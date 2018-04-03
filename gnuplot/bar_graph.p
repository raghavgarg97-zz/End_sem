#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color size 3.9,2.9

set output "Plot3.eps"

set xtics font ",16"
set ytics font ",16"
set xlabel font ",20"
set ylabel font ",25"

set xlabel "num of elements"
set ylabel "Average speedup wrt 1 thread"

set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border


set ytic auto
set xtic auto


set key top left


plot 'analyse' every :::0::0 u ($2/$2):xticlabels(1) title "Threads 1" fillstyle pattern 7,\
 '' every :::0::0 u ($2/$3):xticlabels(1) title "Threads 2" fillstyle pattern 12,\
 '' every :::0::0 u ($2/$4):xticlabels(1) title "Threads 4" fillstyle pattern 24,\
 '' every :::0::0 u ($2/$5):xticlabels(1) title "Threads 8" fillstyle pattern 10,\
 '' every :::0::0 u ($2/$6):xticlabels(1) title "Threads 16" fillstyle pattern 15,\

     
