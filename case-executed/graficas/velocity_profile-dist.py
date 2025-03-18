
# open with gedit or geany (text editor) for syntax highlight
# run using: python3 velocity_profile-dist.py

import numpy as np
import csv

print("Hello world!")

mystring = "Hola"

print(mystring)


# read a file and rewrite it addina a column

#basename = "velocity_profileXY-openfoam_sampling-10x10"
#basename = "velocity_profileXY-openfoam_sampling-20x20"
basename = "velocity_profileXY-openfoam_sampling-40x40"
newname = basename + "-dist"

extname = ".gplt"

basename = basename + extname
newname  = newname + extname


print(basename)
print(newname)

infile = open(basename,"r")
outfile = open(newname,"w")

#outfile.write("#x     y     z    dist   u     v     w\n")

lines = infile.readlines()
outlines = []
#outlines = ["#x     y     z    dist   u     v     w\n"]
outlines = ['# dist   veloc \n']
#print(outlines[0])
#print(list(outlines[0]))

count = 0

dlist = []
vlist = []

# read file
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
      x = float(lineelems[0])
      y = float(lineelems[1])
      veloc = float(lineelems[5])
      #print(x,y,veloc)
      dist = np.sqrt(x*x + y*x)
      #print(dist)
      dlist.append(dist)
      vlist.append(veloc)

infile.close()

nelem = len(dlist)

# minimum Dx = 0.1/80 = 0.00125

# depurado de elementos repetidos
flag = bool(1)
ielem = 1
while (flag):
   distpre = dlist[ielem-1]
   dist  = dlist[ielem]
   if ( abs(dist-distpre) < 1e-4):
      #print("repeated")
      dlist.pop(ielem)
      vlist.pop(ielem)
   else:
      ielem = ielem + 1
   if (ielem >= len(dlist)):
      flag = bool(0)
   #print(dlist)

#exit()

nelem = len(dlist)

#outline = "#  dist      veloc  \n"
#outlines.append(outline)
for ielem in range(0,nelem) :
   dist  = dlist[ielem]
   veloc = vlist[ielem]
   outline = str(dist) + "   " + str(veloc) + "\n"
   #print(outline)
   outlines.append(outline)

outfile.writelines(outlines)

outfile.close()

exit()
