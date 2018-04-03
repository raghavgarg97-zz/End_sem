set terminal postscript eps enhanced color size 3.9,2.9


set output "Plot4.eps"

set xtics font ",16"
set ytics font ",16"
set xlabel font ",20"
set ylabel font ",25"

set xlabel "num of elements"
set ylabel "Time consumed"

set yrange[0:]
set ytic auto

set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border



set xtics rotate by -45
set style histogram errorbars lw 3
set key top left


plot 'analyse' every :::0::0 u ($2/$2):7:xticlabels(1) title "Threads 1" fillstyle pattern 7,\
 '' every :::0::0 u ($2/$3):8:xticlabels(1) title "Threads 2" fillstyle pattern 12,\
 '' every :::0::0 u ($2/$4):9:xticlabels(1) title "Threads 4" fillstyle pattern 24,\
 '' every :::0::0 u ($2/$5):10:xticlabels(1) title "Threads 8" fillstyle pattern 10,\
 '' every :::0::0 u ($2/$6):11:xticlabels(1) title "Threads 16" fillstyle pattern 15,\

     
