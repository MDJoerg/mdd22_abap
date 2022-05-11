@AbapCatalog.sqlViewName: 'ZI_MDDVDMF_FLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Flight Model - Flight Schedule'

define view ZI_MDD_VDMF_FSchedule
  as select from ZP_MDD_VDMF_FSchedule

  association [1]    to ZI_MDD_VDMF_Carrier as _Carrier     on _Carrier.CarrierId = $projection.CarrierId
  association [0..1] to ZI_MDD_VDMF_Airport as _AirportFrom on _AirportFrom.AirportId = $projection.AirportFrom
  association [0..1] to ZI_MDD_VDMF_Airport as _AirportTo   on _AirportTo.AirportId = $projection.AirportTo

{
      // key info + combined info field
  key CarrierId,
  key ConnectionId,
      FlightNumber,
      // departure
      CountryFrom,
      CityFrom,
      AirportFrom,
      DepartureTime,
      // arrival
      CountryTo,
      CityTo,
      AirportTo,
      ArrivalTime,
      DaysLater,
      // flight information
      cast(FlightTime as zmdd_flight_time) as FlightTime,                       // OData Error CONVERSION_EXIT_SDURA_OUTPUT
      DistanceKM,
      FLTP_TO_DEC(DistancePerHour as zmdd_distance_km_per_h) as DistanceKMH,    // Better Output - Float to Dec
      FlightIsCharter,
      // additional Information
      cast(case
        when FlightTime <= 120 then 'S'
        when FlightTime > 360 then 'L'
        else 'M'
        end as zmdd_flight_distance_type)                    as FlightType,     // Special calculation for filtering
      // Associations
      _Carrier,
      _AirportFrom,
      _AirportTo
}
