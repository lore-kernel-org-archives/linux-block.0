Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0622DA1F
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488631; cv=fail; b=pxw3CfFQ99zjBP74i8eh18bJA3sJLf839k9yoGvRfzW6VK3tfPDQbXVsyv1NhGDVBbAcDOqK2BEOxCorTLBXumpZCrN4Y9HzpmB7m/XoGgowcqv5iPY9OmMXUht7w7C2Y6enbml91B5qNPMsWBsnsednOdO2+80MghLq1NsyiwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488631; c=relaxed/simple;
	bh=11pW3aMSTUYBWwW/yFcq3S8owgtSbFgGHoWXJOc0BEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mmQZRo3xoVugrw4Dqq5wfRUDGsIdL82DX4X7EP6nVy3N7psL8Iag5Kpsbw0gWt4n9ECnzeczUOJW2i0mmQpZPXpbN87vwJ6tC1m10mEsvul+CaXxsVnvvJp/l0wehoCmgLVSJTLW9eElRsauBV2eeg0jGqn6sEnYISILs7CRoPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lMzRhA37; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=twmQ/VPg; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lMzRhA37";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="twmQ/VPg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752488629; x=1784024629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=11pW3aMSTUYBWwW/yFcq3S8owgtSbFgGHoWXJOc0BEc=;
  b=lMzRhA37eliHJ0hs0E9EOVtAEk2wLfzSHGsfZQH5GHDt3LSkTdgSBokB
   nlWtSdcMDWkNlz8hZi+hcI0h8iYraZuuOAmc3aMorFmnRRp2RPpb1YC5p
   RejPrkhG9AD+ALb9R/VxhLwLZDMAn3zBqf86n+eiDy5/K+z2GLN2h9G2C
   UprQd/DHWhBZF3DRt1JJp1A48ciULzM1jTl/WJYVRm5xHdzBRd/EA21Lh
   fF+Qne3x6lIuwJdSvQjT0fsDUxpFGn88MCiBXXwc5wEJpzZFeXp22fZlI
   oH7WETiCcRLPxaFJsLdPg+edcXbbYmxyQRd7LlImVG1d1UJEDm8JOPc6a
   Q==;
X-CSE-ConnectionGUID: SqedwfTgQ529Q0dgEL+2VA==
X-CSE-MsgGUID: geQg+10vQTSW5MPeFOuiBg==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="92923290"
Received: from mail-bn1nam02on2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.47])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 18:23:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohS845iTc2pDBmMYhb2n5FQw8nuwl0TKiVANUm30HVhs2Axa8v8UXATkE/qoN96CvogqSzFKY+op+c2qPwntMoyFExRM9fozGV3Fh7opAD9fUsfAc+i8tIrJJALGR/KAZ1NFTUrGmbDkv6GK9gj7Fq2XClhV23MfOUvK9Xzk3SjllTIs0THZUUSmFezwutjauYNRaBMNV2VxGMXCfIlLWyCQGr3BJ47BZ9ihXyFz+MniADh6DO2HB36efmZOBd9NOeWjmz4gecGQVnRH15HQvlRMAP2sBc6ncldXessSwAf6LRtKW01uU+bk6RBQ+owwpAWSdEOhym/t2sJ9Wpr52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11pW3aMSTUYBWwW/yFcq3S8owgtSbFgGHoWXJOc0BEc=;
 b=gDbUeSch/ZVtAG288UgG/89gxz2LsDj08Ar9hxFq+Eb6UvRZAzD9cTey9preLSN/y30kCaFSkxaIM89U7h1qm8VLr/DpzgqsRugg1vHjwBIJqsAhdySZMVYp8SQFjfIMAB2ecH73RrtnKr6+unuP/1vwpXVtSQmCOq/vFwEeXYHesuflvYOGSHZ4DPpqweAbdhpYt8BRhSXLVIfuVLtu68txP+dBIn6otOOBZ6VEW296tWODWF/0yHvo7sqXIphsq1dv6Ps88SW1C7yvZJldqSc6Qo61nuqD/2M4UZzemFCmNui7CUF9/fpJYXJlf93YVfy2lNN2zP27vLTvUQFWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11pW3aMSTUYBWwW/yFcq3S8owgtSbFgGHoWXJOc0BEc=;
 b=twmQ/VPggrV4mxi7mrPHze1X3QPtd/1zCsFVr1bXPfhBWZz43xsA5WQEf4RQnrlG0yj8J8nhLZmYyrPdGyZVGQDcPHxHX88NbVY8cGd/9VYIF7aNBBpBwQW8YJigbJbsHFgkcLMDa9zL2y6Ft9k0F+jFcj5z4aYYp4iZPGuncSA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8389.namprd04.prod.outlook.com (2603:10b6:a03:3d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 10:23:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:23:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Topic: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
Thread-Index: AQHb8Mc5SBDvG05QgkaafWBcWGVVyLQp61+AgADxhACAAKWhAIAF7q4A
Date: Mon, 14 Jul 2025 10:23:44 +0000
Message-ID: <c53e8414-f3ad-4eb7-8963-8532790ccbb2@wdc.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
 <07fa0a60-1541-4201-b4e9-b02a994c915c@wdc.com>
 <6e25e109-33bf-413f-812a-69a7f33e783e@acm.org>
In-Reply-To: <6e25e109-33bf-413f-812a-69a7f33e783e@acm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8389:EE_
x-ms-office365-filtering-correlation-id: 3a251de7-575f-49f8-f334-08ddc2c0835c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWVNcUhBZ3AzUWV3WmMvK0Z0NkxHVjVYQURsQTl3UGNDKy9sY2VJYUErRENs?=
 =?utf-8?B?Zk51Q0lxUTA3c3V6cmtYYTJvWjNnWjM0K3pQeHJJUUI0MTZsWXlIUGw1TVdE?=
 =?utf-8?B?SkVnUVFHcTlldVBaWjgyUDNCOUFkQ2JFRXRtbklZQzZPN3daNDBUUkp6UnhN?=
 =?utf-8?B?ZzRDRWtxK0hvajBRNEZSbEhJRjZxZ3JiOEtYK3J2dzRqMnlZcVZ4bGdDdWVF?=
 =?utf-8?B?RGVpbURXeUdCL21QMG5HTitsRGhCYkFWWVZ1OEZadVFnc0IxQjRZTWdmM2k4?=
 =?utf-8?B?cThCVDNJa2lMM2o3Yi9oRUptZ3E0a1lrVUZSa05zSjYwams1bVlVcml6ZFUx?=
 =?utf-8?B?eXU4RkpyVXVKa21rR0V4VmhXajVYYUp3dTZUUHQ0RnhRZFlsYjJLdUdaenEz?=
 =?utf-8?B?SlNmUUt5QVNacUowZGVUUnFZeVNtZXIraDU3QmNGajNkc1hkK2VmTHMrbExD?=
 =?utf-8?B?aFF2N1RZMXFFV0pNbjJWbCt5RTFmRnVaUVF3RTZxa05OS1o0RWR0UDJubjdz?=
 =?utf-8?B?cTNVRk5TeG9xdEJpSXcxaUxOeW1IR2thQ1Z4a1VWeDR5cVdZQlZCemUvck81?=
 =?utf-8?B?RnJXK2xEVlZoRTNEREhkejBueHJwb2ZNTDM3R2g2cG1yZmN6WERiMGNEWjJ6?=
 =?utf-8?B?blkraDRuUFNuWG43VUVSeFYrMUtGZDRnVGFSN3Q5R25Jb3RvVVlWcXh0U1pI?=
 =?utf-8?B?bUF1TVFFWTQzRkxSZy9qd1pmeUhZZXZDRFoweUUwSjhQMFVJNytJUjJxbW9p?=
 =?utf-8?B?blNlYlZiNWtyRitXeFhyb2xVdmtvOGdLSnQ4L2RzcDBYZ0xFbmJQV2FBUGxm?=
 =?utf-8?B?WWIyMTVyQzdKTHl1eTNjR21hZHNIR2szdFNsTXhIYXR1Ny9jSFRyR1JKQ0JL?=
 =?utf-8?B?NGxUS3ZVTWNMbUMyYVZkSDdOY2kxTnZDSFZUN3BNREhmam45cm1OSU5RYXVR?=
 =?utf-8?B?Q213cWNQbkp3RUtHRkZrek5UOHBsejVmSUd0SDZMbk1NVHhtb29jY1hWdUlW?=
 =?utf-8?B?VFVOZWV2M1lCbEJWS1paQWJYZmJUZ3I0bEhwOFZsWCtZWjRacTFiTmgydjBJ?=
 =?utf-8?B?ZUROVFhiWi9EYTJ3Tm0vRjZFL294ZXdrY2hmT2VHN20vLzdOK1lONG5aOHQx?=
 =?utf-8?B?cnZqTllGaC84Y1pvaFZOam9MVFJCU21PNmFYeGxYS0xFVEdCNmhMakxvM2gy?=
 =?utf-8?B?OG1Zc2pGWVUrV2tvVmRGMnV5anVPdGpJTFNDdEc1WHVuLzBpWklxNWkrc01K?=
 =?utf-8?B?di9EWlNzQkRyRFhaemg5cUFHQ0tabDNOTUd2QStzZUovd0R4UVMxbnhtaGxZ?=
 =?utf-8?B?UTZXQzZsRnh3Z2hISE9jUGhxekFwSGlVc3dLdnFIMWNMMk5VdUMvSzFtWlh6?=
 =?utf-8?B?M3Q4UkdKelB5UHNWWkI5VElvcXZ3cTdpTnV6N3VPbHdSREJVb2VuWEtjZXV4?=
 =?utf-8?B?NndLN2lKYmRZU3d6VXdPOTI0OGJPM0t5bzd2cVFWL08vTjdNRGJ1azN3RCt4?=
 =?utf-8?B?ZUIwYmUzakx1REp0UjljSTdxbVNBMTZramdFZmV5dnFmY2tWcHJjNjYyeW51?=
 =?utf-8?B?azB4UEhUdGRzc2l4VkI3Y3o5dW1HdEs4WmFOa1dsWDRkUEZ0MmVjQlZkamtv?=
 =?utf-8?B?M3BHL1ZZbEc2M3ZuWFZKdmxnWklSYkk0RGJNa2NUMTN3Q2VzRXVKYTNIUWJI?=
 =?utf-8?B?Z2lCZFAxSzIyZmxGaVVOL0lHOCtUaEROdlBHdHNnd2Q4dUVvaWFNM0kxbGxa?=
 =?utf-8?B?WGZ4SFhWd1BGaWZkVlZuYmZabzM0amN1WU1tVjJuZjlTRlZOUzNEODlvbVFR?=
 =?utf-8?B?UTU3WkxJR3FVMDZLamZjdUlTRjVJVWgvdUdtMEFiR2dyUTJrSW82SlhEMmpL?=
 =?utf-8?B?OTdWeS94S3V4b2pjclRtZHpKV3FNb0FGbXJDZkl0VWE0K0xNelRXTUpJNkEr?=
 =?utf-8?B?dEdtbVV4TjhORUsrRjVxc3V2dXQ4MlRrZy8yRExhd0RzeE1GdDNUQkpsR2pm?=
 =?utf-8?B?djlxU1l0REN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y25MbHFyeFBickx5RzFPZnhOZG1PdEpDRUNLMmkzSEZvVnBnckprYkZ2ejUy?=
 =?utf-8?B?NmNlNWRqZTE0c1psNlVYaTBPT21LcG1lOGxHeHVobWhjRkhlQmtQd01aa0hh?=
 =?utf-8?B?VS9uTE1YRHdDaU9IRnJEU3Vqb0xvM3UvTmtHdEpwcVZSWGVDU2FHdWVKNzdF?=
 =?utf-8?B?QkpYV2NOS3JETVJJZHc5bFowYUFIMFV4NG9QSDFmVWo1dCtxa1VEczdTSi83?=
 =?utf-8?B?U1BTaElFWEVvUy81RlB0M2tEQjdEQWZxRDNYYzQ1SlFWZG1aNGQrb056dkRu?=
 =?utf-8?B?VzJvUm1Kam5mcFRJdk10eUJrTE9lREZkVEJKRkZQb3RDZHUrZmtWL1l2WFRQ?=
 =?utf-8?B?RSt1Mm5Zd29zQmJwbFhBcGhDQnBWdmVqQSs4cXVnQkFEdXp2VVU2ZDZoQmNm?=
 =?utf-8?B?RWJNWDE1N0FhS1hCUlR6dVR2NUNhSko2QjlBS1R3aHNvcklEVjM4WXNzRUpK?=
 =?utf-8?B?QitkZFBqWlMrQjB5T3RVaExhbTAvb1RlOEpLb1NkQUlMck9Ya3JxRU80S2Fx?=
 =?utf-8?B?a2NKZG9VSGVuTU41L24yRWNPb0pYbVJObThnbmJpWVp3STVGRkdCanBZTmI0?=
 =?utf-8?B?SVJHeUs4b2dvOW9BMU1CNEJQeThyRCtpem91RUt6RVR0Z09JTU1TY3gvWDZv?=
 =?utf-8?B?MUFZL2k5cy9RMVcvQzcxdVJYZnBMTTBOZzVOMWhXeEljZ3RPNCs5NkplY2Rx?=
 =?utf-8?B?NEo3aHdFL2ZCOEVjYkprUnFXc0dIb3JSdmNyRzdKZWtKRjZVSVRObTdGcGZr?=
 =?utf-8?B?TW5PRWpENHFWQ2xwMXZLQVdrQVQxaENoTE9JYklUZnVwV1BmaUF0aGVieXJN?=
 =?utf-8?B?VjVaVnlQcGhRQmFNMzBoWTBWOEtCMEFGZ2wvOXVFOHJZMVk3aENFRW1Yemdi?=
 =?utf-8?B?dVVhU2U2OEMzVmpmUE9kZ3BJYzd6ajhJT29XUjZwbm44dzhuczg5bG02cjZV?=
 =?utf-8?B?YzBlckc0dXcrZ3E2WGhnbDdLOUYvZU9UWnB5ajFIL3BKTjFiWU1GNEVnWEcv?=
 =?utf-8?B?R0N1T3RsSHpVRmZqQmsyc0xXVGJWSnNycXd0cEloWHZkcE1aeWpneWw3RWdz?=
 =?utf-8?B?TGs4RkROSGRKcEIwbzlqVndTaUYrUGVHWGtJMmdYWmlNTHFNSzUvZlZMV1Jk?=
 =?utf-8?B?Nlc2aHl1VjgyZzhSTkNDU0NZZEY5Q2hlRGNhQ2NlNlZlSTdWUGYxdDZTcFN0?=
 =?utf-8?B?MXBLbXVRK0R3NXh1QU44cEkvK2xLa2g5RXplYVhVOG1tZW5KMDdvdkllUWRm?=
 =?utf-8?B?WDFXR3Z4Z2RlSEZVZWh2YWQ2RnJ4bGxJWXlLV3ZSc2JOU1kycDZCbmFXM1B6?=
 =?utf-8?B?b1lWNHpoV2twaHUyU25SSzVIR2syWTZVdHN1ZXZYWU5NTzNxNUQ3ZXgzVFVn?=
 =?utf-8?B?RkpYVGxIcEdiUGhzbEpRWm91akxGRkRCbnVlcC85c0VlVUk2eXV4dFdlZFBp?=
 =?utf-8?B?cmIwekM4UGFwUTJiNGEwRU1qK0xWVVdFSms5bVVWOGNYL1ZxdWZoR2ZzaFBy?=
 =?utf-8?B?blJZb0hWSjVrZkhCdkFaaU5PKzFMNThuOEo5YVdnU1BsR1NuN2p1V1RuUHZ3?=
 =?utf-8?B?OEp3VE11SUJkZlBFVFNFczduRGg4ZGdZaEovVVBaSUJERFQrLzFUOTlqbEk3?=
 =?utf-8?B?RjRqWVh5RXFjdi9zbzJIcGc2cjBZMmd2UDRZWHJYcVV0bUx4REZJcm1zZ2dM?=
 =?utf-8?B?YnVvT2l1M3QxZ1IwajNvRDQ3d2pPcDNZdHhEWWZ1SzdFTEluaTB6bnVvdDl0?=
 =?utf-8?B?WTlrTkNtTDRFdzE3bkcxdG12Q0xaSGR0UEJyVjh5UnltM3FwYUlXZU9TcXlT?=
 =?utf-8?B?S0NZOXRtTDVJaGY1VEZxQURPTnNpbWhVT1VvOElCMXlGUU5hK3BqeGtacVJL?=
 =?utf-8?B?YkR3ajRoNlVpSHRLODhMN1Y4MGcyNGl5dXJPYm9id1hqQk5BbU03MWJlU2dC?=
 =?utf-8?B?VnFkaGZ1VWRVQzF4TVVpaHVmUUp2RFA4dEtNSU5USlh6VUVnbUZrMWU3YXo0?=
 =?utf-8?B?T21wT1A1V2FwSHZWSisyVDVPcWhzOXliN3NadGV2eTRUdmpUUW1KaENhVWgz?=
 =?utf-8?B?UkVTZVJrcXplTzRLNm12bVZzdDJJSFVkTjlDZmE5WDFYU0xLVjhnUi9rOG9C?=
 =?utf-8?B?SGFPTnJtYkFQWGd3RFZDaTgzdUxmZnp5UGsvQWovb0FmcytLcGNzNHpCak9S?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C27DC6D0A06E6479FAB18BE493EEC96@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/MAu5+WPtZ816iXCZJvYtNfNUQ6ExNVdzF5/gU7hmW27iaVMuUJ9T3iWVW+sPfE1XHi5PM3oWA/11lKxDD64lwo7wU/ejlYH7bJnFeHS2UPDcS4Skd+95g/uGceTmRA9O29L0IDgYOUl4KA+2JwHW5JwS+v+yVTmGFt32A+pYkjyZqZVbl9dMX09rhjvS05ge+E+7uJr9lKCDCHQPZQlJ+UWftolvE42uE8e46HI7b9n9DItZzsXaWo6npZeMH3IavjZMOmfCjB5SOliQmkqeWNBHbnEmXHQdhhyOzDMHIAwvqfC8TlGSp5GH/NQtI3Me50j6w1Z9VUe11ZMFxLI2sDgsGgqSh+Sclj1FeaCl0EAxd3so4D/eVdi9JqMUcg427Lk46UQ+iuCjAhvJ34KFNFPYee+/D2211FAew3n0aHBd684eXZoPqtWL6F9flfHA/07Niw8ODZggvpDCkgtxLHthbPi4/xmgQO36DrWxTT8E83h8qy3hrvnsCO6hSn4gzGU1666782zvx2Dh+qiISS/z9eSzLvLKE1O+CSCHEHBN+hubUCBcs7AS0SIAqhVLiBZmOZGO8nxxf0OD4waOxNCiMXGsD3WGEbA55ZjdBCZ/uBLC0D4k4hEtQJzxM2X
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a251de7-575f-49f8-f334-08ddc2c0835c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:23:44.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0OnF60RZzgR8DVKujuOS9kc+HZ/TK6KdTQl7QmFxJhDoAiUhiaSmB+m/sHQgkn+TEeYHPACE76VcHuGNDkmMrhV9QUdqknonw8zEv0n1rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8389

T24gMTAuMDcuMjUgMTc6NDgsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy85LzI1IDEw
OjU1IFBNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAwOS4wNy4yNSAxNzozMSwg
QmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPj4+IEhhcyBpdCBiZWVuIGNvbnNpZGVyZWQgdG8gYWRk
IGEgd2FybmluZyBzdGF0ZW1lbnQgaW4gYmxrX2ZpbGxfcndicygpDQo+Pj4gdGhhdCB2ZXJpZmll
cyB0aGF0IGJsa19maWxsX3J3YnMoKSBkb2VzIG5vdCB3cml0ZSBvdXRzaWRlIHRoZSBib3VuZHMg
b2YNCj4+PiB0aGUgcndicyBhcnJheT8gU2VlIGFsc28gdGhlIFJXQlNfTEVOIGRlZmluaXRpb24u
DQo+Pg0KPj4gJCBnaXQgZ3JlcCAtRSAiI2RlZmluZVxzUldCU19MRU4iDQo+PiBpbmNsdWRlL3Ry
YWNlL2V2ZW50cy9ibG9jay5oOiNkZWZpbmUgUldCU19MRU4gICA5DQo+Pg0KPj4gU28gZXZlbiBp
ZiB3ZSB3b3VsZCBoYXZlDQo+Pg0KPj4gb3BmID0gKFJFUV9QUkVGTFVTSCB8IFJFUV9PUF9aT05F
X0FQUEVORCB8IFJFUV9GVUEgfCBSRVFfUkFIRUFEIHwNCj4+IAkgUkVRX1NZTkMgfCBSRVFfTUVU
QSB8IFJFUV9BVE9NSUMpOw0KPj4NCj4+IGl0J2xsIGJlIDggaW5jbHVkaW5nIHRoZSB0cmFpbGlu
ZyBcMCBpdCdsbCBiZSA5Lg0KPj4NCj4+IElmIHlvdSBsb29rIGNsb3NlbHksIFJFUV9PUF9TRUNV
UkVfRVJBU0UgYWxyZWFkeSBpcyAnREUnIHNvIG5vIGNoYW5nZXMuDQo+IA0KPiBJdCBzZWVtcyBs
aWtlIG15IGNvbW1lbnQgd2FzIG5vdCBjbGVhciBlbm91Z2guIEkgYW0gYXdhcmUgdGhhdCB0aGUN
Cj4gY3VycmVudCBjb2RlIGRvZXMgbm90IHRyaWdnZXIgYSBidWZmZXIgb3ZlcmZsb3cuIEFkZGlu
ZyBhIGxlbmd0aCBjaGVjaw0KPiB3b3VsZCBoZWxwIGluIG15IG9waW5pb24gYmVjYXVzZToNCj4g
LSBJdCB3b3VsZCBjYXRjaCBwb3RlbnRpYWwgZnV0dXJlIGNoYW5nZXMgb2YgYmxrX2ZpbGxfcndi
cygpIHRoYXQNCj4gICAgIGludHJvZHVjZSBhIGJ1ZmZlciBvdmVyZmxvdy4NCj4gLSBJdCB3b3Vs
ZCBkb2N1bWVudCB0aGUgbGVuZ3RoIG9mIHRoZSByd2JzIG91dHB1dCBidWZmZXIuIFRvZGF5IHRo
ZXJlDQo+ICAgICBhcmUgbm8gcmVmZXJlbmNlcyB0byBSV0JTX0xFTiBpbiB0aGUgYmxrX2ZpbGxf
cndicygpIGZ1bmN0aW9uIC0NCj4gICAgIG5laXRoZXIgaW4gdGhlIGNvZGUgbm9yIGluIGFueSBj
b21tZW50cy4NCg0KRG8geW91IG1lYW4gc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KZGlmZiAtLWdp
dCBhL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMNCmlu
ZGV4IGYxZGMwMGMyMmUzNy4uYWMzMGNiODMwNjdmIDEwMDY0NA0KLS0tIGEva2VybmVsL3RyYWNl
L2Jsa3RyYWNlLmMNCisrKyBiL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jDQpAQCAtMTkxMSw2ICsx
OTExLDggQEAgdm9pZCBibGtfZmlsbF9yd2JzKGNoYXIgKnJ3YnMsIGJsa19vcGZfdCBvcGYpDQog
ICAgICAgICBpZiAob3BmICYgUkVRX0FUT01JQykNCiAgICAgICAgICAgICAgICAgcndic1tpKytd
ID0gJ1UnOw0KDQorICAgICAgIFdBUk5fT05fT05DRShpID49IFJXQlNfTEVOKTsNCisNCiAgICAg
ICAgIHJ3YnNbaV0gPSAnXDAnOw0KICB9DQogIEVYUE9SVF9TWU1CT0xfR1BMKGJsa19maWxsX3J3
YnMpOw0K
