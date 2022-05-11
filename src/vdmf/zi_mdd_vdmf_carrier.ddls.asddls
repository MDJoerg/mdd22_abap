@AbapCatalog.sqlViewName: 'ZI_MDDVDMF_CAR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Carrier'

@VDM.viewType: #BASIC

define view ZI_MDD_VDMF_Carrier
  as select from scarr
{
  key carrid   as CarrierId,
      carrname as CarrierName,
      currcode as CarrierCurrencyCode,
      url      as CarrierUrl
}
