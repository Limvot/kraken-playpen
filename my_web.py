#!/usr/bin/env python3

from http.server import HTTPServer, SimpleHTTPRequestHandler, test as test_orig
import sys
import json
import subprocess
import random
import os

def execute(data):
    # random file name to prevent data races between different evals
    temp_name = "temp" + str(random.random()) + ".krak"
    with open(temp_name, 'w') as f:
        f.write(data)
    args = ["../kraken/kraken", "-i", temp_name]
    with subprocess.Popen(args,
                           stdin=subprocess.PIPE,
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT) as p:
        out = p.communicate()[0]
        os.remove(temp_name)
        return (out, p.returncode)

def test (*args):
    test_orig(*args, port=int(sys.argv[1]) if len(sys.argv) > 1 else 8001)

class CORSRequestHandler (SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Origin, Accept, Content-Type')
        SimpleHTTPRequestHandler.end_headers(self)

    def do_OPTIONS(self):
        # Send response status code
        self.send_response(200)

        self.end_headers()

    def do_POST(self):

        request_path = self.path

        print("request headers")
        print(self.headers)
        content_length = self.headers.get_all('content-length')
        length = int(content_length[0]) if content_length else 0
        request_data = json.loads(self.rfile.read(length))

        # Send response status code
        self.send_response(200)

        # Send headers
        self.send_header('Content-type','text/html')
        self.end_headers()

        message = execute(request_data['code'])
        print("mesage is")
        print(message)
        self.wfile.write(message[0])
        #self.wfile.write(bytes(message[0], "utf8"))
        
if __name__ == '__main__':
    test(CORSRequestHandler, HTTPServer)
