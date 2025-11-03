Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46261DFE26
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201837; cv=fail; b=Q8uKGgMCzJAzJpekxrdwRw8JzQhhJmQbA1+BfJInGaEFGrE4euTugZBCoYiBjtTm/PnmNG/ttijZvUxhgsg0kPy7enE1zUeEECS7737e4kWDVW2KbuPynIxs8MYSczW3h0oYFDT+3jfQyga9a6HoP8DODbh4FtxyD4S9/3VrkTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201837; c=relaxed/simple;
	bh=97lEehv8ooT9WYgcCWzdGy1S1gVG0mmP4FmQ0c5YB8U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qu+i6IgZGfHvgJ39J2jR6cNjVoekVeD7dqHPGFwSLnZ9kxd3v5Ok9QU71VGrFZs3BGH5j9lkukHzKL93JWINHTrucEKW25Sc6p8KnQ2WflW/KGpJXNxqJG8fzZ2v0u5cUvu6qepcylCeVg3aj9vmE3Js8/sN9sp1lav59ccXVKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gy0y7PeN; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gy0y7PeN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTwBr4KY9JW5J086ktcTPaiJVBoniGRLDi/tEYotTV1LM82FQr+Al1iNMU92+KrDlcDYaUKRmf/sN4/men63g7SBfBh/dAetYQzaPJUQLhPbLJHzTq8lG58ucalerEvRRfU0Z3z2VYXSIyv7RodZaWw2qBFRWP7MK8+M+ZOKRzji5eepPoWvDCRM6iY9ekAmNDCMlptxPBTjGhjSzNW5IJ0JeDBrGOjJ+RMquWEg4rqPxs5rYjes/LyrnAN+MZdStDyU5hIri0CP6bzh8SztFti9nK0pgSWVSRnW9eUvKaZRgW81Qqk3cwtTC65Qn1MfxhjxACK9Tzc5COQjS4CBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97lEehv8ooT9WYgcCWzdGy1S1gVG0mmP4FmQ0c5YB8U=;
 b=ZKba0HmLzCv2P6qif1tMofltrOaUqONjqLcoSz5kZ4DnFmaaNN9igOgijOTNpY0YKjhQELNlwSpPVAjrDuo1LXCBixw8D0W+HOYKBSDdMtFer+nF6E3MWIMBSGwoLUttCjn9xClmJ6oR+xPM5NHDQDHEVJYxMxJ/3bWTeA6ZptVUgOBz4sOjEWMBQYA/n1UuL89AAwUEHM4RW6hDFotTFeGPM6swXrV0koMOmSSBDTvhUJgiRMkYNxdFkmed9XemNMMAsJJS565IiWqvvDF1sGxsVDgdwTfNd0ClanWwnd8tJIlU+LO5oNdU7CAilX/YzZ9CCuBkw7VDydfmeNI2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97lEehv8ooT9WYgcCWzdGy1S1gVG0mmP4FmQ0c5YB8U=;
 b=gy0y7PeNpoCn1WpGpTl8ShYN2fYqWTNq1MO/WGvgo1rEmHrJWw6x/7AKe7LRD62GbBmSbfW9WEVwuSsx34D7evfxy5ECqKK+erKBAVx1iRW8igeUSTle8kw2qf4lvb1lRG5GkiTI1GSiOtHds1QXUrBo3Ufq7ml8KyhFtAX6dbgJL2sKd1zOjB4VGacu8jEu3DyIiKON0pJ9MvgRlxCIoZmNC7alRMWXYB4dkND7Vyp8CaQb4cHnkouIGKU7732J5CSwGpXfBVBYpIlooaoAZJkU1A/0lAzYXmEZiWPl45AQxJR2VTu5lgIV6HVIHMR4Le2fQhmVS/BOFzT9rFlV9A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 20:30:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 20:30:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Yu Kuai
	<yukuai1@huaweicloud.com>
Subject: Re: [PATCH blktests v2 0/5] throtl: support test with scsi_debug
Thread-Topic: [PATCH blktests v2 0/5] throtl: support test with scsi_debug
Thread-Index: AQHcTI1nyEvkXtMzkEKk3EfLEEz/rrThaEqA
Date: Mon, 3 Nov 2025 20:30:31 +0000
Message-ID: <efbcf149-d7ba-4577-9a90-7db23df99187@nvidia.com>
References: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20251103064454.724084-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY3PR12MB9580:EE_
x-ms-office365-filtering-correlation-id: 35e82190-1fec-4d04-d446-08de1b17d5e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1JnaVZEMW1kSTd6K1l4YU5XRVAzbjhWZ1JuY0JjMEZheTdkdXd5V3lmTkpU?=
 =?utf-8?B?YnRJMjF0QTQ4a1cvTThKakRXcGdIR3l6c251bzRubDJPemF2MEhuQUxaVUNR?=
 =?utf-8?B?UEtab3VSZHp6Mm41MXAxNkwzMzNwUGM4UGVWeU5oN0FyWG1QZUtGbjBWbTRu?=
 =?utf-8?B?eERTVDhndk5qUFRjc1p1U1dGVEwrc2RQK01iUTJlbno3M2RtbncyOUUyUE56?=
 =?utf-8?B?V3VjUTFvQkRlakpaSExvaWMxdEpBUUI3dUluVmp0Mzk3Wm82dWRrYjMrQkRW?=
 =?utf-8?B?UXBSNTRIbjYweVozeGhUWVlJOEpVdmpPVUlPb2J5T0x4UmpGbjN3NW9kd3ZQ?=
 =?utf-8?B?VzVWRjhEcnNPQ09RbDBpTFViTEQ3Si85NHVTSmxKcWlSTnVVbWtjUHBhQ3Ri?=
 =?utf-8?B?cHphKzRWa1RGUE9kLzZBR0dKYTYwVkprd2pOTUdhb2FhVFpGYi9yRjZqOTZj?=
 =?utf-8?B?cHlESlQ3Vlc3Qyt5QzVWTUxqTXNoQTFpSHU5MmlzdkhVZlBWSXlEd1h4dEFU?=
 =?utf-8?B?OVZSeU5GYURxUVQvRmRVcG1CeDlFOGE2cnNOLy9sb1ZFZXJiZnVDSG91ajkv?=
 =?utf-8?B?VHR0TXFEbDdMYjRvRHNqQ3cxWGN1a3JIM1p5TVh2N2NoRFJHaURsYWtiTjAx?=
 =?utf-8?B?VVMrK3RteXZhVVpia0gwQkZnK1NGVEpJVzBDSFl5WklMWjU1bVdCTXJXL25l?=
 =?utf-8?B?Z0l2SFQ4TXpITEcrL29JN04vdTdNbWVtMEJ0UVNnazVNeE9sQThTSEZxckkw?=
 =?utf-8?B?ekpkRkp5bnpyb2RONkRVYytFVW50V09GQUNtZnRSdTREelNQektDTVN2NUZ5?=
 =?utf-8?B?ZUV1d3VSamFDUGNmWDJtd2E3c3V2MWNYeC9UWm4xVGROMU9qWlZ3OStkdmU5?=
 =?utf-8?B?UVZ1OGFObFlCSHJhdm9YMkJzVzBZZzNSR2M4Q0huZlZmaDY4NkREYzk0MnZ5?=
 =?utf-8?B?VTdXa3AxaGE0cFEva0Q3NUV3bmNxcXg1Z2RRMW1Ja0M1TnpNVXoxckNyeEJZ?=
 =?utf-8?B?Ky9xUDR0akVqVkZ5TmRvWVpYdklRZG5DNVR0dDd1NmF1eWd1dDE3cUtsZ09K?=
 =?utf-8?B?WEs2UDA2akhSYkNTSlE0NWtOT0pJeUJtbXhNQ2IwODFibS9Gd3dZUHNnWFV5?=
 =?utf-8?B?RkFVSkFlVHNGNkNFR2t6MlR4Ri9CR0xSek05V0g0VXNMYjhMT0lWMkFYWm1l?=
 =?utf-8?B?ZXVldnVYYXFLcS9HRWxCOWZ5TG41TmVZWjBPejQrcEluT1A4b0RHZkw3dzlI?=
 =?utf-8?B?UzRjNHlBZ2hkaElBNUJyZzJFMXExOS9oaE1yTHBBZ2FKVlBaSDhDekRFeUpG?=
 =?utf-8?B?dVJzRHdSd0xnOWpCQWN6RmFmaHRKOXVlRXJ6SllLVUZIUW9kTU11K2ZPTkxy?=
 =?utf-8?B?YUk0cHFCRkx1TUFjdXNpVHBvbWwrOHFCaDFTbGVRSDZqM0ljbEMydG5EYnZM?=
 =?utf-8?B?Y01UVkltOFJtY2JWWjgxUnhyUzBBVkFnaVJUSzNvMEM3VllGR2l6VlVPS1pw?=
 =?utf-8?B?VDhhK1FEOVlvcEZub3hmSzFxaC9uMXU2RnVKeEN3T1NyWnYvMGpGMXluNHJK?=
 =?utf-8?B?NEZBR0RmK0R5MGJORStLWUFydjhBUlJEVDZMcDZNUFZjWmJSNFp2SENGbllK?=
 =?utf-8?B?YURid0dXWXk5V1VPeTlCQzkreUg0cUN2RGs5YjZBbVNpWFBJNUk2V1g5WVVG?=
 =?utf-8?B?aWpURFV1YXp1UHJoazQ5ZDlsVHJJRDc2WFZ0UkxtL0UyN0V6bGd3RVJuUFd1?=
 =?utf-8?B?ZkJyRUg5RVlHN20zc3dqNi95dUZMcHdoVWpQa01DRmVCcm5raHBqNHN4Q2hJ?=
 =?utf-8?B?emUyQ0d4bU12YlV4N05rdU94b2NqbEN0dnJuRE1EMWlCSkJYQXc4a3ZKblN4?=
 =?utf-8?B?bXdEZGF1VitVZVl5dmNyeW9kb3VQclhmc3RiVXRTUzJQMGdJcjVZQzM5aUVq?=
 =?utf-8?B?QXFhZHFrMFJWaTVleDFlb0h0UmxvN0ZIMkRDQ0ZJbkxidmFDY2l1Q2tJYlNt?=
 =?utf-8?B?T05QdTUvWUV4UU5zWmxaSU9POWxVa0VxTUZ6KzdmSDRncVdnYmNLUm9xeW9h?=
 =?utf-8?Q?ZCuwtx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjB5Y1MxVEZPYy91ajZGdGpocm5CZWVJMkowRnpjNnBzWE1ZTWNON2Q3OFVI?=
 =?utf-8?B?YVdiSldidXRvTmVrZTB1bVdCWDM4M3RZQ3NPNjlKMGYxNi9pNXRzN0lkM3Nv?=
 =?utf-8?B?M3QzTFg4NnNSclVYZzFwa2tnZkJJVzFPZ0dnQXcvOFFTMnhobkpRbkdPOC9v?=
 =?utf-8?B?TWlSUm1Ua1hjRHdxT0k5S3hNUzR3MTRwZEIrb1NSVFJBTVZkWTQ3QXVCeWxW?=
 =?utf-8?B?NE1LdXVPajFsTWdSdTBGK1J5cnNndkI1N01SMHFac01NTmwza3lmQjFibDlS?=
 =?utf-8?B?elBJWmdDTXliWWpsR3YrUFFqeFJ2RXJBSzBGSTJxYUJqOWxqd2I0MHlLNmIv?=
 =?utf-8?B?NWtmdit4MUw3VFlNUTRYWWcxQ2FQN2FZTm8wME9lcVNSeWkra044b3gxWmJj?=
 =?utf-8?B?a0pOVVJuL21TbWM5M3ZiMlVXRVNDNVAzUFV4c21saEVDU3M4a2RtTnJ3NHZ4?=
 =?utf-8?B?MHcxbEcyd0MwSFFIaUJOaTMyajlrSXlUcnhocXJZMFhiL2VQaWxBbzhJN1NS?=
 =?utf-8?B?cW9OaHUzbXhQaHhMcHJydDNNeC9TYmJRcmQwMml3dlQ2ek15bjdSby9ubDVx?=
 =?utf-8?B?Z2p4djZxY2NZSldMb3dtWHkvaGYyb3p0em93MlFEakpnYmNvK3hnSkh5Z1Bx?=
 =?utf-8?B?VlIzUFZFZmtpdjlmOFZPYmkxQ3ZxZTJoZ1hxcDZQd0k0SzloVFYzNCtZR3BJ?=
 =?utf-8?B?ZUt4ZXhjSHRjQmkwYUJtZ2w4dUl4Y01tbHRyMmhHcGVqcGJmZTV1L1hpYXBF?=
 =?utf-8?B?VDY2K1QwZjg5R1h4eHZCcTE1ZmtHVjlRd1UraDBkN25ISVpxNEQ3VTJxSU5v?=
 =?utf-8?B?Zm5IM1htV295YUF1a3p3bHJZWTFiSzg1TDFORzNVTlk2UXJ4YnMzd0x0Z2NR?=
 =?utf-8?B?akxWOG82VWV1ekNQczJHUUxzQWlKVlg4cnZRV3NIZzJsSkRIYU9OcldpMVp6?=
 =?utf-8?B?REIrRVRTUEo2dXY4dTlsQVZLeVczYlZNSFVMd0RlMDlwaXlWTU1yTHdlcWky?=
 =?utf-8?B?cVU1dnVGUkpsN1ZYbmlBTHNpZTlWMG5oeE9Nc2pSekd6aE4vRDAxVVpEMnBX?=
 =?utf-8?B?ck5RcENhUmFUUlVpaUtmV2JqeW51UUFBeUhZRU9SY1ZuQzg5S1BaczlJbW1Z?=
 =?utf-8?B?ZVpMUVR1ODB6OU9BTkV3VjFTeXRvdmJMRzRYRFBVY2FpZTJiVHluK2Zzak9l?=
 =?utf-8?B?TGFDbjV2SXZGRWh5ekN5UWpXeVJBUGtYM2VLZzcxTzFNWnFGWlFUVUdCamtT?=
 =?utf-8?B?NEZocFNsakRjaTRYZ0l2Q2kwM2RsYlRGbXVMVHplZi9CSnVkVTAzeFN2VXNp?=
 =?utf-8?B?ME1qeXhlY0hPOUJEckVLQ1d0TVZLTzQyM3VGblZvSjRXUDBqT1BaLzFyUWxH?=
 =?utf-8?B?Ukd5YTJrRzlLb003dTFhREpqb1pKWjV6NkJuUzN5aDZpbXJZSzhXVCtOc0lV?=
 =?utf-8?B?bUhtWTYvczd6cmdoOGRLcmoyYW1DY2d0dWNzWXZFVURLaFVVUHZjb1ZnditL?=
 =?utf-8?B?RTN4SUFQN1haSjZBMHZCVTlRdGlmVVcvbyt5Q1cyc2RLdVZnejZuSTFydFR6?=
 =?utf-8?B?TEIrVmJXNUN6em1BL2I1c2U5UkhuNmlqUnhTcCtsQzVKaWRNOFV4cVdqUTlS?=
 =?utf-8?B?TXFOUDJwZldDczR2YUlXeEJtcHcwT1pGOW9aUDVZKzB6alp1L2dmOHZzVkdI?=
 =?utf-8?B?Z1RjcXdhaFA0UGZPbGxvUmxidUJXZXJsTWJ3cXM0T09CaTF4NU8waFZCNUor?=
 =?utf-8?B?Um42MmhGb0p5emt1Yy9vckgzRzNGWGVqSTRwdHNzbGpxdCs0QW9tVXBUVHVZ?=
 =?utf-8?B?YmxPbElFOVl1SFdtY0JGYjk2d1JnSWhDczhFWU5sTDNWMmFyM1NoWHJBVDJl?=
 =?utf-8?B?aEszNUpLN3RTc1JsUVZSWmNYOWg3a1VsV1lMUmhzeHMxbGJrTmFvQUR3Qm5F?=
 =?utf-8?B?TmlGRGdlWVhIRE9iRlFMZGNDREZUWmxNS3lzVkZLUzJZY1psOFpKTzFOeUVR?=
 =?utf-8?B?U1ZYbnJQMGJrUEw1c3o5ckZldEFRK1J6ZkFjbWEySEFtNU96dDJ1WXhNUlZa?=
 =?utf-8?B?cU9NREJWb0MxSFYwYkF4bnVvTGZXWTVoR0NQaWdTVStMc2VRbFRxSXRDZG95?=
 =?utf-8?B?M25HSzFSQnNPN1B2Ly85dHhHeFVYMWl3TWw4NWxhOFoxSGw3OXdQYWcvUUtu?=
 =?utf-8?Q?Nm4du0vjUyYSL99lXyPMjHIeBO/bAfL79wmfCtDvmIGE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC84CC9C7C2C1A4798D05CDF055B2C26@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e82190-1fec-4d04-d446-08de1b17d5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 20:30:31.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGwC9LVRWRX5nl8M/jkXM0V29SaRGJIDybC6N1bCXUbTp6wbslLUy2JdRy3fLs4tMl+v6pwh6Sg1LueukMw2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

T24gMTEvMi8yNSAyMjo0NCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEN1cnJlbnRs
eSwgdGhlIHRocm90bCB0ZXN0IGNhc2VzIHNldCB1cCBudWxsX2JsayBkZXZpY2VzIGFzIHRlc3QN
Cj4gdGFyZ2V0cy4gSXQgaXMgZGVzaXJlZCB0byBydW4gdGhlIHRlc3RzIHdpdGggc2NzaV9kZWJ1
ZyBkZXZpY2VzIGFsc28NCj4gdG8gZXhwYW5kIHRlc3QgY292ZXJhZ2UgYW5kIGlkZW50aWZ5IGZh
aWx1cmVzIHRoYXQgZG8gbm90IHN1cmZhY2Ugd2l0aA0KPiBudWxsX2JsayBbMV0uDQo+DQo+IFBl
ciBzdWdnZXN0aW9uIGJ5IFl1IEt1YWksIHRoaXMgc2VyaWVzIHN1cHBvcnRzIHJ1bm5pbmcgdGhl
IHRocm90bCB0ZXN0DQo+IGNhc2VzIHdpdGggc2NzaV9kZWJ1ZyBbMl0uIFRoZSBmaXJzdCB0aHJl
ZSBwYXRjaGVzIHByZXBhcmUgZm9yIHRoZQ0KPiBzY3NpX2RlYnVnIHN1cHBvcnQuIFRoZSBmb3Vy
dGggcGF0Y2ggaW50cm9kdWNlcyB0aGUgc2NzaV9kZWJ1ZyBzdXBwb3J0Lg0KPiBUaGUgZmlmdGgg
cGF0Y2ggc3VwcG9ydHMgcnVubmluZyB0ZXN0cyB3aXRoIGJvdGggbnVsbF9ibGsgYW5kIHNjc2lf
ZGVidWcNCj4gaW4gYSBzaW5nbGUgcnVuLg0KPg0KPiBDaGFuZ2VzIGZyb20gdjE6DQo+ICogQWRk
ZWQgdGhlIDJuZCBwYXRjaCB0byBmaXggdGhlIHRocm90bC8wMDIgZmFpbHVyZQ0KPiAqIDV0aCBw
YXRjaDogY2hhbmdlZCB0aGUgZGVmYXVsdCBvZiBUSFJPVExfQkxLREVWX1RZUEVTIHRvICdudWxs
YiBzZGVidWcnDQo+DQo+DQo+IFsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2Nr
LzIwMjUwOTE4MDg1MzQxLjM2ODY5MzktMS15dWt1YWkxQGh1YXdlaWNsb3VkLmNvbS8NCj4NCj4g
WzJdIGJsa3Rlc3RzIGNvbnNvbGUNCg0KDQpGb3IgdGhlIHNlcmllcywgbG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==
