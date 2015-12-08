set terminal pngcairo transparent enhanced font "arial,10" fontscale 2.0 size 1920, 1080
set output 'result.png'
set title 'Pure advective model - comparison of temporal discretization impact for T=10h'
set xlabel 'Distance [m]
set ylabel 'Mass concentration [kg/m-3]
set grid
set style line 2 lt 3 lw 3 pt 3 lc rgb "red"
plot 'result0.01.txt' title'dt = 0.01' with linespoints lt 2 lc rgb "black" lw 6 dashtype 4 ,  \
	 'result0.1.txt'title'dt =0.1' with linespoints lt 2 lc rgb "red" lw 2 dashtype 2, \
	 'result1000.txt'title'dt =1000' with linespoints lt 3 lc rgb "blue" lw 2,

