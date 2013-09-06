xquery version "1.0-ml";

let $page :=<html>
<body>
<h2>Gzip test</h2>

{
for $a in (1 to 100)
    return
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec hendrerit tempor tellus. Donec pretium posuere tellus. Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla posuere. Donec vitae dolor. Nullam tristique diam non turpis. Cras placerat accumsan nulla. Nullam rutrum. Nam vestibulum accumsan nisl.</p>
}
</body>
</html>

return
    if(  contains(xdmp:get-request-header("Accept-Encoding"), "gzip") )
    then    
    (
        xdmp:set-response-content-type("text/html"),
        xdmp:add-response-header("Content-encoding", "gzip"),
        xdmp:gzip($page)
    )
    else    
    (
        xdmp:set-response-content-type("text/html"),
        $page
    )