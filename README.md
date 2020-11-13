# BNL

Example halo model code that includes non-linear halo bias following Mead & Verde (2020; xxxx.xxxxx).

Clone the repository using
```
git clone --recursive https://github.com/alexander-mead/BNL
```
the ```--recursive``` is important because that will also ensure that necessary libraries are cloned in to the ```library/``` subdirectory. ```BNL``` can then be compiled using ```>make```. If you get an error: ```*** No rule to make target `build/precision.o', needed by `bin/BNL'.``` this is because you did not use the ```-- recursive``` flag above. ```BNL``` should compile with any ```Fortran``` compiler, the default is ```gfortran```, but you can change the compiler within the ```Makefile```. To run the compiled code type ```>./bin/BNL```.

To run the code you also need a `data/` directory. When run, the code should print some useful things to the screen and create data files `data/power_std_linear.dat`, `data/power_std_2h.dat`, `data/power_std_1h.dat`, `data/power_std_hm.dat`, `data/power_bnl_linear.dat`, `data/power_bnl_2h.dat`, `data/power_bnl_1h.dat`, and `data/power_bnl_hm.dat`. You should be able to plot these using the `gnuplot` script `plotting/power.p`, which is also included in the repository. You should be able to make the plot via `>gnuplot plotting/power.p`.
