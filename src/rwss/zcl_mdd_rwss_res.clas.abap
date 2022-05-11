class ZCL_MDD_RWSS_RES definition
  public
  inheriting from CL_REST_RESOURCE
  create public .

public section.
protected section.

  methods GET_PARAM
    importing
      !IV_PARAM type DATA
      !IV_DEFAULT type DATA optional
    returning
      value(RV_VALUE) type STRING .
  methods SEND_AS_JSON
    importing
      !IV_PAYLOAD type DATA
      !IV_ERROR_TEXT type STRING optional
      !IV_ERROR_CODE type I optional .
  methods SEND_ERROR .
private section.
ENDCLASS.



CLASS ZCL_MDD_RWSS_RES IMPLEMENTATION.


  method GET_PARAM.
    IF iv_param IS NOT INITIAL.
      rv_value = mo_request->get_uri_attribute( iv_name = CONV string( iv_param ) ).
      IF rv_value IS INITIAL.
        rv_value = iv_default.
      ENDIF.
    ENDIF.
  endmethod.


  method SEND_AS_JSON.

*  transform to json
   data(lv_json) = CL_FDT_JSON=>data_to_json(
       ia_data = iv_payload
   ).


*   fill data
    DATA(lo_entity) = mo_response->create_entity( ).
    lo_entity->set_content_type( if_rest_media_type=>gc_appl_json ).
    lo_entity->set_string_data( lv_json ).

*   response with errors?
    IF iv_error_text IS INITIAL.
      mo_response->set_status( cl_rest_status_code=>gc_success_ok ).
    ELSE.
*   get error code
      DATA(lv_code) = iv_error_code.
      IF lv_code LE 0.
        lv_code = cl_rest_status_code=>gc_client_error_bad_request.
      ENDIF.

*   set error and code
      mo_response->set_status(
        EXPORTING
          iv_status        = lv_code
          iv_reason_phrase = iv_error_text
      ).
    ENDIF.

  endmethod.


  METHOD send_error.

*   fill data
    DATA(lo_entity) = mo_response->create_entity( ).

*   set error and code
    mo_response->set_status(
      EXPORTING
        iv_status        = cl_rest_status_code=>gc_client_error_bad_request
        iv_reason_phrase = 'Bad Request'
    ).

ENDMETHOD.
ENDCLASS.
