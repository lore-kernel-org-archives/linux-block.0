Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944713;
	b=USLPjnHhVxHzf/k5iUnPB8Q1sBlVt7rcN0TjLCptlKzqFqOQTIax7CrjJ09czUNjCCg7
	 eUn1d24WTxalTmBDGCWJGnv9CgDjvGC//wFGmY1sqCYDy3lpenzCb1NCgdM1/ybRMGrl6
	 GrDO8DAYdnTv8PFI/XHdsUxnZtQTAMVYxm8mZZBtiGGOwpZ+/H9EUkHAPJBMVN/OrGSPl
	 lyEb/MI4z47l1aE/wiRc6WliI1MowRIRhefZqOEf6K6tyZu667za1ovZ4054TMJ/oRF3J
	 IgJh0t6Qxs7qMg3jDOlBTL9q1yOgximUfZu+y/QOEImZWe1gnBhyz17EbmMhohRaVrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944713;
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
	bh=PincF1SrPGjPSwKXt0Ac23FGIl1vV6TbAiNjECgDvi0=;
	b=K7rLw1+rG+W4wDKD4tarNtevNU/g+Pw5WTeLPJExVnva0uQiA/ZpmtWdnTMl8uV6Ew26
	 vvqoBy0njH/mDvNV56dbFCWRUP9OY99BJNMsih5CKjE0WHrzmsbHuPh6ZfYNd6awsHw96
	 qc+YiW45Lvh7VsLSDxbHM9AJrSrwzUNdlKRm1x7nnBQ/+Ur0SLATYJkDTNTr8AdeLgxlM
	 u3t5HBO1ZHTHbYqU+5ztnhkMwPcqRstzkkmffOq6reRjRLLGVnPuS5ZatLUfj6j5oq4nJ
	 vemgmws05Abv0iis1V4MlhRKeH6J+daKXACdqISJO+B94q38yCuUFvQuKqADpjj2xlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Aa8GBaIW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.67
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C7606A32F
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 19:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98C7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Aa8GBaIW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nhc9wqv6+8A7onvhEG4kM53661CYVDZWur0m7b7kqeyocsUlZEPkmj0bODSgl2Cu/Rqjp0pkZbR9H/IsHHjJMSrxheRR1e9fripcttxaHOejlqil1In9AeP1ndNJs0+wDSSOJbAk8gVr8oP2DIlsCH+bl9QXUISgc7OfYO8mVaQ1LC9+3iy4Mvga8C1XUSW/MXqI/trjgRlgXrE0x5QrXB70DakfxZbeH9eGq032taaAZy36J0YHq1CvAm6IglFoHoyDJiVqlyDqcoT7CelcNcbuGrg7N39Pzz1SbaWW0HjfbXEZ5OJyPXox2ys6S1xe2xvZAFuQ/WxdLtlbSsECGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PincF1SrPGjPSwKXt0Ac23FGIl1vV6TbAiNjECgDvi0=;
 b=e2SzXgHLHAzB8R3M950kuECjcdgEZR2gJ3ywodVUpVruEbM2V0UhTl78D3uIasE8NitT+8ZVe63T7G4aSjp9QUmuD34hjGtC1GM34paLi8O29CA4QyozlRZDnyTD1Qq7paNHSNMhZwGybUWFR/QFIKrxlg8ttHq9SozinO0BomvXYYOmSt23iNp2L3hsNlXA+JaLBsgjBjWU3At22zw8n8xDy6ES0vaYcx/mg5BK+Ycfi8zF12L9ERyQe1NutGQdApBnxA5+sniPjVke4A3mjvpS+XJ/OaQ7222G9zaZ2iUC9LxebfzlO6YJ5WM0DuXUd5Mc45XrMxjNB2npFUNjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PincF1SrPGjPSwKXt0Ac23FGIl1vV6TbAiNjECgDvi0=;
 b=Aa8GBaIWciS84QGAgNruiqG6ahbmnhetgTViB1ufiIKpydvzH49sRaTEaY6AXm8DFjq8MS+IIrpKG5ptnoROJwDo7gR9mii2+aX1vRS5bUbBxcb/55/v01qxQqPDXH+zwBu3pIItVdskPHXhju73UOGy/9dZqM1l/C/xqz+XWjSbgePs0kCc05WIVid5uKvzBmnj6dMekLnUNtJg+y/8WUy+mCRRvx6ZEF6+CAOEhGdeEEqH9k3psdg03ys3tihh42Rf0bq1yk76YUNKavEwqM68KMuOOYR61qaRy88jjWH60hKxJ1hCPWfkHsDeQMv25haNknAAtWuUFfd1fK6W6Q==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by LV1PR12MB891283.namprd12.prod.outlook.com (2603:10b6:408:516::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:45:07 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 19:45:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ankit Gupta <ankit6791@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
Thread-Topic: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
Thread-Index: AQHddlR5P+75y5qzKE2W9kXNcFAQNLcyq6KA
Date: Tue, 17 Nov 2026 19:45:07 +0000
Message-ID: <fe076b84-dbe7-4863-8d55-d1b385123f57@nvidia.com>
References: <20261117052741.25471-1-ankit6791@gmail.com>
In-Reply-To: <20261117052741.25471-1-ankit6791@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|LV1PR12MB891283:EE_
x-ms-office365-filtering-correlation-id: 346529b6-a227-4eb4-8859-08df44e348b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 IYCOeoeaqHU4KA3aMYfywaYGZjRiD2c4GsdLsyVnQ2/K67DLYvNaNTjcvWOmthBqkvSJhl48QDUAookLpcee/496ibWNoD2dd0nCPJF56atomo/GpfBHMiY5NOkRYSTgaoX9wlQoJo64yXTkC8auMvpmPA+RVQGxidyZb2HuUZomyXkMcnbZ0Gq7Ky4CNVuypuvXwOqpyKSlkP/Sp3JgcesVtpc4I9977d+q41w7/lngri2MncHgrO7zhskBbEOP+LWayI8lIUNjmsxKyvtKWcH/GzNKaLu33pMzXT4lVQwbcZjQgQJKJZ8RU2IN+aENGsySJJ93AmmYDEMjaWX4P7r6vqPOtCsJ/HiMvt7v6gqM4fzhoiLKxKNe/fhIksZIVKvM9PoP8k9YRuOYe4F6QlkLwlCFVRpBSR+EdjhtWs/tG/FbIuhp++/DfJ6nsUvPI6wiFFSAqo2yWBPaZzyQ5PMiDzJjbulKj2QsAHQDz/LHuEqMXBo3TowwMkqBrgY8dr/PjfKDPO4Oeu86JKp2JIwZ2GzH3C8zeT8sE+zRARS0cn1/tdpynKItuAvBHSM73liX7U9h/ltYPz9q/xcBTo1M2wmjTQ9PwYiyVj5DCI8AGJMnX8L9TPuL35W+AwvuMJr7a3zWfsQ9FpwiVQBNUX9O6mfjO6WhhqhmbL/48gyuGzNH0NzHAsoSOGugyBVzeh3IDs/wG26MZ4oUGnZCeqib/W+ZzY+Pqdob2kp0g9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RitDWmg3T2YxL0VTMXR3b29HR3dXdzNuVEF2dTl0Z3J6Sk1melc1WEtQZTFz?=
 =?utf-8?B?TmQ0Zks4RkJkaWx6Z0RRZTlxeVVBQWprRlhFOHJacjh6UEFQcTVISzVCdElW?=
 =?utf-8?B?TllQYWNiQWNYaEFxbER3dmxjWjlQMzNxTlFqWjV2L01id2FnWE1CcjY5bHV5?=
 =?utf-8?B?YnZaNllQNWZPRER1UDBmU1JTOGZ3WlBkc0pmMXA0RjkrZjVNcTYzVUlMTVJI?=
 =?utf-8?B?dnU1RVZVNDMwbmcrVXF0cTR4UjRONEV5dVJha2FaQmxtbHVrNFZzSkIzOWZI?=
 =?utf-8?B?S2JRdXdGZTV4SlRoSUVzUGhvclpjZFJKWFRYUUl6NWJVeU1McUx4Sjk2WmI4?=
 =?utf-8?B?VnZwQmE5TkxqSFhIMXgwU3dqMXBzdHh4enBqcy9HdHdXUUc1ZmZUbVZibExm?=
 =?utf-8?B?dUhncE9RS3htemJ4bDhRdVV3elAxR09OZWZyYVc1UWE4ZVZXdTdqWTN1S0Rm?=
 =?utf-8?B?N3FzM2JLalVZdGpHUS9OTTk2WDVqUHJTQWd3TXNnR25XU0RLS3owaTBQS3Zm?=
 =?utf-8?B?aHdpekNsN2pBT3hZSmtMRU1UbUdEUlQ5cEltaG1JcVZOb2RXVExnVjNkQkcy?=
 =?utf-8?B?WUY0STJ0T0MvR3Y2clZGNzlCWW4xYVNxT2RqMUcyOVdWRmhrRVA1U1FFVmxK?=
 =?utf-8?B?SW44ZC9xQng0UGVibitYUFJDcm16blN5ZFVBYlVBUDVJdzB5ZGdPWHBGMzB1?=
 =?utf-8?B?WVJwdFBiYjNHVlNPZkI1Z09IM1pma0Q3TEtHSnZ6VXd4ek9QYUNOTldRSlcx?=
 =?utf-8?B?SnFoUFgyTzB3R0wzZ0Q4S1hFa2FMYXI1TU1aV291MjR4c2VMZDNPWnF3WXBJ?=
 =?utf-8?B?anlrLzJhRW5iL21MR2hkOTF1RU0xRmFobHR1MGpMQnVOYnl5ZC9pSDZPYTZJ?=
 =?utf-8?B?b3h5TG5paGRFQmJTbURRbmtMWmNvaDdEdkZja3puRERsZFVzSnZvbFNWWnl4?=
 =?utf-8?B?R000dnhYVmt3ZTEvZlJ1TjJNQmhPOFIxaFNSTjJBNVlmdHFyWEY1T2VodCs3?=
 =?utf-8?B?cUFoWEdWNVlwcWJWSmlHRXZ5SmJ4RHYvRy9QRFI2Zm5GVnRGajVjSWhYYjVt?=
 =?utf-8?B?MW5FVTVwVHJGNGtrdzRmMEZiNjRzM0dqNDl2SVRFK3RvbzZqUUUxd1Fac2hy?=
 =?utf-8?B?OHEyZGRTcStvUGJuYUJxSTI1V1NIZVhPS2hjandzZnRaWm5ZUksycWVuT1Ay?=
 =?utf-8?B?ODA2dkgyLzZUdXpReURDWk1SUkpsMWZYVzRSZml4NkMrWno3R2tYVjYraUk2?=
 =?utf-8?B?N2pkTWllYlBzRE1sbmQ2YkM5aEQrVDN5VFczYm5qaUNldEhXWEZyY21tTndl?=
 =?utf-8?B?K0svNWZRRDJXZis5SHQrYmpvYWZzc0JFcVAvMUM0aTRJeVpzdi84ak5zbjNJ?=
 =?utf-8?B?Qkg5WnJuNzhSUW12VFNpTFZRak5QRG9DUEhDV1BjYnR1Y2hjdWE4UE5VMkt5?=
 =?utf-8?B?OXowMXVLTlZCWWxxempXSkNxWFMwY29JS0F5bjhsd2RJN05Yd1MyM1RqZkxQ?=
 =?utf-8?B?UHZKUXBGM2QwYng1SE1QeXdKZTdnVlNCVWk0NVdsVlJZQnp3ZFU1TmRCYlVO?=
 =?utf-8?B?UnF3REI1dnlIaWNXV0xCL0s3cFBGYzJnUGR2UTdMWEpWdVJFaTJXdmdXVW93?=
 =?utf-8?B?V1VCK2luK0xqL3drNHQ3aWkrYnhBait1VmtQNzQvRU1kWGl0TVQwSmFnQjY5?=
 =?utf-8?B?ZFZ2S3JXMTh1UE10Z3dLczAvZU91SHI3SmwvOTVrOXJMSHNSR2QwZWNWd1lG?=
 =?utf-8?B?ay9RL2hxeWhVcWtkQzVRbzA2c2tmOUJlUnNBY3BPZjVKWXFEaUhiN2VvZ2gy?=
 =?utf-8?B?YmNMZHNRUGVPaUxSY0dxejZpOVh2a1FiQzFYeXQvdm5lRHVaU25saGNOcnds?=
 =?utf-8?B?Z2ZXTDI4YnVSejNTUG5CL1Z6SThvZDBxZ3ZBNmc1SG9YVlJsUDNCeGROTXdS?=
 =?utf-8?B?ZkhwOC9pMWRtbUdQRlJ6bFIwZGM5ZmRWUUNBRUtJMitUanBFdlA0TFM3c21q?=
 =?utf-8?B?SkxhTmJOZDF3V2NXazl2bnAxMGxONnBYM3pRY0YzaXU4NzVwYnpyV3Z0eHlB?=
 =?utf-8?B?WklMVFFaQks0SnR2MFo3MktWeTlxeURUZ0dTYXowWEU3eFlmZStoTGZCejVH?=
 =?utf-8?B?ZWppR1NwMEx0MEJ1czdNckxQU2ZzdSt1bk9Kd0tnZ2VWTFVSa0sxbkxkUXVy?=
 =?utf-8?B?TUZkVnNSUzNwblB0RjIxZzlZZUs1elRLVU5LWTNuZi96ZmpnOE9LODFCcGZ4?=
 =?utf-8?B?d0lGM2N5UHB2Vk9KS3FuK1p1MXpKNzArRUFaQng1cWYvNHQyZ1lDY1FIWjk3?=
 =?utf-8?Q?A1W+ebPgwdzjHX8WMH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E58AC9629D7343A954E727A3539417@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 346529b6-a227-4eb4-8859-08df44e348b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 19:45:07.8085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOgVUSUu+HPZBn8d6jytTX6HmfSKBCt50vuF7OniYz1bP/Ee1Rt6I/FNgMO6kke7uUUuN5BEPjJOnq5Q5XQc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB891283

T24gMTEvMTYvMjYgOToyNiBQTSwgQW5raXQgR3VwdGEgd3JvdGU6DQo+IFRoZSBOVk1lIFdyaXRl
IFplcm9lcyBjb21tYW5kIGVuY29kZXMgdGhlIG51bWJlciBvZiBsb2dpY2FsIGJsb2NrcyBpbiBh
DQo+IHplcm8tYmFzZWQgMTYtYml0IGZpZWxkLiBXaGVuIHRoZSBjb250cm9sbGVyIHJlcG9ydHMg
bmVpdGhlciBNRFRTIG5vcg0KPiBXWlNMLCBhcyBudm1ldC10Y3AgZG9lcyBieSBkZWZhdWx0LCB0
aGUgaG9zdCBhZHZlcnRpc2VkIGFuIHVuYm91bmRlZA0KPiB3cml0ZSB6ZXJvZXMgbGltaXQsIHRy
dW5jYXRlZCB0aGUgYmxvY2sgY291bnQgd2hlbiBidWlsZGluZyB0aGUgY29tbWFuZA0KPiBhbmQg
Y29tcGxldGVkIHRoZSByZXF1ZXN0IHN1Y2Nlc3NmdWxseSBhZnRlciB6ZXJvaW5nIG9ubHkgYSBw
cmVmaXguDQo+DQo+IEFkZCBhIHJlZ3Jlc3Npb24gdGVzdCBmb3IgdGhlIGtlcm5lbCBwYXRjaCAi
bnZtZTogbGltaXQgV3JpdGUgWmVyb2VzIHRvDQo+IDY1NTM2IGxvZ2ljYWwgYmxvY2tzIiBbMV0u
IEZpbGwgNjU1MzYgbG9naWNhbCBibG9ja3MgcGx1cyAxIE1pQiB3aXRoIGENCj4gbm9uLXplcm8g
cGF0dGVybiwgemVybyB0aGF0IHJhbmdlIHdpdGggYmxrZGlzY2FyZCAteiBhbmQgY2hlY2sgdGhh
dCB0aGUNCj4gd2hvbGUgcmFuZ2UgcmVhZHMgYmFjayBhcyB6ZXJvZXMuIFRoZSBsZW5ndGggc2Nh
bGVzIHdpdGggdGhlIGxvZ2ljYWwNCj4gYmxvY2sgc2l6ZSwgc28gdGhlIHRlc3QgY292ZXJzIGJv
dGggNTEyLWJ5dGUgYW5kIDQwOTYtYnl0ZSBuYW1lc3BhY2VzLg0KPg0KPiBbMV1odHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1udm1lLzIwMjYxMTE3MDExMjMwLjEwMjg4LTEtYW5raXQ2Nzkx
QGdtYWlsLmNvbS8NCj4NCj4gU2lnbmVkLW9mZi1ieTogQW5raXQgR3VwdGE8YW5raXQ2NzkxQGdt
YWlsLmNvbT4NCj4gLS0tDQo+IFRlc3RlZCBvbiBhcm02NCB3aXRoIHY3LjQtcmMzIChhZWJiNzI3
NDQ3NjQpLCBOVk1FVF9UUlRZUEVTPSJsb29wIHRjcCINCj4gYW5kIE5WTUVUX0JMS0RFVl9UWVBF
Uz0iZGV2aWNlIGZpbGUiLiBXaXRob3V0IHRoZSBrZXJuZWwgcGF0Y2ggdGhlIHRlc3QNCj4gZmFp
bHMgZm9yIHRjcCB3aXRoIGJvdGggYmxvY2sgZGV2aWNlIHR5cGVzICgiemVyb2VkIHJhbmdlIHN0
aWxsIGNvbnRhaW5zDQo+IG5vbi16ZXJvIGRhdGEiKS4gV2l0aCB0aGUgcGF0Y2ggaXQgcGFzc2Vz
IGZvciB0Y3AgYW5kIGxvb3Agd2l0aCBib3RoDQo+IHR5cGVzLiBUaGUgZGV2aWNlIHR5cGUgZ2l2
ZXMgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3MgKDMzIE1pQiB6ZXJvZWQpIGFuZA0KPiB0aGUgZmls
ZSB0eXBlIDQwOTYtYnl0ZSBsb2dpY2FsIGJsb2NrcyAoMjU3IE1pQiB6ZXJvZWQpLiBXaXRoDQo+
IE5WTUVfSU1HX1NJWkU9NjRtIHRoZSBkZXZpY2UgdHlwZSBzdGlsbCBydW5zIGFuZCB0aGUgZmls
ZSB0eXBlIGlzDQo+IHNraXBwZWQuDQo+DQo+IENsYXVkZSBhbmQgQ29kZXggYXNzaXN0ZWQgd2l0
aCB3cml0aW5nIGFuZCB2YWxpZGF0aW5nIHRoaXMgdGVzdC4NCg0KVGhhbmtzIGEgbG90IGZvciB0
aGUgdGVzdCwgb3ZlcmFsbCBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
