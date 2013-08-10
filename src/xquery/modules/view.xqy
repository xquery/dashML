xquery version "1.0-ml";

module namespace view = "https://github.com/dashML/view";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/meta/spec')
  %rxq:produces('text/html')
function view:home-page(
  $var1
)
{
<html>
<head>
<title>dashML Specification</title>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"></link>

</head>
<body>
<h1>dashML Specification</h1>
<p>Make it easy to create custom dashboard page of metrics, leveraging MarkLogic meters</p>
<h3>components</h3>
<ul>
  <li><a href="/dash/builder">dashboard builder</a>- interactive form for generating page using saxon-ce, generates a dash model </li>
  <li><a href="/dash/render">dashboard renderer</a>- renderer generates responsive design page of metrics</li>
</ul>
<h3>technology</h3>
<ul>
  <li>marklogic 7.0 meters</li>
  <li><a href="http://github.com/xquery/rxq" target="_new">rxq</a>- app framework</li>
  <li><a href="http://saxonica.com" target="_new">saxon-ce</a>- form handler</li>
  <li><a href="http://getbootstrap.com/" target="_new">bootstrap</a>- css/html5 template</li>
</ul>
<h3>models</h3>
<ul>
  <li>meters</li>
  <li>dash page that contains dash widget</li>
  <li>dash widgets</li>
</ul>
<h3>features</h3>
<ul>
  <li>generate page</li>
  <li>set alerts/limits</li>
  <li>make 'live'</li>
</ul>
<h3>test</h3>
<ul>
  <li><a href="http://localhost:9050/xray" target="_new">xray</a></li>
  <li></li>
</ul>
</body>
</html>
};


declare
  %rxq:GET
  %rxq:path('/dashml')
  %rxq:produces('text/html')
function view:overview-page(
  $var1
)
{
<html>
<head>
<title>dashML</title>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"></link>

</head>
<body>
<h1>dashML</h1>
<p>Easy to create dashboards for managing MarkLogic.</p>
<h3>Application</h3>
<ul>
  <li><a href="/dashml/builder">dashboard builder</a>- interactive form for generating page using saxon-ce, generates a dash model </li>
  <li><a href="/dashml/render">dashboard renderer</a>- renderer generates responsive design page of metrics</li>
</ul>
<h3>Model api</h3>
<ul>
  <li><a href="/data/history">history</a>- history endpoint for the application </li>
  <li><a href="/data/dash">dash</a>-dash endpoint</li>
</ul>
</body>
</html>
};

