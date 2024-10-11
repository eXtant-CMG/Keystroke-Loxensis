<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:output method="html" media-type="text/html" encoding="UTF-8" indent="no" version="4.0"/>
    <xsl:preserve-space elements="*"/>
    <xsl:param name="sequences" select="//*/@seq"/>
    <xsl:param name="css-path" select="''"/>
    <xsl:template match="tei:TEI">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <meta charset="UTF-8"/>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous"/>
                <link rel="stylesheet" type="text/css" href="$app/data/user-uploads/css/custom_style.css"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/> - <xsl:value-of select="//tei:titleStmt/tei:author"/>
                </title>
                <script type="application/javascript">
                    var a = 0; 
                    var count = 0;
                </script>
            </head>
            <body>
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">
                            <xsl:value-of select="//tei:titleStmt/tei:author"/> | <xsl:value-of select="//tei:titleStmt/tei:title"/>
                        </a>
                    </div>
                </nav>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-5 col-md-4">

                            <div class="description">
                                <h2 align="left">
                                    <xsl:value-of select="//tei:titleStmt/tei:author"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:text>"</xsl:text>
                                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                                    <xsl:text>"</xsl:text>
                                </h2>
                                <h3 align="left">
                                    <xsl:text>Session </xsl:text>
                                    <xsl:value-of select="//tei:publicationStmt/tei:p[@corresp = 'session']"/>
                                </h3>
                                <ul class="list-unstyled">
                                    <xsl:apply-templates select="//tei:head"/>
                                    <ul class="list-unstyled">
                                        <li>
                                            <xsl:text>Date: </xsl:text>
                                            <xsl:value-of select="//tei:sourceDesc/tei:p/tei:l[1]"/>
                                        </li>
                                        <li>
                                            <xsl:text>Start time: </xsl:text>
                                            <xsl:value-of select="//tei:sourceDesc/tei:p/tei:l[2]"/>
                                        </li>
                                        <li>
                                            <xsl:text>Duration: </xsl:text>
                                            <xsl:value-of select="//tei:sourceDesc/tei:p/tei:l[3]"/>
                                        </li>
                                        <li>
                                            <xsl:text>Progression: </xsl:text>
                                            <xsl:text>session-version </xsl:text>
                                            <xsl:value-of select="//tei:publicationStmt/tei:p[@corresp = 'version']"/>
                                            <xsl:text>/</xsl:text>
                                            <xsl:value-of select="//tei:publicationStmt/tei:p[@corresp = 'total_versions']"/>
                                        </li>
                                    </ul>
                                </ul>
                                <h4>About the writing session:</h4>
                                <p>
                                    <xsl:apply-templates select="//tei:sourceDesc/tei:p[@n = 'description']"/>
                                </p>
                                <ul>
                                    <li> Total number of writing operations: <xsl:value-of select="count(//tei:mod[@type = 'continue'] | //tei:add[@type = 'context'] | //tei:add[@type = 'nt'] | //tei:add[@type = 'pre-context'] | //tei:add[@type = 'typo'] | //tei:add[@type = 'translocation'] | //tei:del[@type = 'context'] | //tei:del[@type = 'typo'] | //tei:del[@type = 'pre-context'] | //tei:del[@type = 'translocation'])"/>
                                        <!-- Counts all the writing operations, except visiting sources and the continuation of writing actions (e.g., type="context|continue"), and puts it in a list item -->
                                    </li>
                                    <li style="color: #843371"> Number of newly added sentences:
                                            <xsl:value-of select="count(//*[@type = 'nt'])"/>
                                    </li>
                                    <li style="color: #ff9900"> Number of returns to unfinished
                                        sentences: <xsl:value-of select="count(//tei:mod[@type = 'continue'])"/>
                                    </li>
                                    <li style="color: #377495"> Number of translocations:
                                            <xsl:value-of select="count(//tei:add[@type = 'translocation'])"/>
                                    </li>
                                    <li> Number of contextual revisions: <xsl:value-of select="count(//tei:*[@type = 'context'])"/>
                                        <ul>
                                            <li style="color: #04724D"> contextual additions:
                                                  <xsl:value-of select="count(//tei:add[@type = 'context'])"/>
                                            </li>
                                            <li style="color: #B20D30"> contextual deletions:
                                                  <xsl:value-of select="count(//tei:del[@type = 'context'])"/>
                                            </li>
                                        </ul>
                                    </li>
                                    <li> Number of pre-contextual revisions: <xsl:value-of select="count(//*[@type = 'pre-context'])"/>
                                        <ul>
                                            <li style="color: #7FB069;">
                                                <xsl:text>pre-contextual additions: </xsl:text>
                                                <xsl:value-of select="count(//tei:add[@type = 'pre-context'])"/>
                                            </li>
                                            <li style="color: #F35376">
                                                <xsl:text>pre-contextual deletions: </xsl:text>
                                                <xsl:value-of select="count(//tei:del[@type = 'pre-context'])"/>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <xsl:text>Number of typos: </xsl:text>
                                        <xsl:value-of select="count(//*[@type = 'typo'])"/>
                                        <ul>
                                            <li style="color: #BE7C4D">
                                                <xsl:text>typo related additions: </xsl:text>
                                                <xsl:value-of select="count(//tei:add[@type = 'typo'])"/>
                                            </li>
                                            <li style="color: #875531">
                                                <xsl:text>typo related deletions: </xsl:text>
                                                <xsl:value-of select="count(//tei:del[@type = 'typo'])"/>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <xsl:text>Number of times sources were consulted: </xsl:text>
                                        <xsl:value-of select="count(//tei:add[@type = 'focus'])"/>
                                    </li>
                                    <li>
                                        <xsl:text>Number of direct copies from sources: </xsl:text>
                                        <xsl:value-of select="count(//tei:add[@type = 'source'])"/>
                                    </li>
                                </ul>
                                <p>
                                    <button class="btn fa fa-info-circle" type="button" data-bs-toggle="collapse" data-bs-target="#collapseInfo" aria-expanded="false" aria-controls="collapseInfo" style="color:black"> </button>
                                </p>
                                <div class="collapse" id="collapseInfo">
                                    <div class="card card-body">
                                        <p>The default text is the text at the beginning of the writing session. To view the writing actions in the order they were made, use <i style="font-size:14px;" class="fa"></i>, or click through them at your own pace using <i onclick="decrease()" style="font-size:14px;cursor: pointer;" class="fa"></i> and <i onclick="increase()" style="font-size:14px;cursor: pointer;" class="fa"></i>. To see all the writing operations at the same time, use 'All writing operations'. Then choose whether you want to see all the deletions, insertions and typos by clicking on the 'Deletions', 'Insertions' or 'Typos' toggles. Symbols' shows all writing between symbols. Numbers of revisions' shows the numbers of the order of all changes in the text. The numbers can be enlarged using '<i style="font-size:12px" class="fa"></i> numbers'. 'Writing path' shows the path the writer took through
                                            the text and shows how linear the writing session
                                            was.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-7 word">

                            <xsl:apply-templates select="//tei:body/tei:p"/>
                        </div>
                        <div class="col-lg-1 col-md-1">
                            <div class="sticky-top">
                                <div style="text-align: center;">
                                    <i style="font-size:40px;margin-top: 10px;" class="fa"></i>
                                </div>
                                <p>
                                    <i style="font-size:24px;cursor: pointer;" class="fa start_btn"></i>
                                    <i onclick="stop()" style="font-size:24px;cursor: pointer;float: right;" class="fa stop_btn"></i>
                                </p>
                                <p>
                                    <i style="font-size:24px;cursor: pointer;" class="fa" id="countButton"></i>
                                    <i style="font-size:24px;cursor: pointer;float: right;" class="fa increase_btn"></i>
                                </p>
                                <div style="text-align: center;">
                                    <i style="font-size:24px;cursor: pointer" class="material-icons refresh_btn"></i>
                                </div>
                                <p id="demo" style="text-align: center;"/>
                            </div>
                        </div>

                    </div>
                    <div class="container-fluid fixed-bottom">
                        <div class="row">

                            <div class="col-lg-12 col-md-12 options" style="padding-bottom:15px;">  
                                Step <i style="font-size:20px;font-style: normal;">①</i>
                                <button class="button" onclick="showhiderevisions()">All writing
                                        operations<i id="checkrevisions" class="hide">✓</i>
                                </button>
                                Step <i style="font-size:20px;font-style: normal;">②</i>
                                <button class="button" onclick="showhidedeletions()">Deletions<i id="checkdel" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="showhideadditions()">Additions<i id="checkadd" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="showhidetypo()">Typos<i id="checktypo" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="symbols()">Symbols<i id="checksymbol" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="numbers()">Numbers<i id="checknumbers" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="BIGnumbers()">
                                    <i style="font-size:16px" class="fa"></i> Numbers<i id="checkmark" class="hide">✓</i>
                                </button>
                                <button class="button" onclick="createLine()">Writing path<i id="checkpath" class="hide">✓</i>
                                </button>   </div>

                        </div>
                    </div>
                </div>
                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"/>

                <script type="application/javascript">var rev = $(".add, .del, .cont, .chap").length;</script>
                <script src="$app/resources/js/script.js"/>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="//tei:teiHeader"/>

    <xsl:template match="//tei:sourceDesc">
        <p class="description">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <xsl:template match="//tei:head">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>



    <xsl:template match="//tei:p">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



    <xsl:template match="//tei:lb">
        <br xmlns="http://www.w3.org/1999/xhtml" style="display:none"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//tei:lb[@type = 'indent']">
        <br xmlns="http://www.w3.org/1999/xhtml" style="display:none"/>
        <span xmlns="http://www.w3.org/1999/xhtml" class="indent"/>
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="//tei:lb[@type = 'whiteline']">
        <br xmlns="http://www.w3.org/1999/xhtml"/>
        <xsl:apply-templates/>
        <span xmlns="http://www.w3.org/1999/xhtml" class="whiteline"/>
    </xsl:template>



    <xsl:template match="//tei:emph[@rend = 'italics']">
        <i xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <xsl:template match="//tei:emph[@rend = 'bold']">
        <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="//tei:title">
        <xsl:apply-templates/>
    </xsl:template>


    <xsl:template match="//tei:distinct[@rend = 'small-text']">
        <p xmlns="http://www.w3.org/1999/xhtml" style="font-size: 83%;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'nt']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <span xmlns="http://www.w3.org/1999/xhtml" class="add nt">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">★</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
    </xsl:template>

    <xsl:template match="//tei:add[@type = 'source']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <span xmlns="http://www.w3.org/1999/xhtml" class="add src">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">★</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
    </xsl:template>

    <xsl:template match="//tei:add[@type = 'nt|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <span xmlns="http://www.w3.org/1999/xhtml" class="add nt">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
    </xsl:template>


    <xsl:template match="//tei:mod[@type = 'continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <q xmlns="http://www.w3.org/1999/xhtml" class="cont">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">☆</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">☆</i>
        </q>
    </xsl:template>



    <xsl:template match="//tei:mod[@type = 'continue|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <q xmlns="http://www.w3.org/1999/xhtml" class="cont">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">☆</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">☆</i>
        </q>
    </xsl:template>



    <xsl:template match="//tei:del[@type = 'context']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">▷</i>
            <xsl:apply-templates/>
            <i class="symbol">▷</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>




    <xsl:template match="//tei:del[@type = 'context|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">▷</i>
            <xsl:apply-templates/>
            <i class="symbol">▷</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>




    <xsl:template match="//tei:del[@type = 'pre-context']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del pre-context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">◁</i>
            <xsl:apply-templates/>
            <i class="symbol">◁</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>



    <xsl:template match="//tei:del[@type = 'pre-context|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del pre-context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">◁</i>
            <xsl:apply-templates/>
            <i class="symbol">◁</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>


    <xsl:template match="//tei:add[@type = 'context']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">►</i>
            <xsl:apply-templates/>
            <i class="symbol">►</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'context|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">►</i>
            <xsl:apply-templates/>
            <i class="symbol">►</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'interdoc']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add interdoc">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:del[@type = 'interdoc']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <del xmlns="http://www.w3.org/1999/xhtml" class="del interdoc">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </del>
    </xsl:template>


    <xsl:template match="//tei:add[@type = 'pre-context']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add pre-context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">◀</i>
            <xsl:apply-templates/>
            <i class="symbol">◀</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'pre-context|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add pre-context">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">◀</i>
            <xsl:apply-templates/>
            <i class="symbol">◀</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>


    <xsl:template match="//tei:del[@type = 'typo']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <del xmlns="http://www.w3.org/1999/xhtml" class="del typo">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">△</i>
            <xsl:apply-templates/>
            <i class="symbol">△</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </del>
    </xsl:template>




    <xsl:template match="//tei:add[@type = 'typo']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add typo">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">▲</i>
            <xsl:apply-templates/>
            <i class="symbol">▲</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>




    <xsl:template match="//tei:add[@type = 'typo|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add typo">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">▲</i>
            <xsl:apply-templates/>
            <i class="symbol">▲</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:del[@type = 'translocation']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del trans">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">✧</i>
            <xsl:apply-templates/>
            <i class="symbol">✧</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>




    <xsl:template match="//tei:del[@type = 'translocation|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del trans">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">✧</i>
            <xsl:apply-templates/>
            <i class="symbol">✧</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'translocation']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add trans">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">✦</i>
            <xsl:apply-templates/>
            <i class="symbol">✦</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>

    <xsl:template match="//tei:add[@type = 'translocation|continue']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add trans">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">✦</i>
            <xsl:apply-templates/>
            <i class="symbol">✦</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </ins>
    </xsl:template>



    <xsl:template match="//tei:add[@type = 'focus']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <span xmlns="http://www.w3.org/1999/xhtml" class="add focus">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">✦</i>
            <xsl:apply-templates/>
            <i class="symbol">✦</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
        </span>
    </xsl:template>

    <xsl:template match="//tei:add[@type = 'layout']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add layout" style="color: #fff;display: none">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>.</ins>
    </xsl:template>

    <xsl:template match="//tei:del[@type = 'layout']">
        <i xmlns="http://www.w3.org/1999/xhtml" class="line">
            <xsl:attribute name="id">line<xsl:value-of select="@n"/>
            </xsl:attribute>
        </i>
        <s xmlns="http://www.w3.org/1999/xhtml" class="del layout">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <span class="p sup">
                <xsl:value-of select="@change"/>
            </span>
        </s>
    </xsl:template>
    
    <xsl:template match="//tei:metamark"/>
    
   
    
    <xsl:template match="tei:note"/>
    

</xsl:stylesheet>