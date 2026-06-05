Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709111A683A
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683238; cv=fail; b=X7/NFWAmwEQfB7gd/0XxasNMnldwqo8HKt0Gppah0zPMOZOc6ftzX+fpa6QavlSd521stm2xAPFnEeTk6uqNthk9PBleyvp+6aFQ4TTmjWVCmi3b7P28H1etucSrk9JohuvGqjAu30uuf2osl5rwqYpEauf7WCsOxEU7zPpawPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683238; c=relaxed/simple;
	bh=5GoZ+BL/0Il4vmBWH3BEXhzHS9cnKuxnjPsgzYtI+gQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsbdrd4G0kwH1UAV6rPGm7/BDXCScZvqFfEZ/tZjS47hIJjkBws4Lz17LZVA9lWak8Do3IC/j78NEraUgLxIwQEPDkTsK3yNrwg/0GhWluJhYrJqAGNyoUe/2hZ9zvpot+cUbd1AIrPK0t1lEb/lH104qKvOw6Yd8myK90cdKok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EByCLIw8; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EByCLIw8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBZfNBBp/YvRBqB9EkQJFD0pRUGcrvq6m/YDrQ32GzoZyDeIeyhQdw7oR5pr2uZPGA1itGuW2GzFFDoGsaNjEJ0DMaS0bDG84KvmxLXiem1UvdkcQe9covtwLEBOD70LjWMTM5OhxQU8DZGYcc++EPm0CLpjBgV3ggSSQ6ow/6l0nIPJhNXUc+FvnfY+RgbbOxdgD8EB747TrHbU5Zo+vPd2P3LitdVBc3N+ZJe4U1PoOtNIn+UKusnie5VO4ki/X73Xb7AMX5rrxC0L9vraVDqR7+oi2HZ0afKUPDjwzR8zQbDiOwhNvUx5Czw+GQODYzHyLez942FP+7wSwNiuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GoZ+BL/0Il4vmBWH3BEXhzHS9cnKuxnjPsgzYtI+gQ=;
 b=s5N1NHcP8JnHWZpTfifaQZYQlx8bynBz1rG1ES/sPfJZsPgnCN90JstSB/EY0cDBh2QFGcYR9lhUbNUVyk3fzqwZ7h1RlOX5kBaQNGbReYG5qRsCqZOonGL057ZAKByrNESiIOyNLuDjVrdBE+AkKjLhUA7xi0aoK7lQoEhJwXrvcQn21ra3oPnNdAPWUYHT/MdHo3ARXSwQkMDOUop2Ir90b+wI6VPh5rxGljtO3ce8tM8o7O743NPBhXi9O9NcAO5CR0+jl+6JvEibfVfQeDZh6RDJcQtuwKeZq0I5hsCtf6jhmQV+vyOhSBbYlYb1MdqmuU2psoIkeappAt8nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GoZ+BL/0Il4vmBWH3BEXhzHS9cnKuxnjPsgzYtI+gQ=;
 b=EByCLIw86t9vu5XZN62hqnO1BxR03eVYpQBHjXJIMWd0UfiaP7CBLIB6F7wYRJY46gntVgH95lU4eAGdTEEOGTez1LiANH0yAS4t41K0kDJpAaVboxdYEGhHptmMfK7/dkXdgB5SP86RxTwDgQdFtu35kyl3FVzB3xeH98UMozoUJMtbBQI4PntPMk4uTQP+QltRWfCLUXamVQDib1Yvg4P9vh6g6sKohpTdIT1s9pZY0VSS11bC/4xulvGNNA9rT+a9QFuyorcQSolYGVQ6Cyzr5zINQdkGG0X6PAXcuRz1yHSXxVBUxb2HLM6iCWhTEH3yxn4ywT4MJDBU5OstNA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:13:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:13:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH v7 02/14] block/bdev: Annotate the blk_holder_ops callback
 functions
Thread-Topic: [PATCH v7 02/14] block/bdev: Annotate the blk_holder_ops
 callback functions
Thread-Index: AQHc9RWz9gWsj1pX8k6hhApqjqpNwLYwQ/OA
Date: Fri, 5 Jun 2026 18:13:51 +0000
Message-ID: <100f9f03-501c-4f4c-a417-8c0f675d48ad@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <be51cf81110f691ebd5868ac2f15ceb847805bc8.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <be51cf81110f691ebd5868ac2f15ceb847805bc8.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: d786ed73-23ff-41d0-bf92-08dec32e3283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 xiRrjNVT9P/Ze1TdpABfy7K9tkD+JR//sEmBGExR5grcRiJ7g7WtwrAzcGzckLvOV6If1EtoAjyvqmaRq5BSQ23nPsOgwtHia5enWecmZx/igCJ2wtE0ZZpJDkfi2+7LgZFr4N6f+bK7JC1hRLa1f1ub9OEtWKojsiZgRImclWm8d18BbvUlghj8QraYSEevKAgfRyUXo+AByg5DQ4dubXCYmp7kifq43jGPlchR5gsRR7JUib2mCJS4FXYWKwHl2hfC1iZueSikafiNfWP/GnligczrgMpdL/FLnlsutnwwMyz3xqLJb+07xkkXzGJ028glSB81R+aByG3bz7LN8rnCVU4tx9cZA7wW7FPILFmNH+fbm1tjsQoknzNs/9e6Q95XwhxTfyvG7wcttUNsmHP3rj/K4CfY0RgiytPxj4TK/KtGoZg7uodKC4/D9HuImhqc97wqyR4sfCuNYSv9jN6OIhCm/jVwzEzq17TnRPv0Cy9APpZe+mCJBRn7sndLXyLQI2Iubv4ab22aJ+Mpio1ZPvH3f5XI4Gjx5+mkaMjTFI6IJHv65uMeKbRRnjlEwfmgGMtCzGoGZgayt7NQu1mmGEP/Y9KzDZwqz+JaA2r9EJeQ3Q1CtohimGNSNFIcL054Y5JL8dNYZdvtCDD1b6BhyAAEJR4R/UeOeQsi35iv9hRaErK0Xh78snEU3O/soXibmG+bmXghMfEuSZ6eMtsiezp6lDTPydBTLlRegzQN39BpUvs4K1h+qbAgWKxG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHRsTGZlcnd5bkkyVEpnekRFM0E5bVI5MjZGakVia05Oby9nOWo4d0JBbXZj?=
 =?utf-8?B?eCtKaGNGV3VpOGhxQ1ZramFqYlY5eDV0amlod0F2bEZVc1RBVlk2bkpJZE1y?=
 =?utf-8?B?WC81WHpLUzYzNWd3M2JWeS95enFNN2xsekxVZURMK2JMMkhvbDdMY3FaYlo2?=
 =?utf-8?B?bWlKTnl4bHNxSk5SVEhLclBDUkx1SDhOVHpQVk10Wmh2aXlCWTVZNUlXTVIw?=
 =?utf-8?B?ZE1JUHNCZWNWQkdqaHFMSlZ6cFl1S3BRWjVPR1BoNnlmc3Y3WUVVdFBhMEdT?=
 =?utf-8?B?UGE3dlhYUk5FTEZXSmQ4Z0o0UU82SkxMVks0cENRR0ZFaEhGVk42UnJPb1NR?=
 =?utf-8?B?V21DSVFncmpMdVdMOUZpcUEvbzVCbEd0WW1QYmRFTUxCZk1FY2VZZUQ5V1hW?=
 =?utf-8?B?cU5La2ZUMU54WEFEQzAwdERpTW1zdXVLT0lXK2FxUkNTei9YZ2lsc2JIM0RB?=
 =?utf-8?B?eHJBb2xPSFFFL2Q5dWd1Z2RFQm9YRlhGOTBQUWxSai93YVFWU3RZSmo5aS9z?=
 =?utf-8?B?WkgzMTQ1RVhaMmxiOHdHRUhsdURSV3BFZzZ5YTk4b0VDKzhyUnFyR3hVUTIr?=
 =?utf-8?B?d0lNN1dDVElUZmpQVlBkTjFxWDhzZSszbGVXSDFiM3dYNll5Wldwcnc0VkZq?=
 =?utf-8?B?K2F6VC9Famg2UVNMc1JIc3VnM1h4YkNkOWx2VVdSREUwSTBXTERTZ2owc1Y1?=
 =?utf-8?B?MzhTSnRwb2NNZjRoNTZzbkxGby9zV3pOSkh6YnUzMVovSktSWHVFSXZNU1Q4?=
 =?utf-8?B?Mkh1TzJOcTRyaUtXc2JlMjU4ZXZyR1A5YUlJRUdFeml5SXh5eHpGbmpHVG4y?=
 =?utf-8?B?SERDMi83K2FTTTNNSkh5OXJYazRsSTJKUnQrVU5KU1FKd1N6bkNmQmk2Rkxy?=
 =?utf-8?B?a0RITjdvSWlSYmx2c3VWSkpGbnFmMzQ0allMZGNEdm81bFFsN2NXNndBdXlP?=
 =?utf-8?B?V0YzaEVlcStTMHpsYWlaek5zN216aVpRc1M1K0lzQUlOMXV2WnR6NEFoSXZj?=
 =?utf-8?B?VHA2cE5aNlNXSzkvUHBISGhIRlN3K1pXa2VYNm53WDVzTUg4ckoxQjBaVEZq?=
 =?utf-8?B?VTZjUlhsbmZvV0ZLUzVCNVArOHhZbEs5blJuUTJPam9wUEpGRU44N1EwTEdX?=
 =?utf-8?B?ajFQWi96TGJxVnB0TkpaVVVOeUx6RGZjcnl0RkY5SDRCVmh0djdycmRlcEMz?=
 =?utf-8?B?UjZDb1RVUkpFc0g3UXdCdXB6dndQQzN6ODlBQkJnZ2hIaUdUd1NMcER6bEYv?=
 =?utf-8?B?RXBSdnVXZlpaaGRHUXdHa3FQWTNGNTVHWUIwWkY1L3JZdDkxWmRCUXU0cUdI?=
 =?utf-8?B?Y213NkxaM3R1WlZLZDJpSU9LQmREOGJ4RWI2RjJmNjVKcjlIdjl6QVpvcUpB?=
 =?utf-8?B?akVpUzFDQlp0SU5EMUV3T3Q2RFMycURUTkNHQldQdE5sZmJXSFFCU24wZ0R4?=
 =?utf-8?B?QjVVL2VwMmpmaDhBbmJrRXJwMVR1bUY0aVdXVFF2Mit2SDNPOUZIc3RadlhF?=
 =?utf-8?B?UzRrZW8rSkZ0VkNER1ZhZU1ZZ1RsRzJRcmZIdzh4OUhtRlAwTXR2YmMwM2U1?=
 =?utf-8?B?TGR6ZWxRUXpJOEwrL1l4QW45OGxrWlovbk85Um5hdDFsRW9hcHhMeGRoUUM5?=
 =?utf-8?B?VjdFSElod2Z0YjMraXM5a0p6U1IzamdvcXpaeDBqNGIvUkdIYmdwOHZYdmZh?=
 =?utf-8?B?TUpQWFExb3kvaysxMkc1MmRFbzcvVVdISnJCZllYSVZtQnhueWZWYTFUUEhQ?=
 =?utf-8?B?cUZLTmZSTE1iU0NreDVlTHlPalU4ckFvQWVDSUswUHlGMEV4bjVVNDBVZkpK?=
 =?utf-8?B?TEtJUU1qamV3RWJ6QXpvNE1xOE5wdHdNZGY1WTliUGM0bFlxaEs0T2Q4ZXcy?=
 =?utf-8?B?ZWF0cXhTSXpwcEltK1NPdldhWUwwWTdub216VlNyY0EwU21NcnRmUEg5WFYr?=
 =?utf-8?B?Ymc3Wld6dWM2RS9SNjVycHVVZTRabWY3VHFMZE5NNmpQK2RiRC9CQVRvLy9t?=
 =?utf-8?B?Wjl6MjRxY0RGaGh4NmxiUDIxRzVEVTlQSjByZGFYZlh6RGRBNjZ6dExqSEtI?=
 =?utf-8?B?VFNnQVpwRlZxeit1ZWlJT3dkUloreGJ2L3htaW9vK0o5Qi82NnVRWFkyZmFw?=
 =?utf-8?B?MFFWdlVNT3FuTFhSMGpLNjN3blpQMGtKcWQ4NVF4bGNJWFlJWndvU1N1OGxS?=
 =?utf-8?B?NHlqRFJ3ckJORDFEeCtMQTNtaUNGVWxHbHBjMUFZU3BjcW9LTnl6b1h3cHVk?=
 =?utf-8?B?VXFLaytZQlcrazk2dk9sWGU1RCt1ZXRkZmpadnkyNXU5cDFKcWxLL202S3cx?=
 =?utf-8?B?SEVEVjM0TXJWcjZCTWRJc3RqMjhCOENIU1IvOThLU1FOWFpmNSt2ck1oSFV3?=
 =?utf-8?Q?PEml0MYJjyYt3X6cumH3lrVip9RwahPaM011k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D71BD6C1E754F4B96D7F1F0324DCF24@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d786ed73-23ff-41d0-bf92-08dec32e3283
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:13:51.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzGJml7oHIpwAfbzE7WY1n8kylurwU27lGJ1zwHboh0pGwQ7H/wMFPNXf/bNNHlYVMr/15ciu0/KFYa2nhLbjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

T24gNi81LzI2IDExOjAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IFRoZSBmb3VyIGNhbGxi
YWNrIGZ1bmN0aW9ucyBpbiBibGtfaG9sZGVyX29wcyBhbGwgcmVsZWFzZSB0aGUNCj4gYmRfaG9s
ZGVyX2xvY2suIEFubm90YXRlIHRoZXNlIGZ1bmN0aW9ucyBhY2NvcmRpbmdseS4NCj4NCj4gUmV2
aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZTxoYXJlQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZh
biBBc3NjaGU8YnZhbmFzc2NoZUBhY20ub3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
