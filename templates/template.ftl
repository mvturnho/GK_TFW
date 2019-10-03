<#ftl ns_prefixes={"s":"http://schemas.xmlsoap.org/soap/envelope/","a":"http://www.centric.eu/key2parkeren"}>
<#assign root = doc["s:Envelope"]["s:Body"]>
<#assign verg = root["a:Vergunning"]["a:Rvergunning"]>
<#assign k2pzknr = root["a:Vergunning"]["a:Rzaak"]>

<cases:attributeGroupsSaveMessage
    xsi:schemaLocation="http://www.emaxx.org/functional/cases http://www.emaxx.org/functional/cases/attributeGroupsSaveMessage.xsd"
    xmlns:tn="http://www.backend.com/testservice" xmlns:cases="http://www.emaxx.org/functional/cases"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <cases:attributeGroups>
        <cases:attributeGroup>
            <cases:name>GGR Aanvraag</cases:name>
            <cases:index>0</cases:index>
            <cases:attributes>
                <cases:attribute>
                     <cases:name>Vergunningnummer</cases:name>
                     <#if verg?has_content>
                        <cases:value>${verg}</cases:value>
                     <#else>
                        <cases:value>0000</cases:value>
                     </#if>
                </cases:attribute>
                <cases:attribute>
                     <cases:name>K2Pzaaknummer</cases:name>
                     <#if k2pzknr?has_content>
                        <cases:value>${k2pzknr}</cases:value>
                     <#else>
                        <cases:value>0000</cases:value>
                     </#if>
                </cases:attribute>
            </cases:attributes>
         </cases:attributeGroup>
    </cases:attributeGroups>
</cases:attributeGroupsSaveMessage>
