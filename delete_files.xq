xquery version "3.1";
declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $page-title := "Uploaded files";



let $upload-info :=
    <uploads>
        {
            for $resource in collection('/db/apps/textgenetic-KSL/data/user-uploads/tei')
            return
                <upload uri="{base-uri($resource)}" name="{util:unescape-uri(replace(base-uri($resource), ".+/(.+)$", "$1"), "UTF-8")}">
                {
                   xmldb:remove('/db/apps/textgenetic-KSL/data/user-uploads/tei')(: $resource/tei:TEI/tei:teiHeader//tei:title/text() :) 
                }
                </upload>
        }
    </uploads>
return
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
        <title data-template="config:app-title">Keystroke Loxensis</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"/>
        <meta data-template="config:app-meta"/>
       
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous"/>
        <!--JQuery-->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"/>
        <!-- Bootstrap CSS -->
        
        <link rel="stylesheet" href="$app/resources/css/style.css"/>
        
        
    </head>
    <body id="body">
        <div class="body-wrapper">
            <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:#347E70">
                    <div class="container-fluid" style="font-family: Courier New, Courier, monospace;">
                        <a class="navbar-brand" href="">
                        <b>Keystroke Loxensis</b><br/> a Text Genetic Keystroke Logging App</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"/>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="your_process">Uploader</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="uploads.html">Files</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="statistics.html">Statistics</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="https://extant-cmg.github.io/eXtant-wiki/">Documentation</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="https://extant-cmg.github.io/eXtant-wiki/loxensis/encoding">Encoding manual</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
               
            <div class="content-wrapper">
                <div id="content">The Uploaded files are successfully deleted</div>
            </div>
        </div>
        <footer class="container-fluid fixed-bottom" style="height:70px;background-color:#063828;color:white;border-top-style: dotted;">
            <div class="row align-items-end">
                <div class="col-4">
                    <a href="https://www.uantwerpen.be/en/research-groups/centre-for-manuscript-genetics/">
                        <img src="./resources/images/cmg_white.png" alt="CMG" height="50" class="d-inline-block align-text-bottom" style="margin-top:5px;"/>
                    </a>  <a href="https://clariahvl.hypotheses.org/">
                        <img src="./resources/images/clariah_def_white.png" alt="CLARIAH-VL" height="50" class="d-inline-block align-text-bottom"/>
                    </a>
                </div>
                <div class="col-4 text-center" style="font-size:60%;margin:10px">Developed Lamyk Bekius, in collaboration with Joshua Schäuble, Vincent Neyt, and Nooshin Shahidzadeh Asadi as part of <a class="footerlink" href="https://github.com/eXtant-CMG" target="_blank">
                        <b>eXtant</b>, a toolkit for digital scholarly editing</a>.</div>
                <div class="col-4 d-flex flex-row-reverse"/>
            </div> </footer>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"/>    
    </body>
</html>
