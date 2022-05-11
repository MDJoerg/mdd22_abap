@AbapCatalog.sqlViewName: 'ZP_MDDVDMF_FSC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Flight Schedule - Private'

@VDM.viewType: #BASIC

define view ZP_MDD_VDMF_FSchedule
  as select from spfli
{
  key carrid                                                           as CarrierId,
  key connid                                                           as ConnectionId,

      // departure from
      countryfr                                                        as CountryFrom,
      cityfrom                                                         as CityFrom,
      airpfrom                                                         as AirportFrom,
      deptime                                                          as DepartureTime,
      // arrival at
      countryto                                                        as CountryTo,
      cityto                                                           as CityTo,
      airpto                                                           as AirportTo,
      arrtime                                                          as ArrivalTime,
      period                                                           as DaysLater,
      // flight infos
      fltime                                                           as FlightTime,
      distance                                                         as Distance,
      distid                                                           as DistanceId,
      fltype                                                           as FlightIsCharter,
      // ---- conversions
      // combined Flight Number
      cast(concat(carrid, connid) as  zmdd_flight_number)              as FlightNumber,
      // calculate distance in KM
      cast(unit_conversion(
                quantity => distance,
                source_unit => distid,
                target_unit => cast('KM' as abap.unit),
                error_handling => 'SET_TO_NULL' ) as zmdd_distance_km) as DistanceKM,
      // calcuate the speed as float
      cast(distance * 60 as abap.fltp) / cast(fltime as abap.fltp)     as DistancePerHour
}
