;---------------- function for calculating the divergent wind (mmm)--------------
    undef ("divergent_mmm")
    function divergent_mmm(u,v)
    ;local local_variables ;-- optional
    begin
        dv    = uv2dvF_Wrap(u,v)               ; u,v ==> divergence
        uvd   = dv2uvF_Wrap(dv)

        uvd_write=(/ uvd /)
        uvd_write!0="component"
        uvd_write!1="year"
        uvd_write!2="plev"
        uvd_write!3="lat"
        uvd_write!4="lon"

        uvd_write&component=ispan(0, 1, 1)
        ;uvd_write&year     =ispan(1985, 2014, 1)
        uvd_write&plev     =uvd&plev
        uvd_write&lat      =uvd&lat
        uvd_write&lon      =uvd&lon

        uvd_write@units    =uvd@units
        uvd_write@long_name=uvd@long_name
        return(uvd_write)
    end
;---------------- function for calculating the divergent wind (every member)--------------
    undef ("divergent")
    function divergent(u,v)
    ;local local_variables ;-- optional
    begin
        dv    = uv2dvF_Wrap(u,v)               ; u,v ==> divergence
        uvd   = dv2uvF_Wrap(dv)

        uvd_write=(/ uvd /)
        uvd_write!0="component"
        uvd_write!1="model"
        uvd_write!2="year"
        uvd_write!3="plev"
        uvd_write!4="lat"
        uvd_write!5="lon"

        ; uvd_write&component=ispan(0, 1, 1)
        ; uvd_write&model    =ispan(0,14,1)
        ;uvd_write&year     =ispan(1985, 2014, 1)
        ;uvd_write&plev     =uvd&plev
        ;uvd_write&lat      =uvd&lat
        ;uvd_write&lon      =uvd&lon

        uvd_write@units    =uvd@units
        uvd_write@long_name=uvd@long_name
        return(uvd_write)
    end

;========================================================
; Calculate the divergence from the wind components u,v, 
; and then calculate the divergent wind components (mmm)
;========================================================
;-----------------JJA------------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_JJA_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_JJA_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,{-90:90},:)
    v_new=v(:,:,{-90:90},:)
    ;printVarSummary(u_new)

    uvd=divergent_mmm(u_new,v_new)
    uvd&year     =ispan(1985, 2014, 1)
  
    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_JJA.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- DJF ----------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_DJF_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_DJF_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,{-90:90},:)
    v_new=v(:,:,{-90:90},:)
    ;printVarSummary(u_new)
  
    uvd=divergent_mmm(u_new,v_new)
    uvd&year     =ispan(1985, 2014, 1)
  
    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_DJF.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- Annual ------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_annual_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_annual_mmm_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,{-90:90},:)
    v_new=v(:,:,{-90:90},:)
    ;printVarSummary(u_new)
  
    uvd=divergent_mmm(u_new,v_new)
    uvd&year     =ispan(1985, 2014, 1)
  
    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_annual.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;========================================================
; Calculate the divergence from the wind components u,v, 
; and then calculate the divergent wind components (every member)
;========================================================
;----------------- Annual ------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_annual_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_annual_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,:,{-90:90},:)
    v_new=v(:,:,:,{-90:90},:)
    ;printVarSummary(u_new)
   
    uvd          =divergent(u_new,v_new)
    
    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_annual_m.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- DJF ----------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_DJF_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_DJF_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,:,{-90:90},:)
    v_new=v(:,:,:,{-90:90},:)
  
    uvd          =divergent(u_new,v_new)

    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_DJF_m.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- JJA ----------------------------------
    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/u/"
    filename="ua_JJA_fillna.nc"
    fi=addfile(diri+filename, "r")
    u=fi->ua
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/CMIP6/hist/v/"
    filename="va_JJA_fillna.nc"
    fi=addfile(diri+filename, "r")
    v=fi->va
    ;printVarSummary(v)
    u_new=u(:,:,:,{-90:90},:)
    v_new=v(:,:,:,{-90:90},:)
    
    uvd          =divergent(u_new,v_new)

    filepath="/zhoulab_rit/lzhuo/data/CMIP6/hist/"
    filename="uvd_JJA_m.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd