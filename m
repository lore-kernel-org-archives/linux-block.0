Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F65748F;
	Tue, 28 Oct 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636099; cv=fail; b=g5CfXngG7h6GGrgrosrjx6NYF08AEi7piHdd66lIECoVqE7DIHsG30Kxj/uxltZkXq9AHT+lRcFiacbctSV8vh5HDCGGRMHRAyNQH71exGIp+HlrO/krzJI+FBQR9w+ooB4lDy8flE5Bw3zNQrVr0nIxqsIUjqPvwf0oEBs5m40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636099; c=relaxed/simple;
	bh=RcHidMlcyjqwmhNVe68MRHbD4LliqXZSAEekEGLy8MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxJLu9JBBHPMnQJce8guGAX+BpIR6jY3RDzCcAXDOfHg8LSoF0juMozS3WhEYidFg/1aGN89UR02/llEdEkrVHn71G63Wx4fzM+q11q4XlYrq0lihlQTc72nFkiaUtFQDW3+Zj1VtpGmrsJglHd3kOWBXYpcD7AleGpMkUJlsF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dSdlSQGJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kdDl9q7t; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dSdlSQGJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kdDl9q7t"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761636097; x=1793172097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RcHidMlcyjqwmhNVe68MRHbD4LliqXZSAEekEGLy8MY=;
  b=dSdlSQGJD4CHg3izyvtlFOt/sMQ+8I653PaLs4gLY4TxB03E8xOXCpVJ
   oH3b16CC3FVx9St45lklgrXrsUFi1Tvp5d01CAJflJFcyFzRVVsQvhBGt
   s0Il3njwN/QTqIsnb7J3JMBYcFsYHmSpLaatDGY6h3SV+dWlz22+Oje+v
   Iw2pTWCuGRghLoU1LZEO2vWTKzk8t00DECYMdf4akFseubcvNSW/bZfox
   AFzGgsCOaHO0wHywhcb0oEUQ7qMUAk/sjAcEisK3CGIvC28yGEmWeJzGJ
   /25vz1VM5emaVPejlS0Dm/bCiSqY9ndC9xZcBiX0KgQmATxMwPockUVU7
   Q==;
X-CSE-ConnectionGUID: ug9Gr7FRQay+gXuxOTZdSA==
X-CSE-MsgGUID: 9TeaasYsRwOf7L9nINOvlw==
X-IronPort-AV: E=Sophos;i="6.19,260,1754928000"; 
   d="scan'208";a="134969999"
Received: from mail-westcentralusazon11010056.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.56])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2025 15:21:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt/pe9CBKofsj9U5LZVNQ7BvHRKZzs64mNFx1qebfjcJC4H3DdIgydKi/g0iFOYdYkOD9hOkb+gU+A3i3zrsBgjqhtOgDyTmzGEnXa+rHoHPanYwsA80B1GQhlUIn1zqCwPDvZrTHK673Cd+vyJGtq1dqX0v1NhWyxLAZY6hq1k9uUw1y9t5m29eRuC4i4+gAMIx7D0g1WrZ2imKyJnb3eo7PP/sNBPZNwAFhANLf6N08WcmFqluKizuuBkWHF9cMhnW15KiCFfBYwfysKVYCrTWbbQb0X8UoUlJusW8LTEyIoMUs2Yjw454N7NVGrWJ6/jtUOF50yT9Wn03lA3bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcHidMlcyjqwmhNVe68MRHbD4LliqXZSAEekEGLy8MY=;
 b=xsDfWDYCUHKvzlSQ3frmZuOpaxwWiPXB2hm4wD8GDca0JK3gvB3WaXzxiW3aau/lbO+yfTSxYUitsN/Uuv0FDiu83Ie+dpqotRkQPGuPlMgeYVPCWPx7l7mRGTfJDhFpw8iQjU6YZ/TOuGAaRa2fFSe5+jDqSylhQx91ZqWWFcAKl24DGfyY1nxsAZ2WwyDnz79tFI+KaSvdkwJY++1n/UkdbcD4VCAk1z7y0gry1lV4ly8lrtNtCaL3xCCESn1oFwjLtw+N6ELcaMt+hAs6pGuR4AJku5CluHs5tJnRwt6iwfCsi4LUHKQxL7R/KwP6cbLsgmjYN/kVbXibyTWS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcHidMlcyjqwmhNVe68MRHbD4LliqXZSAEekEGLy8MY=;
 b=kdDl9q7tO8nQexq7EkG0F9uWxKkcAaGO2rgWkzUyX79iNUhHVJDEMVPY2WmOXD757/PFxb1VMrvb/abgdWvrEfRIls7D2WyxmOWVf168j483DWhw2qKnKLOOfG+/jkneuFaq5xITgowNy3TX6OoU+/dRnvF2nH5SArU0yZHcuLQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7390.namprd04.prod.outlook.com (2603:10b6:a03:293::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 07:21:28 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 07:21:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] blktrace: for ftrace use correct trace format ver
Thread-Topic: [PATCH] blktrace: for ftrace use correct trace format ver
Thread-Index: AQHcR87R8be/GFkFvU2/GW4ucGiEc7TXJ1UA
Date: Tue, 28 Oct 2025 07:21:28 +0000
Message-ID: <8940ba50-5e39-4755-9a68-a55fb99603af@wdc.com>
References: <20251028055042.2948-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028055042.2948-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7390:EE_
x-ms-office365-filtering-correlation-id: 8de2c105-f658-447d-c62e-08de15f29c65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDhYWXI5NFVBY1lhTGJVUVgvUXJCaWhEd3BUM0FFQkdMdXBMRmxncDc2VVlq?=
 =?utf-8?B?ZlFjTVpqVVJRbktwczVtNUUvVVNlNUpodFRJbC9NYnpwVDVzZnpDTXpFZzcw?=
 =?utf-8?B?a3BtTDlZZ2J6SjFRZ2dQdUZwSHMvaEpTdWNyaCtHeWh1ZnR5bHRXamxVbW5S?=
 =?utf-8?B?elZtd0xaa3lzbEY1SVQxbjNzZTZVVTVYdkIyVnBrYVoyUGZpOERyOTl1R1pI?=
 =?utf-8?B?Ri9nOUJ4TDlCbXQrdkgrMS9pdUZieSt1TVZzRFFjVFFNNmxlN25aczdOWU9P?=
 =?utf-8?B?N24yZ2JNc1Fod28wWituOUxZL3BIeXMrZXNCZ1dDVW9ZMm1ZSy9zYTg5ZTdO?=
 =?utf-8?B?WFFoaHhVeEQ4NnU5V3lhTVRRSFRnZnZ6aDdLMjVlSkVCYTZtYlliQUJKRjBH?=
 =?utf-8?B?N0FGMWRwaWpkOGwvcldpRXNqa2MvTmhtaHJkYXJWVUhXSUtKVys5ejVzOWNm?=
 =?utf-8?B?a1hZa2lMNUc3VDFPOE5RMzVHVm54MjljNE9CcllXOW9zdjFqMXpxSXNLR01x?=
 =?utf-8?B?VG5GTEVYcnFiMmJhaVh6U3A2YVI0ZjU2TUsyYmUzZU0vbHZ2NFFCbDU1M2ZU?=
 =?utf-8?B?U0Nxb0lQWmd0eGZLM2orckQ1c3FyL05mdExYOFAwbU9iZFlvakpNOXFDL3B6?=
 =?utf-8?B?djRPWHkvYlVoNGFWNFdQTytFWk9VK1BrUTFJWHljb1BZcnNTVDZ3bDNLZTdM?=
 =?utf-8?B?MlNGMXM4Nk40b1NNaWFkWHBtbzlmVEJrZ1lQZ2xjdVZhYXArZGZZeUc4RFky?=
 =?utf-8?B?OXJTUDNneUsvQUw4dnh6UmNUb3ppTWIxTWpZQUtyMWlmTDVZTFRGcGdralAz?=
 =?utf-8?B?a1FuYkRuenQvRjFZbVhST0w4d0dzS3gxeVZaWFhLdXRwcGV5RGxyNS90VVBW?=
 =?utf-8?B?VHZuczhzZllYdTJiMUJGdjYwYVB6eXUyeDk3QUk4LzJPMExORWE1YzcxTHlU?=
 =?utf-8?B?MUxzS2FCN2wwYnlaTnUwZ2Rtc0V4eTVNSWp1Z090QTgvbmNzY3Z2NmxxNzdS?=
 =?utf-8?B?L3krazVMT2ZNN09OTUtmSHByTDhpek5hZjZUbnFWUkNEQm9aT3JWNHZPS3ZC?=
 =?utf-8?B?TzVRd3hobkhSLzhRbWhjMGNlSDVDZ0JSOG5SY2ZzcWFmeGRNaklOV090eTJW?=
 =?utf-8?B?NHVaUWY4bjJuZFZ3QnNTYXdZV0NGazZmWkRja1JCanJTeTBBUGFWYXZYTHpa?=
 =?utf-8?B?b2trSVhHejU1U0dqSXFyaUtZUUtZTGN5ZnZXVzJaVm54c0ViM1YyMmFtc0hx?=
 =?utf-8?B?SlhkOHgveHRPQVlRT1VxWStzcFdIUnBkZnBwMGh0MUlFNXFvay9VMXJIc2o2?=
 =?utf-8?B?TDM5UU5Qa0tSV1B6S3pFb3N1T1I2M3lCUWZXZDA3NTBjZ0pMWWxMeVEwdU1x?=
 =?utf-8?B?NnlMQkdzU1BEcVJEckFUbDRJYmh3OVlDaVlIcFBJZTlKb0FhWm5oY2o1amFK?=
 =?utf-8?B?ZWVpdjI5L2pBVDdZQmUwNjU1Qm43ZWN1YlZuQ1Y1SFgzVS9qZjZpUlNKMVBG?=
 =?utf-8?B?MDFDNlpSYUlPOVhnZGc0VUc5bUhRRzRWTkErZGNLRjIvdlk4aU1nM01KRGxq?=
 =?utf-8?B?L1ZhYjZhRXRRTmcvb1lXYjNiVk9BRXpnUDNyZ2M2NSs3QitTbzNENyt5QzUv?=
 =?utf-8?B?dFZDWWdJMUhKVW9Mc243T280VHp5NFV5WFFURDFVUlhrYlRSeFVQYlB5bFYz?=
 =?utf-8?B?aytDdWxmODZNaDNHZHNVNzNSbXMxa1NHaEp4NldTbjBNQ1pJL2dRUjRqcXVz?=
 =?utf-8?B?WlVGZXZMaDFUb1dKOW5ZeFZNWC80N0lxMGphWFYwbXgxRkVkLzBpaXR4M3lK?=
 =?utf-8?B?OVRoMFZLeGxvQ1M1dS9Zd1lrYkc0blR0Z2tvY1JHQ1dTdXovR0d2Uk9CT3Na?=
 =?utf-8?B?aDJmTElKR3hMenh1eDhCRDhxcW1XdFZSZ3VVaUtYSlRkNTFOQjhsRlZEeHVh?=
 =?utf-8?B?RUQwSjhjZXliM01JeGlmK3VybXNWM3RvVlB0d0NGZ1ZRSW14Z3dhMW1sV1Nu?=
 =?utf-8?B?WkxPUEpQS0ZVWDRUNVcxVm04ZElqdHhNajlJZ2NjYkNvdlhiblIyNzNLUGZO?=
 =?utf-8?Q?iive3k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2V4bDJOVkVDUkR3QzNMNlVKY293ZFVVTzdOMEw0ZS9NZkhPblI4V2krQlFB?=
 =?utf-8?B?SHhXZGxoMkF1eHlOZGhlbCt5K0FhNExLMGNTQjZ3R2lCWVpVRlZDd3g0Z3F3?=
 =?utf-8?B?MEV4UHNKanZKZU5ZT0ZZVm5CL1p1SlB6L2w0RHNxUGdyMTZFRzNZZ3pzS0dk?=
 =?utf-8?B?VGxQTHVnbGtmbkdTWDhERGw2VzI3T2ZpNXFJcUkzaDRJbFl5YnRyQzZkY0Vt?=
 =?utf-8?B?OVpUaUZ5bHFrQlZSbXJJSUgvVmFrVFFLRll0ZmpBbDlDY3JmQzd0T3lxbkNm?=
 =?utf-8?B?M1RQZVRFdzFhTHVJSkNRRlNRVG1qZlJqME5ZcEszb0NMUFZ3RmFIQjdZK3lP?=
 =?utf-8?B?cE1QdVdvVi9nckhGb2ljSUU1NmgraDdvT3Y3Ym5HYkV0TS9QdVl5aXRKRlg1?=
 =?utf-8?B?VGpJVDRZTDIrQi90SWMxY3pGVkYrZUNraDNLcURmM2g4QmNNb0d6RFFlb1lx?=
 =?utf-8?B?MTAvQWJkRUV0SjhpaHpFNG9IMndJdktrUVFtdTFJd0ova0xicHJoZTZyTmc0?=
 =?utf-8?B?cmdUM2pPSkdWall1RE9ad3ptU1NjcmZNMWNIQnhyNHZwSWpzWm1KalpVbndt?=
 =?utf-8?B?N1plL3RoYTNOOHJjSU90MkhwcmgycU9CT1lDZ1R5QmhUaUlXNEUxUERDeHI1?=
 =?utf-8?B?azFPTUdxdTZVemgwYm1OL2YxWHhWaDV5VW4zNFg1cTNqeCs5M1dXOG05dEFE?=
 =?utf-8?B?WW5JYXVZVEtNMUJnVGRsZUk1WkZuR1R5U0ZHSTFjblp1VDVSajUrRFBPdzhq?=
 =?utf-8?B?bjc0NnNxdEs2RVZldkx6KzJ2eXdKazk4eFVtaklGNHdwUVpTNUFRUHhKQWtE?=
 =?utf-8?B?S2JnWjYvTU1XbTBJbGdpMUV2SW16a0E2TmxPTGxKZnlwMHNrSVN2RnZydDlD?=
 =?utf-8?B?ZSsyZTJOaXAzK2ZQTmRZR3BuUlpaUGp5aTIyMTR3WVY5T25hN0ppV2VySnZG?=
 =?utf-8?B?VUNJQnVTTUowZWlFbzNZQ3dPZ2xLeDRvNGt3UjNXbjJyOEVzdEQ5SVhUekhG?=
 =?utf-8?B?K1hwUWVHK3V6bXkyQ2wvSnR5RGkzZC9YSWpLK3NpU2c5OUJuQmg5OFBtVVMx?=
 =?utf-8?B?bmxNbEJFQmJreGNlbnNCWGM1L0JQNXBRVHJQN2xNd2VXMGx0SFNxaUlzTDho?=
 =?utf-8?B?dUd1a1hQTVF5MndpQzk1Tjlmd0lHYTg3NXRHaUFMR2lSWDJVNlp6YzRkVnp4?=
 =?utf-8?B?Q0tlQXErd2NGK0ZCSlhSbXBzTEd2QSsrREtnOVpBZmNIMmFROHJZUTRFTkpr?=
 =?utf-8?B?bVZ6ZjNuUjNDd0R0OFJ3ZkRLanJzTUppWmZKZXZpSnNxZ1gxQXI5NUFndlQr?=
 =?utf-8?B?dk12V2g2L0U3UkhVaU00TzV2K3lOZE4wOVRWNWVWaFVqUVI0VkdYaEUvR0VN?=
 =?utf-8?B?ZzRodE1LWmhyY3ZvVXVVY2JkVHZuT2VDOWtYZEtDb0U2Tm16eDFzQVdNYnVt?=
 =?utf-8?B?aGhubEJGTEpTcjEyeVV1SFBRaDlTTE1DMVJ6M1JKbk5HS0xaRTZEUHRWUjJI?=
 =?utf-8?B?Z3VSZStJYi9oT01MK09McGpHUEFWeUREZWRuNHh1blhiWUpHbnFkOHVacmpq?=
 =?utf-8?B?QlZSSTZBS2sreVhQWUZuYzc3Nmg3bXVvMUV0dVBVTTB2d0dnTW9wSm0wd0lY?=
 =?utf-8?B?ZXBrN0hnMmQweFBVR01KbUNSZUdRQTJ0NnVLWGkyRGNvd2g1OW5tdlB3cHhr?=
 =?utf-8?B?YVFTSGduTVlsTms3RkZKc0gyTHJlTGIyMFJNOHNhNVh0OGgwNGlzTE55Zms2?=
 =?utf-8?B?RHZWVW0wcGNnZjZlcWFNeEZMQzF6MHYxd0ZkK1ZnaGVkMWhBd3Z1WjBKcm1K?=
 =?utf-8?B?ZHBiL0dQQ0NQVTJQSE9wNDlhWkYvcjBNVzhEc2tQUnA3bnNXRUpkMFc0eW1F?=
 =?utf-8?B?RjJZSEtxU1RVQ0JHcmlqMzFHODhBRXZhSWRPYTdhVUtadmJWazlnUkFJVmlz?=
 =?utf-8?B?VEVVMlJ5SzhmUllheHJsTE1OWGZ0dlV4M1NWb0o1QWNZbHFnWjIxeTM4RE1O?=
 =?utf-8?B?cWtmSTRTWmk5d2tUU0piVkRLT3RsNWNEcUFWRVlIS2x6U2JTOWRLb2tzVFo5?=
 =?utf-8?B?bVlSUkJCM2MzM1ZZVUQxeWRFa3cvdFQwYWNYYjd6MzdhTzB0MTFUNERCK3Vr?=
 =?utf-8?B?bnhOTnBuZTlKZ0VlRXUzRUswVFRZRlVJSXRsTFQvS3piQ29kVzlNVmVyaGIw?=
 =?utf-8?B?VVovYjg0cmVFRFplK3h5MnRFckYyNHAxTVdVMGF6TjRyU3dhdzFueS90bWFq?=
 =?utf-8?B?ZHVOc1U1LzF6OHJxaHFjYWFPZlZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4D11B451C4364CB27BF61A64D3D41F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AcOuM+9nFzMWU+nzaXU0ccsLYzxagYj65GVLkUz+bNxyfnSsEmFCFsaqt/qkzUYD5Ih2C1lXbfXlX5fjxySAahyJJ/CFrICQefeGcEV9l+Z4xawvTLo5M+5ijXwYF58IstfgpHxTqMU0zNs6c7hFAMI6dZZOnlLyVe1JtWgQ2BShjjxUdrCailRC/GvvaBFGQhZfmFppDulboKT+ouckG4EM9zAj64Iyuwl7Eqsw4bjU4iQgCeFCnwh6cjZkefSDvH3JLMYv5GyIltbtlUf3Vxm/hZEo9nafA3REwPBxF0nQ+urG4pTGRhowaTbBEYRr0Q7Qf5uuRsaNAdoiWie4N930Vj12iL+SdvyNe0ye3AQYcgg7RpC7zmF+Od99fKDi80TovyxG3BZG9+AW3iNQ7U2R/l5mbq+3p8KBemXki4SxL1M09Dsq6IZTyYoGA7pttA6yX+o6UvAQtjxj0MApO9w89OMQai01cUCBcnRF6RsZwTEFuppmzf+rRbJuZ5/QcdW+npckkfIDlapgy6hEEg0UNgI4UnuUjsVGCBlwLRT4Eftzeocq92ySK9Wv0AiB7G+2PpTy6Ca88nJtRdCpaXdQXZ/GahwzPJsaGKTels1a/kabkyYGbXgcW/DUzSAz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de2c105-f658-447d-c62e-08de15f29c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 07:21:28.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24q1+ay02Bk13HIhnrG1wSsMcm2Tj1bIFLYW4GVbOkyKIM5byANElafRHz4dLFBW+419bhPx4EfgUtYqARZH70EBrBByFcCFMwIxTeozWSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7390

T24gMTAvMjgvMjUgNjo1MCBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBUaGUgZnRy
YWNlIGJsa3RyYWNlIHBhdGggYWxsb2NhdGVzIGJ1ZmZlcnMgYW5kIHdyaXRlcyB0cmFjZSBldmVu
dHMgYnV0DQo+IHdhcyB1c2luZyB0aGUgd3JvbmcgcmVjb3JkaW5nIGZ1bmN0aW9uLiBBZnRlcg0K
PiBjb21taXQgNGQ4YmM3YmQ0ZjczICgiYmxrdHJhY2U6IG1vdmUgZnRyYWNlIGJsa19pb190cmFj
ZXIgdG8gYmxrX2lvX3RyYWNlMiIpLA0KPiB0aGUgZnRyYWNlIGludGVyZmFjZSB3YXMgbW92ZWQg
dG8gdXNlIGJsa19pb190cmFjZTIgZm9ybWF0LCBidXQNCj4gX19ibGtfYWRkX3RyYWNlKCkgc3Rp
bGwgY2FsbGVkIHJlY29yZF9ibGt0cmFjZV9ldmVudCgpIHdoaWNoIHdyaXRlcyBpbg0KPiBibGtf
aW9fdHJhY2UgKHYxKSBmb3JtYXQuDQo+DQo+IFRoaXMgY2F1c2VzIGNyaXRpY2FsIGRhdGEgY29y
cnVwdGlvbjoNCj4NCj4gLSBibGtfaW9fdHJhY2UgKHYxKSBoYXMgMzItYml0ICdhY3Rpb24nIGZp
ZWxkIGF0IG9mZnNldCAyOA0KPiAtIGJsa19pb190cmFjZTIgKHYyKSBoYXMgMzItYml0ICdwaWQn
IGF0IG9mZnNldCAyOCBhbmQgNjQtYml0ICdhY3Rpb24nDQo+ICAgIGF0IG9mZnNldCAzMg0KPiAt
IFdoZW4gcmVjb3JkX2Jsa3RyYWNlX2V2ZW50KCkgd3JpdGVzIHRvIGEgdjIgYnVmZmVyOg0KPiAg
ICAqIFdyaXRpbmcgcGlkIChvZmZzZXQgMzIgaW4gdjEpIGNvcnJ1cHRzIHRoZSB2MiBhY3Rpb24g
ZmllbGQNCj4gICAgKiBXcml0aW5nIGFjdGlvbiAob2Zmc2V0IDI4IGluIHYxKSBjb3JydXB0cyB0
aGUgdjIgcGlkIGZpZWxkDQo+ICAgICogVGhlIDY0LWJpdCBhY3Rpb24gaXMgdHJ1bmNhdGVkIHRv
IDMyLWJpdCB2aWEgbG93ZXJfMzJfYml0cygpDQo+DQo+IEZpeCBieToNCj4gMS4gQWRkaW5nIHZl
cnNpb24gc3dpdGNoIHRvIHNlbGVjdCBjb3JyZWN0IGZvcm1hdCAodjEgdnMgdjIpDQo+IDIuIENh
bGxpbmcgYXBwcm9wcmlhdGUgcmVjb3JkaW5nIGZ1bmN0aW9uIGJhc2VkIG9uIHZlcnNpb24NCj4g
My4gRGVmYXVsdGluZyB0byB2MiBmb3IgZnRyYWNlIChhcyBpbnRlbmRlZCBieSBjb21taXQgNGQ4
YmM3YmQ0ZjczKQ0KPiA0LiBBZGRpbmcgV0FSTl9PTkNFIGZvciB1bmV4cGVjdGVkIHZlcnNpb24g
dmFsdWVzDQo+DQo+IFdpdGhvdXQgdGhpcyBwYXRjaCA6LQ0KPiBsaW51eC1ibG9jayAoZm9yLW5l
eHQpICMgc2ggcmVwcm9kdWNlX2Jsa3RyYWNlX2J1Zy5zaA0KPiAgICAgICAgICAgICAgICBkZC0x
NDI0MiAgIFswMzNdIGQuLjEuICAzOTAzLjAyMjMwODogVW5rbm93biBhY3Rpb24gMzZhMg0KPiAg
ICAgICAgICAgICAgICBkZC0xNDI0MiAgIFswMzNdIGQuLjEuICAzOTAzLjAyMjMzMzogVW5rbm93
biBhY3Rpb24gMzZhMg0KPiAgICAgICAgICAgICAgICBkZC0xNDI0MiAgIFswMzNdIGQuLjEuICAz
OTAzLjAyMjM2NTogVW5rbm93biBhY3Rpb24gMzZhMg0KPiAgICAgICAgICAgICAgICBkZC0xNDI0
MiAgIFswMzNdIGQuLjEuICAzOTAzLjAyMjM2NjogVW5rbm93biBhY3Rpb24gMzZhMg0KPiAgICAg
ICAgICAgICAgICBkZC0xNDI0MiAgIFswMzNdIGQuLjEuICAzOTAzLjAyMjM2OTogVW5rbm93biBh
Y3Rpb24gMzZhMg0KPg0KPiBUaGUgYWN0aW9uIGZpZWxkIGlzIGNvcnJ1cHRlZCBiZWNhdXNlOg0K
PiAgICAtIGZ0cmFjZSBhbGxvY2F0ZWQgYmxrX2lvX3RyYWNlMiBidWZmZXIgKDY0IGJ5dGVzKQ0K
PiAgICAtIEJ1dCBjYWxsZWQgcmVjb3JkX2Jsa3RyYWNlX2V2ZW50KCkgKHdyaXRlcyB2MSwgNDgg
Ynl0ZXMpDQo+ICAgIC0gRmllbGQgb2Zmc2V0cyBkb24ndCBtYXRjaCwgY2F1c2luZyBjb3JydXB0
aW9uDQo+DQo+IFRoZSBoZXggdmFsdWUgc2hvd24gMHgzMGUzIGlzIGFjdHVhbGx5IGEgUElELCBu
b3QgYW4gYWN0aW9uIGNvZGUhDQo+DQo+IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIw0KPiBsaW51
eC1ibG9jayAoZm9yLW5leHQpICMNCj4gbGludXgtYmxvY2sgKGZvci1uZXh0KSAjIHNoIHJlcHJv
ZHVjZV9ibGt0cmFjZV9idWcuc2gNCj4gVHJhY2Ugb3V0cHV0IGxvb2tzIGNvcnJlY3Q6DQo+DQo+
ICAgICAgICAgICAgICAgIGRkLTI0MjAgICAgWzAxOV0gZC4uMS4gICAgNTkuNjQxNzQyOiAyNTEs
MCAgICBRICBSUyAwICsgOCBbZGRdDQo+ICAgICAgICAgICAgICAgIGRkLTI0MjAgICAgWzAxOV0g
ZC4uMS4gICAgNTkuNjQxNzc1OiAyNTEsMCAgICBHICBSUyAwICsgOCBbZGRdDQo+ICAgICAgICAg
ICAgICAgIGRkLTI0MjAgICAgWzAxOV0gZC4uMS4gICAgNTkuNjQxNzg0OiAyNTEsMCAgICBQICAg
TiBbZGRdDQo+ICAgICAgICAgICAgICAgIGRkLTI0MjAgICAgWzAxOV0gZC4uMS4gICAgNTkuNjQx
Nzg1OiAyNTEsMCAgICBVICAgTiBbZGRdIDENCj4gICAgICAgICAgICAgICAgZGQtMjQyMCAgICBb
MDE5XSBkLi4xLiAgICA1OS42NDE3ODg6IDI1MSwwICAgIEQgIFJTIDAgKyA4IFtkZF0NCj4NCj4g
Rml4ZXM6IDRkOGJjN2JkNGY3MyAoImJsa3RyYWNlOiBtb3ZlIGZ0cmFjZSBibGtfaW9fdHJhY2Vy
IHRvIGJsa19pb190cmFjZTIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGNrdWxrYXJuaWxpbnV4QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAga2VybmVsL3RyYWNlL2Jsa3Ry
YWNlLmMgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYmxrdHJh
Y2UuYw0KPiBpbmRleCAxYTgzZTAzMjU1Y2UuLjQwOTdhMjg4YzIzNSAxMDA2NDQNCj4gLS0tIGEv
a2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4gKysrIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMN
Cj4gQEAgLTM4NCwxNiArMzg0LDY1IEBAIHN0YXRpYyB2b2lkIF9fYmxrX2FkZF90cmFjZShzdHJ1
Y3QgYmxrX3RyYWNlICpidCwgc2VjdG9yX3Qgc2VjdG9yLCBpbnQgYnl0ZXMsDQo+ICAgDQo+ICAg
CQlidWZmZXIgPSBibGtfdHItPmFycmF5X2J1ZmZlci5idWZmZXI7DQo+ICAgCQl0cmFjZV9jdHgg
PSB0cmFjaW5nX2dlbl9jdHhfZmxhZ3MoMCk7DQo+IC0JCXRyYWNlX2xlbiA9IHNpemVvZihzdHJ1
Y3QgYmxrX2lvX3RyYWNlMikgKyBwZHVfbGVuICsgY2dpZF9sZW47DQo+ICsJCXN3aXRjaCAoYnQt
PnZlcnNpb24pIHsNCj4gKwkJY2FzZSAxOg0KPiArCQkJdHJhY2VfbGVuID0gc2l6ZW9mKHN0cnVj
dCBibGtfaW9fdHJhY2UpOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2UgMjoNCj4gKwkJZGVmYXVs
dDoNCj4gKwkJCS8qDQo+ICsJCQkgKiBmdHJhY2UgYWx3YXlzIHVzZXMgdjIgKGJsa19pb190cmFj
ZTIpIGZvcm1hdC4NCj4gKwkJCSAqDQo+ICsJCQkgKiBGb3Igc3lzZnMtZW5hYmxlZCB0cmFjaW5n
IHBhdGggKGVuYWJsZWQgdmlhDQo+ICsJCQkgKiAvc3lzL2Jsb2NrL0RFVi90cmFjZS9lbmFibGUp
LCBibGtfdHJhY2Vfc2V0dXBfcXVldWUoKQ0KPiArCQkJICogbmV2ZXIgaW5pdGlhbGl6ZXMgYnQt
PnZlcnNpb24sIGxlYXZpbmcgaXQgMCBmcm9tDQo+ICsJCQkgKiBremFsbG9jKCkuIFdlIG11c3Qg
aGFuZGxlIHZlcnNpb249PTAgc2FmZWx5IGhlcmUuDQo+ICsJCQkgKg0KPiArCQkJICogRmFsbCB0
aHJvdWdoIHRvIGRlZmF1bHQgdG8gZW5zdXJlIHdlIG5ldmVyIGhpdCB0aGUNCj4gKwkJCSAqIG9s
ZCBidWcgd2hlcmUgZGVmYXVsdCBzZXQgdHJhY2VfbGVuPTAsIGNhdXNpbmcNCj4gKwkJCSAqIGJ1
ZmZlciB1bmRlcmZsb3cgYW5kIG1lbW9yeSBjb3JydXB0aW9uLg0KPiArCQkJICoNCj4gKwkJCSAq
IEFsd2F5cyB1c2UgdjIgZm9ybWF0IGZvciBmdHJhY2UgYW5kIG5vcm1hbGl6ZQ0KPiArCQkJICog
YnQtPnZlcnNpb24gdG8gMiB3aGVuIHVuaW5pdGlhbGl6ZWQuDQo+ICsJCQkgKi8NCj4gKwkJCXRy
YWNlX2xlbiA9IHNpemVvZihzdHJ1Y3QgYmxrX2lvX3RyYWNlMik7DQo+ICsJCQlpZiAoYnQtPnZl
cnNpb24gPT0gMCkNCj4gKwkJCQlidC0+dmVyc2lvbiA9IDI7DQo+ICsJCQlicmVhazsNCj4gKwkJ
fQ0KPiArCQl0cmFjZV9sZW4gKz0gcGR1X2xlbiArIGNnaWRfbGVuOw0KPiAgIAkJZXZlbnQgPSB0
cmFjZV9idWZmZXJfbG9ja19yZXNlcnZlKGJ1ZmZlciwgVFJBQ0VfQkxLLA0KPiAgIAkJCQkJCSAg
dHJhY2VfbGVuLCB0cmFjZV9jdHgpOw0KPiAgIAkJaWYgKCFldmVudCkNCj4gICAJCQlyZXR1cm47
DQo+ICAgDQo+IC0JCXJlY29yZF9ibGt0cmFjZV9ldmVudChyaW5nX2J1ZmZlcl9ldmVudF9kYXRh
KGV2ZW50KSwNCj4gLQkJCQkgICAgICBwaWQsIGNwdSwgc2VjdG9yLCBieXRlcywNCj4gLQkJCQkg
ICAgICB3aGF0LCBidC0+ZGV2LCBlcnJvciwgY2dpZCwgY2dpZF9sZW4sDQo+IC0JCQkJICAgICAg
cGR1X2RhdGEsIHBkdV9sZW4pOw0KPiArCQlzd2l0Y2ggKGJ0LT52ZXJzaW9uKSB7DQo+ICsJCWNh
c2UgMToNCj4gKwkJCXJlY29yZF9ibGt0cmFjZV9ldmVudChyaW5nX2J1ZmZlcl9ldmVudF9kYXRh
KGV2ZW50KSwNCj4gKwkJCQkJICAgICAgcGlkLCBjcHUsIHNlY3RvciwgYnl0ZXMsDQo+ICsJCQkJ
CSAgICAgIHdoYXQsIGJ0LT5kZXYsIGVycm9yLCBjZ2lkLCBjZ2lkX2xlbiwNCj4gKwkJCQkJICAg
ICAgcGR1X2RhdGEsIHBkdV9sZW4pOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2UgMjoNCj4gKwkJ
ZGVmYXVsdDoNCj4gKwkJCS8qDQo+ICsJCQkgKiBVc2UgdjIgcmVjb3JkaW5nIGZ1bmN0aW9uIChy
ZWNvcmRfYmxrdHJhY2VfZXZlbnQyKQ0KPiArCQkJICogd2hpY2ggd3JpdGVzIGJsa19pb190cmFj
ZTIgc3RydWN0dXJlIHdpdGggY29ycmVjdA0KPiArCQkJICogZmllbGQgbGF5b3V0Og0KPiArCQkJ
ICogICAtIDMyLWJpdCBwaWQgYXQgb2Zmc2V0IDI4DQo+ICsJCQkgKiAgIC0gNjQtYml0IGFjdGlv
biBhdCBvZmZzZXQgMzINCj4gKwkJCSAqDQo+ICsJCQkgKiBGYWxsIHRocm91Z2ggdG8gZGVmYXVs
dCBoYW5kbGVzIHZlcnNpb249PTAgY2FzZQ0KPiArCQkJICogKGZyb20gc3lzZnMgcGF0aCksIGVu
c3VyaW5nIHdlIGFsd2F5cyB1c2UgY29ycmVjdA0KPiArCQkJICogdjIgcmVjb3JkaW5nIGZ1bmN0
aW9uIHRvIG1hdGNoIHRoZSB2MiBidWZmZXINCj4gKwkJCSAqIGFsbG9jYXRlZCBhYm92ZS4NCj4g
KwkJCSAqLw0KPiArCQkJcmVjb3JkX2Jsa3RyYWNlX2V2ZW50MihyaW5nX2J1ZmZlcl9ldmVudF9k
YXRhKGV2ZW50KSwNCj4gKwkJCQkJICAgICAgIHBpZCwgY3B1LCBzZWN0b3IsIGJ5dGVzLA0KPiAr
CQkJCQkgICAgICAgd2hhdCwgYnQtPmRldiwgZXJyb3IsIGNnaWQsIGNnaWRfbGVuLA0KPiArCQkJ
CQkgICAgICAgcGR1X2RhdGEsIHBkdV9sZW4pOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gICAN
Cj4gICAJCXRyYWNlX2J1ZmZlcl91bmxvY2tfY29tbWl0KGJsa190ciwgYnVmZmVyLCBldmVudCwg
dHJhY2VfY3R4KTsNCj4gICAJCXJldHVybjsNCg0KSXNuJ3QgYSBzd2l0Y2goKSBraW5kIG9mIGFu
IG92ZXJraWxsIGZvciBzb21ldGhpbmcgdGhhdCBjYW4gYmUgZG9uZSBpbiBhIA0Kc2luZ2xlIGlm
ICgpIHt9IGVsc2Uge30gYmxvY2s/DQoNCk90aGVyd2lzZSBsb29rcyBnb29kLA0KDQpSZXZpZXdl
ZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K
