@AbapCatalog.sqlViewName: 'ZC_MDDVDMF_FSW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Flight Schedule - Consumption World'

@VDM.viewType: #CONSUMPTION
@OData.publish: true

define view ZC_MDD_VDMF_FS_WLD 
as select from ZI_MDD_VDMF_FSchedule 
{
      //key CarrierId,
      //key ConnectionId,
  key FlightNumber,
      CarrierId,
      ConnectionId,
      CountryFrom,
      CityFrom,
      AirportFrom,
      DepartureTime,
      CountryTo,
      CityTo,
      AirportTo,
      ArrivalTime,
      DaysLater,
      FlightTime,
      DistanceKM,
      DistanceKMH,
      FlightIsCharter,
      FlightType,
      /* Associations */
      _AirportFrom,
      _AirportTo,
      _Carrier

    
}
