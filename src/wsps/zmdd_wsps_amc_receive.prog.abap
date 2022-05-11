*&---------------------------------------------------------------------*
*& Report ZMDD_WSPS_AMC_RECEIVE
*&---------------------------------------------------------------------*
*& Magdeburger Development Days 2022 - AMC Demo
*& @MDJoerg 2022
*& Receive Messages from APC - e.g. from external Python WebSocket Listener
*& code used from https://blogs.sap.com/2014/03/26/abap-channels-part-2-publish-subscribe-messaging-using-abap-messaging-channels/
*&---------------------------------------------------------------------*
REPORT zmdd_wsps_amc_receive.

PARAMETERS: msg_nr   TYPE i DEFAULT 1, "number of expected messages
            wait_sec TYPE i DEFAULT 20.            "waiting time to

DATA: lo_consumer       TYPE REF TO if_amc_message_consumer.
DATA: gt_message_list TYPE TABLE OF string.
DATA: lv_message          TYPE string.
DATA: lx_amc_error         TYPE REF TO cx_amc_error.

* implemenation class for AMC receiver interface
CLASS lcl_amc_test_text DEFINITION
FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* interface for AMC messages of type TEXT
    INTERFACES if_amc_message_receiver_text .
ENDCLASS.

* Consumer test for ABAP Messaging Channel YAMC_TEST”
CLASS lcl_amc_test_text IMPLEMENTATION.
  METHOD if_amc_message_receiver_text~receive.
*
* remark: in this method should the message be received and  the main actions
* should be processed in the main program and  usually after WAIT statement.
* Any kind of communication, e.g. RFCs, HTTP and message hanlding,

* e.g. error message is not supported and  will lead to ABAP dump.
*

* insert received messages into the global table
    APPEND i_message TO gt_message_list.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_receiver_text TYPE REF TO lcl_amc_test_text.

  TRY.
      lo_consumer = cl_amc_channel_manager=>create_message_consumer(
          i_application_id = zif_mdd_wsps_c=>c_amc_app
          i_channel_id     = zif_mdd_wsps_c=>c_amc_channel
      ).
      CREATE OBJECT lo_receiver_text.

      " start of message delivery
      lo_consumer->start_message_delivery( i_receiver = lo_receiver_text ).
    CATCH cx_amc_error INTO lx_amc_error.
      MESSAGE lx_amc_error->get_text( ) TYPE 'e'.
  ENDTRY.

*
* wait until a message is received but not longer than waiting time in seconds
*
  WAIT FOR MESSAGING CHANNELS UNTIL lines( gt_message_list ) >= msg_nr UP TO wait_sec SECONDS.

  IF sy-subrc = 8 AND  lines( gt_message_list ) = 0.
    WRITE: ')-: Time out occured and no message received :-('.
  ELSE.
    LOOP AT gt_message_list INTO lv_message.
* print out the list of received AMC messages
      WRITE: / sy-tabix, lv_message.
    ENDLOOP.
  ENDIF.
