*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_DATA_DYN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_data_dyn.
**********************************************************************
*Objective - Report has to Accept input from the user which is TableName
*            and No.of.rows that should be displayed dynamically using class.
**********************************************************************
* DESCRIPTIVE LOGIC *
**********************************************************************
* 1.First,User should give input for tablename and no.of.rows
* 2.Then we have created local internal table using field-symbol of type any table
* 3.Then we have created a object from the Z class
* 4.And we are calling validate method to validate data given by user
* 5.Then we are creating data dynamically and assigning to internal table
* 6.if table is assigned then we reading data from the table
* 7.By using display class we are displaying the output
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
PARAMETERS : p_tab TYPE tabname OBLIGATORY,
                                       "table name
             p_row TYPE sy-dbcnt OBLIGATORY.
                                       "database table rows
**********************************************************************
*                       Data Declaration
**********************************************************************
DATA : lo_dyn_dec TYPE REF TO data,
       lv_temp    TYPE c.

"field-symbol for table
FIELD-SYMBOLS: <lt_tab> TYPE ANY TABLE.
"creating a object
DATA(lo_tab) = NEW ztt_cl_dyn_data( ).
"calling method to validate data
CALL METHOD lo_tab->validate_tab
  EXPORTING
    i_tab = p_tab
  IMPORTING
    e_tab = lv_temp.

IF lv_temp IS NOT INITIAL.
  "creating data dynamically

  CREATE DATA lo_dyn_dec TYPE TABLE OF (p_tab).

  "assigning field-symbol
  ASSIGN lo_dyn_dec->* TO <lt_tab>.

  "if lt_tab is assigned
IF <lt_tab> IS ASSIGNED.


call METHOD lo_tab->read_tab
  EXPORTING
    i_tab        = p_tab
    i_row        = p_row
  IMPORTING
    e_table      =  <lt_tab>
  .

IF <lt_tab> IS NOT INITIAL.
"displaying the output
   cl_demo_output=>display_data(
     EXPORTING
      value = <lt_tab>
      ).
    ENDIF.                             "IF <lt_tab> IS NOT INITIAL.
  ENDIF.                               "IF <lt_tab> IS ASSIGNED.
  UNASSIGN : <lt_tab>.
ENDIF.                                 "IF lv_temp IS NOT INITIAL.
