class ZCL_MDD_RWSS_RES_AIRPORT definition
  public
  inheriting from ZCL_MDD_RWSS_RES
  create public .

public section.

  methods IF_REST_RESOURCE~GET
    redefinition .
  methods IF_REST_RESOURCE~POST
    redefinition .
  methods IF_REST_RESOURCE~DELETE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDD_RWSS_RES_AIRPORT IMPLEMENTATION.


  METHOD if_rest_resource~delete.
* ------- local data
    DATA: ls_data TYPE sairport.

* ------- check id
    DATA(lv_id) = get_param( 'id' ).
    IF lv_id IS INITIAL
      or not lv_id(1) ca 'ZYX'.
      send_error( ).
    ELSE.
* ------- check existing
      SELECT SINGLE id
        FROM sairport
        INTO ls_data-id
       WHERE id = lv_id.
      IF sy-subrc NE 0.
        send_error( ). " exists
      ELSE.
* -------- create and fill output
*            prepare
        ls_data-mandt = sy-mandt.
        ls_data-id = lv_id.
        IF ls_data-time_zone IS INITIAL.
          ls_data-time_zone = 'UTC'.
        ENDIF.
*            update database
        DELETE from sairport
         WHERE id = lv_id.
        COMMIT WORK.
*            send json output
        send_as_json( ls_data ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD if_rest_resource~get.

* ------ check params
    DATA(lv_id) = get_param( 'id' ).

* ------ execute request
    IF lv_id IS INITIAL.
* -- set request
      SELECT *
        FROM zi_mdd_vdmf_airport
        INTO TABLE @DATA(lt_data).

      IF lt_data IS NOT INITIAL.
        send_as_json( lt_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ELSE.
* -- single request
      SELECT SINGLE *
        FROM zi_mdd_vdmf_airport
        INTO @DATA(ls_data)
       WHERE airportid = @lv_id.

      IF ls_data IS NOT INITIAL.
        send_as_json( ls_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD if_rest_resource~post.
* ------- local data
    DATA: ls_data TYPE sairport.

* ------- check id
    DATA(lv_id) = get_param( 'id' ).
    IF lv_id IS INITIAL.
      send_error( ).
    ELSE.
* ------- check json content
      DATA(lv_json) = io_entity->get_string_data( ).
      IF lv_json IS INITIAL OR lv_json(1) <> '{'.
        send_error( ).
* ------- check json format
      ELSE.
        cl_fdt_json=>json_to_data(
          EXPORTING
            iv_json = lv_json
*         IMPORTING
*           ev_meta =
          CHANGING
            ca_data = ls_data
        ).
        IF ls_data IS INITIAL
          OR ls_data-name IS INITIAL.
          send_error( ).
        ELSE.
* ------- check existing
          SELECT SINGLE id
            FROM sairport
            INTO ls_data-id
           WHERE id = lv_id.
          IF sy-subrc EQ 0.
            send_error( ). " exists
          ELSE.
* -------- create and fill output
*            prepare
            ls_data-mandt = sy-mandt.
            ls_data-id = lv_id.
            IF ls_data-time_zone IS INITIAL.
              ls_data-time_zone = 'UTC'.
            ENDIF.
*            update database
            MODIFY sairport FROM ls_data.
            COMMIT WORK.
*            send json output
            send_as_json( ls_data ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
