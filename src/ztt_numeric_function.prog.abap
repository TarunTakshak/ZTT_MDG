*&---------------------------------------------------------------------*
*& Report ztt_numeric_function
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_numeric_function.

DATA n TYPE decfloat16.
DATA m TYPE decfloat16 VALUE '5.55'.

    DATA(out) = cl_demo_output=>new( ).

"abs
*    n = abs( m ).
*    out->write( |ABS: { n }| ).

*"sign
*    n = sign( m ).
*    out->write( |SIGN: { n }| ).

*"ceil less-negative  high-positive
*    n = ceil( m ).
*    out->write( |CEIL: { n }| ).

*"floor negative - high positive-low
*    n = floor( m ).
*    out->write( |FLOOR: { n }| ).

*"trunc - rounding off
*    n = trunc( m ).
*    out->write( |TRUNC: { n }| ).

*"frac-after decimal
*    n = frac( m ).
*    out->write( |FRAC: { n }| ).
*
*    out->display( ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""ipow
**
*    DATA n TYPE i.
*    DATA arg1 TYPE p DECIMALS 1.
*    DATA arg2 TYPE int8.
*
*    n = 2.
*    arg1 = `1.2`.
*    DATA(out) = cl_demo_output=>new(
*      )->write( |**  : { arg1 ** n }|
*      )->write( |ipow: { ipow( base = arg1 exp = n ) }| ).
*
*    cl_demo_output=>line( ).
*
*    n = 62.
*    arg2 = 2.
*    out->write( |**  : { arg2 ** n }|
*      )->write( |ipow: { ipow( base = arg2 exp = n ) }| ).
*
*    out->display( ).
