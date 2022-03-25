import sys

memo = sys.argv[1]
result = sys.argv[2]

f = open(memo)
tab_content = f.read()
f.close()
space_content = tab_content.replace(" ", "\t")

f=open(result, 'w')
f.write(space_content)
f.close()