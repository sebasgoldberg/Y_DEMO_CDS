@EndUserText.label: 'Configuração data de vencimento objetivo para data do dia'
define table function YTF_DEMO_CDS_CONFIG_DATA_VENC
with parameters
    @Environment.systemField: #SYSTEM_DATE
    iv_date : abap.dats
returns {
    mandt : abap.clnt;
    bukrs: bukrs;
    blart: blart;
    dias_prev_notif: yde_nego_dias_prev_notif;
    data_envio: abap.dats;
    data_vencimento: abap.dats;
}
implemented by method YCL_DEMO_CSD_CODE_PUSHDOWN=>amdp_CONFIG_DATA_VENC; 
