Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D13D968
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qwz9t6dK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="glha0n1W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704874956; x=1736410956;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mnhinmhL3Yp0aSMRLRcmFwPdF8zrHKgWm6tBtnBPcV0=;
  b=Qwz9t6dKAWTCKeRdiAqytNgWUtU6ilcDbnLexHVcfAJZB03WG9ss0S0F
   UhxFE8Pd6Pu9TAT6nu5W5fj/iYlbKPyy9wgOiLMXAwOHb8qCnIryvCycn
   lGne4dr/VVzXWarSAFi5cgf2UAFVjFcIq4lmZYNwMZqxom/xWy4mA7v+N
   xV8w4DSBZLwoEMTLR0vMB3oQquaW57hdLZuP0DyHajzpN/D200uQL6npo
   ncSw3YHKkNeq5yotDGzXxys6qQE1faZ7B9yhgpa4HjQYnNFNpFF3G9py8
   0n8Kzx8bUZ457x//9c+LUA2JTn88WYw1u2oMkULdiir4GIawiJq+zuMXe
   g==;
X-CSE-ConnectionGUID: x32zJMtwQAOBiSkuk/Ph/w==
X-CSE-MsgGUID: ywWgbOoHQNe/mxFbBex20Q==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="7015655"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 16:22:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJdQgOwFsF48c4/DrxHFe6Dem2rUX6Ykz7gsvg/ZrI/HovmCtCVySo/tYPpnNMPOMP4xEmxiOuqz9FVftEZrdyGSkwnaSYh7YwiYxiYr8hWVSQAHmLqe1C9PDqYveJdwFR1eWwXlwRCfhY8Vdd9hL5Qh/Cmok8i9LN3S/XTW9kxwv0BP1eqDmxagT6e0FdM/Xwi4E1XEEqHEobMbtYzBgJ+F2XwsdwaNGBrXt7QPiX9wQAtyWo4Gp/UCx5Ecq40j1RoSEAyCWAFLgTHaHMO4Xi4zXO3QDgzpVgWJ+4IjIDFuxbBjLGj0abLGBK0EM1iV3lZr48HDdTIarHv+hgbmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnhinmhL3Yp0aSMRLRcmFwPdF8zrHKgWm6tBtnBPcV0=;
 b=E7F595Om0RGX96yZ53o10E2bPXUsI5AjC6eG1MOKo5PmNqBtb9Fvcr9UwRYC3AHXhmmXUY+tbSupA7H1+JPYRUNrOpeqhMTOXacAH4K2rrQ2J4jBUnw9v1tnmL822iz9Yn1C5TdP4e0WuMXdgQ9+BrlK8Pir1eOUJQMEEikdPNTxB0YZWd1LB0uc3+QYy7f2CBwJ7u1k5jQGWLDRSM5uTwyB4nH0wDfFiGePFPoCitrwj7T+EUGMZHyTnGP3LtqPwXOK29ZHWyBg2ANiypAy4wRPh6lBGrw0QcExlsupYRBj4MkRIuuimZPqJXtyb2hdXo/nTVRMdvo/XKVfEd52dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnhinmhL3Yp0aSMRLRcmFwPdF8zrHKgWm6tBtnBPcV0=;
 b=glha0n1WZXwD5e+Wa+/1bnAy7Vva8z8rUnVeXDKJGOUrtyb7laEL4J76R4c9LUXR/cusjozBSTtyjvGiq0CIvyQA6t3ys+BO+I6XFfhCGsOiGkDsP9gtvEOOQntPtOx+MsO00zpIWIJjwyUNx930CO+H845m6/N2wmMmNsF6lK4=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH7PR04MB8554.namprd04.prod.outlook.com (2603:10b6:510:2bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:22:26 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 08:22:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix partial zone append completion handling in
 req_bio_endio()
Thread-Topic: [PATCH] block: fix partial zone append completion handling in
 req_bio_endio()
Thread-Index: AQHaQ4Qg4uldr04P70a3BQHxEN+IZ7DStUEA
Date: Wed, 10 Jan 2024 08:22:26 +0000
Message-ID: <fb2671c4-fae8-42fd-9d36-931a3a013090@wdc.com>
References: <20240110051559.223436-1-dlemoal@kernel.org>
In-Reply-To: <20240110051559.223436-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH7PR04MB8554:EE_
x-ms-office365-filtering-correlation-id: 04bb5f13-8c02-4044-1018-08dc11b5475e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W3GZ2NfKqMCrPGjjhaq1w7BtZsi+ESSEFDyndH1ICs/t9GalS0Jj1cNZKIHDXEwRsbgpPdOUZQmb5kTFHeOIhX+cjIoy2gErl9UzzIZxEldGX0WID96mWwDFugkdy+jmGfMv6o6w+L3nteKatd4U7I0hVbRdzBSVIp7i7nf2zAIYuKJzaWLVlGnu66pXYUZo+xUdnBTrb/8zSM6XtNlx1C8TZmBiGrPiw3RFqpIp0aGlcxFsaOy/UMkmepG/Sxl9B7hWH33f7c/F7JPd6lPkjUC2NtUpIdltFTrUG5KMu7RMIaBzjZVATFCRey2rOD8Bm54p9ykSdgdvk8Z+jSpM/wE1R4+NjE/zUNOMUma4CDoyw25efLl4ErpdsvFgZqWgmaOso6bIP2T5WVRnZNYWWQggTA4Nc7YmWVoS7cVN1LbSzLhTARnMV3mGj4GJhWXS8AEGUuxs+d2Mjs2no9ZsrMZaNXEtmwlZIXrenJcBYzL0+aJeAwik5fFIUmuRQzmGqrDY+pGZ4vVvCr0CqnFPciFYqW+pNSf6aY6Q4YC1buH81eKMYK65ReIJrixUYbwkvanmfdyf7JOIOrImxTrfSvdAUWCcnuciTx6qBPPNjrLW0cq/xFXSGxQlbKl901NlQVG2PXdb4wZbayeOKjKMEk4Jd9b0WCM7AebnKiDLyRad0ZXp31wVkbDXjpV5sdO6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(2906002)(478600001)(5660300002)(38070700009)(41300700001)(91956017)(76116006)(110136005)(66946007)(64756008)(66476007)(36756003)(66446008)(8936002)(66556008)(316002)(71200400001)(6506007)(6486002)(82960400001)(31696002)(6512007)(8676002)(53546011)(86362001)(2616005)(38100700002)(122000001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk1oU3JYbG1FbFZjMms2UWRMZ054U1FlU3Y1RG0yQnhndWw2Snc4a0owRCtL?=
 =?utf-8?B?T3JsVzNiN0ZZdi9jWGZwU1VhZlRJdXpvdHhCbkM2dVdwWEhRRzA4VnY1Ly9s?=
 =?utf-8?B?THhKbUZNc1p5Z1FLUkszWlJSM05nNUUrREFDMVN5cEtVQjJ4MGJVbExGc09V?=
 =?utf-8?B?bVlLMHh1M3ByL0kwQ0QwU0FUTFc4TnZsZE1vR1MvRDFmeDRadUZzVFFHdnU1?=
 =?utf-8?B?OURqVTBPekxLeXNhNEpoOW5rV1A0SlBSWnlLSFpSSFVSS2N0R1RCMnQxc1Mr?=
 =?utf-8?B?UGl1ZFViYVBwd3kvN0ZkWjc1N1RlUW1nczBqT0Y0MVk1N3RhMWFDMW5CK2Fw?=
 =?utf-8?B?Zm4vSllGdVNmZC91NXJJU0k0T2pxbGp2Vy9mbG9tTWlXMVc1dk15TEdsMEhx?=
 =?utf-8?B?WUNqRTllZVltQWpxMWM5NWtnRXhrREJDKzRQUktqazlrMmdERG83ZEJYWi84?=
 =?utf-8?B?UGRScENxaisySDdUbGRvaVZtQ0N1VXpNWVZ5WkoyTjUrTEpHT0xHRVJOWmlo?=
 =?utf-8?B?Y0xxbk5LZVM2WmppTy9SRkM1akxDcjd4akdjajJXV1pxYm9IWXltcndFODdw?=
 =?utf-8?B?NUlaeVJrUk1KTkpxazkzb2RGT1dxWlE4dE5vR0ZNWHBnTHFSSVNaRDIybEMv?=
 =?utf-8?B?RmF5SzN6V0JDc09Zd3F1VWwyVjY3VkxuUTkvWDkxNStsTndXS0JJTDJod1By?=
 =?utf-8?B?VU5wRHJMSUxPR1FBWXB5VWhYN1lPbGNUSDcydE5na2xQKzk4SkZoYmdmRWs3?=
 =?utf-8?B?cmw3RG5zTkMvR1prMWdDS3AyRzJXU25ucGpzbVNVTWVMeDJyejBXNFBPcWxo?=
 =?utf-8?B?TkU3QUlkUTJpRzMxSzFLb3ZsUEdSZ3RwQ0MrZHExaHpkdFNaVElsTUZpYVY1?=
 =?utf-8?B?ZUZjc1dIQXdCMGNNMVY3M0pJNFhoS1FWOXA5Y3JEeWtTM1lsOFVUZzh6dG12?=
 =?utf-8?B?Wm53WTV4cU9Uak9VcDNHamJhN25WbFpRWm5vaU9DTWlGUDhXeWsyWDFQOVNz?=
 =?utf-8?B?V3JmVmNtRjZwNGVrWEdMczNOaDZyS0p3ajVtR3piMk82VEMrcUNmc24vajdS?=
 =?utf-8?B?QldHUzIrYUFtR2cwY1d1NllMZTRPSmQ0QituejhuMDdndzVwdDBta1hsVCtr?=
 =?utf-8?B?OGYxcmtrL2hDRkxWeHgyZ0FRZFVvVlBDbFlrRHVGdWFUYVlXam9yK0FMcnA0?=
 =?utf-8?B?YUVhanE4UjUvdlA4SzJrajM5c3VTb1lBVDdmNzlUQ2szS0Vnb1R6dnBqV1Jm?=
 =?utf-8?B?bWhpNGJiREhGMGdtcTk5K3hFQmFmMTZ3WXNvMk40RC9PZllFYUVHRXEzMTll?=
 =?utf-8?B?T2lhOGVkK280QWRVZ2t6NEhVcU5GaCtuYzFKN2hIdEVCcVVCbDNjMU50QzVZ?=
 =?utf-8?B?dU5tN2x4N0poOXdLSC9NRkVMU0xHZ3FHZjR3ckQvT1dXbURPYUo1YUpVRVJh?=
 =?utf-8?B?Qi9uN2dTVnh1QnRUK1RxS3JobzFDd3k5cS81Zi8wazg4UDFzM2RtUy9yMFVy?=
 =?utf-8?B?NlVIUVhLcmQ2WStzQTRwRko3Y21Ka1ZNYmY3TEVoVDU0bVQ4blJVcFgzMjFQ?=
 =?utf-8?B?UWJwRDJFOW0rTWtWdG55aTNjRTBDdHFlTWZ0bHpWNkZvdVRleVQzREdUV1Jm?=
 =?utf-8?B?dXdyclZTbWRjcFAyN1N1Vk93L0Q4NHBwZ2MxcE04S2VWWlRjOS9lTXlYL0RE?=
 =?utf-8?B?RHNSRFdld2NJdnN6cHdzMDQwVnkycjRjalJZdDNrbnIydzZoK3V5eXFVdUhK?=
 =?utf-8?B?bVE2Z3F1QmJqU2pST3NaeU54MC9BS3Z6d0loZFlzZUZ2emhEV0dzc2x0UUNq?=
 =?utf-8?B?bXlCUFVMNGF5NFNpam94TzJEQ0c4aFlUZ09McVgybndGdWdOaVZjUUYySVhH?=
 =?utf-8?B?dCtsQm53UWtEeGtyNGxkYTZJenJBeVRHRDZrZ3dJdjhiOFRiYk8yOVplblhI?=
 =?utf-8?B?US85UUlEN3p1cVorRkpVT2J2d2JmQ1BsY0RheFhzd2FFR3BBQ3FOUTRrZU16?=
 =?utf-8?B?ZDNtL0RIYWxVcllPKzUrUHY5aG42d1Frb0szNDN2RDNuUTVvS08vbFpmakUw?=
 =?utf-8?B?aTJDNlBZUzQ2NmZ4NHA0UDRoMFJUQ0tKYlh1b1hzQldaVXN1WkgxdHg2VUFm?=
 =?utf-8?B?SG9aSXhSb1RNdU1EVzRDQ3BQQ1R2OTRhOC9US2JHeC80dkpHL3BRQnZLRWZT?=
 =?utf-8?B?WGx2dWtscExKQ3hhZjZxaTNDa3dRU1p2YnN1UytTOGxudXU2NE5GUU5aWVEz?=
 =?utf-8?B?dlFKMHJPZEpCWXUvKzRpSXNwNnd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29FFC8DE3708314985125380578C09B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	15lYmeTQsaRtZ/3ecFXhwMzucsxttlwVIQ5ajoqbIUbL/63O7vwL4EV4nQds2bYVnuZRqQhOZm0/aaR99CZxyjZu3g+oWNrBGbcWzOWayxtHt/JfaNT86fjvJfh6k6zUP47Lu2ZmVE2O4lTZ7NQTU9R3dwlY5FfWO+Ma8aYAi1PTLGjBT4Gj7upDKyOZxj9Y+ws99Vh/oPEyDGX+iIjOwm8LnRMCs5JSy0ca9KakaxLzMBbrCjewnBsRNeUVZ/XMiinQuko5Pwr9eSWV9SyDZ7Mo4uBXva0Vf4tt44VVrj5jQma/TMRdvEk/GMxl0f/V0hkEvnrnRICcD5/UhC3Cumyj+Y5fa7BinnPgYT/4d7JJQ82A6igWuTXuNwT4T9aQNPe9uf+FK0l93g/Mz3QFd1HTNQkN2HDURQGm7hupEUUYrVWHf4dMckaa4NWn6kqf4Wg8KpupMZHaIYrLVaRzGwb8+x7Y4/rqL3wPc/HZlX9zywJ30YPOb/7Xfm0LefdjbwdBAR64fyhnIBJ+LRKu0VrmfZM832KJdAOY9I0q3CS0p0BQIdyLxOYdFF28Pi1tVDzdNwzFqBGVGmRPkfAZJEkuBuCWz9pExajBg9KaBzeVXWuD0atnAv7ch7HdHjrY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bb5f13-8c02-4044-1018-08dc11b5475e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 08:22:26.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGeQgOz7RAu7Tt/l+H+oT5xuQVIcYGnDBlOaK6Q9EokdkVJnWAkoQ22gmsFe6rzA+guD3Q6J+FlGwEBwghBFBboIsBbyb07W+UrceW5cuqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8554

T24gMTAuMDEuMjQgMDY6MTYsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBlcXVhbCB0byB0aGUg
QklPIHNpemVpLCB0aHVzIGVuc3VyaW5nIHRoYXQgYmlvX2VuZGlvKCkgaXMgY2FsbGVkLg0KICAg
ICAgICAgdHlwbzogc2l6ZSB+Xg0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
