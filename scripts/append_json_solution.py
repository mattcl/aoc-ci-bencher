import os
import sys
import json

day = int(os.getenv("DAY"))
out = os.getenv("OUTPUT_FILE")
input_name = os.getenv("INPUT_NAME")

assert out is not None, "Missing OUTPUT_FILE"
assert input_name is not None, "Missing INPUT_NAME"

with open(out, "r") as f:
    data = json.load(f)

solution = json.load(sys.stdin)
# we do this to ensure that we write only the format we want to the output file
p1 = solution['part_one']

if day == 25:
    p2 = "no part two on day 25"
else:
    p2 = solution['part_two']

data[input_name] = {'part_one': p1, 'part_two': p2}

with open(out, "w") as f:
    json.dump(data, f)
