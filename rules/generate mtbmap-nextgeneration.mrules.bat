@echo off
set "gravelsurface=@isOneOf(surface, unpaved, gravel, ground, dirt, grass, sand, compacted, fine_gravel, earth, mud)"
call :sub >mtbmap-nextgeneration.mrules
exit /b
:bikeway
echo 			define
echo 				min-zoom : 15
echo 				line-color : #3333dd
echo 				line-width : 13:1;16:2
echo 				line-opacity : 1
echo 				line-style : dash
goto :eof

:pedestrianway
echo 			define
echo 				min-zoom : 16
echo 				line-color : #ee3333
echo 				line-width : 16:1;17:2
echo 				line-opacity : 1
echo 				line-style : dash
goto :eof

:forestpath
echo 			define
echo 				min-zoom : 13
echo 				line-color : #000000
echo 				line-width : 1
echo 				line-opacity : 0.5
echo 				line-style : dash
goto :eof

:gravelroad
echo 			define
echo 				min-zoom : 13
echo 				line-color : #ffffff
echo 				line-width : 13:1;15:3;19:5
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
goto :eof

:trackway
echo 			define
echo 				min-zoom : 13
echo 				line-color : #bb8844
echo 				line-width : 13:1;15:3;19:5
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
goto :eof

:highspeedroad
echo 			define
echo 				min-zoom : 5
echo 				line-color : #ff9155
echo 				line-width : 6:1;11:4;17:10
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
goto :eof

:bigroad
echo 			define
echo 				min-zoom : 7
echo 				line-color : #eebb55
echo 				line-width : 7:2;14:3;18:10
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
goto :eof

:pavedroad
echo 			define
echo 				min-zoom : 12
echo 				line-color : #ffffff
echo 				line-width : 9:1;15:3;19:10
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 30%%
goto :eof

:unknownroad
echo 			define
echo 				min-zoom : 12
echo 				line-color : #cccccc
echo 				line-style : dot
echo 				line-width : 9:1;15:2;19:8
echo 				border-style : solid
echo 				border-color : #000000
echo 				border-width : 20%%
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
echo 	target : place
echo 		for : place=city
echo 			define
echo 				min-zoom : 7
echo 				max-zoom : 14
echo 				font-size : 10:18;13:14
echo 		elsefor : place=suburb
echo 			define
echo 				min-zoom : 13
echo 				max-zoom : 16
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
echo 				min-zoom : 14
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
echo 		for  : landuse
echo 			define
echo 				min-zoom : 16
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


echo 	target : road
echo 		for : highway=motorway*
					call :highspeedroad
echo 			elsefor : highway=trunk*
					call :highspeedroad
echo 			elsefor : highway=primary
					call :highspeedroad
echo 			elsefor : highway=secondary* and maxspeed ^>85
					call :highspeedroad
echo 			elsefor : highway=secondary and %gravelsurface%
					call :gravelroad
echo 			elsefor : highway=secondary and maxspeed ^<60
					call :bigroad
echo 			elsefor : highway=secondary and width ^>10
					call :highspeedroad
echo 			elsefor : highway=secondary and width ^>=6.5
					call :bigroad
echo 			elsefor : highway=secondary and width ^<6.5
					call :pavedroad
echo 			elsefor : highway=secondary 
					call :bigroad
				
				
				
				;				call :pedestrianway
;				call :bikeway
;				call :forestpath
;				call :trackway
;				call :gravelroad
;				call :unknownroad
echo 		elsefor : highway=unclassified
				call :pavedroad
echo 		elsefor : highway=tertiary  or highway=tertiary_link
				call :pavedroad
echo 		elsefor : highway=secondary or highway=primary_link
				call :bigroad
echo 		elsefor : highway=primary or highway=motorway_link or highway=trunk_link
				call :highspeedroad
echo 		elsefor : highway=motorway or highway=trunk
				call :highspeedroad
echo 		else
echo 			stop
echo 		for : tunnel=yes
echo 			define
echo 				line-opacity : 0.3
echo 				border-opacity : 0.3
echo //				fill-opacity : 0.3
echo 		draw : line
echo 	target : barrier
echo 		define
echo 			min-zoom : 15
echo 			line-color : #222222
echo 			line-width : 0.5		
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
echo 				fill-color : #9ade84
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
echo 				line-style : none
echo 				fill-color : #eff4ef
echo 			draw : fill
echo 	target : recreation 
echo 		define
echo 			line-style : none
echo 			fill-color : #caff99
echo 		draw : fill
