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
      INTEGER :: icos, ihm
      INTEGER :: i
      CHARACTER(len=256) :: base
      TYPE(halomod) :: hmod
      TYPE(cosmology) :: cosm

      REAL, PARAMETER :: kmin = 1e-2
      REAL, PARAMETER :: kmax = 1e1
      INTEGER, PARAMETER :: nk = 128
      REAL, PARAMETER :: amin = 0.5
      REAL, PARAMETER :: amax = 1.0
      INTEGER, PARAMETER :: na = 9
      INTEGER, PARAMETER :: icosmo_default = 37
      INTEGER, PARAMETER :: ihm_std = 115
      INTEGER, PARAMETER :: ihm_bnl = 114
      CHARACTER(len=256), PARAMETER :: base_std = 'data/power_std'
      CHARACTER(len=256), PARAMETER :: base_bnl = 'data/power_bnl'
      LOGICAL, PARAMETER :: verbose = .TRUE.

      ! Assigns the cosmological model
      icos = icosmo_default
      CALL assign_init_cosmology(icos, cosm, verbose)

      DO i = 1, 2

         ! Set halo model and output file base
         IF (i == 1) THEN
            ihm = ihm_std
            base = base_std
         ELSE IF (i == 2) THEN
            ihm = ihm_bnl
            base = base_bnl
         ELSE
            STOP 'Error, something went terribly wrong'
         END IF

         ! Assign the halo model
         CALL assign_halomod(ihm, hmod, verbose)

         ! Set number of k points and k range (log spaced)
         CALL fill_array_log(kmin, kmax, k, nk)
         CALL fill_array(amin, amax, a, na)

         ! Do the halo model calculation
         CALL calculate_halomod_full(k, a, pow_li, pow_2h, pow_1h, pow_hm, nk, na, cosm, ihm)

         ! Write data file to disk
         CALL write_power_a_multiple(k, a, pow_li, pow_2h, pow_1h, pow_hm, nk, na, base, verbose)

      END DO

   END SUBROUTINE example

END PROGRAM BNL_example
