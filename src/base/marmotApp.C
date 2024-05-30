#include "marmotApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
marmotApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

marmotApp::marmotApp(InputParameters parameters) : MooseApp(parameters)
{
  marmotApp::registerAll(_factory, _action_factory, _syntax);
}

marmotApp::~marmotApp() {}

void
marmotApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<marmotApp>(f, af, s);
  Registry::registerObjectsTo(f, {"marmotApp"});
  Registry::registerActionsTo(af, {"marmotApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
marmotApp::registerApps()
{
  registerApp(marmotApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
marmotApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  marmotApp::registerAll(f, af, s);
}
extern "C" void
marmotApp__registerApps()
{
  marmotApp::registerApps();
}
