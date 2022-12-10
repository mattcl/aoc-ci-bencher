import os
import sys
import json

solution_file = os.getenv("SOLUTION_FILE")
input_name = os.getenv("INPUT_NAME")

assert solution_file is not None, "Missing SOLUTION_FILE"
assert input_name is not None, "Missing INPUT_NAME"

with open(solution_file, "r") as f:
    data = json.load(f)

if input_name not in data:
    print(f"No solution for {input_name}, skipping check")
else:
    solution = json.load(sys.stdin)

    if 'part_1' in solution:
        solution['part_one'] = solution['part_1']
    elif 'part1' in solution:
        solution['part_one'] = solution['part1']

    if 'part_2' in solution:
        solution['part_two'] = solution['part_2']
    elif 'part2' in solution:
        solution['part_two'] = solution['part2']

    p1 = solution['part_one']
    if isinstance(p1, str):
        p1 = p1.strip()

    p2 = solution['part_two']
    if isinstance(p2, str):
        p2 = p2.strip()

    e1 = data[input_name]['part_one']
    if isinstance(e1, str):
        e1 = e1.strip()

    e2 = data[input_name]['part_two']
    if isinstance(e2, str):
        e2 = e2.strip()


    assert p1 == e1, f"Mismatched solution for part 1 using input {input_name}. Expected `{e1}` but got `{p1}`"
    assert p2 == e2, f"Mismatched solution for part 2 using input {input_name}. Expected `{e2}` but got `{p2}`"

    print("solutions match, OK")
