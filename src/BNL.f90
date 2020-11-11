PROGRAM BNL_example

   USE array_operations
   USE cosmology_functions
   USE HMx

   IMPLICIT NONE

   CALL example()

CONTAINS

   SUBROUTINE example()

      IMPLICIT NONE
      REAL, ALLOCATABLE :: k(:), a(:)
      REAL, ALLOCATABLE :: pow_li(:, :), pow_2h(:, :), pow_1h(:, :), pow_hm(:, :)
      INTEGER :: icosmo, ihm
      CHARACTER(len=256) :: base
      TYPE(halomod) :: hmod
      TYPE(cosmology) :: cosm

      REAL, PARAMETER :: kmin = 1e-3
      REAL, PARAMETER :: kmax = 1e2
      INTEGER, PARAMETER :: nk = 128
      REAL, PARAMETER :: amin = 0.1
      REAL, PARAMETER :: amax = 1.0
      INTEGER, PARAMETER :: na = 16
      INTEGER, PARAMETER :: icosmo_default =  1
      INTEGER, PARAMETER :: ihm_default = 3
      LOGICAL, PARAMETER :: verbose = .TRUE.

      ! Assigns the cosmological model
      icosmo = icosmo_default
      CALL assign_cosmology(icosmo, cosm, verbose)
      CALL init_cosmology(cosm)
      CALL print_cosmology(cosm)

      ! Assign the halo model
      ihm = ihm_default
      CALL assign_halomod(ihm, hmod, verbose)

      ! Set number of k points and k range (log spaced)
      CALL fill_array_log(kmin, kmax, k, nk)
      CALL fill_array(amin, amax, a, na)

      ! Do the halo model calculation
      CALL calculate_halomod_full(k, a, pow_li, pow_2h, pow_1h, pow_hm, nk, na, cosm, ihm)

      ! Write data file to disk
      base = 'data/power'
      CALL write_power_a_multiple(k, a, pow_li, pow_2h, pow_1h, pow_hm, nk, na, base, verbose)

   END SUBROUTINE example

END PROGRAM BNL_example
