note- MarkLogic 7 is not released yet!

# dashML

MarkLogic 7.0 introduces more tools for monitoring the performance of your MarkLogic server. dashML leverages these tools to make it easy to create lightweight, responsive dashboards giving you up-to-date information on the health and performance of your applications.
 
## Requirements

MarkLogic 7.0

## To install

First, you need to download and install MarkLogic 7.

Second, create an appserver, providing the following details;

* root: provide directory where dashml/src/xquery was copied to your filesystem
* set database: Meters
* set error handler: /rxq-rewriter.xqy?mode=error
* set rewrite handler: /rxq-rewriter.xqy?mode=rewrite

With everything setup, you can now point your web browser to http://localhost:####  (where ### is the port number you choose when setting up appserver) and you should see dashML homepage.

Click onto instructions tab or go direct to building dashboards.

## To install tests

create an appserver, providing the following details;

* root: provide directory where dashml/src ison your filesystem

Now point your web browser to http://localhost:####/xray which will run all tests

## FAQ

* 'X is not working' - make sure you have run long enough for meters to be generated (or switch to last 60 minutes)
* submit an [issue](https://github.com/xquery/dashML/issues)


## More Info on technologies

The following are links on the other technologies used in this application.

* RXQ github [repository](https://github.com/xquery/rxq).
* [purecss](http://purecss.io/) - css templates
* [EXQuery RESTXQ Draft Specification](http://exquery.github.com/exquery/exquery-restxq-specification/restxq-1.0-specification.html#method-annotation).
* Adam Retter's [RESTXQ](http://archive.xmlprague.cz/2012/presentations/RESTful_XQuery.pdf).
* [JSR-311](http://download.oracle.com/otndocs/jcp/jaxrs-1.0-fr-eval-oth-JSpec/).
 
The usage of RESTXQ annotations turns out to be a very concise way of building up flexible RESTFul interfaces, as well as providing the basis from which to create MVC architectures for our XQuery web applications.
