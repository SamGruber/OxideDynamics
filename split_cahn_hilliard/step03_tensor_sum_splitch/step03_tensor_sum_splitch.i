[Mesh]
    type = GeneratedMesh
    dim = 2
    nx = 300
    ny = 300
    xmax = 50
    ymax = 50
  []

  [Kernels]
    [./w_dot]
      variable = w
      v = c
      type = CoupledTimeDerivative
    [../]
    [./coupled_res]
      variable = w
      type = TensorSumSplitCHWRes
      mob_name = M
    [../]
    [./coupled_parsed]
      variable = c
      type = SplitCHParsed
      f_name = f_loc
      kappa_name = kappa_c
      w = w
    [../]
  []

  [AuxVariables]
    [./local_energy]
      order = CONSTANT
      family = MONOMIAL
    [../]
  []
  
  [Variables]
    [./c]
      order = FIRST
      family = LAGRANGE
    [../]
    [./w]
      order = FIRST
      family = LAGRANGE
    [../]
  []

  [ICs]
    [./cIC]
      type = RandomIC
      variable = c
      min = 0.09
      max =  0.11
    [../]
  []
  
  [AuxKernels]
    [./local_energy]
      type = TotalFreeEnergy
      variable = local_energy
      f_name = fbulk
      interfacial_vars = c
      kappa_names = kappa_c
      execute_on = timestep_end
    [../]
  []
  
  [BCs]
    [./topc]
      type = NeumannBC
      variable = c
      boundary = top
      value = 0.0
    [../]
  
    [./bottomc]
      type = NeumannBC
      variable = c
      boundary = bottom
      value = 0.0
    [../]
  
    [./leftc]
      type = NeumannBC
      variable = c
      boundary = left
      value = 0.0
    [../]
  
    [./rightc]
      type = NeumannBC
      variable = c
      boundary = right
      value = 0.0
    [../]
  
    [./topw]
      type = NeumannBC
      variable = w
      boundary = top
      value = 0
    [../]
  
    [./bottomw]
      type = NeumannBC
      variable = w
      boundary = bottom
      value = 0.0
    [../]
  
    [./leftw]
      type = NeumannBC
      variable = w
      boundary = left
      value = 0.0
    [../]
  
    [./rightw]
      type = NeumannBC
      variable = w
      boundary = right
      value = 0.0
    [../]
  []
  
  [Materials]
    [./free_energy]
      type = DerivativeParsedMaterial
      property_name = fbulk
      coupled_variables = c
      constant_names = W
      constant_expressions = 2.7
      expression = c*log(c)+(1-c)*log(1-c)+W*c*(1-c)
      enable_jit = true
      outputs = exodus
    [../]
    [./mobility]
      type = AnisotropicSumDiffusionMaterial
      tensor_anisotropic = '0.1 0 0
                            0 1 0
                            0 0 0'
      tensor_isotropic = '0.5 0 0
                          0 0.5 0
                          0 0 0'
      x_min = 0
      x_max = 1
    [../]
  []
  
  [Postprocessors]
    [./integral_c]
      type = ElementIntegralVariablePostprocessor
      variable = c
    [../]
    [./integral_w]
      type = ElementIntegralVariablePostprocessor
      variable = w
    [../]
  []
  
  [Preconditioning]
    [./cw_coupling]
      type = SMP
      full = true
    [../]
  []
  
  [Executioner]
    type = Transient
    solve_type = NEWTON
    scheme = bdf2
  
    petsc_options_iname = '-pc_type -sub_pc_type'
    petsc_options_value = 'asm      lu          '
  
    l_max_its = 30
    l_tol = 1e-4
    nl_max_its = 20
    nl_rel_tol = 1e-9
  
    dt = 2.0
    end_time = 20.0
  []
  
  [Outputs]
    exodus = true
    perf_graph = true
    csv = true
  []
  
  [Problem]
    register_objects_from = 'PhaseFieldApp MarmotApp'
    library_path = '/home/w9g/projects/moose/modules/phase_field/lib ~/projects/marmot/lib'
  []  