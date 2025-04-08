Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093B25F79E
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098723; cv=fail; b=KAH+LNK+ZrTA6nwDe20xVY+wdoR9iu/UHiElLvVan44OVxYKhaIdLpfWq+DAJJxBv6tJxKSi+3wOMsEOmiTWnnSjxkwWxfKiCeyqH+6zFn8XDebQbzfqbwPns+xv/U/qXi8IZ14c8uSGJ73HTVMGDIxd0Nq2b0LqK7+3WwgXOxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098723; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WwJqiIEbUq/ZujicQc2LDbWcDGaKP1Q6OOvGqG9dBI3Uh8mAho7E4bMP534twV9fJVDybKY6emYKmb/e/qeszunke9K7Iqqf7MXE/UQO0I0XY2slnbU5Z0hw86L0/eAJhjLVH2yvWJrtV12GIe+moXHNhuFBw2xI+LKnq1CeBzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fy7vQ/RO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ov80R1zn; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fy7vQ/RO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ov80R1zn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744098721; x=1775634721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Fy7vQ/RONmoLxBkiUk8fD38Ekd3ZLE5MIOA7NO826PsvRTKsN+LsOQB4
   Ki03eeTSVm9LX8ICXPG7iSCXy6JopW6l9u8c/YTvhbNjcKRK3oJEQxD56
   HKgkbYpukNETjLBRyw9fPiLOdr3eGehiaelN7FQyeqcPw7x9SUgBt3fyu
   NMQNcQKjt195DM7XxvI63ar/DgYgYUGGbciTmp4dqjLsPK3L9VTJ3zsJe
   CVtVWSKOiHaqq4sybNVoZ+1ZybDjUsdpbX+uIiti7mZfVWRXt+59MFhdw
   L8UKiq0W9+qb5Scu3rKZkdwR13prYna7M5rIwNCwAeuA+XwXF2c1/SzrF
   w==;
X-CSE-ConnectionGUID: fQOB3a4iTuqetXyEI5+fzg==
X-CSE-MsgGUID: TOB/6VkvRHiYSdKlQl2aNw==
X-IronPort-AV: E=Sophos;i="6.15,197,1739808000"; 
   d="scan'208";a="72967040"
Received: from mail-northcentralusazlp17013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.62])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2025 15:51:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXqDuArUP6tkb5yqSJBzSnXsJ47M12Ky4XuIZ0QihaOgWeAY4o629tiJ9t9nuAAz3sIU0D9m18lV8GilCgXiR23QKKTphw0s0xHy6GNm7KZp0HvzGLhaPsDGJyGkLy/MkXqr4s+K+TVyNyRY9BfLEJinNV+S3SLria97iBQAfQcFm8MhvejjgFCwZZ3m/1kr/96Hcuk3Ytq/QK773Qa1G9Xj3PtRK2LBOoOjykwfMD1iu88Zhf2RydW8xxJm7KUpaVkh1y0DuOS/S8KsMp7RA4er+pw0GLdcu9aYiYRbaVRbMhK828+SMj54ERUzcHDiKI7ckqKVNT77r1KGsj6PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FjYvH9d+nVusCeKQdU1O5LM40lvQpUxAonXPE6hMDRvuxKzHMbfAA9sRx5wZAYeLsIBPApp1mvExKWjuriuRkgx2psPJGO3Hk41T5SswIwNp/xwFED3iYJ34c37DFt2PF15KLUiYpTZZu2vO+mi7d+O1neiYMUz1AOKqAkkwYIMHSj9syBtNkggSdindKGs482z4tX/0HguLrSPXCDzIUQ7O3asJWHNV+TKlvnBwAs2cr67fxC9TsfkJRXpnSvdjZNHINlsw2OoK8f9l9k4OznlcKb0wp4f029BlNqKI4fHrFaolwpCzFT64qOhWaTbb5+Co9SkbyR0hE4NHDYQHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ov80R1zniSV/YuQ0MtZ3QiUh3kA/l5EHpyCKZ669hhclO1hckvTwmEPuskJnXVQ3CbVxFfACLq+eIQ0CcYgqJ3adwmOhWpqhxKGb7MR2+E9b2ta9tn5lhLl/yBVEPM+6Vn0/SwkKr4x8Omfb/V2gyYv1S7FnwdJsblF6SUzm48c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6943.namprd04.prod.outlook.com (2603:10b6:208:1e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 07:51:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:51:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>
Subject: Re: [PATCH v3 0/2] New zoned loop block device driver
Thread-Topic: [PATCH v3 0/2] New zoned loop block device driver
Thread-Index: AQHbp5LcdEhaUm5g3EeUOxh0vniv+LOZZwgA
Date: Tue, 8 Apr 2025 07:51:52 +0000
Message-ID: <2efc2648-926a-4504-a487-0877c3d62088@wdc.com>
References: <20250407075222.170336-1-dlemoal@kernel.org>
In-Reply-To: <20250407075222.170336-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6943:EE_
x-ms-office365-filtering-correlation-id: f00e2632-8b58-4975-0987-08dd76723a15
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkZpeUlNLzBaY3lzcEVqdjJIcGJGUy95YlZpNVorYkl5WEprMXN2NVZYR3NJ?=
 =?utf-8?B?SmdCK2xjRUt2L2F6Vk9YTlgyQTZYQ3B6NzBTT0JNSElONVc0Z290TDhxVUtl?=
 =?utf-8?B?MUNJZnFCOUVwY2VKL1dWbk5CUUozeFpaYXZDTUVwTzNqMjZ1TUtmVWZvbWJE?=
 =?utf-8?B?Q3lSTGFMZlhuaDNxSGFOc2kzYzMzelh3R1RNM2grMmQ2SnRQUmtQTlpYTy9M?=
 =?utf-8?B?dC9SZFR5d0wrK2hyNG9NdEhobDk3Wmxwdm01WGkrMHV4U2JCYmJ5WXZadTJi?=
 =?utf-8?B?N0VTWXlmLzFPVUd5dkpqSE9PNk9qVXUvWnRrSUtQek5LdUZXdThzdnJGTTdV?=
 =?utf-8?B?WndoMmEvV1F4MnZFTk1zUUQ4RE1WS3hrRi9LTFBPU09VTkRLcEZPN2Y0eEta?=
 =?utf-8?B?WDZQQVgwYlVSVXZUcXN5dW50QzdmYWYvenphTkpRUzdJZGZyT2tHQjlNWGtH?=
 =?utf-8?B?MnBNN1lYUXplRTdKRHJaMzNrdENrZHJvN01aNDdRejVwN1hLV0J1UDBXamxE?=
 =?utf-8?B?UDdoWmszN1FoV2FMejYycTl5c0Y3VU9tRnNrZU8xSnR5UlF0ZTl1bGlzV1d2?=
 =?utf-8?B?RVd3N1ZXQ0p3VnpWbnRhd3FKM0g3UnFIZ0dEb1hTa0tnQzk2QmE5bnQvcmE4?=
 =?utf-8?B?V2FDTGYxeUR5aTg3eFNhVjMxNnNaR05OYm5ZM2dTYjFOZnV2OVpJNEdrVDF5?=
 =?utf-8?B?bTFzTWYySFp3QVFFazdqcjZUNkE1cnIvVmQxMWpzN3pkaStUOWE4UUNNVFRS?=
 =?utf-8?B?dTZZeUpJUk5JWTEwV1hEYW95T3FDWDBXeHZXcTNqb0Q5Wk02OWhFWW1GejVV?=
 =?utf-8?B?RDBlNDJRaFdaeHNvdUh2UXhockZHbDhySWhwWDlJOTZGY243eW9IQUhwM2Yw?=
 =?utf-8?B?MVFMSXVpWlV3TVR1aG9KaWJteGZOR0pwbVBzOHpPMGQrbEIrYXhreU4xdWdL?=
 =?utf-8?B?S090ZmRucHU2QTl3UEJHM0xEOGpOc2FxL2o2MHJzQUdxWkhEZ1ZQNUlRVUNM?=
 =?utf-8?B?Wi9FYWJpVVM0Q3oyKzRHd01VK1pVcGdYU0UyL1ZTZHArQ04yNzUwVEd0cVow?=
 =?utf-8?B?dXdENE84d2YwTmxvaWUzcDBMY0pOay9zWG5hV0ZKV3BjMjRJT0MranNFVlRX?=
 =?utf-8?B?S28vRWQyUWZhSGUyeS9WYjVGbjY5NXZlK3BQeS9KcXlMSGY2ckhMb0I0UmRO?=
 =?utf-8?B?c0JYWlhBZzdMaEhCazV0WnV1S2JuVWdPZ2NseHg5R0JjRHI5SjNHRDhGOG9B?=
 =?utf-8?B?MUd2M1ExUnk3eXJkRlRwMVVXVFlmMmpMbHhIYTlsWmZKSFhKT0Z3N1g0Lzdk?=
 =?utf-8?B?d3hjRG5jUWZJSkJWY1EwbGwrU0VvM0kyYTVWZGllVTkzYkV3Nk9yUFZlMnpF?=
 =?utf-8?B?UGYveTJOSmQ3OVV0TDJRK0xkQ0VjZ255bHYyd3JERlh5elh4bC9zWGJtUG1W?=
 =?utf-8?B?clBkNndlYVIwUmFNNnNEcHVLaFJ2WUhCUkFQV0k5bDlxMXZ4TStUYXFTUkZF?=
 =?utf-8?B?VEd0OEZvTlc2dmZvT1MrN0dUWGM3cEFVNytXLzdkVWRnMEVtemhHekE2SW0z?=
 =?utf-8?B?UTdzSlVWWi9kcVVjajZJQ04xNWpBc0tyYS82OGh2TEw3VmdGdzV3RmJtUTBB?=
 =?utf-8?B?ZVNyQlErYmF4WlUxelVvSzh0ZTdYQnZwcWRqZzJpendnTXJrQlM2bFJDYWlR?=
 =?utf-8?B?NnZ6emFoTkVEM2g5VXJHWG5CTGdkeTZrYVIzM3JmelFGK0dpQjVEL3lSYWd1?=
 =?utf-8?B?M2JleXFkN1NwN3NnVGJIYWJRUXR3VWZCVkp6eGM2b2pIbHlPZ2ZURFZzOHJ0?=
 =?utf-8?B?anE2d2l0MDZ0Q1ZSQzNlejJUdDhBa3BqeS9WVE51UXk3c0xtY0loSDM0ZHRJ?=
 =?utf-8?B?eEJ2WjlPRTRqNi9CZTJWeGduYmZQcHRVdVl3a3NyMHFON2dwOVBWVmxpaWhr?=
 =?utf-8?Q?2SFBNLlCMOsRXLJE8b5jsMN+I03SM4HN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1RoZE1BV0xuK2o0WER2Q0Z6UUpGSEZrbzQ2QloreUR3Wi9XSndoa09YeE0x?=
 =?utf-8?B?dkZzOVRWQU83cUk1cnRVZVBJOGFpd1hyZFNXZC8yeTNoa0tSVjlKUzY3WlRE?=
 =?utf-8?B?M2lOaC90V1R1SVl5dGhNVk15VUNUdElwL0hWOEJpem1GTkxhZ2ZSLzdEdVlj?=
 =?utf-8?B?TXh5cHpCWnAvTE9acEFiT05MaWRod3hZZUpkU3IvTXpMNHNabWZjS2kwOVJK?=
 =?utf-8?B?ZmJtOTFTaU16VTVRMlZ5ZUFrRlpqYXdpNUpaM25FeUxqS0RqWDVic0VWVDFr?=
 =?utf-8?B?TGtVaGcyd1ZNUDZ0SEVKdE1pTHRvSlYzZCt5Ym85TXpEU2plaU5NUzQxSnlE?=
 =?utf-8?B?NFp3VGloR0JoMVA2cXkySThHaHBZQUNYY2FEQzlrZGk0dFN5OWwyVkJBcmUz?=
 =?utf-8?B?Uk9ydUFSaGhGd2UrUWhmeit1alFobmlyWkF3M2s5cTlQcHVHQUVuQnM4THM0?=
 =?utf-8?B?T1BvSzk5V2F3WklyOUVaNVdYbzNVQjBTcU8zdkFHOFBmdG91aGZvcHdiNk5N?=
 =?utf-8?B?V0ppRnNmSG5tTDA3TlJ6WllTVzZtbFF0SzQ0QitJQTFXRnhZOWVJL1lGTXpl?=
 =?utf-8?B?TGFZQzFQbVpCUi9TME1lN0JacnFZbnJlL0FoS0ZicWFucnp1YUhPNzFWTU5M?=
 =?utf-8?B?aSsyVENEemU4RUVqZlUxNFZadW5TNFZMTjgvRzdhdHFKOVFwQ0tiWW10Tklq?=
 =?utf-8?B?NHhlck9CWWtrSzA0Y0JvRDRDemN4dFgveFdCcnBnVGZCRkR3L2RFUi9zSFh2?=
 =?utf-8?B?dWtHWXpnZ3NTa1dkQUxsQmJQTXg2ckVJeUV1cUxGeG9xYnR2M2lDb1dseVc0?=
 =?utf-8?B?cFNybU9mcksrcWd5Q3NQVVlxZUc2dDh2RnZjQTRObENNb1I3RFNSWWZhZ3Bw?=
 =?utf-8?B?blUxLzZqeENIeWd3Wm80cDRoRlpmdk9hZ1RxN1hXdkpVeVJjZ1F0bVI3a3FV?=
 =?utf-8?B?TnZZdERyRFBKT000bkhpMlA3TnBFeDlzQlNsQTd3Y0FWWmZMaGsxNVovRmpQ?=
 =?utf-8?B?dElLdGVQa0MyeUJtMWtHcjJiVXdkend3bjlZVFBHcHd5Z3JlSFE4eFZEYVNq?=
 =?utf-8?B?bHlRVGFaSjJpMnJObUFKK2xBMG4zTzdGTmtOZnBSZ2ZyNndPR1QyTitlQWc3?=
 =?utf-8?B?V2U0aVpCRHZMeHY2UEpmNWFBTS8wT2pMK05WaTR0MEYvQ2luYzBvVlgrSWxM?=
 =?utf-8?B?K2VlaHhvOG5tSnRHemhtRDNxRmhLWUY1bnUxczVYUGZKOGZQdERFWEM5QlJO?=
 =?utf-8?B?bHl3MFVWeE9DN1dKMjlmZDg0azB6Sms5Y3J4REVPcUp1aHkvUzZrblZkdVNG?=
 =?utf-8?B?eklUWnByQ1dCWThJeWdieUZsc21URlNjN0VUT05SYnRTUENLNTRtZEN2WEVn?=
 =?utf-8?B?TTc5Y3Y4NXVKb2o2c2ZFc3p2QytVblFoQXBEK1hrd0ovUE9sUVRWOXdTK09Q?=
 =?utf-8?B?RVJZNWp3WWhrUFU5SFVaeGl5T09FejdaNC8rUGIrZDBsV05udFI1Lzd5MjVu?=
 =?utf-8?B?TGlBbXNyS1VQMmkxdWhnN0dGK0ZWNWYxdGhrSHZ6VDlKSVh0c2J1OWY5OE5U?=
 =?utf-8?B?b0wyYkNnV2FsM3JGWndVWjNXUGpXMVJsMnN0L01DaGkxRzkxcld0Rk80SHN2?=
 =?utf-8?B?bTNKYWZqWUtaN1dIM1pFVWxLWXRSNUhaZkV5VjVhRStwM291eU9zYWJvcEl0?=
 =?utf-8?B?UHQvaXhycmNNWUhrV0NZcE1KT0t0Z0Z6RlloeUJYRll4VHllUlpXZEllT1Rj?=
 =?utf-8?B?Ymtrd25yQXF0NVNtOHNQazd5aHFNRFN5WThBY1lYRzYvS2RZWVJXaisrclZ3?=
 =?utf-8?B?ek05R3lUa3JPak9INmhCS3F5MERPbkNTdTM1ajBPMFVMZUVNb3paT0lCZHB5?=
 =?utf-8?B?eDlpR0tyMjVmQnV5NDVaK0lHYk0rYTBFdktLWFB4MmJwektPcitxY1lyTUJB?=
 =?utf-8?B?Uy8wM1dETjh5Rmt0VnRDUjFoSFplcCtYd3NRNFRmQkRmUGRPQ2dzRUhLNklw?=
 =?utf-8?B?V1AwN3ZpeEZGQTNZY2o4RkhnYTRwbGtlSHJTUWdVVFNad0dxUlN4YVA5amZ4?=
 =?utf-8?B?enkreTVSVUlrSUQ3dXgrSVhJRk8yYXJkcWVKbHFIOWxwZkpYSkZidnI0cVQ4?=
 =?utf-8?B?TnJuNWUvKzdDODFXRXhvY29oVzNoZHNnZDVmNFlTemVjTlFNdVZ2Wkg1ei9S?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DFE51BDE4D7F74EABE3731037B91356@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IuPoZ2XbdfG8XG1b3TYe4wGwxGdzvvxiG9yYVAVSeUxDwHZkxKiGcrjFNcr3Y/9IUKoYqkzg/V521HMykkUjx9loZq04jOK901Cm859x9ta7vPPikfN5QtPNGVUlGWwZse6jzBRUWt7XqGC+Ne/aOmIzNzG1nGDsZpp9IQG253BgTCK19Tcugdd7mjiXYxazvSvXbNgUHbvjvRhRxj+9ZMAGDFBS7wWDMg2blP0C9B/3sR3cGQcwWpDtSQQEv2V1DqoWC4lEgqN+Yw8N1WY/LnNbqktlYp5QHSgEU9f79WmqTK16LZ16K/jkCby8qiBGsdcrqnvrMfwa7J36YUDdCVD27Vn19qd3Ul3bBfVG/7arAIoQMBa/SyMnfAcWFi0OiTKcLI66oHVJvDKU1HtakDv4wbyIYNS7RQ2IQwAwrvwKCH4YGf5k0hlRGHGhPvQ6LDwHmfljVV5bBNRpf5NQSfmdfKtGM/bN/iD8HVmr/x6XlNJXFVOgQ+cSG1TKsdCkHDoH0tRF2qzfA5KQh++PFyF9Y9hH2ImUrA/Aw64OSmL4Z8n9F1C306ZX2tVqs+fkO3n1IKMQcL82cmxorrd/c3Tpdg8npX1yWmLybJgmu9wlqZ18+/DrMoY+fvl2BRuO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00e2632-8b58-4975-0987-08dd76723a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:51:52.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eikUYhG/pc3aod73gc+uCBEO5WQv/dn0IWlXP2qhwcQWdIeYJqJrBsGNNLl4FC+IYuYQz4J9HqmQWDt3q82mPFcylRnm7w6UYs3dRMF7mS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6943

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
