import sys
import json

solution = json.load(sys.stdin)
p1 = f"{solution['part_one']}".replace('\n', '<br>')
p2 = f"{solution['part_two']}".replace('\n', '<br>')
print(f"{p1}|{p2}")
