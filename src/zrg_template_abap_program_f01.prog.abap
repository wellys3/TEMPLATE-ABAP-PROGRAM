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

      CASE cb_sheet.
        WHEN ''.

          PERFORM f_start_timer.

          PERFORM f_progress_bar_single USING 'Uploading excel, please wait...' 'S' 'S'.

          "Read Excel File.
          PERFORM f_read_excel_data USING p_file
                                 CHANGING git_excel_raw.

          PERFORM f_progress_bar_single USING 'Preparing excel data, please wait...' 'S' 'S'.

          "Preparing Excel Data.
          PERFORM f_preparing_excel_data USING git_excel_raw
                                      CHANGING git_excel_fix.

          PERFORM f_stop_timer.

          "This program sucessfully executed! (Exec. Time & seconds)
          WAIT UP TO 1 SECONDS.
          CLEAR gd_message.
          CONCATENATE 'This program sucessfully executed! (Exec. Time'
                      gd_run_str
                      'seconds)'
            INTO gd_message SEPARATED BY space.
          PERFORM f_progress_bar_single USING gd_message 'S' 'S'.

          IF git_excel_fix[] IS NOT INITIAL.
            PERFORM f_display_data USING git_excel_fix[]
                                         git_bkpf[]
                                         git_mara_makt[]
                                         git_mara_makt_2[].
          ELSE.
            MESSAGE 'No data found' TYPE 'S' DISPLAY LIKE 'W'.
          ENDIF.

        WHEN 'X'.

          PERFORM f_start_timer.

          PERFORM f_progress_bar_single USING 'Uploading excel, please wait...' 'S' 'S'.
          PERFORM f_create_excel_container.
          PERFORM f_open_data_excel USING p_file.

          PERFORM f_progress_bar_single USING 'Preparing excel data, please wait...' 'S' 'S'.
          PERFORM f_read_excel_data_2 CHANGING git_excel_fix[].

          PERFORM f_stop_timer.

          "This program sucessfully executed! (Exec. Time & seconds)
          WAIT UP TO 1 SECONDS.
          CLEAR gd_message.
          CONCATENATE 'This program sucessfully executed! (Exec. Time'
                      gd_run_str
                      'seconds)'
            INTO gd_message SEPARATED BY space.
          PERFORM f_progress_bar_single USING gd_message 'S' 'S'.

          IF git_excel_fix[] IS NOT INITIAL.
            PERFORM f_display_data USING git_excel_fix[]
                                         git_bkpf[]
                                         git_mara_makt[]
                                         git_mara_makt_2[].
          ELSE.
            MESSAGE 'No data found' TYPE 'S' DISPLAY LIKE 'W'.
          ENDIF.

      ENDCASE.

    WHEN 'RB2'.

      PERFORM f_start_timer.

      PERFORM f_get_data CHANGING gd_rb
                                  git_mara
                                  git_makt
                                  git_bkpf.

      PERFORM f_stop_timer.

      "This program sucessfully executed! (Exec. Time & seconds)
      WAIT UP TO 1 SECONDS.
      CLEAR gd_message.
      CONCATENATE 'This program sucessfully executed! (Exec. Time'
                  gd_run_str
                  'seconds)'
        INTO gd_message SEPARATED BY space.
      PERFORM f_progress_bar_single USING gd_message 'S' 'S'.

      IF git_bkpf[] IS NOT INITIAL.
        PERFORM f_display_data USING git_excel_fix[]
                                     git_bkpf[]
                                     git_mara_makt[]
                                     git_mara_makt_2[].
      ELSE.
        MESSAGE 'No data found' TYPE 'S' DISPLAY LIKE 'W'.
      ENDIF.

    WHEN 'RB3'.

      PERFORM f_start_timer.

      PERFORM f_get_data CHANGING gd_rb
                                  git_mara
                                  git_makt
                                  git_bkpf.

      PERFORM f_process_data    USING git_mara
                                      git_makt
                             CHANGING git_mara_makt
                                      git_mara_makt_2.

      PERFORM f_stop_timer.

      "This program sucessfully executed! (Exec. Time & seconds)
      WAIT UP TO 1 SECONDS.
      CLEAR gd_message.
      CONCATENATE 'This program sucessfully executed! (Exec. Time'
                  gd_run_str
                  'seconds)'
        INTO gd_message SEPARATED BY space.
      PERFORM f_progress_bar_single USING gd_message 'S' 'S'.

      IF git_mara_makt[] IS NOT INITIAL.
        PERFORM f_display_data USING git_excel_fix[]
                                     git_bkpf[]
                                     git_mara_makt[]
                                     git_mara_makt_2[].
      ELSE.
        MESSAGE 'No data found' TYPE 'S' DISPLAY LIKE 'W'.
      ENDIF.

    WHEN 'RB4'.

      PERFORM f_start_timer.

      PERFORM f_get_data CHANGING gd_rb
                                  git_mara
                                  git_makt
                                  git_bkpf.

      PERFORM f_process_data    USING git_mara
                                      git_makt
                             CHANGING git_mara_makt
                                      git_mara_makt_2.

      PERFORM f_stop_timer.

      "This program sucessfully executed! (Exec. Time & seconds)
      WAIT UP TO 1 SECONDS.
      CLEAR gd_message.
      CONCATENATE 'This program sucessfully executed! (Exec. Time'
                  gd_run_str
                  'seconds)'
        INTO gd_message SEPARATED BY space.
      PERFORM f_progress_bar_single USING gd_message 'S' 'S'.

      IF git_mara_makt_2[] IS NOT INITIAL.
        PERFORM f_display_data USING git_excel_fix[]
                                     git_bkpf[]
                                     git_mara_makt[]
                                     git_mara_makt_2[].
      ELSE.
        MESSAGE 'No data found' TYPE 'S' DISPLAY LIKE 'W'.
      ENDIF.

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
FORM f_get_data  CHANGING p_rb
                          p_git_mara TYPE gtt_mara
                          p_git_makt TYPE gtt_makt
                          p_git_bkpf TYPE gtt_bkpf.

  CASE p_rb.
    WHEN 'RB2'.

      SELECT * FROM bkpf INTO TABLE p_git_bkpf
        WHERE bukrs IN s_bukrs AND
              belnr IN s_belnr AND
              gjahr IN s_gjahr AND
              blart IN s_blart.

    WHEN 'RB3'.

      SELECT * FROM mara INTO TABLE p_git_mara
        WHERE matnr IN s_matnr.
      SELECT * FROM makt INTO TABLE p_git_makt
        WHERE matnr IN s_matnr.

    WHEN 'RB4'.

      SELECT * FROM mara INTO TABLE p_git_mara
        WHERE matnr IN s_matnr.
      SELECT * FROM makt INTO TABLE p_git_makt
        WHERE matnr IN s_matnr.

  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_READ_EXCEL_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_FILE
*&      <-- GIT_EXCEL_RAW
*&---------------------------------------------------------------------*
FORM f_read_excel_data  USING    p_file
                        CHANGING p_git_excel_raw TYPE gtt_excel_raw.

  DATA: lit_raw_data  TYPE truxs_t_text_data.

  CLEAR p_git_excel_raw[].
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      i_tab_raw_data       = lit_raw_data
      i_filename           = p_file
    TABLES
      i_tab_converted_data = p_git_excel_raw
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    "Error Reading File <File Location>.
    MESSAGE s066(/isdfps/mm) DISPLAY LIKE fiehc_con_msgty_e
                             WITH p_file.
    LEAVE LIST-PROCESSING.
  ENDIF.

  "Delete header & empty row
  DELETE p_git_excel_raw INDEX 1.
  DELETE p_git_excel_raw WHERE col1 IS INITIAL.

  FREE: lit_raw_data.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_CREATE_EXCEL_CONTAINER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_create_excel_container.

  "1. Control Get
  CALL METHOD c_oi_container_control_creator=>get_container_control
    IMPORTING
      control = gcl_iref_control
      error   = gcl_iref_error
      "retcode =
    .

  IF gcl_iref_error->has_failed = 'X'.
    CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
  ENDIF.

  "2. Container Create
  CREATE OBJECT gcl_oref_container
    EXPORTING
      "parent                      =
      container_name              = 'CONT'
      "style                       =
      "lifetime                    = lifetime_default
      "repid                       =
      "dynnr                       =
      "no_autodef_progid_dynnr     =
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  IF sy-subrc <> 0.
    MESSAGE 'Error while opening file' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  "3. Control Init with Container
  CALL METHOD gcl_iref_control->init_control
    EXPORTING
      "dynpro_nr            = SY-DYNNR
      "gui_container        = ' '
      inplace_enabled      = 'X'
      "inplace_mode         = 0
      "inplace_resize_documents = ' '
      "inplace_scroll_documents = ' '
      "inplace_show_toolbars    = 'X'
      "no_flush             = ' '
      "parent_id            = cl_gui_cfw=>dynpro_0
      r3_application_name  = 'EXCEL CONTAINER'
      "register_on_close_event  = ' '
      "register_on_custom_event = ' '
      "rep_id               = SY-REPID
      "shell_style          = 1384185856
      parent               = gcl_oref_container
      "name                 =
      "autoalign            = 'x'
    IMPORTING
      error                = gcl_iref_error
      "retcode              =
    EXCEPTIONS
      javabeannotsupported = 1
      OTHERS               = 2.

  IF gcl_iref_error->has_failed = 'X'.
    CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
  ENDIF.

  "4. Control Get Proxy
  CALL METHOD gcl_iref_control->get_document_proxy
    EXPORTING
      "document_format    = 'NATIVE'
      document_type  = soi_doctype_excel_sheet
      "no_flush       = ' '
      "register_container = ' '
    IMPORTING
      document_proxy = gcl_iref_document
      error          = gcl_iref_error
      "retcode        =
    .

  IF gcl_iref_error->has_failed = 'X'.
    CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_OPEN_DATA_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_open_data_excel USING p_file.

  CONCATENATE 'FILE://' p_file INTO gd_documenturl.

  "5. Document Open
  CALL METHOD gcl_iref_document->open_document
    EXPORTING
      document_title = 'Excel'
      document_url   = gd_documenturl
      "no_flush       = ' '
      open_inplace   = 'X'
      open_readonly  = 'X'
      "protect_document = ' '
      "onsave_macro   = ' '
      "startup_macro  = ''
      "user_info      =
    IMPORTING
      error          = gcl_iref_error
      retcode        = gd_retcode.

  IF gcl_iref_error->has_failed = 'X'.
    CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
  ENDIF.

  "6. Spreadsheet Check Exists
  CALL METHOD gcl_iref_document->has_spreadsheet_interface
    IMPORTING
      error        = gcl_iref_error
      is_available = gd_has_sheet.

  IF gcl_iref_error->has_failed = 'X'.
    CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_READ_EXCEL_DATA_2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_FILE
*&      <-- GIT_EXCEL_RAW
*&---------------------------------------------------------------------*
FORM f_read_excel_data_2 CHANGING p_git_excel_fix TYPE gtt_excel_fix.

  FIELD-SYMBOLS: <lfs_value> TYPE text255 .

*--------------------------------------------------------------------*

  IF gd_has_sheet IS NOT INITIAL.

    "7. Get Spreadsheet
    CALL METHOD gcl_iref_document->get_spreadsheet_interface
      IMPORTING
        error           = gcl_iref_error
        sheet_interface = gcl_iref_spreadsheet.

    IF gcl_iref_error->has_failed = 'X'.
      CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
    ENDIF.

    CALL METHOD gcl_iref_spreadsheet->get_sheets
      EXPORTING
        no_flush = ' '
        "updating = -1
      IMPORTING
        sheets   = git_sheets
        error    = gcl_iref_error.

    IF gcl_iref_error->has_failed = 'X'.
      CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
    ENDIF.
    "7. Dnd Get Spreadsheet

    "8. Data Read
    LOOP AT git_sheets INTO gwa_sheets.

      gd_tabix = sy-tabix.

      CALL METHOD gcl_iref_spreadsheet->select_sheet
        EXPORTING
          name  = gwa_sheets-sheet_name
          "no_flush = ' '
        IMPORTING
          error = gcl_iref_error.

      IF gcl_iref_error->has_failed = 'X'.
        CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
      ENDIF.

      gd_row_start = 1.
      gd_row_empty = 0.
      gd_row_end = gd_rows.

      CLEAR: git_excel_raw[].
      WHILE gd_row_empty < 5. " max empty rows

        "Ranges Create
        CLEAR: gwa_rangesdef, git_rangesdef[].
        gwa_rangesdef-row     = gd_row_start.
        gwa_rangesdef-column  = 1.
        gwa_rangesdef-rows    = gd_row_end.
        gwa_rangesdef-columns = gd_cols.
        APPEND gwa_rangesdef TO git_rangesdef.

        REFRESH git_excel_generic.
        CALL METHOD gcl_iref_spreadsheet->get_ranges_data
          EXPORTING
            "no_flush = ' '
            "all      = 'X'
            "updating = -1
            rangesdef = git_rangesdef
          IMPORTING
            contents  = git_excel_generic
            error     = gcl_iref_error
            "retcode  =
          CHANGING
            ranges    = git_ranges.

        IF gcl_iref_error->has_failed = 'X'.
          CALL METHOD gcl_iref_error->raise_message EXPORTING type = 'E'.
        ENDIF.

        "*--------------------------------------------------------------------*

        "Insert data generic to Excel Raw
        LOOP AT git_excel_generic INTO gwa_excel_generic.

          AT NEW row.
            CLEAR gwa_excel_generic.
          ENDAT.

          gd_col_index = gwa_excel_generic-column.
          gd_col_index_str = gd_col_index. CONDENSE gd_col_index_str.
          CONCATENATE 'COL' gd_col_index_str INTO gd_fieldname.
          ASSIGN COMPONENT gd_fieldname OF STRUCTURE gwa_excel_raw TO <lfs_value>.
          IF sy-subrc EQ 0.
            <lfs_value> = gwa_excel_generic-value.
          ENDIF.

          AT END OF row.
            APPEND gwa_excel_raw TO git_excel_raw.

            IF gwa_excel_raw-col1 EQ space.
              ADD 1 TO gd_row_empty.

              IF gd_row_empty EQ 5.
                EXIT.
              ENDIF.

            ELSE.
              CLEAR gd_row_empty.
            ENDIF.

          ENDAT.

        ENDLOOP.
        "end data takeover

        ADD gd_rows TO gd_row_start.
      ENDWHILE.

      "*--------------------------------------------------------------------*

      "Insert Data from Excel Raw to Excel Fix
      IF git_excel_raw[] IS NOT INITIAL.

        "Delete header & empty row
        DELETE git_excel_raw INDEX 1.
        DELETE git_excel_raw WHERE col1 IS INITIAL.

*        "Data delete empty rows at the end
*        gd_index = lines( git_excel_raw ).
*        WHILE gd_index > 0.
*
*          READ TABLE git_excel_raw INTO gwa_excel_raw INDEX gd_index.
*
*          IF gwa_excel_raw-col1 EQ space.
*            DELETE git_excel_raw INDEX gd_index.
*          ELSE.
*            EXIT.
*          ENDIF.
*
*          SUBTRACT 1 FROM gd_index.
*        ENDWHILE.
*        "End Data delete empty rows at the end

        PERFORM f_break.

        CASE gd_tabix.
          WHEN 1.

            PERFORM f_preparing_excel_data    USING git_excel_raw
                                             CHANGING p_git_excel_fix.

          WHEN 2.

            PERFORM f_preparing_excel_data    USING git_excel_raw
                                             CHANGING p_git_excel_fix.

        ENDCASE.

      ENDIF.
      "End Insert Data from Excel Raw to Excel Fix

*      EXIT. "Remark if you use 1 sheet only
    ENDLOOP.
    "8. End Data Read

  ENDIF.

  "9. Close Document
  gcl_iref_document->close_document(
    EXPORTING
      do_save     = ''
      no_flush    = 'X'
*    IMPORTING
*      error       =
*      has_changed =
*      retcode     =
  ).

  "10. Free Container
  gcl_oref_container->free( ).

ENDFORM.
