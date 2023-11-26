*&---------------------------------------------------------------------*
*& Report yr_demo_cds_envia_notif
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT yr_demo_cds_envia_notif.

parameters:
    p_data type d default sy-datum.

start-of-selection.

    " Obtemos configuração.

    select
        *
    from
        YDBT_DEMCDS_CONF
    into table
        @data(lt_YDBT_DEMCDS_CONF).


    " Convertimos os dias

    types:
        begin of ty_s_config_x_data_vencimento,
            bukrs type bkpf-bukrs,
            blart type bkpf-blart,
            ZFBDT type bseg-ZFBDT, " Data de vencimento para a data do dia
        end of ty_s_config_x_data_vencimento,

        ty_t_config_x_data_vencimento type standard table of ty_s_config_x_data_vencimento.

    data:
        lt_config_x_data_vencimento type ty_t_config_x_data_vencimento.

    loop at lt_YDBT_DEMCDS_CONF assigning field-symbol(<ls_lt_YDBT_DEMCDS_CONF>).

        append value #(
            bukrs = <ls_lt_YDBT_DEMCDS_CONF>-bukrs
            blart = <ls_lt_YDBT_DEMCDS_CONF>-blart
            " Data de vencimento objetivo para a data do dia e os dias previos a serem considerados.
            ZFBDT = p_data
                + <ls_lt_ydbt_demcds_conf>-dias_prev_notif
        )
        to lt_config_x_data_vencimento.

    endloop.


    " Obtenção das posições que tem a data de vencimento gerada a partir da
    " configuração, e que devem ser notificadas para o v.

    check lt_YDBT_DEMCDS_CONF is not initial.

    select
        bseg~bukrs,
        bseg~belnr,
        bseg~gjahr,
        bseg~buzei
        " adicionamos outras informações relevantes para a notificação
    from
        bkpf inner join bseg
        on
            bkpf~bukrs = bseg~bukrs and
            bkpf~belnr = bseg~belnr and
            bkpf~gjahr = bseg~gjahr
    for all entries in @lt_config_x_data_vencimento
    where
        bkpf~bukrs = @lt_config_x_data_vencimento-bukrs and
        bkpf~blart = @lt_config_x_data_vencimento-blart and
        bseg~zfbdt = @lt_config_x_data_vencimento-zfbdt
    into table
        @data(lt_dados_notificacoes).


    " Realizamos as notificações usando as informações obtidas...

    message 'Processamento realizado com sucesso' type 'S'.
