Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47E26E6F4
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177222; cv=fail; b=ULjxci8293NJYSdSLzCnPKa+H6kKa0J5pCCXI0+CsfHNwxggv5Wg909ymbFPnYmDqvPrRG/1GM4Vqaqg3/p2IHAncmDJ4Bf7OHCTLtS1+HuRKcYUsMBS0ebDaWiojeiD3jHMJa5Vt6EqU9aI6hsgrhrbNVokWPzLyJqgU22t0ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177222; c=relaxed/simple;
	bh=St17pXaE0OErO4x0EN3IwIz2AR0zd8HEJl9ymXBwsAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8iU5G2SdE1/WyUPPkf0PhMDEAR8cHDeBgUKrZKgnutKJlRTXE1JuDDudVFPKazsEo6GHEh9cMk3zzYZ3zrD5QAzFgHW/l31syiJvvNM6SlkPHb1vgUFnn2tFoXObQMdSZdnv1i+TvG303uGE4M4ovK2M8RioQ5+W6Sb/TuPvBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VYv4Grl3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zY0+ff8L; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VYv4Grl3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zY0+ff8L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762177220; x=1793713220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=St17pXaE0OErO4x0EN3IwIz2AR0zd8HEJl9ymXBwsAs=;
  b=VYv4Grl3UNIZKn7zdocRMTl6U/lR3QsgBNw7zkHu0s7zNwyIh81nxQEr
   GgUlXh36U64K47pE9Jp3e1WavmFUsvnfugbk1+S3MsICwpTWcUV9eghGK
   7FeIlWAmbS8qULKDvV+h4Y4qVa+G8ej03WQTpNKHSC5wxJlCisFGSoYr4
   ewaXuIcY8PrtCCqu7zR26WFoU5UVtCJRZm2/CnhspiDU96NexqAIrzC6J
   KUUIbpUxhgbkpLlQOojtrPYwDuVFD3Tx0bXTz9oOaBkh9zWoQt2iQuQud
   SW2fpQ8Epydk6/GqS+jTQFHMf4KaiwzUqKoAeOwMpYayMT9veHAEYUl8d
   A==;
X-CSE-ConnectionGUID: 4th/RilnT+2i1KWowawLyw==
X-CSE-MsgGUID: GxGM4DuOTDuphdcFsRTwRQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="134043487"
Received: from mail-northcentralusazon11013020.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.20])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:40:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYiZJsjJq8AZPho/xYCySIi1dCreadeNgzWAIzW9jXmzjE4ZjauGuQiyZeXgiv7Fvi76Tr4QG8yiSRL8omsbmw1oN1thdAXqg6afIUtRKp12N3+sknUfNS8rmXRyRKRZ8RxNNbbm8UuInLwlVjOtt7ccx1w07DIQXYvVLObXwEfdKriyOwsqoZ2iEniw06ZZobRF4qEZJ274vaYQrL7XVd5inaw64D/vVFOvTFfOZ1R5dXKnVWEf6e1tJD3O0lSdCGTat5c4ba1BhGRnj4F2uInyTmP2PnQGeqw/zH9ODD2Pz+QabdsW3DS6Gj0225PFgrqRJCziYvgdSEM+uBuI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St17pXaE0OErO4x0EN3IwIz2AR0zd8HEJl9ymXBwsAs=;
 b=IGlBK/GGs9R7U7ugXWtTRkbgQwBELtO9iY/JyeMcw4TEhih0D+nJKlD4g4G2jVH+Wle0LU0jc8ULIK3LLX/zf6f5KTt/l4jczMX1RS8xLqSfbhoKzQenMH/g8C96eqKun0VYJSWj/VpGQCBUkhX1foApQJpPNhVsqLaTA8Cb51QlUVnwU0tkdKHkeYG6f9A0BrLlnIpw0ROAn3vBffrH7JKL1l8izt72kTJUDjvd8EUG2ssUsRPOCCpb4T2Dm/VMfmoyjznXlQOgfqRauwrD/bX2tWhb3Mg6qJxneHyLXZKRwxpgZ/ojM8EbQnEQOUVP9J4qSK6bwjk+zLqGPogb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St17pXaE0OErO4x0EN3IwIz2AR0zd8HEJl9ymXBwsAs=;
 b=zY0+ff8LhlLD4P3EBhXoQ9O5GaEmAgyYSQD+fqYrlUSdkop5oBuPIm1b4KtCtowO+37N7prWzLSU2wjO/KGplPRyD85GF7nqeINP9B+r7uiB6CvTnBEelfqKlI9IXypgGD8CKww2yWqLj/JLnPz9a022yVwY4tTS6IY2yz631T4=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BN0PR04MB8095.namprd04.prod.outlook.com (2603:10b6:408:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:40:10 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:40:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Thread-Topic: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Thread-Index: AQHcTKsxgrbFyvpK8k6ZMKMJbiprxLTg9WgA
Date: Mon, 3 Nov 2025 13:40:10 +0000
Message-ID: <bd4e2d68-bece-442a-8a00-4fe2d5e14645@wdc.com>
References: <20251103101653.2083310-1-hch@lst.de>
 <20251103101653.2083310-3-hch@lst.de>
In-Reply-To: <20251103101653.2083310-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BN0PR04MB8095:EE_
x-ms-office365-filtering-correlation-id: 7f6df684-05be-46c0-3e3c-08de1ade8261
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?djlwazdKc1N3d0VaSWw0bFRLaFc3dnN1SW43WmQxcTV2aVB6MEwweFFqdFBO?=
 =?utf-8?B?Z0lpa1F0bUxsOHN3d0RhNitZZ3krR1ZJSTZTQkRFL3pSeW1lM1cyejRSVDgz?=
 =?utf-8?B?cnYzSXRUWnJwNklFS1ArVFZPeldON1hzcDZ1d1JRRDRGVDBUNDZjTUVqYWh2?=
 =?utf-8?B?MkZWUkJVTlZmY2xubFJnbFBOSXFuUU01OHVDZUJpRSs1NDVJUVkvK25SUmlG?=
 =?utf-8?B?RThrODRwM1d5NndISWkvcnh4MC93eld6RjRuRXFOajFKbFJTejJrUnM0NFlE?=
 =?utf-8?B?K2xiQTAwajVKcnZuU1NTM1R1UWNHNEhwY3BFc1lMR1R0aWdLRGM1M0o5ZEM0?=
 =?utf-8?B?S2hCdE5wczhYL1FwZkpEd2tublR6RjVpcXZiZDh6OVM3RnNtNDFCMnIrdi9F?=
 =?utf-8?B?eGIwUjY0THI1a2FHdjIwOGFLRW10S3FuZzQvU0V3NzE5R1dHenowTUg5Z0tq?=
 =?utf-8?B?WjhVdnp4ai9SU014U0taQXh5b3hZRXNJSnF3eUkrcjdzWGpEMFcrWkp2UGtR?=
 =?utf-8?B?NHh3bGJCSDhudGJscndrb3F1K0hpSkU3UzNTSDIxZ0RiWkYzZUV5Qm5Ec29t?=
 =?utf-8?B?TWhoUmpSSEJxaExGaExlbTloaTIyUjFMTzJ1RVNVTkFpTlpDakNKMUREYldU?=
 =?utf-8?B?TGZUMzhzTE1VNFlvOEJDaTd3bXFvQ3hzMklCbTFmSEtGM2lOclVWS3QzdXhl?=
 =?utf-8?B?UEpWc1RPUFp5TG5PYUhZd0R5WTJjUFNBSlRseG1Ra0JSTk1rdlVncDlGU0Yw?=
 =?utf-8?B?RkNwKzJsQ0tJUktEb1dLblZKTE1IVlFDcTVWVUIxNXppMXh6ZHM3Q2FIakNz?=
 =?utf-8?B?Vm1EbFduNFRoUzhjcEV4THZnUmVDTi9Uc3BVQmpXY3ZZVXRyUzdaQ01KZ3VN?=
 =?utf-8?B?ZmZONFVkcjZHelFCY1pTUG5UL2hEVSs5WmZiRFhNVVpyUnVlbnA0bXlKNWZv?=
 =?utf-8?B?UGJya0RzdXI3T3NlZVJJbDN4R2lsSWw4bE9tWXA0dUNvK0h6S2RDVFdFK053?=
 =?utf-8?B?T3BCaGtZbXJsbTVDKysrdTU1aW16d1ZKTnhNYXdBUW5VOGk5YUNtQ2h0d0ts?=
 =?utf-8?B?Z21BWTN1TFdLclUxdmhUUXR6NzdWRU5vVzhKQy9BWElLb2swcloyUFBsQ2VS?=
 =?utf-8?B?VTE0UU1rekpoWHV4akh5cGdFbVpUbEhWYkJFd3c2dHowQm94aWFyMVdZNk9N?=
 =?utf-8?B?U09UZ3FJWWEvOWsrTjBURjdGM0t2bWYwbjJGbEQ2b2k2cjFkQXVsVDNXdUZQ?=
 =?utf-8?B?Z2M3Ymg0TVFId25HVlBEclluVVhPMVk0NTlBejlud1hiaW9WQ1Y4c21VMnl2?=
 =?utf-8?B?VW9JNEFUbXFxYVhWQVd4RTY3T2RRQlhuQU9Hdlk2ZkxEY2VQTXBkajJCNjlS?=
 =?utf-8?B?YXlORWpSZWdySHlUejJib01PZGU4cTBqOUphS0huVWIwSDU5R1kyYm9xbitV?=
 =?utf-8?B?MFRDVTcrMjF5VnV5RTRwUHRHamlVck50Y2lSb3hCVzlQTGlwTHZhQmx3QmtV?=
 =?utf-8?B?N3R2ZEJ6Z3djOTBPMDVxNzFvYnFEYlo3RUFhSCtUc2pHbXYvdnl1S2EvVGJC?=
 =?utf-8?B?VVIxa2cwUGRmS2JiZ0cwUzdJelRFc2k5MjVLZjdGbU9TVTVYV1ZxL2U3akNX?=
 =?utf-8?B?a0lJWDNxUUMwV1YvaUlmYkFmaDFwaHdHWkdSazlzd1Y0enV1UmdLdGhHRUdq?=
 =?utf-8?B?Rm9SdHdSR2Jmb2FzQlgvc3ZheUR6UlcwK3BKZnIwL1h5UUhsNnY4VlEvb3dY?=
 =?utf-8?B?OVFla3oyaGJrQWpjWTJNa1VTbWd5T2R1azI5VDhJWW50ZWJVYWZoWmtBZFdH?=
 =?utf-8?B?VWZ0ekc2bzljU2NMQ1U1K01MU1hxUUFaMS9LcTZER1ovVDZZVDVIMmYvN2xz?=
 =?utf-8?B?OFJSbjQyNVErdGdZMzFxTnpUa2lJM0RIM2tacDF0MnZ1QTlDUG9VRDhtY3ZC?=
 =?utf-8?B?TDJ4TFZqSXpwVVB0eFZmb25aTVRVcVpnWGZnRGNYamM5RDdqQmxVN3dFbjZH?=
 =?utf-8?B?QXZya24wWlpPRU85S0s0WWNYVSs5YWxiTjZYOFFZREpqWExBRnZ1bVRobzBk?=
 =?utf-8?Q?bvdWKl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDh0ZGk2ckRjVmJpWU5mdU04S3Y5MmVGVjUralVqdFVXbzJualROOVZwdWI4?=
 =?utf-8?B?aFlmV2FwYzNxcXQvYktvUEJrTWlHdlAwa3NsV3FTaWFjSWN3NzdnLzBQdHRZ?=
 =?utf-8?B?OVdFcjNMbWo3UGMvM2lQTzFkQzFpSnYyaWdXdzNmTUwvQUdLb3RNVitRRDNh?=
 =?utf-8?B?NUNMR0ZBSytnb3ZvMEZsa095ZVI5V2Q0eVdpcHlTcTJJN2dGcVk4TGlROHRW?=
 =?utf-8?B?SXp4dnpBdUVLTi8zNFJrek5iWFNoVUtFeDhXSHNpd0JiV20vN3hScXdETVJi?=
 =?utf-8?B?dUorR0ZvVDZHb2RqQnFyKy9iNUNPUU5QOGRYN3dxd1Y0VVE1TE1xTVByd3pl?=
 =?utf-8?B?eXhnckRYR3I2eFBKK2pGWlh0cVU4cGdCSXZkOStrMjFvT0NkclFBQ0ZtUHow?=
 =?utf-8?B?NjU5NC9Zb3VjcVA5RmxTVWJmQWQvS01Xb0JTV0l2KzRFeXNHUXllMzRnSVh2?=
 =?utf-8?B?WWdid3JHSVMvYVZ6M21MdGF2T3o1T3FlT1pqenNXNlJJc015LzEyTjA4M3lq?=
 =?utf-8?B?c0pjblh5eEY4TTFGanpqaXpFNGZodUc0Q2tTNHVKR05qQit6WjlyUTVsSUVk?=
 =?utf-8?B?aXB1djNmdDA4L0ZNbVUwZjJGZmkzRFBUUVo1Ylp6TURkNE15MkVQMzNSU3BX?=
 =?utf-8?B?a0k3bHlRV0UxVkMxNGFCM01iU1NGUTZCNDJYcElvNnFMSTlOaUt4ZnhnRkxB?=
 =?utf-8?B?RkVOaTVqZlQwUFlWNGFqM2tVMGFDaUwvbVhFNDdZSjl4dFNFUXlFcE5Lc1VM?=
 =?utf-8?B?dXJacnd2UUdiS3g2QjFiZjdOYm9iQzdONWlHN2lncU1TY3JaUXJTdUR5VnhS?=
 =?utf-8?B?L2cxaTU0TEdySSs3SGNmYStzSWdkdkI3QTZaeFlGQnJkOGEzKzJjWDFzRkd4?=
 =?utf-8?B?STl0a2MvS211M1FiZ24vblZQL014OHBYWHgxT2E4MjduNnZiSjVRRTl2dGk0?=
 =?utf-8?B?T3FMaDdIbEYyV1Q5ZDc1ajI1M3lvaG5NS3M1SlovUDFQejUyczZ2OTgzN2JU?=
 =?utf-8?B?eU94UXBUdFU4SzBMZ1YrTW04L093Q0FqVmJxOEEyMkk2TWVJczJVRmdXWWpi?=
 =?utf-8?B?UkozRGJjYzRmVE1oQ2RpRnhERkZqYkNZOUd6czIwMDZQWVg2YUVVcEdrL3ZY?=
 =?utf-8?B?SjdjRmZrRnNRY3FrbmlTOFM1dnlxM3N5MXBISGNSQkFoWkl1c0srRWpDcjda?=
 =?utf-8?B?b3JUckhoNkhRd1MyeXF0UUZGNFRTZWhtZ3p4OHh4WHJ0OGxrZ3VkTjdhVEVY?=
 =?utf-8?B?YmJNWHQ1UlRlR3VNUXQrTGVqUUJ4WWNKcm91ZE9qRkhhcWlXNFk0S1l4N1JJ?=
 =?utf-8?B?RzZiR2xPNG45TkZUVkRwTDFWMkJPNk8xd2lPcjR5YVlUeXFJSjVacUJaaWdX?=
 =?utf-8?B?MldwR0o0aXRrOEVqYWJEanNwMXhtdHMwM0l1WkV2NkJkWXBzSjZDSFg3UHhI?=
 =?utf-8?B?VndhTXIxa0E3NGpqMU9YRTVQM1N1UHlnbXo2eW9iTWJRSUhXdFYzRDVoQUlS?=
 =?utf-8?B?cVJnR1pHV2wvK1ZUdUhXdmJmc2ZpOTZqcjY3SFdaeVhaUW9SdnFIcEVVdkNM?=
 =?utf-8?B?R0lxU3RhS3l6QWxBbHh5dlZTVmZCOG9IUXhzdGFmL2xIT2Y0V3RVMjV3Z0Jy?=
 =?utf-8?B?U0JaSlNFM1loTk8rVUx4WWM1YTBLWnZJcVlnTkZ4Qy9MVi8vT2V6MnlZakNy?=
 =?utf-8?B?WlBiK2h0U1RDRDloUEJzWmtLL2dKOEhFMFdXVmFWVmZReUxrbm1jellMRG5k?=
 =?utf-8?B?NGVhODBIL0J0ZU9sa2VwT3EvOWlRbDF3UkVKWU5nYm0vL1VIWWw3M0YvOVhI?=
 =?utf-8?B?RUttOVNqUTBUT3lwR1JjK1Rtam0vRWhNcWFIVVd6R1h4TTFzeTJQSVpxVHV3?=
 =?utf-8?B?VTRLOFNyTlR4OHRMNWI2cDFJSkl2ekQydHpDRnFLWUVoSFJjamkvWDhHRDl0?=
 =?utf-8?B?bnkxZFh6VkphNkVOT1plcE5lZmNPNjZzbzVMNUREeG9kM1ZUYTFJVmVHNmJu?=
 =?utf-8?B?MGF5ZlMrT21CdlcvMUlLOEM1THl2UEFGaCt3ZzdKWjBiVUNYTTNaMzN3bG1M?=
 =?utf-8?B?WndnLzNhVHNobkZPd3dTM1plSWhncTN2d25hcGRJQ1hUTkFhTnVZY2UyK1lU?=
 =?utf-8?B?V2c2am1sKzJmT2g4bXdkODBQbis0aU9LdEFPdnhtRFhxNnVnYkRMYWNITnFC?=
 =?utf-8?B?eDl0RnVZQ21QL3N4cjZkUmJTeTFsaXo3NURHOENZR29pYnB0MGFydXBSSkFV?=
 =?utf-8?B?OWFlcEdKUm5iRm9NTE93dU9Wb2dBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <617A276251F4834BA7E071CAFC33AA7B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8shghB9jLVmWHHZ7vkz1ABnDkLFvIvzSgMqAGpaVDYl/5n5WjKx/o4X1S9+ROnrGPnz/ZqcKl3pirmWrjE1zRGbSDYTpN5iA4BaKIzs2SwbsousArT6qzl57dZv0bVt5hXyPr2vMYHGS93HBgtNMMXZPCKp7inhAeIqqBBMmrXhIYAGdl8UfYLISsrtDJcl2VVVphBhrdXUbkvtJJzJcDnzTbgH5JlxwqI4amPE/U9+FzDDjYtK0f2MeTXWT49rDehDI6Z/MEw5ez0J68U5kJ1+51+RdU8vRSj1nxZSubfrtPIhYXGDGEFfjJs8FMxsaVooPkamlFXB6V5LH9LVda9Y4ETyB/lR+yMm4SJvXW4YC2iuLHDNgajFxQNIYFT/8eJ0XUZvOnUtio84NsIfczzOiUuQ7kud58xY8ZByOJXrYu7TwQ0iEYCwvfZlbfMmDMWNP7KPJM0BhCXhQxzPym4ciyBALVrECo/vt6IgevqikVqOCJo598cLaQoz4Cw6apB1LtexAJixQNWMVXRX29j4CPjfJhdS6vKR9EnWejjcI96pdw6QNj77p1Z9RoUlP4iLTDzdxSQQtsEFtMhfzQxkP+ioDyCRNKV401fbbBvcTsKlRDUBhwKzLYeFQdkUE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6df684-05be-46c0-3e3c-08de1ade8261
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:40:10.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGapTiOjWU3tvIH+ZsA6kmA8o/IGrkl5jf0ElkYNKJ5vSVGLf4yIxwWfapSD6xDigt6t2ij3STGpqp6NdUK/lPXzsOlworALSolggNWGxrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8095

T24gMTEvMy8yNSAxMToxOCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ICt2b2lkIGJp
b19pbnRlZ3JpdHlfYWxsb2NfYnVmKHN0cnVjdCBiaW8gKmJpbywgYm9vbCB6ZXJvX2J1ZmZlcikN
Cj4gK3sNCj4gKwlzdHJ1Y3QgYmxrX2ludGVncml0eSAqYmkgPSBibGtfZ2V0X2ludGVncml0eShi
aW8tPmJpX2JkZXYtPmJkX2Rpc2spOw0KPiArCXN0cnVjdCBiaW9faW50ZWdyaXR5X3BheWxvYWQg
KmJpcCA9IGJpb19pbnRlZ3JpdHkoYmlvKTsNCj4gKwl1bnNpZ25lZCBpbnQgbGVuID0gYmlvX2lu
dGVncml0eV9ieXRlcyhiaSwgYmlvX3NlY3RvcnMoYmlvKSk7DQo+ICsJZ2ZwX3QgZ2ZwID0gR0ZQ
X05PSU8gfCAoemVyb19idWZmZXIgPyBfX0dGUF9aRVJPIDogMCk7DQo+ICsJdm9pZCAqYnVmOw0K
PiArDQo+ICsJYnVmID0ga21hbGxvYyhsZW4sIChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0p
IHwNCj4gKwkJCV9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9OT1JFVFJZIHwgX19HRlBfTk9XQVJO
KTsNCg0KDQpXaHkgY2FuJ3Qgd2UgY2xlYXIgdGhlIGZsYWdzIHdoZW4gYXNzaWduaW5nIGdmcCwg
b3IgYXQgbGVhc3Qgb3V0c2lkZSBvZiANCmttYWxsb2MoKXMgcGFyYW1ldGVyIGxpc3Q/DQoNCg0K
PiArCWlmICh1bmxpa2VseSghYnVmKSkgew0KPiArCQlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gKw0K
PiArCQlwYWdlID0gbWVtcG9vbF9hbGxvYygmaW50ZWdyaXR5X2J1Zl9wb29sLCBHRlBfTk9GUyk7
DQo+ICsJCWlmICh6ZXJvX2J1ZmZlcikNCj4gKwkJCW1lbXNldChwYWdlX2FkZHJlc3MocGFnZSks
IDAsIGxlbik7DQo+ICsJCWJ2ZWNfc2V0X3BhZ2UoJmJpcC0+YmlwX3ZlY1swXSwgcGFnZSwgbGVu
LCAwKTsNCj4gKwkJYmlwLT5iaXBfZmxhZ3MgfD0gQklQX01FTVBPT0w7DQo+ICsJfSBlbHNlIHsN
Cj4gKwkJYnZlY19zZXRfcGFnZSgmYmlwLT5iaXBfdmVjWzBdLCB2aXJ0X3RvX3BhZ2UoYnVmKSwg
bGVuLA0KPiArCQkJCW9mZnNldF9pbl9wYWdlKGJ1ZikpOw0KPiArCX0NCj4gKw0KPiArCWJpcC0+
YmlwX3ZjbnQgPSAxOw0KPiArCWJpcC0+YmlwX2l0ZXIuYmlfc2l6ZSA9IGxlbjsNCg0KZ2ZwIGlz
IHVudXNlZCBmb3IgdGhlIHJlc3Qgb2YgdGhlIGZ1bmN0aW9uLg0KDQoNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvYmlvLWludGVncml0eS5oIGIvaW5jbHVkZS9saW51eC9iaW8taW50ZWdy
aXR5LmgNCj4gaW5kZXggODUxMjU0ZjM2ZWIzLi4zZDA1Mjk2YTVhZmUgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvYmlvLWludGVncml0eS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvYmlv
LWludGVncml0eS5oDQo+IEBAIC0xNCw2ICsxNCw4IEBAIGVudW0gYmlwX2ZsYWdzIHsNCj4gICAJ
QklQX0NIRUNLX1JFRlRBRwk9IDEgPDwgNiwgLyogcmVmdGFnIGNoZWNrICovDQo+ICAgCUJJUF9D
SEVDS19BUFBUQUcJPSAxIDw8IDcsIC8qIGFwcHRhZyBjaGVjayAqLw0KPiAgIAlCSVBfUDJQX0RN
QQkJPSAxIDw8IDgsIC8qIHVzaW5nIFAyUCBhZGRyZXNzICovDQo+ICsNCj4gKwlCSVBfTUVNUE9P
TAkJPSAxIDw8IDE1LCAvKiBidWZmZXIgYmFja2VkIGJ5IG1lbXBvb2wgKi8NCj4gICB9Ow0KPiAg
IA0KDQpBbnkgc3BlY2lmaWMgcmVhc29uIGZvciB0aGUgaG9sZT8NCg0KDQpPdGhlcndpc2UsDQoN
ClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KDQo=
