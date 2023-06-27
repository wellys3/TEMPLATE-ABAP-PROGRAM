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
                    CHANGING p_git_mara_makt TYPE gtt_mara_makt
                             p_git_mara_makt_2 TYPE gtt_mara_makt_2.

  CASE gd_rb.
    WHEN 'RB3'.

      LOOP AT p_git_mara INTO gwa_mara.

        CLEAR gwa_mara_makt.
        gwa_mara_makt-matnr = gwa_mara-matnr.

        READ TABLE p_git_makt INTO gwa_makt WITH KEY matnr = gwa_mara-matnr.
        IF sy-subrc EQ 0.

          gwa_mara_makt-maktx = gwa_makt-maktx.

        ENDIF.

        APPEND gwa_mara_makt TO p_git_mara_makt.

      ENDLOOP.

    WHEN 'RB4'.

      LOOP AT p_git_mara INTO gwa_mara.

        CLEAR gwa_mara_makt_2.
        gwa_mara_makt_2-matnr = gwa_mara-matnr.

        READ TABLE p_git_makt INTO gwa_makt WITH KEY matnr = gwa_mara-matnr.
        IF sy-subrc EQ 0.

          gwa_mara_makt_2-maktx = gwa_makt-maktx.

        ENDIF.

        APPEND gwa_mara_makt_2 TO p_git_mara_makt_2.

      ENDLOOP.

  ENDCASE.

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


*&---------------------------------------------------------------------*
*& Form F_EXEC_BUTTON_1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_DATA[]
*&---------------------------------------------------------------------*
FORM f_exec_button_1  CHANGING p_git_mara_makt_2 TYPE gtt_mara_makt_2.

  LOOP AT p_git_mara_makt_2 ASSIGNING FIELD-SYMBOL(<lfs_mara_makt_2>)
    WHERE select EQ 'X'.

    CONCATENATE <lfs_mara_makt_2>-matnr
                <lfs_mara_makt_2>-maktx
     INTO <lfs_mara_makt_2>-matnr_maktx
      SEPARATED BY space.

  ENDLOOP.

ENDFORM.
