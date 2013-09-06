xquery version "1.0-ml";

module namespace view = "https://github.com/dashML/view";

import module namespace dash-model = "https://github.com/dashML/model/dash"
  at "dash-model.xqy";
import module namespace history-model = "https://github.com/dashML/model/history"
  at "history-model.xqy";

declare namespace rxq="﻿http://exquery.org/ns/restxq";
declare namespace html="﻿http://www.w3.org/1999/xhtml";
declare namespace meter="http://marklogic.com/manage/meters";

declare default element namespace "https://github.com/dashML/model/dash";

declare
  %rxq:GET
  %rxq:path('/')
  %rxq:produces('text/html')
function view:spec() as element()
{
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>About - dashML</title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.2.1/base-min.css"></link>
</head>
<body>
<h1>About - dashML</h1>
<p>Make it easy to create custom dashboard page of metrics, leveraging MarkLogic meters</p>
<h3>components</h3>
<ul>
  <li><a href="/builder">dashboard builder</a>- interactive form for generating page using saxon-ce, generates a dash model </li>
</ul>
<h3>technology</h3>
<ul>
  <li>marklogic 7.0 meters</li>
  <li><a href="http://github.com/xquery/rxq" target="_new">rxq</a>- app framework</li>
  <li><a href="http://saxonica.com" target="_new">saxon-ce</a>- form handler</li>
</ul>
<h3>models</h3>
<ul>
  <li>history - meter time series</li>
  <li>dashboard - represents a single dashboard which can contain multiple widgets</li>
  <li>widgets - each widget represents a type</li>
</ul>
<h3>features</h3>
<ul>
  <li>builder
  <ul>
  <li>list dashboards</li>
  <li>set current dashboard for configuration</li>
  <li>add or remove widget to current dashboard</li>
  </ul>
  </li>
  <li>set alerts/limits</li>
  <li>make 'live'</li>
</ul>
<h3>test</h3>
<ul>
  <li><a href="http://localhost:9050/xray" target="_new">xray</a></li>
  <li></li>
</ul>
<h3>smokes and mirrors</h3>
<ul>
<li>I made GET do bad things (idempotent)</li>
</ul>
</body>
</html>
};


declare
  %rxq:GET
  %rxq:path('/builder')
  %rxq:produces('text/html')
function view:builder(
    $id
) as element()
{
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>dashML</title>
  <link rel="stylesheet" href="/resources/pure-min.css"></link>
  <style>
  <![CDATA[
  .pure-g > div {
        box-sizing: border-box;
    }
  .builder-div {
    border: 1px solid black;
    margin-left:5px;
    width:50%;
  }
  .dash-table {
    border: 1px solid black;
    margin-left:5px;
  }
  .widget-table {
    border: 1px solid black;
    margin-left:5px;
  }
  .render-div {
    margin-left:5px;
    border: 1px solid black;
    background: #eee;
    width:40%;
  }
  iframe{
    width:100%;
    height:100%;
    border:0px;
  }
  .menu-div{
    border-bottom: 1px;
  }
  h3 {
    float:right;
    margin-top:5px;
    margin-right:5px;
    font-weight: bold;
    color: rgb(75, 75, 75);
  }
  ]]>
  </style>
</head>
<body>
<div class="pure-menu pure-menu-open pure-menu-horizontal menu-div">
    <ul>
        <li><a href="/builder">dashML</a></li>
        <li><a href="/" target="render-frame">about</a></li>
    </ul>
</div>
<div class="pure-g-r">
    <div class="pure-u-1-2 builder-div">
    <h3>dashML builder</h3>
<br/>
    <form method="POST" action="/builder" class="pure-form">
      <fieldset>
        <table  class="pure-table dash-table">
         <thead>
        <tr>
            <th>dash name</th>
            <th colspan="2">actions</th>
        </tr>
    </thead>
    <tbody>
          {
              for $dash in dash-model:all()/dash-model:dash
              let $dash-id := $dash/@id/data(.)
              return
              <tr>
              <td>
                <a href="/builder/{$dash-id}">
                {$dash/dash-model:title/data()}
                </a>
              </td>
              <td>
                <a href="/render/{$dash-id}" target="render-frame" title="display dash" class="pure-button">
                render
                </a>
              </td>
              <td>
                <a href="/builder/delete/{$dash-id}" id="delete" title="delete dash" class="pure-button">delete</a>
              </td>
              </tr>
          }
    </tbody>
   </table>
   <input id="name" name="name" type="text"/><button id="create" title="add new dash" class="pure-button pure-button-primary">+ dash</button>
  </fieldset>
 </form>

{
 if($id) then   
 (<h3>
{dash-model:get($id)/dash-model:title/data()}
 </h3>,<br/>,<br/>)
 else ()
}
 <form method="POST" action="/builder/{$id}" class="pure-form">
   <table  class="pure-table widget-table">
     <thead>
       <tr>
         <th>title</th>
         <th>type</th>
         <th>meter</th>
         <th>actions</th>
       </tr>
     </thead>
     <tbody>
     {for $widget in dash-model:get($id)/dash-model:widget
     return
     <tr>
     <td>{$widget/dash-model:title/data()}</td>
     <td>{$widget/dash-model:type/data()}</td>
     <td>{$widget/dash-model:resource/data()}{$widget/dash-model:meter/data()}</td>
     <td><a href="/builder/widget/delete/{$id}/{$widget/@id/data()}" title="delete widget" class="pure-button">delete</a></td>
     </tr>
     }
     </tbody>
   </table><br/>
{
if($id) then
<div>
<input id="title" name="title" type="text"/>
<select name="type">
  <option>sparkline</option>
  <option>meter</option>
  <option>timeseries</option>
</select>
<select name="meter">
{history-model:get-metric-names()}
</select>
<button id="add-widget" class="pure-button pure-button-primary" title="add new widget">+ widget</button>
</div>
else ()
}
 </form>
<br/>
 </div>
 <div class="pure-u-1-2 render-div">
    <h3>dashML render</h3><br/>
    <iframe name="render-frame"/>
 </div>
</div>
</body>
</html>
};


declare
  %rxq:POST
  %rxq:path('/builder')
  %rxq:produces('text/html')
function view:handle-dash-post(
  $id
  )
{
    let $id :=
        dash-model:create( xdmp:get-request-field("name"),
        <dash xmlns="https://github.com/dashML/model/dash">
          <title>{xdmp:get-request-field("name")}</title>
          </dash>)
    return xdmp:redirect-response("/builder/" || $id)
};

declare
  %rxq:POST
  %rxq:path('/builder/(.*)?')
  %rxq:produces('text/html')
function view:handle-widget-post(
  $id
  )
{
    let $m := tokenize(xdmp:get-request-field("meter"),":")
    let $_ := dash-model:add-widget-to-dash(xs:unsignedLong($id),
        element widget {
            attribute id {xdmp:random(100000000000000)},
            element title { xdmp:get-request-field("title")},
            element type {xdmp:get-request-field("type")},
            element resource {$m[1]},
            element meter {$m[2]}
        }
     )
     return xdmp:redirect-response("/builder/" || $id  )
};



declare
  %rxq:GET
  %rxq:produces('text/html')
  %rxq:path('/builder/(.*)$')
function view:handle-configure(
  $id
)
{
    view:builder(xs:unsignedLong($id))
};


declare
  %rxq:GET
  %rxq:produces('text/html')
  %rxq:path('/builder/widget/delete/(.*)/(.*)')
function view:handle-widget-delete(
  $id,
  $widget-id
)
{
    let $_ := dash-model:remove-widget-to-dash(xs:unsignedLong($id),xs:unsignedLong($widget-id))
    return xdmp:redirect-response("/builder/" || $id)
};


declare
  %rxq:GET
  %rxq:produces('text/html')
  %rxq:path('/builder/delete/(.*)$')
function view:handle-delete(
  $id
)
{
    let $_ := dash-model:remove(xs:unsignedLong($id))
    return xdmp:redirect-response("/builder")
};

declare
  %rxq:GET
  %rxq:produces('text/html')
  %rxq:path('/render/(.*)?')
function view:handle-render(
  $id
)
{
let $xslt := <xsl:transform
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:meter="http://marklogic.com/manage/meters"
    xmlns:model="https://github.com/dashML/model/dash"
    xmlns:xdmp="http://marklogic.com/xdmp"
    xmlns:history-model ="https://github.com/dashML/model/history"
    exclude-result-prefixes="xdmp xs meter"
    extension-element-prefixes="xdmp history-model"
    version="2.0">

<xdmp:import-module namespace="https://github.com/dashML/model/history"
                    href="modules/history-model.xqy"/>

   <xsl:template match="model:dash">
     <div class="pure-g-r">
       <xsl:apply-templates select="model:widget"/>
     </div>
   </xsl:template>

   <xsl:template match="model:widget[model:type eq 'sparkline']">
     <xsl:variable name="data" select="
     if(model:resource eq 'databases')
         then
         history-model:get-database(
  model:meter/string(),'raw',
  (),current-dateTime(),
  'sum','xml',true(),false(),
  ())
  else if (model:resource eq 'hosts') then
      history-model:get-host(
  model:meter/string(),'raw',
  (),current-dateTime(),
  'sum','xml',true(),false(),
  ())
  else if (model:resource eq 'servers') then
      history-model:get-server(
  model:meter/string(),'raw',
  (),current-dateTime(),
  'sum','xml',true(),false(),
  ())
  else
      history-model:get-forest(
  model:meter/string(),'raw',
  (),current-dateTime(),
  'sum','xml',true(),false(),
  ())
     "/>
     <div  title="{{$data//*:desc}}" class="pure-u-1-3 dashboard-piece dashboard-piece-{{if(model:resource eq 'servers') then 'blue'
     else if(model:resource eq 'hosts') then 'purple'
     else if(model:resource eq 'forests') then 'orange' 
     else 'gray'}}bg">
       <div class="dashboard-content">
       <span style="float:right;font-size:80%;margin:0px;padding:0px;color:#eee"><xsl:value-of select="model:resource"/></span><br/>
       <span style="font-size: 2.0em;line-height: 1;"><xsl:value-of select="model:meter"/></span>
       <h2>
             <span class="inlinesparkline">
             <xsl:value-of select="string-join($data/*:summary/*:data/*:entry/*:value,',')"/>
             </span>
       </h2>
       <p class="dashboard-metric"><xsl:value-of select="$data/*:summary/*:data/*:entry[last()]/*:value"/> <span class="units"><xsl:value-of select="$data/*:units"/></span></p>

      <span class="xml">[
       <a href="http://localhost:8002/manage/v2/{{model:resource}}?view=metrics&amp;{{replace(model:resource,'s$','')}}-metrics={{model:meter}}&amp;period=raw&amp;format=xml" target="_xml">xml</a> |
       <a href="http://localhost:8002/manage/v2/{{model:resource}}?view=metrics&amp;{{replace(model:resource,'s$','')}}-metrics={{model:meter}}&amp;period=raw&amp;format=html" target="_html">html</a> |
       <a href="http://localhost:8002/manage/v2/{{model:resource}}?view=metrics&amp;{{replace(model:resource,'s$','')}}-metrics={{model:meter}}&amp;period=raw&amp;format=json" target="_json">json</a>
      ]</span>
       </div>
       
     </div>
            
   </xsl:template>

   <xsl:template match="model:widget[model:type eq 'meter']">
       <div class="pure-u-1-4">
       display meter widget<br/>
       <a href="/history/{{model:resource}}/{{model:meter}}/raw">link</a>
       meter:<xsl:value-of select="model:resource"/>:<xsl:value-of select="model:meter"/>
       </div>
   </xsl:template>

   <xsl:template match="model:widget[model:type eq 'timeseries']">
     <div class="pure-u-1-4">
     display timeseries widget<br/>
       <a href="/history/{{model:resource}}/{{model:meter}}/raw">xml</a>
       meter:<xsl:value-of select="model:resource"/>:<xsl:value-of select="model:meter"/>
     </div>
   </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>


let $xml  := dash-model:get(xs:unsignedLong($id))
let $result := xdmp:xslt-eval($xslt,$xml)
return
('<!DOCTYPE html>',
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>dashML</title>
<meta name="description" content=""/>
<meta name="viewport" content="width=device-width"/>
<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.1.0/pure-min.css"></link>
<link rel="stylesheet" href="http://weloveiconfonts.com/api/?family=fontawesome"></link>
<link rel="stylesheet" href="/resources/css/main.css"></link>
<link rel="stylesheet" href="/resources/css/custom.css"></link>
<script src="/resources/js/vendor/modernizr-2.6.2.min.js">>&#160;</script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js">&#160;</script>
  <script type="text/javascript" language="javascript" src="/resources/sparkle/sparkle.js">&#160;</script>
  <script type="text/javascript">
  $(function() {{
      $('.inlinesparkline').sparkline('html',{{type:'line',height:80,width:200}});
  }})
</script>
</head>
<body>

  <header>
    <nav class="pure-menu pure-menu-open pure-menu-horizontal pure-menu-blackbg">
      <ul>
        {for $d in dash-model:all()/*
        return
        <li class="{if($d/@id/string(.) eq $id) then 'pure-menu-selected' else ()}"><a href="/render/{$d/@id}" >{$d/dash-model:title/data(.)}</a></li>
        }
      </ul>
      <span class="make-live"> Live <input id="makelive" type="checkbox" title="make live"/> refresh (secs) <input id="refresh" size="2" type="text" value="10"/></span>
    </nav>
  </header>

  <section class="dashboard pure-g-r clearfix">
    {$result}
  </section>

  <footer>
  &copy; 2013 MarkLogic
  </footer>
  
  <script src="/resources/js/plugins.js">&#160;</script>
  <script src="/resources/js/main.js">&#160;</script>


  
</body>
</html>
)
};

declare
  %rxq:GET
  %rxq:path('/history/databases/(.*)/(.*)(/?)')
  %rxq:produces('application/xml')
function view:get-databases(
  $meter,
  $period,
  $start
)
{
let $result := history-model:get-database(
  $meter,$period,
  (),current-dateTime(),
  "sum","xml",true(),false(),
  ())
return $result[1]/*
};

declare
  %rxq:GET
  %rxq:path('/history/forests/(.*)/(.*)(/?)')
  %rxq:produces('application/xml')
function view:get-forests(
  $meter,
  $period,
  $start
)
{
let $result := history-model:get-forest(
  $meter,$period,
  (),current-dateTime(),
  "sum","xml",true(),false(),
  ())
return $result
};

declare
  %rxq:GET
  %rxq:path('/history/servers/(.*)/(.*)(/?)')
  %rxq:produces('application/xml')
function view:get-servers(
  $meter,
  $period,
  $start
)
{
let $result := history-model:get-server(
  $meter,$period,
  (),current-dateTime(),
  "sum","xml",true(),false(),
  ())
return $result
};


declare
  %rxq:GET
  %rxq:path('/history/hosts/(.*)/(.*)(/?)')
  %rxq:produces('application/xml')
function view:get-hosts(
  $meter,
  $period,
  $start
)
{
let $result := history-model:get-host(
  $meter,$period,
  (),current-dateTime(),
  "sum","xml",true(),false(),
  ())
return $result
};