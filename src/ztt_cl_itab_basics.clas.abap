*CLASS ztt_cl_itab_basics DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC .
*
*
*  PUBLIC SECTION.
*    TYPES group TYPE c LENGTH 1.
*    TYPES: BEGIN OF initial_type,
*             group       TYPE group,
*             number      TYPE i,
*             description TYPE string,
*           END OF initial_type,
*           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.
*
*
*    METHODS fill_itab
*      RETURNING
*        VALUE(initial_data) TYPE itab_data_type.
*
*    METHODS add_to_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(updated_data) TYPE itab_data_type.
*
*    METHODS sort_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(updated_data) TYPE itab_data_type.
*
*    METHODS search_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(result_index) TYPE i.
*
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*
*
*
*CLASS ztt_cl_itab_basics IMPLEMENTATION.
*  METHOD fill_itab.
*
*      initial_data =  VALUE #( ( group =  'A' number = 10  description = 'Group A-2')
*                               (  group = 'B' number = 5   description = 'Group B')
*                               (  group = 'A' number = 6   description = 'Group A-1')
*                               (  group = 'C' number = 22  description = 'Group C-2')
*                               (  group = 'A' number = 13  description = 'Group A-3')
*                               (  group = 'C' number = 500 description = 'Group C-2')
*                                ) .
*
*  ENDMETHOD.
*
*  METHOD add_to_itab.
*    updated_data = initial_data.
*    updated_data = value #( base  initial_data  ( group = 'A' number = 19   description = 'Group A-4' ) ).
*  ENDMETHOD.
*
*  METHOD sort_itab.
*    updated_data = initial_data.
*    sort updated_data by group ascending
*                          number DESCENDING.
*  ENDMETHOD.
*
*  METHOD search_itab.
*    DATA(temp_data) = initial_data.
*    "add solution here
*
*    READ table temp_data WITH KEY number = 6 TRANSPORTING NO FIELDS.
*
*    result_index = sy-tabix.
*
*
*
*  ENDMETHOD.
*
*ENDCLASS.



*CLASS ztt_cl_itab_basics DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC .
*
*  PUBLIC SECTION.
*
*    TYPES: BEGIN OF alphatab_type,
*             cola TYPE string,
*             colb TYPE string,
*             colc TYPE string,
*           END OF alphatab_type.
*    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.
*
*    TYPES: BEGIN OF numtab_type,
*             col1 TYPE string,
*             col2 TYPE string,
*             col3 TYPE string,
*           END OF numtab_type.
*    TYPES nums TYPE STANDARD TABLE OF numtab_type.
*
*    TYPES: BEGIN OF combined_data_type,
*             colx TYPE string,
*             coly TYPE string,
*             colz TYPE string,
*           END OF combined_data_type.
*    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.
*
*    METHODS perform_combination
*      IMPORTING
*        alphas             TYPE alphas
*        nums               TYPE nums
*      RETURNING
*        VALUE(combined_data) TYPE combined_data.
*
*
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*
*
*ENDCLASS.
*
*CLASS ztt_cl_itab_basics IMPLEMENTATION.
*
*  METHOD perform_combination.
*
*  loop at alphas ASSIGNING FIELD-SYMBOL(<fs_alpha>).
*
*  READ TABLE nums ASSIGNING FIELD-SYMBOL(<fs_nums>) INDEX sy-tabix.
*
*  if sy-subrc eq 0.
*
*  combined_data = VALUE #( base combined_data
*                         ( colx = |{ <fs_alpha>-cola }{ <fs_nums>-col1 }| )
*                         ( coly = |{ <fs_alpha>-colb }{ <fs_nums>-col2 }| )
*                         ( colz = |{ <fs_alpha>-colc }{ <fs_nums>-col3 }| )
*
*                         ).
*    ENDIF.
*    ENDLOOP.
*  ENDMETHOD.
*
*ENDCLASS.

***********

*CLASS ztt_cl_itab_basics  DEFINITION
*  PUBLIC
*  FINAL
*  CREATE PUBLIC .
*
*  PUBLIC SECTION.
*    TYPES group TYPE c LENGTH 1.
*    TYPES: BEGIN OF initial_numbers_type,
*             group  TYPE group,
*             number TYPE i,
*           END OF initial_numbers_type,
*           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.
*
*    TYPES: BEGIN OF aggregated_data_type,
*             group   TYPE group,
*             count   TYPE i,
*             sum     TYPE i,
*             min     TYPE i,
*             max     TYPE i,
*             average TYPE f,
*           END OF aggregated_data_type,
*           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.
*
*    METHODS perform_aggregation
*      IMPORTING
*        initial_numbers        TYPE initial_numbers
*      RETURNING
*        VALUE(aggregated_data) TYPE aggregated_data.
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*
*ENDCLASS.
*
*
*
*CLASS ztt_cl_itab_basics  IMPLEMENTATION.
*  METHOD perform_aggregation.
*    " add solution here
*    loop at initial_numbers assigning field-SYMBOL(<fs_init>).
*    read TABLE aggregated_data ASSIGNING FIELD-SYMBOL(<fs_agg>) WITH KEY group = <fs_init>-group.
*    if <fs_agg> is ASSIGNED.
*    <fs_agg>-sum = <fs_agg>-sum + <fs_init>-number.
*    <fs_agg>-count = <fs_agg>-count + 1.
*    <fs_agg>-average = <fs_agg>-sum / <fs_agg>-count.
*
*   if <fs_init>-number < <fs_agg>-min.
*      <fs_agg>-min = <fs_init>-number.
*   elseif <fs_init>-number > <fs_agg>-max.
*      <fs_agg>-max = <fs_init>-number.
*   ENDIF.
*
*   else.
*   aggregated_data = value #( base aggregated_data
*                             ( group = <fs_init>-group
*                              count = 1
*                              sum = <fs_init>-number
*                              average = <fs_init>-number
*                              max = <fs_init>-number
*                              min = <fs_init>-number
*                             ) ).
*
*      ENDIF.
*      UNASSIGN <fs_agg>.
*      ENDLOOP.
*  ENDMETHOD.
*
*ENDCLASS.

******************************

CLASS ztt_cl_itab_basics  DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS ztt_cl_itab_basics  IMPLEMENTATION.

  METHOD reverse_string.
    " Please complete the implementation of the reverse_string method
    result = input.
    call function 'STRING_REVERSE'
      EXPORTING
        string    = input
        lang      = 'E'
*      IMPORTING
        rstring   = result
*      EXCEPTIONS
*        too_small = 1
*        others    = 2
      .

  ENDMETHOD.

ENDCLASS.



