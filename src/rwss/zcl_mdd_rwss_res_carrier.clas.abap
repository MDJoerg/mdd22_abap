class ZCL_MDD_RWSS_RES_CARRIER definition
  public
  inheriting from ZCL_MDD_RWSS_RES
  create public .

public section.

  methods IF_REST_RESOURCE~GET
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDD_RWSS_RES_CARRIER IMPLEMENTATION.


  METHOD if_rest_resource~get.

* ------ check params
    DATA(lv_id) = get_param( 'id' ).

* ------ execute request
    IF lv_id IS INITIAL.
* -- set request
      SELECT *
        FROM zi_mdd_vdmf_carrier
        INTO TABLE @DATA(lt_data).

      IF lt_data IS NOT INITIAL.
        send_as_json( lt_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ELSE.
* -- single request
      SELECT SINGLE *
        FROM zi_mdd_vdmf_carrier
        INTO @DATA(ls_data)
       WHERE carrierid = @lv_id.

      IF ls_data IS NOT INITIAL.
        send_as_json( ls_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ENDIF.


  ENDMETHOD.
ENDCLASS.
