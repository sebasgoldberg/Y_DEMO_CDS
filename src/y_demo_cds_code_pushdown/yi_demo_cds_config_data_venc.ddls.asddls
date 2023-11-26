@AbapCatalog.sqlViewName: 'YVI_DEMCDS_CONFV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Configuração data de vencimento objetivo para data do dia'
define view YI_DEMO_CDS_CONFIG_DATA_VENC
    with parameters
        @Environment.systemField: #SYSTEM_DATE
        iv_date : abap.dats
as select from ytf_demo_cds_config_data_venc( iv_date: :iv_date )
{
    bukrs,
    blart,
    dias_prev_notif,
    data_envio,
    data_vencimento
}
