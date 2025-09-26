Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022111713
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758886550; cv=fail; b=secot0eh1XROIJhkfjaE1dL2ihbtWi5FyZdqen8Ra/bDAIFMT7M8zEccobh4s3zAR/ZZVk2HjEini1Zd0EFIHX4XTzGiqAVJ4pTDB7yXnGlIcovKwMTbYBnbRWFYbUL+ZiioAYcJZ17lNnFquEGXklWUpKnX4t5PnxMWC6IJ6fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758886550; c=relaxed/simple;
	bh=0jCY/kh/10/UFTi8vQCrnbAkEu171PSJTHDUy5zBHhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cswh6xF6/pAUd76y3G+51mjZWQd8b9PdREqMdQlk7+lBI5d/TpoZ7zHWjxIrXqMJGv6aClTXh4KzGzLY4uefcYnq9R/XqdLF12cFr/l7E2oHv4qZkytP4gqoI1sP9h9U6izFYCh7xBmTgux9SHiQ2irUs8AvVVpnV1xbSiVX9l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CP3d1vg4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yCy3N2pC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CP3d1vg4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yCy3N2pC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758886549; x=1790422549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0jCY/kh/10/UFTi8vQCrnbAkEu171PSJTHDUy5zBHhI=;
  b=CP3d1vg4beYW/3zEHfUOL/kxJGN4rbEDmVAjOy9wIlUocDAGWW7qLMjw
   /vv2XiPkC3L8IngsgFuitLzuW8WZwkl5UFXSsq/SDa5O3z0uzek75awQK
   wrV6RAyMniHfgb5YD8a3AGUGAWUI8DE2vH/4TWSKNKgcpBcciMc7CH2cG
   5QIBsj0MgrmXOsalsJ4/gaj+lk1EM8YM8H+i8pMP/gEYj+fZnvddf9Q55
   /wbGlxnuZKisfej8jAfBt06boX5OUvFs+jbTA+0+xa/KQbUGdCxzWEXHS
   aXypvvhjh92kXrpWIfKaVQmdyEmQcuih/iXO/eepXxyAKHd9y6948pDNv
   g==;
X-CSE-ConnectionGUID: sjXpx43fRCyyS5qAhmuieA==
X-CSE-MsgGUID: IJrAPQLfQN2dpBjIa8maug==
X-IronPort-AV: E=Sophos;i="6.18,295,1751212800"; 
   d="scan'208";a="131926629"
Received: from mail-westusazon11012070.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.70])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2025 19:35:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0d/34OVTSzD+CYa+e9ycruKD4itvdU4y15fjVng8ng6ii24b3p3qupBVLrrqeq8LI4ZFesZGFomtmPJJVbxMlgtSqe/jidyMEzHNahULh/x4/T5wTpc7xKLDhBuv97+eQC/AC1vvOspcyEtgvP/hKfiJSJ70woVN6DPzZ0/Da0fGfHEoURiVVmENBD23uHXvgBz/1qL597M2BIy419soMl/On9RV3+6kenUuVrQKaP5mLZfRtxhWkT3DnVfCL9vGn9vEP9FRjwy196mBQtIvRrN8kCZR2qTts1PurZJrqVepH/X1KSzv9yYhbH948f28vzXe4GNWmiUGl0Kt+WI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jCY/kh/10/UFTi8vQCrnbAkEu171PSJTHDUy5zBHhI=;
 b=JbQYGJBH/qL80JlkLL4SWNz8JVn8Bl56YM3ysE6lm7fY0IWP8kXs7rQz58eHtmKJKiRyAvcM3UiZT+VZvb17l+J618/179pCQX0Tr+OapMfH5tRZukpk/nI0+i1ksK1CvThzHpxQiZBnp4JmK82KOMk1XORvELmdnTGT+S5ojtF9MLz7tjDwlSon2AhqhYG0Q/EOwSxtPR24abfKYzoI9MZpKpXLQVE8cXGeqRuyaxUlwyl3ENJ5CR0zkVBGxuHHT0PSGYcAdxnpBt8bpuCzDKNx3qYG0ycudYNwkuSPLZsNbz5C+r3VDWAsezzSBLlFQRglF79r2Cqi/PPjBkM6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jCY/kh/10/UFTi8vQCrnbAkEu171PSJTHDUy5zBHhI=;
 b=yCy3N2pCLFUZ0Sie2Y6cX6xLs013O3pbh5bjyQj5AdxOiwvKw2oxe3sOe3izS3VuccZxJEnm4mpBYjPA+OfdFp7NmC7/STr7S//+bOaphkHXLD6qKZkzcVBc/QLf4yP7vTCLcEwyjitmdCYySR0ITntx5bV6qEn0A420yoEjOok=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BL0PR04MB6579.namprd04.prod.outlook.com (2603:10b6:208:17c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 11:35:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 11:35:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, "johnny.chenyi@huawei.com"
	<johnny.chenyi@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 0/1] tests/throtl: add a deadlock regression test
Thread-Topic: [PATCH 0/1] tests/throtl: add a deadlock regression test
Thread-Index: AQHcKHsjkOCvLWjNmkaQXXpa0j9M/7Sgcr2AgAARnQCABN4QAA==
Date: Fri, 26 Sep 2025 11:35:43 +0000
Message-ID: <kg2za37ilxts76revsmy75w52bne6jncdevbeeq6tmphqw4blp@r3r2xfhsc4ef>
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
 <d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzh@coj4djvqosml>
 <84b4ee8d-1e79-66a7-9097-16a999a5dcde@huaweicloud.com>
In-Reply-To: <84b4ee8d-1e79-66a7-9097-16a999a5dcde@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BL0PR04MB6579:EE_
x-ms-office365-filtering-correlation-id: 32555561-0f08-4709-e878-08ddfcf0d427
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3JUdXVuVWhGZlJWSXFWKzFNSGlxbTk0VFU1WkxiNm5kbjZaUDR5RkZ5V1NG?=
 =?utf-8?B?aUpLYjZSVVB5bGdoOWw5SkdNd2tVY0E2QTcvSVNrNllZaUdIQzNacU9oUGVE?=
 =?utf-8?B?RGxDbXkzeHhSY1BFaDR6VVZhZkg4ai92UG5lRStXbnQ0ZjVlaWZsdnNRQVpa?=
 =?utf-8?B?UUZXWWwyL1Q5NnBXV0JYcmYwQXBXZXlpd0dPZEo0RXM2SHdVbzE0bjZjREZX?=
 =?utf-8?B?Y2hrRjFZY05mVjZ5RXFjRlJvK0NCKzdFaDRXM094TXpLQXdvcHpORkJRNW1F?=
 =?utf-8?B?SDZXOEtwZnQ1SHFQQzlwUWxqT2U0ckxXVUtxUmZtRGZaMGJ5ZWw3clpCRjR4?=
 =?utf-8?B?STB6OWVOaXRjTkh3TEJlclljWGRFaU5JTDBVTW92U2xTMnQ3TnFLRWN1NmFh?=
 =?utf-8?B?dXFxT2NkUDhVYW8zcmdCaGhTcTVER0lMWnc0QWVXVzJPeno3UGRJaW93ajM0?=
 =?utf-8?B?VndXc0FMcU1ER0V1YmFONTFlU2hnSFdCS2xiUllXb1JidVY0blpTRldpZ3pm?=
 =?utf-8?B?aUo5YlpCRlZsT3U0N3hNMDZUVmFzVmZkZEtoSHF6R0l2NTkxSCsremRQVlBi?=
 =?utf-8?B?dUZucnI5cTVhUFpSeTl0b2JzUmhIRFQ5UnpVRXBscXJwVXlhZFlQM0RiVVlr?=
 =?utf-8?B?Z1NvMjR0ejJPdVJBR01YTWxraFNUYmpRRWFVN28rOEliTDhHdnl6U2EvVDlG?=
 =?utf-8?B?RkQ4NGFvcVo2QlhWcFQ5YlRhZnNKTjBOZWNYVkI0QjROMWhoRnBYeUVNdmNs?=
 =?utf-8?B?a0EvZUl0RVZsbnVTdHR5VlBPaVNwTFIyVFp5YTBLY1FSQjdORDloejBlbFpr?=
 =?utf-8?B?cEpHS2hVZ0pXcG9Ca3ZsVVkybzQvVWVRVVc5UzZmSUcxR1BWbzRQSzNaUHNQ?=
 =?utf-8?B?VUIrM0p1bEh2YWNRNVlLcEZmQkx6SHR6elNSSGN0K0NBcFM5MjFrY2k4aVdG?=
 =?utf-8?B?R2FYa2wrSGRHZ3VaNmFlN0F1M1Q3VjVGclpBaCtJSmdBRXlKaWdkd0FkZ21t?=
 =?utf-8?B?ZnJuNGREbHlneEszOE9Cb1A1V3Z2VUZQb1J6bFB1VWhPdUVmd2R3L2w0cTZl?=
 =?utf-8?B?aE4xNFkxSlNGRWlXc0x4UGxBMlN4WkZCQ3ZqRWJ6dEtqb2hLaFVRTUhyYnVX?=
 =?utf-8?B?NG1FQjlWUWh5YlJVNlJ0K3JDKzZDUHZqWkZoeGc3S2hZMDRIem0wK3N2ZVo4?=
 =?utf-8?B?QmNwQUdublNDcmxFYlE4ZDNxN01iWTBkb0F4VVpOQ1drMVYrbXd4d1pxOGRR?=
 =?utf-8?B?U1hUcjlSalRvMkRLVThGdGxPdWZBbVJRcG91aUxrRWhQOUdTUElERGhGWDVy?=
 =?utf-8?B?MVlvSVM2WE5LOVVsWlR6S1Btb3JKcFNwZTM5TmY0WE1PblBBZ1NvRjhsMzVT?=
 =?utf-8?B?S0tLYnBhM2wrTlBmUUM4K29XdDcxd3Nxcncyd2F0WlBpc0paMXBITVpIRGtz?=
 =?utf-8?B?S1N4SlNic2FweXBJMzhmMHFpNnFwejZJQ0dGNmxlUkxUbmoyUmRZeDlwZGxa?=
 =?utf-8?B?QVVxYVhDYUM1SG1Yb2pJRHNGRndpNlBWTFRSa2hmNFhNWlYxTmJUcWJmTkVa?=
 =?utf-8?B?WnRxSHR2ZkxnWkRHRVk2ZDdGbCt5T0VDOU5vWTFXT0k2eWtTanJnbmt5Si9p?=
 =?utf-8?B?eURzZVh6Z1lsU2ttV1d4cGo1aHp5VDRoYS9ubGgzd21LWTgxdmJSb3drcXhs?=
 =?utf-8?B?YjJ1MFZBdGt4eGxsZi9ZWUJ1UlFpM0hzMEszeWkyYUhmYUhtaWNuTzhXMHUy?=
 =?utf-8?B?NE5iTFJvL3V2TVp5VU84ZWhIMGd6TVRtWWxjRkJ6akFELzZOdnM0eit4c0hT?=
 =?utf-8?B?dFhhUjh0cHZVamxPbHVlUHBJdDFuU211aXFTTzAwcjBRQ3hrNllsSWJ2d2k0?=
 =?utf-8?B?ajJrWjJoeXJLSlhQeTlhTXdTalF2ZVNneXRmaUdjVnVoR2l1MWNDZm1sL05Y?=
 =?utf-8?B?aEdHdDFkaEFYK2gwQ1FaWXFXVDQ0Vk5PSG42cnA0eFNGOXEyN0hXai9SajA3?=
 =?utf-8?B?TXlEWGs3cXFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clZqZkVxc3lxUDlibmpkL0ViamlVbjRrYWJpSFRxWmwzRkd1UXBEMjcvZXEx?=
 =?utf-8?B?VlI2TTE1SnNoeDdqVFZDd3Z0S1ZRVzlod25iUzVocHh4aVRpbkZBT2t2cFlU?=
 =?utf-8?B?U3g4NFNHMzZCalBrTXBLNlAwekYzQzZTSEhJL1NVZ3hSd0s2eW0rajJ1VDJF?=
 =?utf-8?B?Wm1pTHdFWGpqWk9ZR1diTlFveTR3V2NGWGVhZkMzZTVhd1ExaGd2a0pJQndN?=
 =?utf-8?B?UC83UDArN1VVK2NsSTR4QmJVRGtacGtIbHhuaXJ1RGN0MzVHNnJsR2Z5dHVu?=
 =?utf-8?B?WjVic1dMQ2E0VytKYTg2dmF0aEtNZjZPZXhHRXljTHhtUWNiRGlsSWZJZWo2?=
 =?utf-8?B?UGI4UFVCd1c4ajFNWWs1VEpaVEQyRE1HdStFeGxaTTJJcllEU0xYSDhQeml0?=
 =?utf-8?B?N2JQR3BOeml1dnBxQUw2UHEzZlNXbWJBSFluMmlmVXM2ZDhxMnZSOThPM0JQ?=
 =?utf-8?B?bjcrRk05b2ZHSHVSM1dWcUt1NEwvdG1HVTBFRVZUMGk0VUg5KzFnUlJsMzBV?=
 =?utf-8?B?ajh3V2pUaDdqREI2TnhRSTZzUDVCaDJrbXNFelBycWhQcTY1Rkl3UjNuOFRk?=
 =?utf-8?B?d3hVY1QvdDg5MmErTFNRRFF0bEhyMlNEUEpzNkgraEhabFQ3ZEhDWnBuWlpU?=
 =?utf-8?B?NzdxNDhQUDhKVW0wNDlESk4rM0tuU0toTGdJNjVVTDhPTDZ4OTBZa0hPZFZQ?=
 =?utf-8?B?bEdrbHlxWlJpbldVY2NuMk11bnBidkZNbUFDQVkrMFEwRjRPdGRybjAxcUMv?=
 =?utf-8?B?L3VkbTJSeG1ETnkwRVBvY3ZpdEZDOXlwWGlVWlN0b0Q4UGRJUE1CalFLQTgx?=
 =?utf-8?B?MVdldk1CYU5xRUtKYW41cGw4UDVXcFBmakJadjB5ZEhyYksrMzVMYUVNeVlV?=
 =?utf-8?B?aEdzWFNkWlFlUnRYc0hMWWkrbzJUMnQ0TVZuUFJIL210czJhNlpicG9TQmQv?=
 =?utf-8?B?SWEwbVBKdTdlM2d1THJWamIxQW1aSTVHUldsblBQZDF2T1NJU0ZOUjhlUm94?=
 =?utf-8?B?L2VRbVFqK1FuTGJmZjV4T3Rjc0RNUVA4WjVVZndHbUZLVFgwZFg0MU8reGNK?=
 =?utf-8?B?MGV4Y0w5dlRZUHV5b0RDY3dVZHJlSDh0aC9OaU1zN3BUay9zdjhqSzZqMmwx?=
 =?utf-8?B?SjFSZkRNay9GT2lKbE1CclJFSU5EK2UzekFiT1hGOUJiaEttTnBNN1dpR2NS?=
 =?utf-8?B?dVlBdVV4S28wYzM1YVA1MnEyZ29ZRkRIL28wbUpJL1ZIZmNLU1Ryck55MDhP?=
 =?utf-8?B?ZEJrWmlhZjBVTWdoYWEvQlpoN3FNRXp1OHc1UjZnVWVTOGhRWUVzVDZtcHgx?=
 =?utf-8?B?NWhrMFhxZDN0ZkxaMldtdzZFeThvWjNGSTVJTFFHaTBidUJXUHhYRkFzSXZZ?=
 =?utf-8?B?c0lGSlNST0xQZmtnY1pZRCs0NXVJYjlSdHZ5UUhUMnRDTlg0Qk9BYWM5VWdk?=
 =?utf-8?B?eVFqMU83TGZKL3BPWE9meGJvdVZyaHJSd1VqcjJtOFF3MG95eE5sZlRmcnFp?=
 =?utf-8?B?Zlg3L3JEaVU0aG5qZzFleHZET0RVNUtZWUpLUkw0VFB0cnhya2NBRy9xQm16?=
 =?utf-8?B?c0xGRUp0OWRzeXNLTGtNU0pLbWkzc3pDYXU4d0FObGdGdjQ4SC9qN0ptcTRa?=
 =?utf-8?B?dEtCU0RrUytJSXZzT0tISmQvZTU4MU9jRUU4TmZ5OVdmUVUwUlQrbHJHWUhR?=
 =?utf-8?B?Y1RTZXB0Zm5EV3YwRDUxMGhoUVY4c0hjVndYTlpGbEM3WFh2VUtHZXArSVlh?=
 =?utf-8?B?VHVQTDdpc05UeTVEM25YZmtmMnFEUm82K0t0U1JLYXMrR0VTU252SGFrQytz?=
 =?utf-8?B?OEc5NU9UMU9xRjZ6Q1A0U09nbjBmdFQ4RFp5SitrZjZHdTkrUVlieEpidXZZ?=
 =?utf-8?B?cWxKVHZqZlpMM3V3a2NPcVFaSFpRR0lwRjZta2d2WVByNjJEZk16Ynl1UDlR?=
 =?utf-8?B?ODVobjBqcmZWTkFxMXRvbUN0d0w5cUtrbGQwSFk0T3UyRUpLek41cldROWsr?=
 =?utf-8?B?bHdmUHNqNC9QUTh6blRkOUcyQzQzcFllcjJ5SHBLdVRmeGxrRnJESlpjYVlM?=
 =?utf-8?B?cjh2YTNpdFlkVm1jUFFJbW9tYUhSbmZHZm1MbmNGY1VTbVYzemlqTitDdWlY?=
 =?utf-8?B?M0NlL2J0WFV5aTBYZk53cnBjeEYzMmpqVG9VYUsvTzBlME1iQWhwYVdTWEUx?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA063E02A5DA8A41BD96872AE22946C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uYXFL43DfIPiUkU8Vjd+ZRMJ6aFRx8pcFWjT3hM1T1NSM5hemVY72QAjAuZK9LzdxhT3Bk/ZJGcXxBIjvZ395Z/DoQVxko7S0hITxq3ANPcL3i6n0PCzlRww7UVZk3kEMhIuOKH8E+MALlIGzd8nC/8sI6QHW15q791JTnO6+D8o0ilpBBWQuuTBROzr9AD7rKwBIDyf/YXpEeWm03KhgRTTjFg9k5+/sS2NfhbKGSv5RHwMjZAf185ajkZdu5JljgWC1z51mo/WGkviRVue5rTedI+96I8ZwJZdPfEDT3txl6uOQY1koTtD6DJO0R7QvML5S8/EkHw3BUR50mnk97zYI5aInt61PZi3Js+oAh+O99FsNRSdnaX0OaqfDU923VFXtCLB00q/6gcC3QJBcfTCLrXR5yeoevO/L3a8qQhVfmUddxd0j7Gfe8m/EgjSkDn8SPA+G9+G67ME+MbJic+za5bSvp+KsK/o5iKXaqhQKfCL+xn2A3K9tpfy66DHHpfHmjRR7mOzLoh5RfUPJGSGXIEJ59Xjulkxef/9oSfiOcPaD/nM9CEq2OuJMZ4kKQcUUf1zDrpnlR52tL4QTqgBPTa19cKwqOrtXdAmtOokOetVRziS1vzepnZwMOWv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32555561-0f08-4709-e878-08ddfcf0d427
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 11:35:43.7747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LGAvn4DusqomYEAR4nh9UHcVtG2/wg2SyyL89Ly7J1e+kdmdtIdB8noUe5SdMFLl2QqTuSTbH+eACFdQkbGgCvRld8i/1AUDrKB/yFITKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6579

T24gU2VwIDIzLCAyMDI1IC8gMTc6MTUsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLA0KPiANCj4g5Zyo
IDIwMjUvMDkvMjMgMTY6MTIsIFNoaW5pY2hpcm8gS2F3YXNha2kg5YaZ6YGTOg0KPiA+IE9uIFNl
cCAxOCwgMjAyNSAvIDE2OjUzLCBZdSBLdWFpIHdyb3RlOg0KPiA+ID4gRnJvbTogWXUgS3VhaSA8
eXVrdWFpM0BodWF3ZWkuY29tPg0KPiA+ID4gDQo+ID4gPiBXaGlsZSBJJ20gbG9va2luZyBhdCBh
bm90aGVyIGRlYWRsb2NrIGlzc3VlIGZvciBibGstdGhyb3RsLCBpdCdzIGZvdW5kDQo+ID4gPiBk
dXJpbmcgdGVzdCB0aGF0IGxvY2tkZXAgaXMgcmVwb3J0aW5nIGFub3RoZXIgaXNzdWUgcXVpdGUg
ZWF6eSwgSSdtDQo+ID4gPiBhZGRpbmcgcmVnZXJzc2lvbiB0ZXN0IGZvciBub3csIGlmIGFueW9u
ZSBpcyBpbnRlcmVzdGVkLiBPdGhlcndpc2UsIEknbGwNCj4gPiA+IGdvIGJhY2sgZm9yIHRoaXMg
YWZ0ZXIgSSBmaW5pc2ggdGhlIHByb2JsZW0gYXQgaGFuZCBsYXRlci4NCj4gPiA+IA0KPiA+ID4g
QlRXLCBtYXliZSB3ZSBjYW4gc3VwcG9ydCB0byB0ZXN0IGZvciBzY3NpX2RlYnVnIGluc3RlYWQg
b2YgbnVsbF9ibGsgZm9yDQo+ID4gPiBhbGwgdGhlIHRocm90bCB0ZXN0cy4NCj4gPiANCj4gPiBU
aGlzIGlzIGEgZ29vZCBjaGFuY2UgdG8gdXNlIGJsa3Rlc3RzJyBmZWF0dXJlIHRvIHJlcGVhdCB0
ZXN0IGNhc2VzIGJ5IGRpZmZlcmVudA0KPiA+IGNvbmRpdGlvbnMgWzFdLiBUZXN0IGNhc2VzIGNh
biBpbXBsZW1lbnQgc2V0X2NvbmRpdGlvbnMoKSBob29rcyBmb3IgdGhhdA0KPiA+IHB1cnBvc2Uu
DQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1ibGt0ZXN0cy9ibGt0ZXN0
cy9ibG9iL2E5OTdhYjBjYTliNzdkZGYzMWI4YzYzMmJmZTU3ZjdiZDc1ZTMwNWUvbmV3I0wxODMN
Cj4gPiANCj4gPiBZdSwgRllJLCBJIHF1aWNrbHkgaW1wbGVtZW50ZWQgdGhlIHNldF9jb25kaXRp
b25zKCkgaG9va3MgZm9yIHRoZSB0aHJvdGwgZ3JvdXAsDQo+ID4gYW5kIGF0dGFjaCBpdCBhcyBh
IHBhdGNoLiBXaGVuIHlvdSBoYXZlIHRpbWUsIHBsZWFzZSB0cnkgaXQgb3V0LiBFYWNoIHRlc3Qg
Y2FzZQ0KPiA+IHJ1bnMgdHdpY2UgZm9yIG51bGxfYmxrIGFuZCBzY3NpX2RlYnVnIFsyXS4NCj4g
PiANCj4gPiAtIFdpdGggdGhpcyBwYXRjaCwgdGhlIGxvY2tkZXAgc3BsYXQgaXMgcmVjcmVhdGVk
IGF0IHRocm90bC8wMDQuIEl0IGlzDQo+ID4gICAgb2JzZXJ2ZWQgYXQgdGhyb3RsLzAwMSBhbHNv
IGFzIHNob3cgaW4gWzJdLg0KPiA+IC0gdGhyb3RsLzAwMiBmYWlscyBmb3Igc2NzaV9kZWJ1Zy4g
SSBndWVzcyBwZXJmb3JtYW5jZSBkaWZmZXJlbmNlIGJldHdlZW4NCj4gPiAgICBudWxsX2JsayBh
bmQgc2NzaV9kZWJ1ZyBpcyB0aGUgY2F1c2UsIGJ1dCBub3Qgc28gc3VyZS4NCj4gPiAtIFJlc3Vs
dHMgYXJlIHBsYWNlZCBpbiByZXN1bHRzL25vZGV2X251bGxiIGFuZCByZXN1bHRzL25vZGV2X3Nk
ZWJ1Zy4NCj4gPiANCj4gPiBJZiB5b3UgdGhpbmsgdGhpcyBhcHByb2FjaCBpcyBnb29kLCBJIHdp
bGwgcHJlcGFyZSBhIGZvcm1hbCBwYXRjaCBzZXJpZXMuDQo+ID4gDQo+ID4gDQo+IA0KPiBJIGRv
IG5vdCBsb29rIGludG8gdGhlIHBhdGNoIGluIGRldGFpbCwgaG93ZXZlciwgSSB0aGluayB0aGlz
IGlzDQo+IHBlcmZlY3QuDQoNCk9rYXksIEkgd2lsbCB0cnkgdG8gZmluZCBvdXQgdGltZSBzbG90
IHRvIGNyZWF0ZSB0aGUgZm9ybWFsIHBhdGNoIHNlcmllcy4NCg0KPiA+IFsyXQ0KPiA+IA0KPiA+
ICMgLi9jaGVjayB0aHJvdGwNCj4gPiB0aHJvdGwvMDAxIChudWxsYikgKGJhc2ljIGZ1bmN0aW9u
YWxpdHkpICAgICAgICAgICAgICAgICAgICAgW3Bhc3NlZF0NCj4gPiAgICAgIHJ1bnRpbWUgIDQu
NTQ2cyAgLi4uICA0Ljc1M3MNCj4gPiB0aHJvdGwvMDAxIChzZGVidWcpIChiYXNpYyBmdW5jdGlv
bmFsaXR5KSAgICAgICAgICAgICAgICAgICAgW2ZhaWxlZF0NCj4gPiAgICAgIHJ1bnRpbWUgIDUu
Mzg2cyAgLi4uICA1Ljg0MnMNCj4gPiAgICAgIHNvbWV0aGluZyBmb3VuZCBpbiBkbWVzZzoNCj4g
PiAgICAgIFsgICA3OS40NDQ4OTddIFsgICBUMTE1Nl0gcnVuIGJsa3Rlc3RzIHRocm90bC8wMDEg
YXQgMjAyNS0wOS0yMyAxNzowNToyMg0KPiA+ICAgICAgWyAgIDc5LjY4NDg1OV0gWyAgIFQxMjYw
XSBzZCA5OjA6MDowOiBbc2RkXSBTeW5jaHJvbml6aW5nIFNDU0kgY2FjaGUNCj4gPiAgICAgIFsg
ICA4MC4wMDI1NzZdIFsgICBUMTI2Ml0gc2NzaV9kZWJ1ZzpzZGVidWdfZHJpdmVyX3Byb2JlOiBz
Y3NpX2RlYnVnOiB0cmltIHBvbGxfcXVldWVzIHRvIDAuIHBvbGxfcS9ucl9odyA9ICgwLzEpDQo+
ID4gICAgICBbICAgODAuMDAzOTUwXSBbICAgVDEyNjJdIHNjc2kgaG9zdDk6IHNjc2lfZGVidWc6
IHZlcnNpb24gMDE5MSBbMjAyMTA1MjBdDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X3NpemVfbWI9MTAyNCwgb3B0cz0weDAsIHN1Ym1pdF9xdWV1ZXM9MSwgc3RhdGlz
dGljcz0wDQo+ID4gICAgICBbICAgODAuMDA5MzA3XSBbICAgVDEyNjJdIHNjc2kgOTowOjA6MDog
RGlyZWN0LUFjY2VzcyAgICAgTGludXggICAgc2NzaV9kZWJ1ZyAgICAgICAwMTkxIFBROiAwIEFO
U0k6IDcNCj4gPiAgICAgIFsgICA4MC4wMTE5NTJdIFsgICAgICBDMl0gc2NzaSA5OjA6MDowOiBQ
b3dlci1vbiBvciBkZXZpY2UgcmVzZXQgb2NjdXJyZWQNCj4gPiAgICAgIFsgICA4MC4wMTg1ODNd
IFsgICBUMTI2Ml0gc2QgOTowOjA6MDogQXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMyB0eXBlIDAN
Cj4gPiAgICAgIFsgICA4MC4wMjA1OTRdIFsgICAgVDEwM10gc2QgOTowOjA6MDogW3NkZF0gMjA5
NzE1MiA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDEuMDcgR0IvMS4wMCBHaUIpDQo+ID4gICAg
ICBbICAgODAuMDIyODI2XSBbICAgIFQxMDNdIHNkIDk6MDowOjA6IFtzZGRdIFdyaXRlIFByb3Rl
Y3QgaXMgb2ZmDQo+ID4gICAgICAuLi4NCj4gPiAgICAgIChTZWUgJy9ob21lL3NoaW4vQmxrdGVz
dHMvYmxrdGVzdHMvcmVzdWx0cy9ub2Rldl9zZGVidWcvdGhyb3RsLzAwMS5kbWVzZycgZm9yIHRo
ZSBlbnRpcmUgbWVzc2FnZSkNCj4gPiB0aHJvdGwvMDAyIChudWxsYikgKGlvcHMgbGltaXQgb3Zl
ciBJTyBzcGxpdCkgICAgICAgICAgICAgICAgW3Bhc3NlZF0NCj4gPiAgICAgIHJ1bnRpbWUgIDIu
NTg2cyAgLi4uICAyLjQ4NnMNCj4gPiB0aHJvdGwvMDAyIChzZGVidWcpIChpb3BzIGxpbWl0IG92
ZXIgSU8gc3BsaXQpICAgICAgICAgICAgICAgW2ZhaWxlZF0NCj4gPiAgICAgIHJ1bnRpbWUgIDYu
MTM3cyAgLi4uICA2LjQ2N3MNCj4gPiAgICAgIC0tLSB0ZXN0cy90aHJvdGwvMDAyLm91dCAgICAy
MDI1LTA5LTIzIDE0OjA1OjM1LjAxMTg4NTQzOSArMDkwMA0KPiA+ICAgICAgKysrIC9ob21lL3No
aW4vQmxrdGVzdHMvYmxrdGVzdHMvcmVzdWx0cy9ub2Rldl9zZGVidWcvdGhyb3RsLzAwMi5vdXQu
YmFkICAgIDIwMjUtMDktMjMgMTc6MDU6MzcuMjA5Nzk0MDAzICswOTAwDQo+ID4gICAgICBAQCAt
MSw0ICsxLDQgQEANCj4gPiAgICAgICBSdW5uaW5nIHRocm90bC8wMDINCj4gPiAgICAgIC0xDQo+
ID4gICAgICAtMQ0KPiA+ICAgICAgKzMNCj4gPiAgICAgICszDQo+IA0KPiBJIGRvbid0IGZlZWwg
dGhpcyBpcyByZWxhdGVkIHRvIHBlcmZvcm1hbmNlLCB3ZSdsbCBoYXZlIHRvIGNoZWNrIGxhdGVy
Lg0KDQpJIHNlZSwgbm90ZWQu
