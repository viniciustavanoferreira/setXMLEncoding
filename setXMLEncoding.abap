* ls_evento-arquivo_string is the XML that needs to be converted.
  if ( ls_evento-arquivo_string is not initial ).
    lv_len = strlen( ls_evento-arquivo_string ).
    create data lo_cdata type c length lv_len.
    clear lv_len.
    assign lo_cdata->* to field-symbol(<fs_cdata>).
    if ( <fs_cdata> is assigned ).
      <fs_cdata> = ls_evento-arquivo_string.
      assign <fs_cdata> to <ls_conv> casting.
      if ( <ls_conv> is assigned ).
        lo_conv = cl_abap_conv_in_ce=>create( encoding = '4110' input = <ls_conv> replacement = '*' ignore_cerr = 'X' ).

        call method lo_conv->read
          importing
            data   = lv_4110
            len    = lv_len
          exceptions
            others = 1.

        if ( sy-subrc is initial ).
          ls_evento-arquivo_string = lv_4110.
        endif.
      endif.
    endif.
  endif.