// ---------------------------------------------------------------------
// Behavior Definition: ZI_Travel
// ---------------------------------------------------------------------
// Purpose:
//   Minimal RAP (RESTful ABAP Programming) example based on the
//   classic "Travel" teaching model. Defines create, update, and
//   delete operations plus one validation and one determination.
//
// Demonstrates:
//   - Managed RAP business object basics
//   - Standard operations (create, update, delete)
//   - A validation (business rule check)
//   - A determination (automatic field derivation)
// ---------------------------------------------------------------------
managed implementation in class zbp_i_travel unique;
strict ( 2 );

define behavior for ZI_Travel alias Travel
persistent table ztravel
lock master
authorization master ( instance )
etag master LastChangedAt
{
  create;
  update;
  delete;

  field ( readonly ) TravelId;
  field ( mandatory ) CustomerId, AgencyId, BeginDate, EndDate;

  // Validation: end date must not be before begin date
  validation validateDates on save { create; field BeginDate, EndDate; }

  // Determination: automatically set overall status to "New" on create
  determination setInitialStatus on modify { create; }

  mapping for ztravel
  {
    TravelId      = travel_id;
    AgencyId      = agency_id;
    CustomerId    = customer_id;
    BeginDate     = begin_date;
    EndDate       = end_date;
    OverallStatus = overall_status;
  }
}

// ---------------------------------------------------------------------
// Implementation class ZBP_I_TRAVEL (excerpt)
// ---------------------------------------------------------------------
CLASS zbp_i_travel DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_travel.
ENDCLASS.

CLASS zbp_i_travel IMPLEMENTATION.

  METHOD validateDates.
    LOOP AT travels INTO DATA(travel).
      IF travel-EndDate < travel-BeginDate.
        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                         %msg = new_message( id       = 'ZTRAVEL_MSG'
                                              number   = '001'
                                              severity = if_abap_behv_message=>severity-error ) )
               TO reported-travel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setInitialStatus.
    MODIFY ENTITIES OF zi_travel IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( OverallStatus )
        WITH VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                               OverallStatus = 'N' ) ).
  ENDMETHOD.

ENDCLASS.
