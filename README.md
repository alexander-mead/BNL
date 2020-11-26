# BNL

Example halo model code that includes non-linear halo bias following Mead & Verde (2020; https://arxiv.org/abs/2011.08858).

Clone the repository using
```
git clone --recursive https://github.com/alexander-mead/BNL
```
the ```--recursive``` is important because that will also ensure that necessary libraries are cloned in to the ```library/``` subdirectory. ```BNL``` can then be compiled using ```>make```. If you get an error: ```*** No rule to make target `build/precision.o', needed by `bin/BNL'.``` this is because you did not use the ```-- recursive``` flag above. ```BNL``` should compile with any ```Fortran``` compiler, the default is ```gfortran```, but you can change the compiler within the ```Makefile```. To run the compiled code type ```>./bin/BNL```.

When run, the code should print some useful things to the screen and create data files in the `results/` directory: `power_std_linear.dat`, `power_std_2h.dat`, `power_std_1h.dat`, `power_std_hm.dat`, `power_bnl_linear.dat`, `power_bnl_2h.dat`, `power_bnl_1h.dat`, and `power_bnl_hm.dat`. You should be able to plot these using the `gnuplot` script `plotting/power.p`, which is also included in the repository via `>gnuplot plotting/power.p`.

In the `data/BNL/M512/` directory you will find measurements (in ascii format) of the BNL function from the Multidark simulation that are used in the code and paper. These measurements are in the `*_bnl.dat` files, which are two columns: k and 1+B_NL, k is in units of h/Mpc. The files are 1600 rows, which corresponds to 25 k points for each of the 8x8 mass bins (25 x 8 x 8 = 1600). The mass values corresponding to the 8 mass bins can be found in the `*_binstats.dat` files, which are 8 rows, one row per mass bin. The columns are: log10(m_min), log10(m_max), log10(m), nu_min, nu_max, nu, b and rv. Halo masses 'm' are in Msun/h and virial radius 'rv' is in Mpc/h, everything else is dimensionless, 'b' is the linear halo bias. The quantities without _min or _max denote an average over haloes in the bin, weighted by the number of haloes. The nu value is that associated with the mass bin in the code. In the `*_bnl.dat` files the mass bins are layed out sequentially like: 11, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, ..., 87, 88. There is some redundancy here since BNL is symmetric with respect to mass arguments, so for example 12 contains the same information as 21.

A simple `Fortran` loop to read a `_bnl.dat` file would be:

```
DO jbin = 1, nbin
  DO ibin = 1, nbin
     DO ik = 1, nk
        READ (u, *) k(ik), B(ik, ibin, jbin)
     END DO
  END DO
END DO
```

The different numbers for the `*_binstats.dat` and `*_bnl.dat` correspond to different Multidark snapshots. The redshifts are given in the `MDR1_redshifts.csv` file.

The research to develop this softare was funded by the Horizon 2020 research and innovation programme of the European Union under Marie Sklodowska-Curie grant agreement No. 702971.
