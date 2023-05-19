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
