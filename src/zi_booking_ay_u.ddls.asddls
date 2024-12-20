@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Interface for Unmanaged'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    dataClass: #TRANSACTIONAL,
    serviceQuality: #A,
    sizeCategory: #M
}
define view entity ZI_BOOKING_AY_U
  as select from /dmo/booking
  association        to parent ZI_TRAVEL_AY_U as _Travel     on $projection.TravelId = _Travel.TravelId
  association [0..1] to /DMO/I_Customer       as _Customer   on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to /DMO/I_Carrier        as _Carrier    on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection     as _Connection on $projection.ConnectionId = _Connection.ConnectionID
                                                            and $projection.CarrierId = _Connection.AirlineID
                                                            
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
//      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      last_changed_at as LastChangedAt,

      //Parent
      _Travel,

      //Assiciation
      _Customer,
      _Carrier,
      _Connection
}
