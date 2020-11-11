reset

std = 'data/power_std_hm.dat'
bnl = 'data/power_bnl_hm.dat'
n = 9

klab = 'k / h Mpc^{-1}'

plab = '{/Symbol D}^2(k)'

rlab = 'P_{Bnl}(k) / P_{std}(k)'

set log x

unset colorbox

set multiplot layout 2, 1 margins 0.08, 0.98, 0.08, 0.98

   set format x ''

   set log y
   set ylabel plab
   set format y '10^{%T}'

   plot for [i=1:n] std u 1:(column(1+i)):(-real(i-1)/(n-1)) w l lw 2 dt 2 lc palette noti,\
      for [i=1:n] bnl u 1:(column(1+i)):(-real(i-1)/(n-1)) w l lw 2 dt 1 lc palette noti

   set xlabel klab
   set format x

   unset log y
   set format y
   set ylabel rlab

   plot for [i=1:n] '<paste '.bnl.' '.std.'' u 1:(column(1+i)/column(2+n+i)):(-real(i-1)/(n-1)) w l lw 2 dt 1 lc palette noti,\

unset multiplot
