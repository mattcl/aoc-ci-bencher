import os
import sys
import json

def sanitize(solution):
    if isinstance(solution, str):
        # this is a hack for now
        solution = f"{solution}".replace('.', ' ').replace('#', '0').replace('0', '&#9608;').replace('\n', '<br>')

    return f"<pre>{solution}</pre>"


day = int(os.getenv("DAY"))
solution = json.load(sys.stdin)
p1 = sanitize(solution['part_one'])

if day == 25:
    p2 = sanitize("no part two on day 25")
else:
    p2 = sanitize(solution['part_two'])
print(f"{p1}|{p2}")
