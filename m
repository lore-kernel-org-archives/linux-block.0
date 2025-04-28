Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAB1E1DF0
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832093; cv=fail; b=H2DSf5TAcjHYSc03722b7edUgdTT8JmnG9UMwiUA1CV1Kgwq9U76ZqWZAHUpHD7m5xoGCiIGZObQMzkNXdunEgzjkU286odX5iM8mTSEsLfp+/pqK0+rB9WGC1vBgBJQKfS3Hl2a7m7bhn8+VHIatLWU93IlqaxtYk/AAzpDsbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832093; c=relaxed/simple;
	bh=uRECoVycGVZ7leC+moBM8XEHHzGmpWDi/ZnKyh5Sv4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qcsd4OaFZZHvOKa2Al+batOEuTynB6urNU8nGVQ2LbM+sMrRPQVNL6bfRsby4+IspRQBaIw2lqhcuxxpKyOA7YkAnp8sbxE2pMLxSeb/54cjFtjUlzUz4rGBsgKv2/Zakwq80PCjrG9lhtLy4A75iMRWH63QjiKSxEK7exCwrVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EHifZinH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RgxAYlZl; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EHifZinH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RgxAYlZl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745832092; x=1777368092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uRECoVycGVZ7leC+moBM8XEHHzGmpWDi/ZnKyh5Sv4A=;
  b=EHifZinHqtPeS8O7yjAbwg5NEbMFFtyXEya2QoM3z5Q2YOlbyvv+syVI
   ntJfm9IOft21P9qJYMMi53EyJoOiCAeHeBpZLMFGX1s97GrCpN3krQ4GL
   XgpZS4f9yAY4m52dtobHFLAdtx2o4/1tv+8jRTNudFMmfC+wWJaWn9hXx
   pAjM/88BQrGvT/ltRRoz6fUQOj8C9DZ5g4mBgyH8uDFf/qDdlWLrzswim
   LMBgWTw/m6ATJSlnh9hi0uF+YHAd1XOtnJcdOB942bWs9wQbq7LIEvaEo
   u9q2pRIPhMEwEj6TZxRquqa6Gg0Z9A8AFnfMDK8KOkFZPq/ntRQ3in/cH
   A==;
X-CSE-ConnectionGUID: 7SfNPTywT0i8p6CM8vvWcA==
X-CSE-MsgGUID: gaqUjn8MQlO68xAO8hf8rQ==
X-IronPort-AV: E=Sophos;i="6.15,245,1739808000"; 
   d="scan'208";a="79579886"
Received: from mail-westus2azlp17010003.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.3])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 17:21:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEI//A20PhnnnkHoi5PzjhG+DRr2+hgSOnqflG2KLHeXBKF5InZy+lo1rpeMBzrhJPfvufvS0/M5RD+l2nj2epVx9YNcU0ql2A8gA/af9TK0pNLAmeKOq/6O/IijjSHaPkDPSnCmjJznJiL+AO20wx4H/eEdSoJOn+sa0idrudBEMubUliq7RJX4ttcByXIViRorKuMfQfodOAabgyHpLhedGDJKEGWpSzwEydRFy2pb2eSgJLBEdI9H+r+f003oK1TKwYnLnmOSWiSOfui2qM9ei9NyBO5vYDQYree55MnQR1bp5yUfsRi5r9UfVlH/fYu7MsmkIA36fJfhahc0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRECoVycGVZ7leC+moBM8XEHHzGmpWDi/ZnKyh5Sv4A=;
 b=wkR9udqL5wb9UfecwOEWZoF1frcG30Qg8TrNdeH89uXILp1CN2M5X9XHTwyWzyo0b/wJC9lIjVLTt3nho1EBii6aK88S1QWAZigWL4ZvdAPtSKnPre/MdlE8Vk9HLSLBMxd5uGzpLw21lGUV2Re1uYexnZ205Uw3MwALXIzzgqAy2REIOg4GRutDxgtd0x+FI9vUBPcYG8lwH+bzIxyWjGhCcfIFInxj9T6w/oNYhfYyv1yYxWJiUb58ed75FXOqSXdUD2/BCZJxrh6scaq/Aj+F84vYzwyfMm5dJaq6hUNNxg7bK80VtUptfOo8S2lfHq+hfioSBaEDihej+2Rpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRECoVycGVZ7leC+moBM8XEHHzGmpWDi/ZnKyh5Sv4A=;
 b=RgxAYlZlTlAZuTLinULM26lWS5kjj1abHdswISqUySJfRBMcVDMerJwPuq1CFsO+SlIsQKXzj3inUUh3GMm5JFTduyriXsR1fEUyD5XSR8j/AWfObyhwUBLsbXqlXlvQGmtTbfcX/zkxQHpELmJJ+VwNvGy5GLzpoqniz2WYPX4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7232.namprd04.prod.outlook.com (2603:10b6:a03:294::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 09:21:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 09:21:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Yu Kuai
	<yukuai1@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/5] brd; pass a bvec pointer to brd_do_bvec
Thread-Topic: [PATCH 1/5] brd; pass a bvec pointer to brd_do_bvec
Thread-Index: AQHbso7gUEAvLBWMeketWzFlY3QfrLO42LGA
Date: Mon, 28 Apr 2025 09:21:21 +0000
Message-ID: <550164f1-0965-4b88-947a-12c2a4d40a83@wdc.com>
References: <20250421072641.1311040-1-hch@lst.de>
 <20250421072641.1311040-2-hch@lst.de>
In-Reply-To: <20250421072641.1311040-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7232:EE_
x-ms-office365-filtering-correlation-id: 386a86a0-4228-44d7-24b1-08dd86360a75
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aERwbXFxMWozdm0wUFczOWQxZjJoM1FXblVVcmpzdklLdnZYUnd3RGdocEpI?=
 =?utf-8?B?QXY3ZHIvL3pLOVhKSStXZHJXd3F4ZExrR1FpbHdOYTdzZmFaS3Vic1dSZktk?=
 =?utf-8?B?cFB1Uyt4UlpSMGJjT0k2dUdhSGxWeFRrSFlEaUlJSFp0aDVPTm5ucUdZbG1q?=
 =?utf-8?B?UlVnSG1ZZnVrZzNwSVRZVStyL0JabkI0Q1BaNTNSODU1ZVdJTiswVU0xek1i?=
 =?utf-8?B?cGZGbjNHUlVaQjcrMVd1c3FUNWhUQzJUSGRlblhDbGk4NVR1dnpBdHJBdERn?=
 =?utf-8?B?UnNTS1p6Mk9HalBBS3FNdWtqYUFQVzBhdkVobk5NeTVCWHhhckwrWm5lSm90?=
 =?utf-8?B?aDc5cForUXdvNkdpZllaNEhiQWNPdGtndWdZd3pPa1dUY0E5SlFITWUwcFBX?=
 =?utf-8?B?ZjFTb3RDeFI5bS9LUGdZclQ0TTRQb3BXSzNRTjd6NkE2TUMyUVg1cFFZZjNu?=
 =?utf-8?B?L2N2QllGZGtYYXdXdEFYN0dHZ0dYZnFURnp1QkhiV1BSOCtVbmpkc0h4L1F4?=
 =?utf-8?B?RUFweG1qSEltMmtKTXROMU50RE5JbzV5ZENtL1VPU0I5U1NwNHFJaThzTG4r?=
 =?utf-8?B?eDR4dVFsZDdMc09SUjJMWiswalNkQzkvMjBJd2FjOFdEV0dydFJJUHJ3Z1ZP?=
 =?utf-8?B?bVBYODJIczYzQkFFaE9sOXkvb1BKaWhsVXhaU2FOblA2MzdaM2VsMWt5bndV?=
 =?utf-8?B?cUxSMURQWWtJalp0ZGRvOFdEVnZhUjJlUVZvZmpzeGJ4cHpvelMzVzYzNTk2?=
 =?utf-8?B?Zk1LR2J2Q2Excmd5WXZjaXFLSE84dm5KTkZ0TDdSQzNCSzAvQjJFMkxIVHpH?=
 =?utf-8?B?dzhHT0phY3M0QWRoZEhmUlBTeG1mZjl5MVo1L0p0MFVsKzhkRFlYT3paN2lm?=
 =?utf-8?B?MlU2UzNVSzF1QkpObDR1eHJ3YURiTUovcDJuQVNzVnZQYlFzbS9jTXFzb0VI?=
 =?utf-8?B?UXlhQlpSQlFoUENSSUw2Wk1CVFJDT1ZmWFFmMVIzOWk3Z3VISkl1anhiUG1y?=
 =?utf-8?B?TXBpZk9rVzQ0Z2pBYWYzNW42SU52SkRyZ2lUMkU2dmZNeXVKYllZZ09XOWhB?=
 =?utf-8?B?dGFJMW9Ka2pESzZTdWlMbUpaVW9qd0hIMTd2ZlpvblpqRUgrS0x4K0U0VnpR?=
 =?utf-8?B?Q1JlbDg1bWhZSElxZkNkMW0yVXkxQytKOUp5b09RemFZeUlLSzRZSWZjTUY2?=
 =?utf-8?B?dm1CemtFRHFuaTA0b0NEdUwxN1FWMStMTFhCU0pzNnV4L3JpaUFmS0lpcnpS?=
 =?utf-8?B?ZGlTYTdzNU5nd1VhRGtzS0EwVVBUQXlNamxYcnQzcld1cDhkRzU5aG1ZTFdB?=
 =?utf-8?B?bFl4TjA2R0JrYWQ0YnZ5Ums3RTJKTEdqenRwVXZoOEQxeTlRNHJUS0ZDNXJB?=
 =?utf-8?B?by9qeXFoa1lOdy9qYlBFcTRKcE9wZy9kNVlRZExCT2xoa2VzNzNzRkdndGVZ?=
 =?utf-8?B?cklLaE4zTElZK1J2d09yZWduMmRYWjc4alFjS2ZlRW5Dd28xYWszK1IwR3py?=
 =?utf-8?B?b2NNM2h1eTg4UDhNcm9ReGplaGdPRUJnOHNoTkd3TGtqK3NyNnFwZzMwaTNW?=
 =?utf-8?B?U3o5Mm0zenluWGh4b050WDg4MzNVNTdRNW1vWVhzdVIzOUkvWkV6ZDJSWTR2?=
 =?utf-8?B?cmgzN2FlMnRrckJDNEZRejB5MXUrTlJuZHJ5Rjc3TTFMQWRCQXRCM1RMVXVk?=
 =?utf-8?B?TE5BWGdEMGN2RVplL0F3dmQyWHQzYmVxZi9xRFdaRUg3citKblYxa3RGeFQv?=
 =?utf-8?B?bFBFSit0aWNXbVEvWjBWT2dEQ0o2ZGgxd2RaWlFlQ3V6Vk84WSsvRGxKMXVV?=
 =?utf-8?B?Uk52WGsvRmlpcG5Nd1NzZVJpakxZbE5iUkdUdWpVR3hzNGtNMEZodjNCeUtS?=
 =?utf-8?B?UVQ4OWhyRDZPam9RVVlwaGtmdlcrUkhKa2ZDcEhXd2I5MVltdW5BYy9oTzVo?=
 =?utf-8?B?NlBhWmtCN2NHQkl5OExaV2NlaEJmVGsvR1NuY0xOOEtMeWRKSk9PMGpjclpT?=
 =?utf-8?B?MGgxRVNjeG9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDY2OFRjZGFZYU5oZWFxYnlXRVpQeW9KM1RKOVpUcFduRjhIUDNPbHJEVDY2?=
 =?utf-8?B?MS9JSERBY1RWRHhScHI5R0VHVEFQZG9vTTlza3k1ZnRJdkZXL2E3V1dOY2hw?=
 =?utf-8?B?cEJzbUpOdDlHZnB3M0o5elJZVlZMVGF1NEthaFRKZHYwNndKU29BZ29Zc3pI?=
 =?utf-8?B?bjZkNG12b1RTb2U3SkpSSUw2dndpR21OaHhUdjE4NGcyS0FWajM2T2FEZlBJ?=
 =?utf-8?B?OVJFUlYycGNzOVRtcGE4RTB6THF4bHUzMFJGdk9LZUdULzNVQXM2d085cG9J?=
 =?utf-8?B?VW8yUGlIMDQ1anllb3pXeDE3TFFqRE5XeERqTzkxWEhzNEUzNDdwSE9SZHdZ?=
 =?utf-8?B?NmtGY2E4bjNXTE1lL1RpODRiZ2cvQnFTWmlkQkp6c1NTZjVrcGZsVWdyWUNT?=
 =?utf-8?B?NUtJL2t3TDJ1Vnd6bWhETHJFTGVkMCtYZ0JCVUN1MEpZSVRtWU1ISGtLa21Z?=
 =?utf-8?B?ZVJQMnROQm9NYXZGZmUvSE1OcythZG1GVlo1L3B5c0FNanQzMnVNTk1BRHVU?=
 =?utf-8?B?ZTMyTFdXQzRNcXRBdzNtQ0huQXdJRHprdGpOQ3B5VU9UYzIrZEVpQTNMK2xN?=
 =?utf-8?B?bC82akhkNWRCY2UzRlJ3WDVXNlNiRlpodk8vbXlKeTh3bzhUUVJBWm5uZkR0?=
 =?utf-8?B?OHI1L3UvL2pIdUVpRDYvTFIySHhOa3NXZHJlVlBDWURmSVlSbUVhelBscGlz?=
 =?utf-8?B?VHE4NExYb1M3ayt5SittTUlsSEdTL1U1RlNUTjQvSEpOUFFnV2ZmU1FPOXFS?=
 =?utf-8?B?U3UzZkhqbDI3QTdqcnFpMnFFa0ZVWCtMalc1aXRkTFEvb201YlgvSnlJTGFK?=
 =?utf-8?B?REUxR1Nxb1dIdEJwSThCM2RBTzQvODZ4ZVQzcnE0dW5DUEdqcGp1cTBtSnlZ?=
 =?utf-8?B?M2dVOWJkNzRwVG5uZ2U4YlZmbmVkNk5MR2pZenNIN2p1N2VLLzdKWmRBZ0gy?=
 =?utf-8?B?M3R0c3lrczBWZmEreFYrLzVkUHd1OFV4VXY0N2RRT3Q0MmRKeXg3N2hkOVl2?=
 =?utf-8?B?dzkycGNPcW9wMllDY1pWVEg4ZWVBUzFJbGFaZkJXRmR3dHlHbnd0TTQweVRS?=
 =?utf-8?B?T1JnVWFZc0QwNHBCeDVOWFcrN2hhdHVhV2F3emxZN1dvaFpuaXNpVXVvMldV?=
 =?utf-8?B?RDgxSG9PdHlDdFZUbjR4RkVJWklhS3VuMDRWRWR2L0QwZHdINU1xRHJHVmxq?=
 =?utf-8?B?NEFkQk5KNDRvWlBFYXhMM05ObEVzQlJ5WVByM1k3UFVVaUFZbGU0R1JrdGVn?=
 =?utf-8?B?SWhoWHh4NkpwUVJ3WEtTOFQzMmR3dXMwSjhLUmNNVTl3RHVRMkVkdG5uTjZD?=
 =?utf-8?B?OFU3OExpUklQaTFYd3hHV1ZXdDVWSVhvcmVCU1ZQeCtUbmZxRnd2TzZlZ3hV?=
 =?utf-8?B?SjIvc01IOGQ2dUdYLzZ4cERsTVlpZHc2TXJKS0d4ZVZiSm8xcWNhUUtGanRV?=
 =?utf-8?B?N1FkS29CVHczVmM0bEFFcGxJZnlPOUdueHNFZHJHZkdvdFBTbCsyU3pFUFdK?=
 =?utf-8?B?M2I4ZXBZMmNxQzZtWlNYeUlxV1diUjVyMnI1bzJpSFF4VmgwTEQ4ZlJ0NzBm?=
 =?utf-8?B?aHRqL2JCT2pmaUlMT3gwOHBnWW0yNmI4emk3bWRmL1NoMGo0ZlJ4dEVtTWxL?=
 =?utf-8?B?L05JejR3UjRYR3FFVzNUTmVNZ1JManFWN3lSWjFCS1E0Nzk0N1FROHFpREFa?=
 =?utf-8?B?Y08ybWFmc0JXZm9jRW5vc0k2Q2dOeGdGamFBSFJFQmV2d1lUM3c2RWFZdEN4?=
 =?utf-8?B?MEdhOUF2U0EzdDZHMzhKTGZsUVZOK08zYStwRVdTZXpoTkVObWRINGRuWDBm?=
 =?utf-8?B?Z2RwNzkybE1wUk9sWmhSb3hyMndiMG1OTG5KY2JOM2R6UlRBWTliRFFnbHZo?=
 =?utf-8?B?R2JoSDNoQ3JpN1NHczVackFFdGlMKzZ2REtlditadEJ1S0JDNDd3MklkVHIr?=
 =?utf-8?B?YmNma1E0NEE2N0d3RTZKL2pQMkNVclYyOVJ3Rndsc1hEOU9oNys1WDl2SSs4?=
 =?utf-8?B?aWNVclludnR0ZHhKY21majZ0Y05HRnJPSjUzTk1pVVhnaWZUQ2dsVlAwekE1?=
 =?utf-8?B?Wm1sTnRiSjdTWHBkN3RqVWtxak9zWE43SndIQmtZVUFiK1lLVXRKVzlXT3RP?=
 =?utf-8?B?aHl4emY1MGpxVmlPQzVRamgxN2VFVUVWZ3BVaFJycTRMOExxR24wNlMweDM2?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CEFDF555209594ABF04470ED493F5C1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5RnioF89l9FcEK/phVqVpQmHJz7ZBSS2P4vcZ81WF7lx2IbSSqonyyUWR8Da+wzp6S4XeJoWwex0+X4Wm9oPKe2+7hnfQRWT0i6Cp8qwFbkJ5wstflqrx+CS56mPm87SPK194Vm8sxNEHWL699OEOm2dlkogTyFhqgOsD6/8xUpXXue/4LKuLE/QNCZPP2rsKDr8buyx4Wlfe0P3CikwcWcXUulCOT7m4FANqyQFqtydmJ6IEjtJh0CY4eNC36EauYKVzkzw24irTf6/xTUW1sX5feYL4C/dJ1+Ue6H/7kT1pn6sLit3VzMEnlKl6ESl7Ns1MLF5iGy6l1tY6uenTHHo1WEYwT+MMgnYumPsOphiolRfHYfahkLrM0xB+txuD8jk6gvp6WVrsUkZZjsuwpxjkcNcNzHpFC06AsALQAom0vLwGT0fMwBXk1uBirr2K+MUPF4RdDxOoikTVCtwAMay9sEgKZ9R5aDeVNckyHnwKAGCyuLDNOnPp5zGULIy0La2+nUiZg1wTEhGTGkjlBWefxNAtEJj5yI9qVmM1PJpvO3pAEHwqIoNs2GdjYzAO1uZZn8jdlt5YD42jHNPP7alEnVnCR8A3z+p+QbX/dym96j08fxJiCi3MsSbmSBR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386a86a0-4228-44d7-24b1-08dd86360a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 09:21:21.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvHdckSxOBzdi0VugtbG4R5Ceu7ylLy7ggnxuUwkE33jnDCT2WUH1AudA8ZXRkiMHdUEwdJfxbmk8BVKzqdc/nijObY297N8Qa8asNFaORc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7232

Tml0Og0Kcy87LzovIGluIFN1YmplY3QNCg==
