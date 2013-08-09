xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";

import module namespace view = "https://github.com/dashML/view"
  at "/xquery/modules/view.xqy";
  
import module namespace assert = "http://github.com/robwhitby/xray/assertions"
  at "/xray/src/assertions.xqy";

declare %test:case function check-homepage()
{
    let $results := view:home-page(())
    return assert:equal($results, <html xmlns="">
      <body>
	<h1>dashML</h1>
      </body>
      <script type="text/javascript" language="javascript" src="/resources/Saxon-CE_1.1/Saxonce/Saxonce.nocache.js"></script>
      <script type="application/xslt+xml" language="xslt2.0" src="/resources/dashml.xsl" data-initial-template="main"></script>
    </html>)
};


declare %test:case function check-meter-sample()
{
    let $results := view:meter-sample(())
    return assert:equal(exists($results),true())
};