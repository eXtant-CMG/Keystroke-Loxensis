xquery version "3.1";
module namespace stats="http://exist-db.org/apps/textgenetic-KSL/stats";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";

(: Gets some statistics from the files :)
declare function stats:all-stats($node as node(), $model as map(*)) {
      <div id="main">
            <div class="zui-wrapper">
                <div class="zui-scroller">
                    <table class="zui-table">
                        <tbody>
                            <tr>
                                <th class="zui-sticky-col">File name</th>
                                <th style="padding: 2px;">Text title</th>
                                <th style="padding: 2px;">Author</th>
                                <th style="padding: 2px;">Date</th>
                                <th style="padding: 2px;">Duration</th>
                                <th style="padding: 2px;" class="emphasis">Writing actions</th>
                                <th style="padding: 2px;" class="emphasis">New text</th>
                                <th style="padding: 2px;">Returns to leading edge</th>
                                <th style="padding: 2px;" class="emphasis">Contextual (all)</th>
                                <th style="padding: 2px;">Contextual (add)</th>
                                <th style="padding: 2px;">Contextual (del)</th>
                                <th style="padding: 2px;"class="emphasis">Pre-contextual (all)</th>
                                <th style="padding: 2px;">Pre-contextual (add)</th>
                                <th style="padding: 2px;">Pre-contextual (del)</th>
                                <th style="padding: 2px;">Trans-locations</th>
                                <th style="padding: 2px;"class="emphasis">Typos (all)</th>
                                <th style="padding: 2px;">Typo (add)</th>
                                <th style="padding: 2px;">Typo (del)</th>
                                <th style="padding: 2px;">Sources</th>
                            </tr>
                            {
                            let $data-collection := $config:data-root||"/user-uploads"
                            for $resource in collection($data-collection)
                            let $uri := base-uri($resource)
                            return
                            <tr>
                                <th class="zui-sticky-col" >
                                   <a class="link" href="{concat('data/user-uploads/tei/',util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8"))}">
                                       {util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8")}
                                   </a>
                                </th>
                                <td>{$resource/tei:TEI/tei:teiHeader//tei:title/text()}</td>
                                <td>{$resource/tei:TEI/tei:teiHeader//tei:author/text()}</td>
                                <td>{$resource//tei:sourceDesc/tei:p/tei:l[1]/text()}</td>
                                <td>{$resource//tei:sourceDesc/tei:p/tei:l[3]/text()}</td>
                                <td class="emphasis">{count($resource//tei:mod[@type = 'continue'] | $resource//tei:add[@type = 'context'] | $resource//tei:add[@type = 'nt'] | $resource//tei:add[@type = 'pre-context'] | $resource//tei:add[@type = 'typo'] | $resource//tei:add[@type = 'translocation'] | $resource//tei:del[@type = 'context'] | $resource//tei:del[@type = 'typo'] | $resource//tei:del[@type = 'pre-context'] | $resource//tei:del[@type = 'translocation'])}</td>
                                <td class="emphasis">{count($resource//tei:add[@type = 'nt']/tei:seg | $resource//tei:seg/tei:add[@type = 'nt'] | $resource//tei:seg/tei:del/tei:add[@type = 'nt'])}</td>
                                <td>{count($resource//tei:mod[@type = 'continue'])}</td>
                                <td class="emphasis">{count($resource//tei:add[@type = 'context'] | $resource//tei:del[@type = 'context'])}</td>
                                <td>{count($resource//tei:add[@type = 'context'])}</td>
                                <td>{count($resource//tei:del[@type = 'context'])}</td>
                                <td class="emphasis">{count($resource//tei:add[@type = 'pre-context'] | $resource//tei:del[@type = 'pre-context'])}</td>
                                <td>{count($resource//tei:add[@type = 'pre-context'])}</td>
                                <td>{count($resource//tei:del[@type = 'pre-context'])}</td>
                                <td>{count($resource//tei:add[@type = 'translocation'])}</td>
                                <td class="emphasis">{count($resource//tei:add[@type = 'typo'] | $resource//tei:del[@type = 'typo'])}</td>
                                <td>{count($resource//tei:add[@type = 'typo'])}</td>
                                <td>{count($resource//tei:del[@type = 'typo'])}</td>
                                <td>{count($resource//tei:add[@type = 'focus'])}</td>
                            </tr>
                            }
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
};