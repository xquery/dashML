dashML
======

meter dashboard for MarkLogic

Requirements
------------

MarkLogic 7.0


To install
----------

First, you need to download and install MarkLogic 7. Second, create an appserver, providing the following details;

* root: provide directory where dashml/src/xquery ison your filesystem
* set error handler: /rxq-rewriter.xqy?mode=error
* set rewrite handler: /rxq-rewriter.xqy?mode=rewrite

With everything setup, you can now point your web browser to the created app (e.g. http://localhost:####) and you should see dashML homepage.

