#!/usr/bin/env python3

import subprocess

def execute(version, command, arguments, data):
    temp_name = "temp.krak"
    with open(temp_name, 'w') as f:
        f.write(data)
    #args = ["./kraken/kraken", "-i", temp_name] + arguments
    args = ["./kraken/kraken", {"evaluate" : "-i", "compile" : "--no-c-compile"}[command], temp_name]
    print(args)
    with subprocess.Popen(args,
                           stdin=subprocess.PIPE,
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT) as p:
        out = p.communicate()[0]
        if command == "evaluate":
            return (out, p.returncode)
        elif command == "compile":
            with open(temp_name + ".c") as f:
                return (f.read(), p.returncode)
