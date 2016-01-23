@echo off
set "softsurface=@isOneOf(surface, unpaved, gravel, ground, dirt, grass, sand, compacted, fine_gravel, earth, mud)"
set "hardsurface=@isOneOf(surface, paved, asphalt, concrete)"
call :createpython >../../package/rules/pythonhelpers.py
call :sub >../../package/rules/mtbmap-nextgeneration.mrules
exit /b

:createpython
echo def routename(e):
echo     str_list = []
echo     i = 0
echo     for set in e.tagSets:
echo          return set.ToString()
REM echo          return str(dir(set))
REM echo          return set['name']
REM echo          i=i+1
REM echo         if set.hasTag('name'):
REM echo             if set['route'] == 'mtb':
REM echo                 str_list.append(set['name'])   
REM echo     str_list.sort()
REM echo     return '+'.join(str_list)
REM echo     return 'hej'
REM echo     return str(e)
goto :eof

:bikeway
echo 			define
echo 				min-zoom : 9
echo 				line-color : #3333dd
echo 				line-width : 13:1;16:3;19:5
echo 				line-opacity : 9:0;13:1
echo 				line-style : dash
echo 				painting-cycle : 695
goto :eof

:pedestrianway
echo 			define
echo 				min-zoom : 11
echo 				line-color : #ee3333
echo 				line-width : 16:1;17:2
echo 				line-opacity : 11:0;15:1
echo 				line-style : dash
goto :eof

:forestpath
echo 			for	: @isOneOf(trail_visibility,bad,no)
					call :forestpath1
echo 			elsefor : trail_visibility=intermediate
					call :forestpath2
echo 			elsefor : trail_visibility=good
					call :forestpath3
echo 			elsefor : trail_visibility=excellent
					call :forestpath3
echo 			elsefor : width^<0.5
					call :forestpath2
echo 			elsefor : width^<1.5
					call :forestpath3
echo 			elsefor : width^>=1.5
					call :forestpath4
echo 			elsefor : highway=track
					call :forestpath4
echo 			elsefor : highway=cycleway
					call :forestpath4
echo 			elsefor : @isOneOf(surface,paved,concrete,cobblestone,paving_stones,fine_gravel,sett,pebblestone)
					call :forestpath4
echo 			elsefor : highway=bridleway
					call :forestpath4
echo 			else
					call :forestpath3
goto :eof

:mtbscalebackdrop
echo 					define
echo 						painting-cycle : 398
echo 						line-color : #990099
echo 						line-width : 0.1
echo 						line-opacity : 0
echo 						border-color : #caffa9
echo 						border-style : solid
echo 						border-opacity : 1
echo 						border-width : 10:4;15:6;18:12
echo 					draw : line
echo 					define
echo 						min-zoom : 9
echo 						max-zoom : 11.9
echo 						line-opacity : 1
echo 						painting-cycle : 1000
echo 						line-color : #4444cc
echo 						line-width : 2
echo 						border-style : none
echo 					draw : line

goto :eof

:mtbscale
echo 				for : @isOneOf(mtb:scale,0-,0,0+)
						call :mtbscalebackdrop %~1
echo 					define
echo 						min-zoom : 12
echo 						max-zoom : 25
echo 						line-color : #1fdd00
echo 						line-width : %~1
echo 						line-opacity : 1
echo 						border-style : none	
echo 						painting-cycle : 624
echo 					draw : line
echo 				elsefor : @isOneOf(mtb:scale,1-,1,1+)
						call :mtbscalebackdrop %~1
echo 					define
echo 						min-zoom : 12
echo 						max-zoom : 25
echo 						line-color : #e2e200
echo 						line-opacity : 1
echo 						border-style : none
echo 						line-width : %~1
echo 						painting-cycle : 624
echo 					draw : line
echo 				elsefor : @isOneOf(mtb:scale,2-,2,2+)
						call :mtbscalebackdrop %~1
echo 					define
echo 						min-zoom : 12
echo 						max-zoom : 25
echo 						line-color : #ee4444
echo 						line-opacity : 1
echo 						border-style : none
echo 						line-width : %~1
echo 						painting-cycle : 624
echo 					draw : line
echo 				elsefor : @isOneOf(mtb:scale,3-,3,3+)
						call :mtbscalebackdrop %~1
echo 					define
echo 						min-zoom : 12
echo 						max-zoom : 25
echo 						line-color : #c300c3
echo 						line-opacity : 1
echo 						border-style : none
echo 						line-width : %~1
echo 						painting-cycle : 624
echo 					draw : line
goto :eof

:forestpath1
					call  :mtbscale "10:1;15:1"
echo 				define
echo 					border-style : none
echo 					line-color : #555555
echo 					line-opacity : 11:0.3;15:1
echo 					line-style : dashlong
echo 					line-width : 10:0.05;15:0.5
echo 					painting-cycle : 625
echo 				draw : line
goto :eof
:forestpath2
					call  :mtbscale "10:3;15:5"
echo 				define
echo 					border-style : none
echo 					line-color : #555555
echo 					line-opacity : 11:0.3;15:1
echo 					line-style : dashdot
echo 					line-width : 10:1;15:1.6
echo 					painting-cycle : 625
echo 				draw : line
goto :eof
:forestpath3
					call  :mtbscale "10:3;15:6"
echo 				define
echo 					border-style : none
echo 					line-color : #000000
echo 					line-opacity : 11:0.3;15:1
echo 					line-style : dash
echo 					line-width : 10:0.25;15:2
echo 					painting-cycle : 625
echo 				draw : line
goto :eof
:forestpath4
					call  :mtbscale "10:3;15:7"
echo 				define
echo 					border-style : none
echo 					line-color : #000000
echo 					line-opacity : 11:0.3;15:1
echo 					line-style : dash
echo 					line-width : 10:0.5;15:3
echo 					painting-cycle : 625
echo 				draw : line
goto :eof


:bridleonly
echo 			define
echo 				min-zoom : 13
echo 				line-color : #009900
echo 				line-width : 10:0.5;15:3
echo 				line-style : dashdot
goto :eof


:gravelroad
echo 			define
echo 				line-color : #b07f3e
echo 				line-width : 10:0.5;15:4;18:12
echo 				line-style : solid
echo 				min-zoom : 10
echo 				line-opacity : 10:0;13:1
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 25%%
echo 				border-opacity : 10:0;13:1
echo 				painting-cycle : 650
goto :eof

:trackway
echo 			define
echo 				min-zoom : 10
echo 				line-opacity : 10:0;13:1

echo 				line-color : #b07f3e
echo 				line-width : 10:0.5;15:3;18:8
echo 				line-style : solid
echo 				fill-opacity : 10:0;13:1

echo 				border-style : dash
echo 				border-color : #000000
echo 				border-width : 20%%
echo 				painting-cycle : 640
echo 				border-opacity : 10:0;13:1
echo 			draw : line



goto :eof

:highspeedroad
echo 			define
echo 				min-zoom : 5
echo 				line-color : #ff9155
echo 				line-width : 6:1;11:4;17:10
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
echo 				painting-cycle : 690
goto :eof

:bigroad
echo 			define
echo 				min-zoom : 7
echo 				line-color : #eebb55
echo 				line-width : 7:0.5;13:5;18:20
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
echo 				painting-cycle : 680
goto :eof

:pavedroad
echo 			define
echo 				min-zoom : 10
echo 				line-color : #ffffff
echo 				line-width : 9:1;15:4;18:13
echo 				line-opacity : 10:0;13:1
echo 				fill-opacity : 10:0;13:1
echo 				border-opacity : 10:0;13:1
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 30%%
echo 				painting-cycle : 670

goto :eof

:unknownroad
echo 			define
echo 				min-zoom : 7
echo 				line-color : #cccccc
echo 				line-opacity : 7:0;14:1
echo 				line-style : solid
echo 				line-width : 7:0.5;12:1;15:3;18:10
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 25%%
echo 				painting-cycle : 647

goto :eof

:sub
echo // Example of Maperitive rendering rules for OSMTileMachine
echo.
echo.
echo.
echo features
echo 	points
echo 		place : place
echo 		named_points : shop or restaurant or pub or natural=peak
echo 	lines
echo 		road : highway
echo 		railway : railway=rail 
echo 		bridge : bridge=yes or bridge=viaduct
echo 		waterway : waterway
echo 		cliff : natural=cliff
echo 		mtbroute : osmnetwork[type=route AND @isOneOf(route,mtb)]
echo 		bikeroute : osmnetwork[type=route AND @isOneOf(route,bicycle,lcn,ncn,inline_skates)]
echo 		footroute : osmnetwork[type=route AND (@isOneOf(route,foot,hiking,ski,fitness_trail,walking,running))]
echo 	areas
echo 		landuse : landuse or natural=wood
echo 		building : building
echo 		barrier : barrier
echo 		parking : amenity=parking
echo 		recreation : leisure=stadium or leisure=park or leisure=playground or leisure=garden or leisure=common
echo 		pitch : leisure=pitch
echo 		protected : leisure=nature_reserve or boundary=protected_area or boundary=national_park
echo 		waterarea : natural=water OR waterway
echo properties
echo 	map-background-color : #fcfaeb
echo 	map-sea-color : #65a4d0 
echo 	text-color : #000000
echo 	text-halo-color : #ffffff
echo 	text-halo-width : 40%%
echo 	font-size : 14
echo 	font-family : Clear Sans
echo 	font-weight : bold
echo 	topmost-layer : true 
echo rules

echo 	target : footroute
echo 		define
echo 			text-color : #cc3333
echo 			min-zoom : 16
echo 		draw : text
		
echo 	target : place
echo 		for : place=city
echo 			define
echo 				min-zoom : 11
echo 				max-zoom : 14
echo 				font-size : 10:18;13:14
echo 		elsefor : place=suburb
echo 			define
echo 				min-zoom : 15
echo 				max-zoom : 16

REM used for map legend only
echo 		elsefor : place=text
echo 			define
echo 				min-zoom : 10
echo 				max-zoom : 20
echo 				text-color : #000000
echo 				text-halo-color : #ffffff
echo 				text-halo-width : 40%%
echo 				font-size : 11
echo 				font-family : Arial
echo 				font-weight : bold
echo 				text-max-width : 20
echo 		elsefor : place=town
echo 			define
echo 				min-zoom : 11
echo 				max-zoom : 15
echo 				font-size : 10:18;13:14
echo 		elsefor : place=village
echo 			define
echo 				min-zoom : 14
echo 				max-zoom : 16
echo 		elsefor : place=neighbourhood
echo 			define
echo 				min-zoom : 15
echo 				max-zoom : 16
echo 		elsefor : place=locality
echo 			define
echo 				min-zoom : 15
echo 				max-zoom : 17
echo 		elsefor : place=hamlet
echo 			define
echo 				min-zoom : 14
echo 				max-zoom : 17
echo 		elsefor : place=isolated_dwelling
echo 			define
echo 				min-zoom : 15
echo 				max-zoom : 17
echo 		else
echo 			stop
echo 		define
echo 			text-color : #000000
echo 		draw : text
echo 	target : protected			
echo 		define
echo 			min-zoom : 13
echo 			line-style : solid
echo 			line-color : #449944
echo 			line-width : 1
echo 			line-opacity : 0.4
echo 			fill-color : #009900
echo 			fill-hatch : nwse
echo 			fill-opacity : 0.1
echo 			fill-hatch-color : #aaffaa
echo 			fill-hatch-opacity : 0.07
echo 		draw : fill
echo 	target : pitch
echo 		define
echo 			min-zoom : 14
echo 			line-style : solid
echo 			line-color : #aadf79
echo 			line-width : 1
echo 			line-opacity : 0.8
echo 			fill-color : #aadf79
echo 			fill-opacity : 0.3
echo 		draw : fill
echo 	target : building
echo 		define
echo 			line-style : none
echo 			min-zoom : 12
echo 			fill-color : #8c7a6f
echo 		draw : fill
echo 	target : $featuretype(area) 
echo 		for  : landuse=forest or natural=wood
echo 			define
echo 				min-zoom : 13
echo 				max-zoom : 14
echo 				font-size : 16
echo 			draw : text
echo 		elsefor  : leisure=nature_reserve or boundary=protected_area or boundary=national_park
echo 			define
echo 				min-zoom : 13
echo 				max-zoom : 15
echo 				text-halo-color : #eeffee
echo 				text-halo-width : 120%%
echo 				text-halo-opacity : 13:0.7;15:0.2
echo 				font-size : 13
echo 			draw : text
echo 		elsefor  : landuse
echo 			define
echo 				min-zoom : 15
echo 				max-zoom : 16
echo 				font-size : 13
echo 			draw : text
echo 		elsefor : leisure=stadium or leisure=park or leisure=playground or leisure=garden or leisure=common
echo 			define
echo 				min-zoom : 17
echo 				font-size : 12
echo 			draw : text
echo 		elsefor : building=yes
echo 			define
echo 				min-zoom : 17
echo 				text-halo-width : 22%%
echo 				font-family : arial
echo 				font-size : 12
echo 			draw : text
echo 		else
echo 			define
echo 				min-zoom : 18
echo 				text-halo-width : 22%%
echo 				font-family : arial
echo 				font-size : 11
echo 			draw : text
echo 	target : $featuretype(point)
echo 		define
echo 			min-zoom : 18
echo 			text-halo-width : 22%%
echo 			font-family : arial
echo 			font-size : 11
echo 		draw : text

echo 	target : $featuretype(line)
echo 		define
echo 			min-zoom : 18
echo 			text-halo-width : 22%%
echo 			font-family : arial
echo 			font-size : 11
echo 		draw : text

echo 	target : mtbroute
echo 		define
echo 			min-zoom : 13
echo 			font-size : 15
echo 			text-orientation : flow
echo 			text-color : #770000
echo 		draw : text
echo 		define
echo 			min-zoom : 12
echo 			max-zoom : 12.9
echo 			font-size : 15
echo 			text-orientation : fixed
echo 			text-color : #770000
echo 		draw : text

echo 	target : bikeroute
echo 		define
echo 			min-zoom : 17
echo 			painting-cycle : 4000
echo 			text-color : #0000ff
echo 		draw : text



echo 	target : road
echo 		for : highway=motorway or highway=motorway_link
				call :highspeedroad
echo 		elsefor : highway=trunk or highway=trunk_link
				call :highspeedroad
echo 		elsefor : highway=primary or highway=primary_link
				call :highspeedroad

echo 		elsefor : highway=secondary and maxspeed ^>85
				call :highspeedroad
echo 		elsefor : highway=secondary and %softsurface%
				call :gravelroad
echo 		elsefor : highway=secondary and maxspeed ^<60
				call :bigroad
echo 		elsefor : highway=secondary and width ^>10
				call :highspeedroad
echo 		elsefor : highway=secondary and width ^>=6.5
				call :bigroad
echo 		elsefor : highway=secondary and width ^<6.5
				call :pavedroad
echo 		elsefor : highway=secondary or highway=secondary_link
				call :bigroad
				
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and %hardsurface%
				call :pavedroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and %softsurface%
				call :gravelroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and @isOneOf(smoothness, bad, very_bad, horrible)
				call :gravelroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and @isOneOf(smoothness, excellent, good, intermediate)
				call :pavedroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and @isOneOf(smoothness, very_horrible)
				call :trackway
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and maxspeed ^>95
				call :highspeedroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road) and maxspeed ^>75
				call :pavedroad
echo 		elsefor : @isOneOf(highway, tertiary, unclassified, service, residential, living_street, road)
				call :unknownroad
			
echo 		elsefor : highway=track and tracktype=grade1 and %hardsurface%
				call :pavedroad
echo 		elsefor : highway=track and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=track and tracktype=grade1 and width ^<3
				call :trackway
echo 		elsefor : highway=track and tracktype=grade1 
				call :gravelroad
echo 		elsefor : highway=track and @isOneOf(surface, gravel, compacted, fine_gravel)
				call :gravelroad
echo 		elsefor : highway=track 
				call :trackway

echo 		elsefor : highway=footway and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=footway and bicycle=no
				call :pedestrianway
echo 		elsefor : highway=footway and bicycle=yes
				call :bikeway
echo 		elsefor : highway=footway and trail_visibility
				call :forestpath
echo 		elsefor : highway=footway and %hardsurface%
				call :pedestrianway
echo 		elsefor : highway=footway and %softsurface%
				call :forestpath
echo 		elsefor : highway=footway
				call :pedestrianway

echo 		elsefor : highway=cycleway and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=cycleway and trail_visibility
				call :forestpath
echo 		elsefor : highway=cycleway and @isOneOf(smoothness, bad, very_bad, horrible)
				call :trackway
echo 		elsefor : highway=cycleway and %softsurface%
				call :gravelroad
echo 		elsefor : highway=cycleway
				call :bikeway

echo 		elsefor : highway=bridleway and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=bridleway 
				call :bridleonly
					
echo 		elsefor : highway=path and foot=designated and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=path and foot=designated and bicycle=no
				call :pedestrianway
echo 		elsefor : highway=path and foot=designated and %hardsurface%
				call :pedestrianway
echo 		elsefor : highway=path and foot=designated and %softsurface%
				call :forestpath
echo 		elsefor : highway=path and foot=designated  
				call :pedestrianway

echo 		elsefor : highway=path and bicycle=designated and @isOneOf(mtb:scale,0-,0,0+,1-,1,1+,2-,2,2+,3-,3)
				call :forestpath
echo 		elsefor : highway=path and bicycle=designated and trail_visibility
				call :forestpath
echo 		elsefor : highway=path and bicycle=designated and @isOneOf(smoothness, bad, very_bad, horrible)
				call :trackway
echo 		elsefor : highway=path and bicycle=designated and %softsurface%
				call :gravelroad
echo 		elsefor : highway=path and bicycle=designated  
				call :bikeway
				
echo 		elsefor : highway=path and %hardsurface% and bicycle=no
				call :pedestrianway
echo 		elsefor : highway=path
				call :forestpath

					

					
echo 		else
echo 			stop
echo 		for : tunnel=yes
echo 			define
echo 				line-opacity : 0.3
echo 				border-opacity : 0.3
echo 		draw : line


echo 	target : mtbroute
echo 		define
echo 			min-zoom : 12
REM echo 			line-color : #c0e0c0
echo 			line-color : #90d382
echo 			line-start-cap : triangle
echo 			line-width : 10:7;15:12;18:21
echo 			line-opacity : 0.8
echo 			border-style : solid
echo 			border-color : #008800
echo 			border-width : 18%%
echo 			painting-cycle : 405
echo 		draw : line
echo 		define
echo 			min-zoom : 9
echo 			max-zoom : 11.9
echo 			line-opacity : 1
echo 			painting-cycle : 1001
echo 			line-color : #006600
echo 			line-width : 2
echo 			border-style : none
echo 		draw : line


echo 	target : footroute
echo 		define
echo 			min-zoom : 14
REM echo 			line-color : #c0e0c0
echo 			line-color : #a4c083
echo 			line-start-cap : triangle
echo 			line-width : 10:5;15:9;18:20
echo 			line-opacity : 0.9
echo 			border-style : solid
echo 			border-color : #ee3333
echo 			border-width : 6%%
echo 			painting-cycle : 404
echo 		draw : line


echo 	target : barrier
echo 		define
echo 			min-zoom : 15
echo 			line-color : #666666
echo 			line-width : 0.2		
echo 		draw : line
echo 	target : parking
echo 		define
echo 			min-zoom : 15	
echo 			line-width : 0.5
echo 			line-color : #dc9833
echo 			line-opacity : 0.3
echo 			fill-color : #f3f298
echo 		draw : fill
echo 	target : bridge 
echo 		for : cycleway=designated or highway=cycleway
echo 			define
echo 				min-zoom : 15
echo 				line-color : #fcfaeb
echo 				line-width : 15:2;17:6				
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 15:0%%;17:30%%
echo 			draw : line
echo 		for : highway=footway or footway=designated 
echo 			define
echo 				min-zoom : 16
echo 				line-color : #fcfaeb
echo 				line-width : 16:3;17:6				
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 30%%
echo 			draw : line
echo 	target : railway
echo 		define
echo 			min-zoom: 10
echo 			line-color : #fcfaeb
echo 			line-style : dash
echo 			line-width : 13:1.5;17.5:2.75
echo 			border-style : solid
echo 			border-color : black
echo 			border-width : 50%%
echo 			border-opacity : 1
echo 			line-opacity : 1
echo 		draw : line
echo 	target : waterarea
echo 		define
echo 			line-style : none
echo 			fill-color : #65a4d0 
echo 		draw : fill
echo 	target : waterway
echo 		define
echo 			min-zoom : 12
echo 			line-color : #65a4d0 
echo 			line-width : 13:0.5;17:2
echo 		draw : line
echo 	target : cliff
echo 		define
echo 			min-zoom : 16
echo 			line-color : #444444
echo 			line-width : 2		
echo 		draw : line
echo 		define 
echo 			line-style : dash
echo 			min-zoom : 16
echo 			line-color : #444444
echo 			line-offset : 2
echo 			line-width : 3
echo 			line-offset-sides : right
echo 		draw : line
echo 	target : landuse
echo 		for : landuse=forest OR natural=wood
echo 			define
echo 				line-style : none
REM echo 				fill-color : #9ade84
echo 				fill-color : #9ece89
echo 			draw : fill
echo 		elsefor : landuse=meadow OR natural=scrub OR natural=heath OR natural=grassland
echo 			define
echo 				line-style : none
echo 				fill-color : #9ade84
echo 				fill-hatch : diagonalcross
echo 				fill-hatch-color : #caffa9
echo 			draw : fill				
echo 		elsefor : landuse=grass 
echo 			define
echo 				line-style : none
echo 				fill-color : #caffa9
echo 			draw : fill				
echo 		elsefor : landuse=residential
echo 			define
echo 				line-style : none
echo 				fill-color : #efe6dc
echo 			draw : fill
echo 		elsefor : landuse=commercial
echo 			define
echo 				line-style : none
echo 				fill-color : #e2e7ff
echo 			draw : fill
echo 		elsefor : landuse=farm or landuse=farmland or landuse=field
echo 			define
echo 				line-style : none
echo 				fill-color : #f8f1a8
echo 			draw : fill
echo 		elsefor : landuse=industrial
echo 			define
echo 				line-style : none
echo 				fill-color : #d6d1c8
echo 			draw : fill
echo 		else
echo 			define
echo 				painting-cycle : 399
echo 				line-style : none
echo 				fill-color : #eff4df
echo 			draw : fill
echo 	target : recreation 
echo 		define
echo 			line-style : none
echo 			fill-color : #caff99
echo 		draw : fill
