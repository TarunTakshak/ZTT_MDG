*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_DYN_DATA_DEC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_dyn_data_dec.
**********************************************************************
* DEVELOPER ID: TAKSHAKT
* CREATED DATE: 01.09.2022
* TRANSPORT ID: S4XK903138
**********************************************************************
*Objective - Report has to Accept input from the user which is TableName
*            and No.of.rows that should be displayed dynamically
**********************************************************************
* DESCRIPTIVE LOGIC *
**********************************************************************

**********************************************************************
* CHANGE HISTORY *
**********************************************************************
* CHANGED BY * CHANGED DATE * TRANSPORT ID * REASON FOR CHANGE / ID *
**********************************************************************
*    *             *             *              *                 *
*    *             *             *              *                 *
**********************************************************************

**********************************************************************
*                       Selection-Screen
**********************************************************************

PARAMETERS : p_tab  TYPE tabname OBLIGATORY,
             "table name
             p_rows TYPE sy-dbcnt OBLIGATORY.
             "database table rows
**********************************************************************
*                       Data Declaration
**********************************************************************
DATA : lo_dyn_data TYPE REF TO data.
FIELD-SYMBOLS:
  <lt_tab> TYPE ANY TABLE,
  <lv_cnt> TYPE any.

"Field Validation
START-OF-SELECTION.
  SELECT SINGLE tabname FROM dd02l INTO @DATA(lv_table) WHERE tabname = @p_tab.
  IF sy-subrc <> 0 .
    MESSAGE e000(ztt_msg_rerfernce) WITH p_tab.
  ELSE.

  "Assigning parameter to field-symbol
   ASSIGN p_rows TO <lv_cnt>.
   IF <lv_cnt> IS ASSIGNED.

  "creating dynamic data
   CREATE DATA lo_dyn_data TYPE TABLE OF (p_tab).

  "Assigning the dynamic internal table to field-symbol
   ASSIGN lo_dyn_data->* TO <lt_tab>.
      IF <lt_tab> IS ASSIGNED.
        "fetching Data
        SELECT * FROM (p_tab) INTO TABLE <lt_tab> UP TO <lv_cnt> ROWS.
        "displaying data
        cl_demo_output=>display_data(
        EXPORTING
        value = <lt_tab>
        ).
      ENDIF.                             "IF <lt_tab> IS ASSIGNED.
    ENDIF.                               "IF <lv_cnt> IS ASSIGNED.
   "unassigning values
    UNASSIGN: <lt_tab>,
              <lv_cnt>.
    CLEAR lo_dyn_data.
  ENDIF.                                 "IF sy-subrc <> 0 .
