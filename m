Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544B330D32
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199957; cv=fail; b=tzWrURpR3fkplF0IkuUmX510fqaywXxX4k+QTZy3eHFRyX2dl3U1Vrpw86VKUk71iKHHE8Q+msmN8bwo+NNGlNdPddsXn3EmWFLz31s2lsf+yBn3gsSF+xNhF1a7Lsc0ggXjxeCuNLw/NeJszpQb65fiJvQWPsAnUWuMB0Rc7VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199957; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omFWWfyRGK227STeBy+Qj9tTBy+je57SNo+V385cAG42uknkpmfVJM+0EjsmJK8QtegBvSomoCV16z2m4TNv6F0xE/OsDOikIbH/i3XVd09ZAysZuJdqIwQwlZxvEVNXHZ41cmvSU8mZh94APS/dosOJkcNZ1H4ccYVSq0qF/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Br6sEKug; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KLNXbdel; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Br6sEKug";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KLNXbdel"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772199954; x=1803735954;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Br6sEKugm4g7LBNsJ0QsfNBfy/g6hEZnJwiMrz1YodKH4JJkk/4RJAeI
   JK2LTeYIiTGzkTRAWB2kfZc3S4J5vhxD7vwa8TKlN1mD5Bjwf+0VbqF06
   aCD7/b3OJKUBsNU0L+Mc9GbSqH++cJ9l8SQyhovhtAPPQlkFives+oems
   mynNd6HG4c6djIkPKzL5URJHBs24s23e1L0Ou1JOVsx9nnKwnToDShlwD
   jXrGic4ThNa70KVJs2bbm6qxa7LuRd5Kkd3hbOREufk5P5LMG7JkHiCSw
   s9fo/ZjmwGXPXp66sLbC5AxsLz/IY4dpujp/wRQEpyTTDKV9Mu5a1lLRQ
   Q==;
X-CSE-ConnectionGUID: 0GtcEROIRmi/XhJPkhtTvA==
X-CSE-MsgGUID: YMMWys6cRniV80mxVlJZUA==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="142719142"
Received: from mail-southcentralusazon11011025.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 21:45:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeXZNErGIiXOrnl6edz0JlrwcvEbgs2mhL5lgU8rjzxDuXfLYi6Hs+k8Qu03YfTAXzah36umPoNnkAtEN/d9nsPCIIwHC1MGM+V32++YXr1W8VYytoNtLxHIii7jbz1fUTrGJNhYm1epjLqG/fKMZR3HFuAngvOI+gL/Y4mBHLJiWl5fVYN1+Jm58lWU4rkuFsDET00bH3b5G2ErMFYXLCKTMmhNT1JE572Wi3LOVroMks0ae/sLZHLCMf43gKpn32KHDu6/X8+UqHWB75SGsiksSrDfvHMOBoJDCZ4Pb7E26E5hobbmgF3M42DF09U/cayn9zSiT6SCDH4WqZ3Xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=SikMXxzGEYON5oE4n4zuJHPxt6Wn8MC4FYcdxkBeTrEzpoj43rYfUN5eGnxSEEfQCCthUuNb11iTzxdpjTi+NZcMyEHeVgyBqRrXAA4ajRJXI12tNylSnYkXPBpB2p537vn7dGH1qYAZ/MsPRCIJ9Q23B0XG2JFnJe5vn6pa5jX2hMvINH4GljZf2SYSviZL0Qqh7n/ztUyHQspmc4jzJ3ANcvlVZ5fHwdjJNs/B0QBqspE9xOrCCEgD14i5mCR8+0j00JpPUcfvqSM1u1WaSkhrElhBeP/y0BMOVileiPAEciAEE07RbuWtScjx13XUlHeVb63Ley9AtLi4TFizWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=KLNXbdel05C9VZn4PYiD8sc0D+o0R803o7i7Ib0HvlAmpIE9FoJthKN95vXpx25AwIZghEKWUB1aWB3M99HxU/kFFwZYJQOCKHptimfbFur1wkZqdeWVSipXxFaPBIo2Lg+Q/2PriRjWSVJiG1l8EF1gA9I6wB7gpt+xEXsqjcI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DS6PR04MB9919.namprd04.prod.outlook.com (2603:10b6:8:368::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 13:45:53 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 13:45:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] block: allow submitting all zone writes from a
 single context
Thread-Topic: [PATCH v4 6/8] block: allow submitting all zone writes from a
 single context
Thread-Index: AQHcp+yhNZPg+4+/J0i2D/e0iQIwMbWWju6A
Date: Fri, 27 Feb 2026 13:45:53 +0000
Message-ID: <b5873371-bfb3-4bb5-b150-a7774df1b2b6@wdc.com>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
 <20260227131951.2464150-7-dlemoal@kernel.org>
In-Reply-To: <20260227131951.2464150-7-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DS6PR04MB9919:EE_
x-ms-office365-filtering-correlation-id: b1430b7b-3711-4eb4-0370-08de760686b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 QrLmPHrthWRkuL2oO4aETrpiNj6btOEkpaYxsLf+I15VpsccAsqJMeOf5Si8JYOB9z6+ELX+TtpFWtl5lFRnTMPeywRNh/FgDQxre4qxr6Mk2q3o1hSXf+1f87Vx3j26hzRikGZoCcnw17s2k2atf1iHE4VC4kaJPVyo5QLQGLPaOyuVjvnD18kqaQo/ylQMYxHd+C2HnNRSpVTkMezT0+44DCRvaDqnyx3omvNGd4RMNEn90chzxaEBW+DDukV4sOubnijHsMxxg6+gYbi4BApDe0jj+PhLprVNBhkrnmdlSDf3HfmFZkW+CNsf7J9Dli58zyTlUCbQJ9TtlRsl+CLyow4lKLwFE5FZUYbknN2cF7WMZ7JgaPCYwK6Lgk23CcCTQfY17lQ6BogG4+8JpJxVd5LnKxFAiLVx9OPVh0FathKoc5EXJBlNKhcKHyHl2HPifD5+9tZWu+DvAJbzHaZ/kwmlZfvClyAGcGkcF+MJHDUDnvLgyGZrQ3VwlLZcgr+sIySlvHQeN+/DnRHST8hqmp5NGgmNrDxMF5mACZ+8lSYfAhS8+ysEHQSoBs/DuJCskkAFpYHBzcipBYg7qAsV6eEwKFYhoxMHZrtgfJN6d1UX+yQIsYMbW32WmVdShgH3AGPvD+0OteDoj522juZyaRIXV4k2uaRAnUCyeFmCsXxbY+Z9bUSR/UQpqUDG49DkFVyPtZIM1+Jpr+Qq3URdOZX9ed49zmzm2rgN4dFmrwG+5lTHFIABbVeoCHs1lwnEW3GmiXmsum5W3tvx8thJBb25PasH1JZUTmPMmOg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjFYS0wwcWNpYlNrTDA0ci9aOWhuQ0hFaWpvWExMakg5RUduZWdSMjdma3hR?=
 =?utf-8?B?N3N6bHI4VkhKU1NQVGFDZzNGdEdyZUJ2bUFjRVZRVzkrRDVjaGMxU2FxZnpj?=
 =?utf-8?B?eEJqbXpYSzBXcHZPZ0hFdXdiMFBhNDhMZ1RXS0xVdlRjb2xvTEVTUlhSZWpT?=
 =?utf-8?B?RnFiMkRaSkdLSk5oUG1FOElIMXpvN1BTUnhWenhocmJtclVYSzlLQjg2V0Rn?=
 =?utf-8?B?OGlvZlloT2RXdnFBVkVQWXQxcUZrRCtNM20xR1lMbjJTZnJ4elFET3hYWGNS?=
 =?utf-8?B?dndwaVZUQk1SOUM5YXRSRUNHOWJGOStiQW9lY2p0VUovbmtQL3B3TkxzV203?=
 =?utf-8?B?bjZYWjAyL09Zb0Rmb1psSDFEdk5lU2dhck4zdm9LaGFJODlPTlIzWEo3ZXRQ?=
 =?utf-8?B?WWo1Q1MzTFFkZjlrYjVBUnIzdGhXR0Zsd29zc0Zhc2NCZWZYSktidWVnSVJF?=
 =?utf-8?B?WUcwQlFzWVArbXhHRURpNmhwQVFPM0VGUnc1MUZLbkdtK1c4TUpDVVVJc3pr?=
 =?utf-8?B?T2hvaitmM3BLdDViRmVNMnJEbWJSUkVHelc4K2IxMzRZL0tsN0JUMDRaUXhJ?=
 =?utf-8?B?Z24rWUVPOW45OGNicVhSYk5oQS9TOWNYTTRqZC9TeWxCVXNjbEpvSUFWaklo?=
 =?utf-8?B?cUNndzA1NkVsNFZmZXZ0L3c3eUZ0TEU0K2l3aUJUckpYbnJWOHZXZ3M4Z09O?=
 =?utf-8?B?UVgydUppaTVBaEwzZWdIWmhvMFFnV1pmcjhOWlhoVVIxMEkwZ1Z2OTc3Y1lh?=
 =?utf-8?B?ZlpsN08wYmEwMWUwbmgrdkY5NXMrWFljTHhMcGx4RXpodkdDdWVEOTRKdm5l?=
 =?utf-8?B?NVpyTnJSQW41enlqYlVXSW9DYmpHcjgrY3hJQjV3WFVteGU0TkNjdkxVK0po?=
 =?utf-8?B?OEJ2TXhwSW5rbFlXcDV4cnRQY3JnOTJPWmNqTTk1N2V2L25TWUh0Y3dGUllK?=
 =?utf-8?B?clVVcUVEajY0RGNGODQyK2F2WGlsZGNOUFJucDFEbVYrVkhiQlMxbXN6TFlv?=
 =?utf-8?B?YVgvUHkxSE9idWdjOXJjTTgyT3ZzWXo3MVYxZUlMWWxzamRsWW5WaU5Gek1S?=
 =?utf-8?B?eVFydnR2NC9sb3BXZDkwalIwdGtKN0NweGNlUVd6YUpYcExKVUVaZWhCMUxM?=
 =?utf-8?B?SW9uMUgvRjA5N3M3c01IVXlnSTJlajgzMVhsRjFzT3NDckxnbUtGOUVQa3E1?=
 =?utf-8?B?V1Rsd3NsZSs4WlBrQzRPMFRQT05kRWdnR3psSm1XdUxXQnV5MnRSQnFjZWdj?=
 =?utf-8?B?bEdFMThTRVdJQzJaL0t1Z2hVQW5HU2lUbm5jeWpIeG5UcWJxbkJzcnNHZGxx?=
 =?utf-8?B?NXhMWjBoWHdZRkF1bjgrQWMxcGdOUmYzMTAxSDVpUER2bTJlZTh3RTRkQ1BX?=
 =?utf-8?B?WFhWRGlVMy9XblFBY3FqdmRkUkN5SktoaFpScThxVUR2Z3VzeEtrYkVrTHpS?=
 =?utf-8?B?UERkWmhXaWpRcW5MN3U0a0RUVjZuQkJ5TlhaOW5Ud0tlQjdjR0dRb1VaNWpK?=
 =?utf-8?B?SGxuQWM2L0VqRTVXK2FpeVBVL3dqbGV3VDlkSFZtM21pNEgzZkdiMzdwVzB0?=
 =?utf-8?B?MlhGRWo2Vm8wRWRBWlBaMWpNUDlXa0kwOFBWclpNZG1KMTZYKzJtUmhRTDNj?=
 =?utf-8?B?UmxKbVY3MkZDMm9pNEpQWkM0ZXNlZ3d4VkRaZ2x0TzhDSHAxK1luNzlPUWNX?=
 =?utf-8?B?UVk5akRZcTFuaFZiWXIwMkR6cjh3d1BrM2o5RVZ3R01ZVUl1cHJjV0xCSmda?=
 =?utf-8?B?RVZSN0RUTkJOSzltR1FwY1NyREVtWVJBbHpyM3RGa2hJMlRHK2Fob08xY2xs?=
 =?utf-8?B?YVV0WlBjYzhhbWZXRFAwVTQ1NUVYZ3VFVWE4QnBEUkdzak01R3hXc05INXpy?=
 =?utf-8?B?QUhnU21SLzRBYlp5UThScjZrNVloelpyaW1RTDlPLzJBQWdnNFFCeUFsWDhs?=
 =?utf-8?B?MVBNS210K2RkT0l4R0RSaWdPSGxDMVh5ZWtudjgwbHgxb1VFM2NCSHFjS1JY?=
 =?utf-8?B?OG9QNUNvTEdndXVFVkFHNFBYZ3hlT3IvVEVRamFIay9sMVhmejc5dHdqQ0Q5?=
 =?utf-8?B?M20yK0N3L1FkOHJMQkVHNjMrRXhadmpSWVVIT1J2U2l2ZysvTEQ2WTZTZ3d5?=
 =?utf-8?B?MkhhdjB1UjMrckg0bUJlV2V6ZWY4cE00OWNLeERxQU53L1VkR3doQ2RMUU9I?=
 =?utf-8?B?YTg4UUJrYmdzTllXdUU1MTdxU0YySVNxeUdURG5oVnVRems0a2J4MHNOdy9X?=
 =?utf-8?B?NVlKOVNJS2U0Mkp6THZWVUx1T044VHp4VXg5TTRFaEErL3NBYWxQcG1vOTl4?=
 =?utf-8?B?TWVqb3pRUmhIbFQ1b3FMUTlnU0RpTlNPdDRuU2RGa3d3alJyTEpiSDN6V2Nw?=
 =?utf-8?Q?5Apqw+KP7UtzkHjo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F07A2294A30824994A016A7E223C07A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	84VCkaMrxgkZo2wGPJkAPIbKxPbVEdFFwN31QJeiWY9zgsFDjzINhhhrQZxWaVbSo+h0x/ETwDs4rVu10yyKz1xRuSzoh7Z6c0JGGZQhP9wEhrrHJx0g9a8J7M+5O/f8o/Wd5xHMoWJW/+/MW2uGyluWgA+ufszv57YAn3as6bupkqzYXhgRcetHcf9mW7gH/tDSVjY7bR3AQW3vlfTL5XoPaB0iQT+OIrAJjn8qv/b49HgHyKfE1B9pyCrCnmPqvgdvi9Sc52AJbyuNzzlAYnFahdi+m/f9DGrHvRjssEie76VDud+o8SgXHgyo9Zzy5X9BRKkesVf4Xhl3R/sQBVwdFbSHOcDm4iB8+En7xfNpld9+/x5XlMPDi5H7Lv3PyWipMojegJwTQAjqmaSjYen2Qtb0e3t2ZfMTaE/VMDMlhA43eVC3gftypBskRnIex49RQgJ5j0FHiyrVmqxGinWG6ecvEPoS5p2/PGVK8Hvfj/ucbjv+o1CXHlYv64Eu95HoeCeIEN8HzAAFlo1zCRXcbTEVAXPfo5ms044Zgix7N+QCZW1pp1LXDZEciq8xU4HpxsYPBdH6TJuLZSTllzPyKNXDoGIGm9AOvXHi2k/VJ7qzwaJ2Yx/lJ79LCvPc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1430b7b-3711-4eb4-0370-08de760686b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 13:45:53.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aiq+wwCjSgIvgScb51vDYsEPRGBqGF4g/LVBxq7wcz8JxgVXOzE/qZy1EWsM4mfkdiNT5f+UQoISor6m/FLvCZH/TdNJxP0wpY7MwV8BYIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB9919

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
