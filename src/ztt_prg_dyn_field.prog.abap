*&---------------------------------------------------------------------*
*& Report ztt_prg_dyn_field
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_dyn_field.

**********************************************************************
* Developer ID: TAKSHAKT
* Created Date: 08.09.2022
* Transport ID:
**********************************************************************
*                         Descriptive Logic                          *
**********************************************************************

**********************************************************************
*                          Change History                            *
**********************************************************************
* Changed By * Changed Date * Transport ID * Reason for Change / Id  *
**********************************************************************
*            *              *              *                         *
*            *              *              *                         *
**********************************************************************


TABLES : dd03l.

TYPES : BEGIN OF ty_dd03l,
          tabname   TYPE tabname,
          fieldname TYPE fieldname,
        END OF ty_dd03l.



PARAMETERS : p_tab  TYPE tabname,
             p_rows TYPE sy-dbcnt.


DATA : lo_dyn_dec  TYPE REF TO data,
       lt_table    TYPE TABLE OF ty_dd03l,
       lv_temp     TYPE char30,
       o_alv       TYPE REF TO cl_salv_table,
       lt_tab_temp TYPE TABLE OF char30.



SELECT-OPTIONS s_field FOR dd03l-fieldname.


FIELD-SYMBOLS:
  <lt_tab> TYPE ANY TABLE,
  <lv_row> TYPE any.

LOOP AT s_field.
  lv_temp = s_field-low.
  APPEND lv_temp TO lt_tab_temp.
ENDLOOP.


START-OF-SELECTION.

  TRY.
      SELECT tabname fieldname  FROM dd03l INTO TABLE lt_table  WHERE tabname = p_tab
                                                                  AND fieldname IN s_field.

      IF sy-subrc <> 0 .
        MESSAGE e000(ztt_msg_rerfernce) WITH p_tab.
      ELSE.
        ASSIGN p_rows TO <lv_row>.
        IF <lv_row> IS ASSIGNED.
          CREATE DATA lo_dyn_dec TYPE TABLE OF (p_tab).
          ASSIGN lo_dyn_dec->* TO <lt_tab>.
          IF <lt_tab> IS ASSIGNED.

          SELECT (lt_tab_temp) FROM (p_tab) INTO CORRESPONDING FIELDS OF TABLE <lt_tab> UP TO <lv_row> ROWS.

            IF sy-subrc NE 0.
              MESSAGE e000(ztt_msg_rerfernce).
            ELSE.
*normal display
*          cl_demo_output=>display_data(
*            EXPORTING
*              value   = <lt_tab>
*          ).
*alv display
              CALL METHOD cl_salv_table=>factory
                IMPORTING
                  r_salv_table = o_alv
                CHANGING
                  t_table      = <lt_tab>.
              o_alv->display( ).
            ENDIF.
          ENDIF.
        ENDIF.
        UNASSIGN : <lt_tab>,
                   <lv_row>.

        CLEAR : lo_dyn_dec.

      ENDIF.
    CATCH cx_sy_dynamic_osql_semantics.
      MESSAGE e002(ztt_msg_rerfernce).
  ENDTRY.
