xquery version "3.1";

module namespace app="http://exist-db.org/apps/textgenetic-KSL/templates";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";

(:~
 : This is a sample templating function. It will be called by the templating module if
 : it encounters an HTML element with an attribute: data-template="app:test" or class="app:test" (deprecated). 
 : The function has to take 2 default parameters. Additional parameters are automatically mapped to
 : any matching request or function parameter.
 : 
 : @param $node the HTML node with the attribute which triggered this call
 : @param $model a map containing arbitrary data - used to pass information between template calls
 :)
declare function app:test($node as node(), $model as map(*)) {
      <ul>
    {
        let $data-collection := $config:data-root||"/user-uploads"
        for $resource in collection($data-collection)
        let $uri := base-uri($resource)
        return
            <li><a href="{concat('data/user-uploads/genetics/personal/tei/',util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8"))}">
            {
                $resource/tei:TEI/tei:teiHeader//tei:title/text()
                }
                name="{util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8")}"
            </a>
            </li>
    }
</ul>  
    
};


declare function app:resourceMetadataForm($node as node(), $model as map(*), $entrypoint as xs:string?){

let $resourceID := if (session:get-attribute("fileId")) then session:get-attribute("fileId") else local:createUniqueID()
let $collectionID := session:set-attribute("fileId", $resourceID)
   
(:let $newDoc := admin:createDocument($entrypoint):)
return
    <div id="yourForm" class="col-sm-11" data-resId="{$resourceID}">
        <form>
             <div id="upload-panel" class="form-group row">
                <div class="col-sm-9">
                    <div class="upload-drop-zone btn-block fileinput-button">
                        <span>Drop files here or click to browse your system for files. </span>
                    </div>
                    <!--the upload button is hidden and a click on the drag-and-dop div is redirected to this hidden button-->
                    <input id="fileupload" class="hiddenUploadButton" type="file" name="files[]" multiple="multiple" />
                    <!-- The global progress bar -->
                    <div id="progress" class="progress">
                        <div class="progress-bar progress-bar-success"></div>
                    </div>
                    <!-- The container for the uploaded files -->
                    <table id="files-table" class="files table table-striped">
                        <thead>
                            <tr>
                                <th>filename</th>
                                <th>folder</th>
                            </tr>
                        </thead>
                        <tbody id="files"></tbody>
                    </table>
                </div>
            </div>
        </form>
    </div>
};



(:recursive function to produce a new module-,collection-, or resource-id that is not yet in use:)
declare function local:createUniqueID(){
    let $testId := fn:tokenize(util:uuid(),'-')[1]
    let $idExist := collection($config:data-root)//id($testId)
    return if ($idExist) then ( local:createUniqueID() ) else $testId 
};
