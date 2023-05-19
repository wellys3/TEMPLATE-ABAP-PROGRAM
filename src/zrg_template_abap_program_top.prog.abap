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
           gc_template_url   TYPE string VALUE '/SAP/PUBLIC/YSD/Template Upload ZRG_TEMPLATE_ABAP_PROGRAM',
           gc_ucomm_download TYPE sy-ucomm VALUE 'FC01',
           gc_filename       TYPE text255 VALUE '',
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
         col1   TYPE  char255,
         col2   TYPE  char255,
         col3   TYPE  char255,
         col4   TYPE  char255,
         col5   TYPE  char255,
         col6   TYPE  char255,
         col7   TYPE  char255,
         col8   TYPE  char255,
         col9   TYPE  char255,
         col10  TYPE  char255,
         col11  TYPE  char255,
         col12  TYPE  char255,
         col13  TYPE  char255,
         col14  TYPE  char255,
         col15  TYPE  char255,
         col16  TYPE  char255,
         col17  TYPE  char255,
         col18  TYPE  char255,
         col19  TYPE  char255,
         col20  TYPE  char255,
         col21  TYPE  char255,
         col22  TYPE  char255,
         col23  TYPE  char255,
         col24  TYPE  char255,
         col25  TYPE  char255,
         col26  TYPE  char255,
         col27  TYPE  char255,
         col28  TYPE  char255,
         col29  TYPE  char255,
         col30  TYPE  char255,
         col31  TYPE  char255,
         col32  TYPE  char255,
         col33  TYPE  char255,
         col34  TYPE  char255,
         col35  TYPE  char255,
         col36  TYPE  char255,
         col37  TYPE  char255,
         col38  TYPE  char255,
         col39  TYPE  char255,
         col40  TYPE  char255,
         col41  TYPE  char255,
         col42  TYPE  char255,
         col43  TYPE  char255,
         col44  TYPE  char255,
         col45  TYPE  char255,
         col46  TYPE  char255,
         col47  TYPE  char255,
         col48  TYPE  char255,
         col49  TYPE  char255,
         col50  TYPE  char255,
         col51  TYPE  char255,
         col52  TYPE  char255,
         col53  TYPE  char255,
         col54  TYPE  char255,
         col55  TYPE  char255,
         col56  TYPE  char255,
         col57  TYPE  char255,
         col58  TYPE  char255,
         col59  TYPE  char255,
         col60  TYPE  char255,
         col61  TYPE  char255,
         col62  TYPE  char255,
         col63  TYPE  char255,
         col64  TYPE  char255,
         col65  TYPE  char255,
         col66  TYPE  char255,
         col67  TYPE  char255,
         col68  TYPE  char255,
         col69  TYPE  char255,
         col70  TYPE  char255,
         col71  TYPE  char255,
         col72  TYPE  char255,
         col73  TYPE  char255,
         col74  TYPE  char255,
         col75  TYPE  char255,
         col76  TYPE  char255,
         col77  TYPE  char255,
         col78  TYPE  char255,
         col79  TYPE  char255,
         col80  TYPE  char255,
         col81  TYPE  char255,
         col82  TYPE  char255,
         col83  TYPE  char255,
         col84  TYPE  char255,
         col85  TYPE  char255,
         col86  TYPE  char255,
         col87  TYPE  char255,
         col88  TYPE  char255,
         col89  TYPE  char255,
         col90  TYPE  char255,
         col91  TYPE  char255,
         col92  TYPE  char255,
         col93  TYPE  char255,
         col94  TYPE  char255,
         col95  TYPE  char255,
         col96  TYPE  char255,
         col97  TYPE  char255,
         col98  TYPE  char255,
         col99  TYPE  char255,
         col100 TYPE  char255,
         col101 TYPE  char255,
         col102 TYPE  char255,
         col103 TYPE  char255,
         col104 TYPE  char255,
         col105 TYPE  char255,
         col106 TYPE  char255,
         col107 TYPE  char255,
         col108 TYPE  char255,
         col109 TYPE  char255,
         col110 TYPE  char255,
         col111 TYPE  char255,
         col112 TYPE  char255,
         col113 TYPE  char255,
         col114 TYPE  char255,
         col115 TYPE  char255,
         col116 TYPE  char255,
         col117 TYPE  char255,
         col118 TYPE  char255,
         col119 TYPE  char255,
         col120 TYPE  char255,
         col121 TYPE  char255,
         col122 TYPE  char255,
         col123 TYPE  char255,
         col124 TYPE  char255,
         col125 TYPE  char255,
         col126 TYPE  char255,
         col127 TYPE  char255,
         col128 TYPE  char255,
         col129 TYPE  char255,
         col130 TYPE  char255,
         col131 TYPE  char255,
         col132 TYPE  char255,
         col133 TYPE  char255,
         col134 TYPE  char255,
         col135 TYPE  char255,
         col136 TYPE  char255,
         col137 TYPE  char255,
         col138 TYPE  char255,
         col139 TYPE  char255,
         col140 TYPE  char255,
         col141 TYPE  char255,
         col142 TYPE  char255,
         col143 TYPE  char255,
         col144 TYPE  char255,
         col145 TYPE  char255,
         col146 TYPE  char255,
         col147 TYPE  char255,
         col148 TYPE  char255,
         col149 TYPE  char255,
         col150 TYPE  char255,
         col151 TYPE  char255,
       END OF gty_excel_raw,

       BEGIN OF gty_data,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF gty_data,

       gtt_excel_raw TYPE TABLE OF gty_excel_raw,
       gtt_data      TYPE TABLE OF gty_data,
       gtt_mara      TYPE TABLE OF mara,
       gtt_makt      TYPE TABLE OF makt.

*--Custom Global Types
TYPES: BEGIN OF gty_excel_fix,
         lights(4) TYPE c,
         zindex    TYPE i,

*         bukrs     TYPE ztbl_fi000000003-bukrs,
*         belnr     TYPE ztbl_fi000000003-belnr,
*         gjahr     TYPE ztbl_fi000000003-gjahr,
*         buzei     TYPE ztbl_fi000000003-buzei,
*         saknr     TYPE ztbl_fi000000003-saknr,
*         waers     TYPE ztbl_fi000000003-waers,

         hsl01     TYPE faglflext-hsl01,
         hsl02     TYPE faglflext-hsl02,
         hsl03     TYPE faglflext-hsl03,
         hsl04     TYPE faglflext-hsl04,
         hsl05     TYPE faglflext-hsl05,
         hsl06     TYPE faglflext-hsl06,
         hsl07     TYPE faglflext-hsl07,
         hsl08     TYPE faglflext-hsl08,
         hsl09     TYPE faglflext-hsl09,
         hsl10     TYPE faglflext-hsl10,
         hsl11     TYPE faglflext-hsl11,
         hsl12     TYPE faglflext-hsl12,

         message   TYPE text255,
       END OF gty_excel_fix,

       gtt_excel_fix TYPE STANDARD TABLE OF gty_excel_fix.
*----------------------------------------------------------------------*
* End - Global Types                                                   *
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Global Variable                                                      *
*----------------------------------------------------------------------*
*---Standard Global Variable
*---Variable Program - Table & Work Area
DATA: git_data TYPE TABLE OF gty_data,
      gwa_data TYPE gty_data,
      git_mara TYPE TABLE OF mara,
      gwa_mara TYPE mara,
      git_makt TYPE TABLE OF makt,
      gwa_makt TYPE makt.

*---Variable Program - Single Value
DATA: gd_tabix     TYPE i,
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
SELECTION-SCREEN BEGIN OF BLOCK a01 WITH FRAME TITLE title001.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb1 RADIOBUTTON GROUP rb USER-COMMAND rad DEFAULT 'X'.
SELECTION-SCREEN COMMENT 4(30) label001.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb2 RADIOBUTTON GROUP rb.
SELECTION-SCREEN COMMENT 4(30) label002.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb3 RADIOBUTTON GROUP rb.
SELECTION-SCREEN COMMENT 4(30) label003.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a01.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE title002.
PARAMETERS: p_file TYPE rlgrap-filename MEMORY ID ysd_filename MODIF ID m01.
SELECTION-SCREEN END OF BLOCK b01.

SELECTION-SCREEN BEGIN OF BLOCK c01 WITH FRAME TITLE title003.
SELECT-OPTIONS: s_bukrs FOR bkpf-bukrs NO-EXTENSION NO INTERVALS MODIF ID m02,
                s_gjahr FOR bkpf-gjahr NO-EXTENSION MODIF ID m02,
                s_belnr FOR bkpf-belnr NO INTERVALS MODIF ID m02,
                s_blart FOR bkpf-blart MODIF ID m02.
SELECTION-SCREEN END OF BLOCK c01.

SELECTION-SCREEN BEGIN OF BLOCK d01 WITH FRAME TITLE title004.
SELECT-OPTIONS: s_matnr FOR mara-matnr MODIF ID m03.
SELECTION-SCREEN END OF BLOCK d01.

SELECTION-SCREEN: FUNCTION KEY 1.
SELECTION-SCREEN: FUNCTION KEY 2.
*----------------------------------------------------------------------*
* End - Selection Screen                                               *
*----------------------------------------------------------------------*
