class ZCL_MDD_ODGW_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
    begin of TS_ZC_MDD_VDMF_FS_GERTYPE.
      include type ZC_MDD_VDMF_FS_GER.
  types:
    end of TS_ZC_MDD_VDMF_FS_GERTYPE .
  types:
   TT_ZC_MDD_VDMF_FS_GERTYPE type standard table of TS_ZC_MDD_VDMF_FS_GERTYPE .
  types:
    begin of TS_ZC_MDD_VDMF_FS_WLDTYPE.
      include type ZC_MDD_VDMF_FS_WLD.
  types:
    end of TS_ZC_MDD_VDMF_FS_WLDTYPE .
  types:
   TT_ZC_MDD_VDMF_FS_WLDTYPE type standard table of TS_ZC_MDD_VDMF_FS_WLDTYPE .
  types:
    begin of TS_ZI_MDD_VDMF_AIRPORTTYPE.
      include type ZI_MDD_VDMF_AIRPORT.
  types:
    end of TS_ZI_MDD_VDMF_AIRPORTTYPE .
  types:
   TT_ZI_MDD_VDMF_AIRPORTTYPE type standard table of TS_ZI_MDD_VDMF_AIRPORTTYPE .
  types:
    begin of TS_ZI_MDD_VDMF_CARRIERTYPE.
      include type ZI_MDD_VDMF_CARRIER.
  types:
    end of TS_ZI_MDD_VDMF_CARRIERTYPE .
  types:
   TT_ZI_MDD_VDMF_CARRIERTYPE type standard table of TS_ZI_MDD_VDMF_CARRIERTYPE .

  constants GC_ZC_MDD_VDMF_FS_GERTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZC_MDD_VDMF_FS_GERType' ##NO_TEXT.
  constants GC_ZC_MDD_VDMF_FS_WLDTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZC_MDD_VDMF_FS_WLDType' ##NO_TEXT.
  constants GC_ZI_MDD_VDMF_AIRPORTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZI_MDD_VDMF_AirportType' ##NO_TEXT.
  constants GC_ZI_MDD_VDMF_CARRIERTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZI_MDD_VDMF_CarrierType' ##NO_TEXT.

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS ZCL_MDD_ODGW_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZMDD_ODGW_SRV' ).

define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    TRY.
        if_sadl_gw_model_exposure_data~get_model_exposure( )->expose( model )->expose_vocabulary( vocab_anno_model ).
      CATCH cx_sadl_exposure_error INTO DATA(lx_sadl_exposure_error).
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_med_exception
          EXPORTING
            previous = lx_sadl_exposure_error.
    ENDTRY.
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20220511092810'.                  "#EC NOTEXT
 DATA: lv_rds_last_modified TYPE timestamp .
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
 lv_rds_last_modified =  GET_LAST_MODIFIED_RDS_4( ).
 IF rv_last_modified LT lv_rds_last_modified.
 rv_last_modified  = lv_rds_last_modified .
 ENDIF .
  endmethod.


  method GET_LAST_MODIFIED_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
*    @@TYPE_SWITCH:
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20220511092811'.
    TRY.
        rv_last_modified_rds = CAST cl_sadl_gw_model_exposure( if_sadl_gw_model_exposure_data~get_model_exposure( ) )->get_last_modified( ).
      CATCH cx_root ##CATCH_ALL.
        rv_last_modified_rds = co_gen_date_time.
    ENDTRY.
    IF rv_last_modified_rds < co_gen_date_time.
      rv_last_modified_rds = co_gen_date_time.
    ENDIF.
  endmethod.


  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20220511092811'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="ZC_MDD_VDMF_FS_GER" binding="ZC_MDD_VDMF_FS_GER" />|  &
               | <sadl:dataSource type="CDS" name="ZC_MDD_VDMF_FS_WLD" binding="ZC_MDD_VDMF_FS_WLD" />|  &
               | <sadl:dataSource type="CDS" name="ZI_MDD_VDMF_AIRPORT" binding="ZI_MDD_VDMF_AIRPORT" />|  &
               | <sadl:dataSource type="CDS" name="ZI_MDD_VDMF_CARRIER" binding="ZI_MDD_VDMF_CARRIER" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="ZC_MDD_VDMF_FS_GER" dataSource="ZC_MDD_VDMF_FS_GER" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_AIRPORTFROM" binding="_AIRPORTFROM" target="ZI_MDD_VDMF_Airport" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_AIRPORTTO" binding="_AIRPORTTO" target="ZI_MDD_VDMF_Airport" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CARRIER" binding="_CARRIER" target="ZI_MDD_VDMF_Carrier" cardinality="zeroToOne" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZC_MDD_VDMF_FS_WLD" dataSource="ZC_MDD_VDMF_FS_WLD" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_AIRPORTFROM" binding="_AIRPORTFROM" target="ZI_MDD_VDMF_Airport" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_AIRPORTTO" binding="_AIRPORTTO" target="ZI_MDD_VDMF_Airport" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CARRIER" binding="_CARRIER" target="ZI_MDD_VDMF_Carrier" cardinality="zeroToOne" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZI_MDD_VDMF_Airport" dataSource="ZI_MDD_VDMF_AIRPORT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZI_MDD_VDMF_Carrier" dataSource="ZI_MDD_VDMF_CARRIER" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'ZMDD_ODGW' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.
