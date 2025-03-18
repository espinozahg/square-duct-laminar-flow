
# open with gedit (text editor) for syntax highlight
# run using: python3 pressure_drop.py

import numpy as np
import csv

print("Hello world!")

mystring = "Hola"

print(mystring)

# NumPy version
print(np.version.version)
#print(np.__version__)

# read a file and rewrite it addina a column

basename = "pressure_drop-openfoam_sampling-10x10"
#basename = "pressure_drop-openfoam_sampling-20x20"
#basename = "pressure_drop-openfoam_sampling-40x40"
newname = basename + "-dpdz"

extname = ".gplt"

basename = basename + extname
newname  = newname + extname


print(basename)
print(newname)

infile = open(basename,"r")
outfile = open(newname,"w")

#outfile.write("#z    dpdz\n")

lines = infile.readlines()
outlines = []
#outlines = ["#z     dpdz\n"]
outlines = ['#z     dpdz\n']
#print(outlines[0])
#print(list(outlines[0]))

count = 0

zlist = []
plist = []

# first read file
for line in lines :
   #print(line)
   #print(list(line))
   #lineelems = line.split()
   line = line.strip() # remove leading and trailing whitespaces
   line = " ".join(line.split()) # remove duplicate spaces
   #print(line)
   lineelems = line.split(" ")
   #print(lineelems)
   if (lineelems[0] == "#") :
      continue
   else:
      z = float(lineelems[0])
      p = float(lineelems[1])
      zlist.append(z)
      plist.append(p)

infile.close()

#print(zlist)
#print(plist)

nelem = len(zlist)
#print(nelem)

for ielem in range(1,nelem) :
   z0 = zlist[ielem-1]
   z1 = zlist[ielem]
   p0 = plist[ielem-1]
   p1 = plist[ielem]
   #print(z0,z1,p0,p1)
   dpdz = (p0-p1)/(z1-z0)
   #print(dpdz)
   #dist = np.sqrt(x*x + y*x)
   #print(dist)
   
   #lineelems.insert(1,str(dpdz))
   #print(lineelems)
   #outline = 'a b c\n'
   #outline = '    '.join(lineelems)
   outline = str(z1) + "   " + str(dpdz) + "\n"
   #print(outline)
   outlines.append(outline)
   #outfile.write("%f   %f    %f\n" % (1.0, 2.0 , 3.0) )

outfile.writelines(outlines)

outfile.close()

exit()

