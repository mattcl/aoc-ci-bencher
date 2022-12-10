import sys
import json

def sanitize(solution):
    if isinstance(solution, str):
        # this is a hack for now
        solution = f"{solution}".replace('.', ' ').replace('#', '0').replace('0', '&#9608;').replace('\n', '<br>')

    return f"<pre>{solution}</pre>"


solution = json.load(sys.stdin)
p1 = sanitize(solution['part_one'])
p2 = sanitize(solution['part_two'])
print(f"{p1}|{p2}")
