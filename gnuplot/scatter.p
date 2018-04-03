set terminal postscript eps enhanced color

set xtics font ",16"
set ytics font ",16"
set xlabel font ",20"
set ylabel font ",25"

set xlabel "num of elements"
set ylabel "Time consumed"



set ytic auto
set xtic auto


set yrange[1:]
set xrange[1:10000000]

#set format x "10^{%L}"
set logscale x 10
set key top left

set output "Plot1_1.eps"
plot 'analyse' every :::1::1 using 1:2 title "Threads 1" w points  pt 11 ps 1.5
set output "Plot1_2.eps"
 plot 'analyse' every :::2::2 using 1:2 title "Threads 2" w points  pt 12 ps 1.5 
set output "Plot1_3.eps"
 plot 'analyse' every :::3::3 using 1:2 title "Threads 4" w points  pt 13 ps 1.5 
set output "Plot1_4.eps"
 plot 'analyse' every :::4::4 using 1:2 title "Threads 8" w points  pt 14 ps 1.5 
set output "Plot1_5.eps"
 plot 'analyse' every :::5::5 using 1:2 title "Threads 16" w points  pt 15 ps 1.5 
 
