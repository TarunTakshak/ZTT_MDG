*&---------------------------------------------------------------------*
*& Report ztt_sample
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_sample.



*data : lo_dyn TYPE REF TO data,
*        lo_type_desc TYPE ref to cl_abap_typedescr.
*
*
*lo_type_desc = cl_abap_typedescr=>describe_by_name( p_name = 'MARA' ).
*
*CREATE DATA lo_dyn TYPE STANDARD TABLE OF p_name.
*ASSign lo_dyn->* to FIELD-SYMBOL(<lt_data>).
*
*if <lt_data> is ASSIGNED.
*
*  select * FROM mara INTO TABLE lt_data UP TO 10 rows.
*
*    ENDIF.
*
*    cl_demo_output=>display( lt_data ).


PARAMETERS : p_table TYPE char20.

DATA : lo_str    TYPE REF TO cl_abap_structdescr,
       ls_compnt TYPE cl_abap_structdescr=>component,
       lt_tab    TYPE REF TO data.


lo_str ?= cl_abap_typedescr=>describe_by_name( p_table ).

DATA(lo_type) = cl_abap_tabledescr=>create( p_line_type  = lo_str ).

"data(lo_comp) = lo_str->get_components( ).



CREATE DATA lt_tab TYPE HANDLE lo_type.

ASSIGN lt_tab->* TO FIELD-SYMBOL(<lt>).

*  DESCRIBE TABLE <lt> KIND data(tabkind).
*
*  if tabkind = sydes_kind-standard.GET_COMPONENT_TYPE

" if CL_ABAP_STRUCTDESCR=>typepropkind_hasclient eq 'C'.


*  read TABLE lo_comp INTO data(ls_comp) WITH KEY name = 'MANDT' .
*
*
*  if sy-subrc eq 0.

IF ls_compnt-name = 'MANDT'.


  SELECT * FROM (p_table) INTO TABLE @<lt> UP TO 10 ROWS.

  cl_demo_output=>display( <lt> ).

ELSE.

  MESSAGE 'NOT DDIC TABLE' TYPE 'E'.

ENDIF.














**DATA : var1  TYPE string VALUE 'Welcome',
**       var2  TYPE string VALUE 'To',
**       var3  TYPE string VALUE 'Eclipse',
**       final TYPE string.
**
**
**CONCATENATE var1 var2 var3 INTO final SEPARATED BY space.
**
**WRITE : final.
