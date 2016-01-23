set region=albania
call :execute

set region=andorra
call :execute

set region=austria
call :execute

set region=azores
call :execute

set region=belarus
call :execute

set region=belgium
call :execute

set region=bosnia-herzegovina
call :execute

set region=bulgaria
call :execute

set region=croatia
call :execute

set region=cyprus
call :execute

set region=czech-republic
call :execute

set region=denmark
call :execute

set region=estonia
call :execute

set region=faroe-islands
call :execute

set region=finland
call :execute

set region=france
call :execute

set region=georgia
call :execute

set region=germany
call :execute

set region=great-britain
call :execute

set region=greece
call :execute

set region=hungary
call :execute

set region=iceland
call :execute

set region=ireland-and-northern-ireland
call :execute

set region=isle-of-man
call :execute

set region=italy
call :execute

set region=kosovo
call :execute

set region=latvia
call :execute

set region=liechtenstein
call :execute

set region=lithuania
call :execute

set region=luxembourg
call :execute

set region=macedonia
call :execute

set region=malta
call :execute

set region=moldova
call :execute

set region=monaco
call :execute

set region=montenegro
call :execute

set region=netherlands
call :execute

set region=norway
call :execute

set region=poland
call :execute

set region=portugal
call :execute

set region=romania
call :execute

set region=russia-european-part
call :execute

set region=serbia
call :execute

set region=slovakia
call :execute

set region=slovenia
call :execute

set region=spain
call :execute

set region=sweden
call :execute

set region=switzerland
call :execute

set region=turkey
call :execute

set region=ukraine
call :execute


exit /b

:execute
del /Q %region%-latest.osm.pbf
wget http://download.geofabrik.de/europe/%region%-latest.osm.pbf
call osmosis --read-pbf file=%region%-latest.osm.pbf --tf accept-ways mtb:scale=* --tf reject-relations --used-node --tf reject-ways --write-xml %region%-mtbscale.osm
del /Q %region%-latest.osm.pbf
goto :eof