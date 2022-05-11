class ZCL_MDD_RWSS_RES_FLS_WORLD definition
  public
  inheriting from ZCL_MDD_RWSS_RES
  create public .

public section.

  methods IF_REST_RESOURCE~GET
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MDD_RWSS_RES_FLS_WORLD IMPLEMENTATION.


  METHOD if_rest_resource~get.

* ------ check params
    DATA(lv_id) = get_param( 'id' ).

* ------ execute request
    IF lv_id IS INITIAL.
* -- set request
      SELECT *
        FROM zc_mdd_vdmf_fs_wld
        INTO TABLE @DATA(lt_data).

      IF lt_data IS NOT INITIAL.
        send_as_json( lt_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ELSE.
* -- single request
      SELECT SINGLE *
        FROM zc_mdd_vdmf_fs_wld
        INTO @DATA(ls_data)
       WHERE flightnumber = @lv_id.

      IF ls_data IS NOT INITIAL.
        send_as_json( ls_data ).
      ELSE.
        send_error( ).
      ENDIF.
    ENDIF.


  ENDMETHOD.
ENDCLASS.
