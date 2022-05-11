*&---------------------------------------------------------------------*
*& Report ZMDD_WSPS_AMC_SEND
*&---------------------------------------------------------------------*
*& Magdeburger Development Days 2022 - AMC Demo
*& @MDJoerg 2022
*& Send Messages to external Python WebSocket Listener
*& code used from https://blogs.sap.com/2014/03/26/abap-channels-part-2-publish-subscribe-messaging-using-abap-messaging-channels/
*&---------------------------------------------------------------------*
REPORT zmdd_wsps_amc_send.

PARAMETERS: message TYPE string LOWER CASE DEFAULT 'Hi there !'.
PARAMETERS: consid  TYPE amc_consumer_session_id LOWER CASE.

DATA: lo_producer_text TYPE REF TO if_amc_message_producer_text.
DATA: lx_amc_error       TYPE REF TO cx_amc_error.

TRY.
    IF consid IS INITIAL.
      lo_producer_text ?= cl_amc_channel_manager=>create_message_producer(
          i_application_id = zif_mdd_wsps_c=>c_amc_app
          i_channel_id     = zif_mdd_wsps_c=>c_amc_channel
      ).
    ELSE.
      lo_producer_text ?= cl_amc_channel_manager=>create_message_producer_by_id(
        EXPORTING
          i_application_id = zif_mdd_wsps_c=>c_amc_app
          i_channel_id     = zif_mdd_wsps_c=>c_amc_channel
          i_consumer_session_id  = consid
      ).
    ENDIF.

    " send message to the AMC channel
    lo_producer_text->send( i_message = message ).

  CATCH cx_amc_error INTO lx_amc_error.
    MESSAGE lx_amc_error->get_text( ) TYPE 'E'.
ENDTRY.
