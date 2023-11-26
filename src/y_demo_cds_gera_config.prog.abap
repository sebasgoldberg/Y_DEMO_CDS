*&---------------------------------------------------------------------*
*& Report y_demo_cds_gera_config
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT y_demo_cds_gera_config.

parameters:
    p_entcmb type i default 1. " Entradas a gerar x combinação

start-of-selection.

    delete from YDBT_DEMCDS_CONF.

    select
        t001~bukrs,
        t003~blart
    from
        t001 inner join t003
        on
            1 = 1
    into table
        @data(lt_combinacoes).


    data:
        lt_YDBT_DEMCDS_CONF type standard table of YDBT_DEMCDS_CONF.

    loop at lt_combinacoes assigning field-symbol(<ls_combinacao>).

        do p_entcmb times.

            data(lv_index) = sy-index.

            append initial line to lt_YDBT_DEMCDS_CONF assigning field-symbol(<ls_YDBT_DEMCDS_CONF>).

            move-corresponding <ls_combinacao> to <ls_YDBT_DEMCDS_CONF>.
            <ls_YDBT_DEMCDS_CONF>-dias_prev_notif = lv_index.

        enddo.

    endloop.

    insert YDBT_DEMCDS_CONF from table lt_YDBT_DEMCDS_CONF.

    commit work and wait.

    message 'Processamento realizado com sucesso' type 'S'.
