INTERFACE zif_mdd_wsps_c
  PUBLIC .

  CONSTANTS c_apc_app TYPE if_abap_channel_types=>ty_apc_application_id VALUE 'ZMDD_WSPS_APC'.
  CONSTANTS c_amc_app TYPE if_abap_channel_types=>ty_amc_application_id VALUE 'ZMDD_WSPS_AMC'.
  CONSTANTS c_amc_channel TYPE if_abap_channel_types=>ty_amc_channel_id VALUE '/events'.

ENDINTERFACE.
