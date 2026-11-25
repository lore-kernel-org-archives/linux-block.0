Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647505;
	b=XRyhcHabewEiDptLH7BsXAPPht+ypykL7xvFmN6+Pf/spHBzOVqiQ1yrW+xn4YJ5JWxu
	 ZAGsVdeXrKXo/MpsT48mjjQmWRxExiJmjIIwu5T9dwhT8orW49yn7ZnVCqDbwhzlfZMjk
	 eSdC4Zcxo8ocYdLSFIguSxTaA9gPOMjps8tTORNlEQZvdtgEi3g6ouh/hHK+lLJWNFHGC
	 YXjuUmHjV0dYuStYR/f2KZq74iUa2jxtXe7RQ3xclSf/SQEUTTlzsFBWyZ8GUUIRjW1H6
	 uGZTxuXqKLApuLps3XDwcaM7ClPuUXcP+vf3c7Jr7zIsULn/f+q3Lp3Y5suyah5g7lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647505;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
	b=bLaORVb/5yJTtMj74S6nREEvQPvV4cXMx+8d2H7XAG+rlEBtz431Eog9dS01jS7kIc4w
	 +/wIGnPs4t1hbwcncryepG3IIjsofc8cFbRJcJHBL9+oNLcCB3Fpb9vWIzmv6cAEcrxvn
	 yQ0UjdUXhVg9PvKFtsZsDYAEcTXTyuSh74z/Dj45lNAY0XggoQFCW9u3U2PSVNaiPTpkU
	 /+BOPgJ41Z33EZPNwontRDv0ymuGpdSxeC+aeh6e8UoXPUsaGnJQYitSIgdoMcDiGO8LA
	 1qdMEiTYWQIGQNkEQmsurqJF+Z5i5svX5eyyMm0RMlATvmpWGaW8Nql0C/karZ8fegQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ePqBwAMb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.13
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B568606A327
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B568606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ePqBwAMb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt8sxJj1vL3btbUH7mpK0lLHl6AKHy34LBkZS4/saXIE2/nALBBYIYiFCnVJ9l6n0Qo5ZswFd9Us42iB7YHTnCsjFGIWWeElPQNxUhcAHY05+S3j31En7VaB65HUKgcBjLqR2Kq16Rnsvts5D+xt6rDBx0TKmW49nrx37zld3RahBSM2C3qMavaueFuHEqc8KZhtuvQyzgO5vk9/0M5oAi3d0Ry00ZvxA39VIccOLD2k0n9cOBx/SIT0+wLxy1OSexfkuE6Qc/T78o0BR1D+HnN6nitgqZsfv8blxfKlDZaoZiKeIys34g6NxzJUtOnf9UqjiilnU7NyW8nmFGucAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
 b=SLhjDN5PQIb/lM0+r8qh8M7tw4X8lL2KgSVKaQATIqM6I2qjo5klu9Mpq14UQx9+PqoPle8fBCume2bsr0fh8aI0FKgnRco+Cr7J4Hd9JkmM+EnX9X1x0QPSbdXWNPqQlaqWhClytypDz8k8xwy51vCHX+nUkXWn6lAZ0KDNfp2pcp6FF+54aZh2gxPpCiTcGsx0fXWQh2ILjWBsCFmMvvpnyKgEJbLaWDRDe1luDONFnoYfEJGPf393xTF8se11VYOBU6yELGGjX3Egoe0W0AfWhbyQrKMaSLomE2cMUrd1BoTPLTkCsi9Zu24ihoefo4sKGup6hmHHuHMNePv8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THdUqiuckdMXBVc38pNnZDO2uOiBGPDGq5e7Q/ZPk9Q=;
 b=ePqBwAMbO4WMtn4foYukI28ldeKRh8OLBt2kmp+xxPY+POs0RfQ3E/uFXalhaI5aBt0FrpuzX0Y6dG/qZym/dKwwd28waYmTt63FT+xyvNy/FeK7o7PAWkQKi2/boZbijEaCC7fwLNbZTLyY5hBDmAmx2fh5/ikdyZqWlZ5AjbM1D5FSpCgZk36s8wWE6BUIkor3RuLxpNxGgPOkMPMoVEagTQbakHsdzBfXeI5r14I2VItW2hfWrKaeeOn2PmBi7OGDI5frso0CdycxcdXlMQJIF2IF0xY9P3J/do/NdwXyZXA16zcCEnewWMuMhvt1imqzxiNqgCvpQFZW0vgaHw==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:57:50 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:57:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 2/5] blktrace: pass ioprio to tracing data
Thread-Topic: [PATCH 2/5] blktrace: pass ioprio to tracing data
Thread-Index: AQHdfBjPeLGMGoccvEG6oojwiW/oS7c/aJgA
Date: Wed, 25 Nov 2026 22:57:50 +0000
Message-ID: <ecc418b5-5fef-4e41-8ecd-2af2485306b2@nvidia.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
 <20261124133553.152463-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124133553.152463-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: 32b417f5-f3eb-4831-992b-08df4b47880b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261026121527099003|261102123227099003|4143699003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 tHGAYSfMrr9PCUOCdZFWss3AZVM7hO+NVBDvEzV/ADDMhVsZDhSbzaw/XoencKkX5ub6YX9eMTEKVghsDNh3pPMtro468wi4aEXI4WBKem48mxVgb7ElWrU3EqYD8O83BY2ktqQ7TGXeSDbrIaKqax3tq6pHCw1ZC6mcVpl3Q9rXI0imzOvQPppHBSWKqsgQOis0ViIHtRiTw+rnJQGW9ORvziSai2FJijqLrO7iLZSin4jFKxMoCXvsXw+Hs4TVGqAKt5F73gmXvbHH23GOmS1AkQn0tzJDL+ZLbXuTVyWw4V+ivGgotVnZPk7/WKD325W3zmpAKKWAfUDuLMOd5Ps9cQttUAO137TU2ibCTMi7rNYG8R/yg1ErV/qnEePSHlNIDNG9j2ljkQM5FME45HKAFerhy1o2Jb14lnQG5vxYaLHAGAMa+YZsR9P/++qBOrNB7IOADToQRShZk1F5egEPcMGdEN2luDRZzg0Qqdx98ba1Aj9/sAVjWwYqeJdgpt/c3m5Zx5oymejSjsn7DqaYPNMHH2/nrUGE7Ii3XVirHu7U5ijVvLwzTh/cuiGmm41t/sOvdtNZUZLmZkTQ30u4WtpdQiJAcVB0+k6Q9bPzBVgmYFsSc8I9lgzYb5AlqunLHLndHLMLMi2zjcLGnjyt4AyZaKmiIP1pP9as/snmHdolystzgn4mrybaYYpXlJ5dkVqZGUJh7i7oAwTtEu+6+w00wZ/6URC/AY77LeU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026121527099003)(261102123227099003)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SElMbE5IQzJkZ0RIZVE1VDBnNSsvamJsdnlvaGtRcFduS1JwSlFaMkxjYTFy?=
 =?utf-8?B?MS9uSVFpcjk4VG1uWWFNK3Vpanc1cmM0V1VTZTNtTmhPKzg2ajVWbjhlM3JB?=
 =?utf-8?B?Qm5lQWZ0emJWdVVOVE5ta2pDSkllNWM5bWI5SnFNaVkyU2c4U3Y3VUo3YVQv?=
 =?utf-8?B?Q2IwZTY1eENITjhhUmJNRTJkSHVZSmwzY05uWGpWWjBwNnJvQUJDM3preHpO?=
 =?utf-8?B?aExwY3RhVnBvVUp5ZWNtdms4TnJ2Z3plQUFZcGZTajhpSWxpRDJQODgrNXN5?=
 =?utf-8?B?T3d6RWI0TSsrQTJhTUMxemplTnhJWVpRWEk1UTVkKzNDeDROQnd4eDl5SUY5?=
 =?utf-8?B?MHFSVXJZR2Z5c1EwVmJGVDBXMUNiOG82cnozUnlHVTRWMU40eE45SXd3cUR4?=
 =?utf-8?B?WTlTc010NWIzd1ZVeEM4cVRyN2lNN2VWS2dyc1F4TWd5YmV5dmJ5eEFodVhG?=
 =?utf-8?B?U1FHMkpGaFlaSE9NL3hnVHJNemtLd0lmejNuRlhXVjJ1WXJJbGVVSzU4Umpi?=
 =?utf-8?B?WHFjUEVhZ0M0M3FCSWxPeFpLZGloeEErLzFMdUN0MUNSQkV2NkFhbDcxS2pW?=
 =?utf-8?B?dmpmQ0lnRUtLRWJ1U0p5bStRNGNDTy9kSHd0VDNFNmZlaTNXQ0paa2hEdVdZ?=
 =?utf-8?B?ZlZPMWgvY1J1aHd4Z0FVTUdGSWpiVCtTeE9zTjMyME1WSFZmKzVzQUZBV0hi?=
 =?utf-8?B?NEVhdkNzekp5UVljL2tGNmFEMVlId29BNWtqbTF6UkdkMUs2cWljTzBjQTBq?=
 =?utf-8?B?TXA1ZFRFNE9IQUtkUnRZMGg4UjhXYnJnQVMvU0ZBZGtXTk02YkNIMml3SmVK?=
 =?utf-8?B?MXFYKzRFc3pocGxjb2pOV0swZ3hkOGlLR2VlWWFxYW5LZjB5M25CQkFBa05p?=
 =?utf-8?B?RXFBcW15WkZhdkdoaHJBby9YUUtYdjNtNlhvZ1lVTG40WWFQR0F5OTFNNTI3?=
 =?utf-8?B?V3hSUDJkaGs3N2JUY214dFF6aWZuZGRzSW8zc0lzMzVEOTdRK0J6ZU1KL3Q4?=
 =?utf-8?B?N0dkcFB5U0N0d2VwRDVRQmMxL3R1d0hDWXlSejF5VXdmbEVLRnhvamI3b0JB?=
 =?utf-8?B?QXBJY3BBU2hvbTFpYXJIRlF4UE5uOExEMmplUnoyaTVNcGQyOTBCZkdtYm1m?=
 =?utf-8?B?N2tzSFVtT0hlZEVpbzVQbzQ1VzVUN25ZSlpFMHhMaG5IdjNBWEJZMEUzaVNq?=
 =?utf-8?B?L0ZCd3BBOTNpK3ZPTytPT0V3Q2RoRVRSSnhka1VtM1psMFE5b1lhVExOQ20z?=
 =?utf-8?B?VHB0MFVSem14TXBPdk1yc1h2cHU3LzhSQXhHdnpCTGJhVVBBU2pxZzArRFBF?=
 =?utf-8?B?TjkxN1hlK3VaQ082UFU4djVOUHNvMGlYREwzajJYL0gvYjROekhlLzlpS1ds?=
 =?utf-8?B?Nk1LOU9MT294dGlzVjVKVEx1V3lXU1NHbmtLUmY2U0Q4UFZ0dzRoa0lmMFpC?=
 =?utf-8?B?cjQvbW9OWlBJbTNZK3JSZlg5ZCtZZlE1NDZ2c0FiT2hIY0QxVFdLVEMxSlVy?=
 =?utf-8?B?N3hyRDlCMTNGajZkMUM5b0ovTzNYR042a21wRkNtQUJxaTUxQVVJamNuTktK?=
 =?utf-8?B?alJUT1huY2xYV3I4WE11RUp2Q0ZDU0d6Wlg1d1B4L1hkVjdzVm9GVjBMSnJC?=
 =?utf-8?B?QUxONTVTY2dFT0FiRkM2UkROZmtGTXpiYy9Lc1JiaEZhK1djK1RrM3RDbFVY?=
 =?utf-8?B?NmpEb1NVeFQ0YnRURHRmU0pWOVNJUFNxZ015b0JMMk1HMjlHajkxa3luQXhX?=
 =?utf-8?B?dEk0TVdsUXF2NTRFT1hIOVdmeGZtc21ySURSdEk3c2EzN2pycFJSL2R4SVZ6?=
 =?utf-8?B?ZU9ZTGlRMEJHbEd0cUZnQUtTOW50bUhZS1V1dDFGSFFEZzNsaTlSenZpdnE1?=
 =?utf-8?B?cUNOMFpDUHJpUkNEd0dhUm9WWXlGdXhWRTBoTHRnTHdzN0FoTEtaL2wrUTNu?=
 =?utf-8?B?OGxYaW1VZG90RVZMYkhFVC9lc0tRZzFRcUFjbVQ4N1dTdUFvWEoyNnRIanJD?=
 =?utf-8?B?VCt3TDNseWlqcWpWM0hYZEdqKytHS2VaVlRycHlHeExHaVd6KzFvZ2FmZWZN?=
 =?utf-8?B?bDZ5em80R0Q2OVJKYWFTbGNDQUMyOGJ5Zy9WMys0SmdsYnFxdVFLT05taXN0?=
 =?utf-8?B?cnRJbUVXWDQ0WEV1aTVVNXJEMzgyZTZKTHBjb0hJRmlsZm41eGdzL3MvdkxR?=
 =?utf-8?B?U3hQZGFvdkVsKzZBRHdudG9YbElaZ0pEU2ZxVktyL2s4OFBjUjF2UkYweGM3?=
 =?utf-8?B?bTA5aUV4ckt4cFRWdDIwYzl1aHg1ZklDS1poc0VBQm43bldxMERpVjhndldY?=
 =?utf-8?B?aXlkNGlIM05WTlNjR2hmTFNPS3F6YmR4VXNQOW1xN3dpVVUxYkhQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15FDC2DFF79C04EBCF6EF7A4E7E89CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b417f5-f3eb-4831-992b-08df4b47880b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:57:50.7044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mndfYND7BExEUH+ERptOCCP+dEBQt9EDB2c9nPrr5OlUkcNu9zZBuNP9mGU6o6SmEMhLvJnw4SVknzeUjcrO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTozNSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBQYXNzIHRo
ZSBJL08gcHJpb3JpdHkgb2YgdGhlIGJpbyBvciByZXF1ZXN0IGRvd24gdG8gdGhlIHJlY29yZGlu
Zw0KPiBmdW5jdGlvbnMgYW5kIHN0b3JlIGl0IGluIHN0cnVjdCBibGtfaW9fdHJhY2UyLiBFdmVu
dHMgd2l0aG91dCBhIGJpbyBvcg0KPiByZXF1ZXN0IChwbHVnLCB1bnBsdWcgYW5kIHRoZSB6b25l
IHdyaXRlIHBsdWcgZXZlbnRzKSBwYXNzIC0xLCBzbyB0aGF0DQo+IHRoZXkgY2FuIGxhdGVyIGJl
IHRvbGQgYXBhcnQgZnJvbSByZXF1ZXN0cyB3aXRoIGFuIEkvTyBwcmlvcml0eSBvZiAwLg0KPg0K
PiBObyB1c2VyIHZpc2libGUgY2hhbmdlIHlldCwgYXMgX19CTEtfVEFfSU9QUklPIGlzIG5vdCBz
ZXQgb24gYW55IGV2ZW50Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
