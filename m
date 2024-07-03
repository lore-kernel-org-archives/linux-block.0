Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD921755B
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999193; cv=fail; b=WI5MS5yM1WvuOywEEXBzhPaAEJt8CyEszYfTZ9YF7Ax9rKdHnkshmqZbOR5JqiGpkPQ4g26Dk+kH0ovrK2Kw9bAicYfQu3owW1cCRq8I6iYGrviAt8GX0utRJAqNDLbZWFXHzrI6MobVB0THcbFEwrCV1sIHN8iS2jBeF/CA8a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999193; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tk6C5V1F6ie3ZnEFjCU0H26h2q4AJNtF0gSffTe6Xa0lF5hZz54s1ST4z5j8aIklbMaVBXENIIJFq0mIgc4P+6LSLVNjGyfsVdOzQKwWDI4Fe7xN0+x8BMRHZ+avNvsJoHkCedc5dUAOtMlN+xunNKTRr6otsCSVj95hApjBAFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l6mWDvf0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oa2TXdFG; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l6mWDvf0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oa2TXdFG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719999192; x=1751535192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=l6mWDvf0f9VIgS9odETPuuu41FIIYIWk0sMAIzRqoqUOvJ3ixaEniSQA
   9SYaH4uKTHueh0EwHT/ems4kSea5IvNt8IDhdaXFD8OE4a4gWjF8ilapT
   AKpqnQtTRqGQAALQ214MfwO0oBk8oV0gJnUD8bl4DueMbezC+l2Sn/B7Q
   KI3dZ2o+ljVM5DgnQRq2Jyh8zVJLN5ERzasWh0oJXLf8K3oKvWB6iZlws
   wRi8pcx7CIjZmL07nsj6u8iiehRIKZsK7BV/3QJuGqSW95vZym9YWfbdH
   K5FodTIhmmebzhV075OmgoNuAAWJ0QtDCBDFkPIfc7w/LSa5ZE/TCwE8m
   w==;
X-CSE-ConnectionGUID: ho6SRW7lQjiGMe76ZjCaXA==
X-CSE-MsgGUID: WtXITNm5RH+bnO210Qz7hw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="20456497"
Received: from mail-northcentralusazlp17010003.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.3])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:33:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlR4qfinDQGpDLD8+GUgNq9QhbE1TfPxuucT0p+7xmnMV2CSVLMhAfuLxrixFRloZwwfgFxNjS7OZqQ5mVIqdFoUzG8UVmCfOZ73B1+e43/IrrgTBKedBmJY8IhjAKhtAHvsvA3NzcdJFkUDV/QBCk4BBBhztfAD4EfhgkLwhvEJQBi6jWACMc+MgK3cAoShXlJgjOrNDLAMl/sFGPRlz6HJa9x5PWwoPHA13uMOAHO6iyFuS4F2sXOSUijHXkx82SUTMckmOr1pht0B35pdEuyoZyIVc5JdbLoU8qgYTG1GcFk7KY3FO7thycKsZtF/I1SZ+gzV70TP+NS1Mdufdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YaOp5q1mZQsTw4iC/Dl5sStUjET6SZ4rf4hibHGN93+3CB4l6om/uSlX3UaL0q/lE9v/tA3CwyNFdE45SpAZFVbR3cAo5c5TiXwlgvMlZ6oTXmjKOzNZtCsinLmRKEHm5Jq/Zqi9N8+cDCxjM6tBMv9IwwLZCdZ/4tPx8bpJMHf/V2D8nxyAtMeidsu07n2RQreolnTHBOZ1RpC8mU5SPZPWgWVG9A/7KAhIhBwCdNhNfHoB+PbtPRHHlj6kbaWUEAqzQfhGKGt//YtwvmhHbEW4gjNGqtIpa08AhkguPfBbrexl4l8i3DEDrCJnYkQXFzIdK1TR2qaRQmU9SblN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=oa2TXdFGt4CvZdOyfJaDL+qmBD3RT0qFh4+5lqQQMagkP9sdgO7a/+vLLeLY//nlscceXZwqgvZu++kYTAwmbf6IIBYIIFgk49pSLcveVR6w96+oJRcRXfuBVu0INXlltC0bYHtd5PjRIgX5GJ0qigHLzBOOxujDz8VmldmDFM0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 09:33:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:33:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/6] block: don't free submitter owned integrity payload
 on I/O completion
Thread-Topic: [PATCH 5/6] block: don't free submitter owned integrity payload
 on I/O completion
Thread-Index: AQHazJIZjsWcVB2HOkO/CCa5uHQ8S7HkvuIA
Date: Wed, 3 Jul 2024 09:33:08 +0000
Message-ID: <9becb156-24b2-488f-b4f7-98ac0555a67d@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-6-hch@lst.de>
In-Reply-To: <20240702151047.1746127-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: 63e80525-31d6-474e-399f-08dc9b432625
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nm5sRFY1Q2t4endVNG1QMkRwTUR3ZDVVcHJHVVdmem9qMWZ0QThQakRva1BT?=
 =?utf-8?B?QmJhZURxWDJMTVo1emdWTThYSlFKMnZUTFBwNWJiSkp6UzZEV08yRld6ZHR3?=
 =?utf-8?B?L0xxRWVnWDRCWDdaWHU2UnZaZUdLV2g3OUZaMTZmSExyc2ZFZzR0bWdJdEFl?=
 =?utf-8?B?QitDTVltaEI0WEpISmluSEh6YUJEd2Ftc0w1ZUlOMzF0UW1GREFXNi80UU5U?=
 =?utf-8?B?VTVxQ0p2SHZMYmpuZGswb0JhbTBqcGFEdms0dHRNaHNWUTJQbEcyc2REb1lw?=
 =?utf-8?B?S3lzNy85Vm5wWVhhMkFrc2Fkbkt6SHFLZVYyUkJOUnhDOTJvYmVuRGJmOExO?=
 =?utf-8?B?a2tBeDhnZFdLdXp0SWxUdmpNOUYrY0xqRXJGdjc5N21JeUJSU2VoWTd3Vmd0?=
 =?utf-8?B?MEUwaDJwWVp5U09aTk5SQ0dzMW5pY3VrczdFd3BZcWFxRXRJNDdHN0RaTVVJ?=
 =?utf-8?B?cGdMVW5mbzlVbTNPVENSditmMitKWVZZK09rL1lKVU4rRnZ2UG9YdUpNMDJB?=
 =?utf-8?B?eXpPaHRhVmVLdS9kZ0ZDeDVxeVdKZ21qOEtPUlUzQWxJSHdFTmxJVEZMckIw?=
 =?utf-8?B?ejlkRzZpUmdONFVOYWl2YnI4YWNqWjZoR0ZZeUtFeC9BYnh1Y1p5RmtNK0s3?=
 =?utf-8?B?QS9yZHlOOGdCSTJqbm13TkNPckpyM21qRXVGcndjKzNzWHhqa1V1MzhTd2NO?=
 =?utf-8?B?ZjNPd2UvUTlLUjYwN3NNbzhlaUh4czhnYnYrOTRjbnNvK0lRbUxkeU5oRFBC?=
 =?utf-8?B?a3pCdHZhU2ltanZ1emg3Q2dPVDlveGRVWXdLeXd2ZHlQTmU0ZFV5Vkw1aG9w?=
 =?utf-8?B?b0NoaWkyeExVT3FVaWtqWmt4b2haV3hLRVNXMzJjSmtpYnVuOEV3NkZZU3Fk?=
 =?utf-8?B?LytLUXNERUYrZnN2SlpQaTNEcjloOFYxTkw5K2FoSkVkYTI4Q0VmaVppWUI4?=
 =?utf-8?B?QXR6bmw3V1E1YVJYeVQ5N2dhTlJsdEpUOUVDYVBVRVpPNXNxZjY3WDMzdlNo?=
 =?utf-8?B?TmZqL1NZK0tNVmlJa2ZvUjBQeE9KcDVEaWgxeTMyTmt5NkQ4T3VNVjJHWmlB?=
 =?utf-8?B?Wm84L1BkWUllSE5rRThhUDhRZkMxYmIxNWRDOWx0ZmtVdXltTWpEQ3BHR2g2?=
 =?utf-8?B?L2JlSUhSNW85QkFBaUdVV3JtSGdxblhoWnJzLzlrZXRTQUUrakh0SE1NbmNJ?=
 =?utf-8?B?UW5mUTY5NExpUGFLQUJvQkltQVJvOHptU3dIdHErcUNpWWw5NmVsRVJRM1ZD?=
 =?utf-8?B?ODV6ajZGS0I1WjFDRU9yRWVWZVJ5OWZ1Ni8rUlF0eU90RGhJbm0xMmtXQ3Er?=
 =?utf-8?B?dmlFcnlHZVRoV1hZNXdGVjhpN0dqY21ZbmtIc2VzN2hvL3ZrRUsvN0ROSDRZ?=
 =?utf-8?B?eExkdUNSY1J4WFFMNTgrUFZxeDEwM05jQ0x6bnNtUEVreFRmWnhnSVJrcHRV?=
 =?utf-8?B?OU9MYnJBT1dxRFRYL1dqSFhhT2k4QXBPZy81ZFFyanl6S29PTW1PKytIUnpJ?=
 =?utf-8?B?S1R2ejV6Skh6dnV2c1VoY3lRNFdzRlJxUVV4dldDS2hzVjdVNHczTExvb2ZU?=
 =?utf-8?B?aFhBazJxeVdBTStxMkVIcXl0bGk3azkzVGhKNjJzTHJXUXhZNTdKQ1JqVmFH?=
 =?utf-8?B?K0FaQjBJL3hDUjRLYVJNTDYrUHdTblFINGRtRHVGQnFqZDFyekZmc1YvS1dF?=
 =?utf-8?B?V0VjQ0tpeWNDVFZzMmRaWmx2WGtPa1BkRDlDY1QzZFo0b0lXWXNFTjNkQzJ0?=
 =?utf-8?B?OXQ4WVBsWGJRNXpyNVZnWXBqdXkwRTZvZUVwOElXNTZwT1FaUit3U1pqOHox?=
 =?utf-8?B?ZkJsYkd3WlBEYWdYOUU4VndqR25SZXVZanhTZUdJNjFBdmlFTTl1RURQYmEy?=
 =?utf-8?B?WUZKNUs2b3NDV0F4azBldjJ5eFMwMlRyYlhNdXFDY2E0ZEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTdpWGsyc0xxOXdaQU1STHhjVWRDYjNlaGVKREQvUlV0eGFQYWdDRS9vYWR1?=
 =?utf-8?B?OWdDdWxxTVhnN0hoQTAyVm9DOTdOR1FEUjROZVhOalBUbklEVTAwY01vajFz?=
 =?utf-8?B?Q2pTM2Vjcnl2RXlJVEEvMnprbytVNWtlYy9pTlpXNEMveVRrdVBLZEIxMVJ4?=
 =?utf-8?B?blFnMkwzYVVoSHlvNUVyT21aNk1OZWNhQTMyc1VOVXF5NmNEOWFldkJRNDVj?=
 =?utf-8?B?VGwyLy82T3JQRUMvQmtFYWFyNWZyTHZEdkh3UzVnbG51TmxDenROdEkzOWR2?=
 =?utf-8?B?QWcrbUxpSkxWY3RORHZSNDVxd0JFWjRpTTJCdW9yaUQvQVU5bDdIYmNUQ0Rp?=
 =?utf-8?B?cDQxenJvbnpKM0l4NFVvMUpETjdpdzMyTUVOSkJUK1RweDREL2hOMFlRaHEx?=
 =?utf-8?B?YlY5ek1FczlieitwZHhtVGNmOE9oam4rVW9pbTY3UmdtSHk3djgza3RJOVZv?=
 =?utf-8?B?akZ6a1hVZmVpZWZ1T25mZ0FxUzJxNmg1MXpvcVBjeisvWlRSRjNpSndYcms3?=
 =?utf-8?B?ekZpbG5weVM0bWJKZk9qT3VEV01lV29ZazFnR29wVFBNVWVKdW9tTUQ3d2ls?=
 =?utf-8?B?eUZ5cTBGRXNmL2JvLzBRNlBmWHI1NFVoYWZtZ1p0bHVWcm5Dd0x3VnVLamVR?=
 =?utf-8?B?SnZhbldSanFiQ3VlSUhFTFlLdFd2N3kvU0V0NlR0V1hBQ24vUU1LRVJQazNr?=
 =?utf-8?B?WjE0Q1A4YmRFdkJ1RGxiMnJDMjgwRmh4NHdOR0MyRm1ZT2RsS1dpMVR3YVFB?=
 =?utf-8?B?MHhMQVA5bmhLa1ZCWDFYdkZpNnpKNCtYRGlSNSt2QVQxbHRxaFRlckxXWk5a?=
 =?utf-8?B?eU4zRzNqVjRYV2VYSjFSTElGYkNOWGd2TUZISjdpbHpRdUVVRUNyL0lYUEw3?=
 =?utf-8?B?QXYrZm5JY3FWajJOUGJEQ3ltbFpWZmZsMVlnSU5zZkVXTWJWRUtpNlZwTE5Y?=
 =?utf-8?B?YzZXTWxoSG9YbkZoZjdGcXBQZ210OWlCOFFnc2NIczlQU1ZIL2VsUUFIVTM0?=
 =?utf-8?B?UzhjSEhkeXNoWGQ0bm9adDAyaVdOWi9NSW9lNitQVEFycklYam1MYmsrMWRH?=
 =?utf-8?B?RVl3SThvbitGRnYyRmdYczhzZStwVlp1TndCVURYK2xHMVVFWWRWSWZiU1NC?=
 =?utf-8?B?V2k3QmVrTXQ2Zmd1b1k3VndDU0JyUG9QaGo5L245WFZmL0VQVmJPc2JFRVds?=
 =?utf-8?B?VkVhZEVlaGJyN3hTZmdpSkMwZHRKNkZEblpESTJpUHpUSmpFd0tPbEJaM0N4?=
 =?utf-8?B?NXYwSnJtT3BjUnB1MFc4UkxwQkk4L0dZR0J1a1c2clh2ZkJONEY1RkZXdnZP?=
 =?utf-8?B?b0gwdFk0RWJ4OHRyVmlqVXplM0RzdlFNU3ZrTnV5Q1IrNUhMQSs0aVBjelNB?=
 =?utf-8?B?NlhLL0FpWDFjRzdEVXhBWUl2cUNRZVRUd09wL1hNVGJ5NkZVbzlwVWtsSXhy?=
 =?utf-8?B?NU1WVlJoWUE1bTlYR0JHRlZiWXpOcjk1RkxPL0N4djBQZG91T2tGWWdzRXNk?=
 =?utf-8?B?ZTFhTnJqcGdUVDRCUC9KNTRBNWRaZnUwK1Qzbit6MWxLRHBneVJ2c3RZYXJt?=
 =?utf-8?B?U1JFWEczWFF3RlZwQW4vU2h0ZC9zcFZFUjlKYXpTUWloM2k1T2VUMS81Qkk4?=
 =?utf-8?B?ZzNUanJHWVRjdjFNQ01CNmRwMFdubWlHQXFYWlBOSWpMSmtzbGNFWXJsdHRq?=
 =?utf-8?B?aTlNRUV6YytpNlFCRThUaC9xRDNNRU9DMUtMYjF5Yjlqc0NKRTQ2VXdwL0tD?=
 =?utf-8?B?TlRHRXF1T1Qwd2x2OTA5enJCZEtzbmJFaDhNVTZEMDFidkptWThTSFd4L0NN?=
 =?utf-8?B?dnRhT1VBZzBXZFdFcVFuZnNkSmtRQlN5SDVnSUs5VzRJUU9QZDhsQ3VYNG9Q?=
 =?utf-8?B?MmxaYTFBYWVreVd5WWZ6S2NsaGdPMG02NXIxTm11ZXJBcEVPdWtPbWN3V0tU?=
 =?utf-8?B?WENQWHNBcm85UW1veGpHV0N3dng5R0dpaEQwT3ZvVWFyMHV4TUNuQ1BEbVJT?=
 =?utf-8?B?UlVaNnl1WmZjRGluMXlSU1lsMjdJZmZET2h2a1FiZjdPQ1NoUFlQN2h2TllD?=
 =?utf-8?B?NW9WSlB1TGNBWENYOCtFRGVyUi82SWFUNmdlN1oyKy9Xd0lUOC82RWdkSndT?=
 =?utf-8?B?REE2dERGN0gyNWIycGRvVFpHVE83Zmh3ZHJvTmU4WWl1WEcxS3hzUm8zS1RS?=
 =?utf-8?B?QUxwbW1DSDZvUFU0cDBFSUtWWU16Z2lMRU1xNlpad2NxVUVzQUY4ZHhqVklW?=
 =?utf-8?B?L2loZkRHaEp6dzRwVzB1N0tzK21BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A856A973272E65459173993DABF83DE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FWeILIfONA5RweLeQ3I5/0u9CDYFjY7Tp1garMAe3bOOGU6Rq4b91wr/8CTp08LpFVAz8SBdLpHQjqvaTc3xV6eKQNvnezu4izSZw+VSQGxJKEivj0PFS56TVv7eGb0ADFJ6jomOS+A4hhXWqxMlBcmNNXt0uXPs+0GNG60qUTp5OA3Wj8ikGSSEWwXsbV5jyZ8VGI5LSXMZbDTq/QuJa4LDGJRxOA/FFvUFPZIlrqsZXGVex7/DiXNecrSZIITtm4F0+IbDrWGFH1H+9JvPgOt3Bpld4YDPypzFwYd7GrB84/lIeFQXBeX97fjtfl+8QUTDHZdsUpopmAKw98nA/Hueajl8RREovRPCPhcsmNB9+Zjo18l+cA5p78RusyxcW7JLI51gXWvfzZr3epg+juF+eYJ2Ec6fqGPTXdfJ0p9m1cb6EsPuyzI1dTNeK7zPjBhHdynpY3ibbYCCsaXE8HHGrIu+BpHnyhYCwnp9XlGa4kj5ifjbGG9S/G93bNkusswtqpi5y6yGaFbhZhGl/ej1PmpKD/5+dLEZlXTTITPImzLNyRxtzFu4wJzGYgKxEeLqI7OofdnF8qpNMi6a44TXfMLqN9HNNBpZtRmWXGhRzrfbquIasXS/z8kT6E85
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e80525-31d6-474e-399f-08dc9b432625
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:33:08.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3r/0DyFgnNMMoZtCTQdQldl6ckg1jsmyR6ct8jNrlhDlOdElnrWH3qKVevBZs9NuRI8CurvkF2vSHSr6AUOBbu8mjX3Um7yAIqI0H9osLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
