set terminal pngcairo transparent enhanced font "arial,10" fontscale 2.0 size 1920, 1080
set output 'result.png'
set title 'Diffusive and Advective model - for T=5 and 10h'
set xlabel 'Distance [m]
set ylabel 'Mass concentration [kg/m-3]
set grid
set style line 2 lt 3 lw 3 pt 3 lc rgb "red"
plot 'result5.txt' title'T=5 hours' with linespoints lt 1 lc rgb "black" lw 2 ,  \
	 'result10.txt'title'T= 10 hours' with linespoints lt 2 lc rgb "red" lw 2 , \


