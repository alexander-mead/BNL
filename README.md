# Halo model

Example halo model code.

To download this repositoy, follow the instructions on `github`, I recommend using `>git clone`.

For this to work also requires a copy of my `Fortran` library, which can be found here: https://github.com/alexander-mead/library

To compile requires a Fortran compiler and one needs to simply run the `Makefile` by typing `>make` in the terminal. You will need to set the `MOD_DIR` variable in the make file to the location where you have downloaded my `Fortran` library source code. Note well that you do not need to have compiled the library, you just need to have the `.f90` files downloaded. For me this is `/Users/Mead/Physics/library/src`, but it will be different for you. The `Makefile` is currently configured to use `gfortran`, but you can change this and it should work with other compilers, although you may need to change some of the compile flags.

Several directrories also need to be present in the base `halo_model` directory for the install to work correctly. You need `bin/`, `build/` and `debug_build/`. Some of these might be already present when you clone the repository, some of them might be created by the `Makefile`, but some of them you may need to create manually.

To run the code you also need to create a `data/` directory. Run the code via `>./bin/halo_model`. It should print some useful things to the screen and create data files `data/power_linear.dat`, `data/power_2h.dat`, `data/power_1h.dat` and `data/power_hm.dat`. You should be able to plot these using the `gnuplot` script `power.p`, which is also included in the repository. You should be able to make the plot via `>gnuplot power.p`.
