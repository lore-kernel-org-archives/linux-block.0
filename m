Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263135969
	for <linux-block@vger.kernel.org>; Fri, 24 Jan 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728430; cv=fail; b=pAZsYxnDeL/381FrMrNPmjdgN+vmnjfj9uSgbLh6+xeW4BGL8LpJSfQS/kKWYtUhqf9gszaBcYRkPmOKSWn6PC6eZSA4lIpH4yBHmSTq8KvLDJHpsZTshU4PeuTpXKP3P8Gut3sx3uWPXWM2Ph+1HlzB2GBMxn+VkLr3SM5LyaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728430; c=relaxed/simple;
	bh=uhBBHvEFzvF/pumPLRL2zKW8szzXm18z8L51GUxa/Ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFxvi/zcehpnYXZtDxUJ7IBrKleCI121Q95VpwfYbl76sTRcQPFYkOTJlr+kHT+kKduBM7lSxyQL/0mQgH8u7SIQSJ6OxwHF1+5pZTryFErHwpf+uZQxNH4NswgZBamYcQ/sy+7HgTkwVlOshp4bIHvvc2IB4KOBrjYfiZBkr4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VN1d7Krk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yhT2xqvl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VN1d7Krk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yhT2xqvl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737728428; x=1769264428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uhBBHvEFzvF/pumPLRL2zKW8szzXm18z8L51GUxa/Ro=;
  b=VN1d7Krk2NgswYySeqg0VLwBIpNiZjwhPjq8M+oBLB+Uq787p8eK6r9E
   Wxov81PTI1jVLz02sasZNJDQmebdp+O5yq5saKyG7fRJ9GcPxOVyq8+sL
   LzNp/KO4UDTlWP/ItuAab3dAbps2yv3Ro1WEV+A+CNeDxQpXJ8VOo62JY
   u3PqXn0feSGMe1DP9N8f4HWQwAECvWrR0fg6ktempyOVQ167jagoWXVsx
   9Z8ofh2II9ZdMoTFb53AUas4V7oiYx/vcYoX7vW8gAN1qh+CrEeIiEPh8
   yJf9DjzNUNJNrVPW+MzU9/AeINcc+tXyoGIZJEeo9UtlKI92HuPj3GzVJ
   Q==;
X-CSE-ConnectionGUID: F6oMd/r2Ra2Rta95OTaRgg==
X-CSE-MsgGUID: S2NCQ+3+SoSMdEazfx2a/g==
X-IronPort-AV: E=Sophos;i="6.13,231,1732550400"; 
   d="scan'208";a="37745692"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2025 22:20:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDXBOcW289X5FkVOMYXxgyRNSK/AzZC7xyK9RWYPml2IgwDNNYz/TyTSdF4baTBFrU6H/zED9he7BCvTZh0hm49v2ui2lUmjfxqi/bz3tKaq8AyGnWSJ7K+5+BY8CaS6ngG4PiRT0QocP4Sja2vcNYxahqmrDkvWHDjEqRUco6WTSFAZSRhjSj3Fv7uUXor1OUG/N0YdwFH7C+C5JCuuzsbl60TVe38WHumjC60SODfMfdzuBbY4TI1O3z2TG42EDEXy7fqO8TtRUsdnmqH/vsieqM+QCDVFyD+FRTFWKcwcMGFvrKOFPWTxr5INMghuNphMvPY8Z+JwKbn8Nw1bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhBBHvEFzvF/pumPLRL2zKW8szzXm18z8L51GUxa/Ro=;
 b=mnznBShr8aEnktEm5jlCy6JCbHUZTgBh8FUuLwOuespWPWSwHhnARO91xy71ItPDeLobfIn5reQZK4rAENaC3URcWwHCQIg94UnksM90BLmEO2ePu95+jz69rTxkbAzJPkgGjkXAKH/O+QQ+xxVJMXRoGJA39bxPFyB59SDeGjajM6EXgMzd/thHrvAIY4wT/byEF62kZcshZB+VIqFWce49WHEk1I0mmTGCHpKI5fMjNxPCtTWsOSSCCCHK6W+aaa41N4E1cAtrx4wRWo9vgYZXy2WuxYdUhCf3P6whNUQvi1F2bNWKBUonEK/LTfakgRZBN5pEw10hc13O2jZL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhBBHvEFzvF/pumPLRL2zKW8szzXm18z8L51GUxa/Ro=;
 b=yhT2xqvlcO3R5ljojmpgoRPu3Lq7pxtDk100Hl5BQzGXY750/G6TLIlWRGu69+7k8Bz4HKc8gK5aT3LCdvZWDUm02EjW+qmWK6xi47EiBDWcv/XX2vIaeweg7ETFgnkzWW5I/xPrPcR2HciwkDlBYChvzp34BB6L27oNAserGS0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7156.namprd04.prod.outlook.com (2603:10b6:303:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Fri, 24 Jan
 2025 14:20:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 14:20:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Ming Lei <ming.lei@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
CC: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Thread-Topic: [PATCH 0/2] New zoned loop block device driver
Thread-Index:
 AQHbYEbmdjy0OQwptU6Zu0tBlzGDWLMJ1RuAgAAHmwCAAk0mgIAAK84AgAA0DICAAA+zAIAACHuAgANVbYCAFc1LgIAAMjiAgAAez4A=
Date: Fri, 24 Jan 2025 14:20:19 +0000
Message-ID: <a7d4c015-8707-4c56-a8bf-4e8e8746382d@wdc.com>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de> <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora> <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora>
In-Reply-To: <Z5OHy76X2F9H6EWP@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7156:EE_
x-ms-office365-filtering-correlation-id: 9ea76ee2-816e-4160-0145-08dd3c823b5f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T01WT0ZvMUVPeS81c0JtVXJkMmxyRTlrRUFsbEdDM01Yem1oYnI0M0xnWmZy?=
 =?utf-8?B?TlFYL1FldHFMbkZ1bVJERDYzM3luNzgrV0tLdlZOUmRIeUF0TUNHSTUxVmht?=
 =?utf-8?B?NnVtNjNKbjgzb0h1RUtXM0xhbHM5eXcwTWlVeVlIM1dMUTZLMVQ4T1pHQ1Bw?=
 =?utf-8?B?b3p0cG5odWZWTHFHMlRncnp5SU8veVVtc0t2WWwxb1p5WGFpbXUrS1NiQW5B?=
 =?utf-8?B?TElxNjhPQStaak1mMmxNK3VhMUpjVUNpMTN5TFBwUjlmYzgxL2ZCMkdWZE1x?=
 =?utf-8?B?eE1vZUh5SzlwZmRuTHBOd3diQ0tWRHBSUG93VDZUY3MvYS8zazA4WkVITnhp?=
 =?utf-8?B?ajZWTlpPRkxuZ01Pd2FBZHdqeVJMUnhtZWNYQnhGUWNsV1FtVVZWRmRuTk9Q?=
 =?utf-8?B?VUlzSmJzKzN6bVhNOEVPY2Zqb3VjVzc3WUd3cHRpM0YxTDBzc2FiZTFlaDBC?=
 =?utf-8?B?WUZ6M2lKWWJ6aFdCVlBCbUVrNmQ0UkxMTmlmQzRESHBtd3Z3RFByLzdDOVVB?=
 =?utf-8?B?ZmMrSGtPWCt5NzY3TXZSOUtRYWRFR09scUt4bGxSRXIzVUtPaXFjcHhtWGNF?=
 =?utf-8?B?cWowVVJ6NXRZWGRWVUtGb1RKWjR1bVYrTWFyZEsxSHRpQkdQR2dkcTZUWTZS?=
 =?utf-8?B?THYzQnJucm4wSUhOMEpubnlua3BqY24yMk5BeEI3OGtQVnRISnFsTTFtUUhi?=
 =?utf-8?B?aVpDVjY2Nk04MnI5eTFFb3lNcEpBYkhNVlgvUjE3Y1dWcU5wS1FZWjFBbVMx?=
 =?utf-8?B?dE9PM0RjdWlyMmM0Mk51cmlIRkh0dEQ4M3ZVdStyM3hTRUltY054d3dWRGdU?=
 =?utf-8?B?NHpVTm9PS1E0ZVN6NktGck1Ib3ZaNmd5bTJ1bGtRNVlFeUZ0U0Qvc3JpOWIr?=
 =?utf-8?B?OTVrYTZCNXl4eEgzT2F4TjBvdXNzbVZSZVhoc0VVbmQwNVJ0YVlzTmM4R2ZR?=
 =?utf-8?B?K0NrM3RDOWxTeDFxeXh0MFYrYWFsUjFzWStnbFRSRUorRFZTc0Q4Kyt2eDRs?=
 =?utf-8?B?QmVyZXRQd3NTYmVNbCtDSkxIMkYxNDBlZU9qWWFNWHlydC84NmQ0bTE2d242?=
 =?utf-8?B?MDV1Mmk4MEtnKzhsdnRnVHFpMEZyWDdRSnNaQUU5TDN5aXdnRzFxbithZ25a?=
 =?utf-8?B?WElMbHp0MzQ2NHl6TFJ2ZVJyTEUvVGU2L0U1cWpIK0JybFkwUURoUmVSN1A2?=
 =?utf-8?B?Y3ZhS00yUTN4dVJIY21zMFRLWmNsQVI0clVRRkh3SENQMzVjK0pNbVFqMFpu?=
 =?utf-8?B?ZEpjOWtxeVlhM2JDelc3L2tJN0R5cjF2YVVvUlJlYW1TcElYOWFSZjZEb3N6?=
 =?utf-8?B?cE03WkpZTzBHeC8xUEZKSmZCeU52dTE2WVNYRWNEdWNjU0kvY242ZGVsZ0dj?=
 =?utf-8?B?WDRsd0hFVldQSk9BcmJNTWhrKzVoMGhlQjRPbHl2VUswaEhDSCtYWi96aE5X?=
 =?utf-8?B?WUZ4YnFnZlR1cWtQRzZuL3RhZzBZb2I2ZHNTcyt3dVAxYjArVjc2aUhENWFC?=
 =?utf-8?B?RWhrSm15Smo3dFBUUGtmNWZPYWdZUDRndUVsYkEvV2lTY2pJSndrNlJmSmVE?=
 =?utf-8?B?Q0RuRHBtK2RsQlpNN0wwU0hsTFBGTFVHOHVzZ05YQWhDUDBJV2h2b0kxQVlw?=
 =?utf-8?B?MHhTZUI4d2loYnR3Tzhwb1NPYitkajVoODZ4TmpUaGZTVG9oajdtQlQ2cUxB?=
 =?utf-8?B?WFQwNVpnQUNER1Y4aFB4UG1UN0EvVnEyOEVkb0wvRVg1Ry9TenJjV3ZiZVV6?=
 =?utf-8?B?M1VkN29sMXg4R2dmdm9ncythdGdxblluc1FaWEdzT1ZXcm1zaUpQQnZSWHNE?=
 =?utf-8?B?WXNMM3NZUGZLREtiYnVncmV6SklWZGVhODJUMzIvNHNLSmZnenhYRHJZZnlO?=
 =?utf-8?B?Sm9NcEYyeDlrK29ySytYMEg5MFh3K0lyZlJidDFlVFBxNzFaY0tscGdMVXFG?=
 =?utf-8?Q?fIhYbxWXP7kuTDE9WuqCg/w9FX4TDZPS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3Zrc055OThZM2l6UFNObVp4eWt3K1llOG42NWFLMy90Y2RGM1lJTXNENGVk?=
 =?utf-8?B?UnFJblJKTHJDRGt2SjVBcU1hSlVJVXVtR2xEODFiRUVwNmdSckFIMUtoa0tV?=
 =?utf-8?B?TWtaaGdSTEl4WEdJMkhzWnkyVEEyYjJhOUNnbFgrem0vZW1nQnBaMXJUcFZO?=
 =?utf-8?B?NUVEQWRTMXRiNXYzaG55TDdhSnQzcUhxOWVwNEdWa2RYbjl5NHJtRy9RY2ZU?=
 =?utf-8?B?VUNqOHc2Ryt4YlFkcmhtdExrdVcyam9PRnpMWFk3SFkzOUhoSzBKbjZOb2VR?=
 =?utf-8?B?clVaWUFUWGE4eDdwbUtPMHAycDhLbk0xcXg2RDFobmRrT2RkTDZJdlI5U1V6?=
 =?utf-8?B?d2ZPTDY2S3JWZkRQQzU1Z0x1bndmNVRHZHdjSlNDYkFOTTduSDdZWDdlVW9S?=
 =?utf-8?B?TEpUTkJKRm8vdlV0eFE4TVBlYnlhYmVLdjJNSGZET2V6bWcxdHc4ZUhqN0x1?=
 =?utf-8?B?TzI0WWFscFRUVmdjY2ZUd1lTY2xlaTNEYmlydzFON3VKSWdzOURkaWczaHJY?=
 =?utf-8?B?dzlIdjQwU1c4cDBwam5oU0R2dXRBbDJIdnVDNGVhbVpacWRmTHhZYVp5bE14?=
 =?utf-8?B?TmNIYnFVS3hZSndOWVFsSStGZ3FVY0xWSGVaR2h1NFJLMUZYR2tFeDh6dHhh?=
 =?utf-8?B?ZSs4THJGam85SU9ZeXVCTHg1SVlyem1tMVVBK2dZN0lmd0lBNHJEVFFVZ0FC?=
 =?utf-8?B?OG9ZcStieXVIamdJN21USHpZMzErRkhMS1VmZEwxQXN3enRhZzJMT0h1WDhZ?=
 =?utf-8?B?OFU4cjlzajVhVGtpeFZUdGRDcVNibjRFM3kxaUczUVZydnhRZFpvV2lXcmdi?=
 =?utf-8?B?ZWxjNmFaaEVRdStMZUp3ZTNRRnV0alBrOVV1cjBlT285MjljUlJWNytFYTVv?=
 =?utf-8?B?Z3YrSStUb3lwVWovT1JoNlZIVU8yeEpMT2s3ek5BTWF0cWFhR2t4UWVBRGRk?=
 =?utf-8?B?Z25rNlkzd1M2SVJqendVMHFpcDdiSCszMjk1STRybTVMUWE5dGZobWw3QVZx?=
 =?utf-8?B?dXBwOFBUNG1RRjArUGF4cHA4WElKc0Z0UTFGUCtBY0swY3RXbDJ6Q0JPNDJJ?=
 =?utf-8?B?d2JVZXZDdDhCK2lpeE83VVp1OTRlUEt2dUZDeklxaDFKQjl3MjNXbjhxaHlJ?=
 =?utf-8?B?Z0hQbVUrOVdlTjE4Zmw2U01wNG1yQTA0cUZsSTNsNFlqZTRKOWNTZHVSMW1J?=
 =?utf-8?B?ZG8wa1lyNmlWQnRIS1FFUkZvRGxjS21SMUd6cmRxaGJQVENNaDJtdXF4dUlZ?=
 =?utf-8?B?ajFDYiszSlkwanFQT3A1UXhHTzZ2d1FKWjNRaEJlTG1sODk0MTBEbFVOb28w?=
 =?utf-8?B?MmRYeXBjRU9rbmZHMTJ6WUwyUGtZNXFTUk4zaE5iSlozSDZqUUt6YjllbGRr?=
 =?utf-8?B?cjhGSEFFMFd3VjZ3WC8yRGdxM0JjSEV5QnAxbTV1KzZjaklVQWcwRGYzK3F3?=
 =?utf-8?B?bEt4ejBxVDlSUnFxSlN4bUVyMmJkdWhVdEhKdCtjbkZLNitMOWxsMkVzWUFU?=
 =?utf-8?B?cktINHVFRUxPb0F4WjJoUHF6eWxNMUxvQXo2RlgyczU2dnZLTUMvZGV5RlFs?=
 =?utf-8?B?TkwvQml2dm1MSk5yTnZXUE9OUFlHYjNTT09TVWdPMEdWOGM2ZjJnc3IwcWtD?=
 =?utf-8?B?bmhORENzVnFlVXhSNlJwdU9mYk9paUxGenloSDVBb0dxeTJTQXpRUENaWjJk?=
 =?utf-8?B?U1d3SXI3V1oyNTVucnhMMDRrMTh2SzZSdExtMDVncjlCbnhNLy9UQmlWVzZS?=
 =?utf-8?B?a2JBNEVXa2d1ZUZjTkp5SS9sODNFM3RmQ3RNVlo3M2dRVUUydDIyTnAzYjY3?=
 =?utf-8?B?YjI1NTBNbERZeW1nQTBuYi9vZUxmZFc2TEpDNnRKSGV3SVozcGxCNmx2TVlk?=
 =?utf-8?B?R0puZ2gwMDlwSzg4RHB1aFVhWHBpOWhadkJ3K3RLR1NUK2pQSk1JVGZTa3pC?=
 =?utf-8?B?aHA0Vy83a2lxSFU2QVQxRkxjMTlLSnIyWTE3MURMMEEvaVQ5NkpNTmFRUUZ5?=
 =?utf-8?B?ZFloZTlIUzBuZzRodE1kNXI0WFhuZExycnB2a0VoNHVmT2d5cVRodTZaS09a?=
 =?utf-8?B?RENhK1pLUEFwQVJOMG9vWEpCS1J4RGJPeW45MnpmQ2EramZWNmFvMmdGc083?=
 =?utf-8?B?ZStHODY3eHdycTV1cjBKQ3NkbEhDbzNxZlNJOEludUQwa2prQUI3K0FvUStD?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C5933D78F9DE24DB142E284040E3B25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NCnGZc/Tf3JszApyuY+beUESnBoT6NSLNleQcj/NG4HGN+XXMPPdFXLFtAwOk/aF5odHHj53asay//YgTEgYNnh2SpslR+glqr5Hxm+J0OBuM26TeRi7pAdnOInFFnWhblQet9sxYMonRkqeTw+E1dRmHfbKq3zcPH1wEEs6osBSGiP+vc5reI4MJcL7n1eVjd3i7Q4euKAlNxzbSJSfbCattY/mWgPBpNWvKPfCTtbyFZHGGBn9VsSn/jj+c+hsg5Lrd7UT0dQ/7Ey0S/V/oy75KbprlBqv/Eruy0W/BcLxEQy2LBeGS1FExizRjVYsvwvIfo67YSdi5r5kYTNQilHb2cjkuYRIcYXrrOmHGVpY1dw0ESP3pAcMVvvVJEMEos7Wl6M22xJhypaNX072Dk7N1jhqVW6n2pnQrp9WAlbnAValnEiI7bblAlQFxy0mYqdrlbP+S51BpFOLZiht2u572IgV0FXWiRClhwXbStObu82hmZp907SYnaNsjAy1j1ezPAQYJaZ8otbjR8cqRGhDI5e8nSpozru7cYxQ2xQk7GbRcui0DVLapXXANmhEQ+P3jjwenm1LfY89GX9Lwq5iHBTWylk/bqZAuts5T5F9FV+nMCxs+pfdMWVQU2nG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea76ee2-816e-4160-0145-08dd3c823b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 14:20:19.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpVMIgKfk6DTGqBqLYE6uBLur2oJvOE8qtx8gmravT+fwWGuteNoKzaBZr5NihF+m/EN3faj7cs89QOftieleVMp2FKuMwkcFOkvD3dTqgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7156

T24gMjQuMDEuMjUgMTM6MzAsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBGcmksIEphbiAyNCwgMjAy
NSBhdCAwNjozMDoxOVBNICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4+IEJ1dCBhcyBt
ZW50aW9uZWQgYmVmb3JlLCBzaW5jZSB0aGlzIGlzIGludGVuZGVkIHRvIGJlIGEgdGVzdCB0b29s
IGZvciBmaWxlDQo+PiBzeXN0ZW1zLCBwZXJmb3JtYW5jZSBpcyBub3QgdGhlIHByaW1hcnkgZ29h
bCBoZXJlICh0aG91Z2ggdGhlIGhpZ2hlciB0aGUgYmV0dGVyDQo+PiBhcyB0aGF0IHNob3J0ZW5z
IHRlc3QgdGltZXMpLiBTaW1wbGljaXR5IGlzLiBBbmQgYXMgVGVkIGFsc28gc3RhdGVkLCBpbnRy
b2R1Y2luZw0KPj4gYSB1YmxrIGFuZCBydXN0IGRlcGVuZGVuY3kgaW4geGZzdGVzdHMgaXMgZmFy
IGZyb20gaWRlYWwuDQo+IA0KPiBTaW1wbGljaXR5IG5lZWQgdG8gYmUgb2JzZXJ2ZWQgZnJvbSBt
dWx0aXBsZSBkaW1lbnNpb25zLCAzMDAgdnMuIDE1MDAgTG9DIGhhcw0KPiBzaG93biBzb21ldGhp
bmcgYWxyZWFkeSwgSU1PLg0KPiANCg0KVG8gYWRkIG15ICQuMDIgaGVyZSwgaWYgdGhlcmUncyBh
bm90aGVyIGRlcGVuZGVuY3kgZm9yIHRoZXNlIHRlc3RzIGZvciANCnhmc3Rlc3RzIHRoZXkncmUg
anVzdCBnb2luZyB0byBiZSBza2lwcGVkIGJ5IDk5LjklIG9mIHRoZSBwZW9wbGUgcnVubmluZyAN
Cnhmc3Rlc3RzLg0KDQpBbHNvIDMwMCBMb0MgUnVzdCBjb2RlIGRvbid0IHRyYW5zbGF0ZSB3ZWxs
IHRvIEMuIEFsbCBrZXJuZWwgZGV2ZWxvcGVycyANCmtub3cgaG93IHRvIGRlYnVnIGFuZCB3cml0
ZSBDIGNvZGUsIGF0IHRoZSBtb21lbnQgb25seSBhIGZyYWN0aW9uIGtub3dzIA0KUnVzdC4NCg==
