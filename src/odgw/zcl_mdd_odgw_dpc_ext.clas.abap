class ZCL_MDD_ODGW_DPC_EXT definition
  public
  inheriting from ZCL_MDD_ODGW_DPC
  create public .

public section.
protected section.

  methods FLIGHTSCHEDULEWO_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_MDD_ODGW_DPC_EXT IMPLEMENTATION.


  METHOD flightschedulewo_get_entityset.

* ------------------------------------------------------
* WORKAROUND: NO FILTERS, SORTING, ... Available
* ------------------------------------------------------

    SELECT *
      FROM zc_mdd_vdmf_fs_wld
      INTO CORRESPONDING FIELDS OF TABLE @et_entityset.

  ENDMETHOD.
ENDCLASS.
