*&---------------------------------------------------------------------*
*& Include          ZRG_TEMPLATE_ABAP_PROGRAM_F01
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Form F_PRE_EXECUTE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GD_SUBRC
*&---------------------------------------------------------------------*
FORM f_pre_execute  CHANGING p_gd_subrc.



ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_EXECUTE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_execute .

  CASE gd_rb.
    WHEN 'RB1'.



    WHEN 'RB2'.

    WHEN 'RB3'.

      PERFORM f_start_timer.

      PERFORM f_get_data CHANGING git_mara
                                  git_makt.

      PERFORM f_process_data    USING git_mara
                                      git_makt
                             CHANGING git_data.

      PERFORM f_stop_timer.

      PERFORM f_display_data USING git_data.

  ENDCASE.



ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GIT_MARA
*&      <-- GIT_MAKT
*&---------------------------------------------------------------------*
FORM f_get_data  CHANGING p_git_mara TYPE gtt_mara
                          p_git_makt TYPE gtt_makt.

  SELECT * FROM mara INTO TABLE p_git_mara.
  SELECT * FROM makt INTO TABLE p_git_makt.

ENDFORM.
