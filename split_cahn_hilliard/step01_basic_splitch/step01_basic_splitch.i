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
    type = SplitCHWRes
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
  [./c]
    type = RandomIC
    variable = c
    min =  0.09
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
    value = -1e-3
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
  [./mat]
    type = GenericConstantMaterial
    prop_names  = 'M kappa_c'
    prop_values = '1.0 0.5'
  [../]
  [./free_energy]
    type = DerivativeParsedMaterial
    property_name = fbulk
    coupled_variables = c
    constant_names = W
    constant_expressions = 2.7
    # expression = W*(1-c)^2*(1+c)^2
    expression = c*log(c)+(1-c)*log(1-c)+W*c*(1-c)
    enable_jit = true
    outputs = exodus
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
  dt = 1
  end_time = 20.0
[]

[Outputs]
  exodus = true
  perf_graph = true
  csv = true
[]

[Problem]
  register_objects_from = 'PhaseFieldApp'
  library_path = '/home/w9g/projects/moose/modules/phase_field/lib'
[]