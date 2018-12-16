/*!
 * \file   bindings/fenics/src/NonLinearMaterialTangentOperatorFunction.cxx
 * \brief    
 * \author Thomas Helfer
 * \date   14/12/2018
 * \copyright (C) Copyright Thomas Helfer 2018.
 * Use, modification and distribution are subject
 * to one of the following licences:
 * - GNU Lesser General Public License (LGPL), Version 3.0. (See accompanying
 *   file LGPL-3.0.txt)
 * - CECILL-C,  Version 1.0 (See accompanying files
 *   CeCILL-C_V1-en.txt and CeCILL-C_V1-fr.txt).
 */

#include "MGIS/Behaviour/MaterialDataManager.hxx"
#include "MGIS/Behaviour/Integrate.hxx"
#include "MGIS/FEniCS/NonLinearMaterial.hxx"
#include "MGIS/FEniCS/NonLinearMaterialTangentOperatorFunction.hxx"

namespace mgis{
  
  namespace fenics {

    void NonLinearMaterialTangentOperatorFunction::restrict(double* const values,
							    const dolfin::FiniteElement&,
							    const dolfin::Cell& c,
							    const double* nc,
							    const ufc::cell&) const{
      this->m.update(c,nc);
      std::copy(this->m.K.begin(),this->m.K.end(), values);
    } // end of NonLinearMaterialTangentOperatorFunction::restrict

    NonLinearMaterialTangentOperatorFunction::~NonLinearMaterialTangentOperatorFunction() = default;
    
  }  // end of namespace fenics

}  // end of namespace mgis
