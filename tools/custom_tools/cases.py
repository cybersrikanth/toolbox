import sys

def permute(inp): 
    n = len(inp) 
    l = []
    # Number of permutations is 2^n 
    mx = 1 << n 
   
    # Converting string to lower case 
    inp = inp.lower() 
      
    # Using all subsequences and permuting them 
    for i in range(mx): 
        # If j-th bit is set, we convert it to upper case 
        combination = [k for k in inp] 
        for j in range(n): 
            if (((i >> j) & 1) == 1): 
                combination[j] = inp[j].upper() 
   
        temp = "" 
        # Printing current combination 
        for i in combination: 
            temp += i 
        l.append(temp)
    return l

if(len(sys.argv)>2 and sys.argv[2]=="--wl"):
    print("\n".join(permute(sys.argv[1])))
else:
    print(" ".join(permute(sys.argv[1])))