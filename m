Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A023F412
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637043; cv=fail; b=fdahmv+eoTmRew57I8VP2MobIrD/DJrvgZEO/kbKEDAMC8vG09zl6P3RrTz+Je5Yv4hqglLd64cXo1Fo4fo5nvxa0sQfGvcQ27pTVPVWTlEBVdLBh5i7oswfM27SgXsKGxSFJlCFtXRwqw4Yyez3Gbxi/KDzMRBK2el3vh0Fr4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637043; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0KYkghDHT67OXpumX+OeMIe6ofsYwteVYifBPU03ZAgwDgrUoEF5uUpkuQu4ER145xrY+YugT8wSq81ZKGYz0RlQ0MCU0RBg8tKp+gC9r4TE+y1022O3jzJGGdDuQopAvOkc7D6IwhItEQPLnWLTl0+TlceEb/E+pQyzjsnBHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZRXLs9Ty; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LKOEX/su; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZRXLs9Ty";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LKOEX/su"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749637041; x=1781173041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=ZRXLs9TyT2O6IsiNMyoCL76JJ/dfiuRnYxed/m+Ga+VMbBsIBviuaJ8T
   bjrULV0YFiIhto2eKtwsJrJm1V+4muHKRzlN87Iji0CIpU5cJUFFUyb7W
   i7KkaHucsfafYlhRtWDj47jSQLsm9vDGew+s9kZXXn6Dm1b2q2nFgPfAO
   MFhNgpBLUHERz/ESswiNl1H8WAiZxG9FUrQKLdjEWyJKK+XFS9bDFM/tL
   9mjvplSmPRfsaxhVTuNPrg9P2Ao6LMA5UlNN3nk4gqBSOj5XZwU8EYDCI
   EomDQAWxvYI8zCXYVyNeAUYsXHw/RQvgRQqIVL4YSQkBD1WHtik8sx9P3
   g==;
X-CSE-ConnectionGUID: ZgWW+8H/QlSVLHXsHtG5kw==
X-CSE-MsgGUID: WyHT0bNVSgCylrAQQmi7rQ==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="89303141"
Received: from mail-bn1nam02on2065.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.65])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 18:17:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2MeULURpMAM3j/UjdnJDeii/hM0fMP+Hrr5wDVEEiGTKfPZE4AMWV0UyxMqU0Wa9GzBlyOmVk/8p5I6DI+r+UYbkEM1SAfM4k6lgXDYpb7mUn2SPvd8E8yH4vQDzaibCwdDy+OyI//zzOirF+Z5k4utU3o2jc01nmlGytL3vZ+CQ6UbMt9LeNdRQV5960PiHKzBhj/+J9wN5HMxrKF4oulvseQL5QG8yGKXTaWqqENOSXmMkZdTMaoTFB3hs4R9+K/JG7LZTAdrGjnnRBJWmVq3AVn1wh2N+K949Vp5iudguQB3Zsom8g/wGz3hwxYrRqGr7kqDeKJBOc01wCOxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ouexUBn7LTnLSADWde+QP9Pd/OwEobgHViIHrf77Hb9kyw1dUXtHCdLE8vTYtrUcYHqwW5WyuOKXtunPusMyR0caiNhYDYhKuLM3xEDZ199K7gwKDJS2W0cIEdkCCTnpRdDE9smgzoanuib0Wk/ZJckj29EeZTnFGscSpDnc4Udbuj+0y8m9zGK68zs/ofAD8KDiErsV921waYjd+97g92kWWL7r8H0cGBlP747BVVp9zM2NSpxzHowlXJY9qM81WmvV8TFg1QvsmSQm9fBmKpnUNKo2iELNn975nHnMJHmpRgAPds3sjUumvsM8I1tYNeckwO2DXEdJY89GPW+Hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LKOEX/sugB2x2+KOHwsjhBygadqF6zthYMB0R07tSFcjLPiDMZLtxEYeNZntQk/HMqYKRdME/CXw7NZroUigCsV6lXEIGJGnJ/kgM6Rhp7bdhMuQC/mRiGWWM74qbEm11+c6Q7/9D8F8b6kqgZlnvSCikjIqoLI4gOAxhZ8vHrQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7236.namprd04.prod.outlook.com (2603:10b6:303:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 11 Jun
 2025 10:17:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 10:17:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van
 Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
Thread-Topic: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
Thread-Index: AQHb2ouH9Q5FBuhu0UOIrSimzn3Ve7P9vuWA
Date: Wed, 11 Jun 2025 10:17:11 +0000
Message-ID: <44bda857-46e8-47ee-8f2c-30956f14bb39@wdc.com>
References: <20250611044416.2351850-1-hch@lst.de>
In-Reply-To: <20250611044416.2351850-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7236:EE_
x-ms-office365-filtering-correlation-id: 7832b1f5-1df2-4dba-7050-08dda8d12184
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVpjRVdod2dTWG9ON0p1cnI3VlVkd1FHa0U4V3JFWjdkT0FLUjVKbVQybkJY?=
 =?utf-8?B?SWo5TWVYUDQ4SzRaeXV5dGU3QlFxclpld05LSkZKN1pBTWhGY0dNdmdhZ1B0?=
 =?utf-8?B?Rnc5K2xrc3N6SWVNZlBBbkNaWkFVcEo3ZHpnYmYzL3N5cDIwT0k2RmJoTTl5?=
 =?utf-8?B?V2U4WXFITHEzNEZlcy9tSTJGa2llR2YwT0hBRWJkR3NZbit0NFc2V25mY1h2?=
 =?utf-8?B?eUJDTlpHbVR1MllwbFdScFpqTStDT2ptTVYyR250QVBNUTQ1Z2cxNjlRbkN1?=
 =?utf-8?B?aXZ1TkxiZFVwV01neEQ4QlRXcFAyNzExRGlYVDc3a3dmSzBrSGtLb0pVV1pW?=
 =?utf-8?B?bkl4bDYrM0w4VkF5Ny9JaXFUdVhObkZUMHRsZ0tnOHdpOS9xcUVnREV3cHdm?=
 =?utf-8?B?NUFUdGpNTlV0UlUyZTA1dGNJaVFvWHNhUTV5VWF4V0FaVkNHUElObFcyVklx?=
 =?utf-8?B?dGpWanl1a1grYUtqNmNJNTAyU09KalRHWlE2Vk90a0Y5VGwxcG1WTU05dmhj?=
 =?utf-8?B?R3gzR1J1UFZqUDJFeklzcjRYRTFCQTRoS3lGMVg3b0xyRC9WNzhoS2Z2T3F4?=
 =?utf-8?B?NURhY3JLRzdZRE55SS91RVlEUElJWlkzOGVObE0yVENvdTRnY0gzdzdWNWNR?=
 =?utf-8?B?blVsUVl5dFZVT2xrWHNIbUFMaG9EZG1QTWNxYjRDTGM2bTA2azlNMjdsQ2FN?=
 =?utf-8?B?T2hXcDVKNnQwUWpoT2U3MXZkdVlWb1p0dTU4alIwV243MzNyNUljdXdoVW9x?=
 =?utf-8?B?bTg0M1N6c3ZPcE5kcXd4UUh4SkhpTjBrYmlmQW0rOFhpZm9ra3VrOXZ1K1p5?=
 =?utf-8?B?c3h3VENYb1hhSEI3TXhyaXZLUklMTVIwaWtYYlc0UDV3YytrYWYyV0piTVMv?=
 =?utf-8?B?K3lTQUZrNm9YOFhzOWlhUC9MZkRzT0tvMTZHY3JoU05vS05va3dIZkpzdkUv?=
 =?utf-8?B?aXNZek1rNWRReVdkVlZUZUxTNTRETVlvL0R2dzFmbnQ3ZmhwNVFWTm9MUUpp?=
 =?utf-8?B?bGRmd285Z2ZGUVJMSGgxS0tTNThYcHo4U1hMeEdYbTlRRFJ4L2pjcnc1S2ww?=
 =?utf-8?B?VzRPZFlZUmtteHQ5V24wMmU3OHF6eDB4YnVFNUZSMXNjY01FM1ZqVUFyVE9p?=
 =?utf-8?B?QklzUFZMRkpYdll6RUlsMS9wRm9NWGdsRTRIUDcvMTJGbjMwcTBIekdwQkZ4?=
 =?utf-8?B?VEIrQTNaanVTNXVYcWVVN0diWWt1YnRSTHJqUXlrVlIzSFMvbElxZXIybjR1?=
 =?utf-8?B?Zjk2eG16RnY5cDBqRzRYVFQ5eEJlU2xsaGE5KzFBVWZkcVNlRWtxUjdhMDJL?=
 =?utf-8?B?b0ZER0FkU0pMeFU1dVpuMVk0M2plRzlIQWoyM2tKbDFWbUxJekErUmFINmcx?=
 =?utf-8?B?bWNja2JXb2RuZWJjVHFTMWNiZUFhWFZPVVlUZ2R0OVpubnlQb0VoNUdtZHdF?=
 =?utf-8?B?US83NXNiQjJTeWJPNVpiaEdjeWQrQk9lNGNTSGdYKzMrc2d4b2xHRHVDNG9V?=
 =?utf-8?B?NjlIOVNOZGhJbjNnL2pGR1BKQjJSWk1sM0lhYnFMNTY1ZjdSdk5rdXpseU0r?=
 =?utf-8?B?VG8rS1JHYUdvc0pqRUVjamI5MlZDbkFWVUhNL0FLYm9XR2labCtrMVk3eXhz?=
 =?utf-8?B?dm51VncyZm1jY2pwWDFyL3ZGRlE3TTVVNHlRZXhWQlg1dVBsbnBYbUtzSDlJ?=
 =?utf-8?B?alpMYzF1c3BJa25tU2cvK0xvVXB6Rk13MXNQc1ZLVzJxL2JKbmFYcXh6U0FJ?=
 =?utf-8?B?NVlWQS85ZEg0MEpBelZNTjYyeGV6WGlxdEhVSllYUytwVW9Bc2Jvd3MyMHRY?=
 =?utf-8?B?OVlEVzlOd0lKS0pYaUJXNlFKcFVjZDUrcnYxYkJzcmJTa2RoZVA0VjdmT01r?=
 =?utf-8?B?Y3lGV1BycG9xYi9YNDlSc1hiQjdEUUVodHo2cnRHYlREQ2xCMnVSeURObXkv?=
 =?utf-8?B?YkJLbkQwa2Y0Qnk1Sy9NdFN4cU1OTm5QT1lkQ0hvWGROcEhHeFRuVDU3WXhU?=
 =?utf-8?Q?IqQ64ZGraE97SasZkSjX8o6GCxka9w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlRGN3JTa3haUE5WbmJrdWpkY3hYdEIwTmI1NDkrMnVOMTdqajd1RnJwS3kr?=
 =?utf-8?B?VmlaVWdlZkRvcU80Q3VSSHNPWURxLzJicUlZZVVpK2p6S3pSM1BFMmdqUWk2?=
 =?utf-8?B?T0hFUW5pWW5hdStVY2Mxbi91MnduSE1SQkdxTkUwV01hSXZOdU5EdDNzVC9Z?=
 =?utf-8?B?blJ3cUFBREgwbE1FQjdva2FkZVd4WmJXWGVyaE1CVVBvWFNURUcycUVSTDQ3?=
 =?utf-8?B?VnkzNFJZczRCdzk3bi9zZVQzZ1V2Ynp0OXBybkJIRWJkOUtTRVJWTzJRWkcv?=
 =?utf-8?B?cU1kM0pCUytNTG5Rb1Y2NFYwUHJGdmRRZ0hyWllxbkhCSmtTUXFPTDd6VHlP?=
 =?utf-8?B?bGNDVDJveHJrQmxkM2dRTUhOSDRiTWEwSVpsNDNYc0duckJKZmFTMUVQY25v?=
 =?utf-8?B?a0oremNwTTFzU0JEbnBuK3FCU3RjbTJzajBsMi9PYk1nS0dYR215cUpyaXo0?=
 =?utf-8?B?SHhSVno5T3JKUEpMTFg0SHZ3S0JrSzNjRUtDWUpkbjFzclZneGtabW9VcXE1?=
 =?utf-8?B?RzQydW9sWnA1SncyK3ZPbGpYUWp2c2g5eGwvUTg1YzBxd2swa05kTktPcThR?=
 =?utf-8?B?b0dFRUN0Z1FFN3JpaUU2VzhYb2hkVzNxUHEvZ0k0My9sMzdYbi9kdndHb0wr?=
 =?utf-8?B?ZnVYY052T2NYT1NiRE82NldaSlFOQllXekdqWWt0azdOSWlkU3Y5bWlsREpt?=
 =?utf-8?B?d1BUcUFaQjFObEtpUXR4VUFGdktmNjJLZFdxZUwybVRGR3RZNExlbTZ0RUpu?=
 =?utf-8?B?ZU1yd0NzMlowNjdlTWZ4RjlhRkppRnJCTk5pRjY5NVUxSnJxNkRWTGIvVkpJ?=
 =?utf-8?B?Lzg3dmdOWTJTanE3NEsrcUNUckt2RCtBUitBNnN3SzFETGZ6SmRiUXlZTVhL?=
 =?utf-8?B?c3NHWk5UYzZJUUVQQUo1dTNIVTh0TkJwUlpDWEttMkJpMVJMZ3dWRlRvVGtw?=
 =?utf-8?B?NUtYQ3Z5REpkei83NWtkYUVITmRpOS9kSkd4N1ppQ2NQU2FYZ3JNb0lDSU9H?=
 =?utf-8?B?MnJJcTVPRG9KRjdLU0NQbFlsVW9IcUZtOTg0MWV3TjFkbHVvVUtBYTRmVS9s?=
 =?utf-8?B?bkdjeEJjb256OWVzRms4T0h4dVVOSUhwNVEweWY3dW1ROHJlTlJGR2JDMTh3?=
 =?utf-8?B?MXdiY0t6L2ltL0dLQXhDYzJObUZwMldXTUhWaHpzY0RaQkY0OHJ3bmpWTHhJ?=
 =?utf-8?B?Y2FJVkdwNTJ2bzk2QktiVFltS2dtWVJxKzkyb3R0NUVRK2R3Q085Z0ZNeWln?=
 =?utf-8?B?cklXU0FWdWZaRDJjbE1aSlEzRFZoUVNKb1VzRGtqVjFvY290MTk4U2x5RWxs?=
 =?utf-8?B?bGV2WjZTT0V1TTlQeXdJT3FrZUFXTzM5NXMyd0g0MmhsN3FPNG0rUmdrdmwy?=
 =?utf-8?B?RFBrOGpWYnpERWJwcWpQTDNTWm02cXZWMld1dnpXczAxbmZWV0V1S040UTF0?=
 =?utf-8?B?WjlDS216RTZ1Q1dxNFJDQ2JFVlUzQzI0alNlUHBMQWpMMmpsYjlUdk9jWmV3?=
 =?utf-8?B?VjlpZ05aWXUwSEs3MEcrVGUyTGxMaXFZV0NEMUxKZDdNNVVSMHppeXZKTFdS?=
 =?utf-8?B?QmNlVXFZNXRQYitxVHlaMmV5dFMrbmlpbnhQanhTaktGNkNQakx2bm1VMk00?=
 =?utf-8?B?Vm1GREhvRmNHbTZxd2UrVExQR1RQbmJSTGwrRnhNWkwrR1IxUVdnQTNyR3Er?=
 =?utf-8?B?Si94UE1pNlZkQklDM2tKYmFaSWtCYjhjeGNFVnpybDJnZlE2eG1ybHdzb0wy?=
 =?utf-8?B?WTEzaHRJdytGTFFCN0p6cUlGcFFCbkRKTTlVL2dWQzRFQ3VRcXFpRTNDU2dV?=
 =?utf-8?B?cnJqby9CMnZtYWl4RlFFeTRmd3FiMUJ3ZUk0L2FNZ2wyVlR2TWMzR3FMSk9k?=
 =?utf-8?B?NHNXbTA2Z3lvVHhTTUZjM3VjV1FWejhFcWV0ZWNJUlFEUk9zcUNhNG5kQTNX?=
 =?utf-8?B?bCt4bUdwVW5lTXlwNFlaT1hCTzFlV0VqRG9GaUlOb2t0VjlReG9wQjErQmNH?=
 =?utf-8?B?SXc1QXdtVzVwMzNzY0dOWHdXbUJETktoWkh0NExkNmdDMk1iRk8vbkpuODlK?=
 =?utf-8?B?WmpEWTllTmZGREV3NDR0aUdGcllvQlhJS1NGcFVlbng2WDRDc0ttd1NadGds?=
 =?utf-8?B?N000MjQzUVIvU1ZqZVduQW00TmlCNVVmdHo2WUEzQk9HYUdVUWRjYmdBbHRP?=
 =?utf-8?B?YjNqamhHNTdhZ25PSTl4ZUlVclhrVG1pSDBwOXkyTWdoMVk4RjdNMDh2cXNy?=
 =?utf-8?B?bUE1eklncGNLUHlNdHhoNWYzQ0JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BACC4BC58402944D836C0AD3A3CFB374@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jBHuODGObLi09nkkiNHffLPXnQsOZmCN6hKmficaZ+0lbV33HAWlhJ+tuPNmJk/OmfpMBj33VUN2JO3jPSeFpHT7YGL2GBEMn31/XieU6RqnyRWFG+oG+OpGvZqS41AmguCXYiMiNblN+86nlk52CifgKgpxf03xoN+5q9oKSueuVmAZlZB0JscL8qBHAxrW7a1TSEw8OtAyorPzqnqIvf8NC7DfcqriQVe3b5iKrjsC2ZEu3Hr7pAyfNHzI5Oy3J1ggPNt6nVIYJ1X1zUC3ZiN5+UuUIFsGPzRxN+3MJ0rlA+ZrxebmKRx2FxL5KGhiK9K7zbMo86dZx5ytCQ0SdlM/ToVuSVVNbSgMEldzEg228acCnu3atRJ7KJeVXptEhP9qPaFMYMFfsxj+S7wJzvFjYRxbRbNmX2pgYNcQbJTfNYxuNLirIVItuMoX2u0Z06ed0mCyw6wmNI9uUDAtu3XhAmGPoslbSNsAzY5PdAzgED6mrvzKGyUKykWUSoJORvR7ZAbXxsnD1Df+AEeMNEwIMT5H1L04ErkfrqwS7fmO73/BAOgu0uaBQ/RSZhTTqWzzTwZJ7l8xDHgqWtyE9Pv5nLRu7wMX4wARJu7if+OAPXaSlBfMv0Y1STt+qrwG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7832b1f5-1df2-4dba-7050-08dda8d12184
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 10:17:12.0036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2eh4Va5DM193rfWNueMLfw8rI7gOBpKIgs2+oP1uWIZfP23fHwTego50ATcxFZYb6lCBKT27u6bvRbSFpOlJZkKmh4/sVt4Tte+Ofx5kvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7236

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
