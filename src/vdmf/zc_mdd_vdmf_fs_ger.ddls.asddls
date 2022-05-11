@AbapCatalog.sqlViewName: 'ZC_MDDVDMF_FSG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Flight Schedule - Consumption Germany'

@VDM.viewType: #CONSUMPTION
@OData.publish: true

define view ZC_MDD_VDMF_FS_GER 
as select from ZI_MDD_VDMF_FSchedule {
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
where FlightIsCharter <> 'X'
  and ( CountryFrom = 'DE' or CountryTo   = 'DE' )
