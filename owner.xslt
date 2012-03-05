<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kw="http://www.klocwork.com/inForce/report/1.0">
	<xsl:output method="text" indent="no"/>
	<xsl:template match="/">
		<xsl:for-each-group select="/kw:errorList/kw:problem" group-by="./kw:owner">
			<xsl:sort select="kw:owner"/>
			<xsl:value-of select="current-grouping-key()"/>
			<xsl:text>
</xsl:text>
		</xsl:for-each-group>
	</xsl:template>
</xsl:stylesheet>
