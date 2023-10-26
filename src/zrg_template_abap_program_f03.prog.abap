*&---------------------------------------------------------------------*
*& Include          ZRG_TEMPLATE_ABAP_PROGRAM_F03
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Include          ZFI02R0032_F02
*&---------------------------------------------------------------------*
CLASS gcl_falv DEFINITION INHERITING FROM zcl_falv.

  PUBLIC SECTION.

  PROTECTED SECTION.

    "Redefinition of event handler
    METHODS evf_user_command REDEFINITION.
    METHODS evf_top_of_page REDEFINITION.
    METHODS evf_data_changed REDEFINITION.
    METHODS evf_data_changed_finished REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.

CLASS gcl_falv IMPLEMENTATION.

  METHOD evf_user_command.

    CASE e_ucomm.
      WHEN zcl_falv_dynamic_status=>b_01.

        me->check_changed_data( ).

        PERFORM f_exec_button_1 CHANGING git_mara_makt_2[].

        me->layout->set_col_opt( iv_value = 'X' ).
        me->layout->set_cwidth_opt( iv_value = 'X' ).
        me->soft_refresh( ).

      WHEN OTHERS.

        super->evf_user_command( e_ucomm ).

    ENDCASE.

  ENDMETHOD.

  METHOD evf_top_of_page.

    DATA: ld_text TYPE text255.

    "*--------------------------------------------------------------------*

    e_dyndoc_id->add_text( text = gc_company_name
                           sap_emphasis = cl_dd_area=>strong ).

    "*--------------------------------------------------------------------*

    e_dyndoc_id->new_line( repeat = 0 ).

    "*--------------------------------------------------------------------*

    e_dyndoc_id->add_table(
      EXPORTING
        no_of_columns = 2
        border = '0'
      IMPORTING
        table               = DATA(lr_table)
    ).
    lr_table->add_column(
      EXPORTING
        width               = '10%'
      IMPORTING
        column              = DATA(lr_col1)
    ).
    lr_table->add_column(
      EXPORTING
        width               = '70%'
      IMPORTING
        column              = DATA(lr_col2)
    ).

    "*--------------------------------------------------------------------*

    CLEAR ld_text.
    ld_text = gc_report_title.
    lr_col1->add_text( text = 'Program Name:' sap_style = cl_dd_area=>standard ).
    CLEAR ld_text.
    ld_text = gc_report_title.
    lr_col2->add_text( text = ld_text sap_style = cl_dd_area=>standard ).

    "*--------------------------------------------------------------------*

    lr_table->new_row( ).
    CLEAR ld_text.
*    ld_text = gd_run. CONDENSE ld_text.
*    WRITE gd_run TO ld_text. CONDENSE ld_text.
    WRITE gd_run_str TO ld_text. CONDENSE ld_text.
    CONCATENATE ld_text 'seconds' INTO ld_text SEPARATED BY space.
    lr_col1->add_text( text = 'Execution Time:' sap_style = cl_dd_area=>standard ).
    lr_col2->add_text( text = ld_text sap_style = cl_dd_area=>standard ).

    "*--------------------------------------------------------------------*

    lr_table->new_row( ).
    CLEAR ld_text.

    CASE gd_rb.
      WHEN 'RB1'.
        DESCRIBE TABLE git_excel_fix LINES DATA(ld_lines).
      WHEN 'RB2'.
        DESCRIBE TABLE git_bkpf LINES ld_lines.
      WHEN 'RB3'.
        DESCRIBE TABLE git_mara_makt LINES ld_lines.
      WHEN 'RB4'.
        DESCRIBE TABLE git_mara_makt_2 LINES ld_lines.
    ENDCASE.

    WRITE ld_lines TO ld_text. CONDENSE ld_text.
    CONCATENATE ld_text 'row(s)' INTO ld_text SEPARATED BY space.
    lr_col1->add_text( text = 'Total Row(s):' sap_style = cl_dd_area=>standard ).
    lr_col2->add_text( text = ld_text sap_style = cl_dd_area=>standard ).
    CLEAR ld_lines.

    "*--------------------------------------------------------------------*

    e_dyndoc_id->merge_document( ).

  ENDMETHOD.

  METHOD evf_data_changed.

    me->layout->set_col_opt( iv_value = 'X' ).
    me->layout->set_cwidth_opt( iv_value = 'X' ).
    me->soft_refresh( ).

  ENDMETHOD.

  METHOD evf_data_changed_finished.

    IF e_modified EQ 'X'.
      me->layout->set_col_opt( iv_value = 'X' ).
      me->layout->set_cwidth_opt( iv_value = 'X' ).
      me->soft_refresh( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.


*&---------------------------------------------------------------------*
*& Form F_DISPLAY_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GIT_DATA
*&---------------------------------------------------------------------*
FORM f_display_data USING p_git_excel_fix TYPE gtt_excel_fix
                          p_git_bkpf TYPE gtt_bkpf
                          p_git_mara_makt TYPE gtt_mara_makt
                          p_git_mara_makt_2 TYPE gtt_mara_makt_2.

  "FALV Creation with only table passed
  "DATA(falv) = zcl_falv=>create( CHANGING ct_table = p_git_data ).

  "Creation of falv with local redefinition
  DATA lcl_falv TYPE REF TO gcl_falv.

  CASE gd_rb.
    WHEN 'RB1'.

      lcl_falv ?= gcl_falv=>create( EXPORTING  i_subclass = cl_abap_classdescr=>describe_by_name( p_name = 'GCL_FALV' )
                                    CHANGING ct_table = p_git_excel_fix ) .

      "Add title variable
      lcl_falv->title_v1 = gc_report_title.

      "Set checkbox
      "lcl_falv->set_mark_field( 'SELECT' ). "Set column as mark field
      "lcl_falv->column( 'SELECT' )->set_edit( abap_true ). "Set column editable
      "lcl_falv->column( 'SELECT' )->set_col_opt( iv_value = 'X' ). "Set column optimization

      "Set hotspot
      "lcl_falv->column( 'XXX' )->set_hotspot( 'X' ). "Set hotspot

      "Set editable
      "lcl_falv->column( 'MATNR_MAKTX' )->set_edit( abap_true ). "Set column editable

      "Set layout
      lcl_falv->layout->set_zebra( iv_value = 'X' ). "Set zebra
      lcl_falv->layout->set_col_opt( iv_value = 'X' ). "Set column optimization
      lcl_falv->layout->set_cwidth_opt( iv_value = 'X' ). "Set column width optimization
      lcl_falv->layout->set_totals_bef( 'X' ). "Sum on Top
      lcl_falv->layout->set_sel_mode( 'A' ). "Set selection mode

      "Set Gui status to fully dynamic (no standard buttons of ALV Grid)
      "lcl_falv->gui_status->fully_dynamic = abap_true.

      "Modify field
      PERFORM f_modify_field USING lcl_falv.

      "Add button
      PERFORM f_add_button USING lcl_falv.

      "Change grid to edit mode
      "lcl_falv->set_editable( iv_modify = 'X' ).

      "Set size top of page
      lcl_falv->top_of_page_height = 75.

      "Display full screen grid
      lcl_falv->show_top_of_page( )->display( ).

    WHEN 'RB2'.

      lcl_falv ?= gcl_falv=>create( EXPORTING  i_subclass = cl_abap_classdescr=>describe_by_name( p_name = 'GCL_FALV' )
                                    CHANGING ct_table = p_git_bkpf ) .

      "Add title variable
      lcl_falv->title_v1 = gc_report_title.

      "Set checkbox
      "lcl_falv->set_mark_field( 'SELECT' ). "Set column as mark field
      "lcl_falv->column( 'SELECT' )->set_edit( abap_true ). "Set column editable
      "lcl_falv->column( 'SELECT' )->set_col_opt( iv_value = 'X' ). "Set column optimization

      "Set hotspot
      "lcl_falv->column( 'XXX' )->set_hotspot( 'X' ). "Set hotspot

      "Set editable
      "lcl_falv->column( 'MATNR_MAKTX' )->set_edit( abap_true ). "Set column editable

      "Set zebra
      lcl_falv->layout->set_zebra( iv_value = 'X' ). "Set zebra
      lcl_falv->layout->set_col_opt( iv_value = 'X' ). "Set column optimization
      lcl_falv->layout->set_cwidth_opt( iv_value = 'X' ). "Set column width optimization
      lcl_falv->layout->set_totals_bef( 'X' ). "Sum on Top
      lcl_falv->layout->set_sel_mode( 'A' ). "Set selection mode

      "Set Gui status to fully dynamic (no standard buttons of ALV Grid)
      "lcl_falv->gui_status->fully_dynamic = abap_true.

      "Modify field
      PERFORM f_modify_field USING lcl_falv.

      "Add button
      PERFORM f_add_button USING lcl_falv.

      "Change grid to edit mode
      "lcl_falv->set_editable( iv_modify = 'X' ).

      "Set size top of page
      lcl_falv->top_of_page_height = 75.

      "Display full screen grid
      lcl_falv->show_top_of_page( )->display( ).

    WHEN 'RB3'.

      lcl_falv ?= gcl_falv=>create( EXPORTING  i_subclass = cl_abap_classdescr=>describe_by_name( p_name = 'GCL_FALV' )
                                    CHANGING ct_table = p_git_mara_makt ) .

      "Add title variable
      lcl_falv->title_v1 = gc_report_title.

      "Set checkbox
      "lcl_falv->set_mark_field( 'SELECT' ). "Set column as mark field
      "lcl_falv->column( 'SELECT' )->set_edit( abap_true ). "Set column editable
      "lcl_falv->column( 'SELECT' )->set_col_opt( iv_value = 'X' ). "Set column optimization

      "Set hotspot
      "lcl_falv->column( 'XXX' )->set_hotspot( 'X' ). "Set hotspot

      "Set editable
      "lcl_falv->column( 'MATNR_MAKTX' )->set_edit( abap_true ). "Set column editable

      "Set layout
      lcl_falv->layout->set_zebra( iv_value = 'X' ). "Set zebra
      lcl_falv->layout->set_col_opt( iv_value = 'X' ). "Set column optimization
      lcl_falv->layout->set_cwidth_opt( iv_value = 'X' ). "Set column width optimization
      lcl_falv->layout->set_totals_bef( 'X' ). "Sum on Top
      lcl_falv->layout->set_sel_mode( 'A' ). "Set selection mode

      "Set Gui status to fully dynamic (no standard buttons of ALV Grid)
      "lcl_falv->gui_status->fully_dynamic = abap_true.

      "Modify field
      PERFORM f_modify_field USING lcl_falv.

      "Add button
      PERFORM f_add_button USING lcl_falv.

      "Change grid to edit mode
      "lcl_falv->set_editable( iv_modify = 'X' ).

      "Set size top of page
      lcl_falv->top_of_page_height = 75.

      "Display full screen grid
      lcl_falv->show_top_of_page( )->display( ).

    WHEN 'RB4'.

      lcl_falv ?= gcl_falv=>create( EXPORTING  i_subclass = cl_abap_classdescr=>describe_by_name( p_name = 'GCL_FALV' )
                                    CHANGING ct_table = p_git_mara_makt_2 ) .

      "Add title variable
      lcl_falv->title_v1 = gc_report_title.

      "Set checkbox
      lcl_falv->set_mark_field( 'SELECT' ). "Set column as mark field
      lcl_falv->column( 'SELECT' )->set_edit( abap_true ). "Set column editable
      lcl_falv->column( 'SELECT' )->set_col_opt( iv_value = 'X' ). "Set column optimization

      "Set hotspot
      "lcl_falv->column( 'XXX' )->set_hotspot( 'X' ). "Set hotspot

      "Set editable
      lcl_falv->column( 'MATNR_MAKTX' )->set_edit( abap_true ). "Set column editable

      "Set layout
      lcl_falv->layout->set_zebra( iv_value = 'X' ). "Set zebra
      lcl_falv->layout->set_col_opt( iv_value = 'X' ). "Set column optimization
      lcl_falv->layout->set_cwidth_opt( iv_value = 'X' ). "Set column width optimization
      lcl_falv->layout->set_totals_bef( 'X' ). "Sum on Top
      lcl_falv->layout->set_sel_mode( 'A' ). "Set selection mode

      "Set Gui status to fully dynamic (no standard buttons of ALV Grid)
      "lcl_falv->gui_status->fully_dynamic = abap_true.

      "Modify field
      PERFORM f_modify_field USING lcl_falv.

      "Add button
      PERFORM f_add_button USING lcl_falv.

      "Change grid to edit mode
      lcl_falv->set_editable( iv_modify = 'X' ).

      "Set size top of page
      lcl_falv->top_of_page_height = 75.

      "Display full screen grid
      lcl_falv->show_top_of_page( )->display( ).

  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_MODIFY_FIELD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> FALV
*&---------------------------------------------------------------------*
FORM f_modify_field USING p_me TYPE REF TO gcl_falv.

*Reference
*  p_me->column( 'XXX' )->set_no_out( 'X' ). "Hide or not column
*  p_me->column( 'XXX' )->set_key( '' ). "Remove or not key column form dictionary
*  p_me->column( 'XXX' )->set_fix_column( iv_value = '' ). "Remove or not fix column
*  p_me->column( 'XXX' )->set_col_pos( '01' ). "Set column position with specific sort number
*  p_me->column( 'XXX' )->set_cfieldname( 'YYY' ). "Set this column to refer with currency field
*  p_me->column( 'XXX' )->set_qfieldname( 'YYY' ). "Set this column to refer with quantity field
*  p_me->column( 'XXX' )->set_reptext( 'Your description' ). "Set heading column label
*  p_me->column( 'XXX' )->set_scrtext_s( 'Your description' ). "Set short column label
*  p_me->column( 'XXX' )->set_scrtext_m( 'Your description' ). "Set medium column label
*  p_me->column( 'XXX' )->set_scrtext_l( 'Your description' ). "Set long column label
*  p_me->column( 'XXX' )->set_ref_table( 'XXX' ). "Set reference table
*  p_me->column( 'XXX' )->set_ref_field( 'XXX' ). "Set reference field

  "*--------------------------------------------------------------------*

  DATA: lit_sort TYPE lvc_t_sort,
        lwa_sort TYPE lvc_s_sort.

  "*--------------------------------------------------------------------*

*  CLEAR lit_sort[].
  CASE gd_rb.
    WHEN 'RB1'.

    WHEN 'RB2'.

*      CLEAR lwa_sort.
*      lwa_sort-spos = 1.
*      lwa_sort-fieldname = 'TABNAME'.
*      lwa_sort-subtot = 'X'.
*      APPEND lwa_sort TO lit_sort.
*      p_me->sort = lit_sort[].

    WHEN 'RB3'.


    WHEN 'RB4'.

*      p_me->column( 'MATNR_MAKTX' )->set_key( '' ).
*      p_me->column( 'MANDT' )->set_no_out( 'X' ).

      p_me->column( 'MATNR_MAKTX' )->set_reptext( 'Combine MATNR & MAKTX' ).
      p_me->column( 'MATNR_MAKTX' )->set_scrtext_s( 'Combine' ).
      p_me->column( 'MATNR_MAKTX' )->set_scrtext_m( 'Combine' ).
      p_me->column( 'MATNR_MAKTX' )->set_scrtext_l( 'Combine MATNR & MAKTX' ).

  ENDCASE.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form F_ADD_BUTTON
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> FALV
*&---------------------------------------------------------------------*
FORM f_add_button USING p_me TYPE REF TO gcl_falv.

  CASE gd_rb.
    WHEN 'RB1'.

    WHEN 'RB2'.

    WHEN 'RB3'.

    WHEN 'RB4'.

      p_me->gui_status->add_button(
        EXPORTING
          iv_button              = zcl_falv_dynamic_status=>b_01
          iv_text                = 'Button 1'
          iv_icon                = icon_system_save
          iv_qinfo               = 'Button 1'
        EXCEPTIONS
          button_already_filled  = 1
          button_does_not_exists = 2
          icon_and_text_empty    = 3
          OTHERS                 = 4
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

  ENDCASE.

ENDFORM.
