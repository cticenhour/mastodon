# Test to demonstrate the Seismic Probabilistic Risk Assessment (SPRA)
# infrastructure in MASTODON. This test involves three input files:
#
# 1. master.i - The Master file that bins the hazard curve and scales ground
# motions for each bin for use in probabilistic simulations.
#
# 2. sub.i - The file that obtains the scaled ground motions from master.i and
# transfers these ground motions as inputs to the finite-element model and also
# contains the parameters for probabilistic simulation. This file acts as the
# sub file for master.i and master file for subsub.i.
#
# 3. subsub.i - The file that contains the finite-element model.

[Mesh]
  # dummy mesh
  type = GeneratedMesh
  dim = 3
[]

[Variables]
  # dummy variables
  [./u]
  [../]
[]

[Problem]
  solve = false
  kernel_coverage_check = false
[]

[Distributions]
  [./lognormal_density]
    type = Lognormal
    location = 0 # log(1.0); median = 1.0
    scale = 1.3
  [../]
[]

[Samplers]
  [./monte_carlo]
    # performs monte carlo sampling
    type = MonteCarlo
    num_rows = 2
    distributions = 'lognormal_density'
    execute_on = INITIAL # create random numbers on initial and use them for each timestep
  [../]
[]

[MultiApps]
  [./sub]
    # creates sub files for each monte carlo sample and each scaled ground motion
    # Total number of simulations = number_of_bins * num_gms * n_samples
    type = SamplerTransientMultiApp
    input_files = 'sub_sub.i'
    sampler = monte_carlo
    execute_on = TIMESTEP_BEGIN
  [../]
[]

[Transfers]
  [./sub]
    # transfers monte carlo samples to multiapp
    type = SamplerParameterTransfer
    to_multi_app = sub
    sampler = monte_carlo
    parameters = 'Materials/Elasticity_tensor_1/scale_factor_density'
    to_control = 'stochastic'
    execute_on = INITIAL
    check_multiapp_execute_on = false
  [../]
  [./transfer]
    # transfers scaled ground motions to multiapp
    type = PiecewiseFunctionTransfer
    to_multi_app = sub
    to_function = accel_bottom_x # name of function in subsub.i which uses the scaled ground motions
    from_function = accel_bottom_x # name of the function in sub.i, which receives the scaled ground motions
  [../]
[]

[Functions]
  [./accel_bottom_x]
    # Piecewiselinear function that receiving scaled GMs from master.i. Input here is dummy.
    type = PiecewiseLinear
    x = '32 34'
    y = '0 0'
  [../]
[]

[Executioner]
  type = Transient
[]

[Outputs]
  csv = true
[]
