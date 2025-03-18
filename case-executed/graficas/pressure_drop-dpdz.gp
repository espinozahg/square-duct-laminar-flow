#!/usr/bin/gnuplot
# gnuplot script
# gnuplot pressure_drop-dpdz.gp
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
#set   xlabel    "$z$"
#set   ylabel    "$Delta p/z$"
set   xlabel    "{/:Italic z}"
#set   ylabel    "{/:Symbol D} {/:Italic p/z}"
#set   ylabel    "Δ{/:Italic p}/Δ{/:Italic z}"
set   ylabel    "d{/:Italic P}/d{/:Italic z}"

#set format x "%2.2f"
#set   terminal gif font arial 8 size 683,359 nocrop
#set   output   "pressure_drop-dpdz.gif"
# width of page in uptc format is 155 mm = 6.1 in
# size 400 in gnuplot produces a svg that later converted to png with inkscape using 300 dpi has a size of 4 inches
# using arial 16 gives exact font size in libreoffice write as liberation sans 12"
set   terminal svg size 600,400 enhanced font "arial,16"
set   output   "pressure_drop-dpdz.svg"
unset key
set   key on
# left right center top bottom center
#set   key right top
set   key right bottom
set key title ""
#set   key 0.01,100
#set label "Yield Point" at 0.003,260
#set arrow from 0.0028,250 to 0.003,280
set xr [0:10]
#set yr [0:325]

# pointtype 1 +, 2 x, 3 *, 4 square, 5 square filled, 6 circle, 7 circle filled
# rgbcolor "black" "web-green"
# notitle "dummy1"

# Re = 640
# f = 56.92/Re = 0.0889375 (Cengel 2018)
# V = 3.2 m/s
# pmax = f L/D V^2/2 = 45.536  (kinematic pressure)
# pmax/L = 4.5536
# dpdz = C
# C = pmax/L
# C = 4.5536

plot 4.5536                                                               title "Analytical" with lines linetype 1 linewidth 2 linecolor rgbcolor "black", \
     "pressure_drop-openfoam_sampling-10x10-dpdz.gplt"  using 1:2 every 5 title "Mesh10"     with points pointtype 7 pointsize 0.5 linecolor rgbcolor "black", \
     "pressure_drop-openfoam_sampling-20x20-dpdz.gplt"  using 1:2 every 5 title "Mesh20"     with points pointtype 2 pointsize 0.5 linecolor rgbcolor "black", \
     "pressure_drop-openfoam_sampling-40x40-dpdz.gplt"  using 1:2 every 5 title "Mesh40"     with points pointtype 6 pointsize 0.5 linecolor rgbcolor "black"

#plot   "sma.hyw.ele.1"  using 2:3 every 3 title "Sma" with points pointtype 1 pointsize 1.5
# every 2 pointinterval 5
show  key
#plot  "Convergence1.history"    using 1:2 notitle "dummy1" with lines linetype 1 linewidth 2 linecolor rgbcolor "web-green"
#pause -1

exit
