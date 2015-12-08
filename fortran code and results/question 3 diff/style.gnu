set terminal pngcairo transparent enhanced font "arial,10" fontscale 2.0 size 1920, 1080
set output 'result.png'
set title 'Pure diffusive model - Comparison of numerical model and analytical solution for T=10h'
set xlabel 'Distance [m]
set ylabel 'Mass concentration [kg/m-3]
set grid
plot 'result10-analytical.txt' title'Analytical solution' with linespoints lt 2 lc rgb "black" lw 2 ,  \
	 'result10.txt'title'Numerical model' with linespoints lt -1 lc rgb "red" lw 6 dashtype 2 , \


