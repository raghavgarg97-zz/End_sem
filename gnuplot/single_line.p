set terminal postscript eps enhanced color

set xtics font ",16"
set ytics font ",16"
set xlabel font ",20"
set ylabel font ",25"

set xlabel "num of elements"
set ylabel "Time consumed"



set ytic auto
set xtic auto


#set format x "10^{%L}"
set logscale x 10
set logscale y 10
set key top left

set output "Plot2.eps"
plot 'analyse' every :::0::0 using 1:2 title "Threads 1" w linespoints  lc rgb 'blue',\
 '' every :::0::0 using 1:3 title "Threads 2" w linespoints  lc rgb 'red',\
 '' every :::0::0 using 1:4 title "Threads 4" w linespoints  lc rgb 'green',\
 '' every :::0::0 using 1:5 title "Threads 8" w linespoints  lc rgb 'yellow',\
 '' every :::0::0 using 1:6 title "Threads 16" w linespoints  lc rgb 'magenta'
     
