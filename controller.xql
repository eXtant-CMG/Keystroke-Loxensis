xquery version "3.0";

import module namespace ksl = "http://exist-db.org/apps/textgenetic-KSL/ksl" at "modules/textgenetic_ksl.xql";
import module namespace config = "http://exist-db.org/apps/textgenetic-KSL/config" at "modules/config.xqm";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

if ($exist:path eq '') then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{request:get-uri()}/"/>
    </dispatch>
        
else if ($exist:path eq "/" or $exist:path eq "/index.html" or ends-with($exist:path, "/home")) then
    (: forward root path to index.xql :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/templates/index.html">
            <set-header name="Cache-Control" value="no-cache"/>
            <cache-control cache="no"/>
        </forward>
        <view>
            <forward url="{$exist:controller}/modules/view.xql">
                <set-header name="Cache-Control" value="no-cache"/>
                <cache-control cache="no"/>
            </forward>
        </view>
    </dispatch>
else if ($exist:path eq "/uploads.html" or $exist:path eq "/statistics.html" or $exist:path eq "/novel.html" or $exist:path eq "/HowTo.html" or $exist:path eq "/documentation.html") then
    (: forward root path to about.html :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/templates{$exist:path}">
            <set-header name="Cache-Control" value="no-cache"/>
            <cache-control cache="no"/>
        </forward>
        <view>
            <forward url="{$exist:controller}/modules/view.xql">
                <set-header name="Cache-Control" value="no-cache"/>
                <cache-control cache="no"/>
            </forward>
        </view>
    </dispatch>
else if (contains($exist:path, "/$app/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/{substring-after($exist:path, '/$app/')}">
            <set-header name="Cache-Control" value="no-cache"/>
            <cache-control cache="no"/>
        </forward>
       <!-- <view>
            <forward url="{$exist:controller}/modules/view.xql">
                <set-header name="Cache-Control" value="no-cache"/>
                <cache-control cache="no"/>
            </forward>
        </view>-->
    </dispatch>
else if (contains($exist:path,"/user-uploads/genetics/") and not(ends-with($exist:path,'.css'))) then
    let $mypath := substring-after($exist:path,"/user-uploads/genetics/")
    return 
        ksl:transform($mypath)    
else if (contains($exist:path,"/user-uploads/" ) and not(ends-with($exist:path,'.css'))) then
    let $mypath := substring-after($exist:path,"/user-uploads/")
    return 
        ksl:user-transform($mypath)

else if (contains($exist:path,"/your_process")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/templates/uploader.html">
                <set-header name="Cache-Control" value="no-cache"/>
                <cache-control cache="no"/>
        </forward>
        <view>
             <forward url="{$exist:controller}/modules/view.xql">
                <set-header name="Cache-Control" value="no-cache"/>
             </forward>
        </view>
    </dispatch>
else if (ends-with($exist:resource, ".html")) then
    (: the html page is run through view.xql to expand templates :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <view>
            <forward url="{$exist:controller}/modules/view.xql">
            <   set-header name="Cache-Control" value="no-cache"/>
            </forward>
        </view>
		<error-handler>
			<forward url="{$exist:controller}/error-page.html" method="get"/>
			<forward url="{$exist:controller}/modules/view.xql"/>
		</error-handler>
    </dispatch>
(: Resource paths starting with $shared are loaded from the shared-resources app :)
else if (contains($exist:path, "/$shared/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="/shared-resources/{substring-after($exist:path, '/$shared/')}">
            <set-header name="Cache-Control" value="max-age=3600, must-revalidate"/>
        </forward>
    </dispatch>
    (: Resource paths starting with $shared are loaded from the shared-resources app :)
else
    (: everything else is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="no"/>
    </dispatch>
