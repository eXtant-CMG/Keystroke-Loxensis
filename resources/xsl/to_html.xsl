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
                <link rel="stylesheet" type="text/css" href="$app/data/user-uploads/css/notes_view_style.css"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/> -
                    <xsl:value-of select="//tei:titleStmt/tei:author"/>
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
                        <div class="col-lg-2 col-md-2">
                            
                            <div class="description">
                                
                                
                               <h4>Focus events</h4>
                                <xsl:apply-templates select="//tei:body/tei:p[2]"/>
                                
                            </div>
                        </div>
                        
                        <div class="col-lg-6 col-md-6 word">
                            <h4>Text</h4>
                            <xsl:apply-templates select="//tei:body/tei:p[1]"/>
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
                        <div class="col-lg-3 col-md-3 sticky">
                            <div>
                                <h4>Notes</h4>
                            <xsl:apply-templates select="//tei:body/tei:p[3]"/>
                            </div>
                        </div>
                    </div>
                    <div class="container-fluid fixed-bottom">
                        <div class="row">
                            
                            <div class="col-lg-12 col-md-12 options" style="padding-bottom:15px;">   Step <i style="font-size:20px;font-style: normal;">①</i>
                                <button class="button" onclick="showhiderevisions()">All writing operations<i id="checkrevisions" class="hide">✓</i>
                                </button> Step <i style="font-size:20px;font-style: normal;">②</i>
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
                                <button class="button" onclick="showhidenotes()">Notes<i id="checknotes" class="hide">✓</i>
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
        <span xmlns="http://www.w3.org/1999/xhtml" class="add nt">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">★</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//tei:add[@type = 'source']">
        <span xmlns="http://www.w3.org/1999/xhtml" class="add src">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">★</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:add[@type = 'nt|continue']">
        <span xmlns="http://www.w3.org/1999/xhtml" class="add nt">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">★</i>
        </span>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:add[@type = 'rt']">
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add rt">
            <xsl:attribute name="id">
            <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:add[@type = 'rt|continue']">
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add rt">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:mod[@type = 'continue']">
        <q xmlns="http://www.w3.org/1999/xhtml" class="cont">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">☆</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">☆</i>
        </q>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:mod[@type = 'continue|continue']">
        <q xmlns="http://www.w3.org/1999/xhtml" class="cont">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <i class="symbol">☆</i>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
            <xsl:apply-templates/>
            <i class="symbol">☆</i>
        </q>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
   
    
    <xsl:template match="//tei:del[@type = 'context']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:del[@type = 'context|continue']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template match="//tei:del[@type = 'pre-context']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:del[@type = 'pre-context|continue']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:add[@type = 'context']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:add[@type = 'context|continue']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:add[@type = 'interdoc']">
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add interdoc">
            <xsl:attribute name="id">
            <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
            <xsl:value-of select="@n"/>
            </span>
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:del[@type = 'interdoc']">
        <del xmlns="http://www.w3.org/1999/xhtml" class="del interdoc">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
        </del>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:add[@type = 'pre-context']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:add[@type = 'pre-context|continue']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="//tei:del[@type = 'typo']">
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
        </del>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template match="//tei:add[@type = 'typo']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template match="//tei:add[@type = 'typo|continue']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:del[@type = 'translocation']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template match="//tei:del[@type = 'translocation|continue']">
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
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template match="//tei:add[@type = 'translocation']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="//tei:add[@type = 'translocation|continue']">
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
        </ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
   
    
    <xsl:template match="//tei:add[@type = 'focus']">
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
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    
    
    
    <xsl:template match="//tei:add[@type = 'layout']">
        <ins xmlns="http://www.w3.org/1999/xhtml" class="add layout" style="color: #fff;display: none">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>.</ins>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:time">
        (<xsl:apply-templates/>)
    </xsl:template>
    
    
    <xsl:template match="//tei:del[@type = 'layout']">
        <s xmlns="http://www.w3.org/1999/xhtml" class="del layout">
            <xsl:attribute name="id">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <span class="n sup">
                <xsl:value-of select="@n"/>
            </span>
        </s>
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="//tei:metamark">
        
        <xsl:if test="@ana">
            <b>
                <xsl:attribute name="class">notes note<xsl:value-of select="@ana"/>
                </xsl:attribute>
                <i class="fa fa-pencil-square-o"/>
                <xsl:value-of select="@ana"/>
            </b>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <div>
            <xsl:attribute name="class">notes note<xsl:value-of select="@corresp"/>
        </xsl:attribute>
        <b> <xsl:value-of select="@corresp"/>
            </b>-
        <xsl:apply-templates/>
        </div>
        <br/>
    </xsl:template>

</xsl:stylesheet>