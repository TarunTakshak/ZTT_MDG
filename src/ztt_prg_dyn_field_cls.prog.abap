*&---------------------------------------------------------------------*
*& Report ztt_prg_dyn_field_cls
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_dyn_field_cls.

TABLES : dd03l.

PARAMETERS : p_tab TYPE tabname,
             p_row TYPE sy-dbcnt.

DATA : lo_dyn_dec  TYPE REF TO data,
       lv_sucess   TYPE abap_bool,
       lv_temp     TYPE char30,
       lt_temp_tab TYPE TABLE OF char30.

SELECT-OPTIONS : s_field FOR dd03l-fieldname.

FIELD-SYMBOLS : <lt_tab> TYPE ANY TABLE.

LOOP AT s_field.
  lv_temp = s_field-low.
  APPEND lv_temp TO lt_temp_tab.
ENDLOOP.

DATA(lo_obj) = NEW ztt_cl_dyn_data( ).

CALL METHOD lo_obj->validate_tab
  EXPORTING
    i_tab = p_tab
  IMPORTING
    e_tab = lv_sucess.

IF lv_sucess EQ abap_true.

  CREATE DATA lo_dyn_dec TYPE TABLE OF (p_tab).

  ASSIGN lo_dyn_dec->* TO <lt_tab>.

  IF <lt_tab> IS ASSIGNED.
    TRY.

        CALL METHOD lo_obj->read_tab
          EXPORTING
            i_tab        = p_tab
            i_row        = p_row
            i_table_temp = lt_temp_tab
          IMPORTING
            e_table      = <lt_tab>.
        IF <lt_tab> IS INITIAL.
          MESSAGE e000(ztt_msg_rerfernce).
        ELSE.
          cl_demo_output=>display_data(
            EXPORTING
              value   = <lt_tab>

          ).

        ENDIF.
      CATCH cx_sy_dynamic_osql_semantics.
        MESSAGE e002(ztt_msg_rerfernce).
    ENDTRY.
  ENDIF.
  UNASSIGN : <lt_tab>.

ENDIF.
