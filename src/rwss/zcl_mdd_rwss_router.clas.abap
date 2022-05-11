class ZCL_MDD_RWSS_ROUTER definition
  public
  inheriting from CL_REST_HTTP_HANDLER
  create public .

public section.

  methods IF_REST_APPLICATION~GET_ROOT_HANDLER
    redefinition .
protected section.

  methods HANDLE_CSRF_TOKEN
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_MDD_RWSS_ROUTER IMPLEMENTATION.


  method HANDLE_CSRF_TOKEN.
*CALL METHOD SUPER->HANDLE_CSRF_TOKEN
*  EXPORTING
*    IO_CSRF_HANDLER =
*    IO_REQUEST      =
*    IO_RESPONSE     =
*    .
  endmethod.


  METHOD if_rest_application~get_root_handler.

* -------- costants
    DATA lc_carrier TYPE seoclsname VALUE 'ZCL_MDD_RWSS_RES_CARRIER'.
    DATA lc_airport TYPE seoclsname VALUE 'ZCL_MDD_RWSS_RES_AIRPORT'.
    DATA lc_fls_wld TYPE seoclsname VALUE 'ZCL_MDD_RWSS_RES_FLS_WORLD'.
    DATA lc_fls_ger TYPE seoclsname VALUE 'ZCL_MDD_RWSS_RES_FLS_GER'.

* -------- init
    DATA(lr_router) = NEW cl_rest_router( ).
    ro_root_handler = lr_router.

* -------- add path
* carrier
    lr_router->attach( iv_template = '/Carrier' iv_handler_class = lc_carrier ).
    lr_router->attach( iv_template = '/Carrier/{id}' iv_handler_class = lc_carrier ).

* airport
    lr_router->attach( iv_template = '/Airport' iv_handler_class = lc_airport ).
    lr_router->attach( iv_template = '/Airport/{id}' iv_handler_class = lc_airport ).

* Flight Schedule
* World
    lr_router->attach( iv_template = '/FlightSchedule' iv_handler_class = lc_fls_wld ).
    lr_router->attach( iv_template = '/FlightSchedule/{id}' iv_handler_class = lc_fls_wld ).

* Germany
    lr_router->attach( iv_template = '/FlightSchedule/Germany' iv_handler_class = lc_fls_ger ).
    lr_router->attach( iv_template = '/FlightSchedule/Germany/{id}' iv_handler_class = lc_fls_ger ).

  ENDMETHOD.
ENDCLASS.
