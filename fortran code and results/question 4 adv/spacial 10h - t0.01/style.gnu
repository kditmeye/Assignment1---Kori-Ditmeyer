set terminal pngcairo transparent enhanced font "arial,10" fontscale 2.0 size 1920, 1080
set output 'result.png'
set title 'Pure advective model - comparison of mesh discretization impact for T=10h'
set xlabel 'Distance [m]
set ylabel 'Mass concentration [kg/m-3]
set grid
plot 'result10.txt' title'10 Meshes' with linespoints lt 1 lc rgb "black" lw 2,  \
	 'result100.txt'title'100 Meshes' with linespoints lt 2 lc rgb "red" lw 2, \
	 'result1000.txt'title'1000 Meshes' with linespoints lt 3 lc rgb "blue" lw 2,

