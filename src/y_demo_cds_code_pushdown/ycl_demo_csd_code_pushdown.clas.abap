class YCL_DEMO_CSD_CODE_PUSHDOWN definition
  public
  final
  create public .

    public section.

        interfaces:
            if_amdp_marker_hdb.

        class-methods:

            amdp_CONFIG_DATA_VENC
                for table function YTF_DEMO_CDS_CONFIG_DATA_VENC.

    protected section.
    private section.
ENDCLASS.



CLASS YCL_DEMO_CSD_CODE_PUSHDOWN IMPLEMENTATION.

    method amdp_CONFIG_DATA_VENC
        by database function
        for hdb language sqlscript
        options read-only
        using
            YDBT_DEMCDS_CONF
            .

        return
            select
                *,
                :iv_date as data_envio,
                TO_VARCHAR( ADD_DAYS( TO_DATE( :iv_date, 'YYYYMMDD' ), dias_prev_notif ), 'YYYYMMDD' ) as data_vencimento
            from
                YDBT_DEMCDS_CONF
            ;

    endmethod.

ENDCLASS.
