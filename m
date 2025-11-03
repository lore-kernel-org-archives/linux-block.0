Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A70269D17
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177665; cv=fail; b=rBPQrAaPDFFpTnsD4a7ihc51ahhH6kPhpnMy0fWsdCkFqBctpJDrNjcIpe0C5Deebe6vMQ9H497VLR6aYQzeMscy8yLyLA6LJeRmCqiNBEYK7j7fDFj4ivrLZgbTefOVPrE2xM4QhGtPAafiSwyflE6h8d6JdDyJBnq+eWySTDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177665; c=relaxed/simple;
	bh=zUjpQ+MwOxAqS5K92/KHInGFk52+BVC+RTuSDTNMhZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcJsqz+AXwkgXX6z8gYmIq/LVMNjupnJAoAthk2HWWbs7r7IB1M8/QAfcEXyjs4579MKvV+CLHNiR4bkv6R0fuVqc9126ZWV9niI2nB+PTiK68bSm4kV5oU/FuLbjw2eKTGvstSqrzmwn/sDLuHqwsf7bYf3+iTC+BZi9X7RMKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OmbgCxvd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QkgmQ+iT; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OmbgCxvd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QkgmQ+iT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762177663; x=1793713663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zUjpQ+MwOxAqS5K92/KHInGFk52+BVC+RTuSDTNMhZA=;
  b=OmbgCxvdwIjcjdaACqWFKhqPpro8sMcl48mh1/lnrO8VzTqXdORpW8JT
   BaYRqPcOcmDB1LY97I8HyuNxQdYAbypx1F0o5fyHoUm2n+RBKT3FpC7KD
   6OeF82zKSzfFF/oTHA2C3BzUhC4VUuWIMRg2UETk3KJro3uQsWYePk5V2
   NR1+JnzoaG5/J0kF9atsyiheYFIh2ht/nSEye7FF0etZx/1Y1slBGOlpX
   SfgTDWJTb84cczI3ascs+VL/sUBYjSC4Reybzq9gVev7nQBdbqusHBaly
   vTT5t76H2Sz0k52QGj1Uf8dBiVmAiJdU/IBOTvBaBquxdMG9TFk2cMByA
   A==;
X-CSE-ConnectionGUID: 29CxT4vYT56m4JDNNuZNVw==
X-CSE-MsgGUID: gB3yzI4zQIWzVQVefDCPNQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135673136"
Received: from mail-northcentralusazon11010017.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.17])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOizE6pmFwrhVpWBYlkr+XTIg6FIhK1CpTbT1MywAw1ffZV9AY+PuxhDADA1qY9WFa6WYw6EbDl85vIS0BHjAmjFdbsqcukLJ8HL8oVmKgnkScFqJZHioL90kj91wBz8KH7mVQ0k8ooi2NAD3UrEiu2aQAB7QcMvm7V60OG8gefa6+qz/REznYsO8M/nMgJ2WR92ghNnoy7F2xNUQmJn7n2wM048Y5bEwYv4XEOpuDuHrgwPRhAR+5+I12MGZSKOstWw1OGUs9e5a9pzOUYNMKNNize0vNen17fbZGvI8u9yNeAMcF0qpz7YJfvYObi1B1D+kHHA0I9KdxXDvSyCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUjpQ+MwOxAqS5K92/KHInGFk52+BVC+RTuSDTNMhZA=;
 b=jPmDAcgL9bHQKrjyCuofO3TGwztWSX3jzYVVGhtFiGzS0JJBHrb98QIO3csojH8vkCnNflcBPbHfYeTHfxO9+OrPJOsdWUw7IDIUVt6rqtk/c1uVBOl9m+CpSZGgNAM6nNH1MrIQ0L1oeXh3/fRd6uYzBFtK2/uAPX/qI6l1Do2joUHjO4DHn+5EIcQFv2iT01Xze+ccYh2VV0+F/JFS/IYCb5pRFWwBGCsWgNVsFU0nLf7sg9yfonCr1b4D9jQQaBnchrdXFn7ETBsLxTuGVamjrYEvheaICjvfiV+Fl3xf0CoSnmnWRPQZOS8YoQg4LaUTT8WmA6DTdVa3J9eZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUjpQ+MwOxAqS5K92/KHInGFk52+BVC+RTuSDTNMhZA=;
 b=QkgmQ+iTeJrufVL8dYiXqm9kUaFCa1SpAv+NRi3zGmze2SxbJFkujK+wh2dp9f58XeSljoOHrt30EmAc5Z2yIOZnTeJaxj+DEfcS5YMpNhEpZeBLrjDe38KRuXVytapxtI9t2M7xeg8Lzml3wjUmZ8vSTJyp9Lo4puS6eqKCot0=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by LV8PR04MB9147.namprd04.prod.outlook.com (2603:10b6:408:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:47:34 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:47:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Thread-Topic: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Thread-Index: AQHcTKsxgrbFyvpK8k6ZMKMJbiprxLTg9WgAgAABgYCAAACRAA==
Date: Mon, 3 Nov 2025 13:47:34 +0000
Message-ID: <8c8b5f23-b257-47c0-893e-2a5bde51915d@wdc.com>
References: <20251103101653.2083310-1-hch@lst.de>
 <20251103101653.2083310-3-hch@lst.de>
 <bd4e2d68-bece-442a-8a00-4fe2d5e14645@wdc.com>
 <20251103134533.GA23818@lst.de>
In-Reply-To: <20251103134533.GA23818@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|LV8PR04MB9147:EE_
x-ms-office365-filtering-correlation-id: df8b4bcc-5c80-4fd8-b5ce-08de1adf8af1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEJSN0hWUjMvbFRYT0toeFVqeVo5L0ZDMm9LcXpwVERPTkxuRG9jeW9LUmln?=
 =?utf-8?B?dTZEazdKZG1xTTU0djQ5K09QQVl5YWhGcWpZK2JxNDhnU2ZlQ3FjQnh3TFJO?=
 =?utf-8?B?YUtwc3ZjMUJzWUlqdlpJWUNIendHNXlzWlptNnBRQVVMVjRmY0tBMWNDdWEr?=
 =?utf-8?B?ZldwTEk1Q0d2QnRPZXVseFpQcmk4blZhczByNGg0c2MyN3loNVVEbDNwb09a?=
 =?utf-8?B?eEsxa1EwUVJlUEFubkU4dzY5b1V0eU52NkwxWkhWdkthV1NUbXkxL2gzMCtQ?=
 =?utf-8?B?TVlqRkJ3S1lGWGtxZWhRZnczUzlEOVhNQWY5NlBMZFh5Z1hWbnVKYnVFTGVs?=
 =?utf-8?B?U0lxNDYyakxjRlJxdWIwemxTaUJSc0xEOURFRkw5V0xGcEZpRTNJUDFuNmpx?=
 =?utf-8?B?NEV6UC9MQU9USDR4UXc5WXUrbTBKY1BXc29UVVNUSG1WczV4NFhqc0IrZHJK?=
 =?utf-8?B?SHhRNlo4NEdjQUg4bXZEenowWmtKVFAwV0E1dEdVd09pUjRxcCtsNmV0NmRY?=
 =?utf-8?B?L3dHRW9BSEVGUTl0eThJVVM2YXpLNW5Pb3BLYUsxcjVBMXY4TkVENFdqRmht?=
 =?utf-8?B?U3Y2YXlCOG5pYW91U2pJaWVrNWNldHZmajlnSzU4aTFwT0RaL0NvQVNjK0Vw?=
 =?utf-8?B?cVQvU1RZUGh4TlRNdjAzQkhDb1NxMmJyUUlCTVNzRWxlZDZRUUNBVUJJa29u?=
 =?utf-8?B?NVlic3laMWVRdGNicG1pcWFIU0xqN3VBVXgyckxiRzZkWWREazJEQXlSdjA0?=
 =?utf-8?B?bXNsdTdUL2dQVUd4MDhhcTY2WUlOUk8xeW9YSGg4bXJ1dnhCM3hlN3ZjSTFB?=
 =?utf-8?B?Q0pmSHdGdVZIeWttdm04QXZIL2MrUnllcGc0b3F0cUpGL3dXazJkeWt5bWVD?=
 =?utf-8?B?SVBieGEvY0lYWk5iMEhNRVQ5S2lMbWNncERlaExOT0M2QjhXVTl4TU9HZ3B6?=
 =?utf-8?B?YTVYQ3JudzRRUXY4dkdlN0drRmxmQkkyWjdGQm5DMlJOMU1Jc0hUSFM0T0lr?=
 =?utf-8?B?bXNkcjRFV3hsd0dXZnJQcm9TdGUvaC9WVVBLUzl6NWMvYzN5aHIrVlUzcmNJ?=
 =?utf-8?B?QVNLa1lvQ3hqMkZPQk0yRDgxZyt5RW4zOVNiNVpBaEN0azFOcGQyYkVNeEt2?=
 =?utf-8?B?SjhORHFPRmNpM3BoL1ZISEEyQWkwQzJGaEVaYUNXRjFyMEdMemtGL1dBbEN2?=
 =?utf-8?B?UTFkUk5vQlVrY3lMaHVKQ2dBbnRQQlJQS1FHN3BzankwWGE2MFNqVG9uNnJC?=
 =?utf-8?B?N0JqQVBkVGQzdlZlTHpxVWZ3cTV0TlZXNmZKeW9XWVlhd1dIWmxHWTA1MzQ2?=
 =?utf-8?B?cnJuRnFFdzNUSEhXTHREckR4KzZjQkhYcHkwWUwzZlFZZ1FqTUZkTXdOT3Vv?=
 =?utf-8?B?c1ZuYUZHZEFZdklLTDlHS2YrTnIrOGx4TnE1TFJ4Qm4rcCtYVUJSTGt3dHMw?=
 =?utf-8?B?b3hMWXZEVWYva2hpWFdONzNMOC9FYXR4K0piandiRk5kZ1htOURrNHhCS0h2?=
 =?utf-8?B?M1JuWkhUeVliS2h3TmxjZE14QjF6R216a28yNHY1NkNaUmxYelg1eHNmenhU?=
 =?utf-8?B?bkZmcFdqbEc3NEFBRFBrSVRtZlJ5d1BPQ1UrQzZMcWp4MUJERW5RUFh1N2tM?=
 =?utf-8?B?cjRaenZodkM5VEtkMzJHajI3K0E1cXE5Q3NSMmMvcCtFYXZ1S3hxSmo0SVJi?=
 =?utf-8?B?TVdKbmxGd3RJTjJTMXB6NHlKdisyY2dzNktYL29Zd2FTZlhvMCtQUnZrOEFt?=
 =?utf-8?B?V0FlSEtKY2F5WTEyaUNlU1ZXSkZyZEtBbFNOT1FDWE9xVkYxZENpNmN2K0NS?=
 =?utf-8?B?TFNObzJoUVZFMjU3cXlTNWdCR1Z1YytlMkx0M3dXU2Ixak4wY3lGY3ZWZkZ1?=
 =?utf-8?B?ckZTT0pPSzdRTnJpWENOanh1a3ZWSDJkNi82N3hEQjRtQWpqUFBqY1NhRFRJ?=
 =?utf-8?B?SnByMVdza0pTaXF6Q0JValNTdTJjY2RDOWlPempSa3JaNXM0cDI5T0tnSys5?=
 =?utf-8?B?c0x5aHJLeWl2ZlFBTlkwTFlKdzVBa1daYTV3cEYxUXQ4dVZWb3NpOGpHT2Mx?=
 =?utf-8?Q?MWl3Rn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2pBR1BXUjk0dkViY1pCMExqNnQxTzZPNFV1bzBGVFNnS1JKWWhRNzF4N0Fn?=
 =?utf-8?B?ZTUyeGp0UjJLRksybkZ4VU8weXJjR1FRaUdVNTNVc0VKY01FWFN4Yjc3TjdV?=
 =?utf-8?B?MmFkRGtIT3lCSThKdENNVnhDdU1yMUlpVUpic1pYN3gwanZUODBVT2dna3JR?=
 =?utf-8?B?MktRaXFtU1dwUFVZUmZJZUI2OUw2NW9OOVI0UkQ3VnJYRVVuZkg0QjBhVStE?=
 =?utf-8?B?akVHTlRsbE0zUHhhc2ZQQXdlZ0dlKzd2U3Myb1lJM3owdDFMbFRXbVMzUlpC?=
 =?utf-8?B?R00yQWNjZmcxVGdaZURuRUx5ODNNY3I5a1hNYUFxRGV2WjFkZnJ0ZmVmMlVp?=
 =?utf-8?B?c3JNYW1NQUtXajIxY1ljbkdMTmg5Y2tmeHd5TlhWdXg4VmI3WGVWMVppT1d2?=
 =?utf-8?B?dVFIbDYyOEpoUCtrRHN5YkFyY0xDRys5TWEwb3h0RmN1MFRPSnlsRk81WFBv?=
 =?utf-8?B?c1VUNy95ZWxGMHNQVGl5WDdJTlRJUnM5WXlGQXRUbDVXUlFSV0srZDRxNml6?=
 =?utf-8?B?OHpBMXJMdFdvV25sU293WmRoc3ZnUGpEdCtOZHV0ejVVbU15MkViZHYvOGFx?=
 =?utf-8?B?ZFVXb3ZzZERlTXVmRjIzeUJYTnNDVkxTOThoK21PRnY5RU92Y0NubERHbU1D?=
 =?utf-8?B?NE5rbEVKT0pkMDR3SjNyak4wc2p2alk1SGYyQlBINjVJSitjUUVxRGwzQ1RZ?=
 =?utf-8?B?U0VDZGxkd0QrRVdEMll4R2pBdEdYODZFVlNBWUY1eW92d2xsWHl2UFJaV1ZJ?=
 =?utf-8?B?WCtRcGd3ZDBMNmpjK21KcVUwbkJMc3kzbVFieGUyMmlGT1VlSG1VcVlQZFB1?=
 =?utf-8?B?TkVFN3hIVUlVaUFjZ25wVnRGc0ovTXYrUlQvYldhaFB1OXV0OFQ4TWVLOVdn?=
 =?utf-8?B?L2MycDQ5UEUvUnlyT3FSNnozSFM0NG9mMXJZZ1FhUk9pLzIrWDFLQ1lvY1BU?=
 =?utf-8?B?cnlvaVUyYWt3NE9EQS9YV2w0RDdWNkM0Q08zRjRvVWYwMW1iT0ordUEwRzdC?=
 =?utf-8?B?SkNMVnhJQ3UzSzZoQkRHc1Voa0swWUVmWjRlc3pNZ0ZkeHA1Sk9QQnE3MENq?=
 =?utf-8?B?cGVsMW9hZFVqR3RUZldwaWZiRDRrWmY3S3pnL0dXTXVVMDdJUFR1N2V1bWdk?=
 =?utf-8?B?WmhmYkZRRjZ0c2VrNzI3WDUyRGlDZmxESEYyZ1NOcUp1YXpycWROYnRYdWtJ?=
 =?utf-8?B?dVo1NnhGOWNjT3NIZ0YvWFBFckIxeEwyR2R6ei9BRmhnQlJEYkNOeEdEcUZl?=
 =?utf-8?B?R2ZxaDJ0S3kyZ21YSkluL0xnL3FBV3RoOGdxWStxaWhBYnI0OXZUWEhXM2hp?=
 =?utf-8?B?Y20xR1lnYnczb3NYcVE4R29yWXFlTjgxMktYVjRiWmdmVWo5aHM2N2hmUDhD?=
 =?utf-8?B?NkZWQ2h0aEg3aFhPWk1RUDBndW9BWWIyNGl4TkF3dFFBS0JBcUlSVnFFbUZR?=
 =?utf-8?B?dVFVUW1oaU4rMVpHVUFGNW1udjVRR3k1aXJxUy9HRlUwVmdvR2VnaElJdnI3?=
 =?utf-8?B?ME9pVFVwUTUzUEw3S0gwd0RsQzFjREg5UXp2M1UxNVVWR0w5cW8zbWdLcjVY?=
 =?utf-8?B?SFozNVE3OGFNOXBqUjlMa0RCemdMNUIyaER6VjBqcDRzaE9kVDJNOGhOOXFp?=
 =?utf-8?B?SFZTKzc3d3RrUHJYQUpIMWpVQ2tlKzllUU80WmtnS3Q0Qm5QYUZLOEh1aG9h?=
 =?utf-8?B?VzdJZDcxT21Jc2xiRGpKNW9hTnNWS1BkVVltNUN4M0RpdXQ1UU5STHdrSjRh?=
 =?utf-8?B?Q2dGc0pYdVJOVDdqQ1BNRGdFNmVuMzlKVndSOFZyUW5odnNUZytJTFY5ZmV0?=
 =?utf-8?B?dTdwTkkzdzdBdDRKTnEvb2FqM0FFNFp1cWtrYWlWaU8xL2E0aFpRSGN1UTNy?=
 =?utf-8?B?d0RTcERORVErOEZoaXFHdkoyZ0s0VWlyZU1lUDJoelJ3Tkk5N2FKeDhyNzlr?=
 =?utf-8?B?VGlKUmk3UVFUbmdYME5USndOaU5TS0Q5STBTTGVrbXhicjh6NjBSMVBJMmFu?=
 =?utf-8?B?TCthSWNNUGpmUHN1d0kyNGs1dUJsRndxczQwK1lkRndoNXJrZU9GaVFYVFlI?=
 =?utf-8?B?bmgwb1ZYbVVjUmtjbjdEckFGVEFUelpqZEF4OHN6ZEt4dyswaE1rYkg5MXY1?=
 =?utf-8?B?dzJ3SGJnRzFqSENDekFuOHducFhmTG1ZRnBlcy9LcEx0UG9zdVAwcWtTQjMx?=
 =?utf-8?B?UjAzZW12QjhoNVhpYUJOMDV1R1QvQWpzbU9oWWZBcVkwUlk1VElETk5MT0Nj?=
 =?utf-8?B?NlJ0NU44N3Y2WVJDNUR0RWJhWDFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16006000A293F047AFB04E3B0B132BA9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g4w2dQSIzxERFkd4rzt2twTVBDD8XXOt7Qd8jxnxC2+FyfXvNG/hTHUwSzcrXIXfuAqY3/CtNaMxWntG5I1RV7PcT4+IPjTHblt2A7uk6cuCyKXcHB6GMRsSJZAYToQP42ydfZQMxCtHZRIEBPjCh2Cj+kEvcrWNvDaofnuA9GeCjiQeBCYCF/1UEJ3T8X2hdkWcgJytXFW6qgwvY6wiQ2IQsdUuMjxLoZEwDtRLoeqvYhfE+tc3kJGvXWGK6dykqv8+74q+stRFStr5pf7cxeRT0gZPeXBrWRBRapQJX6Q6GGFS5t7XDMaDHDr/ha7LBiNdYKE1wGZr/tywqmxvQ332aH5CWQ4Lr+mXgpWYvdaZkk7kVXv1TEln7aOKF0MqsQYS2/K709VIM7HnkF8uFIFz/eEuBkSGU7vVDuUHixNhvGM6Za3923QaNC2xpQNd+7tJ0rqmLWZKMh/D03MtmTtgbHDpHQAniWHhFUGLUO7/5sJ3mJonm0GmDixOt9IoTq9OrTUvkHAQ2ABl/WDG8Fi2rlkeZd99PDBDbgT729TwdE6Y2I3TzakyMRqbs8DJKYQZ+lwRU+tGjt6R8/BS2NdpDGK2sy/Fqq/N1f/TxxJesdZ8q125O3cdBwpcssaY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8b4bcc-5c80-4fd8-b5ce-08de1adf8af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:47:34.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaRBkZTkFyVtDCgEGIsAnzygO7assFaKEsY77y/hKH100o+FYlvcszsY1ifKC8bql/9gwoA482n+cytQUg6pvAst3JZwWFHLnK0+GX5Nf3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9147

T24gMTEvMy8yNSAyOjQ1IFBNLCBoY2ggd3JvdGU6DQo+IE9uIE1vbiwgTm92IDAzLCAyMDI1IGF0
IDAxOjQwOjEwUE0gKzAwMDAsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9uIDExLzMv
MjUgMTE6MTggQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4+ICt2b2lkIGJpb19pbnRl
Z3JpdHlfYWxsb2NfYnVmKHN0cnVjdCBiaW8gKmJpbywgYm9vbCB6ZXJvX2J1ZmZlcikNCj4+PiAr
ew0KPj4+ICsJc3RydWN0IGJsa19pbnRlZ3JpdHkgKmJpID0gYmxrX2dldF9pbnRlZ3JpdHkoYmlv
LT5iaV9iZGV2LT5iZF9kaXNrKTsNCj4+PiArCXN0cnVjdCBiaW9faW50ZWdyaXR5X3BheWxvYWQg
KmJpcCA9IGJpb19pbnRlZ3JpdHkoYmlvKTsNCj4+PiArCXVuc2lnbmVkIGludCBsZW4gPSBiaW9f
aW50ZWdyaXR5X2J5dGVzKGJpLCBiaW9fc2VjdG9ycyhiaW8pKTsNCj4+PiArCWdmcF90IGdmcCA9
IEdGUF9OT0lPIHwgKHplcm9fYnVmZmVyID8gX19HRlBfWkVSTyA6IDApOw0KPj4+ICsJdm9pZCAq
YnVmOw0KPj4+ICsNCj4+PiArCWJ1ZiA9IGttYWxsb2MobGVuLCAoZ2ZwICYgfl9fR0ZQX0RJUkVD
VF9SRUNMQUlNKSB8DQo+Pj4gKwkJCV9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9OT1JFVFJZIHwg
X19HRlBfTk9XQVJOKTsNCj4+DQo+PiBXaHkgY2FuJ3Qgd2UgY2xlYXIgdGhlIGZsYWdzIHdoZW4g
YXNzaWduaW5nIGdmcCwgb3IgYXQgbGVhc3Qgb3V0c2lkZSBvZg0KPj4ga21hbGxvYygpcyBwYXJh
bWV0ZXIgbGlzdD8NCj4gV2UgY291bGQsIGJ1dCB3aGF0J3MgdGhlIHBvaW50Pw0KDQogRnJvbSBh
IHJlYWRlciBwb3YgaXQncyBraW5kIG9mIGFubm95aW5nIHRvIGl0IHRvdWNoZWQgdHdpY2UgbGlr
ZSB0aGlzLCANCmJ1dCBJIGd1ZXNzIHRoYXQncyBqdXN0IG15IHBlcnNvbmFsIHN0eWxlIHByZWZl
cmVuY2UgaGVyZS4NCg0KDQo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9iaW8taW50ZWdyaXR5LmgN
Cj4+PiBAQCAtMTQsNiArMTQsOCBAQCBlbnVtIGJpcF9mbGFncyB7DQo+Pj4gICAgCUJJUF9DSEVD
S19SRUZUQUcJPSAxIDw8IDYsIC8qIHJlZnRhZyBjaGVjayAqLw0KPj4+ICAgIAlCSVBfQ0hFQ0tf
QVBQVEFHCT0gMSA8PCA3LCAvKiBhcHB0YWcgY2hlY2sgKi8NCj4+PiAgICAJQklQX1AyUF9ETUEJ
CT0gMSA8PCA4LCAvKiB1c2luZyBQMlAgYWRkcmVzcyAqLw0KPj4+ICsNCj4+PiArCUJJUF9NRU1Q
T09MCQk9IDEgPDwgMTUsIC8qIGJ1ZmZlciBiYWNrZWQgYnkgbWVtcG9vbCAqLw0KPj4+ICAgIH07
DQo+Pj4gICAgDQo+PiBBbnkgc3BlY2lmaWMgcmVhc29uIGZvciB0aGUgaG9sZT8NCj4gQmVjYXVz
ZSBpdCdzIHJlYWxseSBqdXN0IGFuIGludGVybmFsIGZsYWcuICAoU28gaXMgQklQX1AyUF9ETUEs
IGJ1dA0KPiB0aGF0IHNob3VsZCBnbyBhd2F5IHRoaXMgbWVyZ2Ugd2luZG93KS4NCj4NCj4NCg0K
