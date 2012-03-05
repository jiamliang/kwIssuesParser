<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kw="http://www.klocwork.com/inForce/report/1.0">
<xsl:output method="html" encoding="GBK" version="4.0"/>
<xsl:param name="issueOwner">*</xsl:param>
<xsl:template match="/kw:errorList">
    <html>
      <head>
        <title>Klocwork Issues</title>
      </head>
	  <body>
	  <style type="text/css"> 
	/* CSS Document */ 
	body { 
		font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		background: #E6EAE9; 
	} 

	table { 
		border-collapse: collapse;
		empty-cells: show;
		width: 2000px; 
		padding: 0; 
		margin: 0; 
	} 

	caption { 
		padding: 0 0 5px 0; 
		width: 700px;      
		font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		text-align: left; 
	}

	th { 
		font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		border-top: 1px solid #C1DAD7; 
		letter-spacing: 2px; 
		text-transform: uppercase; 
		text-align: left; 
		padding: 5px 4px 4px 6px;    
		background: #CAE8EA; 
		word-break: keep-all;
	} 
	
	th.fst { 
		font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
		color: #4f6b72; 
		border-left: 1px solid #C1DAD7; 
		border-right: 1px solid #C1DAD7;
		border-bottom: 1px solid #C1DAD7; 
		border-top: 1px solid #C1DAD7; 
		letter-spacing: 2px; 
		text-transform: uppercase; 
		text-align: left; 
		padding: 5px 4px 4px 6px;    
		background: #CAE8EA; 
		word-break: keep-all;
		width: 30px;
	} 

	td { 
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px;   
		color: #4f6b72; 
	} 

	td.fst { 
		border-left: 1px solid #C1DAD7;
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px;    
		color: #4f6b72; 
		word-break: keep-all;
	} 
	td.E { 
		border-left: 1px solid #C1DAD7;
		border-right: 1px solid #C1DAD7; 
		border-bottom: 1px solid #C1DAD7; 
		background: #fff; 
		font-size:11px; 
		padding: 5px 4px 4px 6px;    
		color: #FF0000; 
	} 

	dt {
		color: #4f6b72;
	}

	dt.E {
		color: #FF0000;
	}
	
	</style> 
        <table>
          <tr>
            <th class = "fst" width="40px">ID</th>
			<th width="70px">Severity</th>
			<th width="60px">Owner</th>
            <th width="100px">Code</th>
            <th width="70px">state</th>
            <th width="70px">Status</th>
            <th width="200px">Message</th>
            <th width="250px">Location</th>
			<th width="800px">Trace</th>
          </tr>
		<xsl:if test="$issueOwner = '*'">
		  <xsl:for-each select="kw:problem">
			<xsl:sort select="number(kw:severitylevel)"/>
			<xsl:sort select="kw:owner"/>
			<xsl:sort select="number(kw:problemID)"/>
			
			<tr>
              <td class = "fst">
                <xsl:value-of select="kw:problemID"/>
              </td>
			  <xsl:if test="kw:displayAs = 'Error'">
			  <td class="E">
				  <xsl:value-of select="kw:severity"/>(<xsl:value-of select="kw:severitylevel"/>)
			  </td>	
			  </xsl:if>
			  <xsl:if test="kw:displayAs = 'Warning'">
			  <td>
				  <xsl:value-of select="kw:severity"/>(<xsl:value-of select="kw:severitylevel"/>)
			  </td>
			  </xsl:if>	
			  <td>
                <xsl:value-of select="kw:owner"/>
              </td>
			  <td style="word-break: break-all;">
                <xsl:value-of select="kw:code"/>
              </td>
			    
			  <td>
                <xsl:value-of select="kw:state"/>
              </td>
			  <td>
                <xsl:value-of select="kw:citingStatus"/>
              </td>
			  <td style="word-wrap: break-word;">
                <a>
					<xsl:attribute name="href"><xsl:value-of select="kw:url"/></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="kw:message"/>
				</a>
              </td>
			  <td>
			    File:<xsl:value-of select="kw:file"/><br />
				Method:<xsl:value-of select="kw:method"/><br />
				Line:<xsl:value-of select="kw:line"/><br />
				Column:<xsl:value-of select="kw:column"/>
              </td>
			  <td>
				<xsl:apply-templates select="./kw:trace/kw:traceBlock[@id = 0]"> 				
				</xsl:apply-templates>
              </td>
            </tr>
          </xsl:for-each>
		</xsl:if>	
		  <xsl:for-each select="kw:problem[kw:owner=$issueOwner]">
			<xsl:sort select="number(kw:severitylevel)"/>
			<xsl:sort select="kw:owner"/>
			<xsl:sort select="number(kw:problemID)"/>
			
			<tr>
              <td class = "fst">
                <xsl:value-of select="kw:problemID"/>
              </td>
			  <xsl:if test="kw:displayAs = 'Error'">
			  <td class="E">
				  <xsl:value-of select="kw:severity"/>(<xsl:value-of select="kw:severitylevel"/>)
			  </td>	
			  </xsl:if>
			  <xsl:if test="kw:displayAs = 'Warning'">
			  <td>
				  <xsl:value-of select="kw:severity"/>(<xsl:value-of select="kw:severitylevel"/>)
			  </td>
			  </xsl:if>	
			  <td>
                <xsl:value-of select="kw:owner"/>
              </td>
			  <td style="word-break: break-all;">
                <xsl:value-of select="kw:code"/>
              </td>
			    
			  <td>
                <xsl:value-of select="kw:state"/>
              </td>
			  <td>
                <xsl:value-of select="kw:citingStatus"/>
              </td>
			  <td style="word-wrap: break-word;">
                <a>
					<xsl:attribute name="href"><xsl:value-of select="kw:url"/></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="kw:message"/>
				</a>
              </td>
			  <td>
			    File:<xsl:value-of select="kw:file"/><br />
				Method:<xsl:value-of select="kw:method"/><br />
				Line:<xsl:value-of select="kw:line"/><br />
				Column:<xsl:value-of select="kw:column"/>
              </td>
			  <td>
				<xsl:apply-templates select="./kw:trace/kw:traceBlock[@id = 0]"> 				
				</xsl:apply-templates>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
	<xsl:template name="traceBlock" match="kw:traceBlock">
		<!--
		<xsl:variable name ="fileName1" select ="replace(current()/@file,'\\',':')" />
		-->
		<dl>
		<xsl:for-each select="kw:traceLine">
			<xsl:choose>
			<!-- type of "E"-->
			<xsl:when test="current()/@type = 'E'"> 
			<dt class="E">
				<span style="font-weight:bold; color:#996633">
				<xsl:analyze-string select="../@file" regex="[^\\|/]*.$">
					<xsl:matching-substring>
						[<xsl:value-of select="regex-group(0)"/>: 
					</xsl:matching-substring>
				</xsl:analyze-string>
				<xsl:value-of select="@line"/>]</span>: <xsl:value-of select="@text"/>
			</dt>
			<xsl:if test="current()/@refId != ''">
				<xsl:apply-templates select="../../kw:traceBlock[@id = current()/@refId]">
				</xsl:apply-templates>
			</xsl:if>
			</xsl:when>
			<!-- type of "C"-->
			<xsl:otherwise> 
			<dt>
				<span style="font-weight:bold">
				<xsl:analyze-string select="../@file" regex="[^\\|/]*.$">
					<xsl:matching-substring>					
						[<xsl:value-of select="regex-group(0)"/>: 
					</xsl:matching-substring>
				</xsl:analyze-string>
				<xsl:value-of select="@line"/>]</span>: <xsl:value-of select="@text"/>
			</dt>
			<xsl:if test="current()/@refId != ''"> 
				<!-- The following won't be reached, for this type of traceline will not be "Error" traceline -->
				<xsl:apply-templates select="../../kw:traceBlock[@id = current()/@refId]">
				</xsl:apply-templates>
			</xsl:if>
			
			</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		</dl>
	</xsl:template>
</xsl:stylesheet>