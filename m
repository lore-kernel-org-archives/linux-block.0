Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBC239E76
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596134; cv=fail; b=oSjSLqQpDebUL2KuaC0qf9M+ABjCQPLvRttV9qvYYMd4qJaeXbc2Lb6eDk6GEUMeG6RWIlfrkOmYDJEmkHzOZRWqAkoMbGoV+Ei77a1ZmGYlIEGqPdUB4m9wEMWDr914ZtMZnGiesEVsxzqKYNK0DjDwcxXZV4H0Oi+rWi4LSmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596134; c=relaxed/simple;
	bh=u7/ViwCroQAzeNw7LVbeeKoK8pmTCnL9EOuQF/5haaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJNEOMusmtyLzO49Kmwz1YUJ9ETLuE3prF30GV0Z4jMTayM35inYKFpfl2+r+TkCDwmb6IRFt0bhZBjDXdlUDLjP1jaRYDsRTu/lIODFJx5DZ0ykamO1kXEhjlhjpjmvN1FT6Wev3NnVJwdxo72erNrlTyn4zpzJl+0Jho+H8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgU/W8A2; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgU/W8A2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlgD1Hh3DVsXDgZ2kDI/8kANoj2T9MhnaTGDGmK8QbOWbCTWrivaOAVitjgm2kfW4G+xjIsSzbSWXyQZ/NidmqgF9uTTlPYuP/sQhasoEU3EbYANTyS6VT8zKJAGa86GpNfdvqo/fWAqhF66znSXmY0Z8YIcTmZe6GRWdMDFBXrE9PdEK2mGvIJ4lBN57FAMNss1ZjN3kw4p6ev+HvyAQXPURkhi3qCXhM20ELvLuLxbSIvh32dwtR30fv0CM09AkKI2AVwcgvZ8kzET/Kepe948XtKiPm44aBRJUCuyF5UMUhkerOLGB2nCzhp0ixPADhX8EKAMjBXeVA+EyL0ENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7/ViwCroQAzeNw7LVbeeKoK8pmTCnL9EOuQF/5haaI=;
 b=msHvK6u4IaFVbR1YhpzlkrZSI6fM9fbPohsULcha8nOusL5/xyeePEW4tuAe1EVFad3DLa+wNpUaCkqigkcuihnMmLBkJkb6M4wlHH37JReviy7u4lgnKWvG79cqWJpVUdjfBkzAd1zvgI5eTFLaSxE8sa6DJWnqmR5rAvAy/gAU7W4ipyTYgYbLAciGxxtBTHa1k7weaMB2M6GUscbjBUlai7mmsGHt/8xD2Mo7LQ2b7Lb40DxrjQEwAzLYTL4weuk5LHRZKh26zc/fSyeFoPSsb+R/uWn49jBGrvQ2eFKp/xQ8bB1OWOfnZtH5GjkIUCcwAUWC3maQrBmu60ZtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7/ViwCroQAzeNw7LVbeeKoK8pmTCnL9EOuQF/5haaI=;
 b=lgU/W8A2ww8gCZUfRmvjfOaAl0v2R1JgvxR1ccLovEIcItdN2qui3udV6Pm+DTkm2mMPtFxSbdN8cfa2SsOYDAMNoAto/KfOi8Cp1AnO04yqB3oDj68fDXbw5bqSmo7NaFd8cVMUPftmxRBTqHcGWreC0Aa0GNtvh9Nz1zRkkEx5r8/UZTaYnJgAk/f1PnLIs/IUl12Q5dLrvQqTVJ0CnAFIpLRleVvEkTwBOLsPAuQbG47+YJNapRdmMsjnhy3CTenb6/7rTMazjw8GPRa1VRALeUj1o5gPYPyONMnsIHSj0ifYhYL1xM7iJ87RxuOs1E7mPwlF49qRkCfW1BZihA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 23:48:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 23:48:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Topic: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Index: AQHcWY5pp8pvRk/tS0G+GdNsr4pEy7T6qvuA
Date: Wed, 19 Nov 2025 23:48:47 +0000
Message-ID: <ddda3d01-b95e-4798-b21d-a0c526b5b5a8@nvidia.com>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
In-Reply-To: <20251119195449.2922332-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6522:EE_
x-ms-office365-filtering-correlation-id: 03286f45-bcdd-472c-749a-08de27c62ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUJSTmkxQ3YxME8vVEpCMU5rQy84WEJKem9TTmdFdG1VWThkSkxYMlYycnor?=
 =?utf-8?B?akowOFR6b0VkM1FpbzR1MDh1ZnNrT1ovZk9RNjlzTURsSGs0ZEtHalNYazZ5?=
 =?utf-8?B?YUNZTzlYNlJIeEg5Wkg3cWl6ejMrbTlQOUFhelp2MzFyNkg3SGVSWnhOU3FT?=
 =?utf-8?B?eWI1cTd0SmlFeEF5OERrYms5S2xlMk05Y0ppMncyREdQL3BoYnlxV2htV3pU?=
 =?utf-8?B?RjRweVJodStOU2dTMUFiem1sdTZjYXZNM3lNd3BiL2VaanNtMW1PU1BkV3NB?=
 =?utf-8?B?S3BEWGFFWVBHYXlmUkVzWml3c1hRbXA0UHlNVmYzVVhRTk5YaDUybSs0ZzJw?=
 =?utf-8?B?bXc3TVp0Q3BFOVRPTzlxbnhqWEV5czBBNlJCVzZxL01BSndGZzhlM1pvejVG?=
 =?utf-8?B?MnlxUWRjRXRmRncvRXJqRWk3N05rbTdGK0xHUmlNUWtjZDJITFJBVVQrMVp4?=
 =?utf-8?B?SkJ0U1JTRXREMmNMUi91MGh6M0MvTUZhendVc2JPTWd2UXZKSTRvQ3hyRHhB?=
 =?utf-8?B?ZDNyaUFhQk0yTXZaWThMZVM4TzZHa0U5WjRkS3EzaTNYaUljYXlpTTB0T2pX?=
 =?utf-8?B?cTdLMXZtRk5PeVhCRTFEelNMVU1acTYwdGJhR0o2UXRjM3pPb0ZmSnp6UHk3?=
 =?utf-8?B?bGIySUlCSUhCenFVc09tT1cvTytPS29vK1grQUE5ZTdJdHFVN3ljQnM4YUJQ?=
 =?utf-8?B?a3FKRGQ2MklMM0thcTVKbXZTbE5GNTRvdzIvUFo3QXEzdkorZHpjZTc2eWo3?=
 =?utf-8?B?R0N3ZWttV2FaODFIYTVBLy9NaHcvVXVCK1dobHk0VytnY3Joc2RQeXRUWERC?=
 =?utf-8?B?OS9ZeUg4dkFjdnorbXN5OXcyQ3NFMjRPQVJyTWNFS3p5TEtCVzhWSWhkNE9p?=
 =?utf-8?B?OFNMci9GbFFqazcyeE9mNXdCQXVhMUlBamp6UGFzamhaNS9aZ0tDanM0azJH?=
 =?utf-8?B?VVpuVytscnJ3d091TElBTHM0MkpsWkpmaUsxeEpXb29XVi9IdlBWYlBtc1hI?=
 =?utf-8?B?eU5OT210L2lWcEl3ckRXbmJqTXhWd3hKUWhEV202RFhWVlNyanBVdnlYYWlB?=
 =?utf-8?B?eGFaY0d5R2ZqUmZUQkNUVlVUTjhRVUtRbkN5ZUtBOC9BVjZleG1PVlVEZWxF?=
 =?utf-8?B?QnA4cE44a2h0SVhyMTRkK2Y4ZElIK3ZQSTN4M3NSL3lVUlpVTE4rTkh5TXJm?=
 =?utf-8?B?UGtPWHpSbDFOQlA0dlNWQWJhQkRreUxOeVZtQkhNVWt2UlhIL3pXQitzWk1l?=
 =?utf-8?B?NnZrbG1Sc05tTmNOYk9IU3phazNSa3JOdE9FL1hzNmFmWWFMVEwxK2Q4eDNI?=
 =?utf-8?B?d1JmQ1pJU3gzajcwVURiWDc0eVVEOTVpaGZwYUNpcEU2bEU3emZuYXhNb2lW?=
 =?utf-8?B?anQxMGQvb2JPY0h5ZVJuNnFQWE1pNU5BNHFGYk9xSkVNRnZHb1VxN3FKMmZB?=
 =?utf-8?B?QUhpUlVwQTdVQ1FUODh1eVFxc1o5UEhmNVlySjg4QWN0SkhxUzJaUHlFa1d0?=
 =?utf-8?B?RS9jazVtUWk2Y3g1SFJwZVQybE1wallIcnJaczdoL2twTkVVKzRRUHZGalJY?=
 =?utf-8?B?MnFZOEI4bkVqMnJIeVhIcVJPK0J3RkpqT01Fd2orV1ltd1MwS2VhVTZ4WjNq?=
 =?utf-8?B?N0JjWnhOSEsrbm95OUJLNmFqN1RWeEJoR1JFOUk5ajN6SUJHc2RxaXNWSFlM?=
 =?utf-8?B?Rkg4ZmErc21QVytFTVhQL3FVYXRnMnI5TDkyRTZLZkxWRGVxOUoyaTdpS2Ri?=
 =?utf-8?B?QSs2SlhYQTc5bkFlSWtEaDhsdENZR2hTaVBVWWRPeGlYck5pRi8vdkprbVEw?=
 =?utf-8?B?ZGdiNTJRS2NVZHVYLzVhNWNBSTVNUCs5Ti9GWEU1bWtXZEk1alp1VitqODM4?=
 =?utf-8?B?VVgzdmkvOHUycUJqdDBab1puZGpNN29XYmRBTS8wU2tGMEhOUG00c0U1cHhW?=
 =?utf-8?B?TjJYc1gybmFjTWc1dXhUOTVKWlBMcVFRSnVHVVN1U01OYTY3Tmh6Y3RRVnBx?=
 =?utf-8?B?RktQVEVGclBINCtvUDJLd1JMNEVUWmFGY3hRaUE1YitpUSt0NmJKYkZwT1py?=
 =?utf-8?Q?irLeKR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWR2QkxIWVl6TTVrRmt3Skg1L09pSHk4bERPUkU0aXZNMFkvZG9mUHFnZFdo?=
 =?utf-8?B?N2ZKY2Y3YXkyRW4wVS80YWY1ZlJ6a0ppaWhpS0djTWpEcXY2TUxiTFg3WXlP?=
 =?utf-8?B?eUR3NEszamdqUGczNmFFUnErdzR2L3BSdlBVYS9NS05qWkIxVTR6Rk5SV2wx?=
 =?utf-8?B?MTJxV1NHaGZBVXBveEY1a1hoYW45MUNTUVgvb3picFZCeExNdGNyZXM2QnBE?=
 =?utf-8?B?OVF6ZHkwcDhLeEVBdkkzRWs2VmRpbHJQVlVLblY1V2lveTFoakpJRCsrTzZJ?=
 =?utf-8?B?RjJYZUpmaGpOUnowTTQzRHhGYVoweERLQjVkTU5sdzlMNEx3MUhpTElFbnpM?=
 =?utf-8?B?ckdqTXYvbFF6eWZHRjBuQUQ3bUhVRHpYUjZhU2NZdmlYbnlLR1crSmp0NFBX?=
 =?utf-8?B?Y1hCcDQ1Qndsd29vRmg2aTFFRmJTZlFLV3pDMW9nVEhqeDR1SFFUMXQrWk4v?=
 =?utf-8?B?T3hPeHpXV0xPNVAzMUVtbVRMaGp0UGV1NHN2enVhSU91RlZHUWRyd0ZLeXN4?=
 =?utf-8?B?U3RrMXhENTZUbzJzWXBBV0wycFhsWWpWYWN6bHF3dE1wZDV1YVVubjJhM0N2?=
 =?utf-8?B?b2c2YXN4czBDYUNqZ0xvOFhjd0hPT0o3d3haYm1jeTFvc0h0bUNhUklaTFRM?=
 =?utf-8?B?akE4U0tkYVNYS3o3THFVNFNOMnlPaEhOWXFFRTFtYnpkZnZ0bmJlZ1liLzNt?=
 =?utf-8?B?NWlmaWR2WjQ1dEJhcGVScGdHRXV1ODJDZDNFcVZobVdzN1BMY29HcWswZldy?=
 =?utf-8?B?Zm1IcEpyNFFNNUYzRU8rd013dUkzSzJHd2srVGgrSWZCRm1vRkFDb2FpS3RS?=
 =?utf-8?B?TmZFLzNMUjJ5R1hjM205V1ZqUmpDbElBK0h2Q2JJMDlGWjEyN0FBTHdyQmVl?=
 =?utf-8?B?QmJsQVYwOEJJM3BmTTVldFZnRjNSQzNIZ3pyRm44a3JMMWlvOVNtYnU0cEpk?=
 =?utf-8?B?OVh4ZHBPdkxJV0ppQ211SGk4a1BCa2ZlMUR1ckFxY1l5MStJK1FHc3RIMVh5?=
 =?utf-8?B?WVNRd0htMzQreW9rZ0ZWSDF5RFVjM3VudlFsL1k5SkFra1BBT1g3S1EyYmpW?=
 =?utf-8?B?Q2JnWkFkaDRzZXVIWmo3czNQTkRjNG82QkRXWlRieXk1cXArUFRTMFgzcGJV?=
 =?utf-8?B?SjBHT0hsVVB2SzI3VXRJK1VhNlpIRTRKaEt6OGc2V3k0akYvWXppdHBTczRi?=
 =?utf-8?B?YlB3SEo1c1dLemlJNE10Wks0NWNkM3htQkFCcjNZNVJDL1BTemhkZFpKWGI0?=
 =?utf-8?B?aHhWWlRmTXBYUnhGOHFaalVTMWJTeE9EbWJmVS9qTnY4OUY1akNBb1d6TWdv?=
 =?utf-8?B?WS9qL01qU3JGajlKUTJVVGdaTXdHK0NISjBHdVJjWW55Z1dBZ1gvYXlOV014?=
 =?utf-8?B?UFloUktIYXo4alM4cU9Yc0lhT0JiRDlCUXZXN1ROUktkTnd4N1hhRlcvdm5Z?=
 =?utf-8?B?VE5pNlBZOSs2dlJFNXpNSlQyWXhPWmtjQW1Xakc3NjJBR0JGLzErMjA1Y2RQ?=
 =?utf-8?B?djVva3NIRzVsaEQrOFljVkpmODBrNlJxYzRXL3RaRjFvT0FQbHVoVGhkNUtN?=
 =?utf-8?B?LzZXQzBvUkdGamVCcWVoYUxEdys2dlFrc0tSaG56bTlWYkJHVnNHMDJWQ1A5?=
 =?utf-8?B?VjhNVGZZZVdDMjFpQkU4aGRmMVVuOC9MV3ZPTDZUcmZxNlhLaHJzakJBWDRO?=
 =?utf-8?B?Umc1ckRHbnVXTUJzazJrTFd2aEhRL1RLRDZOdEt1eHpGNzl4ZHV1c21MUzk1?=
 =?utf-8?B?RFZkZzJMczNoSkltUVNFckROM2tWOTVSNlcrNWRha3hkZ1cySjBZaUZlLy9i?=
 =?utf-8?B?OGxLaEpjZVNDU3VnYVdQSkpwaWRMQVljczdxdkFnR0tKYUk3RG9PZVhIZGJx?=
 =?utf-8?B?VUgwUVBnOEtEYVNaV1dXUVlZQjJEcVkrUTVWY0RQYy8zVlY4c3RiVXM2NWUy?=
 =?utf-8?B?aWhVVVNpQlcram5mWVRSbytVZzNucklEazg1V0JqZk9VY2tXWE1NdmNZUmJa?=
 =?utf-8?B?ZGNGdUxhZnFodTduR3dkd3B2TTNMd1JNMi9yb3lWN1RXTEE2ZXlMalViYTZO?=
 =?utf-8?B?RU4rczNBTXRrdE5CclNjditHSndvUzdrc0piQ3cwQlN0dUZPZndMb1B4QWJS?=
 =?utf-8?B?SEY0bjVPL1ZoVzRZbWF0S0ltaERKUGpwdG1oOTlmM2FXN0J4cU1MQ3dJYnJ3?=
 =?utf-8?Q?f2gX/ltwz5WoN2Fcx1uHySPFkkX2U2n5CEA7h6BEfqy4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <508F41A171E57B4287AE4E6715C25D8F@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03286f45-bcdd-472c-749a-08de27c62ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 23:48:47.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYh8J23iufWLvz6whW4rAlHh1L7EJv+CFpacOLhvJfuTHUaefVfrvseD/fQq+CXB/xlt67u3KyD7gtirFv0qvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

T24gMTEvMTkvMjUgMTE6NTQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiArc3RhdGljIHZvaWQgdGVz
dF9pbnZhbGlkX2RtYV92ZWN0b3JfbGVuZ3RoKCkNCj4gK3sNCj4gKwljb25zdCBpbnQgdmVjcyA9
IDQ7DQo+ICsNCj4gKwlib29sIHNob3VsZF9mYWlsID0gZG1hX2FsaWdubWVudCA+IDE7DQo+ICsJ
c3RydWN0IGlvdmVjIGlvdlt2ZWNzXTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaW92WzBdLmlv
dl9iYXNlID0gb3V0X2J1ZjsNCj4gKwlpb3ZbMF0uaW92X2xlbiA9IG1heF9ieXRlcyAqIDIgLSBt
YXhfYnl0ZXMgLyAyOw0KPiArDQo+ICsJaW92WzFdLmlvdl9iYXNlID0gb3V0X2J1ZiArIG1heF9i
eXRlcyAqIDQ7DQo+ICsJaW92WzFdLmlvdl9sZW4gPSBsb2dpY2FsX2Jsb2NrX3NpemUgKiAyIC0g
KGRtYV9hbGlnbm1lbnQgKyAxKTsNCj4gKw0KPiArCWlvdlsyXS5pb3ZfYmFzZSA9IG91dF9idWYg
KyBtYXhfYnl0ZXMgKiA4Ow0KPiArCWlvdlsyXS5pb3ZfbGVuID0gbG9naWNhbF9ibG9ja19zaXpl
ICogMiArIChkbWFfYWxpZ25tZW50ICsgMSk7DQo+ICsNCj4gKwlpb3ZbM10uaW92X2Jhc2UgPSBv
dXRfYnVmICsgbWF4X2J5dGVzICogMTI7DQo+ICsJaW92WzNdLmlvdl9sZW4gPSBtYXhfYnl0ZXMg
LSBtYXhfYnl0ZXMgLyAyOw0KPiArDQo+ICsgICAgICAgIHJldCA9IHB3cml0ZXYodGVzdF9mZCwg
aW92LCB2ZWNzLCAwKTsNCj4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gKwkJaWYgKHNob3Vs
ZF9mYWlsKQ0KPiArCQkJcmV0dXJuOw0KPiArCQllcnIoZXJybm8sICIlczogZmFpbGVkIHRvIHdy
aXRlIGJ1ZiIsIF9fZnVuY19fKTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoc2hvdWxkX2ZhaWwpDQo+
ICsJCWVycihFTk9UU1VQLCAiJXM6IHdyaXRlIGJ1ZiB1bmV4cGVjdGVkbHkgc3VjY2VlZGVkIHdp
dGggaW52YWxpZCBETUEgb2Zmc2V0IGFkZHJlc3NyZXQ6JWQiLA0KPiArCQkJX19mdW5jX18sIHJl
dCk7DQo+ICsNCj4gKwlpb3ZbMF0uaW92X2Jhc2UgPSBpbl9idWY7DQo+ICsJaW92WzBdLmlvdl9s
ZW4gPSBtYXhfYnl0ZXMgKiAyIC0gbWF4X2J5dGVzIC8gMjsNCj4gKw0KPiArCWlvdlsxXS5pb3Zf
YmFzZSA9IGluX2J1ZiArIG1heF9ieXRlcyAqIDQ7DQo+ICsJaW92WzFdLmlvdl9sZW4gPSBsb2dp
Y2FsX2Jsb2NrX3NpemUgKiAyIC0gKGRtYV9hbGlnbm1lbnQgKyAxKTsNCj4gKw0KPiArCWlvdlsy
XS5pb3ZfYmFzZSA9IGluX2J1ZiArIG1heF9ieXRlcyAqIDg7DQo+ICsJaW92WzJdLmlvdl9sZW4g
PSBsb2dpY2FsX2Jsb2NrX3NpemUgKiAyICsgKGRtYV9hbGlnbm1lbnQgKyAxKTsNCj4gKw0KPiAr
CWlvdlszXS5pb3ZfYmFzZSA9IGluX2J1ZiArIG1heF9ieXRlcyAqIDEyOw0KPiArCWlvdlszXS5p
b3ZfbGVuID0gbWF4X2J5dGVzIC0gbWF4X2J5dGVzIC8gMjsNCj4gKw0KPiArICAgICAgICByZXQg
PSBwd3JpdGV2KHRlc3RfZmQsIGlvdiwgdmVjcywgMCk7DQo+ICsgICAgICAgIGlmIChyZXQgPCAw
KQ0KPiArCQllcnIoZXJybm8sICIlczogZmFpbGVkIHRvIHJlYWQgYnVmIiwgX19mdW5jX18pOw0K
PiArDQoNCg0KaXMgcHdyaXRldiBjb3JyZWN0IGFib3ZlIG9yIGl0IHNob3VsZCBiZSBwcmVhZHYg
KCkgPw0KDQoNCj4gKwljb21wYXJlKG91dF9idWYsIGluX2J1ZiwgaW92WzBdLmlvdl9sZW4pOw0K
PiArCWNvbXBhcmUob3V0X2J1ZiArIG1heF9ieXRlcyAqIDQsIGluX2J1ZiArIG1heF9ieXRlcyAq
IDQsIGlvdlsxXS5pb3ZfbGVuKTsNCj4gKwljb21wYXJlKG91dF9idWYgKyBtYXhfYnl0ZXMgKiA4
LCBpbl9idWYgKyBtYXhfYnl0ZXMgKiA4LCBpb3ZbMl0uaW92X2xlbik7DQo+ICsJY29tcGFyZShv
dXRfYnVmICsgbWF4X2J5dGVzICogMTIsIGluX2J1ZiArIG1heF9ieXRlcyAqIDEyLCBpb3ZbM10u
aW92X2xlbik7DQo+ICt9DQo+ICsNCg0KDQotY2sNCg0KDQo=
