Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC816EC0E
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472935; cv=fail; b=R1LTDpx4+WNqhbaSjEvdUnZDAwV9ErkRNPdPbI17PQrPKSdFc4Bl9tSwJgmS3EX365jfdzvdHLFFafWnYOMJc4p+aojIZ0INe1WP44K1Itp3a6pHqpx9jb5t+K3FRazd6QDUfMHU15HFmYLJOmmGi5hB++qF13Lwe0gTvreG+4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472935; c=relaxed/simple;
	bh=6rE5JP/DJopBiPiYjKMxyqNuH7d3u3NOFlMSrdBDkcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tO6J4ejpebKEBWXOfzQxWCnBhJkW9p0iDKgZy9AQj96legsYfk6h3MY6EQOPS/BZXbzduscoN2b3XJU3j0WqdPIZaWAK3Asf10AvQeTwa2adJypY5dI0DuSk4FIrQMbButmaMTIz4kSXYUvgqE92c7vmeKxvVFzM9iXWGkiCBjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SfXSr6tr; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfXSr6tr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnBowjX+CqG1LtHXvQtqpRjdpBtM1eeu9PI2ebw8sodsHvtYkG7SsWmQaHnPdc/xyojxaBfZnDhIiMrpBN1rnGc8PW31xshGjyqv13xcrrLlU8Nbsg0ApXSEXv8hrMeeNiMQYzhI8Bc8fkS9lkVIo/mdgAt8Rjg2nf0aXgtE2OLYVs1/rWpNE05dAHkEYRYeulGR9FhbBCcKN1SU2EU+dRZNSzUCgT+h2/3lw1xr3SHbXIp84sVhZF74qtlhkbqOZjTmSu2FfHa/wlrutAS/9q6/LVLOCGk8j4kSs12Jn/aVxLLN01vc9yuAHwYEaTz8NQTDKyZrZlRhQ5WDnqcdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rE5JP/DJopBiPiYjKMxyqNuH7d3u3NOFlMSrdBDkcs=;
 b=h/Qaef6s1RIdF9/AjhiTKxPIgHaD7Sc8eElySIm+//90aj1LhoHl/yoOpiFJRAfmG71mCkBTP0FuIA7QLPveHv/qZAjkqB2NBXqaLFeiiFpC+paDTLnva+BSyyP+hyX0jaL2Yqzs7tuDnfKqnreW1kAiJKbH2ev2c/T+lsTidZXi200K5M5kBOSNYm5uRJ61i8WM7VVVpWMxFWsTUfzNgdzr3qU9I+FnVU3BgOIS1tRJ0aevzyo7QAbnLXVh8z+z44th16ustqdGZkSWQBPGRYaLAEzlevjlKWFfKUyW3fT9X/Bl5YO3Dv3O67cBi8iADY9NP1mBsihtEuZbnkaaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rE5JP/DJopBiPiYjKMxyqNuH7d3u3NOFlMSrdBDkcs=;
 b=SfXSr6trPEVPHGJO+GYoJfswhcY/UVgfXb/6ofeyhzgT59nY1yzTRXQ8VhaGXEUX81b8RguDr/ysyWfpKZr+cS786UlswMEQoxlA5/svdpYP4wF+NB9IddtPUqA2iWtxuaR5Pk/HKaihVeKdSukd5KUBywJssKVxU2o738VmdR038nTLpiAXKugcfkzyI2uavldeBS6Q0qzS0o8dJEfJwzLy4GI11Hwoor5CNNO4knZn4fTbbOPAniScKKH90vGHqxYjoEezfCFlWNu2PH7boqL4x7z+wRzpIZGE2fM20ojWan2VJQcSXDC4ibxwwFAlvBmFt4rKOtSQBcWp2zTtVg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 04:42:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.021; Wed, 13 Nov 2024
 04:42:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"dwagner@suse.de" <dwagner@suse.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktest V2] nvme: test nvmet-wq sysfs interface
Thread-Topic: [PATCH blktest V2] nvme: test nvmet-wq sysfs interface
Thread-Index: AQHbNKJOCrH1PSQxgEaHA1OBv7logrK0o4gA
Date: Wed, 13 Nov 2024 04:42:10 +0000
Message-ID: <04ea2ae9-befc-4482-b3b3-bea211eaa03a@nvidia.com>
References: <20241112012904.5182-1-kch@nvidia.com>
In-Reply-To: <20241112012904.5182-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ2PR12MB8955:EE_
x-ms-office365-filtering-correlation-id: 4f1e6e4d-50bc-4793-952e-08dd039d8991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVJUUDAzUlg5Y0ZDUUR0WjBWcGFvRzhZa2x6V2tKWXB6TmhDR3dJVUZpRlNL?=
 =?utf-8?B?RDVUbllEbXM2ZmNRRmNuYUpCblBCcVpxSTdDU2M3L2MvRWhsZXpCY1RBL2dO?=
 =?utf-8?B?c0RoeDBWRWhrRU92ZE1nUGRtV3gvNk9YSlZhZ3EzUllMRXNZL0JXNGNOMitD?=
 =?utf-8?B?eGZFN0Z1MXY0VmtzdCtad0kzVXkxaTRFcFVpOGVzSWZ0dlBqMW0vWWMrVjlh?=
 =?utf-8?B?MmdXUDNndFEvM0JuQ08vZEtrTlZpMjZSV2tZQTBiVnB1WDhXRlh6R25BRjNL?=
 =?utf-8?B?ZEc1ZzRFRmpERG1JNC8rOHdqWDk3aGM5RDI2ZVhaeVpJS1J5OTl2UDVmV1Az?=
 =?utf-8?B?Smh4ZjdZRUdxMEJTUitUTGlESzlISWQxdW1vdGJYUVBDekxvTnpUZng0ZkNr?=
 =?utf-8?B?Z3psYWhnY2E4U1VvNzhEck9nK2hmMjFLZ0ZPTGxERUdIbC80NGdzc3FxVW1k?=
 =?utf-8?B?Qnlma1JQaEtkN3VlZ2RENzFVMTRRRC9VOUZXdU12MU43dWVDc0ZJRkM2V3lV?=
 =?utf-8?B?Njh6U2xoYXVQdERkeGMwUWV6Ny9GZW5JOWk0QnFoWE9KU1Zrb25BZHdyVkJF?=
 =?utf-8?B?akJkbUNPK3lUUUovZkErMVpLNmY1aEl3U2RjQUVaRkM1cTM4NDdISnF1d25i?=
 =?utf-8?B?YW9MUmRuR3BJK2VkdzljUmxUSGlsVHUweHVhVzNyVXg0N2xMeHhKelNEK3A4?=
 =?utf-8?B?aDcwUU55Z1lKeE1NUm9Oelp3MUIybWhuR2VWOTFZODdoVHhsOHhXZVB4SDhz?=
 =?utf-8?B?T3RpUlZGU3NDS3VMUEZBMTgxTUE1ZnFFV0crVlorZStnMXBDUWsxOEMrSllD?=
 =?utf-8?B?OEV1Z01FdENKWTJyT1V4UmxjR3JrTk56RjZwUkRLcFp0bUQrMGNWRzJwUjhJ?=
 =?utf-8?B?aitUZTVueVhlTUs2eEVUQ0JMSnJqRGtRQ09lNThpYnhiaGYrSDYvbnIxYlJt?=
 =?utf-8?B?MG1yTzdjYU9JOFNMNjZmallzZld6dmNBWXdaNnhHMUxQVW95UUNXLzFyRnFE?=
 =?utf-8?B?alhFdWNlVXlpYVFRcWhQOGl0Z3dobXRzNGhkNEhBMjIyTjBMc0F3blc0bWVs?=
 =?utf-8?B?UGNUSkdiQ2FwaldRTVJvb1NsMEdEMUlOSEI0QnFRYWhIQkpUSnVtR3JrUzZy?=
 =?utf-8?B?NFRKSHI2V0krY3oxYjd0bHY2NEE2N3crSXZGZ1ZWeGpGb210Z2xOcFdEUnRH?=
 =?utf-8?B?SUlNeVVHWUNOcTRReWtxRjh5NStHWkw5dDBqaVMrYk1ZTFdDNU05aTRpZzU1?=
 =?utf-8?B?U05VVUh5WUdIdWFSZlQ0WWtuUkJBbGVJWCt4blNjQmc3c3JpUDJSd1lHLzYy?=
 =?utf-8?B?VXVBSGRmQXFKMC9NbUVVRVNRaWNIRnNnTk1oN05aUDlhb1pxZk9QVUU2cnp5?=
 =?utf-8?B?VEJaVkRmV1RScCtxclY0MHdaRy95VFNzUUgvRmVva29PaWNpeFp6WXU5NnUy?=
 =?utf-8?B?Y1dUd1pTRlJCcDhCcEt0VitLRVRFMXVmKzJzWXJkak9OMXd5MjBaVEpJQXhm?=
 =?utf-8?B?emlEd1luZVRUcklkY0gwS1NWOTJrRTZQdTZtWGJHbzVqaFRtM0hoQjU1Zktz?=
 =?utf-8?B?U0pYYW40c2xHMGduTWN5aXl0dVZ3aTh5VE9Ic2lWaENubGxvamFPRy9XQ3cy?=
 =?utf-8?B?eGJHL1VNVm00MHpmMDBYLzJGSTBYUk91K1VKMEtueWVFNGo3WFp1UCtDSC9Z?=
 =?utf-8?B?Q1NQS3RKTzJIUU1iSURZY3dIdXFRQ21xNndFdStKSlg0YUJ4emFxeG9neW9E?=
 =?utf-8?B?TWNhYmJxTFdvdkpURU1hVm9vQkxjRysreDJSdE4vdE9SbXIzUm9kNTVFYlRz?=
 =?utf-8?Q?rMvJxmR5AQDxWf3cEIyLDx8T9WNuJdTBTenJA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHB2SVpUUENBT2xXUEdzSHVpcXE0SkVuRm1vN0I0ZFhYY2lHTXpQWTdQSHZD?=
 =?utf-8?B?OUhlVzVENnhtVHk3YzdRMUJ1K1FvNTRzSnBKczJEVDhDakowektnaEczbjFI?=
 =?utf-8?B?TlRjbEJmTDJMMXBqU0licW9yNFU4WVdITDQzaDJuZFlGQzVpMHdaOWFWb2ZE?=
 =?utf-8?B?OGdUeXFaSzRjNElWejFSRG81TGE1SFJiVXRnT0x5QzFRNzd3Nldzcjk2UUJm?=
 =?utf-8?B?OFByTU5lSHhWTzMwWk5iM0w2c3g3RG00eGZ4NDU5UDNtUmpJWkg2QnAxMVFs?=
 =?utf-8?B?N2ViUWMyak5qQjMvMkRscGYxeS9lK2RaSTVvU21BTzFzaWdvb0J3b1hab3hN?=
 =?utf-8?B?d2VUNzdaNW1OTEoxUHRleEprSC9KdXVPaytRd1dZSXYrVGRkcFNOU0Nta2tN?=
 =?utf-8?B?SUFMVlZLaXRoV1diQXVwRlcyRUlBU01FajkxRnhreHpoY0pxOEw1WXc4R0ZT?=
 =?utf-8?B?dHFOU2Q3aGhqL0t5cmZ3cmV5RlpvK240eFJ4a1RhQmVUUnU5Q3F1dlllM3hY?=
 =?utf-8?B?cGU2QTZBUk1ndFpzNHE3UWp6MmthbVgyWGNkMkV3R2RzVWU1elA1ZDVGRE1I?=
 =?utf-8?B?Vjlqc2V2Nll5VjVDN1AzTEdmMHdYbFFOd2g4MkZjOHkxSTlQa1ZlMUF0cnZ5?=
 =?utf-8?B?K25uRDk3d3BuVmFPK0tLaEx5OUo4ZnIxME1kTjdYdDdoVkJYNjViRmFCVG93?=
 =?utf-8?B?a1VkNjExTWFDOE9jN0xPWjhnbE9ZN2NLL0tQMktjdGxCYkh4a2c3dXlQckRL?=
 =?utf-8?B?enk3SWd3MkpYMGtFWURzODlPdUtRRmQzZXkvOWlZUTJWcEtjcHp3WFUyd3Zt?=
 =?utf-8?B?OWN1V0Z3M2lQTWdaZ2c2RXRoTngxUmdUMVVxMm9rdEYzWnFrdUpoRGs1REVq?=
 =?utf-8?B?ZTJvK1ZhaStkdjdwcHBUK3ZETStIOEdJRFM3eVV3MWZlekNVdW11RmJvSjZq?=
 =?utf-8?B?Q1QxR2swWGFid3N5bDN6aVU1WU1uUzcvS3dtR1c1Sm5UMU12UVhId01TSWs2?=
 =?utf-8?B?SnlUWFFmdW5hdXFCZXNYR0kxOHlWaVVxcVNjVTZra1ZsZmVGa0lQUHFGLzRp?=
 =?utf-8?B?cnZFVEZmdHJKck5FTnVyNnZ2Mmo5RXFJeVlYSHMxSGFSdmpuMS8raDFKUmFx?=
 =?utf-8?B?R01oaHQrK0hYK1gxdTJqeHc2ajMvVkVVL0tTNlBGMjVXOGlNRXJXVjBNN1Br?=
 =?utf-8?B?WWRxOWw3ZGRYbEdzcmJtTHFSYmdpbEdyKzRjeHExVW1sV1QzN0FsOUFuMnEv?=
 =?utf-8?B?emFUOVRaN1JnRjVJSnBTemd2cjc4TjhKTWtpcFFQTHZBV0RuUkgvZDFQU0dT?=
 =?utf-8?B?cGZkMlB4eTlleVNFWEdmWTRQcnpWVHVLZ3U1K00rWWdFMzM2Y0FneHFObEdM?=
 =?utf-8?B?VnlacFN3bW5yeWl6WXZGN2thaWFUYmdvMklwZnp4cWsxamEyZjlsWkVNRG51?=
 =?utf-8?B?bGd1UDdmWmM3akpXaHdtTTZEMmJSWDRhQjcxUENZWXFZN093RU13Q3dkYjhE?=
 =?utf-8?B?bEFWUEcvcy95VGVlbFZiYi8xSWI3WVIxRHdHTWpmcTA1cThSczZWdUxsd0sy?=
 =?utf-8?B?Zjd6dkRJVlZYZmx5WFkzSG54bnUyZVlXem9YYXIyUEhia3k1TDNlb28reW5M?=
 =?utf-8?B?RUh2bVdaN3Z1ZzA4ZldwS2llL2t6ZTNsd293Ukwwck5LMHM3M0xVMERXaDlM?=
 =?utf-8?B?eTJHRGdNdHEwSmhZN0V5b2pHWkVGbVpPUDA2SmRjd1RFQUtDcEc4UFZmVzJL?=
 =?utf-8?B?YVhzYmF1ZlgrZWdvWjh4WGI4WVhvK0dKemNndEVkcWdWYXJ3Q0U1STBmRzB5?=
 =?utf-8?B?M09KYkNkdS9QUzRyL1dLMVVLdUVqQVhvWVhWK2N5MHhnY2NoYm5XRGhXd0p6?=
 =?utf-8?B?L0lwbURPM2h3dXpyRk1sK3BhRms1V3ZCelhZWXZNY3dQWW5MWnVRank5UUF3?=
 =?utf-8?B?S0JwUjdINjVQVUdxU2UvYzErT29hRGFHUW1nbjI4RG9vSE1oQ2djaGZVWkcw?=
 =?utf-8?B?aDFtZGljMjNkY1o3SmpMOGFNeEE1OHNERjN0U0dSTUpWWUlXK1RYNzBYZnh0?=
 =?utf-8?B?N3pCWGs4T3hzTWppTXpaL2JHR2NhYXVVS1lodkVkQmJpelVpNE1WWW52YVRy?=
 =?utf-8?B?QUhuVE1CQW8yVW9LQWJIcjIrSklJRGRQcmxiZG84QVo0ZUlRNS8vVXg3VmQ0?=
 =?utf-8?Q?YZqV1k9wqg7dIddwYrTmxhbl+goEV14LzOlSZYwr63zB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB58CEFC871D66448473A8777D172D8D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1e6e4d-50bc-4793-952e-08dd039d8991
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 04:42:10.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFnqm7WOMvX89RHLg9Kl5HnXjBgk+CtaEEOL/+z4RAMYzDSp/KmRQyhlmnaFNyY/kXTgPk8oTxqitPN15PBEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

R3VpeGluIExpdSwNCg0KT24gMTEvMTEvMjQgMTc6MjksIENoYWl0YW55YSBLdWxrYXJuaSB3cm90
ZToNCj4gQWRkIGEgdGVzdCB0aGF0IHJhbmRvbWx5IHNldHMgdGhlIGNwdW1hc2sgZnJvbSBhdmFp
bGFibGUgQ1BVcyBmb3INCj4gdGhlIG52bWV0LXdxIHdoaWxlIHJ1bm5pbmcgdGhlIGZpbyB3b3Jr
bG9hZC4gVGhpcyBwYXRjaCBoYXMgYmVlbg0KPiB0ZXN0ZWQgb24gbnZtZS1sb29wIGFuZCBudm1l
LXRjcCB0cmFuc3BvcnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaTxr
Y2hAbnZpZGlhLmNvbT4NCg0KDQp3aGVuZXZlciB5b3UgZ2V0IGEgY2hhbmNlIGl0IHdpbGwgYmUg
bmljZSB0byBnZXQgeW91ciByZXZpZXcgYnksDQoNCm5vIHJ1c2ggLi4uDQoNCi1jaw0KDQo=
