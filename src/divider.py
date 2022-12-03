import sys, itertools

try:
    file = sys.argv[1]
except:
    print("Pass input file as an argument")
    sys.exit(1)

print("Input File: " + file)

with open(file, 'r') as fin:
    list = fin.read().strip().split('\n')

list = [ int(i) for i in list ]
print("List is: " + str(list))

cnt = len(list)

perms = itertools.permutations(list)
comb_cnt = sum(1 for _ in perms)
print("Possible combinations: " + str(comb_cnt))

for i in itertools.permutations(list):
    #print(i)
    for j in range(0,int(cnt/2)):
        s1 = sum(i[:j])
        s2 = sum(i[j:])
        diff = (s2-s1)
        if diff < 0: diff = (0-diff)
        print("List1: " + str(i[:j]) + " with Sum: " + str(s1) + ", List2: " + str(i[j:]) + " with Sum: " + str(s2) + ", Diff: " + str(diff))

