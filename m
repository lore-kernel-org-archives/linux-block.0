Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59683B0AE3
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683375; cv=fail; b=WrgDJSfJkCquMdlj+tpDrnGLQZuSPlPssuOS7v+6/crvANm9ofEyTFFMwQsU0clZCTKU0amXNYiFcNcmjfNZ5KIKc4Y8hdJCDYZYibqVuNEzePV79ATJBk7pPKdqYvjxwPgE1PUce/2uUjDrMKJkIX41rlYwTtnljdm0DHUprV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683375; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0lnynMAn0LYAMT+FV/eWGvqh6vqqoriQtHELHoomAtfQJAS03NGPJmBvbEm6EKGAmeqH+jHtYyaQj01+FVIJx+dovmaUDZ7E1Zb5w0UFtPV+nLnvFlSs18sUv/PycsSztnjPdBa6jRcUtb7kJS6fQbGZj03TzctJBudNv3P8DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsj5nF6Q; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsj5nF6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc6uafCaGZNc0hrVvYSg0hjh1cxCOYSR/Vu6EWypaxkIDg0y7v3rEmhF6SsjrQYQQD4qGMgdXWITaetznPlEnNh/jkdqT1P4/M7CD2NTN3T3FoIdu03CxEiWVFMXpQf/sLYBRhZ+FBiEDjOIuVVzk5+G4CnixOmZjm8MJ/tDBOWDqopKQl3YTvJi7KyWhpHOc4J+Oe7ghX3Of8PLjngaQ5yxU2qeBRSNuCdeEKm+KYoMxED9wIrmMSShgtrRedLxvgwI51MnOHuaFoQ4qsXi40RXePNaxELKU7o/h5IeZiagqJPt19V4/VqUX4+Is1KycpYok8LFU0t1IyN3Yo8pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=QVrqsrAPdsCFsVTJ5L6d7dwkhV/iAhEydR2xZgd0pozCZz05Z7CTNK5b8W/UYwIijDtaiAZiVBOwydI1XVcZ+e+TY33Ev0Pupf9a5aqs+2/Z1dTuNfc+N7igCPBsfzWvIsFap0OdeH00mpuC2SXWsjUMJNgt9vJa8EAUMsMzjejuFEvLYq5/fr7xH9gAwmAY4T41miT7yxB8PJy7azA4YZ6EETFZnkd8AZy9cMllnC8wO4xffhT/NlSdBxJNo49Oo52VVGHKtY9cTtedk/5zBnJfxQ8tnW1+FEHLqbSBdjPUWMuyWegQ1KLbYN0bfHgpv5zOd1PELSa/VmhNWpaagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=tsj5nF6Qhphh4yISR5mtCK8Ot9LB7EWDCe8jp024KdfUi1ZHpGQG8FUIM2nVWeDzPYvsoWo5IOY8r2mW7pNM11MdBaDykjG9AVN0dONOjbVQTnLspPKWIJytCJN+iTEqeJhVl/zb74WPqVtvsxaKWLIyO53lwPkBXyvsKB6F9f9KK9NCE93J0KBHFoRyOMRUxCP6TS50ul2fs/gmpwvkde7GkspaIdlSayfcokR9oKIO8BoEPcd9j7DW8mK3wrqchkY/1M30hWSiM5RpsSdzEP6V8Xc0kVtKKAT5oeBOzSuInN2q/97/MKIVorFygRYXjml5D2TGqroMb0hkSokX8w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:16:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:16:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>
Subject: Re: [PATCH v7 10/14] block/blk-iocost: Inline iocg_lock() and
 iocg_unlock()
Thread-Topic: [PATCH v7 10/14] block/blk-iocost: Inline iocg_lock() and
 iocg_unlock()
Thread-Index: AQHc9RVxEGKOpEBqm0ai5i3I0K0JbLYwRJoA
Date: Fri, 5 Jun 2026 18:16:11 +0000
Message-ID: <a17239ab-e40b-4f54-b1bc-9f7036230c74@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <f8c9867788957d2e40a32e23c6d9b866e480ad9d.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <f8c9867788957d2e40a32e23c6d9b866e480ad9d.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: d3a8fba7-486f-4ed4-93d5-08dec32e85bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 RAp5RplUw2Du8EXMw1uKfY5pPuMzwXuPrPPi6BVffyS9MmL2CXSLJt/KFFYqwa15wbaWGXtwkOAl8b0rsJo9gJRyMbRzxGgS4lh4dYvBR/0RuCnrBmwfZRDgMTUfxLhVIiURSLZtz3+bXhFJD+eeR44oulyySZf+qj/OanV7VqOGJKSGLmklYJUCXNW1dgtkx7fxYN3tgaXcImnvwsOIBETUQZoDQOikIHuXQHKOEDOoqNrGUsnIj2sLoW+q0ByX1nCORXS/NdDvb30HB9LxB9mYGnSrsxZ17M2jJDxDY8alhNKqlZHKlvDADqKga3SQctlWiHMj0ia6p6JI8oac3gxTylAhboyk7wzspFxPWj2jXT2Ygp0F0OaT0Jr847BgkM+yeF/e/uXxgdsyp7ixi77Fuu/vjfAIAVkR+Oi0OK2Q+fJNNKsKU0I2P8/RWqoYqsOqJnsWj76MRefIDCWeyaQkKhGLU2VrZJQ7Je+QZGUBaKHy4RSWx3wDZQU7QDj8NCr2wFskxfHPn03WtIa/b9W+m9pBbN0/sR5/y9CS+eh751+3i5vGkyA7n97MgLc+E13IYZsp4qUL5y4p3u9k+YDE7krmrPR2UPBqrxGNbaPqM/CNet33JsnxrM+s9Za0Gccyp4GnjsH6+0tz5b81OBuUNIhjswvOch4nfCBiwbd6rG/+MVHrT1zUs5xDVT4vD77P2Q+ItbLIRzVgTPdz9KxQ+Scqdln9FJBVLjVtijqAgbXWI6tAq+rgY3CSn3dh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUM1OEpBRWdwUytBV3RMMW9DMHMxNHp6andXT0VIQ1czczBHOUo4TjNaZlVv?=
 =?utf-8?B?b00vUGEvN3BYTFJubDI0Q1g2RFA4bTFlZHdPZWM0WWlSRUdQODdqZlBsdk50?=
 =?utf-8?B?SnBJVUs1aFB5SVVJR09yOVVsM2hrUUJjUnA2K2pLV0RJc0hjRlJKbWZTQ055?=
 =?utf-8?B?M0RJbW96WjRMV1VzVENJeHJLb003cEdmV3pWRUxiYldjRzZoQjk4dUcvbDg3?=
 =?utf-8?B?LzNEQ0Vydk9KemJSenlIWmtENUlHT0w5QUVXeTNKY3h6c0JhNjRXbTN6aDZD?=
 =?utf-8?B?VllTQXR0U3EvSnRzdGJkSWJmSFVkcEtLbzRMaXJ3K0U3c2lTSUprNUFHV2pn?=
 =?utf-8?B?OVlBUjlwQU5nRHV4c3p2amJDMXY2WDYreFFlbnBGMzdQWWJlSlRzQ3lLUW8r?=
 =?utf-8?B?QlZCdjV0Rlc5SzBKOUpza2tReGJvcUNwZ3U3cjhoSzlmS3d2a2JvSW5wVSti?=
 =?utf-8?B?YmtuSTkvLzIvc3lzRGFYbngxb1R5QnZhZFFQWU5qcjI1VHE4Zlcrd1JnUERa?=
 =?utf-8?B?NmxNUjJ2a2RPaHUrS3I1S1Nwa0h0UjJlS2xLNDE0MFQ5OS9mTjI0VmJaQlRT?=
 =?utf-8?B?dnBLRUsxdkR5Y1VNYWxXUWh1dnFPcjdSNE14ZEo1MDdoaVBTUzcrclllQjUv?=
 =?utf-8?B?bU5GdEw5NkMwUHpEQzlxK2VOZXJhbXdmSXpCR2NOTngrbDNoRGVFTlgwUmVU?=
 =?utf-8?B?c1BNaFJILzc0NlFoMlJyVDlOZjlVbm4wc21ZbFluTTlyRW05QWxtem5TSkRk?=
 =?utf-8?B?cFJYTHBZS3o1R1pNc0FiMlJ0MitmTkI0dEc1L2Yyc0lRQ3pEWWdOalQzT2FG?=
 =?utf-8?B?b21QNGdJNGQwSDNndGxsNmN5ellJbWRVdGRtMUJMQWtEY3p0dG5qUlZyRUhq?=
 =?utf-8?B?RnFGcDY2SS90LzlzTGlHck9FZzFQVHdWVWwyT05yak5ZS2R2WFlmQ0h4U3JX?=
 =?utf-8?B?cDVPbW1TSmV5NDUzdVFFMWJnVERlYzFieXVHcHloTWwreVAwQlc0NGdHU1VI?=
 =?utf-8?B?S25TbmRMWXVLZUpLMW0xanM4RkQxWkg5SS80SnIrT2NodWwydk9xM1htdTFK?=
 =?utf-8?B?T055TFBHSVJJY1BiWHlnckxST0VYL0JBZ1BJTFpaSU1RUG9vU0xRZkRTdnAx?=
 =?utf-8?B?ZGQ0OVBqRzFTZkdidngxdE9sMHo4d2EzWElqenNNak9NUlB3V0hzQkRJZ0hm?=
 =?utf-8?B?ZkVJM0c2dDRaS3pMcXhKcW9XbWRBRS9YNld2Vmx2eUdpdExmckxpUTZXMGdL?=
 =?utf-8?B?ZGIrb2VGNjFhcFh6ZXlzMVYrME1raDdpLzBaQy9qcko5cGpFYkFwVEE1STRD?=
 =?utf-8?B?MEFybzd0WXBIUnNycnpMQlhwRGRFbXZKd2pYdjFJQWtSb2w0Mk1HZm9zSnhN?=
 =?utf-8?B?Q3UreGUxdWY3VWh5aUJQK29QVXMrOVJabFpEOHQyUnpOa0pmS05GWHBoN1NC?=
 =?utf-8?B?UDVQODUvU0Fyd05CVVdSMkJINHhjWER6TWVQR3dBVjhjYkU4ZVNsOUJEa3dw?=
 =?utf-8?B?dWQwY1ZSanRkT2dBYmpCS0k3YmRhb2RLZHlNTm5qQkEwcElRS2hmd3N0T2tR?=
 =?utf-8?B?OTRVMlV1dVlYOWhzN0dOOEx4dHNVbSs1cVlWSjRrcHEzUkZKNUFnMmV2dTFt?=
 =?utf-8?B?YktybmlYWERGeERqTWdZek5GOHFGbGQzWVNZY2hSMzRKRWdEQTJybVZWeGdz?=
 =?utf-8?B?ZHYwMnQwcER5Q2ZpV2d6UWdweDRUSG9Ed1RNSE1OdUk5KzJqdHBKVDFWWHpt?=
 =?utf-8?B?OWdycjVhUmVvLzF1bmM2WncvNC9YL2E5cE4rY2dzL0pPS01LZEM1Ym1VQWwv?=
 =?utf-8?B?aWg5dkxiZTl5L0tkbWcrS1JzMXV2NmVDTWdQNy9xQVZlMFExYnZldktiSHlq?=
 =?utf-8?B?SzI1MDljcTVCVzQrUjE1bTBuektDYXg4Q29sajNQMXVNUjVwRHUyczJZQTdV?=
 =?utf-8?B?L3dzSVFnbXpERE01bW5CS0RlOVFpTGE1N3ZnZDhNUXk4T0VlT1hDcWdMQzdJ?=
 =?utf-8?B?QStEc2IvSEVBa1o0cFcwNUk0UmVreHdmalNhTS9wYmtuVFkrVjFCVWdWVWZP?=
 =?utf-8?B?SXJlMng5bVBEWnpSSFBjMXVXS0Vlejc0dmFFd1dScG1XbHdFZ291Z2RqSW45?=
 =?utf-8?B?RnFMdjg3RFA5QzN4MUhkMkVwSjFKem5oQmwvQ2wreUZnemovckRsZnNVRHJ3?=
 =?utf-8?B?d1hVZFRqM2llVFhFdUk2L0g4bndUSytNS0o1NjVaWEVCVU94VVIrTkxlRVkw?=
 =?utf-8?B?OG50RHNJTE5SN2dIRElBK3RoT1VEcldRSjNqeVBXV0dCWlVSNWlMQUFLRm45?=
 =?utf-8?B?VWNzZStDUDVrQnlFc0xRdUNBeWY0L1R5MWZpenZITkZuSFJSeVUwT01JM2pp?=
 =?utf-8?Q?s/axK8AAgS7Zmtkrb8aJBxlxZ549CHrCJ15Fe/o6XNcRd?=
x-ms-exchange-antispam-messagedata-1: +Uk+hPTbaa1M6Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43A8F70E0600D41831B743C00F3617C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a8fba7-486f-4ed4-93d5-08dec32e85bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:16:11.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBnWvO02gdoQaz1ovWAQaHAEDt8AysppAcJzsTIOayLPTreCVcPJi6nCBLaXCRH5qiSpXKILlit0aeMTpaEpFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
