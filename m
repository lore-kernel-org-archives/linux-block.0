Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820886FA8
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717987874; cv=fail; b=e22g1qAPLu/ksvl178fWo+UkRlQvVB0d+7xVJ8jvuUc4Y7mO/5esFRywH47oj2gSpKR0M36aR5QND0Odch6h/TCsn/YswObBlAy9ndErmWDJJBQQmNTVMcCq406vzWGGmJja4f2EusBkhgPWIqbfQPHSYkDmvCBn99QGV7S2baA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717987874; c=relaxed/simple;
	bh=nu+hsnEdDPQgatEJJM2sDu0FhAjdhiq5nd7wYSBBFEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+lRgI7zPeOHKn7NGESyQJs2qwUXpWz5RPcEdbyflYiw0p2d5iik5pwCBjIE6erlTfjbkuJgyKWxh/8k9lRTI1cvyFzYGiunSJvsKv7eDc2e8PK5FwpzmVP5fLsXGcK/8WG6iiuZhYmz2eIXt03415GaataUGQZhDF8WS6jJ+p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p11lYQZ4; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p11lYQZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi8XKKzxDw/H0RumDLhKzo2twYupKYMm2yq3DS1W07xwdjRY4h1hQgVVdToew3tBq7cAasfcP7hRvHn0Rfbu+GUHITHU+DpX9Fp4KKkrLmik0CjnVIj6KZXQJLgV1AEJh6TO6sEAhYhoyh3LlnGfTr9Dy/hGVDq3MOD3IPI5oe/vUwr+zQszE3XKQJ5EShljdqw49IQ5mGH+FGU031U89WorbbcYQ4JFbwULaLbE0RlSdLnb5TxU5ar6C/RnvjDlHeJyjyaxv3X5qvuupwCFcIw1HxQp0rfcxEI6Mh9Qs6mGuNupCP/rcFXYzYGMbIwDDA2QmDvhfmlGXUVT+erLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu+hsnEdDPQgatEJJM2sDu0FhAjdhiq5nd7wYSBBFEY=;
 b=U8ey0CPpPwijSCBDMd/Ew1oOecuTxWhMKfBBj+y7Eczl6OC4t0dqcGmN5zdn55lfVgKKsevMZubz/8F29ftcBHebdRN66L0atMJcATme7BgM157+/iUHN8gwTnaZ1AP0RXs45Km/fchgDFaMOuWCJnZ0KhWyPXxjj0NQQrbSv2zxdXPdVPBfhb8WlPBquaU/wdAqJFBzvnzsi6ROYPKvXqOWsh39MisI2c+YaUjGzpR/QdrJIKR+8ShFRzO2eWHPCDjIyZTLH1nAVgtoyZkkxJCM5x9A7+9ZJQk1iWIRFgQj2DCfery+pj+d+fygzf6Ov+AlcbRYS0ao7IunRXWCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu+hsnEdDPQgatEJJM2sDu0FhAjdhiq5nd7wYSBBFEY=;
 b=p11lYQZ406g/oq3QqVYDbD2Ely/IC7GVPuIVE+DbCqTn5g0+iYDY93CPMDEHl5eO6ueH+/HnWRwcaURPE+PUGcSp1O8I6lEEfS3MM+bVIrpqfQQB1cLw1R+EwNt2dzAtvGshRqwCq1nUZ9GpyUrOcJNB2V3qDaZ5mLu46pw6+qW+pVtzuLt3HKxsSHUPcVaKwFi0cqJ6iLIKNeHKZiPE9UQn/77s3DqvKWJCFAs//rB18asW+cR42Hr0py9BgEuPNkQOOkFwIS3qRgez2vGeL5I73CCiwLo7/43wB0nNyWs9Ne3YqBxJZjMlgrI5zZV6RH3nbpwb9WCpdq+pW8zm+g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 02:51:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 02:51:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: initialize integrity buffer to zero before writing
 it to media
Thread-Topic: [PATCH] block: initialize integrity buffer to zero before
 writing it to media
Thread-Index: AQHat9JTq4/7opgqV0Km9rXwHHHCpbHAUnQA
Date: Mon, 10 Jun 2024 02:51:10 +0000
Message-ID: <fa90aaf0-4a63-45c6-aae3-9e709e6df0c3@nvidia.com>
References: <20240606052754.3462514-1-hch@lst.de>
In-Reply-To: <20240606052754.3462514-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7765:EE_
x-ms-office365-filtering-correlation-id: 1c6672e2-8714-4e1e-e78a-08dc88f82f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUhSb25UcE55T3FRbkZJZmduMjFJQWlUbTRHb240cjNSaVZTMEtSS3FjUkJS?=
 =?utf-8?B?SGJPem1SNEFtSTI4SHpkeTdCZmx5U0liTG8yb2ZGa3ZLaDgvVWU3Um9VM1Rr?=
 =?utf-8?B?dDBkVnpmOW9ZYXk5RnRFcEIxMzZCNTFQS1ZUMW16MVo2RHphaW15QktKdVV0?=
 =?utf-8?B?TzZVWnpPRDFyeVhSRyt5WGhLdUtYOTczWStxMXRHWnJlY0V6OGx3NVVkOWFz?=
 =?utf-8?B?VkpqWWZBSTlkR29PUWZBSXhUK3ZkdkhFQmpFeWNUZkpOM3ZxeXpkYzExT010?=
 =?utf-8?B?NmZ6MEt5VkZEaVZWQm9xcjZtdmpQeklFMy80NGl6VUEweGpmRTdoTm1PSmNx?=
 =?utf-8?B?OERobHovdVlldGhiRGhEVmVNQ1JPZGhmVkRyS0NUNnltWnhVaFpneEU1TEtR?=
 =?utf-8?B?Znp5OTRNNTc3bmp3cmR2bnNpSnpueDRMZ29VWGxpREhnWElmd01VS1htSURi?=
 =?utf-8?B?SVRrb1lwcWt4MDljU1N2ekpqVy9yempTM1dNczgrdFdiUlF2U3ZWVnp0aFl3?=
 =?utf-8?B?SnZVUTY0TUtia2JpK1ZCUFE3cVZGL1VYaFc0TTNlZDlXU1gwQ1dxS25VKzVL?=
 =?utf-8?B?OUsrTWpQMlM2Z1NMaTBqcHd5UWFGcERBdmQyQmlwOEdxc3FYb3VwcytZdnhr?=
 =?utf-8?B?ckgzdDlmR212ekFGQmZ5Mnd2dHZrRUVLL3VhdmpPbHVGVUU3NlE1eVE2NDlU?=
 =?utf-8?B?dS9ROW5wK1p6ZW1hQjI2bFRLd2xScTAyaE95LzRjNHVRb3Q5di9HU2hrMG9a?=
 =?utf-8?B?cEQ1WEtCNnAvdUJkT2UwSnIyTlo0WU1BU29pZ1RYYUJOOFltM1JNSzA2aFZX?=
 =?utf-8?B?UEhFTGNFWG1WMHI4WjVuWXY1NWQ3eSs5dmtQc2VXWVVvSFpQY2JDeSthb2My?=
 =?utf-8?B?WjM4QXhuNUNZdENmQkRYeWpaV2RodWZzdkY2YTVHZVNWNWVxeENvdk10b3pu?=
 =?utf-8?B?UkpncGhJeHpVY3g0aDQyTjhFbm82a2pTeHh0TEd2QnZvUkgwWDV6YnBGMytB?=
 =?utf-8?B?OXpBZE1PQzJ4Uy9wR0c3aUh3L3NwVCtlVjlOeEEyeCtHQzdJcjU3bEYyeDBK?=
 =?utf-8?B?Mk10RmR4ZFlDMjcvdnNLbVYrdWs5MVlrT1J2c2RLK0MzM09adUUrV1dreEgw?=
 =?utf-8?B?Q2dUeVhiVHFGaDdtZkFmdXArUUN1Uk4zODdxM3oyaW1TNktUQWVpaVpEeWtr?=
 =?utf-8?B?emhYY0Q4M0NmcmdyejNicW1xbVVhcERZZWgyRjRTU3VHMVE5ZUF4TWl2UlN5?=
 =?utf-8?B?Y1RCdk9sQmxyRXVEWTBOWWk4emxjejVVOVI5NjAwVk94OVZHTDlpMmpTTmVv?=
 =?utf-8?B?L3U0R1lNa0MxRzc4YTdFaStad3V5YUJ5eUcxLzRHdWhvUmZOYVg5d3YxaGQ1?=
 =?utf-8?B?dFVkYjJJd0Zya2dib0NvSnRrdWY2VDlpbXh1WnZLcDgvU2haMjlvTDIvQjB3?=
 =?utf-8?B?T0dyOVl0M0xxUjFQcTN1UXZ5aEV3MXozSVhZOVRicDFLYkVybUFVVGF0Q0J3?=
 =?utf-8?B?YzFoYnZsL2lLeDNKYXNBOFNKY21vd1hnck1RazUxenZMUTFLT1V5QXFMMnhx?=
 =?utf-8?B?U2ZoNjlBQkllaEZWVC8ydWFINkNvVHc4M0ttRFhpdmNrMWNUYW00bWkvSnRr?=
 =?utf-8?B?SW9NRzFXNmFVazdpbXgyVC9hSjNLOVN2T2M3SzR5eXE4K3J4eGJyRklJb2Qv?=
 =?utf-8?B?S3hWVWVxc0FMWGU0cU1LdHNlRnh4NFd1R3d2czlvSktIeE8wN1c3elhBWmFx?=
 =?utf-8?B?Q2xiLy9ZUU4xT1JHVGI4L0Q5bk00RWVkcWZ6YmVCajdUZVdmRzhaQ3VXRkNL?=
 =?utf-8?Q?9M0sXmgh4pAsn860d/VKFObb/fUW2TekEW2wA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0Zia0o2MTBqbEl5K3RFZTE0ajJlR3VPSzFpdTlnSlh2bnR4aU9nY1diMmNr?=
 =?utf-8?B?NmRRdU03WVdIZk12SE9NejhxSno3bDdSZmhGOWFIQUJOdmhkTVFPTUFKUk0x?=
 =?utf-8?B?aC9MSmVzUUY3amRjbk5EZFFhRnpvZk00Y1pMN3dWcnlDNWZaaCtwcndMMUVx?=
 =?utf-8?B?cDZRYkw0ckdWdllCU2p5R3BTK2hzTS91c2xsTVFsZUFjdnJWSWY5M0NHU2NJ?=
 =?utf-8?B?QUhvSlFwRzYvMVpyUHlVYWJQSnprQytnN2Y5R2d4VFlCdXl3TnF4b2ZzTitX?=
 =?utf-8?B?WE0wK0IyMjd1cFU3b2lMaC96OFdUUjFEdmRsejVyUFY5YjFLL21qYVV1OHY1?=
 =?utf-8?B?b3BlcTRDbndZQTdPOTUyVCtHRHU1MmRyOU8yenJKOXFaWUQvSVFYZVpYdnFJ?=
 =?utf-8?B?YVk4MkZMRndKblBBK3NyTGVEbjVtRHZsOWJES204RzlIUjlyL0RPTDVHNVNq?=
 =?utf-8?B?UzcyelIrWmUrRjFxNlB0MitjY2U4UjRaNXhHbFB3SXhhZ0JyR2JtcHE4bm1m?=
 =?utf-8?B?cDhCeWR4Wm5OYXdtTHRCSmoxa1BEMklNU2VaV1hPTnNjK0tLN3NlT09YdHJ5?=
 =?utf-8?B?Y3djaC8vTnpiOEsxL3VBZHN1d2VCbHI2c3hRSEFtL0RDS2ptcHJCVGVLeXhM?=
 =?utf-8?B?N0RndENhcENGby9PRXBzbTBhU1Azdm1ma3FQYzBzRXQ5WHlvakxOdTB5c3Z6?=
 =?utf-8?B?a0NuY3JoUWkwNm1udXJHaGQ2Z2cyd3ozWXFOTjgyTUVtYjFtUGVpVGpLbXFU?=
 =?utf-8?B?SmhZbEtWYVA2RkxHYWw1TFBlaWh3RUh1VnlTZXBNSmRkd2kxcE1iUU5oVnlq?=
 =?utf-8?B?UW1hQ01DQko4S1RzK0FVbmQwektsUnQ4UkRLVDlMeEQyQXQ2N09BMjJYK1Y2?=
 =?utf-8?B?WTN1bEt2TGppVGczUGh0ak5Sa2cvRit2SmphUVFoSHhFR1dEdzIwN2xhanpx?=
 =?utf-8?B?SVZob3c5M1FHVDRhWThLN2pSVTFDdU4vT05ycGJFb2NlUSt3M3ZrMW0xMnRT?=
 =?utf-8?B?ck1SdWIxb1c4OURQd2Rkc0lXR1FxVGRBUVBrdmZ6Z0VlSVNZK0dsT2dlSWlU?=
 =?utf-8?B?a3YxT00zb1N5V2syeFpjMml6bmhMcGpEV0lndC9PaVM5MHl0RFRDZUJOSHhm?=
 =?utf-8?B?dUNCZmtsNk5zWWcxUGNZeWZpWGcySGEwV0YvdEZsNkhrVkZtN081eTJJRFA4?=
 =?utf-8?B?cVVXaGF3M3lpZGFUYktIRFo1NmE0alR3Q3V0Rm9Xbm82YXhhdlZzb3kwS1Iv?=
 =?utf-8?B?dTJTV21rS3RCV0RNazdSbWlPNVA4RDZhVTVRczBUd212VlZZZC9YM05ITmxD?=
 =?utf-8?B?QWlHdDV5UlAyWmtubVB0SGkzU2pMVWhSZ1pMMzhXMm9yVDRNcjhTYlVIYWlJ?=
 =?utf-8?B?WVRUWUdUT3hQZGRCUis1WFFXU0tQTmdKQ1Q1Mkp1MVhyaWRrWG1sQWp0bEIx?=
 =?utf-8?B?aWV3K1R2TmZWdmtlQ0ZCbjBlWTNHZ3FuVUNVSnVUZGpKVW9ienBuUFVJTjBB?=
 =?utf-8?B?d0hWMGpyV2R1akJyZkdadGFRS1RyaGRadTJTdW50Z2dSdzVmZldiNnZhaERU?=
 =?utf-8?B?blVYeEtXTG01aVU0dnA1Wlp2cFhOdXVwUHdwYWdIN3BWb3BJSGx1TkJTWFls?=
 =?utf-8?B?dTlMcFdsR3pLREhoaDJzNkN5d1liWW1UZ0xXNlFSdy9SbVAvMDRhcDFzVTI1?=
 =?utf-8?B?OE9ldjRmUE5Lc2Z3UTRzQmJubHRiTHZ2ejJHMEVxUktQS09CeXZQd3h4QkQ1?=
 =?utf-8?B?SVNoT25BRDFtbHFXKy9lNE1BSCtYQXRqMVNkdUMzUHM2aVJqZnNGckFyVkJI?=
 =?utf-8?B?N3pGcVN6ajRXSnhtWXloS0llMFQ1SGV0czFyeUNiV1hEMi9NN0RwQmxXcGtP?=
 =?utf-8?B?aUVmaXVoQU9rWU81dXl2cHFvRXg2V1lWa0hHUzhzUTFUYmNlaURUK2I4ekUz?=
 =?utf-8?B?NFovdFRONzY3RDhFRnREdHJxUmNRcktUSkNSMGhRWDZPakR5Y0MxQUFqbzJU?=
 =?utf-8?B?V2ZDaElLVURKSjRKeHBvUS9HVkJRamdjYlVZWU1iUXJBVUU3dnRqam5ySld5?=
 =?utf-8?B?blFHdVB1L25CNDZqY0krMFVFNk02R1pjTVNyNlE5dWo1SmdCY2w2TVNlK0gr?=
 =?utf-8?B?U2xrNkUxOTNUVzU0ZVFSeFBLTWFZTGtlRlEyS3hkamJaMXNOcVU0THhsWHJ1?=
 =?utf-8?Q?13T0UQdxnEYdbXoIJ80ZgS4x30RdjDh2SNf1gfZO76A9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD79D21A940B2346B99E3C6474EFDC9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6672e2-8714-4e1e-e78a-08dc88f82f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 02:51:10.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wDV3d+/qML2D/FU0dsM4bbNEF5F04Vfy7GALHJXcF2+7kK06/eLn5JUHYn8SN+YdAyGWYSs1quQdoLYdQp7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

T24gNi81LzIwMjQgMTA6MjcgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBNZXRhZGF0
YSBhZGRlZCBieSBiaW9faW50ZWdyaXR5X3ByZXAgaXMgdXNpbmcgcGxhaW4ga21hbGxvYywgd2hp
Y2ggbGVhZHMNCj4gdG8gcmFuZG9tIGtlcm5lbCBtZW1vcnkgYmVpbmcgd3JpdHRlbiBtZWRpYS4g
IEZvciBQSSBtZXRhZGF0YSB0aGlzIGlzDQo+IGxpbWl0ZWQgdG8gdGhlIGFwcCB0YWcgdGhhdCBp
c24ndCB1c2VkIGJ5IGtlcm5lbCBnZW5lcmF0ZWQgbWV0YWRhdGEsDQo+IGJ1dCBmb3Igbm9uLVBJ
IG1ldGFkYXRhIHRoZSBlbnRpcmUgYnVmZmVyIGxlYWtzIGtlcm5lbCBtZW1vcnkuDQo+IA0KPiBG
aXggdGhpcyBieSBhZGRpbmcgdGhlIF9fR0ZQX1pFUk8gZmxhZyB0byBhbGxvY2F0aW9ucyBmb3Ig
d3JpdGVzLg0KPiANCj4gRml4ZXM6IDdiYTFiYTEyZWVlZiAoImJsb2NrOiBCbG9jayBsYXllciBk
YXRhIGludGVncml0eSBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWc8aGNoQGxzdC5kZT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
