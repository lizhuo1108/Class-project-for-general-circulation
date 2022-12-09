;---------------- function for calculating the divergent wind--------------
    undef ("divergent")
    function divergent(u,v)
    ;local local_variables ;-- optional
    begin
        dv    = uv2dvF_Wrap(u,v)               ; u,v ==> divergence
        uvd   = dv2uvF_Wrap(dv)

        uvd_write=(/ uvd /)
        uvd_write!0="component"
        uvd_write!1="year"
        uvd_write!2="level"
        uvd_write!3="latitude"
        uvd_write!4="longitude"

        year_start=1979
        year_end  =2021
        uvd_write&component=ispan(0, 1, 1)
        uvd_write&year     =ispan(year_start, year_end, 1)
        uvd_write&level    =uvd&level
        uvd_write&latitude =uvd&latitude
        uvd_write&longitude=uvd&longitude

        uvd_write@units=uvd@units
        uvd_write@long_name=uvd@long_name
        return(uvd_write)
    end
;=======================================================
; Read the data 
;======================================================= 
    diri="/zhoulab_rit/lzhuo/data/ERA5/"
    filename="u_season.nc"
    fi=addfile(diri+filename, "r")
    u=fi->u
    ;printVarSummary(u)

    diri="/zhoulab_rit/lzhuo/data/ERA5/"
    filename="v_season.nc"
    fi=addfile(diri+filename, "r")
    v=fi->v
    ;printVarSummary(v)
;========================================================
; Calculate the divergence from the wind components u,v, 
; and then calculate the divergent wind components
;========================================================
;-----------------JJA------------------------------------
;--First calculate the divergence
   ;Note that in order to calculate divergence, input data must be in ascending latitude order
    u_new=u(:,{"JJA"},:,{-90:90},:)
    v_new=v(:,{"JJA"},:,{-90:90},:)
    uvd=divergent(u_new,v_new)

    filepath="/zhoulab_rit/lzhuo/data/ERA5/"
    filename="uvd_JJA.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- DJF ----------------------------------
    u_new=u(:,{"DJF"},:,{-90:90},:)
    v_new=v(:,{"DJF"},:,{-90:90},:)
    uvd=divergent(u_new,v_new)

    filepath="/zhoulab_rit/lzhuo/data/ERA5/"
    filename="uvd_DJF.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
;----------------- Annual ------------------------------
    u_new=dim_avg_n_Wrap(u(:,:,:,{-90:90},:), 1)
    v_new=dim_avg_n_Wrap(v(:,:,:,{-90:90},:), 1)
    uvd=divergent(u_new,v_new)

    filepath="/zhoulab_rit/lzhuo/data/ERA5/"
    filename="uvd_annual.nc"
    fout=addfile(filepath+filename,"c")
    fout->uvd=uvd
