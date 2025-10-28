Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D96330336
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673515; cv=fail; b=qcYTt7yp41XxkmzJvyZg1ALwKCDvtbXp7T28b5br5xI4aCkUMJcVQ5+PkM3DHLwzQ3emVyxEkJ1ZdEa2GpcRZEMY5M/3VamGCY+RUvqO8vgSA0CgqFtp3Y2wciJY5ZBsCrMsd/5KqQal2RK1CdCfzMy/338FlTURLJxVoZpSIHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673515; c=relaxed/simple;
	bh=aB9KxSGi4k8nm7i+UhXckc3aq3B1QdFV0k8MsZCiTM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nou3lRAd4BoTmQwEk4ibCLq3JllOF7rQtyyIQ/sMWrvnGF3qXSj27jt8y+u5abfxKnJDl8oOhdkO6fa5Yst2gnVn0sn7zRy49LHf8cpBCiLiML2KKXigCICsi37KJscnrl8gn7Fq+t8pae0s8WBwZYaixnJNB5wO6qv2o0vCVgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nMhikwJ2; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nMhikwJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrTd6teuLqKZbeiSkjfQQhYNaCRGXmWR6KsUL+djLY7stcKlDTEhXG75WkY3srpq6zKQDnpaQPxqsXT8i7XYGz0NogTR6F7Oqj+lUKIxq7/LCTTgbA7TLs/uKuEp0Jkf3L5wWMxtRrtQgzEDvlbYw1BaUBCrhGBLGChREbZAWasaP3rT1clc3e45ls9SOVQL57AlsKQU1Y/AR/I3/HoyWJpXBbLK3H+e7MEFT7Oy3hh0t3YAl4oJLA+OiYJf6PxkoFsp1xEXpD8yGfkXkvPeVxiuHrTvktXRos11z1evVKnWjKRVM1CDJVwNnYZZz395LwwPzJyLFU78BLWdkdUY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB9KxSGi4k8nm7i+UhXckc3aq3B1QdFV0k8MsZCiTM4=;
 b=sEWyZ1DSE9HoGwhks+V6GS9r/e+LvQk2GFAcZ207rwYXknECdh/z5ibDSFy5u8OiI0lx1+1q2iynebV6dxXEKQa1UKyCijFUURV2PR1fVUYXirpQn38IlRd26rwcmkqEOjrawD31WQdpuGHYKLEEZdIXuV244c8HDZrkJ0PZNJhycyEPyFGCn3iFMQbdBvH4Rslx163btvctcOPQjCaVvgOI0nM0kh05jU9w/2hI8SMkIERzPhNzgSBMrLB0ERBBm2+h1JEcCy354tbtpKkvBHHq3hQje+xV9ne7hIVesoD+E/ScR//1yGlj/2lUUAy9zYh4r9lCyhSx5n52aemLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB9KxSGi4k8nm7i+UhXckc3aq3B1QdFV0k8MsZCiTM4=;
 b=nMhikwJ2pfjPEujAopKmsuBizjI5Yn7QkIO7XygADCpnEg1X7Le9mlHiOAOWsASKg3PXDKTCwNt0X2aAQSQiih8AuXMPk6MAT+kmrVVrnjbW2qKwXyleAzQrjwa4pWD1Bi+fJgCxNMHIPzaI7pjq1nykQqMOjQe2UC/+2nXmq6EXlJW4V5VeYLWlN1nAXF6Oryxo+co48CDHtyYfQ9DKRA3cED9BYY8fu+l44uqCK6hJ0MLhDee81F8jmRtIABgoB1TNyFTJrZahp6SClb58/xpyycI8rtBgx9VJ6AmGrjYclP8vy1jbZfwFY3Z9oAGj9QXnji8GIroy18/GesasLw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 17:45:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 17:45:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] blktrace: add blktrace zone management
 regression test
Thread-Topic: [PATCH blktests 1/2] blktrace: add blktrace zone management
 regression test
Thread-Index: AQHcR9WyRbu+wdEajUGQGIEdNu9kcrTXKDgAgACtToA=
Date: Tue, 28 Oct 2025 17:45:08 +0000
Message-ID: <158d6401-9d06-42e6-886c-57b57cb75293@nvidia.com>
References: <20251028063949.10503-1-ckulkarnilinux@gmail.com>
 <4513674c-9d99-4356-9fb5-f39030cd6a92@wdc.com>
In-Reply-To: <4513674c-9d99-4356-9fb5-f39030cd6a92@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4295:EE_
x-ms-office365-filtering-correlation-id: f43b6a62-881c-47bf-8023-08de1649bc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDM5R1NHdExTWWtoWkF1WXZEc0Nqajc4R2RVRlV6aEhsQkRwcnVrdEJhaFBQ?=
 =?utf-8?B?WFd1NG9qb0kxSENMZVdsNUpRbkFudnMySTNxZzJXd1gwbUh4THNXTCt0MlUz?=
 =?utf-8?B?T0VNNElmU2tBZUdEZTdacDlkS0h4R2FneklYK0VRNWd2eUlUUnlLYitWSFlN?=
 =?utf-8?B?OTZPOGErM3Y0NUpqbDhLZHJLcjAxNkswMXFZS1FqQjRPdUkwd2gyWnVWOERQ?=
 =?utf-8?B?OUpJWENIMjdhN0hIVjA4cDNBSENhdUVSOG5TbUZIY2lLVVlDdFk3cmUrVTBr?=
 =?utf-8?B?cVVGSXZVTmp5b0RCd2Q1Z20vRTNJek1HeDlpWXEyV0FGU05SeDFmUjZickta?=
 =?utf-8?B?b3c1MVJra1M1dm5SVE9DYm02SjFkVHB3azluSVJZcUJueFhUdkpXLzYxYVdk?=
 =?utf-8?B?WlhpMWJ6eVl5cHhnbnNabkFFbHpmLzk0WjBOUTZEK0lqRGhKOFJEdWJINkhW?=
 =?utf-8?B?RWRiUWJpQmlMNklxK2RhblZMWVVmVHFSSnhDWnZLOXFRL2FPRlQ2ejduN09k?=
 =?utf-8?B?Smc0YXF6NXBuS2dSQWl1ZFNFR2pNZmtZSkUwNFZQYmdiOTRmdkJNZ29DZW1R?=
 =?utf-8?B?V3BCVkwyUFRXSE1OVkZWMWZwd3VIb3BNUjkrZ2lrMkJTZHYvZlcrZWt0OTBl?=
 =?utf-8?B?NmVtR0FyelFvME5kZnV5SUk3cnRqU2I5QlNZa1lHUDZDTHdoZm8xQTYrVlo1?=
 =?utf-8?B?SWlZbXM3ZDZFYytOQlNUOUllRXN3QVNWTlZPWmtnNUQrUkY3NjFKb0pLdlNF?=
 =?utf-8?B?d0F0WHJjMExYbkE3SkhFQ2FwS2p1emJQRStZVGZDVXZ3aXk5OWkrTjVCVGtU?=
 =?utf-8?B?OVg0SGhpa0t3dEovR2hMaFFMbm4yc0k5TXhWa0hQZmJRMVNBSkY5UWhheWtP?=
 =?utf-8?B?bG5BbHUxbFlqdmZ0SlhlY3NTWEtRWE93VjVUMlVnZDFFYURTYW85TlRUT01o?=
 =?utf-8?B?QTM5OUNwNENtalBkMzQwYVpWS3dhSFl4MlJyMTdHOEo3bHk1cWIrMS9GK3FH?=
 =?utf-8?B?Nlh0V1owVzFrOTVZMk0rMHpBQmc2UXdoMnJvVlgxVkZDaXRkYVl5L3gyS2xR?=
 =?utf-8?B?eDVzVVBwbitmQUZXKzFLTFpPc3hUWW5nOFhyTTJOWHgzNy82WFJ4aTFqRHRX?=
 =?utf-8?B?YWRvYUpYSlduVGdEZmw1T3pMM0Y4V2VnOVAyeFIrbVV1dDNuUXJsbHRNckFY?=
 =?utf-8?B?Vllsa2RWME1hOER2UmRiMXVuWWttbWRHU3QxbWEyQjhHL28raEo4a2ZuNEVQ?=
 =?utf-8?B?QkFRNjNKZ2pkcEl2SVc1OUFyby9xa21LaDEyTVpZSDVNOXdvNGhVOUN5VzdM?=
 =?utf-8?B?TUM1TmlwczlpZktTVy9DK2RRM0NNMTV1amNGOFlFMlBCdGhnUTlZWWtJL1N4?=
 =?utf-8?B?RGppNWpHNE1TRkQ2b01jalEraXIzNnQwalI4allrdURGTmZ3dVJmUkVaNmhZ?=
 =?utf-8?B?VVBOemdFY2lxOFMvM3podTRFbjBaWDFqcHI5MVNwWk0zS3V5L1VHMk5RaUpM?=
 =?utf-8?B?MjM0WHRmYllMeThMQlcrQ3RCdGQ2ZkRHRmIraXlQRy81RGFncTc5bkRxN25y?=
 =?utf-8?B?SjBHWndveVdEMDVSU0gyMS9kcURrc3J4N0dEdXlYOHRST0g3b0diTUZZSEVU?=
 =?utf-8?B?SERYNm9UUEVTR2ZBajMvTUZWZ04zWW1nem5xdHB0TFpMaFlIUmtxVWkxeEpR?=
 =?utf-8?B?bmRpNDNiSjVKMnJPK0FVVWtnQ0NwNGJROTlubnRzUW1QSEJtckFiMStKaTg2?=
 =?utf-8?B?SXpwbHFkMUFkdUNHRVRJV1VHUGN2dlZZRGswbkxUREZhZlVVUWRIdnljWDUv?=
 =?utf-8?B?ZWwrSWpsT1lvUEo0WDJCUjVuMFQza2oxdk5KL3IzY3ZJVzdyenpqSkpQR0NJ?=
 =?utf-8?B?MFlmL1p3ODJCcUtzM3RPTUZiRVFGU2JGVHpGVmV1WVpubWI1RGQwdXlGTGNF?=
 =?utf-8?B?dnJ1SmVDdlJPTWJvcUd6a2UyN3hsM3BVYnFKM0VJRFAvbGE0RzlIQjRkSG9U?=
 =?utf-8?B?QWR3ZUhVYlQwNTZ5bnFUUFRzcTJOTHQ5UUNLZmpDNFVvU2daTURNaHpCT0Nt?=
 =?utf-8?Q?DnTvRc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWF5QncxSXNoZXcxZG9FQkpyQ0hCeUltYlZwbnNjYlJlb1lOUG51NitxcTZM?=
 =?utf-8?B?VlFKUlRtZWJKN3kvMXdNY1pseVp3Yks2bWozWitneFJaMjdvNUFNR3NNMzJV?=
 =?utf-8?B?S1JEdkJ2Z3YyM0FyK01xdGF1eHpJb1FrSjhRN3BlZjNKWktKK2tkckFDMDVO?=
 =?utf-8?B?eXF5ZFYxbFk1dU0vcVFJSG9GcVZvOVJiY1o1amc0U29Da1BUR0t3SFFmekNn?=
 =?utf-8?B?bmZVZUxEcFN3c1VmWTlGaWZVQUZxb1ZTRG1tNWVEWEs0cVg3ZXBmUEsxVnVV?=
 =?utf-8?B?YWtxc0ErbXJCRUhyb2pEaTNUMTZWK2ZndlZ1cTh3R2VacDRrMm5KYU5MOVVw?=
 =?utf-8?B?TnpkdGFERnQyeWdoQnJvNmUxaDJKUllsMVNCRS9NVzRBQTI1ZmRyb2YySDlO?=
 =?utf-8?B?SkxDNWFLZkxvdnpINTVHR2ZuSUdxdERqMjA1ZzlZUUdIS2FKVGcrZi9IMTdQ?=
 =?utf-8?B?bk5NUVg5a3NvL2JkQ2p1Y3p5Um80STcrQmFRcVVoVWlLa3dSdTNhMmFwbnhh?=
 =?utf-8?B?Y3QwL05OWkYxM0VvS09wTHhYQ1JLclN6RytOOXh5aHpJSXdTZSsxNGRsTmVp?=
 =?utf-8?B?dWw3RnF0ZUFCcnJ6WlQySHhXMFREekZTSko5dmYrWThJQ0dHaWE0d2xidjV2?=
 =?utf-8?B?MjhnemlKc013cVhJWnV6TXdrWG9wQW5qbk5HTUZ1VzJqV2VHR1R5czJFVHgv?=
 =?utf-8?B?bWlJRkx1SEdOU2pPWGs5UEJkRFRSdXE2S1phK2dsZ3poWTBwelJ2ZFpwNlBY?=
 =?utf-8?B?a2Q0Rkp0MU9iY2gzWnNZTFRLR0p2ZEdZdjVjKy9YMzQ2bkxneHRMTVhtKzRR?=
 =?utf-8?B?MDRqNDdzMUF0L3E5UDNWMFhqdExrVVNHUlhNKzZtTzVKaFhsR3VTUjZtOU1X?=
 =?utf-8?B?MmtXRDNBRGcyeVAwWTZwMDU5Wmg1TzdWK0xYNjRRVlVvNlFYQU9Db0Q4SVpt?=
 =?utf-8?B?OWJyYVpuRC82enMxMjRFMVprWDg1b2prSjhvUVM2R0h3TFNJQmJRdEJtS2kv?=
 =?utf-8?B?cGlSWFZoL3VRNS9YQnJEM3VyRk81ZU9yTkdGSjhOeUpuaktwSVl0Mm90cjhZ?=
 =?utf-8?B?UnFUMThtZWpFVXYxUkFWaks1KytrMERGbUxCYTZwY2wwU29kdzBVVU9ick5F?=
 =?utf-8?B?ZWhvS3VVa3ljS3p2K0g3TXRSUi9SN3I4SUZvMFBrMDVMb1hXUjVCOE04ZStK?=
 =?utf-8?B?MVp6V3lHNlorZktpNllpL1g1Ti9Md3d2YlNOUUZ2d25BVTNhTWVSMDFlQVF3?=
 =?utf-8?B?TlZDeFl0ZEk3U085M1JoUmdqcUNmZm83Ymk3OGdNSm9qeTUrMk1SWm51cHY2?=
 =?utf-8?B?UHYvbmNOMUgwcm5wWDhNV2pLN0wyUVNxYlRDTi9IdlZjbUlSbkNlTUtTS2pk?=
 =?utf-8?B?QTB2eEZ1T2dadkpLejBBY0FrcStPMXJLR01saE51b21rY1dkWW9zZHovMW1t?=
 =?utf-8?B?b1VKVG82NHJiVk1hNDdIMXh3RGJxN1I1ZmFYODlpWHlEQkZ6dWx4TVgxekpB?=
 =?utf-8?B?R1k3akV4dG8yMHNQUmM4KytTcktIbmFWQXM4WXpnTzhpUFpTbDdUaHJsTDhW?=
 =?utf-8?B?enYwOHVxZzBtbSt1anY1T3dQR2pJd0IzUUlyckZpaHd4T1JSV25kT2xhNW5C?=
 =?utf-8?B?S0JoakU1bjFTeHEzVDhkdTdWcGM4K3ZOUU0rdTAyZnRFVStiV3lGbjVIa3FK?=
 =?utf-8?B?UVNlUm9IblVyam5lWU9mS3ZrOXlaWU90c0lTb0szaXI1Z0FKVHY3U1RYKzd4?=
 =?utf-8?B?VDdMSy9tZE5uSnY0NUk1TU5tS0tIOFpEU0JrYUk1ZW43Z0JKc3oxQWhqeGFH?=
 =?utf-8?B?eENFMHBKdkZjczhxRVRGUElqWkQ1YldHajRjMFpqUVJhbG1lYTVIelRScS9v?=
 =?utf-8?B?L1lKbkZLeFZtQlNhMFUzOURrQnBIUVpESUVtZUdQZkVIZHBBUk1YT3pPTzdX?=
 =?utf-8?B?aWZqVlM5NmhocElBTGRoUTFiSnBCUkVQdUdrNzU5Zm8zRzZKWkVjdzE2V05Z?=
 =?utf-8?B?eWZQRmtVdXd6amw5eHNJS1d4a0JkNVZXM1daL1RNZ3lDclQyL2w0WTlYZU1z?=
 =?utf-8?B?MFZSc2l5YklkVk5NTlc1bC92WFVjU3Z5NnhtcUpPdXhQQnArK0UvQ1VVN2lP?=
 =?utf-8?B?QWhTU01qZ0paTFYyL0tWQ0RUaDNzMU9SZ2dnZ09rbFVQcStwVExnZUVOdVJB?=
 =?utf-8?Q?oBczWgvnZEDgdIO7vr6BHzGijo/cuKvF7eikm5zjVtuE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2AFA02A704870498A6EF43CA42E99DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43b6a62-881c-47bf-8023-08de1649bc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 17:45:08.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtuJ/VlsbyNcXvy+xfyAhr3xN8o3Yu0QosLjfHYY3V5mw0ViJdl4MEOCaF+amsJNPYJbACt0XgUevMVf0OT0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295

T24gMTAvMjgvMjUgMTI6MjQgQU0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTAv
MjgvMjUgNzozOSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gKwkjIENsZWFyIGRt
ZXNnIHRvIGlzb2xhdGUgdGVzdCBvdXRwdXQNCj4+ICsJZG1lc2cgLUMgMj4vZGV2L251bGwgfHwg
dHJ1ZQ0KPiBEb2Vzbid0IGJsa3Rlc3RzIGhhdmUgc29tZXRoaW5nIGxpa2UgZnN0ZXN0cycgX2No
ZWNrX2RtZXNnKCk/IENsZWFyaW5nDQo+IHRoZSBkbWVzZyBidWZmZXIgZnJvbSBvdGhlciB0ZXN0
cyBkb2Vzbid0IHNvdW5kIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUuDQo+DQphZ3JlZSB3aWxsIHNl
bmQgVjIuDQoNCi1jaw0KDQo=
