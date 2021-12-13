import sys
import json

def sanitize(solution):
    s = f"{solution}".replace('\n', '<br>')
    return f"<pre>{s}</pre>"

solution = json.load(sys.stdin)
p1 = sanitize(solution['part_one'])
p2 = sanitize(solution['part_two'])
print(f"{p1}|{p2}")
