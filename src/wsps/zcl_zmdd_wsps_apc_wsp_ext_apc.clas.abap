class ZCL_ZMDD_WSPS_APC_WSP_EXT_APC definition
  public
  inheriting from CL_APC_WSP_EXT_STATELESS_BASE
  final
  create public .

public section.

  methods IF_APC_WSP_EXTENSION~ON_START
    redefinition .
  methods IF_APC_WSP_EXTENSION~ON_MESSAGE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZMDD_WSPS_APC_WSP_EXT_APC IMPLEMENTATION.


  METHOD if_apc_wsp_extension~on_message.

    DATA: lo_producer TYPE REF TO if_amc_message_producer_text.
    TRY.
* retrieve the text message
        DATA(lv_text) = i_message->get_text( ).
        lo_producer ?= cl_amc_channel_manager=>create_message_producer(
          i_application_id = zif_mdd_wsps_c=>c_amc_app
          i_channel_id     = zif_mdd_wsps_c=>c_amc_channel
        ).
        lo_producer->send( i_message = lv_text ).


* create the message object
        DATA(lo_message) = i_message_manager->create_message( ).
* send message
        lo_message->set_text( |Echo: { lv_text }| ).
        i_message_manager->send( lo_message ).
      CATCH cx_amc_error INTO DATA(lx_amc_error).
        MESSAGE lx_amc_error->get_text( ) TYPE 'E'.
      CATCH cx_apc_error INTO DATA(lx_apc_error).
        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
    ENDTRY.
  ENDMETHOD.


  METHOD if_apc_wsp_extension~on_start.

    TRY.
* bind the WebSocket connection to the AMC channel
        DATA(lo_binding) = i_context->get_binding_manager( ).
        lo_binding->bind_amc_message_consumer(
          i_application_id = zif_mdd_wsps_c=>c_amc_app
          i_channel_id     = zif_mdd_wsps_c=>c_amc_channel
        ).


* send the message on WebSocket connection
        DATA(lo_message) = i_message_manager->create_message( ).
        DATA(lv_cons_id) = i_context->get_connection_id( ).
        lo_message->set_text( |connected:{ lv_cons_id }:SAP Backend { sy-sysid }/{ sy-mandt } - AMC enabled| ).
        i_message_manager->send( lo_message ).
      CATCH cx_apc_error INTO DATA(lx_apc_error).
        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
