CC=gcc
CFLAGS= -g -I. -lm -lpthread
OBJS= params.txt threads.txt
analyse= processed_1.txt processed_2.txt
 
App:common.h prog.o thread_function.o
	$(CC)  -o App prog.o thread_function.o $(CFLAGS)

prog.o: prog.c common.h
	$(CC)  -c  prog.c -o prog.o $(CFLAGS)

thread_function.o: thread_function.c common.h
	$(CC)  -c  $< -o $@ $(CFLAGS)

runtest: App $(OBJS) script.sh
	bash script.sh $(OBJS) > runtest

analyse: runtest script1.py
	python script1.py

plot: Plot1_1.eps Plot2.eps Plot3.eps Plot4.eps

Plot1_1.eps: analyse scatter.p
	gnuplot scatter.p
Plot2.eps: analyse single_line.p
	gnuplot single_line.p
Plot3.eps: analyse bar_graph.p
	gnuplot bar_graph.p
Plot4.eps: analyse bar_graph2.p
	gnuplot bar_graph2.p

report: report_gen.pdf 


report_gen.pdf: report_gen plot
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make report_gen

.PHONY: clean


clean:
	rm App
	rm *.o
	rm runtest
	rm analyse
	rm *.eps
	rm report_gen.*
	rm *.pdf
	
