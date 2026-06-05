Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EB27A462;
	Fri,  5 Jun 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679764; cv=fail; b=daoFUdeoiCyGdqvXLY2jvtskb8WmfwWYnA8wL8/mHCqUeaUjRLwh/BbDIx3BrHQxwRuJ8Uox3yVyvq6XGVFJOWBa8QtU/2T75yP3706iwxFt6xP6i2tBdJ1UAHOwvOjA88laA8nTRd3OJWrtAhDkxsr7dYUHlb+tObMnHjI7QaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679764; c=relaxed/simple;
	bh=D4wPq3nPgZQzcUSDKv1rLHwwyxfV0lMzwAwj0eiVIKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLpuSDrHXTjyRR8m4wPAOwTdj8tQrCNr1XAdbhORnD9c+XdILTBqzigDBRmYejOA7WNhK2WUQ8Ry2CCQSr2b+a49lSMCZbHt4Mq5w8HtDCgHpz7LiXkEp2czsAJphDvAEFBzfm8X+64ddtjWwFd+H52VLNlUgxy/vUSqjgbltFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+RM+e8Q; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+RM+e8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9OoxqKsByFWu8P5LeE/iVK9tb+uT/w6yUAz18yEotNZCo4biORKQLVi/FFywwbCeZ968E3lwHVrretNsW8X8rByNSemMF2xqQeZGHtpHkZFvDzNO1rQJno/D24iX350co5Tm3Q4FVuLRdhpiO0gEyO7x/96QXybctTsYBhxYOCr3U7OJ0+9wcEkE8gMIIUs0xtQeQvldOUMi+KRLQA3SZWPM30gsbJeU80rp+IwWud4BACqlrb2OXXsW2PmuZPWZXt0Z6VFbr5kvkp1x6bOjuN4tLzDaozhNc/l7MInuK8TCgAgCeY0y90hMG5RtgZFAP/iSPC4Jl/2CqTzAH3Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4wPq3nPgZQzcUSDKv1rLHwwyxfV0lMzwAwj0eiVIKY=;
 b=HYbE41JGFsvKEVuZ1+LzKGYittX1LXZfpcHFsA4xx5TQWR98qsFJt8pPacHQ5dxb4FmgVjb8PR9hgbPecw3C7PQ44wZ4q8CxKA1p50jT2XvtgAIiNx7pHDsj1lJEFzoYdhzLEWfOLqvhocPXko+ohedxwZ4WFZnhTWlc2zKbIMQKLYavHobawEISSP1GyQ+OVg+nzAq1lpHYwTL7BwmKOHV1DVeUicW8ELRAXXtprutNrnJtE/dBnG1ahhZcSqWJMYPFXC/5AFrjlH0KMupegrPz99rskUEvVot3qtywuHEyuQJxtacKLUbgqVjeCmo7QZdggK5OLwUFwBvTsas/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4wPq3nPgZQzcUSDKv1rLHwwyxfV0lMzwAwj0eiVIKY=;
 b=I+RM+e8QWO/zxMaqQjVNsY26gnoD98j8NHK1ifyoL/jPkHUMKV4+zl9rbsjpxOKObuxBAbEq4qUbku3iZOPEE0L0A0cSZ5FpzcaznUcS2YcBF5v91hd21eSbJj1mGLsKrwVn/sU3YdrsrTmVaWKb/N2QSGhSj8uWZJ4RYviE4qcrE+PRAX7VDCO8iDJ8G1xbyuMksaGWEBapZsofSDwfIz9L1eOd7SsizJy6AGv34N5yar6CB8JT+Ho7SC1JmlO+SeW9ztNXm0yNmy9XInbWV5xxOsT1Q8wkaBLVYalCWYthZlhPa/mpFphC7xhbMcQnQgPjxev5e3zenqPbEg7sUQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DSWPR12MB999176.namprd12.prod.outlook.com (2603:10b6:8:36f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 17:15:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:15:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Damien Le Moal
	<dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
Thread-Topic: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
Thread-Index: AQHc9BDU34Ig5FQSHkSIW6VfP2WjtbYwNcmA
Date: Fri, 5 Jun 2026 17:15:51 +0000
Message-ID: <ba96b67f-3d7f-4839-8292-733a5eb43d46@nvidia.com>
References: <20260604105347.168322-1-marco.crivellari@suse.com>
In-Reply-To: <20260604105347.168322-1-marco.crivellari@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DSWPR12MB999176:EE_
x-ms-office365-filtering-correlation-id: 143c190d-a76c-4cb1-cd1d-08dec3261842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|56012099006|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 X4hda1j/iRRmkqHPYLhtd8LvYureH4R391XxRAUH3Wh2nK/wFhT/10FNGL3GGKV9y06zC0TN17XYdMsrgpTIrSNMI8n4/oaTWZB24iLIvCj9FC7l2Du8eihlSI7koXxg7epJu+sV2uqXzofO+gcMf73syVIHZRbGwDW/O06+8sdG5ooFnjOG1J1Dd0OHPgznnb96YYRMbU7XIWbRhqAFv0UtDG8u0pYlbwjJu5IwyOtSz1IaT0AGFUTzDUxL8nyTKk2YZ9tAS2Jq7QpEShK7zruHGXCgSUHSvWfrfo7M40OQEzfB3lh3514ZB/xfgWVi70xU2QbHUhNQCgVMw4ll8mkHGCH3b9JefPYRwYbpwyfaz+tKisX4IrLVWFIuGljyahcLnl4UPaeMSICQhinMPcZk83gyPa6x6FOKkQ11CpUPFuZH0HrMst8rxA7JI3sA9jODpYJcrJmy7j0J6SftZkUZZ2bR+TwHIMClH4dU37Z/FUtNQgozDVUKI9eu2KEhqac7NXIvGacfwDrzEzJktcjdXPpfrXhZex+0uKVVi1jOFzr0DKBm9QCWOQ9h9EIYCRDzdLb5roSXC4a1K6W+yBC4M63BsCKQyez19uItggjEbevXlT49po8Y01mbDy/z6xzIeL5HZ3aTJxAL3YBJ7M6yQN68d6Bgov8tmdqfcDC4oqhzYYRWHg/qNYZbnY3jWu5g28dhWSz4KxkgzgYJtysW/1we9hjmLOoRMOIKOUkNFFQlX7xQzqmdbHXSZPTZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3N6dmtSWUhSN01xTjNOL3FIZ0FyaHhzWkxvbUtMeDJXenRKQWVwUlBFTE50?=
 =?utf-8?B?RjRKRXBOUTFrSS95SmpXNTgxN090bmVJOWt0WVZOZ3ltcWFteldrOU9zb2Zh?=
 =?utf-8?B?Y0hSYnZKRUROZnRMQTZwVGFJL2VaeFM4ZHNTWTA0TGgzbnYzS1EvODU4Mlhh?=
 =?utf-8?B?Z24vcnlGcWQ5bGpRS0w1ejRLdU9rQzd5c2ROeXE3bHdSdHZMY2h3NGFBOHRX?=
 =?utf-8?B?M2ZSTU5Ha09PQjFkSm52VUlHU1FEY2FEdm1PL1N3aEdsTmxBZ1k1Qk5ic2VD?=
 =?utf-8?B?d0N1RThQYXVJK2Z2WjFSR1o0UnRRSXpFLzdWUmpQV213RzFvSHdBbUpyczh6?=
 =?utf-8?B?Qys4Qk96Zlp1bWQvSWMvTFd6WFcrU3JyaFNxa09LRjNjTUhXZENmWnkzRmRw?=
 =?utf-8?B?aUJCRFhYUTI0czBKUXF6N1NSVExxbWNmWjZwUWZ2ZmVRZnA1MmdPVk9obG5u?=
 =?utf-8?B?SjZZcitkTWlhMmQ2eVl4V3BwN2tjMExnTElhSVYrdHhuWkpaZUdvb0NKNzRI?=
 =?utf-8?B?VEVUbDR1c21vKzBNV2k4KzNpNlNrM05jN0NTbGNXbEpNS1lFTlVnQWFpRWpM?=
 =?utf-8?B?VEJNTnlES1lUaXplRWxOeTFOd0xTRUpoaWhnbGROUzRPMHUvUzQ0UkNyZHZS?=
 =?utf-8?B?Z1lSWTRoWmo4K1c5M05GMXRjSkZKWWJaRjJPTG9MemZZWUV4cTh4MkNDK0NU?=
 =?utf-8?B?N0VGdXhnSFdaelNySGZWbC91ZmcyM1BZUXY2TVNSRG4xTURKYytlTXNYZGRV?=
 =?utf-8?B?RHFadS9IR2JiaEZrVGJjRThlTlhNQThhNDEwU0VhSmFzampIb005dXVPV0dx?=
 =?utf-8?B?c1MvQ2hIcklJZ1Q5dGEzME1xNHNEUms2cWlVdjlPZzRWMDBsZUhTY2VkWlBq?=
 =?utf-8?B?bnhkVkVEL1Z0VG1hR2REd2dLS2QvQzBrWmZQbmM4TmhMQ0ZBN0puUVMvRVlq?=
 =?utf-8?B?MWNGVitTaWs2WXdESEF5S1JpUUFEdmVYR2hFbHNYMHFGdXFDU1VOVlVVVzFV?=
 =?utf-8?B?Y3NOU3hnSmpiYU54SW8yZ3NEeUlhTUJpWTVEMUprS3RKU1BVTVI0cVZmeDlv?=
 =?utf-8?B?WjBrd0owWnYvUmNZMmN5UUNCaGkrS1JPUDlxd1JGZFNkayt2eUR1bklEZm90?=
 =?utf-8?B?d0plOUcwR01zNFJFNXBPd1N2SmtydmtFYkxsMmlhb3pFYUs1M0VXekFVdFlJ?=
 =?utf-8?B?cHlNdElVekw5WWNYazZjUlJCZktuTEZCNlJvLzc0MFEzd1Q1NXF6dmZxT1pE?=
 =?utf-8?B?Z3dBRGtOZEt3UHlicUdBMTk4T1J5TzdFQ0xJUkxPNmhjZ0Q0Y2oyT1dFVGI5?=
 =?utf-8?B?akMzZ0k2ZVhORVgvS1RUUFhSWmxPcVVFVWJucVdYb0E4R3ZDSHdZZGdHT2VR?=
 =?utf-8?B?ekNoSXB6YUZDemQ0VUxMUzZnTlRaWERBRmEvQkpQeWRzMURDNldHbkhYTHJp?=
 =?utf-8?B?SndGUkU5M1gvSXhzUUIzWVhSWFVFK0RYTm5XUjIzQzlkY1JRMkhza0hTbDEz?=
 =?utf-8?B?QlJmRTRjOVluYlVHYVJsUmp6NUMxYjcyLzg3anR4emMyY05UWExhMXhteTRO?=
 =?utf-8?B?T1J2ZzhqL0M3dVJJdEJ1aW5IVTRoQUdRZDF3UHdCK2M3RVZqZjdIeDRGTndq?=
 =?utf-8?B?OHhjODRyZ1FkYk9uY1NMY2M1VnVrNmg1WDJDSEVnN1BIdkdodGg3VUFqL3hK?=
 =?utf-8?B?Q2xIcVcwRXJBM05tRlN0SkpTcXR0Y1h4a1QxcmFzblJpa2oxRjVFT0xETUVy?=
 =?utf-8?B?aHVJK3RoaFpjbU1oSnVuUkxCd09WUDdJMG81clc1bXNNMUE3OHFLNDAwdjJF?=
 =?utf-8?B?THlmcjlOOFlSaWpZTzc1NlRWb3ZRZ2pXektRZHM3eUpIV2t3UjhVV1R5SUVP?=
 =?utf-8?B?OHc5RkErNWFxSGdRdEtNUFZGZGxGeHhWeThMQXRuQThmY3dYMU5VUnZDdU1E?=
 =?utf-8?B?eVdoZkZqdnpWeE5ITVR5dlljbDh2cHBwbis4dlQvUUg3KzQ0eFNUbmZHQ0Zo?=
 =?utf-8?B?ZjN5UkE4cDVTcXlSYU5sQUYybHlVM3NleDB4d3NsQVJWWlN2bnYyV2VJaUcz?=
 =?utf-8?B?OEhiS0NsTWt2Z1NuOEM4KzFzdUlpZGZ1MitoL1cxckpUbHBxZkNYbFROYUo4?=
 =?utf-8?B?MzBBUTJwV1FLWFpKNU9QeEZ5bEtBRlovNUZpL0JLQkE5a3NZczVmKzVMU0sr?=
 =?utf-8?B?K0pBQlc0ODhtV2lMQUxWV0pBR3ptVnhoa2QvZVlnUDNhZHFVUUtrKzBpREs5?=
 =?utf-8?B?bjVnRnNXellzcFUva01aL2FNdHVqbEpHTFI2Z2xDcXNqMWN2SCtQaFVHN3py?=
 =?utf-8?B?enJaR3BUdU15ZFdXNDNrQWxsZHoydGZpK3JKNDlYTjNLWjVRR0RzbnlUcVZq?=
 =?utf-8?Q?nIp/y9FdQ6Gujr7XFuRfjT82dm4D6WjnhkYb6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD5839C87EA22F489B1ABB1C263BF88F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c190d-a76c-4cb1-cd1d-08dec3261842
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:15:51.6170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIM7KFgplYdFoZewkIScEIJr5qMQAua8L4Dk2Qv/Xo7uZwfy2KxZOjKPnikj+oa6v5X22Q1Tliupf6lLUi3AWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999176

T24gNi80LzI2IDAzOjUzLCBNYXJjbyBDcml2ZWxsYXJpIHdyb3RlOg0KPiBUaGlzIGNvbnRpbnVl
cyB0aGUgZWZmb3J0IHRvIHJlZmFjdG9yIHdvcmtxdWV1ZSBBUElzLCB3aGljaCBiZWdhbiB3aXRo
DQo+IHRoZSBpbnRyb2R1Y3Rpb24gb2YgbmV3IHdvcmtxdWV1ZXMgYW5kIGEgbmV3IGFsbG9jX3dv
cmtxdWV1ZSBmbGFnIGluOg0KPg0KPiAgICAgY29tbWl0IDEyOGVhOWY2Y2NmYiAoIndvcmtxdWV1
ZTogQWRkIHN5c3RlbV9wZXJjcHVfd3EgYW5kIHN5c3RlbV9kZmxfd3EiKQ0KPiAgICAgY29tbWl0
IDkzMGMyZWE1NjZhZiAoIndvcmtxdWV1ZTogQWRkIG5ldyBXUV9QRVJDUFUgZmxhZyIpDQo+DQo+
IFRoZSByZWZhY3RvcmluZyBpcyBnb2luZyB0byBhbHRlciB0aGUgZGVmYXVsdCBiZWhhdmlvciBv
Zg0KPiBhbGxvY193b3JrcXVldWUoKSB0byBiZSB1bmJvdW5kIGJ5IGRlZmF1bHQuDQo+DQo+IFdp
dGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgV1FfUEVSQ1BVIGZsYWcgKGVxdWl2YWxlbnQgdG8g
IVdRX1VOQk9VTkQpLA0KPiBhbnkgYWxsb2Nfd29ya3F1ZXVlKCkgY2FsbGVyIHRoYXQgZG9lc27i
gJl0IGV4cGxpY2l0bHkgc3BlY2lmeSBXUV9VTkJPVU5EDQo+IG11c3Qgbm93IHVzZSBXUV9QRVJD
UFUuIEZvciBtb3JlIGRldGFpbHMgc2VlIHRoZSBMaW5rIHRhZyBiZWxvdy4NCj4NCj4gSW4gb3Jk
ZXIgdG8ga2VlcCBhbGxvY193b3JrcXVldWUoKSBiZWhhdmlvciBpZGVudGljYWwsIGV4cGxpY2l0
bHkgcmVxdWVzdA0KPiBXUV9QRVJDUFUuDQo+DQo+IExpbms6aHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjUwMjIxMTEyMDAzLjFkU3VvR3ljQGxpbnV0cm9uaXguZGUvDQo+IFN1Z2dlc3Rl
ZC1ieTogVGVqdW4gSGVvPHRqQGtlcm5lbC5vcmc+DQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNv
IENyaXZlbGxhcmk8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4NCg0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
