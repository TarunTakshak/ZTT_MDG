**********************************************************************
*Objective - Class has to take TableName and No.of.rows from the program
*            and fetch table data from the class
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

CLASS ztt_cl_dyn_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA : lo_dyn_dec TYPE REF TO data.
    METHODS :
"method for read data
      read_tab IMPORTING i_tab   TYPE tabname
                         i_row   TYPE sy-dbcnt
                         i_table_temp type STANDARD TABLE OPTIONAL
               EXPORTING e_table TYPE ANY TABLE,
"method for validate data
      validate_tab IMPORTING i_tab TYPE tabname
                   EXPORTING e_tab TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztt_cl_dyn_data IMPLEMENTATION.
 METHOD read_tab.                      "method for read data
 "field-symbol for table and row
    FIELD-SYMBOLS: <lt_tab> TYPE ANY TABLE,
                   <lv_row> TYPE any.
  "creating data dynamically
    CREATE DATA lo_dyn_dec TYPE TABLE OF (i_tab).

  "assigning field-symbol
    ASSIGN lo_dyn_dec->* TO <lt_tab>.
    IF <lt_tab> IS ASSIGNED.

    if i_table_temp is not SUPPLIED.

      SELECT * FROM (i_tab) INTO TABLE <lt_tab>  UP TO i_row ROWS.
      e_table = <lt_tab>.

      elseif i_table_temp is SUPPLIED.

      SELECT (i_table_temp) FROM (i_tab) INTO CORRESPONDING FIELDS OF TABLE <lt_tab> UP TO i_row ROWS.

      IF sy-subrc <> 0.
        MESSAGE  e000(ztt_msg_rerfernce).
      ELSE.
        e_table = <lt_tab>.
      ENDIF.
    ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD validate_tab.                 "method for validate data

    IF i_tab IS NOT INITIAL.

      SELECT SINGLE tabname FROM dd03l INTO  @DATA(lv_table) WHERE tabname = @i_tab.
      IF sy-subrc NE 0.
        MESSAGE  e000(ztt_msg_rerfernce).
      ELSE.
        e_tab = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


