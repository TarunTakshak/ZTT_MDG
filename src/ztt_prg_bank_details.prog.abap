*&---------------------------------------------------------------------*
*& Report ztt_prg_bank_details
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_bank_details.

SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME TITLE TEXT-002.

  PARAMETERS : p_insert RADIOBUTTON GROUP rb1,
               p_displa RADIOBUTTON GROUP rb1,
               p_update RADIOBUTTON GROUP rb1,
               p_delete RADIOBUTTON GROUP rb1.

SELECTION-SCREEN END OF BLOCK b.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.

  PARAMETERS :
    "parameters for Bank master data
    p_bankid TYPE ztt_de_bank_id,
    p_addid  TYPE ztt_de_address_id,
    p_ifsc   TYPE int4,
    p_bname  TYPE char20,
    p_mname  TYPE char20,
    p_email  TYPE char20,
    p_mobile TYPE int4,
    p_fax    TYPE int4.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001 .
  "parameters for bank address data
  PARAMETERS:
    p_add_id TYPE ztt_de_address_id,
    p_pinco  TYPE   char20,
    p_street TYPE   char20,
    p_landma TYPE   char25,
    p_city   TYPE   char25,
    p_distri TYPE   char20,
    p_count  TYPE   char20.
SELECTION-SCREEN END OF BLOCK b2.

DATA : lo_bank TYPE REF TO ztt_cl_bank_details,
       lo_add  TYPE REF TO ztt_cl_bank_details,
       ls_bank TYPE ztt_t_bank_mst,
       lo_Temp TYPE REF TO ztt_cl_bank_details,
       ls_add  TYPE ztt_t_bank_add.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""Creating Object""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lo_bank = NEW ztt_cl_bank_details( ).


ls_bank-bank_id = p_bankid.
ls_bank-address_id = p_addid.
ls_bank-ifsc_code  = p_ifsc.
ls_bank-bank_name = p_bname.
ls_bank-manager_name = p_mname.
ls_bank-email = p_email.
ls_bank-mobile = p_mobile.
ls_bank-fax = p_fax.

ls_add-address_id = p_add_id.
ls_add-city =  p_city.
ls_add-pincode =  p_pinco.
ls_add-district =  p_distri.
ls_add-landmark = p_landma.
ls_add-street = p_street.


IF p_displa = abap_true.
  SELECT *   FROM ztt_t_bank_mst INTO ls_bank WHERE bank_id = p_bankid.
  ENDSELECT.
  IF sy-subrc = 0 AND ls_bank IS INITIAL.
    MESSAGE 'DATA Found' TYPE 'I'.
  ELSE.
    MESSAGE 'DATA NOT Found' TYPE 'E'.
    CALL METHOD lo_bank->read_bank
      IMPORTING
        es_bank_ma = ls_bank.
  ENDIF.

  SELECT *   FROM ztt_t_bank_add INTO ls_add WHERE address_id = p_add_id.
  ENDSELECT.
  IF sy-subrc = 0 AND ls_add IS INITIAL.
    MESSAGE 'DATA Found' TYPE 'I'.
  ELSE.
    MESSAGE 'DATA NOT Found' TYPE 'E'.
    CALL METHOD lo_bank->read_address
      IMPORTING
        es_bank_ad = ls_add.
  ENDIF.

ELSEIF p_insert = abap_true.


     CALL METHOD lo_bank->validate_bank
     EXPORTING
       is_bank_ma = ls_bank
       is_bank_ad = ls_add.

  CALL METHOD lo_bank->create_bank
    EXPORTING
      is_bank_ma = ls_bank
      is_bank_ad = ls_add.


  CALL METHOD lo_bank->create_address
    EXPORTING
      is_bank_ad = ls_add.


ELSEIF p_delete = abap_true.
  CALL METHOD lo_bank->delete_bank
    EXPORTING
      is_bank_ma = ls_bank
      is_bank_ad = ls_add.
  CALL METHOD lo_bank->delete_address
    EXPORTING
      is_bank_ad = ls_add.

ELSEIF p_update = abap_true.
  CALL METHOD lo_bank->change_bank
    EXPORTING
      is_bank_ma = ls_bank
      is_bank_ad = ls_add.
  CALL METHOD lo_bank->change_address
    EXPORTING
      is_bank_ad = ls_add.




ENDIF.









.
