import os

f= open("rtl.f","w")
for parent,dirnames,filenames in os.walk('.'):
    dirnames[:] = [d for d in dirnames ]
    filenames[:] = [f for f in filenames if (f.endswith(".v") or f.endswith(".sv") or f.endswith(".vh"))]
    for filename in filenames:
        print(os.path.join(os.path.abspath(parent),filename),file=f)
f.close()
