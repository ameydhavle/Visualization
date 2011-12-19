xquery version "1.0-ml";
declare namespace html = "http://www.w3.org/1999/xhtml";
declare namespace search="http://marklogic.com/appservices/search";
import module namespace visualization = "marklogic-visualization" at "module-visualization/visualization.xqy";

xdmp:set-response-content-type("text/html"),
'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
<html>
	<head>
	 <link rel="stylesheet" type="text/css" href="http://visapi-gadgets.googlecode.com/svn/trunk/wordcloud/wc.css"/>
     <script type="text/javascript" src="http://visapi-gadgets.googlecode.com/svn/trunk/wordcloud/wc.js">//</script>
			{visualization:importScripts()}	
	<script type="text/javascript">
    {visualization:editor-js()}
    {visualization:editor(fn:doc("/pieData.xml")/feed)}
	</script> 
    <script type="text/javascript">
    {visualization:intensityMap(fn:doc("/intensityMap.xml")/feed)}
    {visualization:wordCloud(fn:doc("/wordCloud.xml")/feed)}
   	{visualization:dataTable(fn:doc("/visualization.xml")/feed)}
   	{visualization:annotationChart(fn:doc("/annotations.xml")/feed)}
    {visualization:geoMap(fn:doc("/geoMap.xml")/feed)}
    </script>
    
    <script type="text/javascript">
	{ visualization:facet-charts(fn:doc("/facet-example.xml")/search:response)}
    </script>
    <script type="text/javascript">
    function creatediv(id) {{
    var newdiv = document.createElement('div');
    newdiv.setAttribute('id', id);
    newdiv.setAttribute('style',"width: 800px; float: left; height: 200px; margin: 0 auto");
   
    newdiv.innerHTML = "nothing";
   document.body.appendChild(newdiv);
}} 
    </script>
   

 </head>
	<body>
	<table>
		<tr>
			<td><div id="barformat_div" align="right" style="width: 800px; height: 200px; margin: 0 auto">//</div></td>
			<td><div id="wcdiv" align="right" style="width: 200px; height: 200px; margin: 0 auto">//</div></td>
		</tr>
		<tr>
			<td><div id="editor" align="right" style="width: 800px; height: 400px; margin: 0 auto">//</div>
			<div align="center"><input type='button' onclick='openEditor()' value='Select Visualization' align="center" /></div>
			</td>
			<td><div id='chart_div_anno' style='width: 900px; height: 240px;'></div></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><div id='visualization' style='width: 900px; height: 240px;'></div></td>
		</tr>
		<tr>
			<td><div id="chart_div"  style="width: 800px; height: 300px; margin: 0 auto"></div></td>
			<td><div id="geo_chart"  style="width: 1000px; height: 300px; margin: 0 auto">//</div></td>
		</tr>		
	</table>
	</body>
</html>
