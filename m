Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB01B808
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766207305; cv=fail; b=MymwBFmyYk/M8FsDPuYQBsx1JXSMNsF8r6l7DJ6ZhgtUeUE04hysEye25cEMUyWyvBx6f4WoGH7fgyDT+4FYaRpsa4nWQo5vIPDHc/Kpw0eLHpHJeggNjF2a57FBt/A0mg1JBOEIjYYIkkecTR5NMvuirIfh/uppOx9eLUR5Sq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766207305; c=relaxed/simple;
	bh=g2DDblLjhmOlbeY4LwjglWM3ab8idLOkGkkvfwjFFFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CpnKrN/ILejtOKXLCMvsdSuHmOYlnGjBHxEIu5znOMEVe6RbW1W5Mu/3NzzFzMrQEm2ScOcclNH7/f1gLPOhBzpH8YBmFZR7cRaYVWcSpqIJ9VKELRVGj0ZaE+/aLJgmTXEAuAd2/XfgqsbRwDKhqJmCy5JYyrrXOz3+y4ehnNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ispE8tek; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BOu5UXXY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ispE8tek";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BOu5UXXY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766207303; x=1797743303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g2DDblLjhmOlbeY4LwjglWM3ab8idLOkGkkvfwjFFFM=;
  b=ispE8tekXnYvlUR8G8/iRxyy8VN+k0XwpbMq31VXnNdf0dFjBMSCvSi/
   mvY5jIfOZK+Y/V5HOAQqvUXwhw3FCL3ZWvNI7lG9YoX2cQAKiH5djIb2I
   RAwFeZKoGzvrYFga+8YrWQuy5G/+SY4//px0CkHjhu3Twoyvl8RiZvK0v
   8ZfFOpiPBann/A7UoVwVGYYmL6RfTKLWUsax36uEnz0wGfd584sU5c8hb
   KtKeffZsRgZeyNBpbZiKskAYlNHk6grQBLLhwJrMsGQVJI/PWi2fu3+UQ
   TX3ScSzXnnGJ3g+fY/9vZEfMiETOcLPnrKHIjtdEkmIvzn3V5lR2B9nNi
   A==;
X-CSE-ConnectionGUID: I2xGNlFlSai1dqQ3Q5qO8g==
X-CSE-MsgGUID: 3vaNYperSg6VL7k3VUeicg==
X-IronPort-AV: E=Sophos;i="6.21,162,1763395200"; 
   d="scan'208";a="138254829"
Received: from mail-centralusazon11010060.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2025 13:08:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ycw86Sg/WLosp8NVCaISefU1ZQTTiHO6O93+tN3v9BQcG5WYSiO0r410KFpuQGBExTlBoOqM9Rh3mqQsip8c1pRv8+HapVxh4LiQKUiuH9CwDXwGa5Cclh448Xu/Tu4QCSP1NZg9yL9Cp4OBW1Vi4F6iHXt35Mqaxy6rWyJkAQ6eH/vgUxq8Gj1uQ8A4aFRpmRBL3JLexnPY2ZudAUVxXT+Xtx9M98beJhkpDxmFmQc4ioE1HRe8kQ7DVwAt5ZmCdSbAgs9Z1LHyX2bCBUY/ly4aD/raZ1RO3ihI2i7i1T0Tu0kjb6amKydmZ77lBOcUpFG3DCWjhkDYNW/Q+5lbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2DDblLjhmOlbeY4LwjglWM3ab8idLOkGkkvfwjFFFM=;
 b=L5993jiv3syChQOPa5zGbotUY5Aa7rXSs3llpxn7G5BryM1/lnn3gBhU/bRTfG+8/pEk3XUY+EP6hCsxx9fTEOhpwJSa9RfIcEznicE2Xnk183Po2GIf+E64EhIJTptndYeARzhDW+/EJIl8gUctNafzQA2CtPBMlbz6Xvx5rhZ+TRR2k4Yvtbkx+OULulhG9B+QevlQwStuc3yjeLyf46YFS+OZ3237uHSTkuJFupiTtMstrY4kbIMdCva9PZc+Enfde7KL4jDOiXknKhtYCcYegOrGc+mH9w2Hu+JAe/u3t9BaND+t0vZOuHm0Ae8IEaBTidBG1PbrC0GWKo4Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2DDblLjhmOlbeY4LwjglWM3ab8idLOkGkkvfwjFFFM=;
 b=BOu5UXXY0ZGxAWVBpLLJLlbZqv2yJ2IgwNkWjaAGihlscci1Dq7YJzkqKb+9QpVflyWhh95XD0V2wYih+kNyAx7ZU8dslXdRDNKu3JlzTsjcDbSp2S0emr+pPUPQ57QapETec/LTshoqSv2phuHLWYYHWKyLmo6ztDyV65biwqg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CYYPR04MB8877.namprd04.prod.outlook.com (2603:10b6:930:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 05:08:14 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 05:08:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai@fnnas.com>
Subject: Re: [PATCH blktests v2] test/throtl: don't specify sector_size for
 scsi_debug target
Thread-Topic: [PATCH blktests v2] test/throtl: don't specify sector_size for
 scsi_debug target
Thread-Index: AQHcYCa12IrIQrIjjEC5hlmvro0V87UqHPuA
Date: Sat, 20 Dec 2025 05:08:13 +0000
Message-ID: <23dc94a5-57f3-45c3-8fc6-f4e4bc1065a0@wdc.com>
References: <20251128052235.67745-1-lizhijian@fujitsu.com>
In-Reply-To: <20251128052235.67745-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CYYPR04MB8877:EE_
x-ms-office365-filtering-correlation-id: 1b543a1d-fb0d-4645-f3ca-08de3f85c769
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3FGR1RZNmNkaW1wc0haSm9DMWdoOFF3ZFZkTS85OEUxOXB3anVUZ0FWR2Z6?=
 =?utf-8?B?UEJXRmNzdmtTeGxNK3luenptcXZVTFhib1h3bWZBODBqNnlSS1diUUNLWWtC?=
 =?utf-8?B?V2x0MVZXUHpiUnJuUjRrTFNUd3JDbDF3U0wzaHFIN3lUcEFmcUlhTVMwV0wz?=
 =?utf-8?B?Z2VvYys5aEdPazJYSkFUemp2Y0ZINmZwWmhPYzRob3NNSUcvdGxmV0dCYnls?=
 =?utf-8?B?MmFsT0NVYzJqbVR6c05IWm5GUFZnZTlYVmIyRjZzaTdrY3NGcGhWVnM2TFQ1?=
 =?utf-8?B?NmY3ek9QMWxVY2VvcTJ0ZTdTUmJYWTRLTzZsOWQ5aDlJdFFCUHBXNWhJYnhl?=
 =?utf-8?B?dmJqbE8vTkprVndQMnZHL1VkcDQrUkRxRm11L3RxUHdUOTdxc2xXRWQ3Smlm?=
 =?utf-8?B?K0ZlSUtwL3E5TzNOVnpvaTJ6Y1VPSFdiQUMwTEpMYmMzdTFNOHZWSkhrYk9R?=
 =?utf-8?B?YzRBUXVpb2lxaHRsRFVpZXMwa1cxOUF1bjBmazNvcmNncStSWTVDN3pLZ2F6?=
 =?utf-8?B?bmxiM2VLeGo2V0ExNkpsUlhUTGNVYjhoNjFPTEVOV3ZBRGttL3h4YjVseitE?=
 =?utf-8?B?ZndkUjVVU29UaVZxckdoT3V3WjBidVllTzkzalJMaFgxZEVHUDVRbEd3eHhV?=
 =?utf-8?B?V2JZcEJFOGZhcFY0QXVxa0hJK0ZmUG04ZmRKUEY1RnV4U2c2aFJUVkROeUFO?=
 =?utf-8?B?UWE0bEljMXBWakhETkc4V1A2K0hDMXN3WkVHSmFYUUUxTDNhTllwSU1GdnVl?=
 =?utf-8?B?Y1dkTFM5UVE2UkJHVC8vTUdnNFZhWVA4U21Ia3dtU2ZsL3BMYkxlbjdCWUk3?=
 =?utf-8?B?SEl6Y3VxNDFDelROTzJ0T1JadG5GS3hHclFZSkZNWC9hY1dKUmdUOUpqNXBx?=
 =?utf-8?B?ZjVPNW5xOWhPNjQ5TDRTQmk1dmo2VWNOWThlVjRRaW5CR1VobEF5bDdkclAv?=
 =?utf-8?B?VzdiMjFnVTltRk9WL216UUNpNDMyQnJsRzZ2Zks0UDlPSi9IS29QRnAzQWhM?=
 =?utf-8?B?SVFQWUtjdDMzdTh1L3h4TWF0SnUrNEdDclFOSlVVRUdtdUljZmQ3N1Zhak1m?=
 =?utf-8?B?Z2ZiMzBtVGtiKy9WblhnMHhhTWtlNGtFUlpWa1pIWW1QcTBEY2J2V1lzMTl5?=
 =?utf-8?B?NkpRV0R3VVBVdUFuK0YycWNXeTNYSldHNDVRbzVQSDdsRzFzUXZJZEdUZlZX?=
 =?utf-8?B?M3lFeTV1VlUybCs0NlVKWHgxQmRZcDRsZzVTQ3lZM1pvV2k4WmRFVVFEbEkw?=
 =?utf-8?B?UlBEMXFMSWhnMTFrRm0renVSdzZvRjJTbUxzRWo2NzdRU2FZdmZPVE1rOE1R?=
 =?utf-8?B?MnAySUFWemh0TnBHa01BZklhQXFlRElWUXJlREk0dUV5SVNhSHhpRzVENjFm?=
 =?utf-8?B?M3gwWkZzbUtXSjU0WEszRE9najZFV3hDSVRobVR0NDZXWHp4NHFnaGJybmRi?=
 =?utf-8?B?ZHpMVlIvTWxWYkZKWnNBTlR3ZFNrRHlzdG56S1pRSVJwd2ZvVTNDdW5IaVNy?=
 =?utf-8?B?VnZLaklHTURRMjMwTGMrNVo1T0QrYXNRd3ozU2dhK0hXMjZ3OVV3cEVBOVhU?=
 =?utf-8?B?Tnd5VFYrTi94Y2tLN1VWSWloN2hYUzI3S0NQbFFKMWVybnRvMFZ2dXRoWUZN?=
 =?utf-8?B?Q2Y0MUZSUmN0VEV0Yk9JcVI3Z2VhTk9Yd1F5bHhsaVdMQmZZV0RpcFZLZ094?=
 =?utf-8?B?a241ZlNTMFpLajhyZWhlZmF4VTBETmE5UVhJQ1pONnlLTVV2VVozUVI3UFBG?=
 =?utf-8?B?eFdrUDFtSnpWemhZdDhuVGJuZ1hkaGlqeUp2NGxhbnh1NnFteHdEQTdONnll?=
 =?utf-8?B?NlRxYmZEUHcycitUUE44cDBrbGEwUThFRFh4N0JMWFY5eUU3ZEFQRTZuMWpL?=
 =?utf-8?B?VERDNEZ6ZllreERnK1R5YlhZRnYrY09FdFhvVHV0eTJEdmJQeVhJMUIrKzFx?=
 =?utf-8?B?RHVwaUorR2lwWndxR2tPSXh3WnYyNFljMTFCd1RQMkdpa1g2U3JmZW9LSzBo?=
 =?utf-8?B?ZTNpSnptbVRneE1WanU0T2MyZFVZWEI4N25tcVMwYkFTZWVLdVF0OUlmOEU3?=
 =?utf-8?Q?8GGbqx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WS82R0JQL1NrS3AydXRTQXRjS0pVOS9jRTlDU3RlTERtQnAxUDdqTmx4ZzlY?=
 =?utf-8?B?NzN0anE4c3dPeXRvd1UrbWNZV1piekZMUEdaL1I1WEEwRGFSNCtEdDlzbUZF?=
 =?utf-8?B?c3hYRTZrblUzYVJEV0tiM3Y1aUVxMG85MDRNSEJOUzI5WE4xWVQybExaQkI4?=
 =?utf-8?B?NHpWd2FkK0tNYXZOWktUOWM5bG9MRERxc0pMVGUxd1p5RGYrYlFYN29mTWlx?=
 =?utf-8?B?UkhoWWtRbjQ2SEZGcnZ1b2tmSHg3WnVrRXRpWks5TVNxeHdDbGZUVUtBa0pY?=
 =?utf-8?B?akRWUThGKzZqK25IZkhOZTgrUFJhUC9XVzZOQnFtNVZIcjJ4Sk91OWpXdGY0?=
 =?utf-8?B?aTZRZUtKdnNPeWs4YzM4ckhOQ0tCU2Zsdk1SSFZHS0FENVhvQ0JlcjErNzlw?=
 =?utf-8?B?aHNzbXVTSmxMOERRK1k1anFDSjVJMEZPNmY5Q0UxVzZTdGJyMTZhUWhPRS9t?=
 =?utf-8?B?M2hYOHUyTVZOdUhwejNSRFp1eGhSMk9rb1RGOTdNMmJrNUw3RHFuakZwYndO?=
 =?utf-8?B?aWFMUzVlUkwrcnI2WDBQN01VeFUxdnpCOWkydG5mVCtMQVI3NTh5ZGFQN2gy?=
 =?utf-8?B?MlpRdytnSlhnVER2bkcxQlcvRzdIL2FKYVVMNmQ3UnNoOXZ1VXpEMWZ5TmZl?=
 =?utf-8?B?c0U5RmJod01wa3l0UUlKN2RkbXVoeU5RMEpBL0NkVE5DZVpQaVl1MGdQRkVv?=
 =?utf-8?B?MXA0ZlBvZG9vRzhCSXBWSGRwVUtRVXpXdmFveFZxWjYvU09ZQ1RnTW4yV2Ix?=
 =?utf-8?B?b1BvOUF3OVBCNTFyb2t0NzJCNHloOVkwZGZNSU9pUmJvL0NnTjlhcnZBb3c5?=
 =?utf-8?B?VUpwZmFQcUt6UHdzWkZmTVhvWDBJaG8xc1d2emliMHhnSVFzTVhMc3VBVlRn?=
 =?utf-8?B?aC9MSUFac2VYMTRsakdJVnBqRVZwMEtNeXFvR3AyeTBTNmZCdnBGR1ZMTkZv?=
 =?utf-8?B?eUFxZ3doK2dhMVErS0dYYXdUTEQzZ1BnUXdGaGRGbmRrTk5GMzJvMDUzWFhP?=
 =?utf-8?B?ZTI4SGJ5a1A5MFVRMUhMRHRTMitISkJ3MEdJZlRUTkpaU1N5ekhjcTZ3ZWxK?=
 =?utf-8?B?S0ltNzhvbkhDSFFGZG50UmpWV1hHT2xIQUpmcFRmbEY0WHBEMGxIeHhhaXFo?=
 =?utf-8?B?THZmWkNYYis5NkZqbEZ0bVlna1lTb1ZPR1l3OFl4ZU1iUy9FdjNiZzk4VFR0?=
 =?utf-8?B?ZzM4NDhJR3JLZ204K1BqQTdiN3hSRStpdEVYaEJ4V3hVOE1lSWlyT05pYVlT?=
 =?utf-8?B?NXZNM2hrN3EvL2dNMWNwaDVFYzY5bWVWRU5FdGZQdU5TTDk3aWFuQ3BpQ3ps?=
 =?utf-8?B?OW1ia1hXeFQvMjI4VXV0YzRnYjU0YVE1MTJNWGZDQm14QTh2Q29QRnZTNW1v?=
 =?utf-8?B?ZzJVaHpTMXZQdzhpWWlXbFdjOTdIUHBhQnNNbjhkVUtEaENwQVBvUDhrRWFQ?=
 =?utf-8?B?bjlQODZqRzJPVUZvdTZ0WWpJUjhFNkVUZ3FSd2pRVXUvSmN3bGdiWU5mTEpY?=
 =?utf-8?B?MlZPUUNwMVFhUzJ2T2hwSzF5Q3J2UHBhSUtnUlJ6aDcyRVhsQ1Buc09HK2or?=
 =?utf-8?B?T1N3M1BMMVNmd2YxSTdDaGNrazhwTUo1ajA1bDkrSDJUWUxvVVZRSXg0eVFl?=
 =?utf-8?B?SS9YQkhDTnBoUVZwWkxiWkNLUDAvZFB5dkRseDRDQ2gxeUJIYlA3OXI4bGtt?=
 =?utf-8?B?djBYek55OG0ya2pVYnFyQ09UMFlkY0cyKzhrTjVZbjhiTVNvZ2kzZk1uR0FU?=
 =?utf-8?B?ZVFBRkJCRUJLLzh4eU54YkpvZTBjRFpyajJkdGdTSVROQ0hlNVdHMDdiL1BL?=
 =?utf-8?B?OUY4TVBzTWxEYU9LUHFtTHlDaWhvME1oYU9ITTdVd0o5U0Q2b0czdjU3bzRt?=
 =?utf-8?B?dTI1OE1pL096OFEwRFZNNjNpdkpEaEVJVXlhencrVkswR1FBbUFQR0ZUVUh6?=
 =?utf-8?B?c08xM0lDcCtERFFITFZWcVFMTDJld3RSMlJhUm5iNzVMNEJaZElkN0RYQXdx?=
 =?utf-8?B?OW1PdUZKdkowRWszeHA1aGw1RStzNHZHWnlLUmhETzUrZnQ3d0d3Zll1dzZw?=
 =?utf-8?B?MzNNSEZ4c1VOQlM4OWc3cHF0ck9TOUdUaU5wMk55d2hEU2M3a2JIM1F3cHRC?=
 =?utf-8?B?ZS82UEJXU29UYlg0M2R4VHNBOEVVd1dEVzVLQnJCSC8xckptcDAzOXRrNVNN?=
 =?utf-8?B?SW16ODM0ZjJlZ2xaZGxCSW1GRHg1Wk9BSEh6VHk5VEFFVXpSbnBQS2k3OFpS?=
 =?utf-8?B?VXViL2N4RzR6S0paNGd5NFBqZ1BFUjNCRm15bDU2NzNXOWZESmZJSXZkRVR4?=
 =?utf-8?B?YWZHa3NGY0JMYkJmbWxkMjJXMHIxbVhBYVl3TzhnMVZFY2tmZmhOeFMrL29D?=
 =?utf-8?Q?d5pBF6OpXuOMmaQw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <482CC33755966B4EA738A33333246A09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PvB42cu9xcTsoZoe2p6JTCEiZEv+DxLZnuQVzEWY6qfTwCr01JT+qsprg83OOyaWmyOUEGXHacRIcIMXoUwBC+EINepOSrwmXzdnfn+4z5MmuXnYtLQ0irSrstyijXfxSIEUQ87L5zkqPhjhIwB1NeTWPFdYz/FoB4NmQ5r0vuulny3B1M5TVS1FyuskSYIuTdsgwSss65iAQtL2InkmB6Y10wU8X4+iHYtpC3zcfUXQN5OOipGpe1Mg29c0ovYnTPUo1oKji0WqAlrRoq5xiSlC92HcWbpiJS5R2NbHwFCHNPCC5cdDyHSnVDP8K82k2nbeHqX6u+nVaLvMi38By9ZKVI7MJ43vFNWOYcCU4MlmKH/ZJfE7XEZKhqIuEp1ygSzs9RecvftVNWfueYvmtB+vciWqZ1J7S/UNOe205CTf9NoFCLuj5dOu0El2lNMnE8Gw0k9nXSlXnTguvZYgtKcxqbpbaPzsTL543l9FZncbDWIjcdHDw4Y6P3c51Iv15RUq18ehfoshQRHDJjJLEOKSyObjH1SJ6/c/CfsMs+erHEsleTBtEKPrUDIGG+ATqd3xa5B5+D4rz92S3dbWDSY4peFQEkPxKi2L6DWQfTiwGX5Tn2KB4r75m77rYdxm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b543a1d-fb0d-4645-f3ca-08de3f85c769
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2025 05:08:14.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEjE6zBEuXDNL/HI7Wfoc1zaMo1sDd9yvibsVqnfkf5jqloSFBPzFH4krTfXw+O4q3c/+PZ4asBE4fijjlhoJTvdJqe5Bn4OoeP3nnO5gsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8877

T24gMTEvMjgvMjUgMjoyMCBQTSwgTGkgWmhpamlhbiB3cm90ZToNCj4gQ3VycmVudGx5LCBgc2Nz
aV9kZWJ1Z2Agb25seSBzdXBwb3J0ZWQgYSBtYXhpbXVtIGBzZWN0b3Jfc2l6ZWAgb2YgNDA5Ng0K
PiBieXRlcy4gSG93ZXZlciwgb24gc3lzdGVtcyB3aXRoIGEgYFBBR0VfU0laRWAgZ3JlYXRlciB0
aGFuIDRLQiwgc29tZQ0KPiBgdGhyb3RsYCB0ZXN0cyAoMDAyLCAwMDMsIGFuZCAwMDcpIGF0dGVt
cHQgdG8gbG9hZCBgc2NzaV9kZWJ1Z2ANCj4gd2l0aCBgc2VjdG9yX3NpemU9JFBBR0VfU0laRWAu
DQo+IA0KWy4uLl0NCj4gDQo+IEFmdGVyIGRpc2N1c3Npb25bMV0gaW4gdGhlIGNvbW11bml0eSwg
c2ltcGx5IHJlbW92ZSB0aGlzIHBhcmFtZXRlciB0byBsZWF2ZQ0KPiBpdCBhcyB0aGUgZGVmYXVs
dCBzZWN0b3Igc2l6ZS4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1i
bG9jay8zNDA3YzZiYy05ODMyLTQxZDUtODFjNy03MjE2ZGQ4MWY1ZTJAZm5uYXMuY29tLw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQpU
aGFua3MgZm9yIHlvdXIgd29yayBhbmQgdGhlIHYyIHBhdGNoLCBhbmQgc29ycnkgZm9yIHRoaXMg
c2xvdyByZXNwb25zZS4NCkkgYXBwbGllZCB0aGUgcGF0Y2guDQoNCg==
