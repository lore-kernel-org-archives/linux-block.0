Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD815CE
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717987749; cv=fail; b=qVkKeVrxtoXUFaRA4yQ9r/uKfe0+Ez9AUxuaodTskQJ4Wz0cnmPgSq0o9k9Tp0veAyEzgMF7TEGpwJO6fuPTFtC81+p+oxHBnJnLQpDlyoTGEYejYWw/0FCUdDSBnKck8EwCAizclnAWmCYFlAgTXT/sn3jtgvjPzzYmPWufUg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717987749; c=relaxed/simple;
	bh=/Puqo3fFOc6ONyvqpEuXlAwCAIkVh3dl3ih72bhu5Oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KSiwJtNJpNfp9PxUzvrVxYQvMl3y1p41mQoctdwUW1mGYcQ/yE6MSps0m0GXvPawLwxV77FXzFKhfgmaah4plCYhVf/rX8gU0sx4/qp1PGiekAUiCs71zvz7l13qCV27CUaXelVHUW2elwihaNDRN4xDc5TqGPj1nhxodN1J0Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBlQGXsd; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBlQGXsd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7WbCr+BlFjuUuzogcsC4fmA2soEVOfWHRbKiTDGu+CmjKlzZxQDG3MMAT8sZrMdnLI1yGwHH9a2lpAY69AmIj3/brTRIX5w/J9FkB/1+FlZ9jMV7Gxph6yJbS9jCeWcKcvxTvJmQIVCFj7Te5nvOYuQEcaNyq04YCc/ot1kVNgtyWZWP5tu75hN474Q2j3qdFW22nfi+BAACwLKVOb5pTIpveO4usfxIau3BFgmpCQe90FaVqXFLG1TawDC6jAlVA+jM9j0J0Y/QX4t89aCVwoWQkjIdJdax7mv6HMcTYYV6jgBImi3+37C/D75DHjQgZE8RtydATgbKx5oGpF7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Puqo3fFOc6ONyvqpEuXlAwCAIkVh3dl3ih72bhu5Oc=;
 b=D6s3j3jNjmikFXmy9ADQRZPpJMhzH4XLQ0aLEFM6XfBsm0SXMAwqwPPhLbBWzQSdsnH2RnE/X1/+e/njIF+B1Ok47HZXcc12ZEzlyx0BOEja1K0IZhWdj1lXjS0G2c3GBeJWq537Km0V008eRX8S+Ywkf+gflgimphbd1VKmrAh3korqOsqcEWXfINA00vp5+7yqBxzfC8SmnSuhmxbQvNK5hMqtqMCEBY17xXCAUNuL3O1Aa9XkqwCxYns5KLOtUuWC4q1aAbeSQPS7KtKEWlqyCek+8GXcHdMin4YyWwYEr/bghDWjkBHP4YKAxogIpvTnDu4Oqdj9+BhXnojXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Puqo3fFOc6ONyvqpEuXlAwCAIkVh3dl3ih72bhu5Oc=;
 b=kBlQGXsd/VJ5LdlWriPzc1eN/mUbkCKWPoBOfGXR7pncGz5ORne7ZJMDx0DEKl7Lw7lFeWx4fT2bkoQq/bUqk7ewG4LCzVOOURcbNpgqKyJsTq5SV2ri7m1FnCuq3tpQFBKZaL+Sc/ay9+LjIRDlAQoCEfTTgSI59tF6NaK9MaIficx9SKxifJKu3HaelsZz7pV/AQTkxNqFdsAaR77Y2xyrCHVaKrb27QPA1VHEw1+wpgvXoMY0Rd4dr7dPmF1InrqCRMcG2qVzV+CVBjpGfhfx/bNJOcj8SSz2xBkBzKLxaJiXrRLolwhRMHlHYnELEkPogKSyyhVp9TuU6dj9lA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 02:49:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 02:49:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] check: confirm dependent commands
Thread-Topic: [PATCH blktests] check: confirm dependent commands
Thread-Index: AQHauJdh4YLgVrLV7kimXxKToQbgH7HAUFCA
Date: Mon, 10 Jun 2024 02:49:00 +0000
Message-ID: <dcdb3039-d088-4300-8619-fe881cf1083f@nvidia.com>
References: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7765:EE_
x-ms-office365-filtering-correlation-id: 423b50ec-ad96-466d-846c-08dc88f7e208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?akhxaUg1bnYvTkY3ZjZ6N1BqUmUrQStLMnRIcTBFR2paOVFPY3A5UzJ5UFZJ?=
 =?utf-8?B?aDhNbWUzSTY0RDQ3VFYyaW5GUWFQMDNnTmQzUHprTmErczZaTEtobUYyZHdp?=
 =?utf-8?B?QVlWSWc3c3Z4cHJtVGRtOUJpYnQ1ZEdrb3ZQME95SnB5MXcvMXpKcTZDdGhV?=
 =?utf-8?B?OGN1KzhFTXRLNEt3TUlLYlAwSXN1dEQvNGVJcGZkUXRVSmZwbGVRb1FEY1Bp?=
 =?utf-8?B?KzJCekw5MTlVSEhyS0hwem9TSVk4Z3gvK0lwQmJGOFBLRVNPYkVLcjlkbjM3?=
 =?utf-8?B?TDZzeUxGTXpNSjdKUms0VUVGa0pqZ3dIYytpNG1aV0xoQXlKekdUVE5LVVFW?=
 =?utf-8?B?c29oNU5ZcmpEZ010M3UwN09wVng1Mm1DSWhDZDRMY2J3cHlkMllQVyt0bU1s?=
 =?utf-8?B?MFUzeEdid3BUeitNajdhenVEL3VSTDAwSGNGZ3p3VS9vSDBtSWhHM3FtWXpi?=
 =?utf-8?B?cGsraHF4clVNRUlTcU8zMFFyQWdSZEtWazAvc0tHeFVxQTlsTHV1V3I3U1Fx?=
 =?utf-8?B?UHdkVUJtRVNPaWJ3bG1rQXRPWFk3RkYwbEJoMHJKcithSk5INTRZOG9SeklJ?=
 =?utf-8?B?em5UcmRObzZRcnc0VXBNbEFaOURVRk56RGowNjZlUmgvelRkUGFZbnZlSFk4?=
 =?utf-8?B?UzNxV1NITHhtL3NDVzlXNFFlSGFWTVMyVU83Q004SDFNTHpsUjF2ZERSRmpr?=
 =?utf-8?B?UWRJRThXb2tEODRBWlgzVjFFbkhqUnpsazNiYVVKV241dVhjZ1lWbTJwUWE1?=
 =?utf-8?B?c20vUlJVR3pzbUsxV2d0K2NqWkJRaWFlQk5YM281STFmK0NCSTE4WTZSazF1?=
 =?utf-8?B?UW1zazkraG9VWGg1Y2RZV0RZaXhJSDRNWmZhbUtJZmcxa1RrUG15STh5VXJ3?=
 =?utf-8?B?bkpXanZNWEZVWTNtVzNTVW5HZDgvVW9HWTlZaGYxSUlBYTM5WWFNU1MybUk4?=
 =?utf-8?B?TXJFTmYxbXZlaGw1alQwUmtpL1l3YmUwdFpnaHFlcjM0eUptd29HQnc0cVVD?=
 =?utf-8?B?amVuTVlQNkVPa0t5TWhLUzZrcUM1M0F6enlPeTE0akdaMXFtZ0tGVzlaSGJN?=
 =?utf-8?B?eWlIVDYyR2s1S2NHdTM5NjRDTVVWU29NK3hnY3owUUNTZ3ZWYWZldmVKU2tt?=
 =?utf-8?B?b3B5bGxOREZlT2JvcmRYRzcwMWhWVjd3aFlKZUt4K2FYOFgwTXA5czJlQXEr?=
 =?utf-8?B?UmlybHZFVUdIcWJxNGFSejF0ZDVnaWo3QXZ2N21LcU5LdHNUYkhHbHZSY1pR?=
 =?utf-8?B?L3BNcE9ZYnJicVVxMXZJVTBuNHRKNVYzTjZCNHlFTHh0dFp6ZkRHODdPRXZa?=
 =?utf-8?B?K3VlMkdYVXRQR09oV0Rja1loWGs0TEx4NTgwaXNLVDJ2NjBSWWVmcVZraWdv?=
 =?utf-8?B?cVhBNFJjNXZmNHNsVW4yT1NwTTMvQXA4bkwvWC9ZVkJxOUsvem1ZclVIeWdR?=
 =?utf-8?B?YWlOU3oxZ3JPL0Q4bzF0ZSt4ei9sSllDUEJDVGhuNDNTMEJoQktzdnJLZ1ly?=
 =?utf-8?B?ejdaZE1MWjNCL0JvWHN3M0RNbWZQelpVNmFua0V4REMvTFlvNnAyVDEzQkg0?=
 =?utf-8?B?cVNZSS9mQTJhZmdRVDdlUG14MG9YWGRka1pOTldOR0NLVW82SGJlUlBNdFk1?=
 =?utf-8?B?RFh6ZjRMUnFGMGRmeEFuMDIxbGtsS3Z6NUZEbER3Tnp5QWpYdmFJTXdhcXBx?=
 =?utf-8?B?TnhoaC9Zck83R2N2ZnRVamo4cURPaHpLVGNPNzhsbVdxUkcvSGoyY3NkZE40?=
 =?utf-8?B?L1hpSFJXSjRwOEF0Tnl5UGVBSG9TN0Fxdk9Fb05DTHNIVEQ1YjRjclg4ZjEr?=
 =?utf-8?Q?85U8/tQ0vIylbw89Juq3WfOgrWbElGKarlbjU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1ZRYTU0VE91dTBUQXZvZHpELzkrRUNSSTdlbGErVlYrK3dONSs4RnVQalo2?=
 =?utf-8?B?ME9MT2p0RGg1U1U0MlJBRUpPZjBsZzRXaDgxMHIwU25pZW44TUFvMmswb2hr?=
 =?utf-8?B?b0IrWWc3dCtLbkRKaDIvV2RQR1lMUWtUUUtKUTFyREk2RDJhWDU2TXc3ZWlG?=
 =?utf-8?B?Z0luR2huc0dCMC9MVHdUdWtrSzlUS01YWSsxNGorbUFKdGJxc2t5Qm5JY1VI?=
 =?utf-8?B?SGVtdldXM1cwQSt1MWFnSkNmM2xQK0Y0azVmNnMyOU96Zmo5b1ZRVlhacXRr?=
 =?utf-8?B?QkhaQzMyNTBMT095VkpLeUhyN2dId1JrZVJUdE0zaTdLTlhCRzVtdW03Mm9n?=
 =?utf-8?B?SU1Dcy9nV3AwWEZRSmxJcTdXSU9tZzJxbFhsdXplb2g0bS8xL0o5cEMvcllY?=
 =?utf-8?B?cHZhVEtxdjJNNFhlN1IyNU5yZkcva0NrcmdQQjAvUVpnblJJdU5HZW85MTJO?=
 =?utf-8?B?dFRYR1I0ZGQwaTU3ckV1SHdPUjI0MW5qT29BM0VJSzNiTnNxVy81MVZJa0t6?=
 =?utf-8?B?WWd4b1R6cW5KUit3bzRSbDB3QStjVUlxcUlxa3BQamZHVkpNV1NIZGtUb0Fx?=
 =?utf-8?B?WG96eWpuVEpwdU5CWDR1MjJ3TnF0VmMvOFFEa0ovVzhmN1ZwZkFTdE1DRit0?=
 =?utf-8?B?UlloL0JNemVMUklvRVVOTzlZQW0yYURSMkNKeVFzVjZoRms4ZHlvTGw2alhE?=
 =?utf-8?B?bmp4SitrQUh4VW1HTTR0eklCNHJpZjNIS01NQ3EydTNQblo1RitTREZ6cng4?=
 =?utf-8?B?bVFXa0pxN3duRDNoT0o3ekhia0FKeEdhTTB1UmtEclNEUWNnZlRJQVZYd1Fn?=
 =?utf-8?B?cHdxVGlVc3F4WEQwd1AyNGgvd3lQTEJoREdpU0xnYWtkQlhQNWhUYTRKajQz?=
 =?utf-8?B?NzZVaVYvOGVtdFFZMyt3L1lIcWZrZUIyRkU4YnNyVkdnTm9GOFpEa3Z6K1Zq?=
 =?utf-8?B?ZWdlOXhZV0hVOW1nc2pNTStSY0lnS0EyRVg2TUJBckkzdy82TXgyTVA3clM2?=
 =?utf-8?B?MnBvSjBOeU84YlVaLzBMdzNDWHNwcSs5NHI2cC9VcEFKY0Z0d2RteWY2Z1N4?=
 =?utf-8?B?cFVBZGtwTWFnS3ZzRWRsYnhHUWExWFYxcFJNa082ejJySmtWZDArdVFuclF1?=
 =?utf-8?B?VWY1VXpxMXB3VngzbEVDQzBDcTlvNmFhNWwvbW1HVEl1WThiU3VwYnJqZVUz?=
 =?utf-8?B?YndHUWZ4bDlaZHVOZi8xOG9WNzdUQkRPcXQyR0NXNzFTK1hnL0tNZ1ZnN3Q1?=
 =?utf-8?B?SHpxZFdaRU8xY2dKcGlNNXdFVS85SzI5ck9NdnROWTRJQXFxbFZyT2pVRUhN?=
 =?utf-8?B?VjdwMk4wWGJ2cFhOQXFaTGpnNnNNL1AydDNiZ0RjKy9NcWFaRzhPUSt3MUFy?=
 =?utf-8?B?WG85UGVqT1RGQmVHczNiYnJ3WVJQbDB4b3NVTlNzVWJJMm1nY0JUWXhhTUlY?=
 =?utf-8?B?ZlBiRGFFZ3hoR3VtOTY1MVl3blgveXpZVGZwaEcyV3ZwaUdMSWtvNzF1WWJk?=
 =?utf-8?B?QjM0UGk4anpIUldZVWMwWUNDM2xtbUM5ZjVieks4dWZzWmVCdU5ZdndkVlhJ?=
 =?utf-8?B?WjcyRldJL3p1aDRDSGlSeW42Nk1Nd3hEeTFyQWNuU09haW1sRnNSUVdUM3Av?=
 =?utf-8?B?anFoNzAxbjNTNmhpR0QxYXdJQ1FMRUZRa281enpmby82bFdVSENralVuRG8y?=
 =?utf-8?B?MnZmZnIxdFlzbjJoeTBLajJaYmVrR2xDNHhVeEZmMnlzZWpGQzVubnVNU3U3?=
 =?utf-8?B?T045dUNxem9SbXc2eklTakxSRlgxc0FlQzdNdnlwOTlQakljS3Arc2lNclN5?=
 =?utf-8?B?ak1Bd3FHUGlSZGJOMkNEaEQ5ZkZUTEJXdzM5YkljQXRIODQ2MXd4cEtJaHVx?=
 =?utf-8?B?anZyUUtucGs5d2lHdzkyMEg5bll5MTNZUGI1N0RpemNxZzlNRGpHb0J3OHBm?=
 =?utf-8?B?b3NLTmY2RHNCZWJITWVSeXNkdmZOZDRIMnpXMUExMHRTb2hwRlRRU1pEOThl?=
 =?utf-8?B?ZnNvYkhhZlM2UmRYZk5BT1VqLzRxNnp4dW0zajdKTzRObUtjVGltRkpUWWRn?=
 =?utf-8?B?QldnanBYK2EwdFVHaStpTjIwa1NGWnRqMW9XTVk3UG1oem5Fd3NHUHA3b3o2?=
 =?utf-8?B?dE1LT1Y0TkZGZnd5MlJxSVBZK0JiS1ByOGFoS2k1VGF4OG9odXhVVDdtWVdr?=
 =?utf-8?Q?Bng14QppEQXQgUt+1QXZLm6UfjlozEo4vhv1PP43OPHJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <297670A47B396F4E9CAEBB94767C8C7D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 423b50ec-ad96-466d-846c-08dc88f7e208
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 02:49:00.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sZ4OxOJovNl8FkOYGOPk9o0LRFkjwu/WNXag2W6SRGHYwqkVZKsTvIwbewQgh4P0yVzLbeBxfJfsc34GT0n8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

T24gNi82LzIwMjQgOTo1MiBQTSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEFzIGRl
c2NyaWJlZCBpbiBSRUFETUUsIGJsa3Rlc3RzIHJlcXVpcmVzIHNvbWUgY29tbWFuZHMgdG8gcnVu
IHRlc3RzLg0KPiBDaGVjayB0aGVtIGFuZCB3YXJuIGlmIHRoZXkgYXJlIG5vdCBhdmFpbGFibGUu
IEFsc28gY29uZmlybSB0aGF0IHRoZQ0KPiBiYXNoIHZlcnNpb24gaXMgNC4yIG9yIGxhcmdlci4N
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gU2ln
bmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2k8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMu
Y29tPg0KPiAtLS0NCg0KTEdUTSAuLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
