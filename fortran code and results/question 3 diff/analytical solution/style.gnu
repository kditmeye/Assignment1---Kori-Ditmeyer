set terminal pngcairo transparent enhanced font "arial,10" fontscale 1.0 size 1920, 1080
set output 'result.png'
set title 'Pure diffusion model analytical solution for T=10h'
set xlabel 'Distance [m]
set ylabel 'Mass concentration [kg/m-3]
set grid
plot 'result.txt' with linespoints ls 6 lc 7
