@AbapCatalog.sqlViewName: 'YVI_DEMCDS_DOCSD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Demo: Dados documentos a serem notificadas numa data.'
define view YI_DEMO_CDS_DOCS_NOTIF_NA_DATA 
with parameters
    @Environment.systemField: #SYSTEM_DATE
    iv_date : abap.dats
as select 
from
    bkpf inner join bseg
    on
        bkpf.bukrs = bseg.bukrs and
        bkpf.belnr = bseg.belnr and
        bkpf.gjahr = bseg.gjahr
    inner join YI_DEMO_CDS_CONFIG_DATA_VENC( iv_date: :iv_date )
    on
        bkpf.bukrs = YI_DEMO_CDS_CONFIG_DATA_VENC.bukrs and
        bkpf.blart = YI_DEMO_CDS_CONFIG_DATA_VENC.blart and
        bseg.zfbdt = YI_DEMO_CDS_CONFIG_DATA_VENC.data_vencimento
{
    bseg.bukrs,
    bseg.belnr,
    bseg.gjahr,
    bseg.buzei

    -- adicionamos outras informações relevantes para a notificação

}
