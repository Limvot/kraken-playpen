#!/usr/bin/env python3

import subprocess
import random
import os

def execute(version, command, arguments, data):
    # random file name to prevent data races between different evals
    temp_name = "temp" + str(random.random()) + ".krak"
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
            pass
        elif command == "compile":
            temp_name_c = temp_name + ".c"
            with open(temp_name_c) as f:
                out = f.read()
            os.remove(temp_name_c)
        os.remove(temp_name)
        return (out, p.returncode)
