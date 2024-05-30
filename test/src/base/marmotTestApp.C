//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "marmotTestApp.h"
#include "marmotApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
marmotTestApp::validParams()
{
  InputParameters params = marmotApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

marmotTestApp::marmotTestApp(InputParameters parameters) : MooseApp(parameters)
{
  marmotTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

marmotTestApp::~marmotTestApp() {}

void
marmotTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  marmotApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"marmotTestApp"});
    Registry::registerActionsTo(af, {"marmotTestApp"});
  }
}

void
marmotTestApp::registerApps()
{
  registerApp(marmotApp);
  registerApp(marmotTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
marmotTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  marmotTestApp::registerAll(f, af, s);
}
extern "C" void
marmotTestApp__registerApps()
{
  marmotTestApp::registerApps();
}
