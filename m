Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BE1F4164
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330551; cv=fail; b=ld4uLWd61rsg84KPVM4YMIMQfdvxA83IgroFeRdt2kzQX+Qqz3YEsIET4RyUuXeZXf7/D7w4vKLz+8BZpNrTnzO6nHEzVVKN5ny985+ueua7QbBWmzwWfF/0rmkhckUXINCEckm3daOUJk4Tp/Nt7RHG7lt5HbhnUTvwOgEVnyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330551; c=relaxed/simple;
	bh=i7jadkIzXaZU2atMsiPuyrvg5prSVEd6glwD96R99Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h+UCe6KYYCrb0PKj16JIOVh1f7KkJb6HXpnGe9yW/9I4jSzgrBQpLYPWvRumCKAtKZC/32n96CA5CLb+bqWmM8OuEOp3JAz+r+uGXWjV+8vTP6YCPUZDUkMrUYIIdTvdDebls7RikQZFP6oyxH67G6MLNOsdRtcMSh/Cvg6fRCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJvc6ui4; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJvc6ui4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8RbtqUXhVG/8zwZZ2i2NVu8wBIhurrmTQ8hPOm7EtWhBVcYaX6Dls8kD6xmwnUuxGnAQm/w3jG57EsHOt0h5QXfUNjn4uwoCvRFbc7py7zz5ejOIwkDO2oFMtKlSlBwDSQGIxNV44fD5rWJvLFG8AplTbr/iHvReLeT3SQVTtN39SGG/7xSp2EqBixAW5gUYUrcCXyeImPR1ejkrrLfCVW+YpqHnVZYUGL3YkQA/mKIKMAhooNryTi2ReV+RkZ+D51j2XUAvN9gzcd2hXY0fdR5T0ANPA63XzJsntdvtMrlihdtLDVt6j4B7h7+rbV9QvoMX78fK+r0BV0dceMzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7jadkIzXaZU2atMsiPuyrvg5prSVEd6glwD96R99Y8=;
 b=RyzNI+6ygzHwyeXSv9ZGw/0a9+STzHZ6ZIjX6k7vyYiSyInDKGvd8jVqVye19PrvfZzmLaV8nptb9Qh2tF46bBy6t3hvnqqvsTWeiIht3HCbFalpxjHbcg6AdkqQcAThnZola8YoNBC1iFMHl7m8398FMh7DAKDHA8SdIH7fRHsWbNyg7rVhOVOAGSh547YX0MdRAmeR5cljb2HWPOoSMoFYkj9DUV05NmhfEMp/3jFL1NikIKUyZr4r/RZCByesiM0hFSnYvpFhdPBLBYCRWk86UZGAzf5W7acAYe36ABka0DBtOvOXenKLh3TkUtUnA9mDGS0D9x54o/S/QGB+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7jadkIzXaZU2atMsiPuyrvg5prSVEd6glwD96R99Y8=;
 b=rJvc6ui4YS1hV49TlBvzY8Z1YvDLTQfDsXLVYGbNOl4t6QDFFRXM3ry6A74JFz82FPgyFq3KtD+vFgdKH5pW3XDrzqHhlzdB++dmDnxti5AGRPh8wIOHuxqaCwzjsCHekVA3/sPbHuAFvDRkXWDyB77iYRXAnyAAau13Grw5cC9x5I8z4VofxRKDz2VwlirSyvvKnnFWbTjCFhRjrKBzUMGRbQt+8erL5Mg62/R27B0ulreF6VTVsX99hxhP/etcc72m1lEPkatR69Zy22rESYvDV2qPJAUYcZcqlxO/nyLiErTMbGlQfZCncHGzbinxPYcuCNvRQs12jPa3FqHTog==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:42:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:42:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <wagi@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Topic: [PATCH blktests 3/3] nvme/061: add test teardown and setup
 fabrics target during I/O
Thread-Index: AQHbl/IbnJIRkxxSrECV1gnedpzT5bN5XJ8A
Date: Tue, 18 Mar 2025 20:42:26 +0000
Message-ID: <f90a88ac-bdd2-41ec-936c-2e2bcec01037@nvidia.com>
References: <20250318-test-target-v1-0-01e01142cf2b@kernel.org>
 <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
In-Reply-To: <20250318-test-target-v1-3-01e01142cf2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7453:EE_
x-ms-office365-filtering-correlation-id: de81fa88-c1e0-43d7-73f7-08dd665d64c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWJnUnpYeFFsamlwV0VwakplVjVPakNsb2M3aVVadHZsZ3lod2NZY3dici9t?=
 =?utf-8?B?UEpVcUk2SXRvcm5IRnFjdVMyY1IyRHRFd3JrMEg2L2hSOUN6RkthLzRkVUZQ?=
 =?utf-8?B?TXBNN3IvZEtGNTFEbDRxZ2VyWlpWUXFTekdENE9TL1E2MDlCVThFTTJKSkZw?=
 =?utf-8?B?eEl5L0lvOFVPcmpoMHZIaHV6VnVnZFdwUUNaakZXd0x5dGk1dEhVU1hxcEhL?=
 =?utf-8?B?bnpyc0dWZnVHTE1IeXJIS3RUZENWTS9lTm5PYVRuMzZ5YTlEV0NtcXVCb2xE?=
 =?utf-8?B?eks1M2RSd2YrR29lbTlVUU41R3FzWkdNWWQ2UmRPd0FSZC9zQnZPaHFDQ2c3?=
 =?utf-8?B?SkN0VE1SdXBMOXJBNmMyLzV5Z2xCQUR1MHBQNW5ob2ovMDRxbExBV1hDa2lw?=
 =?utf-8?B?dUw1eEVOTGhDalZaMFkzaFdQcFo5R2x2aGpnUGhTWmhDN2JLMWx4c3RGbHpN?=
 =?utf-8?B?OVJ1V0xHS3JQK296TnUydTUrMVgzM3h2MEFkdTdIZTE0dURXL1FhbXJsT3Qy?=
 =?utf-8?B?dG5oODRJZHJIUGpURTZKZkNzY0UzS3VuTm4zQnE0ZGFJeUNhUmkwTGpRd1JY?=
 =?utf-8?B?S01UM0RTMm9ZYzdmN2hueUJpdjBBSW9HOE15SHc3V3l5Yk5oK1ZodnMzYm5V?=
 =?utf-8?B?TVFpZWs5MmZPR2c2dk8wL2J0NEVBNzBGcjltek02UTdPVXZzb1Jvd2xVUlZL?=
 =?utf-8?B?V0FYaUFTNEVORDJRY3Vobm5GOGJQcU45a2tRb2lYcTQwQnVqWWpmOFZzd00w?=
 =?utf-8?B?ODMyaVBqRS9zU09JeE9ldnVXcTZTd3F5WGtzU28zQ2JsZU45WnlxUkRwQ1I0?=
 =?utf-8?B?MTN0V2xDaGRwdElkclRiVnVBTzhGWTlTVmFvVFlQcFJwb1hPUHdGYy9WWXJ2?=
 =?utf-8?B?cStRbGs0VWkvd0lvNGJJZFJoK1Y4bjltRjZaZElXZStxU3lRblhLM3NrK2RE?=
 =?utf-8?B?bytSTHdHNkZQYUFnODNaTFAzTXZEK1lJbkdQOU1rT0l1Rk9yR1d6aURJUmla?=
 =?utf-8?B?MXdySVRpMmFQYnNYMFBrL0hsbnhJbytKRVFnLzVmQVJwaWZBaTRFMjd3czJ4?=
 =?utf-8?B?WXcyS0dtL2RWd1R5RTBvMEhReU1YaFRKcFI2YnlOWlB5aGdzWmhzbUgyM25Z?=
 =?utf-8?B?M2hVMWQ2RTZGNFU0SnpHZWZ5ZVp4Q3F2OTdDZ0RaK0RTYW9YZm1WQy9IRzln?=
 =?utf-8?B?ZHE1SWxQeUVYSVpaT1BRb2s5UmFwY2tmMWNJcFR3MDB3cFlndlI2SE1GVVo2?=
 =?utf-8?B?R2s2SVVDeWppbGNCMkFFbXV3RSsrM05uQjZ1aWZFMWRNTGt0Sjl4ckhRZmNz?=
 =?utf-8?B?a1lkOEhIRERyVjVYNDZIMDlaaDNoSVJuUnNpRWhaM2I4VElnckxydDgrR0VV?=
 =?utf-8?B?T09LdEsySGR6b1hkRHgwV0laa0xUNXFReWZiNnZ6YThRYzFnVWlDeXZaZ05l?=
 =?utf-8?B?ZGQ5ZFJCTG9WSHlBbHNKVCt0UFQySXROK1RSbkJrL3gzby9ZOTlsOWpTbkJZ?=
 =?utf-8?B?RW5mUTVsVWtYRU9oYjYwSXNJWUJNZktBUnRSa0Z4RGFVc1FzSWh6UHNVS3ZG?=
 =?utf-8?B?SHBMM2VJc01UdVVRY3FCMzRVVjQ0QzFlMmY2YUxScXUweTdZQmM4dHdrVnRy?=
 =?utf-8?B?YlcwV3A2QlZtZlI4VzNMUnd0RzU3UVd0dGJvTXJ4dHI2TTdYeEFPM21HcFBx?=
 =?utf-8?B?REZNbS94OUdOYS9FTlNpVVAzYnI0VUxzbThsOTdOTmN0ZGN2K0pCTVM4Nmxx?=
 =?utf-8?B?eS94U1VZanV6dElUeGxYblUzak1uSC9sTWhSaUh0bm5Na29jQ04zTkRwSTlw?=
 =?utf-8?B?NjZiY0toM3dWRkVSZzIyVFJ0QllIK0pRdktxazlxWWtib1hMdWwvdVlBVlJ0?=
 =?utf-8?B?Y1p4dTZaaXdwWXVHemlNc2xWbnVEVEZ5N0tXN0FnSkdoWTBSVmdEV25yVnNJ?=
 =?utf-8?Q?uZzoH8CzMg4qk8XsUxBQEHGB0jU400wP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZS9tUTZJM3JFQUhHdXg4eWZQUWJjM2s5bjMvUjJ1Tm42eWZ0ZnpUbTViWUNY?=
 =?utf-8?B?c1lPK0wrRHJUVGsvbVQ0UHhnb04rMk5kM0U5SUZyWHp0VExWKzVaQnFMVVh0?=
 =?utf-8?B?b3NGaCtzcVV2SzkyaEMrODIvVzg0RHdRSit5NTIvZ2gyNlA1cWU3ZXN0ZmlG?=
 =?utf-8?B?bURzdlNETGZYdnczbmRUZGFYU3FubGlhVWJRNkdyQmNBU1hnZEdWc3YxWjNO?=
 =?utf-8?B?eXhZSE90QUdWWUxueTNqalBzeDQwNnYrbS9oRkh4L1NmS1ZIQ3RKU1ByS3dH?=
 =?utf-8?B?U1pxV3dIUTZOMXR5a08rNUZ2d0piTVhTb1ByMmt4MzI1cUxBSk1vcFk2amZx?=
 =?utf-8?B?OTdNVEEzVXhqY2VLdXpEQWNLeWlDMTkvN2s0UjNMSnZQWUtFNEJ2UEZLZDNq?=
 =?utf-8?B?ZStVcWNURU1xVnk2T1MzNmdnY2dzbGw1M2RuVFphOTNOMFM3U25xc0pxVmNH?=
 =?utf-8?B?K2Q2bFBLMzluRUlLaUpsRzFYa0hHd0gvNEcvQy95Sng2UWF6N2lDMkpCUjRi?=
 =?utf-8?B?T1RCRVJlYmw3MUsvanRWL2taYUlwazMzaWc1aWV4Vi9pc0REcXJCbFJ6cEk2?=
 =?utf-8?B?Tnk2UmRsVjIrZ1owbjVWY2xVektGMkR4aDY4UVhoYTRYUWlGWHNwc1kyQ2lo?=
 =?utf-8?B?YWhXdGMrVlVxY2lOMGRZRTc4UFhzNHY4ZEd5QytDQlo5S29saGMrcmNuOXdV?=
 =?utf-8?B?eDJmVFFZelFWL3pja09SWFI4UndsV0xxbmExNjB2eUFtWUdwcTdiUTBLaEc4?=
 =?utf-8?B?K1VqWWFPNmN2T3UrRmoyUzFoUVBiaVpiT0t1UXdnRkRVaUliVndVZms2c2xL?=
 =?utf-8?B?c2l0U1FDa0tEZzllcG1PUXRsTW9DdFZ2ejZKdU52V3hJdjRMOW5LbFZTTzdM?=
 =?utf-8?B?cS9SL1dQMCtSZlRYNXNydk5oSEZWbDVQa21NWTB2NmtDYjlEMm9hNzJNSmQ1?=
 =?utf-8?B?V09OVmZqbDJacWQ0ZjBWOENQRzN3eGVmbGxFS1JoUkhUN29XTFBZTFFidzF4?=
 =?utf-8?B?R040aUxpSUU0S0NjSXlSeEdmZWxSRmcxT2JsaS9UZ3c2ODQzK3Y3dVlQZUVw?=
 =?utf-8?B?cmxyYzJnQ2lFRnE2ak54cGpsSTNHb2d3a1RhNXhKR0NVeHRKZmpycUg2ZzI5?=
 =?utf-8?B?YWdlUHl1SURaeWlPcDFyMmFWbCtlNHhGdTI3V2xGV0VKbmRSbnlCVUxRYlBa?=
 =?utf-8?B?TkJ1V0FqVVBWV05oYURRN0NnTW4yVDUzM1k1WUJVWU5LaEhRUlo5ZnZJV1Rp?=
 =?utf-8?B?SXpSRmZ6SWtlZm9vUjlYd1dzcWpBVk5QRUNSTG1aMitJaEdOTy9OUzdKWnY0?=
 =?utf-8?B?QnRLajM2bEZtVlBzRnphS2pNdUJPaXk4L2VCaENRNFo3K2dzc3d5eDcxSjRo?=
 =?utf-8?B?YzFPd0RGYWF3UXdCaStaUlp6cjNrTkk4MEdPeFlUUTRWeXp1d2poSEdHcDV1?=
 =?utf-8?B?UTRoUTIycU1hV1A0NVp1UVkrcS8veEFHQzVSZU5JY2wvaXoreEUxUkZiYytm?=
 =?utf-8?B?SXc3czloV0JSVVVaeHI4V3ZscmtPKzhUNXRNWmFsQjR1Z1NYWXFsVkc0UHg3?=
 =?utf-8?B?WVFkMFhlMk5Xend1MW1zQ2gySjI4RUp2YUZhOUxXUzF1elM1WGZUdzNxOXF2?=
 =?utf-8?B?NTNJTVhhN3BMQkpUZVR3SmFMMEJIc1dYVTlsNUV6TnVPcjBKS3RNaEliS2NE?=
 =?utf-8?B?Sm9iUlRjYXNHbWZSbU5jTWEvRDE1L0ZmbzdsMUorSkszRG13alhvRFNOSlJI?=
 =?utf-8?B?UE45S3Y3WHd4MC9Vb0syc2tlbzRDZkJ0Mk5DZ0tESVNQbzh3cUwzd1N6b3A5?=
 =?utf-8?B?b0FUdmlIZHVmdE45c2hoM1Z0OStjQmdOK2ZsUjJselNDOGcrRm5IUDlsb0Zz?=
 =?utf-8?B?WWNienZ6d1ZzZmVvQTRNSmFEQ09qQlYwU3ZXT2NvVkh4UGYwdnN0WXp6UXJS?=
 =?utf-8?B?STZRcmhuYXM4VGxJVWJ1b2RNWmFDMlNLaG1tSGlKeWN6WHpsUWwxWDIxZFhV?=
 =?utf-8?B?SHltTXU5MGlvZEE2QzJYeU53eTNsT1NqNGNucXc0RUlmS2dDbUo1ZC9wS0pp?=
 =?utf-8?B?aEZHMmtxZFQ2dXFEc1VPblAxLzZxY3JSOCtHVTQ0NWZmeGR4TGRHZTM1Nks0?=
 =?utf-8?B?bWFCTXJYZ2NNemE3UkFUWHpuRTIvZlJmSDQvdy93eGhkRXR1MjhIOWtrZk9z?=
 =?utf-8?Q?XJokrzzTz6GcsFrg7mlTNuXYT9jzers/WYiGsiHSvFuj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <378AE30FBC75F74AB76886F266AA986D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de81fa88-c1e0-43d7-73f7-08dd665d64c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:42:26.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIDZPI+0+HtSz+ktUl3awPUYYm1LhIfIXu4gnTaewJlyQfP5QYVE46TdpbssWH/ZaWtaM40JhmpFooNyVlK+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453

T24gMy8xOC8yNSAwMzozOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gQWRkIGEgbmV3IHRlc3Qg
Y2FzZSB3aGljaCBmb3JjZWZ1bGx5IHJlbW92ZXMgdGhlIHRhcmdldCBhbmQgc2V0dXAgaXQNCj4g
YWdhaW4uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXI8d2FnaUBrZXJuZWwub3Jn
Pg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
