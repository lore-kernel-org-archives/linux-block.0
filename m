Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DD38E5D7
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815212; cv=fail; b=LIHqhnEyHWlnh8uzmwbU1tZOSmOoxTIKYgpw2yE5LT4Y+coQMMA8A8t0WCsRHnLVbNqwX6UXx9x8FKuk7MXCXLM4QtxeyCXKs+rPBgk1N1yO7fer353e8W61rbVZCkWr3r+LnThi6XLSISL4j3KPePEHDzx9VwWFVp2ToaAA0DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815212; c=relaxed/simple;
	bh=wPaIvC+nHlYMcmeFO6vdmn2mrCylBRsUGcRzrhlEMSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1lahUPrYamJvGZ3bb6Be2P6LpMvSMphCZhtCNHRi/5Z7IJX5ia6MfZVkKn8qm7GdTGSu6wF4Y0CQuAnGXtJhHj0p2/yi7RQvXe4IVnHs9Kexe4Hk1qRSm+kFfBIQQMmF8dvUEd6hUpA+5KPz+l1Gpq+YpKY5Ggx3WdHDKVDveU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i02tWHuo; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i02tWHuo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq6fiU/whp0gVUmf+lOM26nJEg9Fhr9LV1O/tRdlU2WiiP2lgvW4vJ79vrbSRvymBk8Gr+O1F1z4oAr2v53syPCxijBte9H1unypmA3yBi7GbF7aTXvk6AmJK3FQCDcP+dqNStHSSeCbZJ58VZ8Xhu/0yHDKX/FCpsgOZUSRDhXS8f+xP6m+NCCebhYdG03sKSfQua43v33uSSXCH4rbqm8zbhan9AyLAduzl5z/FEvuBs2sZ95CIZvsnWfCP3ct2G5WVFw5Ww7ObQWO4/DYEueXPVBifmjACqm8sJ0+ZVVpc6ij+UlL53fU5jp2cYQ9dVFvXUfFhGUWm7td8L+RMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPaIvC+nHlYMcmeFO6vdmn2mrCylBRsUGcRzrhlEMSc=;
 b=P3oJErc5SMI4sk5fQlZX1VW82YBfwiuIUPw7kJiJHpRUkZQlS99D1Zo9J1jm5mvxKC0NklClgUfqXIHbdMU/P9bSlTIhtyiV9tcm9PmcTL/bWHJvvOgszOjMj71MrT2UkSrfZkExteSij4P8UpOddpKjv7cxMcmUILhnmYgj53jL8A3eHsHakmholagRASvIjsUVcU45kJGpnNaLAMRnUHRUDKaJrwYnBBX5ZRmn7BLhqxrpuF26D9nVx2Vt6cAw+6sn0W4jgkbyxAjKaqwesXTozjrKF2P1m1BjsKFB+y+q5oB+yKrfZEKSW+UYJegjeXNcGktVchVQb2vWbHaVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPaIvC+nHlYMcmeFO6vdmn2mrCylBRsUGcRzrhlEMSc=;
 b=i02tWHuoqQRbszLTFbPyLzUU6zPx4YWPgU+DUmNRm7TOJTWnTzN4zEr2CeM+LeWulR6hCl3blL3xakQlXyXgHcefkawLcI2H/gLgYxp5XOUlxjifxa8/AZBEMrkjmKGwCEqnZZaf9xaHRTCaR8muxhY01hHr5cwvpmMSGrF6OKyk4D+2AlYw1SKPvQ83vPh+LObKXT4zBdQiu6qD/GThl9yRrYXIUqD1ka77jT8Jm6zUfqbShtK2T1zdaBZlFE0eDknHr2o689Zq97dqLiIBUblMOaMwLjpxAFd3SaPSe6Oidy2J/EcM6Lb4xH/6ceAqWdo121k+jyYIkUv8DTz+rQ==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 17:06:42 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 17:06:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] blk-mq: reinsert cached request to the list
Thread-Topic: [PATCHv2] blk-mq: reinsert cached request to the list
Thread-Index: AQHc7Sx4UzOR19/6hkelhMkPLTOUn7YgibGA
Date: Tue, 26 May 2026 17:06:42 +0000
Message-ID: <934e3e3e-7759-4430-809b-3d4a2619064d@nvidia.com>
References: <20260526153531.2365935-1-kbusch@meta.com>
In-Reply-To: <20260526153531.2365935-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|SN7PR12MB6862:EE_
x-ms-office365-filtering-correlation-id: 3d7493bd-2622-480c-b16c-08debb492897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 g+sX8w8XBwylvfWlz3BzZiA5jniCUVgqNFldWMicPaP5VfhMXqBmd1rZiYa4GuYk8zQFOH6WOrXngMjYke5IC1n9v/yiWuPx9BiAMw/XQSeS1PWKieVsiN8CmXmdQgnE7qBK5cP2zym/8VZn314mB7Ju0p0Fcm/oye6XsFLHNACxGVvDTxdJjpmIG1+NXvnvo1VNEPlGCC0LBzLcZjVebT5rTuOKqqosFVD5Q8gLZuvkfoWa4RdQy5eqTTDCaELEFHEUWLZidaq5dBJFblipZS3EWBCFDUvj0c2AMiTuGHMBRJutjO0OZlIb8Yl8nI2HLu2pdDPbaUdT6WWCdgjwJQ8nubP9p1uD/BoYvHznyOmYxy25Aha++Gk2k6jQUfaoMd3J5QRseWbOe+vgt/KbdTma3+gH8eXyQLTgVvZODxc9T6T/4zBw+uVrcYpFcqnzj9pRaLUZpdMXaVciVoO+0QosqVguzjGQjtVP7zle4DQY7MJPRAQ6zbS++36lZgVKxcX6nk8nUYDkrOUnIVIGLWKH6FO/+GfkL/8FyVIbcFgZGHDINHRydyVg3JbR63jkgyjY6blW3AmC8KAuOvpOihch6ADjpsYdpYdUJwRBsIwxPrRj6J+SuuBkqPdDz/HIAGdCVRm0EwBGyvZsyu1esFsjjpehKWiXpqmQCpXmcR8lJOqwzvvtbd3ZZkR/Z29bo/XFR0giJqBE6gvMv7Lmg/uLgDkYY0pjFWiGXvB4kzUGL2XotaVCgtM93MqtfsnT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzJIVnBFRmdYQnMrWnl1dDMwYjZRZVRIcDBCOXdFU015dGFuY0RWMVV1WFV0?=
 =?utf-8?B?K0xEWkhVdzhaTThTZk9BRzZVNGovL1FNQ0JFYnpwSTVKZWFTNXlraWc2SEtK?=
 =?utf-8?B?ZTZXYXUreHpsYkRmYzdWckIvT0JOeGRxZVZkbnpiRjBYK25YZUFJejdFMVVx?=
 =?utf-8?B?SUVKSE1QR1ZSU0NuRk8rU0lteEVEWjJlT2l5SE1PNUhQN3hkSTh2Q2hkYkln?=
 =?utf-8?B?cmVyc04yZXhCcGhzaTAxOEtnNisxODh5Q21RUU5tS2hsN1NNaGdvNzQwQWtV?=
 =?utf-8?B?UWxOM1VhLzZvR0kvWnhQdGlyRGMySVV2cEl4NUl3ZGpZV3Y5K2lkRXhGbmNK?=
 =?utf-8?B?UHVIQWZ4MXFuQlNQOGw3MGIxc2M2dkxVTVZkNUJYQ2x1R0Q3RWdkRC9HOXFK?=
 =?utf-8?B?TFlrVFZyblVwVHpIcGZWM1FSVUYxR1BUN2xSM0Y1VDNVRkhSejZaVVA2Tlk3?=
 =?utf-8?B?RzM3Rmw3SklMWkVyd2E2MCsxRElmUmVLZzF6RE90c2lMRGFockdYWXdUck1i?=
 =?utf-8?B?cVVBNU5BV09MaWVOMXp6YWJKME4vUnF2bVJjM1lGKzNtN1I4ZDRrTkVMV1Vr?=
 =?utf-8?B?S3dGZ0FqT0ptZHQ3MHhpMkRkUUtobWVLYTlRNWs5bXNaelpVRFp1K1pmYWRB?=
 =?utf-8?B?U1pjUkVXbTY1L0picjJNbi9HdE54ekpmdXYvNkY5ZzFnalBFYXFiOU0rdWo0?=
 =?utf-8?B?MjVJZHNPYlZ0RW5sMVpsMjU5N0JXVDdZd0prTFZKK3d5WVZ6bnZHUXhtZnhr?=
 =?utf-8?B?bkxGNzdsbTBpNVZhQmxSSVZEbTg0eWkxaHNWVXN0amVwL1ZDVUtyRExSM1hw?=
 =?utf-8?B?UWI4RWdrOTdBckJtVXlYNlF6Q0VXV1h0bE9ZV05TMHJTMm90RG5WZ1N4OFZB?=
 =?utf-8?B?TXhHZ2JsaGh3MFdzd2R3YnhhamZ4SE5SMzdFWlVBSnpOWFZFQ3RrTjlIbXl2?=
 =?utf-8?B?U2w3S3FVdE53UUt1eEo3YUdINmpyb1lGc1YwRngya2hoSWNNODJDbTZ0VWxW?=
 =?utf-8?B?eDNoTEdFUUxia2t2c3l6U1FrTjhLVExqWm84TFppMnZDVHk2MTVBWnYvUkxz?=
 =?utf-8?B?OGYrZjhGWWkvd2U3WVZFVVhaOEh0YnEwNzZhNngxaFo0UkxxL2hNQUVHRlBS?=
 =?utf-8?B?czR0RFFaZ09TK3VpcUVJQ0tPcGtDVkdrZjVWU3VTQTVuR3pUVUY1M1JNeU51?=
 =?utf-8?B?UWFRU3ZRZ0diOFUybmRwOEFmTGZnMU5HK1RHNDhFL1dqQ0VCbCt4TEZ3NTQ2?=
 =?utf-8?B?NFVpekRJWUgrek0wcERPSko2QUhxM2IvRitHUTlLdEF3ZHZIV3ZCSy9QRFFB?=
 =?utf-8?B?T2w1cFV5Wk5aTlloR0ZCNTBvQ1YyVlFkbSt2MlJaVC9OL3FBcTZnVkoxWnk1?=
 =?utf-8?B?Vll1NVVtc3B5amhaTE5nd2xwZVdic0kyMjBOYmdYZGZWN2wwOEZpMHNvSGRT?=
 =?utf-8?B?M2ZPUjV2MDIwZmUwTjlEb0E5RFdrU1hjclBkeEthK1lMZHpidVBOYXA2Z3JL?=
 =?utf-8?B?R1cxVGhPLzVDSmNBTW1PcVI4S1l4U1l6ZXR4UkJhcTNKaFFvanVkYXdJdGFD?=
 =?utf-8?B?YVAyRjVhdkJjazYxTW5nTUNZR3lIZzkxQ2tLZUJodXM0NEZzb3cvSWdLZjE4?=
 =?utf-8?B?S3BYeEtQKzJiL1JGQXNIVmsvOUdaWHdRUHBPM25FMVBZMTlYM251R1hVK004?=
 =?utf-8?B?NXR4L2xVV01HNFNwMGRsYTF5UlRiSDBQL2ZsTFpWcEZBVTc5VFZRRVBYbFhJ?=
 =?utf-8?B?bkY4NXZQU3ZZMHNlb29qMTlPcnJ2dVBKT0FtdTk3dWpnNHFrUzNMNVhoNFZk?=
 =?utf-8?B?TWtjVWFFTUhzRnFrQmNLcWwxVVVUNUEwdmFkSlBVejQwZSt0YUVEbGJuWjhy?=
 =?utf-8?B?UlB5S1U1ZEl2Q0VqaENlcFlYazRvRUNFekIydEJXNm1UYldOOWk1R2ZNcHdw?=
 =?utf-8?B?QXQveXlGNzBMMEN6ZUVZakY2c0ZveDJqMzdlSmZ5QlBaZTBwYTdZMnRCZDY0?=
 =?utf-8?B?NitsdkZwZFAzd2MwUmVVYzUreG8zQW95NDQ2N2Z5Q2c3ZlQ1WUZFZmducGFI?=
 =?utf-8?B?RXZpUnJpUnB0eENoTTFMVnhRbUM2bnpwWmdEVUpLemZrWC95clJaZUJyZHNq?=
 =?utf-8?B?WWVROTJPRW1zd2VXUXpBdWZGNDRoWHVxRjkxNjc1VXFoSEtqYkNJY2hlVnAw?=
 =?utf-8?B?dlpvdDQ1VVg4Ykc5NzVpT2g2YStGYlhRbWVKMDh5WGNTQ0VFbHVKL2tNVm5h?=
 =?utf-8?B?bW9uRzdhVFJ4T080c25PZURlbUw5ZVZSMzQzejZ3dnJmU3FmRit1eUhOVWhv?=
 =?utf-8?B?RzRMaTRrWVo1bkdzUGNER29id3dHOUZVd2lLaVl3UjQyQ3RXSm9TeGNyNmFD?=
 =?utf-8?Q?ZOzpqu2+lxmBZNB8F/hwIyuR8bY8Ygefl/X8Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC2225EB4AB40E4ABC541AE6DBE1C46B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7493bd-2622-480c-b16c-08debb492897
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 17:06:42.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Br0Q6Pe8x6T0SbTjQlzRmYzFdk3ikERtHznhKwxx3pwk3q7cMc619nH0vSMAsMKa6LigNxlHjIZD9KyweXFd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

T24gNS8yNi8yNiAwODozNSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBBIHByZXZpb3VzIGNvbW1pdCByZW1vdmVkIGFuIG9w
dGltaXphdGlvbiBvdXQgb2YgY2F1dGlvbiBmb3IgYSBzY2VuYXJpbw0KPiB0aGF0IHR1cm5zIG91
dCBub3QgdG8gYmUgcmVhbDogYWxsIHRoZSAicXVldWVfZXhpdCIgZ290bydzIGFyZSBzYWZlIHRv
DQo+IHJlaW5zZXJ0IHRoZSByZXF1ZXN0IGludG8gdGhlIGNhY2hlZF9ycSdzIHBsdWcgbGlzdCBh
cyB0aGV5IGFyZSBlaXRoZXINCj4gZnJvbSBhIG5vbi1ibG9ja2luZyBwYXRoLCBvciBhIHN1Y2Nl
c3NmdWwgbWVyZ2UgdGhhdCBhbHJlYWR5IGhvbGRzIHRoZQ0KPiBxdWV1ZSByZWZlcmVuY2UuIFRo
aXMgb3B0aW1pemF0aW9uIGlzIG1vc3QgbmVlZGVkIGZvciBzbWFsbCBzZXF1ZW50aWFsDQo+IHdv
cmtsb2FkcyB0aGF0IHN1Y2Nlc3NmdWxseSBtZXJnZSBpbnRvIGxhcmdlciByZXF1ZXN0cy4NCj4N
Cj4gRml4ZXM6IGRjMjc4ZTliZjJiOSAoImJsay1tcTogcG9wIGNhY2hlZCByZXF1ZXN0IGlmIGl0
IGlzIHVzYWJsZSIpDQo+IFN1Z2dlc3RlZC1ieTogTWluZyBMZWk8dG9tLmxlaW1pbmdAZ21haWwu
Y29tPg0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQo+IFNp
Z25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K
