<#ftl encoding='UTF-8'>
<#-- Template Key2Parkeren tbv Gehandicapten
parkeerkaart -->
<#-- version 1.0 -->
<#-- Zaaktypecode: P4_1_GGP
Zaaktypenaam: Gehandicaptenparkeerkaart bezoeker behandelen -->
<#-- -->
<#assign aDateTime = .now />
<#assign tijdstipBericht = aDateTime?string["yyyyMMddHHmmss"]+'000' />
<#assign startDate = case.startDate?datetime?string["yyyyMMdd"] />
<#assign registrationDate = case.registrationDate?datetime?string["yyyyMMdd"] />
<#assign registrationTime = case.registrationDate?datetime?string["HHmmss"] />
<#-- eigenschappen opvragen -->
<#function eigenschap group attr>
	<#list cags?keys as cag>
		<#if cag.name == group>
			<#list cag.attributes as cav>
				<#if cav.name == attr>
					<#return cav.value>
				</#if>
			</#list>
		</#if>
	</#list>
	<#return undef>
</#function>

<#function kenteken_indicatie group attr>
	<#assign ki = eigenschap(group,attr)>
	<#if ki='mijn'>
		<#return 'P'>
	<#elseif ki='bedrijf'>
		<#return 'B'>
	<#elseif ki='lease'>
		<#return 'L'>
	</#if>
	<#return 'O'>
</#function>

<S:Envelope
	xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
	<S:Body>
		<Vergunningaanvraag
			xmlns="http://www.centric.eu/key2parkeren">
			<Algemeen>
				<Aanvraagnummer>${case.identification}</Aanvraagnummer>
				<Aanvraagdatum>${registrationDate}</Aanvraagdatum>
				<BSN>${case.initiatingActor.person.citizenNumber}</BSN>
				<Kgbr>344</Kgbr>
				<Oref>${case.identification}</Oref>
			</Algemeen>
			<Persoon>
				<Geslachtsnaam>${case.initiatingActor.person.lastName}</Geslachtsnaam>
				<Geslachtsnaamaanschrijving>${case.initiatingActor.person.lastName}</Geslachtsnaamaanschrijving>
				<Voornamen>${case.initiatingActor.person.firstNames}</Voornamen>
				<Geslachtsaanduiding>${case.initiatingActor.person.genderIndication}</Geslachtsaanduiding>
				<Geboortedatum>${case.initiatingActor.person.dateOfBirth}</Geboortedatum>
				<#if eigenschap('GGR Aanvraag','Telefoonnummer')?has_content>
				<Telefoonnummer>${eigenschap('GGR Aanvraag','Telefoonnummer')}</Telefoonnummer>
				</#if>
				<#if eigenschap('GGR Aanvraag','E-mailadres')?has_content >
				<Emailadres>${eigenschap('GGR Aanvraag','E-mailadres')}</Emailadres>
				</#if>
				<Verblijfsadres>
					<Straatnaam>${case.initiatingActor.person.residenceAddress.streetName}</Straatnaam>
					<Postcode>${case.initiatingActor.person.residenceAddress.zipcode}</Postcode>
					<Woonplaats>${case.initiatingActor.person.residenceAddress.city}</Woonplaats>
					<Huisnummer>${case.initiatingActor.person.residenceAddress.houseNumber}</Huisnummer>
					<#if
					case.initiatingActor.person.residenceAddress.houseRemark?has_content>
					<Toevoeging>${case.initiatingActor.person.residenceAddress.houseRemark}</Toevoeging>
					</#if>
				</Verblijfsadres>
			</Persoon>
			<Soortvergunning>
				<Ksrtvergunning>GBBV</Ksrtvergunning>
				<Kprodukt>A2</Kprodukt>
				<Kgebied>15999</Kgebied>
				<Kplaats>A</Kplaats>
				<Ksrtzaak>1BA</Ksrtzaak>
				<Kstatusvergunning>AB</Kstatusvergunning>
				<Ksrtbesluit>2BTD</Ksrtbesluit>
			</Soortvergunning>
			<Kenteken>${eigenschap('GGR Aanvraag','Kenteken')}</Kenteken>
			<Ikenteken>${kenteken_indicatie('GGR Aanvraag', 'Registratie
				kenteken')}</Ikenteken>
		</Vergunningaanvraag>
	</S:Body>
</S:Envelope>
