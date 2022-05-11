@AbapCatalog.sqlViewName: 'ZI_MDDVDMF_APT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Airport'


@VDM.viewType: #BASIC

define view ZI_MDD_VDMF_Airport
  as select from sairport
{
  key id        as AirportId,
      name      as AirportName,
      time_zone as AirportTimeZone
}
