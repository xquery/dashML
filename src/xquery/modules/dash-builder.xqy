xquery version "1.0-ml";

module namespace builder = "https://github.com/dashML/builder";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/dashml/builder')
  %rxq:produces('text/html')
function builder:dash(
  $var1
)
{
<html>
<head>
<title>dashML builder</title>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"></link>

</head>
<body>
<h1>dashML builder</h1>

</body>
</html>
};



