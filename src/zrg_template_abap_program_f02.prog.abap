*&---------------------------------------------------------------------*
*& Include          ZRG_TEMPLATE_ABAP_PROGRAM_F02
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form F_PROCESS_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_DATA
*&---------------------------------------------------------------------*
FORM f_process_data    USING p_git_mara TYPE gtt_mara
                             p_git_makt TYPE gtt_makt
                    CHANGING p_git_data TYPE gtt_data.

  LOOP AT p_git_mara INTO gwa_mara.

    CLEAR gwa_data.
    gwa_data-matnr = gwa_mara-matnr.

    READ TABLE p_git_makt INTO gwa_makt WITH KEY matnr = gwa_mara-matnr.
    IF sy-subrc EQ 0.

      gwa_data-maktx = gwa_makt-maktx.

    ENDIF.

    APPEND gwa_data TO p_git_data.

  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_PREPARING_EXCEL_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GIT_EXCEL_RAW
*&      <-- GIT_EXCEL_FIX
*&---------------------------------------------------------------------*
FORM f_preparing_excel_data     USING p_git_excel_raw TYPE gtt_excel_raw
                             CHANGING p_git_excel_fix TYPE gtt_excel_fix.

  LOOP AT p_git_excel_raw INTO gwa_excel_raw.

    CLEAR gwa_excel_fix.
    gwa_excel_fix-bukrs = gwa_excel_raw-col1.
    gwa_excel_fix-belnr = gwa_excel_raw-col2.
    gwa_excel_fix-gjahr = gwa_excel_raw-col3.
    APPEND gwa_excel_fix TO p_git_excel_fix.

  ENDLOOP.

ENDFORM.
