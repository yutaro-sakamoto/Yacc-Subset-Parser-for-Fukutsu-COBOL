start:
  nested_list | TOKEN_EOF
;

nested_list:
  source_element
| nested_list source_element
;

source_element:
  program_definition
| function_definition
;

program_definition:
  identification_division
  environment_division
  data_division
  procedure_division
  nested_prog
  end_program
;

program_mandatory:
  identification_division
  environment_division
  data_division
  procedure_division
  nested_prog
  end_mandatory
;

function_definition:
  function_division
  environment_division
  data_division
  procedure_division
  end_function
;

nested_prog:
| program_mandatory
| nested_prog program_mandatory
;

end_program:
| END_PROGRAM program_name '.'
;

end_mandatory:
  END_PROGRAM program_name '.'
;

end_function:
  END_FUNCTION program_name '.'
;

identification_division:
  PROGRAM_ID '.' program_name as_literal
;

function_division:
  FUNCTION_ID '.' program_name as_literal '.'
;

program_name:
  PROGRAM_NAME
| LITERAL
;

as_literal:
| AS LITERAL
;

program_type:
| _is program_type_clause _program
;

program_type_clause:
  COMMON
| COMMON _init_or_recurs
;

_init_or_recurs:
  TOK_INITIAL
| RECURSIVE
;

environment_division:
| ENVIRONMENT DIVISION '.'
  configuration_section
  input_output_section
;


configuration_section:
| CONFIGURATION SECTION '.'
  configuration_list
;

configuration_list:
| configuration_list configuration_paragraph
;

configuration_paragraph:
  source_computer_paragraph
| object_computer_paragraph
| special_names_paragraph
| repository_paragraph
;

source_computer_paragraph:
  SOURCE_COMPUTER '.' source_computer_entry
;

source_computer_entry:
| computer_name '.'
| computer_name with_debugging_mode '.'
| with_debugging_mode '.'
;

with_debugging_mode:
  _with DEBUGGING MODE
;

computer_name:
  WORD
;

object_computer_paragraph:
  OBJECT_COMPUTER '.' object_computer_entry
;

object_computer_entry:
| computer_name '.'
| computer_name object_clauses_list '.'
| object_clauses_list '.'
;

object_clauses_list:
  object_clauses
| object_clauses_list object_clauses
;

object_clauses:
  object_computer_memory
| object_computer_sequence
| object_computer_segment
;

object_computer_memory:
  MEMORY SIZE _is integer object_char_or_word
;

object_char_or_word:
  CHARACTERS
| WORDS
;

object_computer_sequence:
  _program coll_sequence _is reference
;

object_computer_segment:
  SEGMENT_LIMIT _is integer
;

repository_paragraph:
  REPOSITORY '.' opt_repository
;

opt_repository:
| repository_list '.'
;

repository_list:
  repository_name
| repository_list repository_name
;

repository_name:
  FUNCTION repository_literal_list INTRINSIC
| FUNCTION ALL INTRINSIC
;

repository_literal_list:
  LITERAL
| repository_literal_list
  LITERAL
;


special_names_paragraph:
  SPECIAL_NAMES '.' opt_special_names
;

opt_special_names:
| special_name_list
| special_name_list '.'
;

special_name_list:
  special_name
| special_name_list special_name
;

special_name:
  mnemonic_name_clause
| alphabet_name_clause
| symbolic_characters_clause
| locale_clause
| class_name_clause
| currency_sign_clause
| decimal_point_clause
| cursor_clause
| crt_status_clause
| screen_control
| event_status
;


mnemonic_name_clause:
  WORD _is CRT
| WORD _is undefined_word
  special_name_mnemonic_on_off_list
| WORD _is
  special_name_mnemonic_on_off_list_mandatory
| ARGUMENT_NUMBER _is undefined_word
| ARGUMENT_VALUE _is undefined_word
| ENVIRONMENT_NAME _is undefined_word
| ENVIRONMENT_VALUE _is undefined_word
;

special_name_mnemonic_on_off_list:
| special_name_mnemonic_on_off_list special_name_mnemonic_on_off 
;

special_name_mnemonic_on_off_list_mandatory:
  special_name_mnemonic_on_off 
| special_name_mnemonic_on_off_list_mandatory special_name_mnemonic_on_off 
;

special_name_mnemonic_on_off:
  on_or_off _status _is undefined_word
;

on_or_off:
  ON
| OFF
;

alphabet_name_clause:
  ALPHABET undefined_word
  _is alphabet_definition
;

alphabet_definition:
  NATIVE
| STANDARD_1
| STANDARD_2
| EBCDIC
| alphabet_literal_list
;

alphabet_literal_list:
  alphabet_literal
| alphabet_literal_list
  alphabet_literal
;

alphabet_literal:
  alphabet_lits
| alphabet_lits THRU alphabet_lits
| alphabet_lits ALSO
  alphabet_also_sequence
;

alphabet_also_sequence:
  alphabet_also_literal
| alphabet_also_sequence ALSO alphabet_also_literal
;

alphabet_lits:
  LITERAL
| SPACE
| ZERO
| QUOTE
| HIGH_VALUE
| LOW_VALUE
;

alphabet_also_literal:
  LITERAL
| SPACE
| ZERO
| QUOTE
| HIGH_VALUE
| LOW_VALUE
;

symbolic_characters_clause:
  SYMBOLIC _characters symbolic_characters_list
;

symbolic_characters_list:
  char_list _is_are integer_list
;

char_list:
  undefined_word
| char_list undefined_word
;

integer_list:
  integer
| integer_list integer
;

class_name_clause:
  CLASS undefined_word _is class_item_list
;

class_item_list:
  class_item
| class_item_list class_item
;

class_item:
  basic_value
| basic_value THRU basic_value
;

locale_clause:
  LOCALE undefined_word _is reference
;

currency_sign_clause:
  CURRENCY _sign _is LITERAL
;

decimal_point_clause:
  DECIMAL_POINT _is COMMA
;

cursor_clause:
  CURSOR _is reference
;

crt_status_clause:
  CRT STATUS _is reference
;

screen_control:
  SCREEN_CONTROL _is reference
;

event_status:
  EVENT_STATUS _is reference
;

input_output_section:
| INPUT_OUTPUT SECTION '.'
file_control_paragraph
i_o_control_paragraph
| FILE_CONTROL '.'
file_control_sequence
| I_O_CONTROL '.'
opt_i_o_control
;

file_control_paragraph:
| FILE_CONTROL '.' file_control_sequence
;

file_control_sequence:
| file_control_sequence file_control_entry
;

file_control_entry:
SELECT flag_optional undefined_word
select_clause_sequence '.'
;

select_clause_sequence:
| select_clause_sequence select_clause
;

select_clause:
assign_clause
| access_mode_clause
| alternative_record_key_clause
| collating_sequence_clause
| file_status_clause
| lock_mode_clause
| organization_clause
| padding_character_clause
| record_delimiter_clause
| record_key_clause
| relative_key_clause
| reserve_clause
| sharing_clause
| error
| nominal_key_clause
;

assign_clause:
ASSIGN _to _ext_clause _device assignment_name
| ASSIGN _to _ext_clause DISK
| ASSIGN _to _ext_clause PRINTER
;

_device:
| DISK
| PRINTER
;

_ext_clause:
| EXTERNAL
| DYNAMIC
;

assignment_name:
LITERAL
| DISPLAY
| _literal assignment_device_name_list
;

assignment_device_name_list:
qualified_word
| assignment_device_name_list qualified_word
;

access_mode_clause:
ACCESS _mode _is access_mode
;

access_mode:
SEQUENTIAL
| DYNAMIC
| RANDOM
;

alternative_record_key_clause:
ALTERNATE RECORD _key _is reference flag_duplicates
| ALTERNATE RECORD _key _is reference key_is_eq split_key_list flag_duplicates
;

split_key_list:
split_key
| split_key_list split_key
;

split_key:
reference
;

key_is_eq:
| SOURCE _is
| '='
;

collating_sequence_clause:
coll_sequence _is WORD
;

file_status_clause:
file_or_sort STATUS _is reference opt_reference
;

file_or_sort:
| TOK_FILE
| SORT
;

lock_mode_clause:
LOCK _mode _is lock_mode
;

lock_mode:
MANUAL lock_with
| AUTOMATIC lock_with
| EXCLUSIVE
;

lock_with:
| WITH LOCK ON lock_records
| WITH LOCK ON MULTIPLE lock_records
| WITH ROLLBACK
;

lock_records:
RECORD
| RECORDS
;

organization_clause:
ORGANIZATION _is organization
| organization
;

organization:
INDEXED
| RECORD _binary SEQUENTIAL
| SEQUENTIAL
| RELATIVE
| LINE SEQUENTIAL
;

padding_character_clause:
PADDING _character _is reference_or_literal
;

record_delimiter_clause:
RECORD DELIMITER _is STANDARD_1
;

record_key_clause:
RECORD _key _is reference
| RECORD _key _is reference key_is_eq split_key_list
;

relative_key_clause:
RELATIVE _key _is reference
;

reserve_clause:
RESERVE integer _area
| RESERVE NO
;

sharing_clause:
SHARING _with sharing_option
;

sharing_option:
ALL _other
| NO _other
| READ ONLY
;

nominal_key_clause:
NOMINAL _key _is reference
;

i_o_control_paragraph:
| I_O_CONTROL '.' opt_i_o_control
;

opt_i_o_control:
| i_o_control_list '.'
| i_o_control_list
| apply_clause_list
;

i_o_control_list:
i_o_control_clause
| i_o_control_list i_o_control_clause
;

i_o_control_clause:
same_clause
| multiple_file_tape_clause
;

same_clause:
  SAME same_option _area _for file_name_list
;

same_option:
| RECORD
| SORT
| SORT_MERGE
;

multiple_file_tape_clause:
  MULTIPLE _file _tape _contains multiple_file_list
;

multiple_file_list:
  multiple_file
| multiple_file_list multiple_file
;

multiple_file:
  file_name multiple_file_position
;

multiple_file_position:
| POSITION integer
;

apply_clause_list:
  apply_clause_list '.'
| apply_clause
| apply_clause_list apply_clause
;

apply_clause:
  APPLY COMMITMENT_CONTROL _on reference_list
| APPLY CYL_OVERFLOW _of LITERAL TRACKS ON reference_list
| APPLY CORE_INDEX TO reference ON reference_list
| APPLY FORMS_OVERLAY TO reference ON reference_list
| APPLY CLOSE_NOFEED ON reference_list
;

data_division:
| DATA DIVISION '.'
  file_section
  working_storage_section
  local_storage_section
  linkage_section
  report_section
  screen_section
;

file_section:
| TOK_FILE SECTION '.'
  file_description_sequence
| file_type
  file_description_sequence_without_type
;

file_description_sequence:
| file_description_sequence file_description
;

file_description:
  file_type file_description_entry
  record_description_list
;

file_description_sequence_without_type:
  file_description_entry
  record_description_list
| file_description_sequence_without_type file_description
;

file_type:
  FD
| SD
;

file_description_entry:
  file_name
  file_description_clause_sequence '.'
;

file_description_clause_sequence:
| file_description_clause_sequence file_description_clause
;

file_description_clause:
  _is EXTERNAL
| _is GLOBAL
| block_contains_clause
| record_clause
| label_records_clause
| value_of_clause
| data_records_clause
| linage_clause
| recording_mode_clause
| code_set_clause
| report_clause
| error
;

block_contains_clause:
  BLOCK _contains integer opt_to_integer _records_or_characters
;

_records_or_characters:	| RECORDS | CHARACTERS ;

record_clause:
  RECORD _contains integer _characters
| RECORD _contains integer TO integer _characters
| RECORD _is VARYING _in _size opt_from_integer opt_to_integer _characters
  record_depending
;

record_depending:
| DEPENDING _on reference
;

opt_from_integer:
| _from integer
;

opt_to_integer:
| TO integer
;

label_option:
STANDARD
| OMITTED
;

value_of_clause:
VALUE OF WORD _is valueof_name
| VALUE OF FILE_ID _is valueof_name
;

valueof_name:
LITERAL
| qualified_word
;

data_records_clause:
DATA records no_reference_list
;

linage_clause:
LINAGE _is reference_or_literal _lines linage_sequence
;

linage_sequence:
| linage_sequence linage_lines
;

linage_lines:
linage_footing
| linage_top
| linage_bottom
;

linage_footing:
_with FOOTING _at reference_or_literal _lines
;

linage_top:
_at TOP reference_or_literal _lines
;

linage_bottom:
_at BOTTOM reference_or_literal
;

recording_mode_clause:
RECORDING _mode _is WORD
;

code_set_clause:
CODE_SET _is WORD
;

report_clause:
REPORT _is report_name
| REPORTS _are report_name
;

working_storage_section:
| WORKING_STORAGE SECTION '.' record_description_list
;

record_description_list:
| record_description_list_1
;

record_description_list_1:
record_description_list_2
;

record_description_list_2:
not_const_word data_description
| record_description_list_2 not_const_word data_description
| record_description_list_2 '.'
;

data_description:
constant_entry
| level_number entry_name data_description_clause_sequence _maybe_next_level_number
| level_number_88 entry_name value_cond_clause
;

level_number:
LEVEL_NUMBER_WORD
;

level_number_88:
LEVEL88_NUMBER_WORD
;

_maybe_next_level_number:
| LITERAL
;

entry_name:
| FILLER
| WORD
;

const_name:
WORD
;

const_global:
| _is GLOBAL
;

lit_or_length:
literal
| LENGTH _of identifier_1
| BYTE_LENGTH _of identifier_1
;

constant_entry:
level_number const_name CONSTANT const_global _as lit_or_length
;

data_description_clause_sequence:
| data_description_clause_sequence data_description_clause
;

data_description_clause:
redefines_clause
| external_clause
| global_clause
| picture_clause
| usage_clause
| sign_clause
| occurs_clause
| justified_clause
| synchronized_clause
| blank_clause
| based_clause
| value_clause
| renames_clause
| any_length_clause
| error
;

redefines_clause:
REDEFINES identifier_1
;

external_clause:
_is EXTERNAL as_extname
;

as_extname:
| AS LITERAL
;

global_clause:
_is GLOBAL
;

picture_clause:
PICTURE
;

usage_clause:
usage
| USAGE _is usage
;

usage:
BINARY
| COMP
| COMP_1
| COMP_2
| COMP_3
| COMP_4
| COMP_5
| COMP_X
| DISPLAY
| INDEX
| PACKED_DECIMAL
| POINTER
| PROGRAM_POINTER
| SIGNED_SHORT
| SIGNED_INT
| SIGNED_LONG
| UNSIGNED_SHORT
| UNSIGNED_INT
| UNSIGNED_LONG
| BINARY_CHAR SIGNED
| BINARY_CHAR UNSIGNED
| BINARY_CHAR
| BINARY_SHORT SIGNED
| BINARY_SHORT UNSIGNED
| BINARY_SHORT
| BINARY_LONG SIGNED
| BINARY_LONG UNSIGNED
| BINARY_LONG
| BINARY_DOUBLE SIGNED
| BINARY_DOUBLE UNSIGNED
| BINARY_DOUBLE
| BINARY_C_LONG SIGNED
| BINARY_C_LONG UNSIGNED
| BINARY_C_LONG
| NATIONAL
;

sign_clause:
  _sign_is LEADING flag_separate
| _sign_is TRAILING flag_separate
;

occurs_key_spec:
| occurs_keys _occurs_indexed
| occurs_indexed _occurs_keys
;

occurs_clause:
  OCCURS integer occurs_to_integer _times
  occurs_depending occurs_key_spec
;

occurs_to_integer:
| TO integer
;

occurs_depending:
| DEPENDING _on reference
;

_occurs_keys: | occurs_keys;

occurs_keys:
  occurs_key_list
;

occurs_key:
  ascending_or_descending _key _is reference_list
;

occurs_key_list:
  occurs_key
| occurs_key_list occurs_key
;

ascending_or_descending:
  ASCENDING
| DESCENDING
;

_occurs_indexed: | occurs_indexed;

occurs_indexed:
  INDEXED _by occurs_index_list
;

occurs_index_list:
  occurs_index
| occurs_index_list
  occurs_index
;

occurs_index:
  WORD
;

justified_clause:
  JUSTIFIED _right
;

synchronized_clause:
  SYNCHRONIZED left_or_right
;

left_or_right:
| LEFT
| RIGHT
;

blank_clause:
  BLANK _when ZERO
;

based_clause:
  BASED
;

value_clause:
VALUE _is literal
;

value_cond_clause:
  VALUE _is_are value_item_list
  _when _set _to false_is
;

value_item_list:
  value_item
| value_item_list value_item
;

value_item:
  literal
| literal THRU literal
;

false_is:
| TOK_FALSE _is literal
;

renames_clause:
  RENAMES qualified_word
| RENAMES qualified_word THRU qualified_word
;

any_length_clause:
  ANY LENGTH
;

local_storage_section:
| LOCAL_STORAGE SECTION '.'
  record_description_list
;

linkage_section:
| LINKAGE SECTION '.'
  record_description_list
;

report_section:
| REPORT SECTION '.'
  opt_report_description_list
;

opt_report_description_list:
| report_description_list
;

report_description_list:
  report_description_entry
| report_description_list
  report_description_entry
;

report_description_entry:
  RD report_name
  report_description_options '.'
  report_group_description_list 
;

report_description_options:
| report_description_options report_description_option
;

report_description_option:
  _is GLOBAL
| CODE _is id_or_lit
| control_clause
| page_limit_clause
;

control_clause:
  CONTROL control_field_list
| CONTROLS control_field_list
;

control_field_list:
  _final identifier_list
;

_final:  | FINAL ;
 
identifier_list:
  identifier
| identifier_list identifier
;

page_limit_clause:
  PAGE _is_are page_line_column
  heading_clause first_detail last_heading last_detail footing_clause
;


heading_clause:
| HEADING _is integer
;

first_detail:
| FIRST DETAIL _is integer
;

last_heading:
| LAST CONTROL_HEADING _is integer
;

last_detail:
| LAST_DETAIL _is integer
;

footing_clause:
| FOOTING _is integer
;

page_line_column:
  integer
| integer line_or_lines integer COLUMNS
| integer line_or_lines
;

line_or_lines:
  LINE
| LINES
;

report_group_description_list:
| report_group_description_list report_group_description_entry
; 

report_group_description_entry:
  level_number entry_name
  report_group_options '.'
;

report_group_options:
| report_group_options report_group_option
;

report_group_option:
  type_clause
| next_group_clause
| line_clause
| picture_clause
| usage_clause
| sign_clause
| justified_clause
| column_clause
| blank_clause
| source_clause
| sum_clause_list
| value_clause
| present_when_condition
| group_indicate_clause
| occurs_clause
| varying_clause
;

type_clause:
  TYPE _is type_option
;

type_option:
  REPORT_HEADING
| PAGE_HEADING
| CONTROL_HEADING
| DETAIL
| CONTROL_FOOTING
| PAGE_FOOTING
| REPORT_FOOTING
;

next_group_clause:
  NEXT GROUP _is integer
;

column_clause:
  COLUMN _number _is integer
| COLUMN NUMBERS
| COLUMNS
;

sum_clause_list:
  sum_clause
| sum_clause_list sum_clause
;

sum_clause:
  SUM _of ref_id_exp
;

ref_id_exp:
  reference
;

present_when_condition:
  PRESENT WHEN condition
;

varying_clause:
  VARYING identifier FROM x BY x
;

line_clause:
  line_keyword_clause report_line_integer_list
;

line_keyword_clause:
  LINE _numbers _is_are  
| LINES _are
;

report_line_integer_list:
  line_or_plus
| report_line_integer_list line_or_plus
;

line_or_plus:
  PLUS integer
| integer
| NEXT PAGE
;

_numbers:	| NUMBER | NUMBERS ;

source_clause:
  SOURCE _is identifier flag_rounded
;

group_indicate_clause:
  GROUP _indicate
;

_indicate: | INDICATE ;

report_name:
  WORD 
;

screen_section:
| SCREEN SECTION '.'
  opt_screen_description_list
;

opt_screen_description_list:
| screen_description_list
;

screen_description_list:
  screen_description
| screen_description_list
  screen_description
;

screen_description:
  constant_entry
| level_number entry_name
  screen_options '.'
;

screen_options:
| screen_options screen_option
;

screen_option:
  BLANK_LINE
| BLANK_SCREEN
| BELL
| BLINK
| ERASE EOL
| ERASE EOS
| HIGHLIGHT
| LOWLIGHT
| REVERSE_VIDEO
| UNDERLINE
| OVERLINE
| AUTO
| SECURE
| REQUIRED
| FULL
| PROMPT
| LINE _number _is screen_line_plus_minus num_id_or_lit
| COLUMN _number _is screen_col_plus_minus num_id_or_lit
| FOREGROUND_COLOR _is num_id_or_lit
| BACKGROUND_COLOR _is num_id_or_lit
| usage_clause
| blank_clause
| justified_clause
| sign_clause
| value_clause
| picture_clause
| screen_occurs_clause
| USING identifier
| FROM id_or_lit_or_func
| TO identifier
;

screen_line_plus_minus:
| PLUS
| '+'
| MINUS
| '-'
;

screen_col_plus_minus:
| PLUS
| '+'
| MINUS
| '-'
;


screen_occurs_clause:
  OCCURS integer _times
;

procedure_division:
| PROCEDURE DIVISION procedure_using_chaining procedure_returning '.'
  procedure_declaratives
  procedure_list
;

procedure_using_chaining:
| USING
| CHAINING
;

procedure_param_list:
  procedure_param
| procedure_param_list
  procedure_param
;

procedure_param:
  procedure_type size_optional procedure_optional WORD
;

procedure_type:
| _by REFERENCE
| _by VALUE
;

size_optional:
| SIZE _is AUTO
| SIZE _is DEFAULT
| UNSIGNED SIZE _is integer
| SIZE _is integer
;

procedure_optional:
| OPTIONAL
;

procedure_returning:
| RETURNING WORD
;

procedure_declaratives:
| DECLARATIVES '.'
  procedure_list
  END DECLARATIVES '.'
;

procedure_list:
| procedure_list procedure
;

procedure:
  section_header
| paragraph_header
| invalid_statement
| statements '.'
| error
;

section_header:
  section_name SECTION opt_segment '.'
;

paragraph_header:
  WORD '.'
;

invalid_statement:
  section_name
;

section_name:
  WORD
;

opt_segment:
| LITERAL
;

statement_list:
  statements
;

statements:
| statements statement
;

statement:
  accept_statement
| add_statement
| allocate_statement
| alter_statement
| call_statement
| cancel_statement
| close_statement
| commit_statement
| compute_statement
| continue_statement
| delete_statement
| delete_file_statement
| display_statement
| divide_statement
| entry_statement
| evaluate_statement
| exit_statement
| free_statement
| generate_statement
| goto_statement
| goback_statement
| if_statement
| initialize_statement
| initiate_statement
| inspect_statement
| merge_statement
| move_statement
| multiply_statement
| open_statement
| perform_statement
| read_statement
| release_statement
| return_statement
| rewrite_statement
| rollback_statement
| search_statement
| set_statement
| sort_statement
| start_statement
| stop_statement
| string_statement
| subtract_statement
| suppress_statement
| terminate_statement
| transform_statement
| unlock_statement
| unstring_statement
| use_statement
| write_statement
| NEXT_SENTENCE
;

accept_statement:
  ACCEPT
  accept_body
  end_accept
;

accept_body:
  identifier opt_at_line_column opt_accp_attr on_accp_exception
| identifier FROM ESCAPE KEY
| identifier FROM LINES
| identifier FROM COLUMNS
| identifier FROM DATE
| identifier FROM DATE YYYYMMDD
| identifier FROM DAY
| identifier FROM DAY YYYYDDD
| identifier FROM DAY_OF_WEEK
| identifier FROM TIME
| identifier FROM COMMAND_LINE
| identifier FROM ENVIRONMENT_VALUE on_accp_exception
| identifier FROM ENVIRONMENT simple_value on_accp_exception
| identifier FROM ARGUMENT_NUMBER
| identifier FROM ARGUMENT_VALUE on_accp_exception
| identifier FROM mnemonic_name
| identifier FROM WORD
;

opt_at_line_column:
| _at line_number column_number
| _at column_number line_number
| _at line_number
| _at column_number
| AT simple_value
;

line_number:
  LINE _number id_or_lit
;

column_number:
  COLUMN _number id_or_lit
| POSITION _number id_or_lit
;

opt_accp_attr:
| WITH accp_attrs
;

accp_attrs:
  accp_attr
| accp_attrs accp_attr
;

accp_attr:
  BELL
| BLINK
| HIGHLIGHT
| LOWLIGHT
| REVERSE_VIDEO
| UNDERLINE
| OVERLINE
| FOREGROUND_COLOR _is num_id_or_lit
| BACKGROUND_COLOR _is num_id_or_lit
| SCROLL UP _opt_scroll_lines
| SCROLL DOWN _opt_scroll_lines
| AUTO
| FULL
| REQUIRED
| SECURE
| UPDATE
| PROMPT
;

end_accept:
| END_ACCEPT
;

add_statement:
  ADD
  add_body
  end_add
;

add_body:
  x_list TO arithmetic_x_list on_size_error
| x_list add_to GIVING arithmetic_x_list on_size_error
| CORRESPONDING identifier TO identifier flag_rounded on_size_error
;

add_to:
| TO x
;

end_add:
| END_ADD
;

allocate_statement:
  ALLOCATE
  allocate_body
;

allocate_body:
  WORD flag_initialized allocate_returning
| expr CHARACTERS flag_initialized RETURNING target_x
;

allocate_returning:
| RETURNING target_x
;

alter_statement:
  ALTER alter_options
;

alter_options:
| alter_options
  procedure_name TO _proceed_to procedure_name
;

_proceed_to:	| PROCEED TO ;

call_statement:
  CALL
  id_or_lit_or_func call_using call_returning
  call_on_exception call_not_on_exception
  end_call
;

call_using:
| USING
  call_param_list
;

call_param_list:
  call_param
| call_param_list
  call_param
;

call_param:
  call_type OMITTED
| call_type size_optional x
;

call_type:
| _by REFERENCE
| _by CONTENT
| _by VALUE
;

call_returning:
| RETURNING identifier
| GIVING identifier
;

call_on_exception:
| exception_or_overflow
  statement_list
;

call_not_on_exception:
| not_exception_or_overflow
  statement_list
;

end_call:
| END_CALL
;

cancel_statement:
  CANCEL
  cancel_list
;

cancel_list:
| cancel_list id_or_lit
| ALL
;

close_statement:
  CLOSE
  close_list
;

close_list:
| close_list
  file_name close_option
;

close_option:
| reel_or_unit
| reel_or_unit _for REMOVAL
| _with NO REWIND
| _with LOCK
;

reel_or_unit:	REEL | UNIT ;

compute_statement:
  COMPUTE
  compute_body
  end_compute
;

compute_body:
  arithmetic_x_list comp_equal expr on_size_error
;

end_compute:
| END_COMPUTE
;

comp_equal:	'=' | EQUAL;

commit_statement:
  COMMIT
;

continue_statement:
  CONTINUE
;

delete_statement:
  DELETE
  file_name _record opt_invalid_key
  end_delete
;

end_delete:
| END_DELETE
;

delete_file_statement:
  DELETE
  TOK_FILE file_name_list
;

display_statement:
  DISPLAY
  display_body
  end_display
;

display_body:
  id_or_lit UPON_ENVIRONMENT_NAME on_disp_exception
| id_or_lit UPON_ENVIRONMENT_VALUE on_disp_exception
| id_or_lit UPON_ARGUMENT_NUMBER on_disp_exception
| id_or_lit UPON_COMMAND_LINE on_disp_exception
| x_list opt_at_line_column with_clause on_disp_exception
| x_list opt_at_line_column UPON mnemonic_name with_clause on_disp_exception
| x_list opt_at_line_column UPON WORD with_clause on_disp_exception
| x_list opt_at_line_column UPON PRINTER with_clause on_disp_exception
| x_list opt_at_line_column UPON CRT with_clause on_disp_exception
;

with_clause:
| _with NO_ADVANCING
| WITH disp_attrs
;

disp_attrs:
  disp_attr
| disp_attrs disp_attr
;


disp_attr:
  BELL
| BLINK
| ERASE EOL
| ERASE EOS
| HIGHLIGHT
| LOWLIGHT
| REVERSE_VIDEO
| UNDERLINE
| OVERLINE
| FOREGROUND_COLOR _is num_id_or_lit
| BACKGROUND_COLOR _is num_id_or_lit
| SCROLL UP _opt_scroll_lines
| SCROLL DOWN _opt_scroll_lines
| BLANK_LINE
| BLANK_SCREEN
;

end_display:
| END_DISPLAY
;

divide_statement:
  DIVIDE
  divide_body
  end_divide
;

divide_body:
  x INTO arithmetic_x_list on_size_error
| x INTO x GIVING arithmetic_x_list on_size_error
| x BY x GIVING arithmetic_x_list on_size_error
| x INTO x GIVING arithmetic_x REMAINDER arithmetic_x on_size_error
| x BY x GIVING arithmetic_x REMAINDER arithmetic_x on_size_error
;

end_divide:
| END_DIVIDE
;

entry_statement:
  ENTRY
  LITERAL call_using
;

evaluate_statement:
  EVALUATE
  evaluate_subject_list evaluate_condition_list
  end_evaluate
;

evaluate_subject_list:
  evaluate_subject
| evaluate_subject_list _also
  evaluate_subject
;

evaluate_subject:
  expr
| TOK_TRUE
| TOK_FALSE
;

evaluate_condition_list:
  evaluate_case_list evaluate_other
;

evaluate_case_list:
  evaluate_case
| evaluate_case_list
  evaluate_case
;

evaluate_case:
  evaluate_when_list
  statement_list
;

evaluate_other:
| WHEN_OTHER
  statement_list
;

evaluate_when_list:
  WHEN evaluate_object_list
| evaluate_when_list
  WHEN evaluate_object_list
;

evaluate_object_list:
  evaluate_object
| evaluate_object_list _also
  evaluate_object
;

evaluate_object:
  partial_expr opt_evaluate_thru_expr
| ANY
| TOK_TRUE
| TOK_FALSE
;
opt_evaluate_thru_expr:
| THRU expr
;

end_evaluate:
| END_EVALUATE
;

exit_statement:
  EXIT
  exit_body
;

exit_body:
| PROGRAM
| PERFORM
| PERFORM CYCLE
| SECTION
| PARAGRAPH
;

free_statement:
  FREE
  target_x_list
;

generate_statement:
  GENERATE
  identifier
;

goto_statement:
  GO _to
  procedure_name_list goto_depending
;

goto_depending:
| DEPENDING _on identifier
;

goback_statement:
  GOBACK
;

if_statement:
  IF
  condition _then
  statement_list if_else_sentence
  end_if
| IF error END_IF
;

if_else_sentence:
| ELSE
  statement_list
;

end_if:
| END_IF
;

initialize_statement:
  INITIALIZE
  target_x_list initialize_filler initialize_value initialize_replacing initialize_default
;

initialize_filler:
| _with FILLER
;

initialize_value:
| ALL _to VALUE
| initialize_category _to VALUE
;

initialize_replacing:
| REPLACING
  initialize_replacing_list
;

initialize_replacing_list:
  initialize_replacing_item
| initialize_replacing_list
  initialize_replacing_item
;

initialize_replacing_item:
  initialize_category _data BY x
;

initialize_category:
  ALPHABETIC
| ALPHANUMERIC
| NUMERIC
| ALPHANUMERIC_EDITED
| NUMERIC_EDITED
| NATIONAL
| NATIONAL_EDITED
;

initialize_default:
| DEFAULT
;

initiate_statement:
  INITIATE
  identifier_list
;

inspect_statement:
  INSPECT
  send_identifier inspect_list
;

send_identifier:
  identifier
| literal
| function
;

inspect_list:
  inspect_item
| inspect_list inspect_item
;

inspect_item:
  inspect_tallying
| inspect_replacing
| inspect_converting
;

inspect_tallying:
  TALLYING
  tallying_list
;

tallying_list:
  tallying_item
| tallying_list tallying_item
;

tallying_item:
  simple_value FOR
| CHARACTERS inspect_region
| ALL
| LEADING
| TRAILING
| simple_value inspect_region
;

inspect_replacing:
  REPLACING replacing_list
;

replacing_list:
  replacing_item
| replacing_list replacing_item
;

replacing_item:
  CHARACTERS BY simple_value inspect_region
| rep_keyword replacing_region
;

rep_keyword:
| ALL
| LEADING
| FIRST
| TRAILING
;

replacing_region:
  simple_value BY simple_all_value inspect_region
;

inspect_converting:
  CONVERTING simple_value TO simple_all_value inspect_region
;

inspect_region:
| inspect_region
  before_or_after _initial x
;

_initial:	| TOK_INITIAL ;

merge_statement:
  MERGE
  sort_body
;

move_statement:
  MOVE
  move_body
;

move_body:
  x TO target_x_list
| CORRESPONDING x TO target_x_list
;

multiply_statement:
  MULTIPLY
  multiply_body
  end_multiply
;

multiply_body:
  x BY arithmetic_x_list on_size_error
| x BY x GIVING arithmetic_x_list on_size_error
;

end_multiply:
| END_MULTIPLY
;

open_statement:
  OPEN
  open_list
;

open_list:
| open_list
  open_mode open_sharing file_name_list open_option
;

open_mode:
  INPUT
| OUTPUT
| I_O
| EXTEND
;

open_sharing:
| SHARING _with sharing_option
;

open_option:
| _with NO REWIND
| _with LOCK
;

perform_statement:
  PERFORM
  perform_body
;

perform_body:
  perform_procedure perform_option
| perform_option
  statement_list end_perform
| perform_option END_PERFORM
;

end_perform:
| END_PERFORM
;

perform_procedure:
  procedure_name
| procedure_name THRU procedure_name
;

perform_option:
| FOREVER
| id_or_lit_or_func TIMES
| perform_test UNTIL condition
| perform_test VARYING perform_varying_list
;

perform_test:
| _with TEST before_or_after
;

perform_varying_list:
  perform_varying
| perform_varying_list AFTER
  perform_varying
;

perform_varying:
  identifier FROM x BY x UNTIL condition
;

read_statement:
  READ
  file_name flag_next _record read_into with_lock read_key read_handler
  end_read
;

read_into:
| INTO identifier
;

with_lock:
| IGNORING LOCK
| _with LOCK
| _with NO LOCK
| _with IGNORE LOCK
| _with WAIT
;

read_key:
| KEY _is identifier_list
;

read_handler:
| at_end
| invalid_key
;

end_read:
| END_READ
;

release_statement:
  RELEASE
  record_name write_from
;

return_statement:
  RETURN
  file_name _record read_into at_end
  end_return
;

end_return:
| END_RETURN
;

rewrite_statement:
  REWRITE
  record_name write_from write_lock opt_invalid_key
  end_rewrite
;

write_lock:
| _with LOCK
| _with NO LOCK
;

end_rewrite:
| END_REWRITE
;

rollback_statement:
  ROLLBACK
;

search_statement:
  SEARCH
  search_body
  end_search
;

search_body:
  table_name search_varying search_at_end search_whens
| ALL table_name search_at_end WHEN expr
  statement_list
;

search_varying:
| VARYING identifier
;

search_at_end:
| _at END
  statement_list
;

search_whens:
  search_when
| search_when search_whens
;

search_when:
  WHEN condition
  statement_list
;

end_search:
| END_SEARCH
;

set_statement:
  SET
  set_body
;

set_body:
  set_environment
| set_to
| set_up_down
| set_to_on_off_sequence
| set_to_true_false_sequence
;

set_environment:
  ENVIRONMENT simple_value TO simple_value
;

set_to:
  target_x_list TO ENTRY alnum_or_id
| target_x_list TO x
;

set_up_down:
  target_x_list up_or_down BY x
;

up_or_down:
  UP
| DOWN
;

set_to_on_off_sequence:
  set_to_on_off
| set_to_on_off_sequence set_to_on_off
;

set_to_on_off:
  mnemonic_name_list TO on_or_off
;

set_to_true_false_sequence:
  set_to_true_false
| set_to_true_false_sequence set_to_true_false
;

set_to_true_false:
  target_x_list TO TOK_TRUE
| target_x_list TO TOK_FALSE
;

sort_statement:
  SORT
  sort_body
;

sort_body:
  qualified_word sort_key_list sort_duplicates sort_collating
  sort_input sort_output
;

sort_key_list:
| sort_key_list
  _on ascending_or_descending _key _is opt_key_list
;

opt_key_list:
| opt_key_list qualified_word
;

sort_duplicates:
| with_dups _in_order
;

sort_collating:
| coll_sequence _is reference
;

sort_input:
| USING file_name_list
| INPUT PROCEDURE _is perform_procedure
;

sort_output:
| GIVING file_name_list
| OUTPUT PROCEDURE _is perform_procedure
;

start_statement:
  START
  file_name
  start_key opt_invalid_key
  end_start
;

start_key:
| KEY _is start_op identifier_list
;

start_op:
  flag_not eq
| flag_not gt
| flag_not lt
| flag_not ge
| flag_not le
;

end_start:
| END_START
;

stop_statement:
  STOP RUN
  stop_returning
| STOP LITERAL
;

stop_returning:
| RETURNING x
| GIVING x
;

string_statement:
  STRING
  string_item_list INTO identifier opt_with_pointer on_overflow
  end_string
;

string_item_list:
  string_item
| string_item_list string_item
;

string_item:
  x
| DELIMITED _by SIZE
| DELIMITED _by x
;

opt_with_pointer:
| _with POINTER identifier
;

end_string:
| END_STRING
;

subtract_statement:
  SUBTRACT
  subtract_body
  end_subtract
;

subtract_body:
  x_list FROM arithmetic_x_list on_size_error
| x_list FROM x GIVING arithmetic_x_list on_size_error
| CORRESPONDING identifier FROM identifier flag_rounded on_size_error
;

end_subtract:
| END_SUBTRACT
;

suppress_statement:
  SUPPRESS _printing
;

_printing:
| PRINTING
;

terminate_statement:
  TERMINATE
  identifier_list
;

transform_statement:
  TRANSFORM
  identifier FROM simple_value TO simple_all_value
;

unlock_statement:
  UNLOCK
  file_name opt_record
;

opt_record:
| RECORD
| RECORDS
;


unstring_statement:
  UNSTRING
  identifier unstring_delimited unstring_into
  opt_with_pointer unstring_tallying on_overflow
  end_unstring
;

unstring_delimited:
| DELIMITED _by
  unstring_delimited_list
;

unstring_delimited_list:
  unstring_delimited_item
| unstring_delimited_list OR
  unstring_delimited_item
;

unstring_delimited_item:
  flag_all simple_value
;

unstring_into:
  INTO unstring_into_item
| unstring_into
  unstring_into_item
;

unstring_into_item:
  identifier unstring_into_delimiter unstring_into_count
;

unstring_into_delimiter:
| DELIMITER _in identifier
;

unstring_into_count:
| COUNT _in identifier
;

unstring_tallying:
| TALLYING _in identifier
;

end_unstring:
| END_UNSTRING
;

use_statement:
  use_exception
| use_debugging
| use_reporting
;

use_exception:
  USE
  use_global _after _standard exception_or_error _procedure
  _on use_exception_target
;

use_global:
| GLOBAL
;

use_exception_target:
  file_name_list
| INPUT	
| OUTPUT
| I_O	
| EXTEND
;

_after:
| AFTER
;

_standard:
| STANDARD
;

exception_or_error:
  EXCEPTION | ERROR
;

exception_or_overflow:
  EXCEPTION | OVERFLOW
;

not_exception_or_overflow:
  NOT_EXCEPTION | NOT_OVERFLOW
;

_procedure:
| PROCEDURE
;

use_debugging:
  USE _for DEBUGGING _on use_debugging_target
;

use_debugging_target:
  procedure_name
| ALL PROCEDURES
;

use_reporting:
  USE use_global BEFORE REPORTING identifier
; 

write_statement:
  WRITE
  record_name write_from write_lock write_option write_handler
  end_write
;

write_from:
| FROM id_or_lit
;

write_option:
| before_or_after _advancing num_id_or_lit _line_or_lines
| before_or_after _advancing mnemonic_name
| before_or_after _advancing PAGE
;

before_or_after:
  BEFORE
| AFTER
;

write_handler:
| at_eop
| invalid_key
;

end_write:
| END_WRITE
;

on_accp_exception:
  opt_on_exception
  opt_not_on_exception
;

on_disp_exception:
  opt_on_exception
  opt_not_on_exception
;

opt_on_exception:
| EXCEPTION
  statement_list
;

opt_not_on_exception:
| NOT_EXCEPTION
  statement_list
;

on_size_error:
  opt_on_size_error
  opt_not_on_size_error
;

opt_on_size_error:
| SIZE_ERROR
  statement_list
;

opt_not_on_size_error:
| NOT_SIZE_ERROR
  statement_list
;

on_overflow:
  opt_on_overflow opt_not_on_overflow
;

opt_on_overflow:
| OVERFLOW
  statement_list
;

opt_not_on_overflow:
| NOT_OVERFLOW
  statement_list
;

at_end:
  at_end_sentence
| not_at_end_sentence
| at_end_sentence not_at_end_sentence
;

at_end_sentence:
  END
  statement_list
;

not_at_end_sentence:
  NOT_END
  statement_list
;

at_eop:
  at_eop_sentence
| not_at_eop_sentence
| at_eop_sentence not_at_eop_sentence
;

at_eop_sentence:
  EOP
  statement_list
;

not_at_eop_sentence:
  NOT_EOP
  statement_list
;

opt_invalid_key:
| invalid_key
;

invalid_key:
  invalid_key_sentence
| not_invalid_key_sentence
| invalid_key_sentence not_invalid_key_sentence
;

invalid_key_sentence:
  INVALID_KEY
  statement_list
;

not_invalid_key_sentence:
  NOT_INVALID_KEY
  statement_list
;

_opt_scroll_lines:
| _by num_id_or_lit _line_or_lines
;

condition:
  expr
;

expr:
  partial_expr
;

partial_expr:
  expr_tokens
;

expr_tokens:
  expr_token x
| expr_tokens ')'
| expr_token OMITTED
| expr_token NUMERIC
| expr_token ALPHABETIC
| expr_token ALPHABETIC_LOWER
| expr_token ALPHABETIC_UPPER
| expr_token CLASS_NAME
| expr_tokens OMITTED
| expr_tokens NUMERIC
| expr_tokens ALPHABETIC
| expr_tokens ALPHABETIC_LOWER
| expr_tokens ALPHABETIC_UPPER
| expr_tokens CLASS_NAME
| expr_token POSITIVE
| expr_token NEGATIVE
| expr_tokens POSITIVE
| expr_tokens NEGATIVE
| expr_tokens ZERO
;

expr_token:
| expr_tokens IS
| expr_token IS
| expr_token '('
| expr_token '+'
| expr_token '-'
| expr_token '^'
| expr_token NOT
| expr_tokens NOT
| expr_tokens '+'
| expr_tokens '-'
| expr_tokens '*'
| expr_tokens '/'
| expr_tokens '^'
| expr_tokens eq
| expr_tokens gt
| expr_tokens lt
| expr_tokens ge
| expr_tokens le
| expr_tokens NE
| expr_token eq
| expr_token gt
| expr_token lt
| expr_token ge
| expr_token le
| expr_token NE
| expr_tokens AND
| expr_tokens OR
;

eq:	'=' | EQUAL _to | EQUALS;
gt:	'>' | GREATER _than ;
lt:	'<' | LESS _than ;
ge:	GE | GREATER _than OR EQUAL _to | GREATER _than EQUAL _to ;
le:	LE | LESS _than OR EQUAL _to | LESS _than EQUAL _to ;

exp_list:
  exp
| exp_list e_sep exp
;

e_sep:
| COMMA_DELIM
| SEMI_COLON
;

exp:
  arith_x
| exp '+' exp
| exp '-' exp
| exp '*' exp
| exp '/' exp
| '+' exp
| '-' exp
| exp '^' exp
| '(' exp ')'
;

linage_counter:
  LINAGE_COUNTER
|  LINAGE_COUNTER in_of WORD
;

arithmetic_x_list:
  arithmetic_x
| arithmetic_x_list
  arithmetic_x
;

arithmetic_x:
  x flag_rounded
;

record_name:
  qualified_word
;

table_name:
  qualified_word
;

file_name_list:
  file_name
| file_name_list file_name
;

file_name:
  WORD
;

mnemonic_name_list:
  mnemonic_name
| mnemonic_name_list
  mnemonic_name
;

mnemonic_name:
  MNEMONIC_NAME
;

procedure_name_list:
| procedure_name_list 
  procedure_name
;

procedure_name:
  label
;

label:
  qualified_word
| integer_label
| integer_label in_of integer_label
;

integer_label:
  LITERAL
;

reference_list:
  reference
| reference_list reference
;

reference:
  qualified_word
;

no_reference_list:
  qualified_word
| no_reference_list qualified_word
;

opt_reference:
| reference
;

reference_or_literal:
  reference
| LITERAL
;

undefined_word:
  WORD
;

target_x_list:
  target_x
| target_x_list target_x
;

target_x:
  identifier
| ADDRESS _of identifier_1
;

x_list:
  x
| x_list x
;

x:
  identifier
| LENGTH _of identifier_1
| LENGTH _of basic_literal
| LENGTH _of function
| ADDRESS _of prog_or_entry alnum_or_id
| ADDRESS _of identifier_1
| literal
| function
| linage_counter
;

arith_x:
  identifier
| LENGTH _of identifier_1
| LENGTH _of basic_literal
| LENGTH _of function
| basic_literal
| function
| linage_counter
;

prog_or_entry:
  PROGRAM
| ENTRY
;

alnum_or_id:
  identifier_1
| LITERAL
;

simple_value:
  identifier
| basic_literal
;

simple_all_value:
  identifier
| literal
;

id_or_lit:
  identifier
| LITERAL
;

id_or_lit_or_func:
  identifier
| LITERAL
| function
;

num_id_or_lit:
  identifier
| integer
| ZERO
;

identifier:
  identifier_1
;

identifier_1:
  qualified_word
| qualified_word subref
| qualified_word refmod
| qualified_word subref refmod
;

qualified_word:
  WORD
| WORD in_of qualified_word
;

subref:
  '(' exp_list ')' 
;

refmod:
  '(' exp ':' ')'
| '(' exp ':' exp ')'
;

integer:
  LITERAL
;

literal:
  basic_literal
| ALL basic_value
;

basic_literal:
  basic_value
| basic_literal '&' basic_value
;

basic_value:
  LITERAL
| SPACE
| ZERO
| QUOTE
| HIGH_VALUE
| LOW_VALUE
| TOK_NULL
;

function:
  CURRENT_DATE_FUNC func_refmod
| WHEN_COMPILED_FUNC func_refmod
| UPPER_CASE_FUNC '(' exp ')' func_refmod
| LOWER_CASE_FUNC '(' exp ')' func_refmod
| REVERSE_FUNC '(' exp ')' func_refmod
| CONCATENATE_FUNC '(' exp_list ')' func_refmod
| SUBSTITUTE_FUNC '(' exp_list ')' func_refmod
| SUBSTITUTE_CASE_FUNC '(' exp_list ')' func_refmod
| TRIM_FUNCTION '(' trim_args ')' func_refmod
| NUMVALC_FUNC '(' numvalc_args ')'
| LOCALE_DT_FUNC '(' locale_dt_args ')' func_refmod
| FUNCTION_NAME func_args
;

func_refmod:
| '(' exp ':' ')'
| '(' exp ':' exp ')'
;

func_args:
| '(' list_func_args ')'
;

list_func_args:
| exp_list
;


trim_args:
  exp
| exp e_sep LEADING
| exp e_sep TRAILING
;

numvalc_args:
  exp
| exp e_sep exp
;

locale_dt_args:
  exp
| exp e_sep reference
;

not_const_word:
;

flag_all:
| ALL
;

flag_duplicates:
| with_dups
;

flag_initialized:
| INITIALIZED
;

flag_next:
| NEXT
| PREVIOUS
;

flag_not:
| NOT
;

flag_optional:
| OPTIONAL
;

flag_rounded:
| ROUNDED
;

flag_separate:
| SEPARATE _character
;

in_of:		IN | OF ;
records:	RECORD _is | RECORDS _are ;
with_dups:	WITH DUPLICATES | DUPLICATES ;
coll_sequence:	COLLATING SEQUENCE | SEQUENCE ;

_advancing:	| ADVANCING ;
_also:		| ALSO ;
_are:		| ARE ;
_area:		| AREA ;
_as:		| AS ;
_at:		| AT ;
_binary:	| BINARY ;
_by:		| BY ;
_character:	| CHARACTER ;
_characters:	| CHARACTERS ;
_contains:	| CONTAINS ;
_data:		| DATA ;
_file:		| TOK_FILE ;
_for:		| FOR ;
_from:		| FROM ;
_in:		| IN ;
_is:	 | IS  ;
_is_are:	| IS | ARE ;
_key:		| KEY ;
_line_or_lines:	| LINE | LINES ;
_lines:		| LINES ;
_literal: | LITERAL ;
_mode:		| MODE ;
_number:	| NUMBER ;
_of:		| OF ;
_on:		| ON ;
_in_order:	| ORDER | IN ORDER ;
_other:		| OTHER ;
_program:	| PROGRAM ;
_record:	| RECORD ;
_right:		| RIGHT ;
_set:		| SET ;
_sign:		| SIGN ;
_sign_is:	| SIGN | SIGN IS ;
_size:		| SIZE ;
_status:	| STATUS ;
_tape:		| TAPE ;
_than:		| THAN ;
_then:		| THEN ;
_times:		| TIMES ;
_to:		| TO ;
_when:		| WHEN ;
_with:		| WITH ;