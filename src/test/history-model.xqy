xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";

import module namespace history-model = "https://github.com/dashML/model/history"
  at "/xquery/modules/history-model.xqy";
  
import module namespace assert = "http://github.com/robwhitby/xray/assertions"
  at "/xray/src/assertions.xqy";

declare namespace s="http://purl.oclc.org/dsdl/schematron";
declare namespace meter="http://marklogic.com/manage/meters";

declare option xdmp:mapping "false";

declare %test:setup function setup()
{
()
};

declare %test:teardown function teardown()
{
()
};

declare %test:case function test-database-meters()
{
let $meter :="active-fragment-count"
let $period := "hour"
let $start := ()
let $end   := ()
let $aggregation := "sum"
let $format := "xml"
let $summary := fn:true()
let $detail := fn:false()
let $databases := "Meters"
let $results :=
    history-model:get-database(
        $meter,$period,
        (),(),
        $aggregation,$format,
        $summary,$detail,
        ())
let $sch := <s:schema xmlns:meter="http://marklogic.com/manage/meters">
           <s:ns prefix="meter" uri="http://marklogic.com/manage/meters"/>
          <s:pattern name="check-response">
            <s:rule context="meter:master">
             <s:assert test="meter:active-fragment-count">should have "active-fragment-count".</s:assert>
            </s:rule>
            <s:rule context="meter:replica">
             <s:assert test="meter:active-fragment-count">should have "active-fragment-count".</s:assert>
            </s:rule>
          </s:pattern>
        </s:schema>

return
(
    (: assert:equal($results,()), :)
    assert:schematron-validate("validate database meters",$sch,$results)
)
};



declare %test:case function test-forest-meters()
{
let $meter :="active-fragment-count"
let $period := "hour"
let $start := ()
let $end   := ()
let $aggregation := "sum"
let $format := "xml"
let $summary := fn:true()
let $detail := fn:false()
let $databases := "Meters"
let $results :=
    history-model:get-forest(
        $meter,$period,
        (),(),
        $aggregation,$format,
        $summary,$detail,
        ())
let $sch := <s:schema xmlns:meter="http://marklogic.com/manage/meters">
           <s:ns prefix="meter" uri="http://marklogic.com/manage/meters"/>
          <s:pattern name="check-response">
            <s:rule context="meter:active-fragment-count">
             <s:assert test="meter:name eq 'active-fragment-count'">should have "active-fragment-count" as name.</s:assert>
            </s:rule>
          </s:pattern>
        </s:schema>

return
(
    (:assert:equal($results,()),:)
    assert:schematron-validate("validate forest meters",$sch,$results)
)
};


declare %test:case function test-host-meters()
{
let $meter :="core-threads"
let $period := "hour"
let $start := ()
let $end   := ()
let $aggregation := "sum"
let $format := "xml"
let $summary := fn:true()
let $detail := fn:false()
let $databases := "Meters"
let $results :=
    history-model:get-host(
        $meter,$period,
        (),(),
        $aggregation,$format,
        $summary,$detail,
        ())
let $sch := <s:schema xmlns:meter="http://marklogic.com/manage/meters">
           <s:ns prefix="meter" uri="http://marklogic.com/manage/meters"/>
          <s:pattern name="check-response">
            <s:rule context="meter:core-threads">
             <s:assert test="meter:name eq 'core-threads'">should have "core-threads" as name.</s:assert>
            </s:rule>
          </s:pattern>
        </s:schema>
return
(
    (:assert:equal($results,()),:)
    assert:schematron-validate("validate host meters",$sch,$results)
)
};



declare %test:case function test-server-meters()
{
let $meter := ("threads")
let $period := "hour"
let $start := ()
let $end   := ()
let $aggregation := ""
let $format := "xml"
let $summary := fn:true()
let $detail := fn:false()
let $servers := ()
let $results :=
    history-model:get-server(
        $meter,$period,
        (),(),
        $aggregation,$format,
        $summary,$detail,
        $servers)
let $sch := <s:schema xmlns:meter="http://marklogic.com/manage/meters">
           <s:ns prefix="meter" uri="http://marklogic.com/manage/meters"/>
          <s:pattern name="check-response">
            <s:rule context="meter:threads">
             <s:assert test="meter:name eq 'threads'">should have "threads" as name.</s:assert>
            </s:rule>
          </s:pattern>
        </s:schema>
return
(
    (:assert:equal($results,()), :)
    assert:schematron-validate("validate server meters",$sch,$results)
)
};
