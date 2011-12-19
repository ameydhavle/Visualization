========== Marklogic Visualization ==============
This library uses google visualization api to render various charts.

Currently the following charts are supported

1. WordCloud:
   Purpose: This chart type is most commonly seen in social media analytic to represent the occurance
   of specific words within the given dataset. 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import wordcloud dependencies by putting the following code in the head section
      	<link rel="stylesheet" type="text/css" href="http://visapi-gadgets.googlecode.com/svn/trunk/wordcloud/wc.css"/>
      	<script type="text/javascript" src="http://visapi-gadgets.googlecode.com/svn/trunk/wordcloud/wc.js">//</script>
   Step 3: place the call enclosed in a <script type..> </script> tag
   	   	<script type="text/javascript">
    		{visualization:wordCloud(fn:doc("/wordCloud.xml")/feed)}
   		</script>	
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td><div id="wcdiv" align="right" style="width: 200px; height: 200px; margin: 0 auto">&nbsp;</div></td>
		...
	
	Supported/Required XML format:
	<feed>
		<data>
			<comment>MarkLogic</comment>
			<text/>
		</data>
		<data>
			<comment>BigData Analytics is great</comment>
			<text/>
		</data>
	</feed>	
	*** for some 'unknown' reason an empty text tag is required by the google api.

2. DataTable:
   Purpose: Can be used for rendering xml in a tabular format. 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import Datatable dependencies by putting the following code in the head section
			{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag
   	   	<script type="text/javascript">
    		{visualization:dataTable(fn:doc("/visualization.xml")/feed)}
   		</script>	
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td><div id="barformat_div" align="right" style="width: 800px; height: 200px; margin: 0 auto">//</div></td>
		...
	
	Supported/Required XML format:
	<feed>
  		<data>
    		<month>Jan</month>
    		<tide>112</tide>
    		<nyquil>201</nyquil>
    		<dayquil>125</dayquil>
    		<duracell>67</duracell>
    		<bounty>141</bounty>
    		<downy>69</downy>
  		</data>
  		...
  	</feed>
  	
 3. Chart Wizard:
   Purpose: Can be used for rendering xml to a compatible chart type. 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import ChartWizard dependencies by putting the following code in the head section
      		{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag 
   **** Having the call for chartwizard in a seperate script tag is mandatory *****
			<script type="text/javascript">
    			{visualization:editor-js()}
    			{visualization:editor(fn:doc("/pieData.xml")/feed)}
			</script> 
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td>
				<div id="editor" align="right" style="width: 800px; height: 400px; margin: 0 auto">//</div>
				<div align="center"><input type='button' onclick='openEditor()' value='Select Visualization' align="center" /></div>
			</td>
		...
		*** This chart needs a button (which can be replaced with an img too) for invoking the wizard ***	
	Supported/Required XML format:
	<feed>
		<data>
			<country>PG</country>
			<revenue>320077</revenue>
		</data>
		<data>
			<country>IQ</country>
			<revenue>215601</revenue>
		</data>
		....
	</feed>	

 4. Annotation Chart:
   Purpose: Can be used for event based chart representation e.g. stock prices and mkt conditions/events. 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import dependencies by putting the following code in the head section
      		{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag 
  			<script type="text/javascript">
			  {visualization:annotationChart(fn:doc("/annotations.xml")/feed)}
  			</script> 
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td><div id='chart_div_anno' style='width: 900px; height: 240px;'></div></td>
		...

	Supported/Required XML format:
		<feed>
			<bb>
				<date type="date">new Date(2011,12,1)</date>
				<item1 type="number">188</item1>
				<event1 type="string">71</event1>
				<eventdetails1 type="string">40</eventdetails1>
				<item2 type="number">56</item2>
				<event2 type="string">175</event2>
				<eventdetails2 type="string">32</eventdetails2>
			</bb>
			...
		</feed>
		** The data requirement for annotation requires a few considerations: 
		a) 'type' attribute is nercessary 
		    type can be : 1) date
		      			  2) number
		      			  3) string
		b) strcuture is important:
			1. date type - event occurance date 
			2. number type - share price/sale/purchase etc
			3. text - event title e.g. euro default
			4. text - event details e.g. euro defaulted causing a 200pt drop in mid afternoon 
  	
	    c) you can have as many events as you, please look at the sample file in the samples folder to get an overview

 5. GeoMap Chart:
   Purpose: Can be used for two column geo representations e.g. country + population. 
   for more column support use intensity charts mentioned below 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import dependencies by putting the following code in the head section
      		{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag 
  			<script type="text/javascript">
			  {visualization:geoMap(fn:doc("/geoMap.xml")/feed)}
  			</script> 
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td><div id="geo_chart"  style="width: 1000px; height: 300px; margin: 0 auto">//</div></td>
		...

	Supported/Required XML format:
		<feed>
			<data>
				<country>AU</country>
				<population>1332915</population>
			</data>
			...
		</feed>

 6. Intensity Chart:
   Purpose: Can be used for multiple column geo representations e.g. country + sales + cost + population. 
   for more column support use intensity charts mentioned below 
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import dependencies by putting the following code in the head section
      		{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag 
  			<script type="text/javascript">
			  {visualization:intensityMap(fn:doc("/intensityMap.xml")/feed)}
  			</script> 
   Step 4: Define the placeholder <div> in the body tag
   		...
			<td><div id="chart_div"  style="width: 800px; height: 300px; margin: 0 auto">//</div></td>
		...

	Supported/Required XML format:
		<feed>
			<data>
				<country>AU</country>
				<sales>23423423</sales>
				<purchase>45454564</purchase>
				<population>1332915</population>
			</data>
			...
		</feed>		

 7. Facet charts:
   Purpose: Can be used for visualizing all the search facets
   
   Usage notes:
   Step 1: Import the module 
     	import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";
   Step 2: Import dependencies by putting the following code in the head section
      		{visualization:importScripts()}	
   Step 3: place the call enclosed in a <script type..> </script> tag 
  			<script type="text/javascript">
				{ visualization:facet-charts(fn:doc("/facet-example.xml")/search:response)}
    		</script>
   
