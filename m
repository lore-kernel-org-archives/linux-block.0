Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEF21505B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728815; cv=fail; b=f+/LtyxepAHH7sVbmILXCruBDz0tBAyWaJy3crZC7N+4Oqo6kEUl1NEGegRtZW9yZe5VDBxgBssgT+WwCI4FI/8YyW2gn+APqPID9w7YsRsgJFSx8m+hZNiR59u9DI0CBPRmiTEYKOV49ulJsaH2m4FqqG7xtG7gmIvO2teud2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728815; c=relaxed/simple;
	bh=1kke/TNjGzwN53fA69Muhu/TJ7aS4gXuM3WZ+xN796Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adm7moK/ew2DiH2+5sv+88x/j4oPLBw6E0K+/4yQh2EKmilJUWJvJzdg52aeKi5WNPVXJTvzpLr51KWr4H2Bp9JMqQGsAJG6LFG2TReq9QV5JxfzpTUxBYBcPOuN57Nvic3FlFjFff+iDe9s+W5EYGLZNNKroJd6nAN247l0k5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SO7XzQ/p; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SO7XzQ/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkWWtE33nxzwoxZ8dPtRIT+J2hu5oRQsPrXqJEI/CNl73SZaYOxEImzJHP5zct7LJ8NtZRHusat4K3t+5fUb61K3ZQQ6YdrXoaLZI0D2iPoarsMUMBJeQ/lrzjH6nrLDh/PTIeegLEUeXRyLDDEWGRJ+cFQAuKCCmMxrSvatncMRbdH+ZpExKuzzHR5UV5oqEhdJLkxpICYIuPCQEbVzKVWsahigZ/dwM1afmdxPHKmYeZp0+J8ZyKPgY0l7/6uuER3AFhtqGXh9BxxvZZVVjUg0q0vR3zItfOzVVJh6tzKiaQvsEixXBegC3hxj1VGbERvFeS2DaB/rUAVVpPGSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kke/TNjGzwN53fA69Muhu/TJ7aS4gXuM3WZ+xN796Y=;
 b=X95/rSp2NUCqcqpJiI2ES7df3wiXnpO7liylUNrtpAXrvlIDrZ0zCyEhL6EqsVnaYX5O2rnLoTKJqc2V3IgleqQemLaStRu5Ab+vmWXOglIytpy9bisM3D15jG/AlLXvdDxPT03OJrtS3cbKmXDLMHSWMSAPauX3GLPcdNtRj9RVbwnRVjOId0WmVewQbW+/7CFHTNFRaNgPPBx92oTdHud3+HKuQlzESZQARiIFRXWUaQqDeQNnQmK/6c6/zSgYXFsF3V+xC3ILSbULUbfRSxPXafoCmDughOkxQQzuAtKLkYz/BjdoymD77CsMr9uvJQ9Cd4/pRSeiF6XbhAsY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kke/TNjGzwN53fA69Muhu/TJ7aS4gXuM3WZ+xN796Y=;
 b=SO7XzQ/pI/Wf3VogTmcS8Wgkf+kxOpuU3mZ+dWspt1RQvQAmrc4OhCbZmzb8A7Qpt2BtVl4i2ZGar8iNoL5FA+pcCjhPl7pxJY7deC0uNJhw3N/sZDTlB+4tsTFrQJ2ZR4ZZqRn0O5LlN8HdtUJVH3B9lH9IioG2/p3cYLAuEva4j83alUP/FW45M6YuvMoFldXMNlyzGRkf60BhAoG5G8TrI05/VziVzS/rR995JL2/6BJMe9FDzqt64NBmnBsoGJeYzpLroXPJd9Xfp72ti5OAHJVTe6sI4x6S+Odo+cQUYy6B3HiKDbA/n+OoPGNIww49jEzYwM9DeshRv5QAlQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 07:20:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 07:20:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v5 4/5] contrib: add remote target setup/cleanup
 script
Thread-Topic: [PATCH blktests v5 4/5] contrib: add remote target setup/cleanup
 script
Thread-Index: AQHbR+YEkEAIxOJyTU+aMqmPavLSr7LdhcMA
Date: Mon, 9 Dec 2024 07:20:11 +0000
Message-ID: <b292d759-63f2-4213-8f03-05d02f7d321b@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
 <20241206135120.5141-5-aaptel@nvidia.com>
In-Reply-To: <20241206135120.5141-5-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4328:EE_
x-ms-office365-filtering-correlation-id: bd4a9210-6c5d-42cf-c681-08dd1821eb11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VldWamlFVmRPSjVoeTRFTDhkZ0cyOUZISDhDbUlwajZ3M2UwTGhEOVdxbGVU?=
 =?utf-8?B?bG43Mm9vbC8wR0lPTkhuOHZJZldodUE2RVlFVWxhcEVPS2NTNVpHS05rNzdw?=
 =?utf-8?B?TSs5bzF6bEVEelpzbHBNWGVUancwNzJKbWlzbThJMnUxU09YazlQVG94Q0di?=
 =?utf-8?B?WGgxUWxhMHc4ei81cVZsSkYrSTlScFdIWDRXT3FhdGxaZE5pei8xY3I1YTk4?=
 =?utf-8?B?azJyQkhaN1RNQzlDWmtmdzNIbE5yZFQyR0ZvbGpIc3lhdmkvYzVmVW9CNks2?=
 =?utf-8?B?SnkyTjhQT3ZFaEVpTGxzZkpnbzU3RnZvelNqOXI1dDd4UUNGOVg4Y2lGWHZw?=
 =?utf-8?B?cFdlMnFwYlNBZmo2QXAyY3p0RHRiSTU5U29VanBTT05NV0VwVCtlY2g1U09D?=
 =?utf-8?B?RmJSSi9Bd1ZkMjRNZXNUajhVdG83c0ZtQi9lcmRydUpjbUxuekFwbGpoajBs?=
 =?utf-8?B?bHo1M2JpMEovWFdjekFuS1N0VWpuN25NbWNqV1ZSQjc4MGtZOWtsMHB6b3RU?=
 =?utf-8?B?Y2hoNUhDMXpnanpESXVVcEZNS2E5MFZlcG5talZvc2ZLT3R5ekNzVlNIbHJJ?=
 =?utf-8?B?VTdVVllXLzMvYi8wK1luVjNITHQvR2haSktYcDdFUTV5dGR4QmNRWkZFRWdO?=
 =?utf-8?B?b0lIQVI4Znpxcm1jVjZqUGs4T2g0SXpKM1krWnFRZlRMQXVLTmw2ak42cGg0?=
 =?utf-8?B?K1FtblZUNkw2bUtjTnFEcWZOSGJSQ3V1dkFvd1JpbDVmUFNQYk0rdHJ5MWdB?=
 =?utf-8?B?Ky9rVjFQeGdKMGRoS1p0TTJhRTNkQWJpTDFBNEx4VERLR2IxdWlIWHNlZUtz?=
 =?utf-8?B?Q0JNek8zYlpETVFYTytYSUxZamc3MlJZZ2p2OHoyNllSRDV0TC92cFkzSHNW?=
 =?utf-8?B?ZzFMSE5ONWwvejIxZFN0OWgwV2g4bW9RWVgyYkNLcHNlNUZBYmZZdnBRekV0?=
 =?utf-8?B?QmM2ajRVci9Gd2J5VmZaUkFCd3pzSlRKbXFMRVNYcFU5QyswR08yMWpqMEsz?=
 =?utf-8?B?ejQwL2YzbjgxYUUyMTliaVBmZGszUmRSbzVPb1VnRktHNnREM3U2T3JkREVz?=
 =?utf-8?B?SFNSV0VxcTR2RTZ4U3dhMDdmblpSODV5V3c2eVdZNDZoNDUxTTVQUnpaRWJi?=
 =?utf-8?B?YXMyVUF1LytOU2lWdmhqNW9yUGNXVjM4TllzaE1pbVFiYmRvamxySkM2TDl5?=
 =?utf-8?B?ZnphaE9uTUUvOEprUkNWczBXVURqSVB1SmdwTDEyZC9EWHJyMUZXYXl5dThJ?=
 =?utf-8?B?Vm1NTnpETVdITTlnZmpXaGZhVmpTOVBRTlR5czJtSGQ3S0JrNWJ3ei9MSkxE?=
 =?utf-8?B?cTZvWFBLQ245UjdzK3VQZ2ZXMmhqSzRDYzQwVzdpajNjZW1jalpNRk5QdHRW?=
 =?utf-8?B?QnltWXkwRU15ZitkU1E5QzlhRXZEbFBVenZqQkpsSGhRaFZmM2gvaHNuVlNj?=
 =?utf-8?B?ZnlFb0ZOVzk3NDZRRzdySS81dUMwcTJwTGdMWUNMdFNzVFRtdEJhNThWQVlY?=
 =?utf-8?B?M3lnamhmQUVqTEVLS0lvRjBHQnFFalgrK1dOMVFtVm1xdDVWTE1BMGx2RVU2?=
 =?utf-8?B?RW1jcHBBcGNEcCtCV21tWStWZ1JvaHByQzJlOFlwOWNEbWNBSkE4SHVuNjNG?=
 =?utf-8?B?VFRKMnNBOFFFZ3dMMUMyZ3BZUmxUbGhGZHpDdlNkemNYQlJkS1JmL3dGTkY5?=
 =?utf-8?B?citvZTQxUmJXWEtaeUdQaUhudXAyMGJncVVrTlNGNkhhQVNQemJDZG0zenpm?=
 =?utf-8?B?blh0eVkzM3JMSmNSeEd6TlM5QmRBR3FuV2JNMGh3WHdlcUV2UWlHS0Y0WDhS?=
 =?utf-8?B?OVFGc1RvMGtsVTBNb0w4UGxTbTB3RGtWQk1OM2RBemFZVDZtNVNxRnVYcm91?=
 =?utf-8?B?ekNIZEFQTUFVckN3UkVTNkdRWTY3SjB3MkN3RWppdWVHbmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFo1TTZwT1R3djJLZWV1Rld0OGdyUkFvcUEzdmhpdWNHQjM5NW42K0o1aElV?=
 =?utf-8?B?L0FGTi9zVndmN0Ria21leVlTTkRaTjdxWVVudzBUQWZKNW4zcTZlcEhlTDB6?=
 =?utf-8?B?VHo2M1NlQ0J1UXhXM3U4aittRW4xQUpGQXN4ZUgxU0hraGtDMitJaklzSGdJ?=
 =?utf-8?B?SnAyUXZDaE9UZ3FadlRjU3Y0dkRxby9BSGsrejRjOEtSWHJrN00xV002VDB4?=
 =?utf-8?B?d05rOVVIUVd3bDNMRGRlS0p3YmlKbXBwckU2SnRiQzNmOEU1Z1MxazVISWIz?=
 =?utf-8?B?NlJ0YlFvclZ5NUlYRklKdktHRFkybi9ob0ZXb0EvNW11NytGUmNIN3dPaWpF?=
 =?utf-8?B?dVpHVGgyTkZhTnVEUFVrZFhZMWNHcEhBT052R1l5RUpVbjM4L0kyUmhSckpB?=
 =?utf-8?B?T2dCRTNLYjFmWjZ0OE1lMDgxenhkRFNyOEZEK2dkK3lyZERIT1VoMk9Xc1BE?=
 =?utf-8?B?N0xFWE41cW5yYzJBWFhkYWJpN2Yza2tTenZqOFkySTh1Z0E0QUgwSkNHOC9S?=
 =?utf-8?B?VzZDazR2Ykh1bktDbmtVTVBtQjJ1a0pVSDRGZkpTMnQwRkV1dmcrb1BuZFNs?=
 =?utf-8?B?RUpPVGovWDBlOGg4YWZpb2l3RU9tNG9Yb3hFUXdVU01GSFRlRVB5eDZaUkta?=
 =?utf-8?B?VHZkYkczU1VzNWx3c2hUQVJLNDZoSkZIM056ZWpNRDNaZGt4MERxSVlpRUpS?=
 =?utf-8?B?TkVRcDAvZW9KeHkzR1lEeHlLb0tCWWowUFdqcTVNQzZPOGMzZXhtelY4ZWc0?=
 =?utf-8?B?NlVUOUI4U3hLNWJDQ00xWXpXVFFBQ2EyNGlDbGJPWE1nL2hQYk1wdHp1WGZt?=
 =?utf-8?B?Qk5PRmt1a0x3dGI0ejJOVTdpZEh3OXJkZ3BEdDcxY3Vja0JjQTNmQlRaYkFi?=
 =?utf-8?B?Rm41ZENkUkQrMHBqWGxqQnZvdnFlODhMS3lSM3UzaXQzN2dCTGRvYW5ITHBo?=
 =?utf-8?B?Ykp1eVU5SXZRQWttK1NsUnFxd2FyUUFsWGsvYmZOVDVsdVZEbHVDZENRdWVT?=
 =?utf-8?B?MTBCRmcrNlR0T3B5bFN0KzRPd3RtU0F0ODlNWmRJSVpOR2Q0cm15ZCtabW9R?=
 =?utf-8?B?TjdLM2o3WWtpWnIzQzVkQmUzck9lZFhUbTRvTWUzZHV1Y3hYU3FPSm10c2Jr?=
 =?utf-8?B?TE10Tlg2Y2p1Q1g1dVRsS2tralhIaUpIdWRQVzRsRlByQjJ4VSt0ZFc4b3Yz?=
 =?utf-8?B?ZlNydEJFS2FJU3Jwa09vSmdMQjJXUnIzcjBzZVRVNFpFRGx2dytVOUtyN3ov?=
 =?utf-8?B?RitHYzlSZ2ZvdmdsWEJOUFMwSWozWTQvZXNEYnVsMVFqVnZiV3V3S0FNbytw?=
 =?utf-8?B?Nk93Wk9JZjI1b1VEQ25SeXdvbjlobnQwd281RDl6VmhnUTdDT3lxNlluQmdE?=
 =?utf-8?B?VVlPb3h2WjByWFZ6ckQ5UkxvWmdtdkpzVkEzL2k0eHRYbHJGWVV3ZHVxTUpY?=
 =?utf-8?B?aUs4YWlZM1F5ZEZIaUJ2ZWlqMUl6ZTgyUlRBQ2pGV1YzMDhCQzNlZHd5bGYw?=
 =?utf-8?B?Q1pMV2hFWm42S2lFSXpwYnlON3p4SXRLU3dpbFhybVN6SG9VUFNYcWp1bHN3?=
 =?utf-8?B?NGRaQlAxcmxwNHQ5aHpPU3RQTDZnVkNxLyswczVtVEpDTE9PQkJWRlRSWUMx?=
 =?utf-8?B?NEJFalBvSG8wTkJZM0xRZVFqbW9DQmRRRDRSSU1vSTV2c0h6T2lGYUZ6M2Rs?=
 =?utf-8?B?cENEL3V1bWI2RS8zNDZaQWxzRGl6dGg2aUlLS1o0R05sbTQrT2FXVmtMNGli?=
 =?utf-8?B?Q3FBdzBKb0hKcVFQTXhpaVJBZzFRclRpVUtVeTQ4cUpRRjN2L1htNnFwQmgx?=
 =?utf-8?B?Y3kxQVdvSGZRaGgya2IzVkpwRWN3TDcvbmJLbnE1NjMxTmJqa3FZTVhVMjRG?=
 =?utf-8?B?Qlk0QVFPQWszZkNmVXpueDkxNTh2eEIrcHdzdHNEOWFYUGVHYVQrQ2pYV05X?=
 =?utf-8?B?N1laY1EvNzlrcjBYQ29DaGE5a25HRTBrVGxrenVmOVM3TmFQWHZrMmlJQ0ln?=
 =?utf-8?B?ZXZJZWFXdzkzbTk4VFlNTzBiQTFIb3RrZU0xTUp2NFhVODA1NXM2eFFTT1Rx?=
 =?utf-8?B?Zm1pVjQwWnB2dkdiYUNCRWpUV3FaVzdFc3VvMlRwZlBmd3U3Q3duaEVMSjFZ?=
 =?utf-8?B?NFl1UkE0NzVibnpoZUVnTEZHNzlLZUl4czhWVnZlTGVlcnZkVUt0VTFiaGFr?=
 =?utf-8?Q?ygFKcbw2cF2KXl/HWLpJHhLNyv3XMUSAJJ0oeu4hJ0to?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FEBAEE5C0D6A942AD78F6DA8D03444A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4a9210-6c5d-42cf-c681-08dd1821eb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 07:20:11.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4jkH7SdqvmhJ+aL1TC/Stg/Kg/Xrmx6HK4Kb1ubUWSJQZAxl/Gimj8ewpbr2kKm43P6056/X5iU8bwjrHZ+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

T24gMTIvNi8yNCAwNTo1MSwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IEZyb206IERhbmllbCBX
YWduZXI8ZHdhZ25lckBzdXNlLmRlPg0KPg0KPiBVc2UgbnZtZXRjbGkgdG8gc2V0dXAvY2xlYW51
cCBhIHJlbW90ZSBzb2Z0IHRhcmdldC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25l
cjxkd2FnbmVyQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEF1cmVsaWVuIEFwdGVsPGFhcHRl
bEBudmlkaWEuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
