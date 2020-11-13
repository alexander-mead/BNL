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
      REAL, ALLOCATABLE :: pow_li(:, :), pow_2h(:, :, :, :), pow_1h(:, :, :, :), pow_hm(:, :, :, :)
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
      LOGICAL, PARAMETER :: verbose = .FALSE.
      CHARACTER(len=256), PARAMETER :: bnl_path = './library/data/'
      INTEGER, PARAMETER :: field(1) = [field_matter]
      INTEGER, PARAMETER :: nf = size(field)

      ! Assigns the cosmological model
      icos = icosmo_default
      CALL assign_init_cosmology(icos, cosm, verbose)

      ALLOCATE(pow_li(nk, na), pow_2h(nf, nf, nk, na), pow_1h(nf, nf, nk, na), pow_hm(nf, nf, nk, na))

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
         hmod%bnl_path = bnl_path ! Important to have this after assign_halomod

         ! Set number of k points and k range (log spaced)
         CALL fill_array_log(kmin, kmax, k, nk)
         CALL fill_array(amin, amax, a, na)

         ! Do the halo model calculation
         !CALL calculate_halomod_full(k, a, pow_li, pow_2h, pow_1h, pow_hm, nk, na, cosm, ihm)
         CALL calculate_HMx_old(field, size(field), k, nk, a, na, pow_li, pow_2h, pow_1h, pow_hm, hmod, cosm, verbose)

         ! Write data file to disk
         CALL write_power_a_multiple(k, a, pow_li, pow_2h(1, 1, :, :), pow_1h(1, 1, :, :), pow_hm(1, 1, :, :), nk, na, base, verbose)

      END DO

   END SUBROUTINE example

END PROGRAM BNL_example
