reset

if(!exists('print')) {print=0}
if(print == 0) {set term qt}
if(print == 1) {set term post enh col; set output 'plots/Takada.eps'}

data(nu) = sprintf('results/Takada_nu%1.1f.dat', nu)
lab(nu1, nu2) = sprintf('{/Symbol n}_1 = %1.1f; {/Symbol n}_2 = %1.1f', nu1, nu2)

nnu = 4
array nu[nnu]
nu[1] = 1.0
nu[2] = 1.5
nu[3] = 2.0
nu[4] = 2.5

kmin = 0.
kmax = 0.7
klab = 'k / h Mpc^{-1}'

rmin = 0.85
rmax = 1.15
rlab = 'P_{hh}({/Symbol n}_1, {/Symbol n}_2, k) / [ P_{hh}({/Symbol n}_1, {/Symbol n}_1, k) P_{hh}({/Symbol n}_2, {/Symbol n}_2, k) ]^{1/2}'

set xrange [kmin:kmax]
set xlabel klab

set yrange [rmin:rmax]
set ylabel rlab

set key top left

plot for [inu=1:nnu] data(nu[inu]) u 1:2 w l lw 3 ti lab(1.0, nu[inu])

show output