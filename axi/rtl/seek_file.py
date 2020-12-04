import os

f= open("rtl.f","w")
for parent,dirnames,filenames in os.walk('..'):
    dirnames[:] = [d for d in dirnames if d not in ['sim','xyz_camif_bak']]
    filenames[:] = [f for f in filenames if (f.endswith(".v") or f.endswith(".sv"))]
    for filename in filenames:
        print(os.path.join(parent,filename),file=f)
f.close()
