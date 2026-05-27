Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632E3BB117
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900668; cv=fail; b=WBjo52PXMfe0cEgYgGN+9LV/qhlC5ag12uQdCozHvghDVxW+hYc4yrfGq5MR0iwTOFaycxPVusBeIl0XtC2pMIbFZJi7EbUXSSl2Gf8Ozme9ZA9s4IBIAlfI8t0O2EJuzzdZbCfUsXkV61rrLtLznXqFl1bjNs0a6R45cSbQupA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900668; c=relaxed/simple;
	bh=9Ba5HKZYOCZ3oomA0z0QClNHXNgFHvkuW/01EM5qmXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJ/WVqr8sWqmie8lqGcIJZ0G+WU+2lIyVN3kT2yWJ1zN5dA3tN3HzhPCN3lzkIhl37HWMknnYcI4EuizN3FvgkpE4NUj0WYC0wUT3Dfe89Ej4gPi1Fu7p+M0ek/Xjal18lx4zzJUqmbMQ/iEyda5/asi0YNKEhK9K55iXAx0NSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=on5nYavZ; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="on5nYavZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYLBMolmNlmTYKoizi1djksYFp74ty7lqp7Ymz6FLrSYDAot72MTeBUbx7jvVJcnAZ02BOI3Xbb4d9YubEwEPYb9UBlvPgy+Xr+6OR4z53LvtenMraGXCmky6OgdFr2FjfzzU+NkZT3s12SzV5ETPhesf0ucCgg806j62/y/hMmWvrm/vmkwBUhaS13fXh98yJvsDN8v/s57cfIpVQFBrr/HVbDnm2IOxZezjZ7cLyikMZPv/8sAigZhDemFiA83zWGAYdZHfPlYMrwMX7JG2GP5Tu1DZvtlDhA007SDq/ijRb4zdlj/serKj4Mg5vw/WSpqCb4Ql4m50oN1qhc87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ba5HKZYOCZ3oomA0z0QClNHXNgFHvkuW/01EM5qmXA=;
 b=SO+6MZ7jOpwV+ATb46jPS7rHbj940gy+JWw5KddpZ8riiicSyHbGG2VNKggulBZ6Za9rYLmhaUZWO/ivkwSifH4e3FDJ0S4XtNt8kEvBArgxhGAwNQcDQ/f/qOAeleTHNN6l+CY4EwJBd6j6DXK281zOMgbuOXgfHaD6T5JKB0XfRrltNe4mppnZevSCk7B5mVjG374Er0Puqo90lofXVvhdGSEmJe08s87YyiXrXpcKPt8kl0C+AOwMA2RorXDGLMV/V54/dntYOJqRD2Lih871kdskXNvT+yEcJ3phFpmXNiqBa116n3P8w2T1BqM/XoO/LQuiHlOAKCgO1uOHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ba5HKZYOCZ3oomA0z0QClNHXNgFHvkuW/01EM5qmXA=;
 b=on5nYavZpwmDpKZ8aA19KIAPPlWSC4WE3aLihNf9q/klO+2ur6moSrZTA+s2XZOIr7p7phDMkXqwhBttGurnTkThvcWXfet0NNeCoFQgBQ1rJ25OyuGtl6+/IB+EJX7qQavyyd5hN6NGnAFh68T4Wm+2QaRm0eqq5h7PSR5toV4L1GNXWBKhU8rxOsTHN658xkvX/VTOBtQHexu4PLdJr6T5QNas9MxkUek7baEiWDhyDuOtwUpAR5CqUeFVoWLh5sqm+z8Ic4vYKC2DEJe4V1xUWMVTO0daKAnlOqOxKOxKQp8HBOji8UJ2M/6+azMIpiCd1nqtWJ5Vc3FjKdPtxQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 16:51:02 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 16:50:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Ming
 Lei <tom.leiming@gmail.com>, Bart Van Assche <bvanassche@acm.org>, Caleb
 Sander Mateos <csander@purestorage.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] loop: cleanup lo_rw_aio
Thread-Topic: [PATCH 1/3] loop: cleanup lo_rw_aio
Thread-Index: AQHc7evMFzuGZQctlEiOElM28HKFsLYiFiKA
Date: Wed, 27 May 2026 16:50:57 +0000
Message-ID: <76eea33b-696e-4a88-87ec-15e7acde9db2@nvidia.com>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-2-hch@lst.de>
In-Reply-To: <20260527151043.2349900-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8354:EE_
x-ms-office365-filtering-correlation-id: 1b2cf03d-87ea-48c2-cd81-08debc102006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 9ajuQmfJhvaPmDhlHz/0Q4rgc4wpv928Yw/yFW5N0nvCdrymbvSvZw6ltMTzGcD3/A+aKCtcbsXC9FSFKgswNXdT40RPD9LfDMUYgiW7tkr239BPwV4c4TtOeXxmVPZSj69g16pCyevqTzYT4Y67mC8fsZPswBfidJXxuMYI0LgOD92cav63UlIYbjcE7+k0yikVUpSUXgU+GpJi8vXPbL4CnJMhr3hciV++d4K9mgKk1A1gI3kWV0BQ2sLNTHGJZlXRAo4iDSx521KIeMB0UYY4iXQHc2w9gVQbJEvsTj+7TagbAjPHdkEJPRquxHCSmA9daYAKeCu6/SJHC9+iTIiS7sCAXCVoRGX4RE92EQMCi/SP44GbCqpoXwc3iqszQO8gKNhtatCTQ4mEo0QOIxvBfqcy2Dbb1mhJP5qo1bqJ+lIhqImj2fxGP5w7ThPeQGzszDQMpixsEjjcaWCxnZZLFQKxpYu+RGu8I0RXAuPBJoGdxCdDSLeML2nfbcyIfyecImy2+rX4pK9eKBKodm6KLvNrqeYwnGxRLlzy7hqS8PL/wYzeCeYe9op0ym6KRHO+9eIiBr3mi2xoUV4JmwNUkPlUp4YUGtqHZ+p4le9/nXRFRtPmUmPuhidV2KSEYAH0BK9rbDoPBWtG5XGn+7bZ9myQIhvtktygoa8ueD8sVXm/oEE70UXPJkdPCRVjBJjkzHc+/Rq8OREdP/j5+msD5zHDnURW49cvEKSkuwHpXSbTYh2PXNWYRxSz0/KK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rmlsb0RoTHF0TE9mMWVYeWF2M25PaEwrVzdJZ2tWWTJlWXVLZWprZEhMMVZ6?=
 =?utf-8?B?bWtOWGlMYVYxVnprV2lsREkxVXRPSDZrNlVReXhObTc4M3pITkI4aEg3Y1Ex?=
 =?utf-8?B?YlpkeTI0Qk5RSGwrVU94L2kvR2J1M0dTQS9nai9YOHZkTGd1WWloWU0wSjI0?=
 =?utf-8?B?NFpIRXZIc0VockswazdYTmtwM0ZDUlNFSTR0NmUrcjM1emNIeUY2bWJpcklO?=
 =?utf-8?B?a3ppQzJLNUJyNmhTVVRpcldxWDE2M2ZaUWlOUzdoSlpFb2kvS3YzVFQ1aWtl?=
 =?utf-8?B?R3J4ZTh6MVNrUFd1TWM3WXBHb2xyOEpwQU1leEROWjdXK3NEREJNM1NJWU9L?=
 =?utf-8?B?TEh0cm16NHRTOEVkNFBTbE1mNStzRlVlRm8vM3I1V3dmSis2ck5oMVpjYjdT?=
 =?utf-8?B?bGlkOGtiK2g4ZitEbGhqNldvK2ljL21GeTNJczlRUWdZZjh0Y1drdDFueGEr?=
 =?utf-8?B?VE1uTUtOVUNjMTE1cHRVY1ZFV1lIYU4xaDZCUytML25LS2NNREh4aEhKREFP?=
 =?utf-8?B?YjFOZ1B5MERWRzIrcUhmT09TN1RrZ3FlY3VKUzJvTlBmTitvRXBZbVZCTlUr?=
 =?utf-8?B?Wk9xSDF5SVJLbjFIRVZKUmEwNlNKNnpsSy9vSWJVUkxzVlRhME00bnVMaU1o?=
 =?utf-8?B?OTdvRFh4WTNSTlhLcDlOa2pkQk92SW8yNmRqakhIT0szbjRhNzhsNXQrRWc1?=
 =?utf-8?B?R20xNEw4ZDBwc0l3Vy9weWVRT0xNYWdPVDhRbVhFemg0bTBLTzVUVE5tbU44?=
 =?utf-8?B?RUlWbSt2alplN1Z3Zk5VbXFKVHVGQkFzQ2l2SEthSmtaY05nMVNMZTZ5T1J1?=
 =?utf-8?B?TjdMKzVDcGUzaUsvcVlWRFFOcFVIMlhjUGZKbEJvRUlpTzlmRHhxVTI4elhJ?=
 =?utf-8?B?UEw4RFhVNklkMWo1STdBTXNFVWkwNlFQMjRnODVzcnQ2VFRBUmh4OHM5a3kv?=
 =?utf-8?B?V3Bjc21UVXRxSU1EWGplUHdra3hkY1Bpc29ld0JNd0RYY2tGd3NSMWd5bFo5?=
 =?utf-8?B?Wmd6YkhoN2x6ZzUrT3BxQWRvbWZUR3IxVVN4bmdQTnJkb1ZyODVweDNXM3VQ?=
 =?utf-8?B?cllVL1hwVEhiNkN6TWlEQTFoaHQwUUNaRFZhWDM1a0gvMkc1VFJwdkM4ZG9o?=
 =?utf-8?B?Nm9yeEVqeWpIdG9MZVBvbjhtRG9ISFVIaEoxeEJVTXBFTjljVEhUbUcrTjlB?=
 =?utf-8?B?eTVRUDQwNWVzb0NYZmVyTGp3Qzh0aFZvckQxN0FzeExwa2lZalV0SHk5ZHps?=
 =?utf-8?B?Vm42OTR1bUhuYVlSMEUwcS9LN3NjYnBhR1dIVXRnajRZY2FIWHYrTzJNSUx0?=
 =?utf-8?B?YTV1K3BWOTNmc1ZCMW9wQVRrQmp2czh6SkdhRGUvOEpEUWhjRzg0cG96YkhO?=
 =?utf-8?B?LzNwRS8xOUEzUmNPM2dFR3BPY1JXbDR6aUh1Qi9mc1pLaFRJbGx3OG8xYzVt?=
 =?utf-8?B?OTZVYUNtNnJxelpMMzQ5dTNjZ2NvdkdxazJiT20xMkpOWGZXdU8yY2R5NUpl?=
 =?utf-8?B?Q1RSclo5SE81czlCZVdyYWtPQmtlMnRYeXJiQ3AyM3pJWDkyckUxblByUEJx?=
 =?utf-8?B?dWtjeHE0aml2RkhVcVVSY3ozdk5NYjlOcDRYYVZtOFdjTGlsNGxYV0d6eGZv?=
 =?utf-8?B?Tkg5VGg5TnRqalllOHJ3eHJyNVJFamM2N3Z0SFFDRXdTYmRmejNHcFFKK2pR?=
 =?utf-8?B?WVk5UEV5akhMLzJLMG93RUsrb1pONThIdjJVZVA5RzB5ZmJFcndzeWVJb3c5?=
 =?utf-8?B?eURpUS9HcktjQ2ZHNThkKzFUV241ZWxpR20ycTFnTVZBRFU0dnVyK0R5aEk3?=
 =?utf-8?B?U3NqczZjbG5HWmhNdDhONDIrcE5yVU45enJCbE9KV3dnYkdvUkFiOTB0OGh1?=
 =?utf-8?B?T2tEdlM1TVNHNlhpajZrVXRtQWcySFRvRERlK0lseFQvdWRVOGpQOVBUTnAr?=
 =?utf-8?B?S05zL0tiWmVZZmJJL1RpR3NOMkxPemwwUE5qR2xXeGJLaTlYL3UyQjNDRFRv?=
 =?utf-8?B?UkJTeXN2YmRwcHd4a2tHM1F3NllCOFJtSm5LZGMzbTVhd00yN3ptR2k4d0FT?=
 =?utf-8?B?bkkzbnVEVXViYXlJa2tzVXF0N2Q5R3B6cFhzV1labmdVZ1RiOGJxQUNsNGs0?=
 =?utf-8?B?K2J3V3dKTmhzSWVhUWpDZkl3bzR6Ny80ckMySitxNHQ1YkhiK2k4NU5lTlVo?=
 =?utf-8?B?VlBHUmd4ZlZkckx3dURzMFl6bG0vZCtDcFp0S2VhZ2hkNmNOVm1GeDBpeXRh?=
 =?utf-8?B?enpRL0QxdHUrc1pUYmRsL3NuWW1MZHlQSnk0SXRWcmc5MWRheDEwa3ZnYlZy?=
 =?utf-8?B?SXJXTHFhb0R2RkhrZnM2UWdIOGFOVHlSUDVhTGFvZ3g0UnoxK053ZXJHcS9l?=
 =?utf-8?Q?7syXE/Z5gfFIDqQy42Vf/Yl2BxlrM52a4hk/L/ZQr9MpN?=
x-ms-exchange-antispam-messagedata-1: srH7ZlPLTXvNKw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B541B1003E2F44B84CC7ED79CEA7560@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2cf03d-87ea-48c2-cd81-08debc102006
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:50:57.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzBQF/AgVNcp0O4pKv4s2JVs5tApYqNvUsccD0ZelijB0WGY/Ouq6pClMKGWVdXI/8rKJL8wpp3g1AYfo9Dtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

T24gNS8yNy8yNiAwODoxMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBvcnQgb3ZlciB0
aGUgY2hhbmdlcyBmcm9tIHRoZSB6bG9vcCBkcml2ZXIgdG8gcmVtb3ZlIHRoZSBuZWVkIGZvcg0K
PiB0aGUgbG9jYWwgYmlvLCBidmVjIGFuZCBvZmZzZXQgdmFyaWFibGVzIGFuZCBjbGVhbiB1cCB0
aGUgY29kZSBieQ0KPiB0aGF0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZzxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
