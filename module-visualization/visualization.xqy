xquery version "1.0-ml";
module namespace visualization = "marklogic-visualization";

declare function visualization:importScripts(){
let $scripts:=
              <setup>
                <script type="text/javascript" src="/js/jquery-1.6.2.min.js">//</script>
				<script type="text/javascript" src="/js/jquery-ui-1.8.16.custom.min.js">//</script>
				<script type="text/javascript" src="/js/highcharts.js">//</script>
				<script type="text/javascript" src="http://www.google.com/jsapi">//</script>
				<script type="text/javascript" src="/js/jquery.gvChart-1.0.min.js">//</script>
				
               </setup> 
return $scripts//script
};

(: Chart editor:)

declare function visualization:get-visualization-data(){
let $a:=  <feed>
      	{
  		for $loop in (1 to 5) 
  		return 
  		<data>
			<month>{xdmp:strftime("%Y %m %d",fn:current-dateTime())}</month>
			<tide>{xdmp:random(250)}</tide>
			<nyquil>{xdmp:random(250)}</nyquil>
			<dayquil>{xdmp:random(250)}</dayquil>
			<duracell>{xdmp:random(250)}</duracell>
			<bounty>{xdmp:random(250)}</bounty>
			<downy>{xdmp:random(250)}</downy>
  		</data>
  		}	
  		</feed>
  		return $a
};


declare function visualization:editor-js(){
let $js:=xs:string("
	var wrapper;
	function openEditor() {
      var editor = new google.visualization.ChartEditor();
      google.visualization.events.addListener(editor, 'ok',
        function() {
          wrapper = editor.getChartWrapper();  
          wrapper.draw(document.getElementById('editor'));
      });
      editor.openDialog(wrapper);
    }
    google.setOnLoadCallback(testMe);
    google.load('visualization', '1', {packages: ['charteditor']});
")
return $js
};

declare function visualization:editor($arg as item()*){
 let $script := xs:string("
 	wrapper = new google.visualization.ChartWrapper({
    'dataTable':data,     
    options: {'title': 'Visualization'},    
    containerId: 'editor',
    chartType: 'LineChart'
      });
    wrapper.draw();
 ")
 let $prefix-script:=xs:string("function testMe() {")
 let $data:=
 (' var data = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return if($pos eq 1) then fn:data($c) else xs:integer($c)))
,'])',$script)
return ($prefix-script,$data,"}")
};
(: Chart editor code ends here:)

(: Intensity Maps :)
declare function visualization:get-intensity-data(){
let $arg:=  <feed>
      	{
        let $demo_countries := ('US','IN','CN','UK','ID','BR')
  		for $loop in (1 to 5) 
                let $index:= xdmp:random(3)+1
  		return 
            <data>
				<country>{$demo_countries[$index]}</country>
                <population>{xdmp:random(2500000)}</population>
				<area>{xdmp:random(2500000)}</area>
            	<sales>{xdmp:random(250000)}</sales>
			</data>
  		 }	
  		</feed>
  		return $arg
};

declare function visualization:intensityMap($arg as item()*){

 let $prefix_script:= xs:string("
      google.load('visualization', '1', {packages:['intensitymap']});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
 ")               
 let $script := xs:string("
 	    var chart = new google.visualization.IntensityMap(document.getElementById('chart_div'));
        chart.draw(data2, {});}
 ")
 let $data:=
 ($prefix_script,'var data2 = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return if($pos eq 1) then fn:data($c) else xs:integer($c)))
,'])',$script)
return $data
};

(: Intensity Maps code ends here:)

(: GeoMaps :)
declare function visualization:get-geo-data(){
let $arg:=  <feed>
      	{
        let $demo_countries := ('US','IN','CN','UK','ID','BR')
  		for $loop in (1 to 5) 
                let $index:= xdmp:random(3)+1
  		return 
            <data>
				<country>{$demo_countries[$index]}</country>
                <population>{xdmp:random(2500000)}</population>
			</data>
  		 }	
  		</feed>
  		return $arg
};

declare function visualization:geoMap($arg as item()*){

 let $prefix_script:= xs:string("
      google.load('visualization', '1', {'packages': ['geomap']});
      google.setOnLoadCallback(drawGeoChart);
      function drawGeoChart() {
 ")               
 let $script := xs:string("
 	    var geochart = new google.visualization.GeoMap(document.getElementById('geo_chart'));
        geochart.draw(geo_data, {});}
 ")
 let $data:=
 ($prefix_script,'var geo_data = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return if($pos eq 1) then fn:data($c) else xs:integer($c)))
,'])',$script)
return $data
};
(: GeoMaps code ends here:)


(: Word Cloud:)
declare function visualization:get-wordcloud-data(){
let $arg:=  <feed>
      	{
        let $demo_string := ('BigData Marklogic','MarkLogic BigData Analytics','BigData Analytics is great','BigData Analytics Visualization','MarkLogic Visualization','Visualization')
  		for $loop in (1 to 5) 
                let $index:= xdmp:random(3)+1
  		return 
            <data>
				<comment>{$demo_string[$index]}</comment>
				<text></text>
            </data>
  		 }	
  		</feed>
  		return $arg
};
declare function visualization:wordCloud($arg as item()*){
let $prefix_script:= xs:string("google.load('visualization', '1');
    google.setOnLoadCallback(draw);
      function draw() {
 ")               
 let $script := xs:string("
 	 var outputDiv = document.getElementById('wcdiv');
        var wc = new WordCloud(outputDiv);
        wc.draw(data2, null);}
 ")
 
 let $data:=
 ($prefix_script,'var data2 = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return fn:data($c)))
,'])',$script)
return $data

};

(: Word cloud code ends here:)

(: Datatable:)
(:Sample code with local data creation method:)
declare function visualization:dataTable(){
let $arg:= visualization:get-visualization-data()
let $prefix-script:=xs:string("
	  google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawbarTable);
 	  function drawbarTable(){")                
let $script := xs:string("
      var table = new google.visualization.Table(document.getElementById('barformat_div'));
	  var formatter = new google.visualization.BarFormat({width: 120});
  	  formatter.format(data_table, 3); 
  	  formatter.format(data_table, 2); 
  	  table.draw(data_table, {allowHtml: true, showRowNumber: true});}") 
let $data:=
 ($prefix-script,' var data_table = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return fn:data($c)))
,'])',$script)
return $data
};


declare function visualization:dataTable($arg as item()*){
let $prefix-script:=xs:string("
	  google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawbarTable);
 	  function drawbarTable(){")                
let $script := xs:string("
      var table = new google.visualization.Table(document.getElementById('barformat_div'));
	  var formatter = new google.visualization.BarFormat({width: 120});
  	  formatter.format(data_table, 3); 
  	  formatter.format(data_table, 2); 
  	  table.draw(data_table, {allowHtml: true, showRowNumber: true});}") 
let $data:=
 ($prefix-script,' var data_table = google.visualization.arrayToDataTable([',
 xdmp:to-json( for $c in $arg/node()[1]/element() return (fn:local-name($c))),
 for $r in $arg/node()
 return
 (",",xdmp:to-json(for $c  at $pos in $r/element() return fn:data($c)))
,'])',$script)
return $data
};


(: Datatable code ends here:)

(: Annotation chart:)
declare function visualization:get-columns($arg as item()*){
 let $column-decl:=xs:string("data.addColumn(")
 for $c in $arg/node()[1]/element()
 let $columns :=  fn:concat($column-decl,(fn:concat("'",fn:concat(fn:concat(fn:concat(xs:string($c/@type),"'"),",'"), fn:concat(fn:local-name($c),"'),")))))
return $columns
};

declare function visualization:get-rows($arg as item()*){
let $row-count:= fn:count($arg/node())
for $loop in 1 to $row-count
let $rows:= for $r in $arg/node()[$loop]
 return
 for $c in $r/element() 
 return 
 if($c/@type eq 'string') 
 then fn:concat(fn:concat("'", fn:data($c)),"',")
 else fn:concat(fn:data($c),",")
 return ("[",$rows,"],")
 };

declare function visualization:get-annotationTable($arg as item()*){
let $init-code:=xs:string("var data = new google.visualization.DataTable();")
(:Sample data  - comment when the data is fectched from from ML 
let $ in-doc:= <feed>{
  for $loop in (1 to 10) 
  return 
  <bb>
	<date type="date">new Date(2011,12,{xdmp:random(10)+1})</date>
	<item1 type="number">{xs:integer(xdmp:random(250))}</item1>
	<event1 type="string">{xs:string(xdmp:random(250))}</event1>
        <eventdetails1 type="string">{xdmp:random(250)}</eventdetails1>
	<item2 type="number">{xdmp:random(250)}</item2>
	<event2 type="string">{xdmp:random(250)}</event2>
	<eventdetails2 type="string">{xdmp:random(250)}</eventdetails2>
  </bb>
  }</feed>
:)
let $in-doc:=  $arg

return ($init-code,visualization:get-columns($in-doc),"data.addRows([", visualization:get-rows($in-doc),"]);")
};

declare function visualization:annotationChart($arg as item()*){
 let $init-code:= xs:string("google.load('visualization', '1', {'packages':['annotatedtimeline']});
      google.setOnLoadCallback(drawAnnotationChart);
      function drawAnnotationChart() {")
  let $postfix-code:=xs:string("var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div_anno'));
        chart.draw(data, {displayAnnotations: true});
      }")    
return ($init-code,visualization:get-annotationTable($arg),$postfix-code) 
};


