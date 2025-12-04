Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011010.outbound.protection.outlook.com [52.101.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23E2FC870
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836097; cv=fail; b=ivXC0AUOHujalFBXPvsNO0qYKLSN/gMtVXMhwDlQxPKWeqvX2nytm8BhIYAvoSe6nBHp0r6R7ufTgfpecsG2OMq5S8KaI6JtMxVaDKfhHUeeT5gx+9iwF3X4xi4gy3xFsERA26iG9YOs6Q15msQjaeqvy1B3pOwpg5pJMXQUvGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836097; c=relaxed/simple;
	bh=Zh3R/PCStJ4U6TKo0ecg26T9XEmf7Hr3EzYChnuc2gE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YAROcBVOHDetV2sirNgYBbGxG+oWA2XzoZhph7cNMjCvtWvzCnIC9xoEgP8guC4edEIdjl6EfG0BMmeScqOH+nvf1L3JuzvrXdahPb0wdNJcjRxr0gL1xcQNVxusvVzr5DGnGMRkV4zElubuh5n8Yb7z9AlARNBT4TAwk99VoOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PrUi/hu2; arc=fail smtp.client-ip=52.101.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PrUi/hu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dquCZTTYgOzhw9bSqQEq52tAj2Q4yQHUCkCrA0oOfch4ImNb1fcVMpz0bfZ7qqnBMCXoQBBZHSfKSY1K147XvgcolMdr7Idf1c4YaH2Gm/e97ADouuI0kwRWpKpGYppuW4pxiUPs/0SbmUBllVDvMGjzX/Bmq3qTn86Y7ZRBAZeezxmRUbc/zzGGU6r3vzN+MHDPeuzix6qMzVsKl7YnsjBxgzdHdL5Vu6t/2dIUECAfenYHxVL3GNwc7pmelIzuCaJhSs9Sv2xnSLLXoBdXV54K10gmBI8nmTKERGpgY3aTjsM41Jm2JrCgU89UVhufuRPagsUSOSHy6U4QgS/o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh3R/PCStJ4U6TKo0ecg26T9XEmf7Hr3EzYChnuc2gE=;
 b=OD3PH0DYvf+BhBiwatqCkaYLYFJj1KA9L4HzziAuD6Rwwt1BUwzj4f6eSFylWITscfUuDH+FTKcH3SlKvPEuJ3z48vYzIxy29F+aNSgAFKnv/poW9WVt7UzQzcr8TU0xu2AHSrHxv5M8ZLuSGfCLW4EPdqxXnxFizliEOxohHrpjh/Jh/Dgf9h6Cb3fahvSektCIpAGLc1Sy2VGMdpQnECqcZ6+uDinvZpCUag7V+Ij2kpsKae75XMtsk6FZL59BKlNTIWamHt6V6aWpQDNjJVxT9NMKQFoxMOqHcL5LMZzIXdW/r6MlQ5vuOyCgTxJrQ0zCmkERN7b37FQsWnA8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh3R/PCStJ4U6TKo0ecg26T9XEmf7Hr3EzYChnuc2gE=;
 b=PrUi/hu2nJNqiGNwpWbzOVRHg4RTZAemx55EVczadAackhR/2jZaaTGL9mdOjtMK07Kg07/Na20pAqM3nQLE5hkVOj55KGyGP8rd9VV5A442ZtCttlkJ6DSWFOqmqbq9ciNHhtInfccILztXxhI5oOAfncsXO2R4hGriWl0owGnk0NSDbBi0rz3g7gCVB8IFi8HDAZCrwnLEH2nmYNEZEG6YnOwd70kIbxPx8w8eRmqI0OzUWIHHNNWG8IVydXmbsRHgtThG5TvrFiPAI5Xfhy1IRCYSktfNRG8ncHuyUxUXiTZO7zDDkrPa0YUFJyxQ9F5UkcmI/e7QKHxIAvZfvA==
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com (2603:1096:604:3b2::9)
 by TYRPR01MB13966.jpnprd01.prod.outlook.com (2603:1096:405:21b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Thu, 4 Dec
 2025 08:14:49 +0000
Received: from OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848]) by OSCPR01MB15532.jpnprd01.prod.outlook.com
 ([fe80::e1b7:1cdb:1cd7:c848%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 08:14:49 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Topic: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
Thread-Index: AQHcWbyd/dB/TE6bnU+b/Z/pvJC8ZrT7KHkAgAAQ1ACAFdnmAIAAJW+A
Date: Thu, 4 Dec 2025 08:14:49 +0000
Message-ID: <82978f0c-4426-4bdf-b270-a86ef9c2d1fa@fujitsu.com>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
 <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
 <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
In-Reply-To: <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB15532:EE_|TYRPR01MB13966:EE_
x-ms-office365-filtering-correlation-id: 11e895ee-8a74-43fb-7035-08de330d31b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnhHaFpOcHI3aVU0dVIvZTFrMlV5Q0ViV3EzU0F4dk0zSVREUUNNbmJ1RnZ4?=
 =?utf-8?B?S1c5c3A3eWM2c2tVN0V5VUw1bXZpaVpkSThmSmJjSmZUZUxxck5mTXh2QXNw?=
 =?utf-8?B?Y0FMWEx6TmJGSzJLWTVmVDAvRUdrdzkxQTlsWUo1Y0tqWDVDdkx2ZmEvd1pi?=
 =?utf-8?B?MHBuMFRXVGJ3NENHdmpydkZoZG5kazROdnZ2cVd0citXNzI4UFY5d1JkOFh2?=
 =?utf-8?B?UUlMem92c20zZ1EvT2dGUTQzc2RNb1owbkdxd1ppdlVZVFJHb0Z3cjRKVGpO?=
 =?utf-8?B?NjlBSzdPemJmT2tqNVk4cFlsUzNyTEhZZFBFSzhDejN3N25Wc1lUUitnTkVF?=
 =?utf-8?B?ZVFoamduMXEzakZ2QnFDak1hNVM3V2xhSXVJNnFlNGo3bGdybDZmaVZadXFN?=
 =?utf-8?B?amF4MjErMC9qT1E5eWpjUXNnMXc5cmZta3F2L3dqUU5oQzBldk91NkwvL1hr?=
 =?utf-8?B?ckpub2p5MDVXWUoxdEJ5aE1uL2piZjBkRmRCcEpEMEU3c1dydDhYaTlLOWVP?=
 =?utf-8?B?azhzRnlZWjhWR3A5bjFXUVpnUGtyYjlBK3RPbkdleDBFbjdyQkdtTUtRUk5X?=
 =?utf-8?B?cGkrOFU4UTVCTnlvcjZQVFJ4VVBMc0Zycy8vREVsRVJmSXFGcWduMU9kYmNP?=
 =?utf-8?B?dTEzVFFla2x6bGNFQWp1U2ZSdGZ4bjA5djEzVzlqYW1rOUltcU91c0lsL1k0?=
 =?utf-8?B?V1k0ZXpON1RFUlAvQzdncjlyMm9OMFp3WnhWQlI1ZUZQaTNEbElMcU5WTWdt?=
 =?utf-8?B?ZCtrRk5HZFFBVElBUmNjaDNTZlA3T21KN1lZcnV1RTJGNHRwQ0gvalVvUHY2?=
 =?utf-8?B?SERDblROZHBjcWlGM2FRSE10RUQyTEtRZVczb08yWFovcTZTMGJQYVJKNDRV?=
 =?utf-8?B?bGFRdTFwV2N1ZXVycW9hbkI5Mlp2OURDbk5abUdaK1NsZ1hQT1RscFBpUyt4?=
 =?utf-8?B?c2ZTUmdLQkdlQ1lDTU1adldtR2psNE1DTitOelRkRHMzWVZHZThQQlMrMUhG?=
 =?utf-8?B?ZHk3ZzN0V1poMHdqM3plZVI1a25PTnE0dzZ6QTYvYnl5R2ZYRXE1cUtOeklT?=
 =?utf-8?B?dlFZdUFZZFpvQXE3OW9Rc3hUdXdrSnJ3bnpzZE8yUmpYKzI2Q0N4R2diK1ZH?=
 =?utf-8?B?cmoxUWRMM1RldFdHMUY1YmV3SnNXV25UdEhsREdxQUdtNWwxN3ltSVV5b2FV?=
 =?utf-8?B?U3VWcjJvK0xFOGNUeGhlaU5LQjc2ZlhRTWxhaXRGa0JxVFJjR090cmF6M1pM?=
 =?utf-8?B?Nnl2aVViZVBnUHFld2JYN2tkU1VKMHJOM2pIWkJNVG5ZTkpSNjMwalo0MXhM?=
 =?utf-8?B?U2c0SS80dUQ3WklOdzVTbU9KOXMyQjh6b1NLdnpDTDZDNXE3eUErWk5GSWU2?=
 =?utf-8?B?bDlIU1lxZjZWeENETit3SXhqRndEMlFjb2l6b3F3TWhtR0k1NVBBZ1BWUXdM?=
 =?utf-8?B?STh2eGhiM2tteW53NC9QNG9wN2ljN3lNU2p2eWh0UGJ2eEdUd0RQUmc3VHk3?=
 =?utf-8?B?UjB1VWlUYURqYUlIQlJxV3NkS2NJbFZQcjVsMDExeXFJKzZOUk5GdnZuTVNP?=
 =?utf-8?B?MUhDTmZMWFNiYnBzYmhWaGw4VnBoNjFTT1VIRXI2Yk1YbUpubHYyRkVBM1ZD?=
 =?utf-8?B?UHFvUzQ4emZZUVVnKzNzSTJ1Nm5KMVh2V0pRc3VaOEZhZklTR3hkSjlmNHJh?=
 =?utf-8?B?U0VwUlJWOGR3RmFDRjRTSk1UbmpRODNIWGRvQzBaV1hna2J6UDlwaFk3T2c1?=
 =?utf-8?B?eUxjWERtYW1kWCtOazV2WDBib21ueXZ4Q0FHYlRTUTJXUkI3Y2tjVUZPRWFS?=
 =?utf-8?B?NlFERjRkYjRheW1WMWVlRHpDd3cyd2Mzbno1ZTlBVEtLcTZqRTRVL3J1OHMx?=
 =?utf-8?B?Q3JYbmtNNGJYZmZHK0hYTnFycWVtRTRWWGJrQkhXdmJlTkRSUnQzZ0k2bnR3?=
 =?utf-8?B?NDNTbUVQTERjSmdYQkFmUE1ROW5iWEd0ZDd5OTUrUHBwdHdHNjV0V0w3VXRW?=
 =?utf-8?B?U2FuNTd5cGNGU09hbjB1OG9NWkxFbVdPV2VxNWVmT2JqSEFLTDgzRWkwdHVp?=
 =?utf-8?B?ZW1UZi9sQnBlZzZ5TXlUY2tPQk5nNW5jVDJQQXdNajg5SUZKblhEQkFrci9z?=
 =?utf-8?Q?aD7w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB15532.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFRxTm84YStJNUl3RU9aRmVsSmg4cy9vN2tSeE56Sjk3Wk1BQ0tpRTJQMWx0?=
 =?utf-8?B?TEh2c2lIbDJGWUozTm9IR3ZvU0ZaVGhiaDhpVFNRdFlwZDlNd2JiaXludDZu?=
 =?utf-8?B?dDNOaUx0N2s0WUZuc3RvdnFra1kzbkxUSkdjd1ZQR1NLZXRPclpqbGQxdFR1?=
 =?utf-8?B?RisybVhHRlBXa2dwb1FrSnVodGZvMHIvLzJYS3FkSG5kNEhjd3RSbUVaVFJm?=
 =?utf-8?B?Vk9WREJRVE45VDdYNm9HUVhma3d2WHVOWVlwVWxmSUJYTTBlbW96eGEwRnZV?=
 =?utf-8?B?VXF1dWRBMVVwUkhlQXkrOVU4RFIwVDZmcEZNbzFQc2dJR0NBNm12V0Q5UTAx?=
 =?utf-8?B?Mm9EaEZWQjZWZ1lIeEhFc2MwZ3A4ZGYvOXoxWDgwMzhJM0lJY3FXRHZqUTdR?=
 =?utf-8?B?WmF2cURPODFkOWlLSVUrVnJmSFgzSUJYczQ2R2ZCMUMzSmtjM2phTCtzTXZQ?=
 =?utf-8?B?RWd5WXJRV3JQT3IvNHRnd1JCZ2toMGNDcjVkYVlnbUJQL3B1VkFBL3pxMndT?=
 =?utf-8?B?SVpTODZJM0tZRUJsNnQvYlk1SjZVSXhqeWtFN3hpNHRTNmJjUVFRazEzSHo5?=
 =?utf-8?B?eGtCRmRPS2JIc2puL2FvOEZwRUlnamFPNDFFQzU0TytjZkR1VVlQc3lhbWZN?=
 =?utf-8?B?allnc1JQY0lGNm85RkRmclhnRUNUeThaOFFZOTBmaUxqdWFlMkFEMnNLYnlL?=
 =?utf-8?B?bndIcjdPeDFNYWorY1dOcmNKdWM4OXdYZE5udjdBYzZXR2FmNlJHS0s1VDRp?=
 =?utf-8?B?NWVGUFpZVjVVYlBMTWFVNERYbjBJYXlBdUtQSDl1OFJCV0NxNDRkaXpNNm55?=
 =?utf-8?B?bm5tVTArSTB5K0o3L3BTbzIyNjZtc0ZJRGJOMUpaeXd6dlpQWmg5L2xBL2k5?=
 =?utf-8?B?TkxCZ1pWeEc2VXNEaGttUHFOYXlIZzFGQlA1QmhKdE5jeERLNDErNlZqeFdu?=
 =?utf-8?B?c043WlpBa3ZsMTVna0t2Nzk3dUc2OTVLUk9EdFdSSmd6bGNCL1VSck9QaXMr?=
 =?utf-8?B?aU1vTHpRSkU4aUZ5UnZxanlNLy9CcVZvd0J4dFIwbFd5dmM2M2RwNUNqdnll?=
 =?utf-8?B?eVhwdDdNMEFNb0t6QmtKMHhJb2cyNUcyVEhISytTVVdONFVYVXVWYnJHSHV2?=
 =?utf-8?B?NXV2MUdiUlQ5NjQ1NnlyN2w4ZTJrTlR2VXU2djFQNG5KeFpUeHZUdVMwZ01t?=
 =?utf-8?B?R1RUZWUrOXFKWXJlbHpDS25rMzFkWkVHUk1wNFMvMWdMcFdrZXRnMldMSjhk?=
 =?utf-8?B?MytGbmhNZTNUZDAyT0JqRHd2WmlncWV4VzNDc2lEOElpclJMRnpzNVM3SC93?=
 =?utf-8?B?NU1HanU0RSs0SDhlYjlLMDNBZk1TdEpIbU1QRC9sTHRZS0xSNVR3MVZNbFhk?=
 =?utf-8?B?RExScGJvRTRxRFc3akZLN0RXeEdSaCtvQTFFYW8wSGRmdE02bTRHWXdjc1p2?=
 =?utf-8?B?V2hsOUZPWTRYbSt5YUZQTjYvZ2hXalB5U08yR05tVytwWlRvUVlOYVlIMTly?=
 =?utf-8?B?ZEpMSmxjSXNWYmtWTTRuV3cxL1NLOVdYSW9QWmt4WU9US2U4S2NrZkd2QkN1?=
 =?utf-8?B?RkxYSStrcE9tazQ4aDA1UklVZXEzdzQ2Z0gxWndwTjFWVVRscVhmTkxodlFG?=
 =?utf-8?B?cEJ5bkJCWWYrOTM3S1MxUlNxZG1mNkE1bC9hTStITUlPN2xxcUlTUzhuK3h4?=
 =?utf-8?B?NmFjcEhpVHhSNkJHc0x1Z1N6ZVZONXZyOW9KZU1SRUZWbTJMbGV1bnp2UXhn?=
 =?utf-8?B?SU83US82ckhOV3hnaXJWT1MrSTJaQ0xWeGtzaXFZRVJOdXoyQ0RIV2NRU21F?=
 =?utf-8?B?TWhQWmlRY2NTZWdYbVR0dUVDRThVNUthUU0yaXVyNmgxTk1DUWhGYnlWbURz?=
 =?utf-8?B?TzBOa3R4dEluN0VxeWlFNWUrblhZbFU5aWNwV1ZmUnEzSk9qSks0WDI5TVVo?=
 =?utf-8?B?c1IzN3hBMlRxNlp6ZURyc0lrbWw4NDhJQmFCK3Y2Ky9rSEF4OWllZU5ERFU5?=
 =?utf-8?B?bnE5QVAzNHE3MFlWZEtRTVpRdnBUTUYrMEpXb3IwUEVOZXMxckw5QmFrY29I?=
 =?utf-8?B?ZWpIZ0hvWVYxWXVqM1RvbUNURTZYbTJnMldCSXV4R2RVQ2lpNWdLOWFJdTdW?=
 =?utf-8?B?cWFBaWVhOEMrWWJ6ekY2clB6aDNvM2g3MzVIcGhEbDZZYTR4Zm5YV2xWajU2?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ED2E1FF657FFB47B5254A6C3B808F86@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB15532.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e895ee-8a74-43fb-7035-08de330d31b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 08:14:49.4411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWnA9bxo8RkmLJiWn0OFMoBwVrlttMquNkwDk74IwChRqTc7jIMq6QAnF8V/wOKMiVIxmLyIpfpUVgZJUdVNVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13966

U2hpbmljaGlybywNCg0KVGhhbmtzIGZvciB5b3VyIGVmZm9ydHMuDQoNCk9uIDA0LzEyLzIwMjUg
MTQ6MDAsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFpoaWppYW4sIHRoYW5rIHlvdSBm
b3IgZmluZGluZyB0aGlzIGFuZCB0aGUgcGF0Y2guIEkgdG9vayBhIGxvb2sgaW4gaXQuDQo+IA0K
PiBUaGUgdGVzdCBjYXNlIHNjc2kvMDA0IGNoZWNrcy9wcm9jL3Njc2kvc2NzaV9kZWJ1Zy8qIHRv
IGZpbmQgb3V0DQo+ICJpbl91c2VfYm0gQlVTWToiLiBJZiBpdCBmaW5kcyBvdXQgdGhlIGtleXdv
cmQgaW4gdGhlIHByb2MgZmlsZSwgdGhlIGRldmljZSBpcw0KPiBzdGlsbCBkb2luZyBzb21ldGhp
bmcgd2l0aCB1c2luZyBhIHNkZWJ1Z19xdWV1ZS4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBzZGVidWdf
cXVldWUgd2FzIHJlbW92ZWQgd2l0aCB0aGUgY29tbWl0IGYxNDM3Y2QxZTUzNSAoInNjc2k6DQo+
IHNjc2lfZGVidWc6IERyb3Agc2RlYnVnX3F1ZXVlIikuIFRoaXMgcmVtb3ZlZCB0aGUgaW5fdXNl
X2JtIHRoYXQgd2FzIHVzZWQgdG8NCj4gbWFuYWdlIHNkZWJ1Z19xdWV1ZS4gVGhlbiwgYXMgeW91
IG5vdGVkLCB0aGUgY29tbWl0IDdmOTJjYTkxYzhlZiAoInNjc2k6DQo+IHNjc2lfZGVidWc6IFJl
bW92ZSBhIHJlZmVyZW5jZSB0byBpbl91c2VfYm0iKSBjaGFuZ2VkIHRoZSBtZXNzYWdlIGZyb20N
Cj4gImluX3VzZV9ibSBCVVNZOiIgdG8gIkJVU1k6Ii4NCj4gDQo+IElJVUMsIHRoZSB0ZXN0IGNh
c2UgcmVmZXJzIHRvL3Byb2Mvc2NzaS9zY3NpX2RlYnVnLyogdG8gY29uZmlybSB0aGF0IGFueSBJ
L08gaXMNCj4gbm90IG9uLWdvaW5nLiBTbywgSSB0aGluayBpdCBjYW4gYmUgZG9uZSB1c2luZyB0
aGUgc3lzZnMgImluZmxpZ2h0IiBhdHRyaWJ1dGUgYXMNCj4gYmVsb3cgKG5vdCB5ZXQgZnVsbHkg
dGVzdGVkKToNCg0KDQpJIGNoZWNrZWQgb3V0IHRvIHY0LjE3IGFuZCB0cmllZCB5b3VyIHBhdGNo
LCBidXQgaXQgZG9lc24ndCBzZWVtIHRvIHdvcmsgYXMgZXhwZWN0ZWQuDQogIA0KSSBhZGRlZCBz
b21lIGRlYnVnIG1lc3NhZ2VzIGJhc2VkIG9uIHlvdXIgcGF0Y2gsIGFzIHNob3duIGJlbG93Og0K
DQogIDQxICAgICAgICAgIyBkZCBjbG9zaW5nIFNDU0kgZGlzayBjYXVzZXMgaW1wbGljaXQgVFVS
IGFsc28gYmVpbmcgZGVsYXllZCBvbmNlDQogIDQyICAgICAgICAgZ3JlcCAtRiAiaW5fdXNlX2Jt
IEJVU1k6IiAiL3Byb2Mvc2NzaS9zY3NpX2RlYnVnLyR7U0NTSV9ERUJVR19IT1NUU1swXX0iDQog
IDQzICAgICAgICAgd2hpbGUgdHJ1ZTsgZG8NCiAgNDQgICAgICAgICAgICAgICAgIHJlYWQgLWEg
aW5mbGlnaHRzIDwgXA0KICA0NSAgICAgICAgICAgICAgICAgICAgICA8KGNhdCAvc3lzL2Jsb2Nr
LyIke1NDU0lfREVCVUdfREVWSUNFU1swXX0iL2luZmxpZ2h0KQ0KICA0NiAgICAgICAgICAgICAg
ICAgZWNobyAiJHtpbmZsaWdodHNbMF19LCAke2luZmxpZ2h0c1sxXX0iDQogIDQ3ICAgICAgICAg
ICAgICAgICBpZiAoKGluZmxpZ2h0c1swXSArIGluZmxpZ2h0c1sxXSA9PSAwKSk7IHRoZW4NCiAg
NDggICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogIDQ5ICAgICAgICAgICAgICAgICBm
aQ0KICA1MCAgICAgICAgICAgICAgICAgc2xlZXAgMQ0KICA1MSAgICAgICAgIGRvbmUNCiAgNTIg
ICAgICAgICBlY2hvIDEgPiAvc3lzL2J1cy9wc2V1ZG8vZHJpdmVycy9zY3NpX2RlYnVnL25kZWxh
eQ0KDQoNCj09PT09PT09PT09PT09PT09PT09PT0NCiQgY2F0IC9ob21lL2xpemhpamlhbi9ibGt0
ZXN0cy9yZXN1bHRzL25vZGV2L3Njc2kvMDA0Lm91dC5iYWQNClJ1bm5pbmcgc2NzaS8wMDQNCklu
cHV0L291dHB1dCBlcnJvcg0KICAgICBpbl91c2VfYm0gQlVTWTogZmlyc3QsbGFzdCBiaXRzOiAw
LDANCjAsIDANCnRlc3RzL3Njc2kvMDA0OiBsaW5lIDUyOiBlY2hvOiB3cml0ZSBlcnJvcjogRGV2
aWNlIG9yIHJlc291cmNlIGJ1c3kNClRlc3QgY29tcGxldGUNCg0KPT09PT09PT09PT09PT09PT09
PT09PQ0KDQpUaGlzIG91dHB1dCBpbmRpY2F0ZXMgdGhhdCBldmVuIHdoZW4gImluX3VzZV9ibSBC
VVNZIiBpcyBwcmVzZW50LCB0aGUgdG90YWwgaW5mbGlnaHQgY291bnRlciBpcyBzdGlsbCByZXBv
cnRlZCBhcyAwLg0KVGhpcyBzdWdnZXN0cyB0aGF0IHRoZSAnaW5mbGlnaHQnIGNvdW50ZXIgbWln
aHQgbm90IGJlIGNhcHR1cmluZyB0aGUgc3RhdGUgd2UncmUgdHJ5aW5nIHRvIGRldGVjdC4NCg0K
DQpUaGFua3MNClpoaWppYW4NCg0KDQoNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9zY3NpLzAw
NCBiL3Rlc3RzL3Njc2kvMDA0DQo+IGluZGV4IDdkMGFmNTQuLmY2MjU0NmQgMTAwNzU1DQo+IC0t
LSBhL3Rlc3RzL3Njc2kvMDA0DQo+ICsrKyBiL3Rlc3RzL3Njc2kvMDA0DQo+IEBAIC0zOSw3ICsz
OSwxMiBAQCB0ZXN0KCkgew0KPiAgIAkjIHN0b3AgaW5qZWN0aW9uDQo+ICAgCWVjaG8gMCA+IC9z
eXMvYnVzL3BzZXVkby9kcml2ZXJzL3Njc2lfZGVidWcvb3B0cw0KPiAgIAkjIGRkIGNsb3Npbmcg
U0NTSSBkaXNrIGNhdXNlcyBpbXBsaWNpdCBUVVIgYWxzbyBiZWluZyBkZWxheWVkIG9uY2UNCj4g
LQl3aGlsZSBncmVwIC1xIC1GICJpbl91c2VfYm0gQlVTWToiICIvcHJvYy9zY3NpL3Njc2lfZGVi
dWcvJHtTQ1NJX0RFQlVHX0hPU1RTWzBdfSI7IGRvDQo+ICsJd2hpbGUgdHJ1ZTsgZG8NCj4gKwkJ
cmVhZCAtYSBpbmZsaWdodHMgPCBcDQo+ICsJCSAgICAgPChjYXQvc3lzL2Jsb2NrLyIke1NDU0lf
REVCVUdfREVWSUNFU1swXX0iL2luZmxpZ2h0KQ0KPiArCQlpZiAoKGluZmxpZ2h0c1swXSArIGlu
ZmxpZ2h0c1sxXSA9PSAwKSk7IHRoZW4NCj4gKwkJCWJyZWFrOw0KPiArCQlmaQ0KPiAgIAkJc2xl
ZXAgMQ0KPiAgIAlkb25lDQo+ICAgCWVjaG8gMSA+IC9zeXMvYnVzL3BzZXVkby9kcml2ZXJzL3Nj
c2lfZGVidWcvbmRlbGF5DQo+IA0KPj4gT24gdGhlIG90aGVyIGhhbmQsIHNpbmNlIGJsa3Rlc3Rz
IGlzIGFsc28gcnVuIG9uIG9sZGVyIGtlcm5lbHMsIGV4cGxpY2l0bHkgYWRkaW5nIHRoZSBTQ1NJ
X1BST0NfRlMgcmVxdWlyZW1lbnQgaXNuJ3QgYSBiYWQgY2hvaWNlIElNSE8uDQo+IFRoYXQgaXMg
YW4gb3B0aW9uLCBidXQgSSB0aGluayB0aGUgY2hlY2sgd2l0aCBzeXNmcyB3aWxsIGJlIG1vcmUg
c3RhYmxlLg0K
