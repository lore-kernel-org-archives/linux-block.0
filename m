Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CB2F4A
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236686; cv=fail; b=qYJzcMHoNYknbiMXbWGvzGdolbITNaQNSREX+wT4eJ9telL3CdNkckExlS2dJ9Qoq3nCLkZFpkWZTqR9uP/n6/kJ8FDgataDZAEX5oVGews4HCUcJtFrdljfU9YAV3yKTd4w1HtwCRdBxlVX59dJVX0pYJazSlQZ4JbTgl1PY/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236686; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDp2meniUbNzerNuP4P2EAumM8p56TkldWzlFBaVMBDPt7FCUyG4NffDtUCICNoWi9Pup+eOCcdakK5UKiwXo6F+hFgMWxRfGVv0+kzYJMlxNofHbKx2ap/zM+vyiNLWLdAYTLo+6FD2wTqGgsxR1e6/qBsAxSOJYNbtY5SNqL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HdaDCZmC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JMr0C2W2; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HdaDCZmC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JMr0C2W2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750236684; x=1781772684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=HdaDCZmCQzy36gzGjYNJpeCFVYKLbHWqze/1oPSjVTb614tmIAB67aGW
   g8TaKKM0HLZLj7ncnnScFWfc5og8RqQrfZ7+1Qz3LZHMOfGWkG1Gp8y2l
   lQ+/mnNws7foQMavlsxZQr94nD8GOzWmBTp7y3Xrxo/87pIBEAs0RmAq4
   1snkGAsNOA7iC7IhIFKhebI9OEP5TViqnqklJL5g8xoV38ubUq07sxkAo
   Eq4EZQNisvAOCsZHOhxtpnrOaTxJjHBWOe6McDjFqaM2tGyOXTSRshODN
   NFjaXGtI97esdzCth1HnC6G67eI9R9PHK5cwFF2+nfJFjKgvOwY7hwmu5
   w==;
X-CSE-ConnectionGUID: 9QTeWB12RhSYLlQ91Q+Z/g==
X-CSE-MsgGUID: hnPJDU8xRh+jtQPEOCtJHw==
X-IronPort-AV: E=Sophos;i="6.16,245,1744041600"; 
   d="scan'208";a="90820096"
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.71])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2025 16:51:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNOCsWp1vaVle27Ie2zY1JNjj1rP9O5nNkM/co5R2K/ISH9oKHUMMTvZUnxNbT3dRsD5Su6to1NkuqN2gt6Oa1zW9SaX5y0JPlgIeSCs/0f5X1+Sr7Vt3WJUnLKYNm2D/sOKSzt2UoL/u9AwG5cT0YA+jHiMH/BO4BEuTsv3JTbgDvwXoE7QAfjLvoCdlWcJn8d8cStoYlW/4nVECnKQe/yX6xzUMzy+24n5Qz6zNlPo1Qnug4BnhmsI4dz5aGB7LSzP0K/1cw/7UoIYY47BJ32L0o1K6wwC9qz3eRPUJHGyKpOTMYouZDn1VLCzQTmHzD5mkVNFz/JQ0Zj3dnqsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ABBN33/3sTb8Kn49J+yasvnAL4V7nmPxrNqNPremoP4LXXyZSLQ9/K5bR9Z+RVzBJm8abanGjea6BfvrBbjNtsvYt59o9gJPzU7jknl/Zh21i8jVlQLtB8rZ/1NL4IA3DbUugMz4bhdiQ/ka1oLL7uTRSVND775SUOFX7NkXGJXuF1N8O+f7IiJvKh5tPGmGmDodywH9xrga9uUEYpd1Bg2PX0bXk1s3VnadzksjdQDuH9QowSBmt51TI1PBiTK2p3x5aqEejfymCDZbubQQJNh6HEUcOc0dO/Ivz0EwuV8fSxzd1GOAyBGAiFs3p2srlOHE4SCWRbA593X1nShGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JMr0C2W2vLw9xfBuSeLItuOmu3dbaOl68CpHgYSah6QIeiH/3iUfoZTiDakqj4Ue7SgyEGrx6QldbI1Uj2CMy8BqBVPqMtdM8S7m/LHP+gJzVNzn4/rMu05XimSKBUQiYe44qWFqfOSBKYipxP+OcokWGrM55cP5JDis/HID0YE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8858.namprd04.prod.outlook.com (2603:10b6:208:491::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 08:51:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 08:51:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: hch <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Thread-Topic: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Thread-Index: AQHb4BajM/NXTTsilk+OtMFR16INTbQInCIA
Date: Wed, 18 Jun 2025 08:51:18 +0000
Message-ID: <2f8f3a8a-8931-471e-b647-596b66d84181@wdc.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8858:EE_
x-ms-office365-filtering-correlation-id: 1a23f961-e1da-41d2-28d8-08ddae454ab4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGNXVE45UlNxeFFuMjRlMGNUU3ZHSGQ5aVUzRG52cFNWTDMvQTVNWERJV3RN?=
 =?utf-8?B?UmJ0QTVqZG9yNk5odEJLU0RwN2pUbkZFN3l4NEJwYnVVZitYMGlQUEtxQlpR?=
 =?utf-8?B?V2FIQTByRzJLaUZrcVpVZ1YwcGJyYVhzTzVMRzZPcGlQUHdVK2FqVmNsOE5I?=
 =?utf-8?B?Z2tpQlluNTFNelErR2RzN1VwVG4wWFRHZWZZbUJ2UkVlN3lRL3diZUVBKzZQ?=
 =?utf-8?B?VEgwRkFiUDNuUUpodkJLWVVWZm1hZGMwd2JDMjlaL1c1a0tQNUVoZk1RMWll?=
 =?utf-8?B?M3JlbWhFU0VjWm9xckNVNVFyNE9wZU15VEJVcHdUMHdpYlNpU1ZwbHkrQWlW?=
 =?utf-8?B?V3BnNFV6WTBOSEJJWjMyLzFRcnA5RHdhcVljemlScDlzdkg2YTFhMHp6ejRu?=
 =?utf-8?B?ZGlJeDNhczh3d1h0dnZSOHdXUGVEUEIzWXlFVkFVeDhKUWdCSTJXRFlsNWlX?=
 =?utf-8?B?K1dmYnNjQ25VZlR2NU5xKzltUlZsT05NcVhRWit3TC9rYzJ0SFFiVEY1aHB2?=
 =?utf-8?B?dWtMcUxTc2NXNEljQW9wcG00bkdITG5jQ3J1MS9JcVo0SVNCVXRPeEpZN2lH?=
 =?utf-8?B?MnlqbVV0aGcyYk4vSG14Nk52cDBlUytQaUdLd0RhcThCekFRck1hckM5Rldj?=
 =?utf-8?B?SUNHYWdBakFRYzRSaWhiQWRpRlF2VnhGMXVBbnN5MVdVQy9JY2ZPNWNlOVlH?=
 =?utf-8?B?TDNqNFhBeURncFR0d2lQeUtMSlhROU1TNjNBc0tWckY5QTRNUTBUNlEyL2hz?=
 =?utf-8?B?dnhzOFhCM0lhbG5sK3hJNlhZSkVjUE96amU1ak5MVkpJZ2dDSkFJcXZyZGtv?=
 =?utf-8?B?cysrcEZEckx4Ykk5WG1XSlRCOExrU2NNTjdncmkzRE4rc3J2ZlpPOEcwMVpU?=
 =?utf-8?B?MVBKTUIxRFpGU3JBRGtiU1ZxbVpwYUNIT1FKTTcxK09kWEZ6L2RhdmErN2E5?=
 =?utf-8?B?M3QwNjJ4NmRWOFJUcS84THlEV3ZrUzZoUHRXVm9EckZMZ3hpOFVvb1JDTUJq?=
 =?utf-8?B?VDZrNnlvcFZ3bURwbGVqV3I3UDlyazZ6S1N2MFBnTW5xczRHTEdEY2lnL1pu?=
 =?utf-8?B?NHoyclgzTTJqaDYvbGdpU2ZUejF5cXM2NVA5dlBFbS9aQTFNU3pIR2Qyck9V?=
 =?utf-8?B?OTd1akhUSjNETEhTejdRMTBFa3ZEOEFSVEgySTR5NE94WW4ybWtrN2wvVEFG?=
 =?utf-8?B?TEljNjRoUzBCbnJEblV5YXVSaU5VYTlwOHB1UUozVEYxbFM4OHpGTjEzTU44?=
 =?utf-8?B?YkVYaVNVNGg1U0RJRkFlMUF3Y09UbC9mYzlBclYzUVJCbFRXZm1iUjdHaUJy?=
 =?utf-8?B?UG9nUlRaenpMaVJ2bGh1NzR3bW1UOHkrU2crN2k3QUlydGcvQ0w2WE5CK2Zt?=
 =?utf-8?B?NVNVNmVNcFlTOUNMSkVseHVBSGJJaUx5RngyY3dzNWJ3ZW9JMnlpZWNkQnF3?=
 =?utf-8?B?TXNWNnhlTFgyQjU1MDVNdktaTlRRRHZRanU0Y0ZpUWZxWGh0Zmh4RllYOHJ6?=
 =?utf-8?B?YmhsZnowWUZMN1BrMnEySFVSWjRxUkptV3hSYzBCbjF3cE9sN2NNTzkvRVRu?=
 =?utf-8?B?dmcyK0lEN1krY1FqaG9EN3hOWTZWM0xoQitwQjZhTkZiaThyOXluUnR6Z1Na?=
 =?utf-8?B?SVRXZ0s0UTc2dk03Rm1veFBuRWx6NkV3UWY4Y0JHemF1Q3p0ZTdvV1JFcGV2?=
 =?utf-8?B?NGxSbGsxSVYrZnRoaVNrZzVrLzhpUEoxQWM4QVI3c0lKYTJaaFF2aCttNlJm?=
 =?utf-8?B?eXJ6SXZOK2lFaUFwazZJY2E0SkhTTjhDK09RN0luZWhqZDJNWTZBYjB4OG5j?=
 =?utf-8?B?T0pYUHRUY3NKU1hyYXhKL0J3a01MMkxaV3ZFeUFqN2d0YlJNMXkzOEJmWEx0?=
 =?utf-8?B?SXo4UVd6ZzJrMnBUaFFIWHRCT2ZWV3RzU0l0MVdFVExTaWdKcERDam9DMkxj?=
 =?utf-8?B?L2kzM2J4R29SY2d4SHNGNDlqZTU1QUpQNnhzaXlXU3p6RXFDUVZtTGlFY2dm?=
 =?utf-8?B?aHZ0R0ZMOUJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S294OVJTQjVuRlR4aWJ3cjBRaTluZDdCZTcyUXJsV29TK0tzd3haYjBPT2ZJ?=
 =?utf-8?B?ZzBPNGZsTy90WXM1V01wQkNiWDV0OUNyenBMeXYzc2VzcVpEMnk1dFU0djAr?=
 =?utf-8?B?S1ltK01GYVFoMHFpL01yS0FNQU9jSlZxaXZDalVMZ0lRa01VVnBQd1A0YVBV?=
 =?utf-8?B?dGwrM2pCcm54Yno2N2YzY0w3cHN6Nkxmcjc0alRPMXpkazE1N1lnWW9hV2hu?=
 =?utf-8?B?WDJiK2lrT2pTdVJqdXNvWFgyQXF6TktLOW9FSkxScnhIZEl1SmdhamRQL0di?=
 =?utf-8?B?QWNhUW5rZyt2YlNXcXVGQ25OdTdWdFJvR0lxUmtyM0JLbGdtZ2kwVzNBeFd4?=
 =?utf-8?B?b2d5SndpdTlTTjdTUWtLaERTN1hiMlNQRERNK1BDMzVYZ2hUdXh0NEQ3VXVR?=
 =?utf-8?B?TjNzZXpkdmErQlc1Q1JEQmYwY0p0N0xYdlE0YmRFSXFVb2hpUEUvTjlPeGI4?=
 =?utf-8?B?cnpyZFBONDFUUGV2MCswd2xlVW1TV29EV3JIK3NrOEwrRmNFV3U5RmNlZktB?=
 =?utf-8?B?elRWWG1kVUErTVMwbnhhZU9DMDNaZXR6UWtyWXM4TCtzVGZpd1dBWnoxdDhX?=
 =?utf-8?B?ck12eVdJamxtcFBDUjJhVEk3c3FNL3owUVh4Rm1iMDQzdGc0UXBCUUxDS0Rh?=
 =?utf-8?B?d1lMMis2S2NnUk9xR0M1enhxVFgrc3RSM2VsS3BQRWdTOVhlU1NyYjArbDNB?=
 =?utf-8?B?RmhNYkF3TlNxN255eXhYQ1h6bVFiK2JIcTJudFNtY3RNVzFSWkRnbnovbjVz?=
 =?utf-8?B?WnQwbnQ5ZEF4blNXcHV3WEU3OHlqN3BRM1BZOWU5aEpCMHYrVDQvSWd0UVVx?=
 =?utf-8?B?dm5lUzlkb0lyK0ZDZ2ZvOGRVa2VsWDlkLzhRYXg4N2xtMGNxUjNnZldVS3J2?=
 =?utf-8?B?bkJQdmNFZkpmd1N1WmVwc3kzS3EzNXNjcys3Q2FBSU43RGhTbXo0UkF2ai9h?=
 =?utf-8?B?eHI1WlV4KzVJbytoQytBS3VhS0ttWCtDelhFSEY3R2FBdS8zaWtUMFFMV1Rk?=
 =?utf-8?B?cnZqM1laelU2c3FtSkZJYkw3K1RsTXlISER1NThrc01RNlVDYnFIS1ZZL2Vr?=
 =?utf-8?B?NjFONS9pQThZN1BVN3g1WFJzck8xNjQrTWhNMGJFMndlZEM1aE5Ub3EvY2Jv?=
 =?utf-8?B?TUh5dlR6Z3JzQWhMelhXL3BPeWtCaHc2YkgyeHRvV2o1UktrTmF3Z1Q5TzV5?=
 =?utf-8?B?VU9xdzlYT2NaSllHekJrL0Q4M1k3OFAyRVJqWnd3WVMxK2xlak9FazBLRXRF?=
 =?utf-8?B?d01pTUV5NDRPYWRHalBkY2F1Z0JUWnVQa29YWURHVTFJRUlXQk1qU1pHemxQ?=
 =?utf-8?B?akpqVUhhNXhwaU80MHhWRXdjbU9lb1JsdXUwVUpFalNtdWQ1N3FnOUZzRWdM?=
 =?utf-8?B?K0JoeGNueFhEalZyU2xjNFhpK25LL3R2bytSMkhRenV3cmdyMUMzb3Y1enIy?=
 =?utf-8?B?RiszeFpvYjJwRHVqVTI4cHZMa0FkWlhHVkdaL0N2N0s1YWxQNnh3Q3FKMldK?=
 =?utf-8?B?MElWYitpa0lSaEY4WUhYZ1VxSWZjUjN3aE42QVAyY2Z6L2c2cXhFVlBGdkFr?=
 =?utf-8?B?d3N3WHZPUWFNMXBLcUN5YU1XWkNSdDVKS01PaUMwSmtWeEpIOURSQ2x6RC9k?=
 =?utf-8?B?ZnJyT0cvSTZkSFNGbFNvaWwyOTZ1alZmUUlWanJuYnFWeVRoMVJ5V3VoTEdO?=
 =?utf-8?B?YUYrUjRNYWdoQVliRnJuOUlpSEFkT2FWeGtBK3RYZ3p0bDVtdHIzSmY2ZEor?=
 =?utf-8?B?djBlK2Q3YjZRZU5MUG12azRzT1dTUGVvMnI2QWtYcHgzUDFmdklPOVNtYzFQ?=
 =?utf-8?B?QTJNUThINy9MeXZSR09NWFVNRjgwZGFiS29TcWlMNldnNnFXc00ycVZZaTI0?=
 =?utf-8?B?cWR5bXdvOUhGSW42N0tpeFhMNTY1SXE0R0c4UDRkbURhU2RiQTdNc0xvNWNa?=
 =?utf-8?B?bWYwZlhxWmJDMXhGUXpZYXgvYUZ4c0hUcFFEU2xRc2Z6ZDg1U2tWZU44WmdG?=
 =?utf-8?B?TTNDOWN6Wm0waVBVR0lJcFBVUkFlYksyU2t2K1NpRm1TVkZCTkE1NVJ2NFV3?=
 =?utf-8?B?WmpKbGhKQXRWcnIwc21uOFRqTXRoSHZjNnJsNzcxTGhKbW9HTDNlTThTbVls?=
 =?utf-8?B?U1l0S3hEbkxXbVJ6SksxU28xMmh4RG1HdUxONWVtdHh5VGRUajFOQ280QkZV?=
 =?utf-8?B?N0Qyc0s2S0phOFVrZVNiTm9Ja215TzNQcFg3Zmhabjh4QzA4WWs3YlM1SzFQ?=
 =?utf-8?B?OUZtR29Idm8yUmI4Zzd2RUZraWNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E16DC40D276FD445B6EAB39E46A85D4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	suoLtXcYd3/OrwQ9Y4hjoIR+oMOFQesFGm+7ska8pEgSf2QVaquvCaet8ajuS1U8ROm1MwFPRcAGnWzVSM1T9y7qbVTisM5O0NeiX37NwMc6/+nzEtDy5GbcgvfAjPY8TFbJN4STU7KOES8lAAg9rmlIFLO6hAjVIXiIWK0ECnldPO8DBj7Frbi75HpnlNSA8ry3E646goYGqeKqua6qammsugAWhKo5inKYaLvpGNAIbLqOoR09ZFlzBIKoGCO57DZIo1pX/O6dF5FQwsVONNqGSkumeWS1amjoMGawl10kdLmtK0dG1g3m0eW6Yy8xL7TwHb3Hf7BgN/PI6klDdkXYLYjyK583OEFqKv1JmuV2D5aFD8vlmf1LyE1aASdZDdGmxDKzXYoqyUXslkfeeLLPvhLHiLZFPJXAsJs13YliYMqwlAvf9tNKDxeVyNzShl5SMrqAsKKF0sz3dSlLIhAJXTJ+NI3ktxBThPPr2AUbXbKLtcmLsnPfIpYoDY/NnNdheP3SQO76fErleIIkLcQwUFdnMov6e/8zada/a0al5mcisjnU2mi7ioEy2fRz1DTJwL62PceJKi6Ewu6QwVuitHgZEwSfJFZqCrk9Wlvlwhdj4ixCJITdg7ldD0ZE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a23f961-e1da-41d2-28d8-08ddae454ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:51:18.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84vfxltmsvKviJPi/KMJZhz6lzFJAQjKUwIV56MviiPGnJEuJc+UjCJmwCvTrjg/HCY8oF/rJRgTWAYacc2FlDbUKL2WMwRk5vRtuukLec4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8858

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
