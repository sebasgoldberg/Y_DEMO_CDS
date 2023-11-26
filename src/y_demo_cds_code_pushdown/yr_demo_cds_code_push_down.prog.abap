*&---------------------------------------------------------------------*
*& Report yr_demo_cds_code_push_down
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yr_demo_cds_code_push_down.

parameters:
    p_data type d default sy-datum.

start-of-selection.

    select
        *
    from
        YI_DEMO_CDS_DOCS_NOTIF_NA_DATA( iv_date = @p_data )
    into table
        @data(lt_dados_notificacoes).

    " Realizamos as notificações usando as informações obtidas...

    message 'Processamento realizado com sucesso' type 'S'.
