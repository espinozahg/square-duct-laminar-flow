#!/usr/bin/gnuplot
# gnuplot script
# gnuplot velocity_profileXY-dist.gp
# works with gnuplot 5.4
# gnuplot --help

set   autoscale                        # scale axes automatically
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
set   xtic      auto                   # set xtics automatically
set   ytic      auto                   # set ytics automatically
set   grid                             # set grid automatically
set   pointsize 2.0
#set   linetype
set   style     line 1 lt 2 lw 2 pt 3 ps 0.5
#set   title     "Energy History" font "arial,30"
#set   xlabel    "$sqrt(x2+y2) dist$"
#set   ylabel    "$Ux$"
set   xlabel    "{/:Italic d}"
set   ylabel    "{/:Italic w}"

set format x "%2.2f"
#set   terminal gif font arial 8 size 683,359 nocrop
#set   output   "velocity_profileXY-dist.gif"
# width of page in uptc format is 155 mm = 6.1 in
# size 400 in gnuplot produces a svg that later converted to png with inkscape using 300 dpi has a size of 4 inches
# 1 inch = 72 point, then 12 point = 0.16666 inches
# font size 12 points gives 8.5 pixels in inkscape and that is 0.085 in, so we need font size 24 to keep up
# using 24 gives too big font
# using 20 gives slightly biggger font
# using 18 gives slightly biggger font than in libreoffice write
# using arial 16 gives exact font size in libreoffice write as liberation sans 12
# size height,width
set   terminal svg size 600,400 enhanced font "arial,16"
set   output   "velocity_profileXY-dist.svg"
unset key
set   key on
# left right center top bottom center
#set   key right top
set   key center bottom
set key title ""
#set   key 0.01,100
#set label "Yield Point" at 0.003,260
#set arrow from 0.0028,250 to 0.003,280
# 0.1*sqrt(2) = 0.1414213562
#set xr [0.0:0.14]
#set xr [0.0:0.142]
set xr [0.0:0.141422]
set yr [0:7]
# pointtype 1 +, 2 x, 3 *, 4 square, 5 square filled, 6 circle, 7 circle filled
# linetype  1 continuous, 2 

# Ux= A*x^2 + B*x + C
# dUx/dx = 2 A x + B
# x=0    Ux=0        -> C = 0
# x=D    Ux=0        -> D D A + D B = 0 -> B = -D A
# x=D/2 dUx/dx = 0  -> D A + B = 0 -> B=-D A   (does not add any info)
# x=0.05 Ux=Umax         D/2 D/2 A + D/2 B = Umax -> D D A + 2 D B = 4 Umax
# D D A + 2 D (-D A) = 4 Umax
# A = - 4 Umax/(D D)
# B = 4 Umax/D
# Uavg = 3.2 m/s (espinoza)
# D = 0.141422 m (espinoza diagonal) 0.1 sqrt(2)
# Umax = 2.1157 Uavg = 6.77024 (natarajan)
# A = -2708.0960; B = 270.8096 (natarajan)
# Umax = 2.0962 Uavg = 6.70784 (shah 1978 and spiga 1944)
# D = 0.14:     A = -1368.9469; B = 191.6525
# D = 0.141422: A = -1341.5557; B = 189.7255

plot 189.7255*x - 1341.5557*x*x                                                title "Parabolic"   with lines dashtype 2 linewidth 1 linecolor rgbcolor "black", \
     "velocity_profileXY-spiga.gplt"                         using 2:3 every 1 title "Analytical"  with lines linetype 1 linewidth 2 linecolor rgbcolor "black", \
     "velocity_profileXY-openfoam_sampling-10x10-dist.gplt"  using 1:2 every 1 title "Mesh10"      with points pointtype 7 pointsize 0.5 linecolor rgbcolor "black", \
     "velocity_profileXY-openfoam_sampling-20x20-dist.gplt"  using 1:2 every 1 title "Mesh20"      with points pointtype 2 pointsize 0.5 linecolor rgbcolor "black", \
     "velocity_profileXY-openfoam_sampling-40x40-dist.gplt"  using 1:2 every 1 title "Mesh40"      with points pointtype 6 pointsize 0.5 linecolor rgbcolor "black"

#plot   "sma.hyw.ele.1"  using 2:3 every 3 title "Sma" with points pointtype 1 pointsize 1.5
# every 2 pointinterval 5
show  key
#plot  "Convergence1.history"    using 1:2 notitle "dummy1" with lines linetype 1 linewidth 2 linecolor rgbcolor "web-green"
#pause -1

exit
