Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05A3A1D2
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793652; cv=fail; b=fthMtkIhT8lZ/MORrZIDd7dWRyTM8Y0LoL5NaOCvk3tzmsN3hD6Cp82d6uTPGLB9GVLlkLZiHYJyjiQDrJHaPCVIS5/PYcUIVkB1pVDt9nP1UetStqRCzZ9mCGyDEZuT0nSfWGRSb2qs6rF4drYSRu6U9dL7FQFdZ6nEU2kxKis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793652; c=relaxed/simple;
	bh=RMKKBWYU6dRIbXi+kiHPG+/TKgwa1Z8IxedJNK2IsEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QA45hnL4fsV0aILLWB66vBiLev7AKm6TGacZPqkg9mml1vgAx5fp2aLp8v5/kD4ziqslZaVLwAGZ7pOK5zOf5acSjC+W/anOHClTsGqpSnp5LUwtmS2mrglYYagLCU1wqN6rmPVsmtdnTs/BFOy50HxWXr+t/BsBdKABhp20g00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SaJpluq1; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaJpluq1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJUkj7eQeyjnfON4dSubssv2xcEaDBza5HsYaJCRaDXVNBioZotz5ho38E8RPxP20jsy9eQTpd1PLCHXFOjNE/nFE7BJCvVWoWTXvbkK7ZD2ZAa4k3PbtW3b3FI2+GoHiWswl6c4izJxgWpHZYlRmdqPGks6IGGEY3N0ayJoZ8hu+VAw4XiS9iPxeZ7GztMfFYPAP3vkk9xI51Q9HZ4OCeVWLeG6UaHnGAQoJy967DthHG3Q+tYtK2GoR1Qypl9M2LmOtPpP/NZUi+jc8MkQcIZBGTMd3df8p0CElPNdWM9D9sIIgZ2ntSo5Dt+wTpdFHJmKJdFBhOFFAv5wB3b1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMKKBWYU6dRIbXi+kiHPG+/TKgwa1Z8IxedJNK2IsEI=;
 b=ptp7QRFSYELATNV32gvj59YpSoUpOo+wPrUKc5zwJ2FtQMh4mQwLdlU/8nymfD1RbafcnuyDBo/SEol96afK5RjbN0GJORjKUxvAHdfcAtl5CpydgXTeznz1cN+E5v8Vp/ICGUodxMVGTzYNpLcMEaW0m8gHr1Jz+lSXzmfopdQME0bv6d9Zfm+g8rw+srJhMGKHQeAJj7GHk4c+pBZjr4cd1986VJluwNwwyofNZlwIh0sJZlzpeuQAIOkassyY6OCxz/XoBT+XfOHYf9fHNBgRtR7sVHNxU2nnO7jowusZC6UG0PUkdEP6imL0kXzfIGzOowOFqamSWscpOKR0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMKKBWYU6dRIbXi+kiHPG+/TKgwa1Z8IxedJNK2IsEI=;
 b=SaJpluq1cZkzGGCI4ytlhXCRdg6Y0L3NcLVeuFKjvE89KUVRmf57HTVjRYHHls2yAglmB6Z8OaJmdx4Fict+MLhKh6hiXkbs1YdRH2NcGmJOmQO8pfRNstgFJKMG8wC17Gjtirn3+O5SbhosxxcRuPEInbBVqdOxE0qV4KtqNFTxMr77Ff58PnGsjMwqgebZ8/vFv7nhgXMormCuCjIPenYbryWoBuPAG2cphndeN9fNxy12l0WWaqLUdn+RJgtHOYgy0iWiFDXdUb17T+Xm4mdggpQaXeCy4LloZzX0KAim6V3PE7Dveo8fvh/v6MLiu78amv6lfksBPpTxIEocJQ==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:27:27 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:27:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] block: split bio_alloc_bioset more clearly into a
 fast and slowpath
Thread-Topic: [PATCH 2/3] block: split bio_alloc_bioset more clearly into a
 fast and slowpath
Thread-Index: AQHctV+qKBXF4xWM5kaMBunFE+pXaLWzcT+A
Date: Wed, 18 Mar 2026 00:27:27 +0000
Message-ID: <b863a32b-453a-412d-9874-72d775347a0b@nvidia.com>
References: <20260316161144.1607877-1-hch@lst.de>
 <20260316161144.1607877-3-hch@lst.de>
In-Reply-To: <20260316161144.1607877-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|SA1PR12MB8986:EE_
x-ms-office365-filtering-correlation-id: c15da527-eb92-41f9-3b78-08de84852271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 39ttbePh1sCSY/9VTlvYeUClbeAsGhhfARnfzwkFhdkdueJ6tCrAA+o7L/Bl+uJ07oOj+zyeflze0j63SNk4oMKphAdGmwXJ0IojiLCY/QFHZgJztDlCiaTcKfn3Oij+OwExTQNwzHzhzLmZQbe/biTGWyUDwbv8u8figekxbfXJkQ7CElLcfuVviEs0gE4tYABQCYt9RTdWrYZ0fM1GDRyJGB7e8eC2KetnKYrlbk3CdsHLahJjbG/DhDSF93RGzipBXsOBIqLh6A8I3oKa/NP+WTx1+EXUhHIsQZ2NAYWTjMA0DWGEIJJ7l9GqoA6gTOhoP4ohxWV5U1uQ3d38wSlJOiHaK1yGJprmhNMi9nRhD3oyVOZlpKsQTUg/IwLVKZSCiG4jjIX1liJN7F4t9mhc0R7JyfZMvcsAzk2lacDI37HQ6iET2t8aSsp6EchN52lCdOdAhlSleQ4uzDLKpwSP4g9F2PEhQ1LyCg823x7EvzOjvudoLZGsrikrfVXO2bm8zCmx3LqCRayINNBPVI03M8fbM7FEWDeszuydL9kfioyasZFL0/9mnDUCs82YSsYI1V+CBd7bdq6oWdVYPk85YClJk41dsBwT7Kxnlzd6HgrKVk7q2JGeIirbPSz+OKbddT5Wy7uBU/YsnU9r1MUYeQB6cLjhbiWOlwZsnsPNEhtsW+yzSB9xl92JocZ4hmI4FBs9c7d0K+CPro/cxAqjK7U8Tr+0unlvs2MvzS5+UKzBHGB52cffS/gU7Fk/6dTxfPYtq8IfaLijaBWySxZGZpp8GBUW+zMvZ/jX4Kk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGdmWEJXSlNNYTYvSnZrUUp0MG9iSiticW9VWncxOVMyYWFRWk05bnRqVnd2?=
 =?utf-8?B?eHFIN1BGaXZTOTVXRUxGNVBFKzNYaXV2d200andUbldrSFN2bVZsQXFTMTdY?=
 =?utf-8?B?U2JvaktLUDhUdXNObFptQ1N1Rm5nTVAzTlNpaUordHREeWxZa1lmSktNTVhP?=
 =?utf-8?B?RnBtNXVhcUZyOUFjWGpJTUkwQVRPQUM4V3plVnF5TnZXd25EYkREOVJkQ2Fr?=
 =?utf-8?B?NklrZHd5OUxRcllxdWZ3OEhRdmtjbXBEdnZYM0hmTHlMZm5pQmN4RE4wOGEy?=
 =?utf-8?B?b1FJb1VVWlhrZTBlMVBnYXpJQis3UGNEVUhqS3Q5eSttMVJvZEJKQ3ZRTnFz?=
 =?utf-8?B?b3NndzdEN3oyUnhGY241Y3N0Zmd4eHlNZTM1QlNudWpmeDRSL3dpNnVuWXp4?=
 =?utf-8?B?VExsYVdOaEMxWE9IelkycW42TU8yeTI5d3JEU1hKdEQwVURTR0w0ZGFHSHF1?=
 =?utf-8?B?K0VmK0lqM28rN0xJRVdBc3dLb1lTSmNYZWhKRjIyMFp2OFRvTkRHWTRFd3px?=
 =?utf-8?B?WCtnWG95OWwxMERaM0d0Mi9xUXRTWmpGQmRRMWxBMUlQaGhkNWFVa3JwMmxz?=
 =?utf-8?B?TzZZd2NkYURET2FVWXh3MkYrcW94WGhkRGFUVS9qVGNIUEVHM2RXeityT0pl?=
 =?utf-8?B?UkN1UENKU3VPUWlrcEdlOG1EQW5tMW9mYkcxNkFreDFLajVDWm84U2xYbEoy?=
 =?utf-8?B?SG00SHZxdnVyckljRkZZUmo2SGdUd1VvdU5veFd2L3RSaDVhNWl3VHVxYUNk?=
 =?utf-8?B?Y24zbVhYNkR4ZmpPUU1CaDM4dlRkZEU1Z3MxL1JUSHprSVZXVUdCQ2NlMFFa?=
 =?utf-8?B?UmYvanRhS1BZYVF5dG93KytVSHJhWE5YdEdyTmNobTZOaUY1allSY1hneFJp?=
 =?utf-8?B?RXhTSmlraWJyRkNnVHVHQ0xuazRoTjRXK2Q5bHBzK0g0VzA0c0ZYZWJXUzhW?=
 =?utf-8?B?TndzbWEzWHc0UkIrVjNqK1daTkR1M3hqVExtWExjT3k3eUJLdW5HOXZkQUpM?=
 =?utf-8?B?UE51MzUxc0F6ZzlIbk1XRFc4cDR4Yi92WVlqQTZpSDZLWDgxVlpTdVlWdTdD?=
 =?utf-8?B?blkyK1lOOWlLVi9kRERYRmZOUzhGa1FNNmpSYWwyaW04b3A0UzY5anV2Mjdt?=
 =?utf-8?B?SmtHUHViRHIweGMrdmdHMCtQRjBsSUpBUXFsMXlUeWJvN1BHMDJxdGd3Qkd3?=
 =?utf-8?B?WEE1VEpWV29HZ2Q3TDVvd0dPamxFSTdkaWRuTnpHTzRWYnVPQlBXakVhMkVV?=
 =?utf-8?B?U2plWG1vWEc2bW04aFRndnFlTWhyQ3pDOXRLRUZ6RDE5RFdVQmZVRlY0ZUhX?=
 =?utf-8?B?U1R6Uk5lWjRyR2VocURmRzUvckJtNHBNV0tiRjVLVDhFZjZjWUtDbTdKd3hz?=
 =?utf-8?B?UDJWVURYakdJZXVTWi9BTUVjbmhKSm1ETkZWaGtsNjhOS0FYQUlQaVk4OWs0?=
 =?utf-8?B?M2J2eW1OV2doVU1YOTFWN2t6d085WGpBZUI2cmpkYVJwR0U4SFFKbzBJTTE0?=
 =?utf-8?B?M0VxSU9WQitEY3VEQ3JMVVlDa1BJSCs4c2ZJeUtXdkdoSE1ZL0tzaU9oWnZI?=
 =?utf-8?B?azdOWVgybEh3UzU2bjVZR2NiUUZ1c3VleVJvRkx0T2hrUnNtaEVzeXdtWjlT?=
 =?utf-8?B?ZXJrcC9JR1RwOWxwOXZLU0NicGpDZkFQV1luajVWbWhHQkRoTldIMEJRcTVx?=
 =?utf-8?B?c2hYVk9lNDg1ZEZpQ1pXcEdwTU1lMEVBOWFRdUhIM2Y2Q3UwREMwMCt4alpl?=
 =?utf-8?B?K0l6bkJrZDZmbTA0MG0xUkd2WlhZNm41elhYUGxTamlETnYrbDVtaW90Zlc4?=
 =?utf-8?B?UkovOFNmREduNE01WmFYY1dZZ1BsZWk1L2o1OTUxalRjUlpDTzY1REpnakda?=
 =?utf-8?B?NlREbzl4L2xUMXZPR0xQa3MwTUU5VlZVTG5TN1hhakdmUW14em5mNUNYV0VE?=
 =?utf-8?B?T25RN0QyNDRaZytnb0J5OGVoUGxtTTl5TGt3L3pOU1BOZndzZUlVN2hXWlNx?=
 =?utf-8?B?OXRrdXRyRUJoTXpXeHprdERYTXRWdnpkUWk0djQ2WlVuN3Awa2JjN1lxN1BN?=
 =?utf-8?B?dm5JWUNOVTk3UTcrVEdYb09hQVhObmM2aWFPZFZZSXhOUnZTVkxDeWJvM3J2?=
 =?utf-8?B?WStmL0pyZzYya0xLaGtyMEhNRWJaTUx2dlpJNkxObG9KRmp0QWt1aHJma0Y4?=
 =?utf-8?B?TkZKYzNmUmFobGtJOUN2cDlZWmRDWmJodnRFOGF1bnU0c3c1OThmb1k0bVlH?=
 =?utf-8?B?eUVwSFRDSlE0SFBYU3V6M3c2MVFzSmwyYWo3ZHhSMGh0MkxIbkdWd1ZTdk40?=
 =?utf-8?B?UDVzSVUxbk13dGNpckdibHZBck1KK3huYVhUb0UvaUt6SndRanNoVDJPM3hu?=
 =?utf-8?Q?cOkhvi9Mmjy7k2BjVytfZCxKMc6kJXWaY4S7F8ji6fAFa?=
x-ms-exchange-antispam-messagedata-1: HY1//oXJ7FAXpQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4FB34653EDAFA4B883B8E0A1AA6C1E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15da527-eb92-41f9-3b78-08de84852271
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:27:27.5835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYzdon0Oy1yhtqePLlsIsNWUAcXvngTluHP+xM5qZVHUPY0cNPhYvDSCdF10ugdxTSqY/re2ozSL7skas+xB/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

T24gMy8xNi8yNiAwOToxMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IGJpb19hbGxvY19i
aW9zZXQgdHJpZXMgbm9uLXdhaXRpbmcgc2xhYiBhbGxvY2F0aW9ucyBmaXJzdCBmb3IgdGhlIGJp
byBhbmQNCj4gYnZlYyBhcnJheSwgYnV0IGRvZXMgc28gaW4gYSBzb21ld2hhdCBjb252b2x1dGVk
IHdheS4NCj4NCj4gUmVzdHJ1Y3R1cmUgdGhlIGZ1bmN0aW9uIHNvIHRoYXQgaXQgZmlyc3Qgb3Bl
biBjb2RlcyB0aGVzZSBzbGFiDQo+IGFsbG9jYXRpb25zLCBhbmQgdGhlbiBmYWxscyBiYWNrIHRv
IHRoZSBtZW1wb29scyB3aXRoIHRoZSBvcmlnaW5hbA0KPiBnZnAgbWFzay4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+IC1jaw0KDQoN
Cg0K
