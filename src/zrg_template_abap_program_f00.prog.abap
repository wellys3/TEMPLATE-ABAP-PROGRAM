*&---------------------------------------------------------------------*
*& Include          ZRG_TEMPLATE_ABAP_PROGRAM_F00
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  F_INITIALIZATION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_initialization .
  PERFORM f_add_download_button.
  PERFORM f_get_terminal_debugger.
  PERFORM f_set_text.
ENDFORM.                    "f_initialization


*&---------------------------------------------------------------------*
*&      Form  F_GET_TERMINAL_DEBUGGER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_get_terminal_debugger .

  "Determine own Terminal-Id
  CALL 'ThUsrInfo' ID 'OPCODE' FIELD gd_opcode_usr_attr
    ID 'TERMINAL' FIELD gd_terminal.

  SELECT * FROM tvarvc INTO TABLE git_terminal
    WHERE name EQ 'ZDEBUG_TERMINAL'.

  SELECT SINGLE low FROM tvarvc INTO gd_zdebug
    WHERE name EQ 'ZDEBUG'.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_BREAK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_break .

  READ TABLE git_terminal WITH KEY low = gd_terminal.
  IF sy-subrc EQ 0.
    IF gd_zdebug EQ 'X'.
      BREAK-POINT.
    ENDIF.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_ADD_DOWNLOAD_BUTTON
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_add_download_button .

  DATA: lwa_functxt TYPE smp_dyntxt.

  "*--------------------------------------------------------------------*

  lwa_functxt-icon_id = icon_xls. " Add Icon to button if you want.
  lwa_functxt-quickinfo = 'Download Template'. " Text to be displayed when you hover mouse over the button
  lwa_functxt-text = 'Download Template'. " Text to be displayed
  lwa_functxt-icon_text = 'Download Template'. " Text to be dsipalyed on button.
  sscrfields-functxt_01 = lwa_functxt.

ENDFORM.                    "f_add_download_button


*&---------------------------------------------------------------------*
*& Form F_SET_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_set_text .

  h001 = 'Selection Option'.
  h001s001 = 'Upload File'.
  h001s002 = 'Table BKPF'.
  h001s003 = 'Table MARA & MAKT'.
  h001s004 = 'Table MARA & MAKT with Button in ALV'.

  h002 = 'Selection Area Upload'.
  h002s001 = 'Is multisheet?'.
  h002s002 = '(X = On | <BLANK> = Off)'.
  %_p_file_%_app_%-text = 'Filepath'.

  h003 = 'Selection Area BKPF'.
  %_s_bukrs_%_app_%-text = 'Company Code'.
  %_s_gjahr_%_app_%-text = 'Fiscal Year'.
  %_s_belnr_%_app_%-text = 'Document Number'.
  %_s_blart_%_app_%-text = 'Document Type'.

  h004 = 'Selection Area MARA & MAKT'.
  %_s_matnr_%_app_%-text = 'Material Number'.

  h005 = 'Selection Area MARA & MAKT with Button in ALV'.
  %_s2_matnr_%_app_%-text = 'Material Number'.

ENDFORM.                    "f_set_text


*&---------------------------------------------------------------------*
*&      Form  F_DOWNLOAD_TEMPLATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_download_template .

  CHECK sy-ucomm EQ gc_ucomm_download.

  DATA : lo_mime      TYPE REF TO if_mr_api.
  DATA : lt_binfiles  TYPE STANDARD TABLE OF sdokcntbin.
  DATA : ld_files            TYPE xstring,
         ld_filename         TYPE string,
         ld_path             TYPE string,
         ld_fullpath         TYPE string,
         ld_useraction       TYPE i,
         ld_default_filename TYPE string.

  "*--------------------------------------------------------------------*

  CONCATENATE gc_filename '_' sy-datum '_' sy-uzeit INTO ld_default_filename.
  CONCATENATE ld_default_filename '.xls' INTO ld_default_filename.

  lo_mime = cl_mime_repository_api=>get_api( ).

  CALL METHOD lo_mime->get
    EXPORTING
      i_url     = gc_template_url
    IMPORTING
      e_content = ld_files.
  IF ld_files IS INITIAL.
    MESSAGE e071(/isdfps/ppempo).
    RETURN.
  ENDIF.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = ld_files
    TABLES
      binary_tab = lt_binfiles.

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    EXPORTING
      window_title         = 'Select filename & location'
      default_extension    = 'xls'
      default_file_name    = ld_default_filename
    CHANGING
      filename             = ld_filename
      path                 = ld_path
      fullpath             = ld_fullpath
      user_action          = ld_useraction
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
*     invalid_default_file_name = 4
      OTHERS               = 5.
  IF sy-subrc <> 0.
    MESSAGE e043(/sdf/smon).
  ENDIF.

  IF ld_useraction = cl_gui_frontend_services=>action_cancel.
    "The action was cancelled by the user
    MESSAGE s007(rsoh).
    RETURN.
  ENDIF.

  CALL METHOD cl_gui_frontend_services=>gui_download
    EXPORTING
      filename                = ld_fullpath
      filetype                = 'BIN'
    CHANGING
      data_tab                = lt_binfiles
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      not_supported_by_gui    = 22
      error_no_gui            = 23
      OTHERS                  = 24.
  IF sy-subrc <> 0.
    "Internal Error Occured
    MESSAGE e043(/sdf/smon).
  ENDIF.

  FREE: lo_mime.

  FREE: lt_binfiles.

  FREE: ld_filename,
        ld_files,
        ld_fullpath,
        ld_path.

ENDFORM.                    "f_download_template


*&---------------------------------------------------------------------*
*& Form F_MANDATORY_VALIDATION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_mandatory_validation .

  IF sy-ucomm = 'ONLI'.


    CASE gd_rb.

      WHEN 'RB1'.

      WHEN 'RB2'.

        IF s_bukrs-low IS INITIAL.
          SET CURSOR FIELD 'S_BUKRS-LOW'.
          MESSAGE 'Fill out all required entry fields' TYPE 'E'.
        ENDIF.

      WHEN 'RB3'.

    ENDCASE.

  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_MODIFY_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_modify_screen .

  PERFORM f_get_rb.

  CASE gd_rb.
    WHEN 'RB1'.

      LOOP AT SCREEN.

        CASE screen-group1.
          WHEN 'M02'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M03'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M04'.
            screen-active = '0'.
            MODIFY SCREEN.
        ENDCASE.

      ENDLOOP.

    WHEN 'RB2'.

      LOOP AT SCREEN.

        CASE screen-name.
          WHEN 'S_BUKRS-LOW'.
            screen-required = '2'.
            MODIFY SCREEN.
        ENDCASE.

        CASE screen-group1.
          WHEN 'M01'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M03'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M04'.
            screen-active = '0'.
            MODIFY SCREEN.
        ENDCASE.

      ENDLOOP.

    WHEN 'RB3'.

      LOOP AT SCREEN.

        CASE screen-group1.
          WHEN 'M01'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M02'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M04'.
            screen-active = '0'.
            MODIFY SCREEN.
        ENDCASE.

      ENDLOOP.

    WHEN 'RB4'.

      LOOP AT SCREEN.

        CASE screen-group1.
          WHEN 'M01'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M02'.
            screen-active = '0'.
            MODIFY SCREEN.
          WHEN 'M03'.
            screen-active = '0'.
            MODIFY SCREEN.
        ENDCASE.

      ENDLOOP.

  ENDCASE.

  "*--------------------------------------------------------------------*

*Unremark this syntax below for your program
*  LOOP AT SCREEN.
*
*    CASE screen-group1.
*      WHEN 'M00' OR 'M01' OR 'M02' OR 'M03' OR 'M04'.
*        screen-active = '0'.
*        MODIFY SCREEN.
*    ENDCASE.
*
*  ENDLOOP.

ENDFORM.


*&-------------------------------------------------------------------*
*&      Form  f_progress_bar_single
*&-------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_VALUE    text
*----------------------------------------------------------------------*
FORM f_progress_bar_single USING p_value
                                 p_type
                                 p_display_like.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      percentage = 0
      text       = p_value.

  MESSAGE p_value TYPE p_type DISPLAY LIKE p_display_like.

ENDFORM.                    "f_progress_bar_single


*&---------------------------------------------------------------------*
*&      Form  f_progress_bar
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_VALUE    text
*      -->P_TABIX    text
*      -->P_NLINES   text
*----------------------------------------------------------------------*
FORM f_progress_bar USING p_value
                          p_tabix
                          p_nlines.
  DATA: w_text(250),
        w_percentage      TYPE p,
        w_percent_char(3).

  w_percentage = ( p_tabix / p_nlines ) * 100.

  "This check needs to be in, otherwise when looping around big tables
  "SAP will re-display indicator too many times causing report to run
  "very slow. (No need to re-display same percentage anyways)
  IF w_percentage GT gd_percent OR p_tabix  EQ 1.

    w_percent_char  = w_percentage.
    SHIFT w_percent_char LEFT DELETING LEADING ' '.
    CONCATENATE w_percent_char '% complete' INTO w_text.
    CONCATENATE p_value w_text INTO w_text SEPARATED BY space.

    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        percentage = w_percentage
        text       = w_text.

    MESSAGE w_text TYPE 'S'.

    gd_percent = w_percentage.

  ENDIF.

ENDFORM.                    "f_progress_bar


*&---------------------------------------------------------------------*
*& Form F_START_TIMER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_start_timer .

  "Record start time
  GET RUN TIME FIELD gd_start.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_STOP_TIMER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_stop_timer .

  "Record end time
  GET RUN TIME FIELD gd_stop.

  "Run time (milliseconds instead of seconds)
  gd_run = ( gd_stop - gd_start ) / 1000000.
  WRITE gd_run TO gd_run_str. CONDENSE gd_run_str.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_LD_ANSWER  text
*&---------------------------------------------------------------------*
FORM f_confirm USING p_word1
                     p_word2
                     p_button1
                     p_button2
            CHANGING p_answer.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = p_word1
      text_question         = p_word2
      text_button_1         = p_button1
      text_button_2         = p_button2
      display_cancel_button = 'X'
    IMPORTING
      answer                = p_answer
    EXCEPTIONS
      text_not_found        = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    "Do nothing
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_BAPI_USER_GET_DETAIL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GWA_Z012_AENAM
*&      <-- LWA_Z062_TEMP0_DEPARTMENT
*&---------------------------------------------------------------------*
FORM f_bapi_user_get_detail    USING p_aenam
                            CHANGING p_department.

  DATA: lit_bapiret2 TYPE TABLE OF bapiret2,
        lwa_address  TYPE bapiaddr3.

*--------------------------------------------------------------------*

  CLEAR: lwa_address, lit_bapiret2[].
  CALL FUNCTION 'BAPI_USER_GET_DETAIL'
    EXPORTING
      username      = p_aenam
      cache_results = 'X'
    IMPORTING
      address       = lwa_address
    TABLES
      return        = lit_bapiret2.

  p_department = lwa_address-department.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_CONVERSION_EXIT_ALPHA_INPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LWA_TVARVC_HIGH
*&      <-- LWA_RACCT_HIGH
*&---------------------------------------------------------------------*
FORM f_conversion_exit_alpha_input    USING p_input
                                   CHANGING p_output.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = p_input
    IMPORTING
      output = p_output.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_CONVERSION_EXIT_ALPHA_OUTPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LWA_TVARVC_HIGH
*&      <-- LWA_RACCT_HIGH
*&---------------------------------------------------------------------*
FORM f_conversion_exit_alpha_output    USING p_input
                                    CHANGING p_output.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
    EXPORTING
      input  = p_input
    IMPORTING
      output = p_output.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_GET_FILE_DIR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_P_FILE  text
*----------------------------------------------------------------------*
FORM f_get_file_dir CHANGING p_filepath.

  DATA: ld_user_action TYPE i,
        ld_rc          TYPE i,
        lit_filetable  TYPE filetable,
        lwa_filetable  TYPE LINE OF filetable.

  "*--------------------------------------------------------------------*

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = 'Browse Upload File'
*     file_filter             = '(*.xls)|*.xls|'
      file_filter             = '(*.pdf)|*.pdf|'
      multiselection          = abap_false
      initial_directory       = gc_init_dir
    CHANGING
      file_table              = lit_filetable
      rc                      = ld_rc
      user_action             = ld_user_action
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  IF sy-subrc IS NOT INITIAL.
    "Internal Error Occured.
    MESSAGE s884(88) DISPLAY LIKE fiehc_con_msgty_e.
    RETURN.
  ENDIF.

  IF ld_user_action = cl_gui_frontend_services=>action_cancel.
    "The action was cancelled by the user
    MESSAGE s007(rsoh).
    EXIT.
  ENDIF.

  READ TABLE lit_filetable INTO lwa_filetable INDEX 1.
  IF sy-subrc IS INITIAL.
    p_filepath = lwa_filetable-filename.
  ENDIF.

  CLEAR: ld_user_action,
         ld_rc,
         lit_filetable,
         lwa_filetable.

ENDFORM.                    "f_get_file_dir


*&---------------------------------------------------------------------*
*&      Form  F_CONV_DATE_SAPFORMAT_WITH_SEPARATOR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GWA_EXCEL_RAW_COL4  text
*      -->P_GWA_EXCEL_FIX_VALID_FROM  text
*----------------------------------------------------------------------*
FORM f_conv_date_sapformat_with_sep   USING p_input
                                            p_separator
                                   CHANGING p_output.

  CLEAR p_output.
  "YYYY-MM-DD
  p_output = p_input(4) && p_separator &&
             p_input+4(2) && p_separator &&
             p_input+6(2).

ENDFORM.                    " F_CONV_DATE_SAPFORMAT_WITH_SEPARATOR


*&---------------------------------------------------------------------*
*&      Form  F_CONV_DATE_TO_SAPFORMAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GWA_EXCEL_RAW_COL4  text
*      -->P_GWA_EXCEL_FIX_VALID_FROM  text
*----------------------------------------------------------------------*
FORM f_conv_date_to_sapformat   USING p_input
                             CHANGING p_output.

  "From DD-MM-YYYY To YYYYMMDD

  CLEAR p_output.
  p_output = p_input+6(4) &&
             p_input+3(2) &&
             p_input(2).

ENDFORM.                    " F_CONV_DATE_TO_SAPFORMAT


*&---------------------------------------------------------------------*
*&      Form  f_conv_date_with_separator
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GWA_EXCEL_RAW_COL4  text
*      -->P_GWA_EXCEL_FIX_VALID_FROM  text
*----------------------------------------------------------------------*
FORM f_conv_date_with_separator  USING    p_input
                                          p_separator
                                 CHANGING p_output.

  CLEAR p_output.

  "DD-MM-YYYY
  p_output = p_input+6(2) && p_separator &&
             p_input+4(2) && p_separator &&
             p_input(4).

ENDFORM.                    " f_conv_date_with_separator


*&---------------------------------------------------------------------*
*&      Form  f_conv_time_with_separator
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_SY_UZEIT  text
*      -->P_0225   text
*      <--P_LD_STR_TIME  text
*----------------------------------------------------------------------*
FORM f_conv_time_with_separator  USING p_input
                                       p_separator
                              CHANGING p_output.
  CLEAR p_output.

  "HH-MM-SS
  p_output = p_input(2) && p_separator &&
             p_input+2(2) && p_separator &&
             p_input+4(2).

ENDFORM.                    " f_conv_time_with_separator


FORM f_convert_amount  USING p_kind
                             p_currency
                             p_amount
                    CHANGING p_output.

  DATA: ld_io  TYPE bapicurr-bapicurr.

  "*--------------------------------------------------------------------*

  CLEAR p_output.
  CASE p_kind.
    WHEN 'TO_INTERNAL'.

      ld_io = p_amount.

      CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
        EXPORTING
          currency             = p_currency
          amount_external      = ld_io
          max_number_of_digits = 23
        IMPORTING
          amount_internal      = p_output.

    WHEN 'TO_EXTERNAL'.

      CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_EXTERNAL'
        EXPORTING
          currency        = p_currency
          amount_internal = p_amount
        IMPORTING
          amount_external = ld_io.
      IF sy-subrc EQ 0.
        p_output = ld_io.
      ENDIF.

  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_DATE_TIME
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> SY_DATUM
*&      <-- LD_FILENAME
*&---------------------------------------------------------------------*
FORM f_get_date_time  USING    p_datum
                               p_uzeit
                               p_separator
                      CHANGING p_output.

  DATA: ld_str_date TYPE string,
        ld_str_time TYPE string.

  "*--------------------------------------------------------------------*

  PERFORM f_conv_date_with_separator    USING p_datum
                                              '.'
                                     CHANGING ld_str_date.

  PERFORM f_conv_time_with_separator     USING p_uzeit
                                               '.'
                                      CHANGING ld_str_time.

  p_output = ld_str_date && p_separator && ld_str_time.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_CONVERT_TO_CHAR_AMOUNT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LD_CHAR8
*&      <-- LS_STR_TO_STRC_NILAI_KOMISI_PA
*&---------------------------------------------------------------------*
FORM f_convert_string_to_amount   USING p_input
                               CHANGING p_output.

  DATA: ld_htype TYPE dd01v-datatype.

  "*--------------------------------------------------------------------*

  CLEAR ld_htype.
  CALL FUNCTION 'NUMERIC_CHECK'
    EXPORTING
      string_in = p_input
    IMPORTING
*     STRING_OUT       =
      htype     = ld_htype.
  IF ld_htype NE 'NUMC'.
    DATA(ld_len) = strlen( p_input ) - 1.
    p_output = p_input(ld_len).
  ELSE.
    p_output = p_input.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_DATE_OF_END_MONTH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> S_GJAHR_LOW
*&      --> S_POPER_LOW
*&      <-- GWA_DATA_SUM_FINAL_DATE_OF_END
*&---------------------------------------------------------------------*
FORM f_get_date_of_end_month  USING    p_gjahr
                                       p_poper
                              CHANGING p_end_of_month.

  DATA: ld_datum TYPE sy-datum.

  "*--------------------------------------------------------------------*

  CLEAR ld_datum.
  ld_datum = p_gjahr && p_poper+1(2) && '01'.
  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
    EXPORTING
      day_in            = ld_datum
    IMPORTING
      last_day_of_month = p_end_of_month
    EXCEPTIONS
      day_in_no_date    = 1.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_GET_RB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_get_rb .

  "*--------------------------------------------------------------------*
  "Get Radio Button

  IF rb1 EQ 'X'.
    gd_rb = 'RB1'.
  ELSEIF rb2 EQ 'X'.
    gd_rb = 'RB2'.
  ELSEIF rb3 EQ 'X'.
    gd_rb = 'RB3'.
  ELSEIF rb4 EQ 'X'.
    gd_rb = 'RB4'.

*Unremark this syntax below for your program
*  ELSEIF rb901 EQ 'X'.
*    gd_rb = 'RB901'.

  ENDIF.

  "--------------------------------------------------------------------*

ENDFORM.
