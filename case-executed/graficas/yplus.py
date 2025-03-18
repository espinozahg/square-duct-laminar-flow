
# open with gedit or geany (text editor) for syntax highlight
# run using: python3 yplus.py

import numpy as np
import csv

print("Hello world!")

mystring = "Hola"

print(mystring)


# read a file and rewrite it addina a column

#basename = "yplus-z8-10"
basename = "yplus-z8-20"
#basename = "yplus-z8-40"

#newname = basename + "-dist"

extname = ".xy"

basename = basename + extname
#newname  = newname + extname


print(basename)
#print(newname)

infile = open(basename,"r")
#outfile = open(newname,"w")

#outfile.write("#x     y     z    dist   u     v     w\n")

lines = infile.readlines()
#outlines = []
#outlines = ["#x     y     z    dist   u     v     w\n"]
#outlines = ['# dist   veloc \n']
#print(outlines[0])
#print(list(outlines[0]))

count = 0

xlist = []
ypluslist = []

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
      yplus = float(lineelems[1])
      #print(x,yplus)
      xlist.append(x)
      ypluslist.append(yplus)

infile.close()

#nelem = len(ypluslist)

# minimum Dx = 0.1/80 = 0.00125

# depurado de elementos repetidos
flag = bool(1)
ielem = 1
while (flag):
   xpre = xlist[ielem-1]
   x    = xlist[ielem]
   if ( abs(x-xpre) < 1e-4):
      #print("repeated")
      xlist.pop(ielem)
      ypluslist.pop(ielem)
   else:
      ielem = ielem + 1
   if (ielem >= len(xlist)):
      flag = bool(0)
   #print(dlist)

#exit()

nelem = len(xlist)

#outline = "#  dist      veloc  \n"
#outlines.append(outline)

yplusTotal = 0.0
yplusMax = -10000.0
yplusMin =  10000.0
for ielem in range(0,nelem) :
   #x      = xlist[ielem]
   yplus = ypluslist[ielem]
   yplusTotal += yplus
   if ( yplusMax < yplus):
      yplusMax = yplus
   
   if ( yplusMin > yplus):
      yplusMin = yplus
   #outline = str(dist) + "   " + str(veloc) + "\n"
   #print(outline)
   #outlines.append(outline)

yplusAvg = yplusTotal/float(nelem)

print("yplus Avg")
print(yplusAvg)

print("yplus Min")
print(yplusMin)
print("yplus Max")
print(yplusMax)

#outfile.writelines(outlines)

#outfile.close()

exit()
