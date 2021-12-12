import sys
import json

solution = json.load(sys.stdin)
print(f"{solution['part_one']}|{solution['part_two']}")
