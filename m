Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6E2FF164
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683334; cv=fail; b=cfeG/XKvUuNScOCux5Oj6XqiSOHgqT9viPJ6vXzixSAo4anHr3+vCfaAgFiGL1b9L0UgUGxeCedKVY6YsKBj7U7a/aJr9zI+tGMOz+tkw2/6ukBzFoPo5fsHxpuxzzR12fwdyXxpcCNYeU99XhDjZQQfq18UVCn3uWXEWzdWOoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683334; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N/WrqzN0/k4jiREhNLot/J2fgN0xLjOJNdLzUaThT/wAmAV3oEEnxhGDz5/L/vKV4DHcUxZWWyjC+3cL8VlaW8j5GqBoXOCPBZCUecckPrNsu3ExXfkJKc3zu01dl0inasewkaZXaBncAsniC7QgULHcLN5NenDN2o4rOeey1wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/kh62RC; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/kh62RC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSIlsY+0LQrog+HyewAt9O9P5YThqR0pCTzWQGZRuA3S9G+HN2GC46WrhtCqMd88+YJ2k6WcyoY+ZvFl/LIFUs5fmJi6ehe4/wZO8AusbqQ2DMftTSjeR/kpJKw1zIjY1zsS8bw1Kgjh0CMfNryLfsG2z+oKXXnsxvHvOiHnoMsHre4SzyaWs1RzOQxybZ1LiIKc1MCLSjnMC6kj8VZ3M0oabiuwdi/PrxuXqLwW2i7gEITCpdyJwE8mlfOv9w/ZdVDpLXHtu18r0p6UdMNyOl/3DZqBZTUzkuASp5iscuIUT5hsEiFx+fsjgSvZTmO8gneLLwZL4qm/sKbwaO24Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=ZQ7PxYQPG1DRzOGVjU8zkJeKf3DoTeW70O1SqvdErjiZwxVUKAEPQjqizpXhCt/mn9Zsqt85ei56Gysw8QO59Qc5z/I2F90FEXZtqQIycr4nfap3TuWNgzOp6U66N5wx+x2EMN45BMFaBLZF8ARb/krd+fpVQUvRiu382St0riAQMI7AxMQIJoaV32Mf6myCodmWE47y55H9ePSg7HUxTHnbCORrwOMG1omSaZQ9r7EtZTVkt4fV9NUmxjVFnK+v3M7vgCdxgwkQXbqmjipFCp3cwTIne4zDZEal2F3j3XVdbgF3ByHgMCiFLPntr6tzKGLcFEZgQxC5hxa5V8q8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=i/kh62RC8ZV3hod9ikPf450r5V9vsV/kWs37W/glYM2rDd0sWSS7AKozoLdV35s/kCTnn6JFpYpOTp+BmKq2JnT7HrrsAm7Sx/xq2ot7ZktMKjxKVgl2MjUKHI7GDJuWX+Fv0TxR382j0bVj7eR77ZZ/bChDTiLDzX/O2C3Fy2gfIVrTR/G+6GlJW9iuPKeM6+z9GiTx87QDmOVlUbahoCfq5uapaFqDxN6s76+keD6zGA40xyLTsnToJoHKio+ZWZA69ABwbHAstyRTybDnXQ9AzBo33mPaTk9yOgHWTmytTxdC2yR3jkj3qR9okADp1G1FwobQDqjtcrA8VifV8A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:15:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:15:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>
Subject: Re: [PATCH v7 06/14] block/blk-iocost: Combine two error paths in
 ioc_qos_write()
Thread-Topic: [PATCH v7 06/14] block/blk-iocost: Combine two error paths in
 ioc_qos_write()
Thread-Index: AQHc9RV0LtFvS+HU0EmLBXAFGiY9LrYwRGgA
Date: Fri, 5 Jun 2026 18:15:29 +0000
Message-ID: <a37547ea-eac5-4b87-be9e-befccdd08ce7@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <80d4fc1ecd5eaf187c0a31c63a1033a7326d4c7e.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <80d4fc1ecd5eaf187c0a31c63a1033a7326d4c7e.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: 0b4d9be2-2483-4c13-58b1-08dec32e6ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 yftUUHptDFzcSt9t7QSGKJCluMdx1Tfsqbv5Gi/tWfa13bkY1sFtwxnj9q0mM+JAAK2nxzWRsjmOMZy5rZSCBx5/5b7q0xEJB0gjFrhaVje2xeS32q6Z9L8yQnsNjmPi2i9/fXF9OwAhrOI7MYb7LZsu4nnggRngWAoVGDLrfKl8wJGV3DnhA96bRy9/Vq3BDsoDm3EJJjr7Piu5dM92VS55lfD3jCqk1NEn1rffiBKDjtDJ8How9+cIqeZLhSd+zM4Jz796LMJR/Qn0tONGc4QVs+2Bu4wSN6/EYdJ8Lynu3iqygToPB2kShjuLVJG5oAJAT9b4RVNGarXQ3R5ZObANyE7AwtseP3XCRAdvUw+VHV7mz3LmIYwVgs0O0R1+axrDvnYeZ96cgKQbvHxA+WBozgAsU/Bj060gJbEELNtQIxIVv+zgNT4mDy6YDlVdNWi6Hj/4OxLENUECOmTHGSJIGgdULvKOU2/9laMBfKhmu7z62G2U4qxIDMQ+BgqTNOyz8XI/h+EsoiCZaO3e2Ys7GOK9/xUd3ZeTAQWsMbYPCw/dXv5OkuzTJyCI0akZhg42JQCZLcBWuE+eaLT5HvYUPFNiuXmZOLMA9dfZvrHtnrx4XUyTmpPs1fV9JwOQKGViR9zVNQn2eZuPgZoJ+G025TEUYO/f5oyARIXGfprBWMRHA9qW+bfhLRzMTwg3gFfzzd8hTGRRAqpn5zr1bXTukJGtSw2V6hvgsb0S33KeVbzG1FKXTzSBKYlz1hKu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDFkSzBNUUQ1cW00eldoOVdSVXRUaHNjS2RGb0lpQmVzUFphT2Q4dC9sb0ZG?=
 =?utf-8?B?TDVlVUF2THJxSmJic1U1UUpJTG5YdjJaNTd6dGVMNWR2aUZHcjBsY1h6bFR5?=
 =?utf-8?B?YjYwTktJS1d2ajZra21oV3lTR1pBNUlNUEVTL0xOSVBZTW96eG13VVIwTUF5?=
 =?utf-8?B?bm1zUy93eXdqWmhyOFI3cXRRVVBoSUQ0ZkwyWkNWOW5ycFBSOFM4U0MrTXVl?=
 =?utf-8?B?MFRNZkhSZ3oxSStsRWkrY281dGhQUmJxOUdyeUhpV2JWZ1h1TEROcE9NTWN2?=
 =?utf-8?B?QS8rWjJUN1NJbE1jdzdHOGxWOTlCWTNNQjJmdjVESkN4Rmw3Z3lFRTVGbmhr?=
 =?utf-8?B?TDU5QXJjZTVQTSt4Z3d5WGc4cFRvQ3IvKzkrakRZa2RTaEhZVit4amN5RTBx?=
 =?utf-8?B?eFpHOVZHL0pLSGdKZTVVRHZUQVpKZ09HeEdSMzV1bldlU2QxS2h1d0h5R3Q2?=
 =?utf-8?B?ZTFRNXpTV0laOXB4WDE3bmdHN0ZQKzdvYlY1bnZPOTlJZFZ4cE1oT2JtdXVp?=
 =?utf-8?B?Vjg5c3RJQlY4WHg2ZUFXRW1hcW55WllmQTIwbnZpK2pJQTNpU3NtNXF3cENh?=
 =?utf-8?B?MGhZVGVxOUdOdUlzVnBwd2FuZURtcm1HT0pmQ2cxSVF1bUZTT2YxVlR3L0RP?=
 =?utf-8?B?eHdETkdXUHlkWVBZeGpjbjlWMzVrR0lHekVZcllvQU85Z3FHamttSVVqQ2JM?=
 =?utf-8?B?TjVwYTJzVTZ5TzREb0s0VmorY2Y1NTFqVjhJbXVlNlhOdWxoVzdEOGQ1WHNN?=
 =?utf-8?B?eUsveEkyZnFDRlk3K21VYm5vQnRxRTVQWjc0dktZWVBnR3RwdHIzZ2syblFP?=
 =?utf-8?B?L0JES0FUMlRwdFU3YTIyZDFYOVBveEhiNEZGVDlBK1I2bkVyMEJqN2daR1lD?=
 =?utf-8?B?bjNIdGROeGllUnVhSFh5WjY0ZDNHa1hRNDc4WlowZEthWkl0Q3RSU0UxaHQz?=
 =?utf-8?B?SjNlN1FIdVM5UzZCV05VQ1ROS1pTNVMvOUw1eFdRUkdhUU5La1o4ZXJhOVkw?=
 =?utf-8?B?VXZjaCtXSnNkVWFTMTBiMkFyZDRIR2s2WitvTDFLNUs1SjBHN0hYbTgwemJk?=
 =?utf-8?B?aCtZUzlidGpON1BoU0Q2Skp1SHJzaGJtVm5TZzZla1dXZHNOcDdpWDBtT3pK?=
 =?utf-8?B?b01NaHEvTE5zRHp4SnN6RVZObXU0alc1M0NSVVZmMnE5d1VLVnEvbnc2Zlly?=
 =?utf-8?B?ZFU0d0VjSU9qZ0I1Z3lDTldIQTRQWDIxNGlzMWVHTWRYVVA3YlNRMENNY3V3?=
 =?utf-8?B?ZDdTbmNscGJNYmptVkgyaFdKV1JPelR6YzFHckR1YlVBZnRXVndKUTBFWWoy?=
 =?utf-8?B?ejVmRS9oZTFmZ2JFbGNmRk5vbFVNcGFwOW1EQ3FGZ1lWclRaeW01NWlsSkRF?=
 =?utf-8?B?WWRkL3ljZzZYV3VvTEtmOS9qWnhjL3NaTlhTOS9NQWthU0hITWUwSmFMRnU2?=
 =?utf-8?B?UUcrQi9pNDZrNmg0QVFhKzV6Z2lHanNSL2J5NVhhNk5jbXcvSVdBOUlaRDZj?=
 =?utf-8?B?QldEV1I3ZWZpdUJlNVFCK1JmWU9NbzEwVEJVSUhDOThSeUs5b05PNkcvZFBv?=
 =?utf-8?B?NG9tRG5Sc2diNGQ3YmlqZ0dKRzd4NjNCcWtvdnFwLytkcjMyT3h0TDhiRzVm?=
 =?utf-8?B?ZCtxdFlmZnZoT2xuS1YrTTNSMGdFb29YenV2bDNCYTJBMk4rVFY0aDJEeGFZ?=
 =?utf-8?B?OHJmSndFeEhvNVhiMUlzQVJ6Qk5HZkNvMkFoU0JtT2pLYndlTlVTY1R2Z1Jv?=
 =?utf-8?B?MVQ3eHJmWDNKZWZQdzB6Y0xhZXFaNmNzTllPYkpTaDRwWDJOMUNJOEV5TFpw?=
 =?utf-8?B?YytkdzNrZ21PZit2TnN0NlpsOExoQnVrdGtUbW1HbGtDaDdwSUM2bXEyd2Fk?=
 =?utf-8?B?VVI2ZE1LN3ZWTVJxTFM2YUxZbXVrclU0WmovWW9VaTRuQm5xTm14T0ZpMGlK?=
 =?utf-8?B?WlVLK0NOaXpFcTdlWlhvbWJyUkhQa0NzTHUybkdkc1RJRktQMUJhbXQxZ1lx?=
 =?utf-8?B?djhvY21RUmlEMUR5c295UHd0T1RoVGpMVkdWWGlaY3FrRkRscnJhWlRhenFv?=
 =?utf-8?B?SjF0S2kvbEVmVE9RaVRZSFR1b1dEMEFobkVML2g0RXZMa21KR1ZWaWZQc3Nk?=
 =?utf-8?B?NXlrakhJQ0ZVZm1nUDRJQlpyU1VadW5qaG1TQnBBTzBhNUFuOURXMFdwNjdS?=
 =?utf-8?B?bXhtdXhmbWJYRHExajN6WDlzMlF5VmlyVGRGcmt2L0JJalFVYjVBQUU1SHNZ?=
 =?utf-8?B?cVJGV1pLVW5yb1A0RkcxN3JsNmh1V0haODJvb2FhLzc4SUcwM3JLOVFRb0N3?=
 =?utf-8?B?QzQ0TkY3VjJpbmRxamlUbW5WZ0tNQWNvTFRhQlV1OVRVQlo2SktnblBiZTZp?=
 =?utf-8?Q?QVrFRq5urVt6RRoDteZdjYEi/Uq5dK0Qz8KjS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE3E17B146ADC44B0D6BBA482B8B7EA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d9be2-2483-4c13-58b1-08dec32e6ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:15:29.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oub5fwkyCO3hgJItyKRArdnwUaVSeboWp5X6Zol3AKSifd7v0jBdss6B/JYfxR0zvMugc0DcEF7eDIaiuoUdSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
