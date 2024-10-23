Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2462E56A
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719793; cv=fail; b=tTogePrsSag/ZO3ck6SfHXsoL0Qyk+hG7/WnGlJaWjxoXDdfHcdIJnmci+AK497i8nFLvj7d7NeLysSJtfmVx6BxJ7rpzS9Si/NnzglyLwd6cC0ZFW3/5sMjydOploAOJnG5S5Uiz3fo/wc7kqBvDvD+n6izSef0w08X8aqsXpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719793; c=relaxed/simple;
	bh=rkZSsgwSXPYFwOYYIgL7NTeg2eSaCtYHVzZE3s7AA74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t1uB0HwLDDl+EjaVTpocBmy1Di3kmPurkfIDcuOQYXAJiCyt2AP/janBPi0+Svx5YBn4ddMRN2oRLv5dKZw/Z9GQfYVzB+giKr3uCjVNjETlexXALHK9BoGg3f8KHxoovJBsOWgSBHpOVbPdT5X0nB+9UMvFAyFWk9xLQxxhqGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7VxjU6w; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7VxjU6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zET/ya/cw7QjVV4NASffe9wck8EjePAQv3vOjuu8Gmxp+ppCSEZkp+TSjJ/PYfaMPjZ5bL/Z4kydp0fjSpMWBvj9ZDByPRt25NkWKVM/7XWIVq4KQGyIKonW8HeAeqtKABRLfwLIQ5rGS16Pg0sDPlo2nY2p1SVQ7GUXyldFTeZEQl8GiOoePqZfpx6X7yScVdOeNoAaJtdeW3YHS+IBNsr6zG50mbbtkL55rsY7qhhW7zNXvJlBh5WcQnL33oe4/s27LXR7SywpO4/Gh1EpV16NDOKHEZDkopyCuE3xTGiscPkheRdmcUdXlW8adQD/9d3GGxX1PdUWqNkS33iT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkZSsgwSXPYFwOYYIgL7NTeg2eSaCtYHVzZE3s7AA74=;
 b=rBd25bWrya67mk7OAQvwiP2pNpYwtmKFwtLmoOiRdE782vgSV3p/6vKJqGhDrsRUdMhonCuany7vjjs0wZghJB7kasf+awnY1Y0x9Uq/HEiMmbQDQDkMk93fJiNmwdWfKXfMwJvv+o6CyN/rBHm4W57BCaS9uro+NLaGjX7SSR4AOa/bTfJsxlVD7qoaFB6xoG9+AR6ldIGYtNp97FrhkP3EIHyClO5kV5jqgRJGnXblW+jcOUFOptieKszHgIm8Xyo+L2dNaOaTGiie+ewVYydrQ3uIvkVbDESZfN09iQ2+YD35DQPZ3sG0R0C7VxYmGc9YoXpBn8EBB5WEljkKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkZSsgwSXPYFwOYYIgL7NTeg2eSaCtYHVzZE3s7AA74=;
 b=W7VxjU6wF5DyzDK7+l5mAMDmjwue0KaZUcGDtd+e3plT2E9FhTM2ThQojlPyKIiHqOxj+McWzpOmP4z/9ARvIy8CWMAj6QpuvI3VyJn0YpDKhFha0tazKgWojzIH2qon5uhXn71od35ZW/9fqQYaDI0Dgkuf7le8qkFs2N9cUHLlGFvtn+jBaKBT8XUIpyND5bBxThDxdx2jF4sxyD2nG0iYmm528ez9TTAp4NFT60JCBg5YUTVrLqGqdrrkrdwIkesFBkbIvo0u+Ws/9lAPzIUY5zUYBQtecoQfBd/rreiGU00UMjSsaq/UmHQI/f36c6iPEmFBBkKBfyHa8HDipQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 21:43:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 21:43:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: Unexport blk_mq_flush_busy_ctxs()
Thread-Topic: [PATCH] blk-mq: Unexport blk_mq_flush_busy_ctxs()
Thread-Index: AQHbJYo16rTirPFbiEiXiKPlBGuaw7KU3gOA
Date: Wed, 23 Oct 2024 21:43:07 +0000
Message-ID: <062fbb4a-937e-4dbd-b3ba-7a8e5ca9749d@nvidia.com>
References: <20241023202850.3469279-1-bvanassche@acm.org>
In-Reply-To: <20241023202850.3469279-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6412:EE_
x-ms-office365-filtering-correlation-id: 56aaa84c-03cd-4bd4-e169-08dcf3abaef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zy9mWlNKR3ZWWGU2anppYktQTVd5eG9jL25BNHR2ZEZJby9xVUcwc3ZGVE05?=
 =?utf-8?B?TE9Dd0l2aUNzOWRJNnN2VWNQQWZmcmdNa1JQeFVVTlA4N3hxUWFzd0RZb2ZV?=
 =?utf-8?B?bFBSMmh1TGNQKzJ0WnVYYzY5OXRhNFBKV3Byd1ZZMzJGMWlZVkFUaktuVFp3?=
 =?utf-8?B?bUlnWURrNHpYQUtVUklkQkc0cDBNSTE4T056emVGSW5WSExQTk9aZDhic0dw?=
 =?utf-8?B?VW56aU1kL1NSWlNYU0VleXlXQzBQdFczSi9XcU5CVDIzbXdHMnE5R2tCZjhF?=
 =?utf-8?B?WUJ1WFVidlovTlFaY1N6Rjg4YjAxRVloWDJCalpqM2JnQnpBU1NSb1lsaCsr?=
 =?utf-8?B?elNHQktVVGsrVVZWaFl3Z3lSOGg4MlppNVoyRG9YaGhqMlRibTFNbGpPSVAz?=
 =?utf-8?B?aFU4Rmo5c3QzR2g1S1hUckpJc3hWUkxKUUFmK1h4dytVSXBrWVR5bC82M0pL?=
 =?utf-8?B?NmFvMmFUVjR2dTRTc2N1VGIybzFaSm9ydHVkQ3ErYkJ2WDh1VGZCNk81cGdu?=
 =?utf-8?B?NVRFOGo0bHY5Y0x1aitBRUUzVGdBQjhDbXlFL0hWYStldzNoSExabktKYk9l?=
 =?utf-8?B?N3ZNd1R1cTJRZ2d3dGt5KzFRRXZXNWdhNVVHVUZMMnpiSnFOQUV5Qmp3VlEr?=
 =?utf-8?B?MThnWmx6Vk9DUm1jWEFDMDZRTmlvc0NuQmk1QlJsdGkvbG1Za2ZUWXdKYmtm?=
 =?utf-8?B?NE1ja2NvNHVUU2V0Qm9LSFlLblVkcTJCdm5MdFhLZEp4UnJkUjVrZWk0YUtr?=
 =?utf-8?B?SHdoVlR0QkM5eFFrUTk4NnFMRkljSzgySDRVb1JLQzhYZDNpVCtFY2tiY0xJ?=
 =?utf-8?B?TEwwTGRoUkFPNHlDR0dNdEhHZ1lGa1lCZFljeGFLZHo3VHYwZStIdEVPSEVW?=
 =?utf-8?B?UUlETTAxdmxnZ05SWFhJcDRoTi9aaW5BVVk5b0lhajdHclNUYmFTREYyRmwv?=
 =?utf-8?B?c3RjSExZN2xwTjZxV2I1cWVFYmJsaXVBZTc0N0JsK3BhYXg1ZVpyT2R1eTdw?=
 =?utf-8?B?cWdJY3Fia2g0bzJ6YUYwMmprSU5leGdPcWpXTVRxV2dBM2hFYTJoZlljK2Fu?=
 =?utf-8?B?OXVtRndzbFM4ajRMVjFIbXFIMEVtNVZ4UlE0WUQ5aDFyYTM2RmxxRUk0VVVv?=
 =?utf-8?B?cmVwK0dFcXE5dFlYY3VBcDJQVUJ5V1NvREhyMkY1Sm5Mc3duWXZQVzBOcnJ6?=
 =?utf-8?B?Y2dMV1d0RmxXS1hhYVBpQUNxQWpxUXNNUmYwVjFOdExkc3F1MElSSjE1aE4w?=
 =?utf-8?B?eUM4UTltNzVBUXNiU0gzVEFFKy84RlFqYU9YTlA2NVduS2QzMkhyODJPTG9m?=
 =?utf-8?B?dys0TExxWDNIZkN3cTJ0TnFpSTkyNUM3dmkxdGZTRUs2SlR2NWVueWJ1NEpZ?=
 =?utf-8?B?cFNXOXFWYm1VL3FjRSs4a3RZOWpZWURWRW1BZmtjdzFlc3FPeVoxWm9EMHJv?=
 =?utf-8?B?QWxlU01VT285eWZIS1ZpUlVkWEhoTVdEN3A4WVZFTUUrNGU2V2ozaGx5Z1hw?=
 =?utf-8?B?d1dYdm5YRlZYVUR5RjRWbkFCZ2JrTTMzUVZyRERNeTFjS0lwM2p2T2U2anIy?=
 =?utf-8?B?VXYyeEF1NXV1Zlc0TFFjeFh5T1RTNXJldW1qNEIyMUNhbG02bUFLR28zWWg0?=
 =?utf-8?B?UUxMaXFwUlVyNHNvbDIvWDJYYjZxZTg2NHZPT1l1ZnJhRlBWbVA0elFMZU9M?=
 =?utf-8?B?aFhHMDJsL0FyNnROWlREODBSR25OckFRZFVMY2ZFNUo4VXA4cmZ0OEZaRlFP?=
 =?utf-8?B?T1BpbE5MR1dnQlF2R1pCMUxXMUY1YnoyVWhsVkllRlNMV3JPQ3BDQWIyaGN1?=
 =?utf-8?Q?mhihirA3hQOJ5245EpmtxVqEZZurRfnSj0mcg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzFWMHEvMG1hSnNYelQzTmRoaituc2g2Y3RRMHhtZC9LdUk1MlExY2lsOUx6?=
 =?utf-8?B?OE5hQUlRbW80YUZ4cG5VSHNBWDNUNGxRRGVsa3ZMUG1pUExSZUdoNjRHSjU4?=
 =?utf-8?B?bERvQ3QybFRiOW9YS3J0aFFVWUxpL3ZwZU0rN1VnQmFYM3NIQUtMbmJ6cWxq?=
 =?utf-8?B?Skc3aVNXR29lT2xEV0YvNys4ZXZQOEJsckFVM3E1YWRSUkhaTlNGb3RIL2JZ?=
 =?utf-8?B?b1VxVlAyUzUvT3VOanFEU2thN3QxMVh6RHdFWmJqVXo4cDViejc5TEJ2YW4z?=
 =?utf-8?B?OTJ3ckdzd1dHTkVzWWN5bldmTEhJa29CbUpBQkJpM004UGtPZFFiOXRSMTMx?=
 =?utf-8?B?VS8xTXBDU3dJNndkdUJmYkJ3N084Q3VEbWswRS82d0xwOWo5WVFOdnpObmpQ?=
 =?utf-8?B?Z1NhMlZ4Z1BCMEc1WHhtc2dBVU9zTDUvckdpMDdySDhFaGhSWlliejZsdldW?=
 =?utf-8?B?Y04wOHZ0aXJ3SHd4Y2M1MWRGY3Fid1BWN1NpeHpvd3ZLdmtHQms3a0hEYkFu?=
 =?utf-8?B?dFdYc0hJNnNHcWVyWXkxei9TV0NDOEIxZFN2bW5CR0dkNGZvaVJqUGVmdzdj?=
 =?utf-8?B?ODJPVlY2ZllnbHhCeGVoNC9teDZjM1pFQWpSTUcwQk9LRXNOTk5Lek55MUNH?=
 =?utf-8?B?VVNtdUk3N0VvN1doaTJjSEVKV1pDamZ4T1FxR3ZTS1I4YS90d0RaT2o1eFhl?=
 =?utf-8?B?a05jWEEyUnAwS3h4WDFWWm5VVWR6VTN4Mi9haFpndDQwRWpnRTJha2d6SDlZ?=
 =?utf-8?B?RlZOOHFldDRtbHRHU044dW14ZktOdUJCYmk3d1FnQnRkcEVQYzFrTGxCWDVn?=
 =?utf-8?B?amFMeU00eER4VmlBdjlONGVRT1BkOHU2RXl4UC8wSEd6YXhPUG54R2ZrYzlZ?=
 =?utf-8?B?azVuS0lWWm9ZUFlLTzVDS2YxVXpCWTY1WVlkSU8xcWxSWG5JdmlNQi9lVitK?=
 =?utf-8?B?MHRVc0tUZk5LeUp3c05hOUdrVnlzck1WbVlmN3ROTGQrU2puZkloWjN3TDZr?=
 =?utf-8?B?NGxCRFY2alpCdjJxc3NoMmxVSnUrekFZNGJ2S1JUeFB2Rzd3M3dxVUVsUkFO?=
 =?utf-8?B?WWdHSDFmVW9FMmd5ZExRK21SK29MSFc5L01WWThaVDBOaWtPZHFyTnE3MFZL?=
 =?utf-8?B?YUltT1JWdzlRTVJOT0R2aU8wSmd5VXVFd1NBV3k1V3E4UVlNb29rNCs1ZERz?=
 =?utf-8?B?Q2pwYXFCV09QVkQzclRBREVEejVZcWlSTTNSQjJ0R1BPL3JUdksxaWhHL3NN?=
 =?utf-8?B?SWsyM3dUWHpscHU2N3BhUEtJc0EyRU1UVmxZNzVTeGdoU1BvWExQWWIrMytK?=
 =?utf-8?B?MjZzczkxZW5WNlJ1dVZTbFVtbnIvcGY2WTJMUVVmRWtCZjFmdkNrdEltVWg2?=
 =?utf-8?B?RXJrQ0ZXWEVqZ0lhN2ZuV1dPbE8rQlBtbERFZlAxQmpXcHNhVkQrZ2I4dU5L?=
 =?utf-8?B?RnVIWTR2VDhvN2o4bjFGM0NIa0RzY2VsRDMrRWpYSVJSaEFuYmd2bVpmWHpR?=
 =?utf-8?B?bzk0TFpkc0g5RHZZdmxML0R4ZmRoRG1hTStIZlVGRDIvTmh0ZHkrNWxCT1Nk?=
 =?utf-8?B?VGRDMzJ5aTZjWjNOOXFZNkVrZTZwb2NVVjZwYU1kdXRsQ3YwbjNWNEFOQnl1?=
 =?utf-8?B?ZnpyVTZUUmdoUzU5RXBMZzRCTiszUWpudk1nQ3ErM3EzTTlNTkpzeWsycngz?=
 =?utf-8?B?TWZ3SjYra3M5RWJLSWh0K2lxSXZpNVlYTDNiN1c4ZEtxMk03RGdGNHIySUJu?=
 =?utf-8?B?N3g4aFdWZFpmVkJWWHhQVmFMUUU5N0RlWEgyNUR3L1ZTUkIrMmIvMUVNUHlm?=
 =?utf-8?B?YStpeDdlSDYxTmVaTGlzdWhnWHNudVpFb05TZWtQV2duOElRTktLT051K3hB?=
 =?utf-8?B?UGU3NGVTMVhHdXMwKzZFN1FYNkRNL3VvT3dWR3l5eGxHNHVuQm1zdW5qYkFx?=
 =?utf-8?B?Y2cya1dNcE1Md1VBMUpZMmQzVjNhNTdhOVBlWk0vUG1xSVZtTlYycHEyVHRu?=
 =?utf-8?B?cVlPRC9ZejU3UER6Wk5LbVFPcEJEU0k3dFo1Smc1WVdFa3B4c0FHa1R1WHdv?=
 =?utf-8?B?L0UxQkhvb2RKYXoxeU9TaWRObEtJTU1NZFVXSi82VVllZmdNMFEwTS8wRFYw?=
 =?utf-8?B?MGJRNFhHSThReldlTkVWbDNYNjNwZU5MeDcyL1gwTzFMS3hEem5SZElTT2xK?=
 =?utf-8?Q?Qz7EbI0o1qDTzWM5q4bs8/UMgU3ihsqbxqhW5N5R8noi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7751460888087C499798201BE73E0198@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aaa84c-03cd-4bd4-e169-08dcf3abaef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 21:43:07.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frJAkgXrHCK+zmRQnHc3edACrFGEHS4/GCBpGgXQ63sgGXvW4VgpKn8SId8+Nbt0AmykgZw7QRJHTKrLNsZuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

T24gMTAvMjMvMjQgMTM6MjgsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gQ29tbWl0IGE2MDg4
ODQ1YzJiZiAoImJsb2NrOiBreWJlcjogbWFrZSBreWJlciBtb3JlIGZyaWVuZGx5IHdpdGggbWVy
Z2luZyIpDQo+IHJlbW92ZWQgdGhlIG9ubHkgYmxrX21xX2ZsdXNoX2J1c3lfY3R4cygpIGNhbGwg
ZnJvbSBvdXRzaWRlIHRoZSBibG9jayBsYXllcg0KPiBjb3JlLiBIZW5jZSB1bmV4cG9ydCBibGtf
bXFfZmx1c2hfYnVzeV9jdHhzKCkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2No
ZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiAtLS0NCj4gICBibG9jay9ibGstbXEuYyB8IDEgLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ibG9j
ay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jDQo+IGluZGV4IDc0ODJlNjgyZGVjYS4uOWFiZTZi
OWRkMmVhIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPiArKysgYi9ibG9jay9ibGst
bXEuYw0KPiBAQCAtMTcxNiw3ICsxNzE2LDYgQEAgdm9pZCBibGtfbXFfZmx1c2hfYnVzeV9jdHhz
KHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0KPiAg
IA0KPiAgIAlzYml0bWFwX2Zvcl9lYWNoX3NldCgmaGN0eC0+Y3R4X21hcCwgZmx1c2hfYnVzeV9j
dHgsICZkYXRhKTsNCj4gICB9DQo+IC1FWFBPUlRfU1lNQk9MX0dQTChibGtfbXFfZmx1c2hfYnVz
eV9jdHhzKTsNCj4gICANCj4gICBzdHJ1Y3QgZGlzcGF0Y2hfcnFfZGF0YSB7DQo+ICAgCXN0cnVj
dCBibGtfbXFfaHdfY3R4ICpoY3R4Ow0KPg0KDQpJbmRlZWQgWzFdLCBsb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
ClsxXQ0KDQpibG9jay9ibGstbXEtc2NoZWQuYzrCoMKgIGJsa19tcV9mbHVzaF9idXN5X2N0eHMo
aGN0eCwgJnJxX2xpc3QpOw0KYmxvY2svYmxrLW1xLmM6dm9pZCBibGtfbXFfZmx1c2hfYnVzeV9j
dHhzKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LCANCnN0cnVjdCBsaXN0X2hlYWQgKmxpc3Qp
DQpibG9jay9ibGstbXEuYzpFWFBPUlRfU1lNQk9MX0dQTChibGtfbXFfZmx1c2hfYnVzeV9jdHhz
KTsNCmJsb2NrL2Jsay1tcS5oOnZvaWQgYmxrX21xX2ZsdXNoX2J1c3lfY3R4cyhzdHJ1Y3QgYmxr
X21xX2h3X2N0eCAqaGN0eCwgDQpzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KTsNCg0K
