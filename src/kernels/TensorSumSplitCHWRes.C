#include "TensorSumSplitCHWRes.h"

registerMooseObject("MarmotApp", TensorSumSplitCHWRes);

InputParameters
TensorSumSplitCHWRes::validParams()
{
  InputParameters params = SplitCHWResBase::validParams();
  params.addClassDescription("Split formulation Cahn-Hilliard Kernel for the chemical potential "
                             "Tensor sum from anisotropic mobility input");
  return params;
}

TensorSumSplitCHWRes::TensorSumSplitCHWRes(const InputParameters & parameters) 
  : SplitCHWResBase(parameters),
    _K(getMaterialProperty<RealTensorValue>("K")) 
{
}