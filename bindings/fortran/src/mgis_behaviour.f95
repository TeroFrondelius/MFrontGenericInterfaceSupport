module mgis_behaviour
  use, intrinsic :: iso_c_binding, only: c_ptr, c_null_ptr
  enum, bind(C)
     enumerator :: SCALAR  = 0
     enumerator :: VECTOR  = 1
     enumerator :: STENSOR = 2
     enumerator :: TENSOR  = 3
  end enum
  enum, bind(C)
     enumerator :: ISOTROPIC   = 0
     enumerator :: ORTHOTROPIC = 1
  end enum
  enum, bind(C)
     enumerator :: GENERALBEHAVIOUR = 0
     enumerator :: STANDARDSTRAINBASEDBEHAVIOUR = 1
     enumerator :: STANDARDFINITESTRAINBEHAVIOUR = 2
     enumerator :: COHESIVEZONEMODEL = 3
  end enum
  enum, bind(C)
     enumerator :: UNDEFINEDKINEMATIC = 0
     enumerator :: SMALLSTRAINKINEMATIC = 1
     enumerator :: COHESIVEZONEKINEMATIC = 2
     enumerator :: FINITESTRAINKINEMATIC_F_CAUCHY = 3
     enumerator :: FINITESTRAINKINEMATIC_ETO_PK1 = 4
  end enum
  type :: Behaviour
    private
    type(c_ptr) :: ptr = c_null_ptr
  end type Behaviour
  type :: BehaviourData
    private
    type(c_ptr) :: ptr = c_null_ptr
  end type BehaviourData
  type :: State
    private
    type(c_ptr) :: ptr = c_null_ptr
  end type State
  type :: MaterialStateManager
    private
    type(c_ptr) :: ptr = c_null_ptr
  end type MaterialStateManager
  type :: MaterialDataManager
    private
    type(c_ptr) :: ptr = c_null_ptr
  end type MaterialDataManager
contains
  function load_behaviour(b,l,bn,h) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function load_behaviour_wrapper(ptr,l,b,h) bind(c,name = 'mgis_bv_load_behaviour') result(r)
         use, intrinsic :: iso_c_binding, only: c_char, c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: ptr
         character(len=1,kind=c_char), dimension(*), intent(in) :: l
         character(len=1,kind=c_char), dimension(*), intent(in) :: b
         character(len=1,kind=c_char), dimension(*), intent(in) :: h
         type(mgis_status) :: r
       end function load_behaviour_wrapper
    end interface
    type(behaviour), intent(out) :: b
    character(len=*), intent(in) :: l
    character(len=*), intent(in) :: bn
    character(len=*), intent(in) :: h
    type(mgis_status) :: s
    s = load_behaviour_wrapper(b%ptr, convert_fortran_string(l), &
         convert_fortran_string(bn), &
         convert_fortran_string(h))
  end function load_behaviour
  ! behaviour_get_library
  function behaviour_get_library(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_library_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_library') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_library_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_library_wrapper(lp,b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_library
  ! behaviour_get_behaviour_name
  function behaviour_get_behaviour_name(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_behaviour_name_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_behaviour_name') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_behaviour_name_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_behaviour_name_wrapper(lp, b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_behaviour_name
  ! behaviour_get_function_name
  function behaviour_get_function_name(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_function_name_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_function_name') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_function_name_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_function_name_wrapper(lp, b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_function_name
  ! behaviour_get_source
  function behaviour_get_source(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_source_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_source') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_source_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_source_wrapper(lp, b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_source
  ! behaviour_get_hypothesis
  function behaviour_get_hypothesis(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_hypothesis_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_hypothesis') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_hypothesis_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_hypothesis_wrapper(lp, b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_hypothesis
  ! behaviour_get_tfel_version
  function behaviour_get_tfel_version(l,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_tfel_version_wrapper(l,b) bind(c,name = 'mgis_bv_behaviour_get_tfel_version') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_tfel_version_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    type(c_ptr) :: lp
    s = behaviour_get_tfel_version_wrapper(lp, b%ptr)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_tfel_version
  !
  function behaviour_get_number_of_material_properties(n,b) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_get_number_of_material_properties_wrapper(l,b) &
            bind(c,name = 'mgis_bv_behaviour_get_number_of_material_properties') result(r)
         use, intrinsic :: iso_c_binding, only: c_size_t, c_ptr
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_size_t), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_number_of_material_properties_wrapper
    end interface
    integer :: n
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    integer(kind=c_size_t) :: ns
    s = behaviour_get_number_of_material_properties_wrapper(ns, b%ptr)
    n = ns
  end function behaviour_get_number_of_material_properties
  !
  function behaviour_get_material_property_name(l, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_material_property_name_wrapper(l, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_material_property_name') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_material_property_name_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    type(c_ptr) :: lp
    integer(kind = c_size_t) :: nc
    if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_material_property_name_wrapper(lp, b%ptr, nc)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_material_property_name
  !
  function behaviour_get_material_property_type(t, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function behaviour_get_material_property_type_wrapper(t, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_material_property_type') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         integer t
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_material_property_type_wrapper
    end interface
    integer, intent (out) :: t
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    integer(kind = c_size_t) :: nc
    if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_material_property_type_wrapper(t, b%ptr, nc)
  end function behaviour_get_material_property_type
  !
  function behaviour_get_number_of_internal_state_variables(n,b) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_get_number_of_internal_state_variables_wrapper(l,b) &
            bind(c,name = 'mgis_bv_behaviour_get_number_of_internal_state_variables') result(r)
         use, intrinsic :: iso_c_binding, only: c_size_t, c_ptr
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_size_t), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_number_of_internal_state_variables_wrapper
    end interface
    integer :: n
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    integer(kind=c_size_t) :: ns
    s = behaviour_get_number_of_internal_state_variables_wrapper(ns, b%ptr)
    n = ns
  end function behaviour_get_number_of_internal_state_variables
  !
  function behaviour_get_internal_state_variable_name(l, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_internal_state_variable_name_wrapper(l, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_internal_state_variable_name') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_internal_state_variable_name_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    type(c_ptr) :: lp
    integer(kind = c_size_t) :: nc
    if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_internal_state_variable_name_wrapper(lp, b%ptr, nc)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_internal_state_variable_name
  !
  function behaviour_get_internal_state_variable_type(t, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function behaviour_get_internal_state_variable_type_wrapper(t, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_internal_state_variable_type') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         integer t
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_internal_state_variable_type_wrapper
    end interface
    integer, intent (out) :: t
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    integer(kind = c_size_t) :: nc
        if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_internal_state_variable_type_wrapper(t, b%ptr, nc)
  end function behaviour_get_internal_state_variable_type
  !
  function behaviour_get_internal_state_variable_offset(o, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function behaviour_get_internal_state_variable_offset_wrapper(o, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_internal_state_variable_offset') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t, c_char
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_size_t), intent(out) :: o
         type(c_ptr), intent(in), value :: b
         character(len=1,kind=c_char), dimension(*), intent(in) :: n
         type(mgis_status) :: r
       end function behaviour_get_internal_state_variable_offset_wrapper
    end interface
    integer, intent (out) :: o
    type(behaviour), intent(in) :: b
    character(len=*), intent(in) :: n
    type(mgis_status) :: s
    integer(kind=c_size_t) offset
    s = behaviour_get_internal_state_variable_offset_wrapper( &
         offset, b%ptr, convert_fortran_string(n))
    o = offset+1
  end function behaviour_get_internal_state_variable_offset
  !
  function behaviour_get_number_of_external_state_variables(n,b) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_get_number_of_external_state_variables_wrapper(l,b) &
            bind(c,name = 'mgis_bv_behaviour_get_number_of_external_state_variables') result(r)
         use, intrinsic :: iso_c_binding, only: c_size_t, c_ptr
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_size_t), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function behaviour_get_number_of_external_state_variables_wrapper
    end interface
    integer :: n
    type(behaviour), intent(in) :: b
    type(mgis_status) :: s
    integer(kind=c_size_t) :: ns
    s = behaviour_get_number_of_external_state_variables_wrapper(ns, b%ptr)
    n = ns
  end function behaviour_get_number_of_external_state_variables
  !
  function behaviour_get_external_state_variable_name(l, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure, MGIS_SUCCESS
    implicit none
    interface
       function behaviour_get_external_state_variable_name_wrapper(l, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_external_state_variable_name') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: l
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_external_state_variable_name_wrapper
    end interface
    character(len=:), allocatable, intent(out) :: l
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    type(c_ptr) :: lp
    integer(kind = c_size_t) :: nc
    if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_external_state_variable_name_wrapper(lp, b%ptr, nc)
    if (s % exit_status == MGIS_SUCCESS) then
       l = convert_c_string(lp)
    else
       l = get_empty_string();
    end if
  end function behaviour_get_external_state_variable_name
  !
  function behaviour_get_external_state_variable_type(t, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function behaviour_get_external_state_variable_type_wrapper(t, b, n) &
            bind(c,name = 'mgis_bv_behaviour_get_external_state_variable_type') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         integer t
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function behaviour_get_external_state_variable_type_wrapper
    end interface
    integer, intent (out) :: t
    type(behaviour), intent(in) :: b
    integer, intent (in) :: n
    type(mgis_status) :: s
    integer(kind = c_size_t) :: nc
    if(.not. convert_to_c_index(nc, n)) then
       s = report_failure("invalid index")
       return
    end if
    s = behaviour_get_external_state_variable_type_wrapper(t, b%ptr, nc)
  end function behaviour_get_external_state_variable_type
  ! free behaviour
  function free_behaviour(ptr) result(r)
    use, intrinsic :: iso_c_binding, only: c_associated
    use mgis
    implicit none
    interface
       function free_behaviour_wrapper(ptr) bind(c, name='mgis_bv_free_behaviour') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(inout) :: ptr
         type(mgis_status) :: r
       end function free_behaviour_wrapper
    end interface
    type(Behaviour), intent(inout) :: ptr
    type(mgis_status) :: r
    if (c_associated(ptr%ptr)) then
       r = free_behaviour_wrapper(ptr%ptr)
    end if
  end function free_behaviour
  !
  function allocate_behaviour_data(d,b) result(s)
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function allocate_behaviour_data_wrapper(d,b) bind(c,name = 'mgis_bv_allocate_behaviour_data') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: d
         type(c_ptr), intent(in), value :: b
         type(mgis_status) :: r
       end function allocate_behaviour_data_wrapper
    end interface
    type(BehaviourData), intent(out) :: d
    type(Behaviour), intent(in) :: b
    type(mgis_status) :: s
    s = allocate_behaviour_data_wrapper(d%ptr, b%ptr)
  end function allocate_behaviour_data
  !
  function behaviour_data_get_state_0(s0,d) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_data_get_state_0_wrapper(s0, d) &
            bind(c,name = 'mgis_bv_behaviour_data_get_state_0') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: s0
         type(c_ptr), intent(in), value :: d
         type(mgis_status) :: r
       end function behaviour_data_get_state_0_wrapper
    end interface
    type(State), intent(out) :: s0
    type(BehaviourData), intent(in) :: d
    type(mgis_status) :: s
    s = behaviour_data_get_state_0_wrapper(s0%ptr, d%ptr)
  end function behaviour_data_get_state_0
  !
  function behaviour_data_get_state_1(s1,d) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_data_get_state_1_wrapper(s1, d) &
            bind(c,name = 'mgis_bv_behaviour_data_get_state_1') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: s1
         type(c_ptr), intent(in), value :: d
         type(mgis_status) :: r
       end function behaviour_data_get_state_1_wrapper
    end interface
    type(State), intent(out) :: s1
    type(BehaviourData), intent(in) :: d
    type(mgis_status) :: s
    s = behaviour_data_get_state_1_wrapper(s1%ptr, d%ptr)
  end function behaviour_data_get_state_1
  !
  function behaviour_data_set_time_increment(d, dt) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function behaviour_data_set_time_increment_wrapper(d, v) &
            bind(c,name = 'mgis_bv_behaviour_data_set_time_increment') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_double
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(in), value :: d
         real(kind=c_double), intent(in), value :: v
         type(mgis_status) :: r
       end function behaviour_data_set_time_increment_wrapper
    end interface
    type(BehaviourData), intent(in) :: d
    real(kind = 8) :: dt
    type(mgis_status) :: s
    s = behaviour_data_set_time_increment_wrapper(d%ptr, dt)
  end function behaviour_data_set_time_increment
  !
  function update_behaviour_data(d) result(r)
    use mgis
    implicit none
    interface
       function update_behaviour_data_wrapper(ptr) &
            bind(c, name='mgis_bv_update_behaviour_data') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(in), value :: ptr
         type(mgis_status) :: r
       end function update_behaviour_data_wrapper
    end interface
    type(BehaviourData), intent(in) :: d
    type(mgis_status) :: r
    r = update_behaviour_data_wrapper(d%ptr)
  end function update_behaviour_data
  !
  function revert_behaviour_data(d) result(r)
    use mgis
    implicit none
    interface
       function revert_behaviour_data_wrapper(ptr) &
            bind(c, name='mgis_bv_revert_behaviour_data') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(in), value :: ptr
         type(mgis_status) :: r
       end function revert_behaviour_data_wrapper
    end interface
    type(BehaviourData), intent(in) :: d
    type(mgis_status) :: r
    r = revert_behaviour_data_wrapper(d%ptr)
  end function revert_behaviour_data
  !
  function free_behaviour_data(ptr) result(r)
    use, intrinsic :: iso_c_binding, only: c_associated
    use mgis
    implicit none
    interface
       function free_behaviour_data_wrapper(ptr) bind(c, name='mgis_bv_free_behaviour_data') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(inout) :: ptr
         type(mgis_status) :: r
       end function free_behaviour_data_wrapper
    end interface
    type(BehaviourData), intent(inout) :: ptr
    type(mgis_status) :: r
    if (c_associated(ptr%ptr)) then
       r = free_behaviour_data_wrapper(ptr%ptr)
    end if
  end function free_behaviour_data
  !
  function state_set_gradient_by_name(s, n, v) result(r)
    use, intrinsic :: iso_c_binding, only: c_loc
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function state_set_gradient_by_name_wrapper(s, n, v) &
            bind(c,name = 'mgis_bv_state_set_gradient_by_name') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_double, c_char
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(in),value :: s
         character(len=1,kind=c_char), dimension(*), intent(in) :: n
         type(c_ptr), intent(in),value :: v
         type(mgis_status) :: r
       end function state_set_gradient_by_name_wrapper
    end interface
    type(State), intent(in) :: s
    character(len=*), intent(in) :: n
    real(kind=8), dimension(*), target :: v
    type(mgis_status) :: r
    r = state_set_gradient_by_name_wrapper( &
         s%ptr, convert_fortran_string(n), c_loc(v(1)))
  end function state_set_gradient_by_name
  ! \note the C function returns a pointer to the variable, the
  !       fortran funtion returns the value
  function state_get_internal_state_variable_by_offset(v, s, o) result(r)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer, c_size_t
    use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure, MGIS_SUCCESS
    implicit none
    interface
       function state_get_internal_state_variable_by_offset_wrapper(v, s1, o) &
            bind(c,name = 'mgis_bv_state_get_internal_state_variable_by_offset') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: v
         type(c_ptr), intent(in),value :: s1
         integer(kind=c_size_t), intent(in), value :: o
         type(mgis_status) :: r
       end function state_get_internal_state_variable_by_offset_wrapper
    end interface
    real(kind=8), intent(out) :: v
    type(State), intent(in) :: s
    integer, intent(in) :: o
    type(mgis_status) :: r
    real(kind=8), pointer :: fptr => null()
    type(c_ptr) :: p
    integer(kind=c_size_t) offset
    if(.not. convert_to_c_index(offset, o)) then
       r = report_failure("invalid index")
       return
    end if
    r = state_get_internal_state_variable_by_offset_wrapper(&
         p, s%ptr, offset)
    if (r % exit_status == MGIS_SUCCESS) then
       call c_f_pointer(p,fptr)
       v = fptr
    else
       v = ieee_value(v, ieee_quiet_nan)
    endif
  end function state_get_internal_state_variable_by_offset
  !
  function state_set_external_state_variable_by_name(s, n, v) result(r)
    use mgis_fortran_utilities
    use mgis, only: mgis_status
    implicit none
    interface
       function state_set_external_state_variable_by_name_wrapper(s1, n, v) &
            bind(c,name = 'mgis_bv_state_set_external_state_variable_by_name') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_double, c_char
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(in),value :: s1
         character(len=1,kind=c_char), dimension(*), intent(in) :: n
         real(kind=c_double), intent(in), value :: v
         type(mgis_status) :: r
       end function state_set_external_state_variable_by_name_wrapper
    end interface
    type(State), intent(in) :: s
    character(len=*), intent(in) :: n
    real(kind=8), intent(in) :: v
    type(mgis_status) :: r
    r = state_set_external_state_variable_by_name_wrapper(&
         s%ptr, convert_fortran_string(n), v)
  end function state_set_external_state_variable_by_name
  ! \note the C function returns a pointer to the variable, the
  !       fortran funtion returns the value
  function state_get_external_state_variable_by_name(v, s, n) result(r)
    use, intrinsic :: iso_c_binding, only: c_ptr, c_f_pointer
    use, intrinsic :: ieee_arithmetic, only: ieee_value, ieee_quiet_nan
    use mgis_fortran_utilities
    use mgis, only: mgis_status, MGIS_SUCCESS
    implicit none
    interface
       function state_get_external_state_variable_by_name_wrapper(v, s1, n) &
            bind(c,name = 'mgis_bv_state_get_external_state_variable_by_name') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_double, c_char
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: v
         type(c_ptr), intent(in),value :: s1
         character(len=1,kind=c_char), dimension(*), intent(in) :: n
         type(mgis_status) :: r
       end function state_get_external_state_variable_by_name_wrapper
    end interface
    real(kind=8), intent(out) :: v
    type(State), intent(in) :: s
    character(len=*), intent(in) :: n
    type(mgis_status) :: r
    real(kind=8), pointer :: fptr => null()
    type(c_ptr) :: p
    r = state_get_external_state_variable_by_name_wrapper(&
         p, s%ptr, convert_fortran_string(n))
    if (r % exit_status == MGIS_SUCCESS) then
       call c_f_pointer(p,fptr)
       v = fptr
    else
       v = ieee_value(v, ieee_quiet_nan)
    endif
  end function state_get_external_state_variable_by_name
  !
  function create_material_data_manager(d, b, n) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function create_material_data_manager_wrapper(d, b, n) &
            bind(c,name = 'mgis_bv_create_material_data_manager') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: d
         type(c_ptr), intent(in), value :: b
         integer(kind=c_size_t), intent(in), value :: n
         type(mgis_status) :: r
       end function create_material_data_manager_wrapper
    end interface
    type(MaterialDataManager), intent(out) :: d
    type(Behaviour), intent(in) :: b
    integer, intent(in) :: n
    type(mgis_status) :: s
    integer(kind=c_size_t) nc
    if (n.lt.1) then
       s = report_failure('invalid number of integration points')
       return
    end if
    nc = n
    s = create_material_data_manager_wrapper(d%ptr, b%ptr, nc)
  end function create_material_data_manager
  !
  function material_data_manager_get_state_0(s0,d) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function material_data_manager_get_state_0_wrapper(s0, d) &
            bind(c,name = 'mgis_bv_material_data_manager_get_state_0') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: s0
         type(c_ptr), intent(in), value :: d
         type(mgis_status) :: r
       end function material_data_manager_get_state_0_wrapper
    end interface
    type(MaterialStateManager), intent(out) :: s0
    type(MaterialDataManager), intent(in) :: d
    type(mgis_status) :: s
    s = material_data_manager_get_state_0_wrapper(s0%ptr, d%ptr)
  end function material_data_manager_get_state_0
  !
  function material_data_manager_get_state_1(s1,d) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function material_data_manager_get_state_1_wrapper(s1, d) &
            bind(c,name = 'mgis_bv_material_data_manager_get_state_1') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(out) :: s1
         type(c_ptr), intent(in), value :: d
         type(mgis_status) :: r
       end function material_data_manager_get_state_1_wrapper
    end interface
    type(MaterialStateManager), intent(out) :: s1
    type(MaterialDataManager), intent(in) :: d
    type(mgis_status) :: s
    s = material_data_manager_get_state_1_wrapper(s1%ptr, d%ptr)
  end function material_data_manager_get_state_1
  !
  function material_state_manager_get_number_of_integration_points(n, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_get_number_of_integration_points_wrapper(nig, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_number_of_integration_points') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         integer(kind=c_size_t), intent(out) :: nig
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function msm_get_number_of_integration_points_wrapper
    end interface
    integer, intent(out) :: n
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    integer(kind=c_size_t) nig
    r = msm_get_number_of_integration_points_wrapper(nig, s %ptr)
    if( r%exit_status .eq. MGIS_SUCCESS) then
       n = nig
    else
       n = -1
    end if
  end function material_state_manager_get_number_of_integration_points
  !
  function material_state_manager_get_gradients_stride(g_stride, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function material_state_manager_get_gradients_stride_wrapper(gs, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_gradients_stride') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         integer(kind=c_size_t), intent(out) :: gs
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function material_state_manager_get_gradients_stride_wrapper
    end interface
    integer, intent(out) :: g_stride
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    integer(kind=c_size_t) gs
    r = material_state_manager_get_gradients_stride_wrapper(gs, s %ptr)
    if( r%exit_status .eq. MGIS_SUCCESS) then
       g_stride = gs
    else
       g_stride = -1
    end if
  end function material_state_manager_get_gradients_stride
  !
  function material_state_manager_get_gradients(g, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t, c_f_pointer
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function material_state_manager_get_gradients_wrapper(g_ptr, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_gradients') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         type(c_ptr), intent(out) :: g_ptr
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function material_state_manager_get_gradients_wrapper
    end interface
    real(kind=8), dimension(:,:), pointer, intent(out) :: g
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    type(c_ptr) g_ptr
    integer gs
    integer n
    nullify(g)
    r = material_state_manager_get_gradients_wrapper(g_ptr, s %ptr)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_gradients_stride(gs, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_number_of_integration_points(n, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    call c_f_pointer(g_ptr, g, [gs, n])
  end function material_state_manager_get_gradients
  !
  function material_state_manager_get_thermodynamic_forces_stride(tf_stride, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_get_thermodynamic_forces_stride_wrapper(tfs, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_thermodynamic_forces_stride') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         integer(kind=c_size_t), intent(out) :: tfs
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function msm_get_thermodynamic_forces_stride_wrapper
    end interface
    integer, intent(out) :: tf_stride
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    integer(kind=c_size_t) tfs
    r = msm_get_thermodynamic_forces_stride_wrapper(tfs, s %ptr)
    if( r%exit_status .eq. MGIS_SUCCESS) then
       tf_stride = tfs
    else
       tf_stride = -1
    end if
  end function material_state_manager_get_thermodynamic_forces_stride
  !
  function material_state_manager_get_thermodynamic_forces(tf, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t, c_f_pointer
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_get_thermodynamic_forces_wrapper(tf_ptr, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_thermodynamic_forces') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         type(c_ptr), intent(out) :: tf_ptr
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function msm_get_thermodynamic_forces_wrapper
    end interface
    real(kind=8), dimension(:,:), pointer, intent(out) :: tf
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    type(c_ptr) tf_ptr
    integer tfs
    integer n
    nullify(tf)
    r = msm_get_thermodynamic_forces_wrapper(tf_ptr, s %ptr)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_thermodynamic_forces_stride(tfs, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_number_of_integration_points(n, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    call c_f_pointer(tf_ptr, tf, [tfs, n])
  end function material_state_manager_get_thermodynamic_forces
  !
  function material_state_manager_get_internal_state_variables_stride(n_isvs, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_get_internal_state_variables_stride_wrapper(nc_isvs, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_internal_state_variables_stride') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         integer(kind=c_size_t), intent(out) :: nc_isvs
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function msm_get_internal_state_variables_stride_wrapper
    end interface
    integer, intent(out) :: n_isvs
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    integer(kind=c_size_t) nc_isvs
    r = msm_get_internal_state_variables_stride_wrapper(nc_isvs, s %ptr)
    if( r%exit_status .eq. MGIS_SUCCESS) then
       n_isvs = nc_isvs
    else
       n_isvs = -1
    end if
  end function material_state_manager_get_internal_state_variables_stride
  !
  function material_state_manager_get_internal_state_variables(isvs, s) &
       result(r)
    use, intrinsic :: iso_c_binding, only: c_size_t, c_f_pointer
    use mgis, only: mgis_status, MGIS_SUCCESS
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_get_internal_state_variables_wrapper(isvs_ptr, s) &
            bind(c,name = 'mgis_bv_material_state_manager_get_internal_state_variables') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
         use mgis, only: mgis_status
         type(c_ptr), intent(out) :: isvs_ptr
         type(c_ptr), intent(in),value :: s
         type(mgis_status) :: r
       end function msm_get_internal_state_variables_wrapper
    end interface
    real(kind=8), dimension(:,:), pointer, intent(out) :: isvs
    type(MaterialStateManager), intent(in) :: s
    type(mgis_status) :: r
    type(c_ptr) isvs_ptr
    integer n_isvs
    integer n
    nullify(isvs)
    r = msm_get_internal_state_variables_wrapper(isvs_ptr, s %ptr)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_internal_state_variables_stride(n_isvs, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    r = material_state_manager_get_number_of_integration_points(n, s)
    if( r%exit_status .ne. MGIS_SUCCESS) then
       return
    end if
    call c_f_pointer(isvs_ptr, isvs, [n_isvs, n])
  end function material_state_manager_get_internal_state_variables
  !
  function material_state_manager_set_uniform_external_state_variable(s, n, v) &
       result(r)
    use mgis, only: mgis_status
    use mgis_fortran_utilities
    implicit none
    interface
       function msm_set_uniform_external_state_variable_wrapper(s, n, v) &
            bind(c,name = 'mgis_bv_material_state_manager_set_uniform_external_state_variable') &
            result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_double, c_char
         use mgis, only: mgis_status
         implicit none
         type(c_ptr), intent(in),value :: s
         character(len=1,kind=c_char), dimension(*), intent(in) :: n
         real(kind=c_double), intent(in), value :: v
         type(mgis_status) :: r
       end function msm_set_uniform_external_state_variable_wrapper
    end interface
    type(MaterialStateManager), intent(in) :: s
    character(len=*), intent(in) :: n
    real(kind=8),     intent(in) :: v
    type(mgis_status) :: r
    r = msm_set_uniform_external_state_variable_wrapper(s %ptr, &
         convert_fortran_string(n), v)
  end function material_state_manager_set_uniform_external_state_variable
  !
  function free_material_data_manager(ptr) result(r)
    use, intrinsic :: iso_c_binding, only: c_associated
    use mgis
    implicit none
    interface
       function free_material_data_manager_wrapper(ptr) &
            bind(c, name='mgis_bv_free_material_data_manager') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(inout) :: ptr
         type(mgis_status) :: r
       end function free_material_data_manager_wrapper
    end interface
    type(MaterialDataManager), intent(inout) :: ptr
    type(mgis_status) :: r
    if (c_associated(ptr%ptr)) then
       r = free_material_data_manager_wrapper(ptr%ptr)
    end if
  end function free_material_data_manager
  !
  function update_material_data_manager(d) result(r)
    use mgis
    implicit none
    interface
       function update_material_data_manager_wrapper(ptr) &
            bind(c, name='mgis_bv_update_material_data_manager') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(in), value :: ptr
         type(mgis_status) :: r
       end function update_material_data_manager_wrapper
    end interface
    type(MaterialDataManager), intent(in) :: d
    type(mgis_status) :: r
    r = update_material_data_manager_wrapper(d%ptr)
  end function update_material_data_manager
  !
  function revert_material_data_manager(d) result(r)
    use mgis
    implicit none
    interface
       function revert_material_data_manager_wrapper(ptr) &
            bind(c, name='mgis_bv_revert_material_data_manager') result(r)
         use, intrinsic :: iso_c_binding, only: c_ptr
         use mgis
         implicit none
         type(c_ptr), intent(in), value :: ptr
         type(mgis_status) :: r
       end function revert_material_data_manager_wrapper
    end interface
    type(MaterialDataManager), intent(in) :: d
    type(mgis_status) :: r
    r = revert_material_data_manager_wrapper(d%ptr)
  end function revert_material_data_manager
  ! integrate
  function integrate(r, d, b) result(s)
    use mgis, only: mgis_status
    implicit none
    interface
       function integrate_wrapper(r, d, b) &
            bind(c,name = 'mgis_bv_integrate_2') result(s)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_int
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_int), intent(out) :: r
         type(c_ptr), intent(in),value :: d
         type(c_ptr), intent(in),value :: b
         type(mgis_status) :: s
       end function integrate_wrapper
    end interface
    integer, intent(out) :: r
    type(BehaviourData), intent(in) :: d
    type(Behaviour),     intent(in) :: b
    type(mgis_status) :: s
    s = integrate_wrapper(r, d%ptr, b%ptr)
  end function integrate
  ! 
  function integrate_material_data_manager(r, p, m, dt) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities, only: convert_to_c_index
    use mgis, only: ThreadPool, mgis_status, report_failure
    implicit none
    interface
       function integrate_material_data_manager_wrapper(r, p, m, dt) &
            bind(c,name = 'mgis_bv_integrate_material_data_manager') &
            result(s)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_int, c_double
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_int), intent(out) :: r
         type(c_ptr), intent(in),value :: p
         type(c_ptr), intent(in),value :: m
         real(kind = c_double), intent(in),value :: dt
         type(mgis_status) :: s
       end function integrate_material_data_manager_wrapper
    end interface
    integer, intent(out) :: r
    type(ThreadPool),          intent(in) :: p
    type(MaterialDataManager), intent(in) :: m
    real(kind = 8),            intent(in) :: dt
    type(mgis_status) :: s
    s = integrate_material_data_manager_wrapper(r, p%ptr, m%ptr, dt)
  end function integrate_material_data_manager
  !
  function integrate_material_data_manager_part(r, m, dt, ni, ne) result(s)
    use, intrinsic :: iso_c_binding, only: c_size_t
    use mgis_fortran_utilities, only: convert_to_c_index
    use mgis, only: mgis_status, report_failure
    implicit none
    interface
       function integrate_material_data_manager_part_wrapper(r, m, dt, ni, ne) &
            bind(c,name = 'mgis_bv_integrate_material_data_manager_part') &
            result(s)
         use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t, c_int, c_double
         use mgis, only: mgis_status
         implicit none
         integer(kind=c_int), intent(out) :: r
         type(c_ptr), intent(in),value :: m
         real(kind = c_double), intent(in),value :: dt
         integer(kind = c_size_t), intent(in),value :: ni
         integer(kind = c_size_t), intent(in),value :: ne
         type(mgis_status) :: s
       end function integrate_material_data_manager_part_wrapper
    end interface
    integer, intent(out) :: r
    type(MaterialDataManager), intent(in) :: m
    real(kind = 8),            intent(in) :: dt
    integer :: ni
    integer :: ne
    type(mgis_status) :: s
    integer(kind=c_size_t) :: nic
    integer(kind=c_size_t) :: nec
    if(.not. convert_to_c_index(nic, ni)) then
       s = report_failure("invalid index")
       return
    end if
    if(.not. convert_to_c_index(nec, ne)) then
       s = report_failure("invalid index")
       return
    end if
    nec = nec + 1
    s = integrate_material_data_manager_part_wrapper(r, m%ptr, dt, nic, nec)
  end function integrate_material_data_manager_part
end module  mgis_behaviour
