CLASS zcl_data_insert_ay_u DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_data_insert_ay_u IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT *
        FROM zay_travel_m
        INTO TABLE @DATA(li_travel)
        UP TO 100 ROWS.

    SELECT *
        FROM zay_booking_m
        FOR ALL ENTRIES IN @li_travel
        WHERE travel_id = @li_travel-travel_id
        INTO TABLE @DATA(li_booking).

    SELECT *
        FROM zay_booksupp_m
        FOR ALL ENTRIES IN @li_booking
        WHERE travel_id = @li_booking-travel_id
        AND   booking_id = @li_booking-booking_id
        INTO TABLE @DATA(li_bsup).

     DELETE FROM zay_travel_m.
     DELETE FROM zay_booking_m.
     DELETE FROM zay_booksupp_m.

     COMMIT WORK.

     MODIFY zay_travel_m FROM TABLE @li_travel.
     MODIFY zay_booking_m FROM TABLE @li_booking.
     MODIFY zay_booksupp_m FROM TABLE @li_bsup.

     COMMIT WORK.

     out->write( | Data inserted | ).





  ENDMETHOD.
ENDCLASS.
