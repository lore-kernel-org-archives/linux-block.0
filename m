Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C0125CC
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611426; cv=fail; b=Pz//vl5nszyNch4BBLNhYwhNPFXqSXChWAWcQ43iCfyHkPmy00z7gACeT6qtdi88wv3uVuf2ljcWh9ha/OiCab8BwNF5z2aDxRxC+UghSt6OZ8phBvSGus178m3O4cq147Iu/kLHVUQPzpIVWbOLegTHa9uZ7cZUcDdCJ3zDwoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611426; c=relaxed/simple;
	bh=+BmwhLSpEFHUVDZPCTcg5vbcnvypx91z7gtFFSk1Msk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Afo7YwJ0sKcgGGhMQOMJoBvNrYt41eDwTHWEW7TdEXVjfnjXHjbjfD4e1IdBAbkbFbFBKy1LX2F0YyujBh+xTfwRc8WvMi2D59r4vby6gEAbr+Zb2LFfQme1jqcBSi00CfU42bDsYDhDWkeA9C45Mwq/79arAXYY2fYTdx8L6Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YLqkasSV; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YLqkasSV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxZvK57MJQHItEDY/AiJVieSb4a2ZFaUwCshOsycfgDnL/AHecG0oAJQHaus9O2rCSfTEqY9saICPAGbr5PwexJrVXKxTIXWfADTUMVYNqfik5/ms4EbYw/d6QMYmxdPuW0RjCIm+gU9drFlQCnXalC82dHfJmDsYWridnj3M7qiPvQ3OEW/XrK9qkpFt135sbdujmDpJ7hiHSmxoM6cTEoPbcHry7erkpD3xpRc0rGm0o9iFO9tq1C3DMN7WDWm7P90iubOqoroFya4pewq8tL2LjFd23mgX28Sucjtx0wClRhEXBSI25DLgK7eFVRe3XLf32yYTQ4V/aCTbLtC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BmwhLSpEFHUVDZPCTcg5vbcnvypx91z7gtFFSk1Msk=;
 b=dWn7U0fJ8aAt8v+BzWN4p40OIjthbCI7S47Dlfao1GkbxhqQvFZcQ9FJBMExtF2BEyVbQQ+W/fvVV515nyrvsIgOO+sZdYQX8XRI3EXJB5MNe7Ia+y6nCFagzD/a6t4CgNXIJh4aMr9uhyJiqxGjQcloHhcZKfoGl66HLNeZxqn1iIxJRyKK06OAGEmEfygJGBy6EHaczSai4fHPb9+SXSq7CEwhc9cHl9WDDo9DcvYoc34Kzs1G7rnIhbSxLQAvKyD6YnmRk6dSnGIB+tLM69wvT+B1bLb4IoR9L0GE4lFAu+UnMcDhItyuTOLfScypXnjgZWfSywHv2f213j63lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BmwhLSpEFHUVDZPCTcg5vbcnvypx91z7gtFFSk1Msk=;
 b=YLqkasSVRwCqtk4dQjIJ+wsfUTzPzAd1X/EO05avX7HWaWRVo046Kkwr3YBV5ENwRATrH/8rw9TYwwW0Ecjw7gutFLCtTK+vTRa1bp6//o+/+FzAFzrCw48H/qrZOOPf3kxGSbU/ZFmCffD8DiLxpWdbMzvSphyQvPrpJ7xwpGRr1kVAF0j4WK87KC2i+6cQa+C9QYI1MZ3I/n0h1+OOsJSTTkjnjhay1wvzYYQ2INJNIKMBWfJaRInoO+WBXyp+tKYr8VjifOXqF1dram94m6oCDY9ukDpfGb2ak6Qm5U7AAiSnLrMvqoDWOIOQ6qAXhTNqcyc9FKkRIbbsqH81nw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 18:17:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 18:17:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHat2P7zkrqQGQ8Ekin/EqHKtP+RLG5elSA
Date: Wed, 5 Jun 2024 18:17:00 +0000
Message-ID: <4cc3289c-21eb-4896-b769-2771c5cefb03@nvidia.com>
References: <20240605161815.34923-1-gulam.mohamed@oracle.com>
In-Reply-To: <20240605161815.34923-1-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5737:EE_
x-ms-office365-filtering-correlation-id: 6a535278-51b4-467e-242d-08dc858bb150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFloRk5LUE1OZHZaT2dPUHhaVGdxRk1WZFBQSEROZGRoaVhITzkrVnRUaENZ?=
 =?utf-8?B?bDhySkpxb3FocjlTT0xCUHhtckdSSEdsSHB4MStnVzRsa3Q2V0VZdC9mODB3?=
 =?utf-8?B?M29YVkptQmJCeE9mNms4d25CVWNvdCtoQ1lTbDU4d2xkdU5kMTJBRTR6aDBw?=
 =?utf-8?B?SWpBMGE4ZGEvNExPNnVVSlVwVHpObjJRS3dod0l5ZVVzQmtVQTBPWmluT1FW?=
 =?utf-8?B?V2RxVk9yWkN4UERhcnI2UE42c1pZVDdkSi96ZkpmUHI4cU1IQTVhQnZGTURm?=
 =?utf-8?B?T1V6dW5WSjRQUk42SlFzbkl0d0NkWlk5M0daZ3loWHJLOEsybHQzY2cySEFk?=
 =?utf-8?B?M09iUHpZK1VVcmNuTGZDZVZDZzgwU2ZBRWpYdkRKTE5ibzFHc3R0MGJJOE8w?=
 =?utf-8?B?cUt0SHFhYnlKWWVZTmlLQlZXYkYzcHM4VlBXaDVyZndWWVM2SThLQkVzMUk4?=
 =?utf-8?B?OW1tcEcrT0dhbXdmQmREbytzVHVqSDdzcmFLMFA2amljU2I2MjY3cFRNbjU4?=
 =?utf-8?B?OWN1VFZlZFdrb2VyYWRmbDdhZ252Z29zM2h4anVkZVl3U3VYZTRWU05xbXU4?=
 =?utf-8?B?U0J6dlUvUTV6dUQxQTNOdHFSazBMdUZsODZFOHovVGZZZUd0M1VqQjlRVnQ3?=
 =?utf-8?B?YjY0R05jWlJFMkZTK014T3VPVXBUZ0VFRnFQUWR2dDRjTzQ1V3FWUStrOU13?=
 =?utf-8?B?bUU2amRhakZWTmpMK3NQRUtHdUNZMnZmTGMxSGpqM0V2Tk5mWFZHR1hmNkxu?=
 =?utf-8?B?dWJzeFE1RnBVOE9BMWVQV2psSHBxRWpTN3RGVjhXZ0pDQWtVU0taK29yd2NM?=
 =?utf-8?B?UkpqQWRDbDFzeXpwRjkxTHlHUlB2eU91Ym42eEFpQ0JvYlA0QzIySnJ5WHNV?=
 =?utf-8?B?aVd3SGQ3VjNVaUtHRkcvUE5hV3h5QTVDK2NJNy9BUG44UXo0ZkFOWDgrZGwr?=
 =?utf-8?B?SEZCMnNLUU00Mm1ybUFVckRpaHVhRVlZbmlSWjc0MmROVEVCSSthKzN4V2pp?=
 =?utf-8?B?ajJQK3lDRVhZREFheXEzWDdudFdPelYrZExHYjRPdXVCR1VxNmszWWI0MGpo?=
 =?utf-8?B?ZGV5bWpGR0ZMRXhnbXMyZHZSaUVzaHl0NnBObmJOV0oxQlg3YVpFck1iU3pF?=
 =?utf-8?B?NHFkV1o4SWpXdnRIcXV5WEVFVlE0Z2kxZkJpVmpydFVXcnU3bDQ0RVZ4d3I3?=
 =?utf-8?B?QjI4SnV5RUEwL1V1dEVKMlprTFdLZTBlVy9SNU9zd1gvT1NTdS9hQkx1VkY1?=
 =?utf-8?B?aWNuUFpJV1RtZHpOS0tMdm1XcTVEWVc5M2dZckcxTzllM1ZvSGkyYnZZUEEy?=
 =?utf-8?B?S3YzQ0pYeENBM0xkTjFuQkl3N0ZFaDJablgxRVJNeHNJYWQveVlnaU1MY0x3?=
 =?utf-8?B?alRkTnZ1dnBQQkZYRThNZlduVjBJVUZkNnpYR0JhWTlSb3FUbzVqMjc1MVZM?=
 =?utf-8?B?TlVJOHVhTzZ5NFVKU2g4V1JmaCtwQlYrUm50aWsyUCt3UFNVUmprZHNyQkJt?=
 =?utf-8?B?aU14Q2plY2VwMm82WDB4aWxpalI0TFJ3Rmd0U0ZpMUdrNlp3cC9Ra3A2dEdV?=
 =?utf-8?B?WDB6SjZ4Ly9nN2pZTG5YRmNxNXRaV25kekxsZDNhUHlaMDNEcFBYN1ZLRm5l?=
 =?utf-8?B?VVU5cGxRVEkxZEQrKzlLNnd2OHcxTEJrZktUTThvZzlNd24rRFVVU29hZi9B?=
 =?utf-8?B?VU15NFV1SG5ZblJGU05GYWdadGxia0JpcHRCUmRkclZ6RENneUVIc0lwVmla?=
 =?utf-8?B?YWh2OSt3TVdJb2puaFg5VkVROTg0ZGZpNjd0RHlnMWhucHlqMUJMUHJ0aEFw?=
 =?utf-8?B?ck5aaFpnem80czBnY0R2QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?em5SSlVQMU5ZUmFzUFZpdHJvWkNwU0ZaOHNJZFVRQnhkR2tvR2R3TG5jMVV4?=
 =?utf-8?B?OTNBYlVvb3AvYzlqMGpzdmNuSnJoMHpad2RTRUNYN1VMUUFuVHZ2S3p0MWVN?=
 =?utf-8?B?KzFjZE1oanYwVHU1c3JpTzlHM28ycnZIMW52TG04czM1b2JmM0VRNGpTdGps?=
 =?utf-8?B?dEFUdWQzV1E5SitkWTlxS094aHVKTnFjajRmdUJGd1htOHJ3SndYYlduKzFR?=
 =?utf-8?B?Yk9HaTRiOUd5c3pFWHN2V3pzdmQyUjhERnJTdkNwQmNYMHhEYXFUTUM1aVdK?=
 =?utf-8?B?RDZCWUhyZXRRejlmUkc2aG9NOFFic2pBc3dGRjdsTTM0SlhDSDRodW1na1Jn?=
 =?utf-8?B?Y2ZNRGxGSExRMnFQSmpmcmpHZWFQaERGRXlELzJDeGtqelQ0alhraHR4TGxO?=
 =?utf-8?B?UEdrYWFFdndsU2VRa3Y5aGxFdXNhcmJQeU1vcXBCeGlQR1JqSCtJc1phd0ZD?=
 =?utf-8?B?alp1TE5YY3l6Y3FpSEE2WUxHVXRrWVJOZ3B5SmpDMVNJL0NUTVJzaEhZRVkw?=
 =?utf-8?B?cGQxTTRjeTVEQWVMdW9ZWk1DWWZacUFacGJuRStXN3hDb004M2NLeVZieVpw?=
 =?utf-8?B?S2I2QmNSalNWcTZPSmlGSXlRVnJCZnVpVHA0QkJ5Snowa3JGM0M3SFY4a21L?=
 =?utf-8?B?QzRFOFc0bW9PaVhTOVp4bXI3TnNTQmE0OEVOV0tiWGdPQ0VoL2NqVEFUdE9K?=
 =?utf-8?B?by95dzRjSDV0VGMzZDZvZnlQcU16WUcwY2pTY1JUaGVUU0xwTForNHdvVHRI?=
 =?utf-8?B?c01SYmNaRWxhVFZONEJTeTl2TE9ZWmJ1azJITCs4TG1zdkNMVkJIU1FpUTZk?=
 =?utf-8?B?Y1lLV3V6UTJTYlh0SGhNQWJxMXM3QXIvZEdmTGpsYkdyNzlYaWN1VWFXRHZL?=
 =?utf-8?B?UE1RU2NUQU85Ung4UTRXYlJVSk5FYjN6cWJEVk1uTFlxU0FydHJFd0FET3A1?=
 =?utf-8?B?VG94NFJEU3R3RGlWQjJ1WUE3Z2o0M1Q2QXc2M0NYVkx1SjRoNlIxL2NHOE5q?=
 =?utf-8?B?dlN4dEhydUlhbXBjaktCVmhsN0hwa0dzRmZZUWFYcXBnWkluRFhnY0JYc0J1?=
 =?utf-8?B?Myt5UWN5MHNWaklUbTdTNldmaVFzNjBIZW0ySGZhWUNodVk1RnlYVG54c2tl?=
 =?utf-8?B?MHEvNE9LQ0FjTGtOU3B3RzloM094djJZSmFYeWNiYVpVWkhXY0RiaWtvc0xU?=
 =?utf-8?B?Yzg1VXpJdzRZSlhhTG5kQXZXVzU2aVVrYmd0bDRvWHFPZzFRaGJETzU2Yytx?=
 =?utf-8?B?WW1yWU84SlV2RXJBTzA3VjNzQUxTZEgrYXljM0NoYjR4QXZtbUE1MnNMdkhM?=
 =?utf-8?B?cGdmVENJWmpIREEweFcxTzAzenNQZk9hNkwwV1V4SHVVNm9JTnBQcGh2ai9W?=
 =?utf-8?B?NHVxMVF6STc2RWJiSTV5bGw1OS9lcVoyZUdBc1NnOWNwRG1YbHRNR01WcW96?=
 =?utf-8?B?TUFkN3Q5bHV3bDQrWEIyZmlORmM3NXlXdGpBWU45UWZITzRIMitINVpOeGtn?=
 =?utf-8?B?cXB4aktTUVc5QmpzMHZaUkZYM0taSHRROGpuQ2ZJeGZyY0tXbzBmdlZ5MlJJ?=
 =?utf-8?B?RjZKR0dMRGIvV3UwOVpLQlg4a2RWREdZRHQxV1M5R0lTc3oyR1JMc3JKUnYw?=
 =?utf-8?B?ZkZrYkFZNmRDYUN5OUdYazFJL0pHTVp3YTk4TWVvNCtHQWVrUnF3b2hIOCt6?=
 =?utf-8?B?RlVqNnAxb1VXL0EyTDFDY3cvSE5SMDcxVlgrS2kva3U1ZGpuNXUvUkxTTGI3?=
 =?utf-8?B?VWdJNTIwRkVpTXNHeFU4SnR2NDZxVUtxVDNlTzl4c0ZZREhNSnBnZGVQSVhB?=
 =?utf-8?B?aTV6NWtXMnlFK3ovWERMVm9lU2Z5ei81TlR5SEpOSDFyTUI1VjB1dExCN0pH?=
 =?utf-8?B?eGlLYlNIVlNXQnhYcGlrZE85STFXYzFxNCtRN01VQ2VvVkRka0o0cGhvd1lv?=
 =?utf-8?B?K1E3eHhPM2k2VGdEb1A0MUQ3cUtVb291YWhGU0I0aXU2RHV5bDJHM3JDNmZN?=
 =?utf-8?B?VHdxL3Nta1pCT0pQUG5zYkYvRGxNZTd2YjkvWUkxdFQ3OEFWZFU0RlhEblI2?=
 =?utf-8?B?akhVQ0t5WDBXdi90Mnl2OEtvOGUxdnhFejJIVWdQY1BjL2VHNVE4MjMycU8x?=
 =?utf-8?B?Q1FtUXFmcHBaSVl2cEo0TWE4UTJ5QTAySVFhOWlKWUg0LzR4UHovdzE5WWI4?=
 =?utf-8?Q?mYcOr/v+/tJU6v+zcszLN01okMbBjfHuRoUwjBptyf5W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEA82ABB145A434E8294284AEA226E7A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a535278-51b4-467e-242d-08dc858bb150
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 18:17:00.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cP7lnpb5Z0D8nQ8e8lG4XeHHQ4Id9Z1GuDtqjlacaJ4mqJ71hsrQ/0Cn3p0j55y6e+aYjvq5BYbP0rOqvMVe0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

T24gNi81LzIwMjQgOToxOCBBTSwgR3VsYW0gTW9oYW1lZCB3cm90ZToNCj4gV2hlbiBvbmUgcHJv
Y2VzcyBvcGVucyBhIGxvb3AgZGV2aWNlIHBhcnRpdGlvbiBhbmQgYW5vdGhlciBwcm9jZXNzIGRl
dGFjaGVzDQo+IGl0LCB0aGVyZSB3aWxsIGJlIGEgcmFjZSBjb25kaXRpb24gZHVlIHRvIHdoaWNo
IHN0YWxlIGxvb3AgcGFydGl0aW9ucyBhcmUNCj4gY3JlYXRlZCBjYXVzaW5nIElPIGVycm9ycy4g
VGhpcyB0ZXN0IHdpbGwgZGV0ZWN0IHRoZSByYWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3Vs
YW0gTW9oYW1lZDxndWxhbS5tb2hhbWVkQG9yYWNsZS5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==
