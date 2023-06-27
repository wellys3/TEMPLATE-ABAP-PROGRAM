*&---------------------------------------------------------------------*
*& Include          ZRG_TEMPLATE_ABAP_PROGRAM_TOP
*&---------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Type-Pools                                                           *
*----------------------------------------------------------------------*
*TYPE-POOLS:
*----------------------------------------------------------------------*
* End - Type-Pools                                                     *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Nodes                                                                *
*----------------------------------------------------------------------*
*NODES: peras.
*----------------------------------------------------------------------*
* End - Nodes                                                          *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Infotype
*----------------------------------------------------------------------*
*INFOTYPES: 0000, 0001, 2006 MODE N.
*INFOTYPES: 0000, 0001, 2006.
*----------------------------------------------------------------------*
* End Infotype
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Tables                                                               *
*----------------------------------------------------------------------*
TABLES: sscrfields, bkpf, mara.
*----------------------------------------------------------------------*
* End - Tables                                                         *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Global Constants                                                     *
*----------------------------------------------------------------------*
CONSTANTS: gc_init_dir       TYPE string VALUE '\Desktop',
           gc_template_url   TYPE string VALUE '/SAP/PUBLIC/ZRG_TEMPLATE/Template Upload.xls',
           gc_ucomm_download TYPE sy-ucomm VALUE 'FC01',
           gc_filename       TYPE text255 VALUE 'Template Upload',
           gc_company_name   TYPE text255 VALUE 'PT XXX',
           gc_report_title   TYPE lvc_title VALUE 'ZTemplate ABAP Program by ZRG',
           gc_report_title2  TYPE lvc_title VALUE 'Title XXX'.
*----------------------------------------------------------------------*
* End - Global Constants                                               *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Global Types                                                         *
*----------------------------------------------------------------------*
*---Standard Global Types
*---Excel
TYPES: BEGIN OF gty_excel_raw,
         col1   TYPE  text255,
         col2   TYPE  text255,
         col3   TYPE  text255,
         col4   TYPE  text255,
         col5   TYPE  text255,
         col6   TYPE  text255,
         col7   TYPE  text255,
         col8   TYPE  text255,
         col9   TYPE  text255,
         col10  TYPE  text255,
         col11  TYPE  text255,
         col12  TYPE  text255,
         col13  TYPE  text255,
         col14  TYPE  text255,
         col15  TYPE  text255,
         col16  TYPE  text255,
         col17  TYPE  text255,
         col18  TYPE  text255,
         col19  TYPE  text255,
         col20  TYPE  text255,
         col21  TYPE  text255,
         col22  TYPE  text255,
         col23  TYPE  text255,
         col24  TYPE  text255,
         col25  TYPE  text255,
         col26  TYPE  text255,
         col27  TYPE  text255,
         col28  TYPE  text255,
         col29  TYPE  text255,
         col30  TYPE  text255,
         col31  TYPE  text255,
         col32  TYPE  text255,
         col33  TYPE  text255,
         col34  TYPE  text255,
         col35  TYPE  text255,
         col36  TYPE  text255,
         col37  TYPE  text255,
         col38  TYPE  text255,
         col39  TYPE  text255,
         col40  TYPE  text255,
         col41  TYPE  text255,
         col42  TYPE  text255,
         col43  TYPE  text255,
         col44  TYPE  text255,
         col45  TYPE  text255,
         col46  TYPE  text255,
         col47  TYPE  text255,
         col48  TYPE  text255,
         col49  TYPE  text255,
         col50  TYPE  text255,
         col51  TYPE  text255,
         col52  TYPE  text255,
         col53  TYPE  text255,
         col54  TYPE  text255,
         col55  TYPE  text255,
         col56  TYPE  text255,
         col57  TYPE  text255,
         col58  TYPE  text255,
         col59  TYPE  text255,
         col60  TYPE  text255,
         col61  TYPE  text255,
         col62  TYPE  text255,
         col63  TYPE  text255,
         col64  TYPE  text255,
         col65  TYPE  text255,
         col66  TYPE  text255,
         col67  TYPE  text255,
         col68  TYPE  text255,
         col69  TYPE  text255,
         col70  TYPE  text255,
         col71  TYPE  text255,
         col72  TYPE  text255,
         col73  TYPE  text255,
         col74  TYPE  text255,
         col75  TYPE  text255,
         col76  TYPE  text255,
         col77  TYPE  text255,
         col78  TYPE  text255,
         col79  TYPE  text255,
         col80  TYPE  text255,
         col81  TYPE  text255,
         col82  TYPE  text255,
         col83  TYPE  text255,
         col84  TYPE  text255,
         col85  TYPE  text255,
         col86  TYPE  text255,
         col87  TYPE  text255,
         col88  TYPE  text255,
         col89  TYPE  text255,
         col90  TYPE  text255,
         col91  TYPE  text255,
         col92  TYPE  text255,
         col93  TYPE  text255,
         col94  TYPE  text255,
         col95  TYPE  text255,
         col96  TYPE  text255,
         col97  TYPE  text255,
         col98  TYPE  text255,
         col99  TYPE  text255,
         col100 TYPE  text255,
         col101 TYPE  text255,
         col102 TYPE  text255,
         col103 TYPE  text255,
         col104 TYPE  text255,
         col105 TYPE  text255,
         col106 TYPE  text255,
         col107 TYPE  text255,
         col108 TYPE  text255,
         col109 TYPE  text255,
         col110 TYPE  text255,
         col111 TYPE  text255,
         col112 TYPE  text255,
         col113 TYPE  text255,
         col114 TYPE  text255,
         col115 TYPE  text255,
         col116 TYPE  text255,
         col117 TYPE  text255,
         col118 TYPE  text255,
         col119 TYPE  text255,
         col120 TYPE  text255,
         col121 TYPE  text255,
         col122 TYPE  text255,
         col123 TYPE  text255,
         col124 TYPE  text255,
         col125 TYPE  text255,
         col126 TYPE  text255,
         col127 TYPE  text255,
         col128 TYPE  text255,
         col129 TYPE  text255,
         col130 TYPE  text255,
         col131 TYPE  text255,
         col132 TYPE  text255,
         col133 TYPE  text255,
         col134 TYPE  text255,
         col135 TYPE  text255,
         col136 TYPE  text255,
         col137 TYPE  text255,
         col138 TYPE  text255,
         col139 TYPE  text255,
         col140 TYPE  text255,
         col141 TYPE  text255,
         col142 TYPE  text255,
         col143 TYPE  text255,
         col144 TYPE  text255,
         col145 TYPE  text255,
         col146 TYPE  text255,
         col147 TYPE  text255,
         col148 TYPE  text255,
         col149 TYPE  text255,
         col150 TYPE  text255,
         col151 TYPE  text255,
       END OF gty_excel_raw,

       BEGIN OF gty_excel_fix,
*         lights(4) TYPE c,
*         zindex    TYPE i,

         bukrs TYPE bseg-bukrs,
         belnr TYPE bseg-belnr,
         gjahr TYPE bseg-gjahr,

*         message   TYPE text255,
       END OF gty_excel_fix,

       BEGIN OF gty_mara_makt,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF gty_mara_makt,

       BEGIN OF gty_mara_makt_2,
         select      TYPE bcselect,
         matnr       TYPE mara-matnr,
         maktx       TYPE makt-maktx,
         matnr_maktx TYPE text80,
       END OF gty_mara_makt_2,

       gtt_excel_raw   TYPE TABLE OF gty_excel_raw,
       gtt_excel_fix   TYPE STANDARD TABLE OF gty_excel_fix,
       gtt_mara_makt   TYPE TABLE OF gty_mara_makt,
       gtt_mara_makt_2 TYPE TABLE OF gty_mara_makt_2,
       gtt_mara        TYPE TABLE OF mara,
       gtt_makt        TYPE TABLE OF makt,
       gtt_bkpf        TYPE TABLE OF bkpf.

*--Custom Global Types

*----------------------------------------------------------------------*
* End - Global Types                                                   *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Global Variable                                                      *
*----------------------------------------------------------------------*
*---Standard Global Variable
*---Variable Program - Table & Work Area
DATA: git_mara_makt   TYPE TABLE OF gty_mara_makt,
      gwa_mara_makt   TYPE gty_mara_makt,
      git_mara_makt_2 TYPE TABLE OF gty_mara_makt_2,
      gwa_mara_makt_2 TYPE gty_mara_makt_2,
      git_mara        TYPE TABLE OF mara,
      gwa_mara        TYPE mara,
      git_makt        TYPE TABLE OF makt,
      gwa_makt        TYPE makt,
      git_bkpf        TYPE TABLE OF bkpf,

      git_excel_raw   TYPE TABLE OF gty_excel_raw,
      gwa_excel_raw   TYPE gty_excel_raw,
      git_excel_fix   TYPE TABLE OF gty_excel_fix,
      gwa_excel_fix   TYPE gty_excel_fix.

*---Variable Program - Single Value
DATA: gd_tabix     TYPE sy-tabix,
      gd_index     TYPE sy-index,
      gd_message   TYPE text255,
      gd_answer(1), "Variable for Popup Answer.
      gd_subrc     TYPE sy-subrc,
      gd_rb        TYPE char20.

*---For Debugger
DATA: git_terminal          TYPE TABLE OF tvarvc WITH HEADER LINE,
      gd_opcode_usr_attr(1) TYPE x VALUE 5,
      gd_terminal           TYPE usr41-terminal,
      gd_zdebug             TYPE rvari_val_255,
      gd_flag               TYPE rvari_val_255.

*---For Status Progress
DATA: gd_percent TYPE i,
      gd_lines   TYPE i.

*---Variable Get Execution Time
DATA: gd_start   TYPE p DECIMALS 3,
      gd_stop    TYPE p DECIMALS 3,
      gd_run     TYPE p DECIMALS 3,
      gd_run_str TYPE text255.

*--Excel Multisheet
DATA: gcl_oref_container   TYPE REF TO cl_gui_custom_container,
      gcl_iref_control     TYPE REF TO i_oi_container_control,
      gcl_iref_document    TYPE REF TO i_oi_document_proxy,
      gcl_iref_spreadsheet TYPE REF TO i_oi_spreadsheet,
      gcl_iref_error       TYPE REF TO i_oi_error,

      git_excel_generic    TYPE soi_generic_table,
      gwa_excel_generic    TYPE soi_generic_item,
      git_ranges           TYPE soi_range_list,
      git_sheets           TYPE soi_sheets_table,
      gwa_sheets           TYPE soi_sheets,
      git_rangesdef        TYPE soi_dimension_table,
      gwa_rangesdef        TYPE soi_dimension_item,

      gd_documenturl       TYPE c LENGTH 256,
      gd_retcode           TYPE soi_ret_string,
      gd_has_sheet         TYPE i,
      gd_row_start         TYPE i,   "First row
      gd_row_empty         TYPE i,   "Count of empty rows at the end of block.
      gd_row_end           TYPE i,   "First row
      gd_rows              TYPE i VALUE 100,   "Maximum Rows (Maximum 65536)
      gd_cols              TYPE i VALUE 20,     "Maximum Cols (Maximum 256)
*      gd_col_index(4)      TYPE n,
      gd_col_index         TYPE i,
      gd_col_index_str     TYPE string,
      gd_fieldname         TYPE string.

*---Custom Global Variable
*---Variable Program - Table & Work Area
*DATA: git_data         TYPE TABLE OF xxx,
*      gwa_data         TYPE xxx.
*----------------------------------------------------------------------*
* End - Global Variable                                                *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Define                                                               *
*----------------------------------------------------------------------*
DEFINE f_fill_range.
  &1-sign = &2.
  &1-option = &3.
  &1-low = &4.
  &1-high = &5.
  APPEND &1.
END-OF-DEFINITION.

*--Example
*f_fill_range: lra_lptyp 'I' 'EQ' lwa_lptyp-lptyp ''.
*f_fill_range: lra_lptyp 'I' 'BT' lwa_lptyp-lptyp ''.
*f_fill_range: lra_lptyp 'I' 'CP' lwa_lptyp-lptyp ''.
*----------------------------------------------------------------------*
* End - Define                                                         *
*----------------------------------------------------------------------*

*----------------------------------------------------------------------*
* Selection Screen                                                     *
*----------------------------------------------------------------------*
*Radio Button
SELECTION-SCREEN BEGIN OF BLOCK a01 WITH FRAME TITLE h001.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb1 RADIOBUTTON GROUP rb USER-COMMAND uco DEFAULT 'X'.
SELECTION-SCREEN COMMENT 4(30) h001s001.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb2 RADIOBUTTON GROUP rb.
SELECTION-SCREEN COMMENT 4(30) h001s002.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb3 RADIOBUTTON GROUP rb.
SELECTION-SCREEN COMMENT 4(30) h001s003.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb4 RADIOBUTTON GROUP rb.
SELECTION-SCREEN COMMENT 4(50) h001s004.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a01.

*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE h002.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (31) h002s001 MODIF ID m01.
PARAMETERS: cb_sheet AS CHECKBOX USER-COMMAND u1 MODIF ID m01. "Checkbox Multisheet
SELECTION-SCREEN COMMENT 36(30) h002s002 MODIF ID m01.
SELECTION-SCREEN END OF LINE.

PARAMETERS: p_file TYPE rlgrap-filename MEMORY ID ysd_filename MODIF ID m01.
SELECTION-SCREEN END OF BLOCK b01.

*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK c01 WITH FRAME TITLE h003.
SELECT-OPTIONS: s_bukrs FOR bkpf-bukrs NO-EXTENSION NO INTERVALS MODIF ID m02,
                s_gjahr FOR bkpf-gjahr NO-EXTENSION MODIF ID m02,
                s_belnr FOR bkpf-belnr NO INTERVALS MODIF ID m02,
                s_blart FOR bkpf-blart MODIF ID m02.
SELECTION-SCREEN END OF BLOCK c01.

*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK d01 WITH FRAME TITLE h004.
SELECT-OPTIONS: s_matnr FOR mara-matnr MODIF ID m03.
SELECTION-SCREEN END OF BLOCK d01.

*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK e01 WITH FRAME TITLE h005.
SELECT-OPTIONS: s2_matnr FOR mara-matnr MODIF ID m04.
SELECTION-SCREEN END OF BLOCK e01.

*--------------------------------------------------------------------*

SELECTION-SCREEN: FUNCTION KEY 1.
*SELECTION-SCREEN: FUNCTION KEY 2.
*----------------------------------------------------------------------*
* End - Selection Screen                                               *
*----------------------------------------------------------------------*
