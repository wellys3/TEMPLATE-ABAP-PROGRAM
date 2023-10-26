*&---------------------------------------------------------------------*
*& Report / Program ZRG_TEMPLATE_ABAP_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


*&-------------------------------------------------------------------*
*& Description : Report Xxx / Program Xxx
*&
*& Module      : Financial Accounting / Material Management / Sales Distribution / XXX
*& Date        : January 1st, 2023
*& Developer   : - your complete name (your email)
*& Functional  : - xxx (xxx.xxx@equine.co.id)
*& FSD Loc.    : - SO2_MIME_REPOSITORY --> SAP --> PUBLIC --> ZFSD
*& FSD         : -
*& Copyright   : © 2023 PT XXX
*&               © 2023 PT XXX
*&
*& Transport Request History (Any changes of TR will be updated here future):
*& *  EQGK****** ABAP1 EG-AB-WSU: zrg_template_abap_program
*& *  Changelog: * Initial Release
*&-------------------------------------------------------------------*


*REPORT ZRG_TEMPLATE_ABAP_PROGRAM.
PROGRAM zrg_template_abap_program.


*--------------------------------------------------------------------*
* Includes                                                           *
*--------------------------------------------------------------------*
INCLUDE: zrg_template_abap_program_top, "Types, Data, Constant Declaration & Selection-Screen.
         zrg_template_abap_program_f00, "Other Function for whole this program
         zrg_template_abap_program_f01, "Get Data
         zrg_template_abap_program_f02, "Process Data
         zrg_template_abap_program_f03. "Display Data
*--------------------------------------------------------------------*
* End - Includes                                                     *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* Initialization                                                     *
*--------------------------------------------------------------------*
INITIALIZATION.
  PERFORM f_initialization.
*--------------------------------------------------------------------*
* End - Initialization                                               *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* Start-of-Selection                                                 *
*--------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM f_break.

  CLEAR gd_subrc.
  PERFORM f_pre_execute CHANGING gd_subrc.
  CHECK gd_subrc EQ 0.

  "*--------------------------------------------------------------------*

  PERFORM f_execute.

END-OF-SELECTION.
*--------------------------------------------------------------------*
* End - Start-of-Selection                                           *
*--------------------------------------------------------------------*


*--------------------------------------------------------------------*
* At-Selection-Screen                                                *
*--------------------------------------------------------------------*
AT SELECTION-SCREEN.
  PERFORM f_download_template.
  PERFORM f_mandatory_validation.

AT SELECTION-SCREEN OUTPUT.
  PERFORM f_modify_screen.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_get_file_dir CHANGING p_file.
*--------------------------------------------------------------------*
* End - At-Selection-Screen                                          *
*--------------------------------------------------------------------*
