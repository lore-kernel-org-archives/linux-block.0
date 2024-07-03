Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0213541F
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000214; cv=fail; b=aGGul8Q+jXHHbnQMJen3hP5L/aY02yHa6eGbSJHkvswV0ikkISJGV0JAYP7qxWc1+g03Wtl6MUO5OgrGwRwX5Eak4f7+i+MZueIWr1ghD/4wHz/Y2TudGjq7hyo78LYWNgcAGN4AWeHkym3uvZCnY49R4sOQ/K5h6WW4q6rKs/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000214; c=relaxed/simple;
	bh=9QbllAn4rzVRCQfNmO47sfCs0wrSFd9V4OxPkq3yyH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dv9Suv12BoVDS4B+acHUx4rFf6phJliBqbAhZSN7GAEvaWyiWzawYxAXY5BUVibHrmcGK8l/85GAjVBT6ACfMNLaVKiyE1xyXbAHo0EHhJt8opSRncQSrvqxGSrpSwS3TVxrjnQTBhge0XqDLGtfMQEz7tH/MPkwzrJ8Y1ud8ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m1nmUVMr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CkB54jFx; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m1nmUVMr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CkB54jFx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720000212; x=1751536212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9QbllAn4rzVRCQfNmO47sfCs0wrSFd9V4OxPkq3yyH8=;
  b=m1nmUVMryHqzmxfOi6AD+JyakWrrwDaEnbCHkP+Fyiq9e2XjDtDOAktZ
   tYYn3cithE/ETzro5uns0VqjneI1lmPGLAhZIRmsX3I5yheMxxAY2dRUO
   vLVrpNa5oaMKH/ixs4b/VX5JJUBLMXhn+PhvjVtSa/TBD0GlZKyXiPz2q
   Zp1xmGS4uAG6eSnKSiyO1tBK0xoHEQSexgP6d3WOrFZMALyJFLo3MZL/l
   fzzFIH3tmzhmHM/ygte8Pjq0mBjK4sB5/XHhjmFyCe1yJRrPpkag3uKSy
   o63JpHB2K7FOLwB8qriVJUQWUPeVrECH0nu9v0TGhJXRK9ShWU0LTd9DE
   Q==;
X-CSE-ConnectionGUID: ju84CNtwRXS21ur7n0EcIA==
X-CSE-MsgGUID: 4qXMzpKOQrOXE4kPthUj3w==
X-IronPort-AV: E=Sophos;i="6.09,181,1716220800"; 
   d="scan'208";a="21089862"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2024 17:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSwLeEJURerSfqzszPFNUNXmb2kjf3MQQSCTcgnu5hmwS2Mav7KwiRZ5TeKvbRnFUhPBtlcmPlUxv3U9fhAyQnPme1f/FcFmYLeOZ5LXeKkBQpd05n6lBwuyJxS2xZUv7CmE00LXEIijBJlwDC6v2iwT1QlGjTvkq/LqWEhU51Y5f3o+1m2N3RHK/ML1ilwWXDx/DiA2jhu9vyuM1p/KAT9ef/R83F9+sXIHDD5N/X9NlAyyWMUqbxuNjnbCVFrn67d/Zby940GTciSWwYkOLb5bZCSJjrOV5CfBGnHWYUImE6q4NK6SEAbESLU/SvN2RFWjyzzjUv6K/WkiyuQQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QbllAn4rzVRCQfNmO47sfCs0wrSFd9V4OxPkq3yyH8=;
 b=AF4gfM5R9+Sf0v6TvA2z74f04A9hE20gGv0Z2clRLlPUZUjpH/CpwFAtbvCf157OPZzvM0wO7+YMHygsApPjRFmsaIVcMJYkMW9mh2gRlI0PIrE29egCAQE2PRxqXoVRVu8e6wBmYX2sjdDTrs3/SmU2No0942QKLU9ATUkbqe4ieyyNfDp4HXdWrfPlZaPywVMv81Ohmp7AE0RoMAng/MgBwcmm4triPYUZedGNUeE9dQooPU6dEDLjeFNuH1L9NzWj77/7/PdHy5tdzkU4TjzuXnCGL/YaUCoyqVPug/jeBAI4Ohk8ht77haXsMcpmtvcfhX7zcBKUjb7ZqQHE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QbllAn4rzVRCQfNmO47sfCs0wrSFd9V4OxPkq3yyH8=;
 b=CkB54jFxj0zROAndXTrlo+VDnm2e0cJ6GHg9y9CN7uUzQnZNei5ykoM1LYAgtK2vfQZ4S4O4sVxgXAlnJsEXjQHmz/siiVY22UXgwhR7DbTDaI4GaDOd0Hzq2YmbgJXSjKNwLgMlcyBTTUmKX5phWkJfuCUA8kr7vFxgKR82rDw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6350.namprd04.prod.outlook.com (2603:10b6:208:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 09:50:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 09:50:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: don't call bio_uninit from bio_endio
Thread-Topic: [PATCH 3/6] block: don't call bio_uninit from bio_endio
Thread-Index: AQHazJISqfUWh+NQs0ifrmvzHBEGKrHkw6IA
Date: Wed, 3 Jul 2024 09:50:08 +0000
Message-ID: <58763b5f-712d-4c42-b5f4-4064e99a4e40@wdc.com>
References: <20240702151047.1746127-1-hch@lst.de>
 <20240702151047.1746127-4-hch@lst.de>
In-Reply-To: <20240702151047.1746127-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6350:EE_
x-ms-office365-filtering-correlation-id: ce734690-baef-4cbf-e324-08dc9b458638
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVVDUzErRGR6U2FkN3NoRXM4eDlYMk1nU0hyNm9ZeG4xRGFlYVkzK1ZLMFhH?=
 =?utf-8?B?NFNKb3oycllNZksxMXZzam82QTZaRlZYRWRZRmdjeTJkN3I0N0h3UlZWV3k5?=
 =?utf-8?B?OWcwbU53L01EZGRFTkY3QUN2MVFWcVI0Q09GdGlUTTVJQU5CNUwxZVdPRlNC?=
 =?utf-8?B?TkdhT0tQL3F5K3p1K2Qra0RjcWR3c0prcHQ1NElWb1lKeDdVamRUK0Z1TGEy?=
 =?utf-8?B?azBBbmJDelNlNGRJVzNNYTlpQ0xReUo2NWxKeVZsYlEvNE1uNzk4cDhXT2Va?=
 =?utf-8?B?eksweEpDT1EvWDRwcDZkdmR3QXNiRDBkSEtaZEEvWGx5ckN5V3RaZ05FdXFp?=
 =?utf-8?B?dE5Cdmltb1RtWW9pUlR6dXNYNnp2MUF5ZURHVEZrNWt6LzV0R0pKTkRSNUtw?=
 =?utf-8?B?Si9tNEVIdENTUzZRUmQ1RDlYc1pwNkpFVG9TL2F1QjVYblc1VUlQT29NYThs?=
 =?utf-8?B?a1N0RUdid2NEWXJRaGpSNVMwbyswVXhPYXlZTDB2OFI1STFsVEZvL084cFpN?=
 =?utf-8?B?T0xEZTFIZDBDRWI2Y0NLWlZaMENXOEVYQjFUSXY3N2pNL3NJcFhaZHJRaTVV?=
 =?utf-8?B?WDR5MFFNRnZlSk9rbTR4Ti9TTTUzRW04TElCYm0zejlDNVhNK25NTGUyWEM4?=
 =?utf-8?B?OUI2U2xCQ21SWllsL1NZQXRLNitTODJQZUpVenpBdEtwM0NUeG55VFNPaDI3?=
 =?utf-8?B?VUdLWE1GMG45OGcwYlRJMGs5Y2dvNHFJM3J1RmNlSzhXT0hiZnZCNVhFcWlN?=
 =?utf-8?B?UUtjSXc5T2d1TDBWUkZBSFRReW83T0pzK3BJUnpGVUtUR0lMNGhDYmxRNG81?=
 =?utf-8?B?V1d3dExET2VYK0dMUWRPN1k1Q05rOUJNUkE3QlRQYUxDdHZIaklXZGJSZWI1?=
 =?utf-8?B?NkJBaHFXS3BTZGwzMmVJdWFicXRieit6a3ZLWlV2cmtuWE40ZDVEbjFGbk44?=
 =?utf-8?B?SzdZYWRKcXdnWXNIWC9DYVFWd3FnYTJGNnlJWlFqeVlsZlhXalU2YnkwMDFC?=
 =?utf-8?B?NnRwRU5YWGcySnViQWJsc2h5bDErSGdiSG9aY1hyeTJyQmNJSVlMZEdPcXd6?=
 =?utf-8?B?OWJOSnIxZFluS3cyenNWQXZKVzZmM284RVl3MEdsYXhFdXBEa1l5US9GR3l3?=
 =?utf-8?B?M0FYWmx3SFBZejh1Q3plMW9WR0pURnlYdk9Qemkwc3BhWTZ2eW5lWHdNWmRU?=
 =?utf-8?B?bXlXUitjYU1yQUZuWXZ2MGlINkozVWhwQ1VpUUFEcUVEVlRLMjZmUkh6RUZH?=
 =?utf-8?B?UVdDWmxwMFlRcGRJTXBveHdXcjlIY0VUbGFPcUpwOVJ4WSthRXl4Q215MXhl?=
 =?utf-8?B?bExFY2g2L0NiZGU2V05hT0dXS1FobTZiRCtrenFIanJQTGJBdmlwRDJkM0Rv?=
 =?utf-8?B?N0ZmVTVCbDl5MnFYbnhraWlLbEFkOFpFYjhXTHFIUzRRenY2MWJhYVhsbEor?=
 =?utf-8?B?bDZyQW9oaU02dDQ0Zk0wcG9GYTNqM0M4ZCtaYzIyY0pHSnRvaEtBa0ViWDJv?=
 =?utf-8?B?ejVtOFRRcm51QTZ3L2JZV0dnZ2ZXbnlyYkpDbnJoMlRSOUxqZHhnUGFxY0tm?=
 =?utf-8?B?QWp2cTBrM05XbU81eE9lNFpWclp2NzhwSVJpVlRJME5GUElSN1RWSXA1eUg0?=
 =?utf-8?B?bXRqUC8xS3p4UXQzZU16SHRVbWRwU3pnd3NZUnpJRzRjMlFXWU9lL0lob1hK?=
 =?utf-8?B?TmkrSjdselpUM0Q5QllYQ0FtKzRORGtnN3VyK2dLanI0TUk5VzgyVUNCNjdv?=
 =?utf-8?B?YjZKQzd4Tkg0VkRFMGNKRzZlTHFnYkhoMi9qRmhpTTZwcmlLWXZzblF2UkJD?=
 =?utf-8?B?NDhjTk54NUh5NW5SdlRVQmorNHVPZGplMGs1Y3BHUzR5SHJqUXFtYWF1enhM?=
 =?utf-8?B?TDJHNnpLZ1RiMkNBSjdsaEZ2V1UxNWFhZnBQckRwTFAya1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTZyTTZkaVZ0U0VMSU4xbG82d0gwcXRYMWRkS2IwT1Rjc1FUN2VuTWI4VWF1?=
 =?utf-8?B?L213WFlUWnFkZ284dVNkL09lZ0pTMGxVaVRsR01rbmF6T2syVzBDbXhsNUF0?=
 =?utf-8?B?cWUzci9qQ2E5YXFUR0ZYS0xmcjlFZ3h6THRMVU9YbzhiWko1emJCY2hkaEVi?=
 =?utf-8?B?M3h6b2c2Z1lGVkx4VVU0dzdBTkx5MzdxbmVVZ3FNQm4yc0czL1VKVUpMRnRV?=
 =?utf-8?B?ZlZFQjdtRWtxK2h6R1JkQitVWThuZTFvRUw0cmhWc2h6a2J0WlllUDVPUm44?=
 =?utf-8?B?enBLZ254dHFvcVFGNWZPOWN1TzdPSEVjaW5zZTFmNlZycE5LL1d4a0NEeXdq?=
 =?utf-8?B?dFB6Y1Z2SXN6WkI3Y3dpd05GYVNNK0U4UkpQWlQvaFYzQzV1d01EZzVwajF6?=
 =?utf-8?B?YzE2U0ZTVytMSlIrYU5NOGFaR1J5TWJKamFNSTA4ODZzK0ZGSW9ZKzAyQ3R0?=
 =?utf-8?B?cFljdnJlcTQvVGNLTGFPNFVqdlRJSEdUUEE1MFp6c1BsVkd4M2V4dnZ6djVy?=
 =?utf-8?B?L01jckgvdGUxT0RQdVE2dHVYM2xEcjVPU29HamlIdjV3SkoxVE4zWSsxZFA3?=
 =?utf-8?B?WDdYMktxV2ZLTmtqcEpTck1lYnMvak5kMnArZWw0bTN2WEhPdW9uaUl1TU1o?=
 =?utf-8?B?UG9qdW44UjdHczllNTNDdmNIVVlFTjR0QzM0bzdXZWY1aWtGeEFJalJmMzJJ?=
 =?utf-8?B?YlJvMHA3eEZWRlBBRmpGOHdjMTFTdndGY2pHTjVMMk5hK0JZeWdwdUdmMnpG?=
 =?utf-8?B?UWQxdU5NdVJrWDI5anh1MnVEc2lrZ2xsN01WTTFVeHJ2NHRqRFJkdW5zS1Y0?=
 =?utf-8?B?a1BqanBtNHVucWlJVmVFMUdYdXhUVVRxREpqRGY4dU9KczNRZ2c3QTlUZkJF?=
 =?utf-8?B?S1dLTGNZTU1NWGdHWGE3VnJGcFdndytTMFV3SFhNUUtsWmlvekN5VWd1WGsy?=
 =?utf-8?B?eFB1T2V1dVNveTdiVlB0U3duRU5uek9XVE9lWkZWUE51YWdBSStsaUhybGFF?=
 =?utf-8?B?d0xFVi90TkhqeTdCUWFzN3owWU9POW8vMGNScXBPUDAxUjBSbmM4VUdtc3h5?=
 =?utf-8?B?Um95bUZJaHdrRXVPNE9rVVRWcGJ0ODBEOW0zQk1YTnFTUElzclQ3SlUrakxh?=
 =?utf-8?B?MVpncEdGMUtjb3piYzRwTjA0YWxKZWYwQzBwWUFWUkFhTjZRcytZaFExWS9C?=
 =?utf-8?B?RlUrRmh1TEl4Y3hBQnZyN09nazdIU0tZaU1XUWU1ZjltbmIzRUI3L1gzVS9r?=
 =?utf-8?B?MjJnTGNjNklyOC9aZG9BcW9pOXUrK0FmeE53YVMrTWcvUUtqV1R3MzB4aTdh?=
 =?utf-8?B?T3U1Qy9wMWt0Y0QvVGJRVnZGVTMwVTdvWEVyZTBQL1J1LzkvQjdLQXR1RUph?=
 =?utf-8?B?eXY0ZTJnWW1kbE9JdjJqWWJZem9vSjdzcmx1VDFtSmNXUXZwYlV4Rk5ycnpa?=
 =?utf-8?B?aExFcXZPeDJNTWlmTTROeTBFZ2JQbkF0aXZMVnhCZTRIVDBGbzVDbWtmdFVr?=
 =?utf-8?B?MjB3UjFPeVpoVUo1bGRXaFlqZGNJZzQrc0Y5cncrQW5nU3lGN01Ca3l5d2di?=
 =?utf-8?B?d1VqUWxqN0plQm5LUzVrb2JrWFlTeEwzc3FwLzd5M0htd3lTUnJxT0wrbmxx?=
 =?utf-8?B?ZzhYUFRqOWlETWZ1SmdrdGtGNUdUSHl5a1hGQkJsb0U0TXFvR0RkY3g0Nzha?=
 =?utf-8?B?Mm0vN0RKK01QYm45VGltYk5SR3E2dUphMlV5bitvYkNDYkZwY1RTbEIyWmtP?=
 =?utf-8?B?YURLT2RCUjNIeWtBYVpHQ0dqREFSQXQ3R05KMjhzejY4bE1NTE1GZTd6bmY3?=
 =?utf-8?B?S1I5aTc1Ty85YU0xOFpWeWcwR2NiQzJFN3BiOEN6RFhxVjQ3ZXkrNldCSi9m?=
 =?utf-8?B?ZWtsQlVGaS9pS2o5SlZqSmVIZXlFS0hrQU5KZ0hIbDlmYlYrTHNrR2tUVlln?=
 =?utf-8?B?RExtQW5kN1B5WWl3dyt4L1NrbHBUdGFDeFkxQVJRSnBlT3pyVWJxUjlPcnlo?=
 =?utf-8?B?Q0hEWURBUDNLTXZNQUtoeUFFZFVMR2psVGhUclBvZ0dLKy9qU1ByV0VQUTkv?=
 =?utf-8?B?TEtkUkxFVkJjaVF3NlN3Nm92Z2N1dFNiRGYvM0FNN2NidmtZQXJRb050MnY1?=
 =?utf-8?B?NzQ4UHhzTDRlUUwvU2NwVE1Da2o0SVNvcitEcjMxUG84S3dLUndHQ3NQbjFx?=
 =?utf-8?B?UHNYeTdqM3NIVEIrK2MzejBaRzh2dWh6Tm01U0xGdEUzUFVDZTYwdDZBNk5m?=
 =?utf-8?B?WDVpb3MrMFJoWVpvVjIwUm1pUkl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2D7BF55F040804B9CEFB0A81A2513C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YNzG7QS2mjI0/w9YdF8K0JiMYcvdi+4PcHz62GGzoO29cRJ4P8bdENjRb8C/QVGmSqk1N+DzSwtBFHE/ovWvwmXQ1sxou7KPUXAkjwivQh7hYcSBXjID7r5f3nBpM+VDRkOsmSjSR3z9j7cs0cQT9BWSNeQQfBcQkzxhRjHBj+nABhKrTeMhNvYnC2cTK8ChgT+zPEJAbx2jOwkYa4zGiCRjpWTaTGmfekDbWTgwN3THXME+lb5up7H9CHsrt/aaqyG3DpaimVQD6orWNXmNqd0oD6iQzsK7CSMNs5Dm40zrnA7DKUBGoFVR1AIbDewcNFH5hxzwvmXPjhdOUmDH9nK1pF5VndlqSs8+7Qj15ysHQkeBdo6uAEfKM9+VISMhI5+XpqMpOFJF/W0labwdqoWc5NljQgiox997OEfbnMPQi1UYvPVuLHJTSVG3p2/LPnJk6UEWe5S2Y1o6902RrteMyXTC4Q3s94hIfbJ8X6i+GEuCO4kOZDKBcD4C6kcD+Elg395ZUIZTPAjSjnw1C92/qZER2WkLEid5z8jDqBnek+TSJSOgrTDwS95NRmbXPQRsacHzcaZJ8hGFvHu4iFWg3buRMKLqpu7uOAgHSNs5hdAC3qACdSS4GrAn+Ro2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce734690-baef-4cbf-e324-08dc9b458638
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:50:08.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l96svQbnXv2eewkkKlgzhQHqNyudPnQaePLxthL5c8EfGA5w60z56FUUkBWYl7RvaszxFjzl7h35YyCd0N7PKoAP2q0k/eRXWrBfXHpSK0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6350

T24gMDIuMDcuMjQgMTc6MTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBDb21taXQgYjIy
MmRkMmZkZDUzICgiYmxvY2s6IGNhbGwgYmlvX3VuaW5pdCBpbiBiaW9fZW5kaW8iKSBhZGRlZCBh
IGNhbGwNCj4gdG8gYmlvX3VuaW5pdCBpbiBiaW9fZW5kaW8gdG8gd29yayBhcm91bmQgY2FsbGVy
cyB0aGF0IHVzZSBiaW9faW5pdCBidXQNCj4gZmFpbCB0byBjYWxsIGJpb191bmluaXQgYWZ0ZXIg
dGhleSBhcmUgZG9uZSB0byByZWxlYXNlIHRoZSByZXNvdXJjZXMuDQo+IFdoaWxlIHRoaXMgaXMg
YW4gYWJ1c2Ugb2YgdGhlIGJpb19pbml0IEFQSSB3ZSBzdGlsbCBoYXZlIHF1aXRlIGEgZmV3IG9m
DQo+IHRob3NlIGxlZnQuICBCdXQgdGhpcyBlYXJseSB1bmluaXQgY2F1c2VzIGEgcHJvYmxlbSBm
b3IgaW50ZWdyaXR5IGRhdGEsDQo+IGFzIGF0IGxlYXN0IHNvbWUgdXNlcnMgbmVlZCB0aGUgYmlv
X2ludGVncml0eV9wYXlsb2FkLiAgUmlnaHQgbm93IHRoZQ0KPiBvbmx5IG9uZSBpcyB0aGUgTlZN
ZSBwYXNzdGhyb3VnaCB3aGljaCBhcmNoaXZlcyB0aGlzIGJ5IGFkZGluZyBhIHNwZWNpYWwNCj4g
Y2FzZSB0byBza2lwIHRoZSBmcmVlaW5nIGlmIHRoZSBCSVBfSU5URUdSSVRZX1VTRVIgZmxhZyBp
cyBzZXQuDQo+IA0KPiBTb3J0IHRoaXMgb3V0IGJ5IG9ubHkgcHV0dGluZyBiaV9ibGtnIGluIGJp
b19lbmRpbyBhcyB0aGF0IGlzIHRoZSBjYXVzZQ0KPiBvZiB0aGUgYWN0dWFsIGxlYWtzIC0gdGhl
IGZldyB1c2VycyBvZiB0aGUgY3J5cHRvIGNvbnRleHQgYW5kIGludGVncml0eQ0KPiBkYXRhIGFs
bCBwcm9wZXJseSBjYWxsIGJpb191bmluaXQsIHVzdWFsbHkgdGhyb3VnaCBiaW9fcHV0IGZvcg0K
PiBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYmlvcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4gICBibG9jay9iaW8uYyB8IDE0ICsr
KysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmlvLmMgYi9ibG9jay9iaW8uYw0K
PiBpbmRleCA0Y2EzZjMxY2U0NWZiNS4uNjhjZTc1ZmQ5YjdjODkgMTAwNjQ0DQo+IC0tLSBhL2Js
b2NrL2Jpby5jDQo+ICsrKyBiL2Jsb2NrL2Jpby5jDQo+IEBAIC0xNjMwLDggKzE2MzAsMTggQEAg
dm9pZCBiaW9fZW5kaW8oc3RydWN0IGJpbyAqYmlvKQ0KPiAgIAkJZ290byBhZ2FpbjsNCj4gICAJ
fQ0KPiAgIA0KPiAtCS8qIHJlbGVhc2UgY2dyb3VwIGluZm8gKi8NCj4gLQliaW9fdW5pbml0KGJp
byk7DQo+ICsjaWZkZWYgQ09ORklHX0JMS19DR1JPVVANCj4gKwkvKg0KPiArCSAqIFJlbGVhc2Ug
Y2dyb3VwIGluZm8uICBXZSBzaG91bGRuJ3QgaGF2ZSB0byBkbyB0aGlzIGhlcmUsIGJ1dCBxdWl0
ZQ0KPiArCSAqIGEgZmV3IGNhbGxlcnMgb2YgYmlvX2luaXQgZmFpbCB0byBjYWxsIGJpb191bmlu
aXQsIHNvIHdlIGNvdmVyIHVwDQo+ICsJICogZm9yIHRoYXQgaGVyZSBhdCBsZWFzdCBmb3Igbm93
Lg0KPiArCSAqLw0KPiArCWlmIChiaW8tPmJpX2Jsa2cpIHsNCj4gKwkJYmxrZ19wdXQoYmlvLT5i
aV9ibGtnKTsNCj4gKwkJYmlvLT5iaV9ibGtnID0gTlVMTDsNCj4gKwl9DQo+ICsjZW5kaWYNCj4g
Kw0KPiAgIAlpZiAoYmlvLT5iaV9lbmRfaW8pDQo+ICAgCQliaW8tPmJpX2VuZF9pbyhiaW8pOw0K
PiAgIH0NCg0KQ2FuIHdlIGhhdmUgc3RoLiBsaWtlIHRoaXMgb24gdG9wIHRvIGF2b2lkIHRoZSBk
dXBsaWNhdGlvbj86DQoNCmRpZmYgLS1naXQgYS9ibG9jay9iaW8uYyBiL2Jsb2NrL2Jpby5jDQpp
bmRleCA2OGNlNzVmZDliN2MuLmYxMGMzNzdiNjg5OSAxMDA2NDQNCi0tLSBhL2Jsb2NrL2Jpby5j
DQorKysgYi9ibG9jay9iaW8uYw0KQEAgLTIxMCwxNCArMjEwLDIxIEBAIHN0cnVjdCBiaW9fdmVj
ICpidmVjX2FsbG9jKG1lbXBvb2xfdCAqcG9vbCwgDQp1bnNpZ25lZCBzaG9ydCAqbnJfdmVjcywN
CiAgICAgICAgIHJldHVybiBtZW1wb29sX2FsbG9jKHBvb2wsIGdmcF9tYXNrKTsNCiAgfQ0KDQot
dm9pZCBiaW9fdW5pbml0KHN0cnVjdCBiaW8gKmJpbykNCitzdGF0aWMgdm9pZCBiaW9fdW5pbml0
X2Jsa2coc3RydWN0IGJpbyAqYmlvKQ0KICB7DQogICNpZmRlZiBDT05GSUdfQkxLX0NHUk9VUA0K
LSAgICAgICBpZiAoYmlvLT5iaV9ibGtnKSB7DQotICAgICAgICAgICAgICAgYmxrZ19wdXQoYmlv
LT5iaV9ibGtnKTsNCi0gICAgICAgICAgICAgICBiaW8tPmJpX2Jsa2cgPSBOVUxMOw0KLSAgICAg
ICB9DQorICAgICAgIGlmICghYmlvLT5iaV9ibGtnKQ0KKyAgICAgICAgICAgICAgIHJldHVybjsN
CisNCisgICAgICAgYmxrZ19wdXQoYmlvLT5iaV9ibGtnKTsNCisgICAgICAgYmlvLT5iaV9ibGtn
ID0gTlVMTDsNCiAgI2VuZGlmDQorfQ0KKw0KK3ZvaWQgYmlvX3VuaW5pdChzdHJ1Y3QgYmlvICpi
aW8pDQorew0KKyAgICAgICBiaW9fdW5pbml0X2Jsa2coYmlvKTsNCisNCiAgICAgICAgIGlmIChi
aW9faW50ZWdyaXR5KGJpbykpDQogICAgICAgICAgICAgICAgIGJpb19pbnRlZ3JpdHlfZnJlZShi
aW8pOw0KDQpAQCAtMTYzMCwxNyArMTYzNywxMiBAQCB2b2lkIGJpb19lbmRpbyhzdHJ1Y3QgYmlv
ICpiaW8pDQogICAgICAgICAgICAgICAgIGdvdG8gYWdhaW47DQogICAgICAgICB9DQoNCi0jaWZk
ZWYgQ09ORklHX0JMS19DR1JPVVANCiAgICAgICAgIC8qDQogICAgICAgICAgKiBSZWxlYXNlIGNn
cm91cCBpbmZvLiAgV2Ugc2hvdWxkbid0IGhhdmUgdG8gZG8gdGhpcyBoZXJlLCBidXQgDQpxdWl0
ZQ0KICAgICAgICAgICogYSBmZXcgY2FsbGVycyBvZiBiaW9faW5pdCBmYWlsIHRvIGNhbGwgYmlv
X3VuaW5pdCwgc28gd2UgDQpjb3ZlciB1cA0KICAgICAgICAgICogZm9yIHRoYXQgaGVyZSBhdCBs
ZWFzdCBmb3Igbm93Lg0KICAgICAgICAgICovDQotICAgICAgIGlmIChiaW8tPmJpX2Jsa2cpIHsN
Ci0gICAgICAgICAgICAgICBibGtnX3B1dChiaW8tPmJpX2Jsa2cpOw0KLSAgICAgICAgICAgICAg
IGJpby0+YmlfYmxrZyA9IE5VTEw7DQotICAgICAgIH0NCi0jZW5kaWYNCisgICAgICAgYmlvX3Vu
aW5pdF9ibGtnKGJpbyk7DQoNCiAgICAgICAgIGlmIChiaW8tPmJpX2VuZF9pbykNCiAgICAgICAg
ICAgICAgICAgYmlvLT5iaV9lbmRfaW8oYmlvKTsNCg0K
