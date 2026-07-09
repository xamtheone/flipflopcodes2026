data = open(0).read().splitlines()

a = 0
p = None
for i in range(len(data) - 1, -1, -1):
    if (data[i] not in ['o-|', '  |-o']):
        continue

    if (p != None and p != data[i]):
        a += 1

    p = data[i]
print(a)