Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96702525E
	for <linux-block@vger.kernel.org>; Mon, 24 Jun 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198137; cv=fail; b=hlGaeK141NflaYRbQSXmPLyZGovxVlgrnjgTMGeqvl2GMPYJo3gfNEZ2iVP1JXTbnpDOLlUQKqQOAGU7NnhNYfqjqhoGky/YjfW/iqNCbfyC+ejNFyyLFRkdcENKTxrMyw0O0dqH4fvN/mXbfz1QO7vx7RalfuTZH35T3r4KiAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198137; c=relaxed/simple;
	bh=byW/GqDOGPg3d6OrayIAmXF9AVILiq7B5fUEJIaOLOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goOa7tB8XMwXhqmmed3Rod34LMtvyBfP4uWcwib1wOJbu9MkGD0MYTRfJUcBMfZmufE5SYvCls/KiUlbQNvk2kmvip0WwVYUWCcv91h4lqJJf+L5TgfeK8qiUoaOrux1wRjrozfF1vdt5KK/xSMKOhWGeuChvWTv/nwis5BU2AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pG2Qd87s; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pG2Qd87s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLM2VDgyqwKhdi+0FnPnH7eMUd0pTgVYhtJue9xJ6d793Cxio1zxuQ2qwxBBTPRjCI11g0SxBp0IuBz+nt+xo1wjBvLpw/sfKcAO1kx8POPt/hUAi15e0Rso2Y3cSSIQib/sO4iWcE5fHc6L96kUCg1U5OFidLT2nXccOQOET2gQoKvA+ZlOODW37xsJ90XLzVFcNE4pnT9J1D1aVjFozxG8Y4Nexc74/pDTZ+XjMpmI1apfZ1N5QrPGo5MNiV8LUVCCeVYPcVJsi7Qm0G8/v0iwZe7TK4MLcdHJHP8hgFKmlClORZS3VQ5ahP8JDsSsiY8JE0Ec5BA8wO5c9XmcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byW/GqDOGPg3d6OrayIAmXF9AVILiq7B5fUEJIaOLOI=;
 b=dSr0Ufsx/It4wZ2IzUTTgegcBfknb2wvHys0WFjBqFLEDfiqoUf4mLXWZsdR0CkSmxg0fc140L87IaC7afa/SQEBdTOjH38XMofOOSlP9j51NnmPQtyk+JceA2yPIIRmmhSBC9VO3P41iPm3GF/ho0JzVp+xLX/pgi562+4oBi68lP03+YNYxdxWVzr9cio/psRILig5DS9qrGztBZ1U3FRiMZWe3A7KJ6Q/EmGKNjYkrkWzQlXkQgCEc1tJokQvfV9ovAvnNmW1ye5W9NH2A8Wgmely7g0IsgHsW4Mydo9rPYZjsEhpeacfVUqOZAYI5Ctzab9BUNgDvd4xm1yRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byW/GqDOGPg3d6OrayIAmXF9AVILiq7B5fUEJIaOLOI=;
 b=pG2Qd87sJW7gEtguVzF/9a2DjN70WBxnxWBhrw+rxyg2R0Jsa+5Mx+4gqa1Cv1yLC3Euhbuu/+/xaNQNk0GSgP14VcsbAqFa6JpXPub3wmiAdZ27MUxg5unap1ll/Z/cdJ83JVZEMvPp/V8OcKOUtc3XwVtRmUWRnFqDEqCMmbFWqgVjuEtmmXoRb45FsiAit2eQ4okgYeif0M8NAUsZauIKViIcRqt7uz0AW8Lw9/rGCLTznWAJ3GJGagtIXeyZSP8NFblq3C4m0CC51vRaKQ2bFcCoRx6Cf2emFJAnOWU5nK8fNPkhZKeXf7jT5lNE6fLqN/IRWDcgSy8qT8DQkw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 03:02:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 03:02:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Gulam Mohamed <gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests] loop/010: do not assume /dev/loop0
Thread-Index: AQHawv56NmgDE7Z8AEOS22kkdzKhQ7HWP9QA
Date: Mon, 24 Jun 2024 03:02:12 +0000
Message-ID: <a52330f4-646e-4ca3-b519-4afaffd08321@nvidia.com>
References: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240620104141.357143-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6718:EE_
x-ms-office365-filtering-correlation-id: cdb90fcf-538f-4de9-537b-08dc93fa0baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nzl1Qys1T0M1czVKUHNCWFN0cVROdHpyLzBGbCtjK3RhRkFJd3FoMzJFUnVX?=
 =?utf-8?B?cHZBQmtoSEhlOHdkRG91VVRnQllBc01mUDF2Zy9SQmJwRGtVd09sMkhBYndJ?=
 =?utf-8?B?RjFESW9JK3Z6VDBNRjJQWEgyK0h5TE1RZEluL0NnREVLbWhQTGdJelBiU2Fn?=
 =?utf-8?B?WGQraEIyVnE2azUyKzBoNWFnazVLR3NJcHZtcmxBVEJtbUUvcGlhQjFmL2pC?=
 =?utf-8?B?ZkVLNm8zbytnOGR6a2I4d3hKaHVWdlBLbkV5bTRnbjFnaVkzTGR2NGp1eTJS?=
 =?utf-8?B?cXBCL1BHRGFuMC9jTVAvTUtwZUlSZjhueStLZS9oSlR6NzFtZFRRZTNRNHly?=
 =?utf-8?B?Z1VXT3lJNFhMeExiTFdpYXp0UUhnWitJd2twUk9GT201QjMzMk5IR3pGcm9q?=
 =?utf-8?B?T3NTVTMzM0plSC9jVXVZK2RTQjVnTm95cGlwZThDdGpnbWVtUlE1NXRadFcx?=
 =?utf-8?B?eUJMRHNnQmg2cVQxVVNscnI1T1lXMHBlQk5UNGVBa3lpdHhBRGdDS0pkemQ5?=
 =?utf-8?B?dUI2ajFmZy90VlVGMTdyZXlha0pnbWNHeWVIWWt3STYrU09zNGRleGRBbWs5?=
 =?utf-8?B?S25jMmpJWEo1VWhsa1UvS0crZEYrZDVsU25zbmNRV1hLeXAySFlBMWxuRGZp?=
 =?utf-8?B?eW9EWm53UjBDZ1g4aC9GMytmV3VlOHNXRXZNVDd4andwSGhsczdGNkpVR3VW?=
 =?utf-8?B?bStralJFY0p2VWxXc1MyNENGdm1sbzhhSkFUek1BcTVDRENtVG5QQWVsU0hV?=
 =?utf-8?B?WDFwWit3cTd2OHhoaklNMjI5OU9KU25lbXNNWWtDNzJKbkx1WnRyb0V4N3pn?=
 =?utf-8?B?OUlRTW1hcHVpajlwUUd3WkV1Q09aWTM2aGpLMWxPcW1HWkVMb3dwTFppdERI?=
 =?utf-8?B?NkRIMG5HTXgwS3lGSFJ6aG1qendMVlllN3ZvSk14WGMwdHNDLzRyUEREUktm?=
 =?utf-8?B?ajdMNlFvQ2QrcDZCcXRIRmRacVF5QW5VUFpFTnRMUGFwVjE2WWt3SG5UNEJF?=
 =?utf-8?B?eG1wWERLLzgxSjF4UHZnWVJTNmZRVk9mVlNwZE9CMmJ1Y3c2Y09tdFZNNVU2?=
 =?utf-8?B?bjU0cFpjOWZWOU5oUEsvQ2dXTnlKVkczaGVIa0VsOTlrZ0xWNndraDY4VWh0?=
 =?utf-8?B?UG1yQTkrSHlQZ2xNNkVVcjNEditGYVZlQkdQUFpKQ2huaWlDbnNlM3BGWEVK?=
 =?utf-8?B?V2FzbjZ1TUg2KzNVUzBZYWFMMlFTczgrM0lDUUk0aWJlMExpZ2E3NW43eldY?=
 =?utf-8?B?RE5ETzU5MTlLTFVidUs5cG95cFV3Z1hmaTIya05TeThGd29BQ2krK0dtSzZk?=
 =?utf-8?B?WE9Nbk9yWkJ4MEdyUk5oMDYxQ1k3d0NoTkdvMjU4TGU0SkxSWVRmanU4MnhZ?=
 =?utf-8?B?K2RXRGxRTy9HWlY5RGZXL0VSbkx5cGFLdCtDeENpV1VNTWNIeStIbWxNZEtZ?=
 =?utf-8?B?YjIxTmlMWlRubTBnZG1WdGFnTzdVUE5QUnhUOUx1SGR5KytqanJlNEJqSkpu?=
 =?utf-8?B?b1YxNzZ5MjBLQkorYVNzTnRMK0Uyb1Q4THNVczFJbnJha21pR01wcFNxaTFP?=
 =?utf-8?B?ay9taHJzM2NycW1IUGxWR09YSEg1d0dpVHVjU21peVhydjRLZnhwQjBXcjkz?=
 =?utf-8?B?U0lPZzl5QytpN0o0NGdvVEVnNlhBbkVBUnFSWTNvdnJid3g4WG9HVEYyMnR5?=
 =?utf-8?B?Z1A4OTZNZllmK2RjdmFHTHZaNTUwL2J3MDd1OEJRdksvS2pCQTJUUW9UOC85?=
 =?utf-8?B?UUVtKzlMSXU4Qk50Z2VrOC9Bdm9KR1lCQndONlhSN0JDMzJoUzRydk1uTnJG?=
 =?utf-8?Q?/CQXVqkOEMUGzOUP8Op2s8hAMPST1WbYuBG6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1FzTGd1N2Q2dU9hS09WU2UrOE9xMnZkUzNHcXNjTnNQV0V6S2hQUmloOGkr?=
 =?utf-8?B?NFFjWklVL3ZtVXhOelEvd2NTWEExamtzbTZyYkgvcTBtSFdaUm5qNnJJeGsy?=
 =?utf-8?B?cUs4cnlRZENDakFZK0xKU3VHbDhTWEhKSklxR20zaW1LUU1kR0loVXlVWDFD?=
 =?utf-8?B?ZTdiVnlvM2lZd3JTMkxSK0hBeGNWYWdkMUVSbkh2TnBsUjQrNmlCamwzWktK?=
 =?utf-8?B?RmhxYlg3TWVINkpWY1k5aGdtYTlJMVVCaDNBMGp6Z2Nxays0T2VIcTI0WHZY?=
 =?utf-8?B?bXNQeStuR1prZW5mNkk2SzlzbTJBU0F2RG9kZ0tha1JtT3ZoN1I4OTVOdFdq?=
 =?utf-8?B?Q0w5cEhBSklxN3V4ZmdwVXFybXp0RFlGK0NoWmYzZDBFeW9BVWpQSEszRDhq?=
 =?utf-8?B?eExPbGFiTWllakhPNStWNnA4OFdxU3NyaHh6ekRENGZkR3VOM2dOM0FvZWt2?=
 =?utf-8?B?dk9jSXg2blpzcjlpSHd2Z0ZIbVlOZURKVFRNeW5CaGVJM2l1R2pxdTFyTjRh?=
 =?utf-8?B?ekFtSmZDK2taS3RCMHRVQ2x6dTBTNlJ2V2ZzTXBsb0JvYXZVOE9FcGdQYjBI?=
 =?utf-8?B?TU5HNUJaSStwNTV4UUpWVmNGeVUyUUtncEl5OGxibUV4WG5hcFpYcGozdGNk?=
 =?utf-8?B?L0xRVmtobVNQVy9JWGhyRFNKVW9aTURZakY4WmpLUFZhOENkWThTSEZWblVU?=
 =?utf-8?B?bXRQVGVBNyt1UCtjL1RLbWxFUEhIOEcyUFdwbERhUjhFY1BKbE94Ly9FYzhR?=
 =?utf-8?B?L29uWmJ3ZUNqTUF0ZTN1Y21DNlNMQ2p0TnkrZkFRWDFtcGd0aktyaTBmSEl2?=
 =?utf-8?B?SVBYT1hmQllvMytVTjNpRlRuVU9yWHRCS2kzRlFuQnpweE5zbk9IcU95cnRN?=
 =?utf-8?B?QW0zdWw5YTJGcUJ5OTg0bE5YWWZkZ0I0Wk85QU5kaFp5WjNZVzVDWW5ubGNm?=
 =?utf-8?B?UThoMHNzT1NKaTNESmR5aDlsWVJuSFViMkhjdHhTZFFjeDVlTitoNmxCanR6?=
 =?utf-8?B?ekFiUnVNOVZPSHZCYW9pT0RCd3U4UDFjeEFTY3E0a09laWljcG1XVU5jb0li?=
 =?utf-8?B?ajRqSERkMWVPWkNMZGRaQzMzb0h3Rit1a2ZGZ2Z4Z01XWlRnazV1OVNmUXBV?=
 =?utf-8?B?NHJSOU9ISUI5TkY4ZC9MSGU4Z01CRjEwZENGQzFRRFZsRFIzeGc0SXU1ZWh6?=
 =?utf-8?B?aC9NU1BYTnRHVnI0NGhnYTJTRUQvSGZKQUpoc3NqNS9aS2h3dXZRczczYTYy?=
 =?utf-8?B?WS9rR2s2WVJ3a3ViMzZ1Nk5wTC91TGJtbldnckxaaFRzaTJpZStZRStTbGxs?=
 =?utf-8?B?OGJzdnNvcVk1ZXlqWUkwOWw5ZERiMUtIRXFnMUY0eHBGUk8yT01Xa1JZYTFO?=
 =?utf-8?B?dVovZ3ZoMXFyMkU5bllLdE9jNjdXOWE4aWJSQ3B5L2R0MGRVMnh4d1hZelRa?=
 =?utf-8?B?QzZPeElpQjlIRDQ4aDRieTQyS0laVWwrMFBRem5haDZLSklWcWxNVitHeUJG?=
 =?utf-8?B?amJ2aU9McUxBNlY3d3RxL1U1bHMwcWlIQjJpMm5FVXJWM1BTVFBFRHBLQm9u?=
 =?utf-8?B?MXlZTWJqdXpzcUNzYkozdW8wSnhvUkx5YkVhb0RGRU10Y1BBRFVReXZSUlhT?=
 =?utf-8?B?VDU1TXczSmNtVWVFNmljZE94SGpFeVRYdVNnSVBPL21tc0dodW4zVEtiZG9q?=
 =?utf-8?B?djFubkdnNHFPNXpBOG9RTHZZR2dqcFhkbGFEQ0NXbW5IZ2doUnhBaXMydXRo?=
 =?utf-8?B?YVZEb29zY25Hc3pFVjVrRHZzNmhDYU9ZZHQ4UHBQZXJiL3RuM0Z4SlpGaFpi?=
 =?utf-8?B?eUtmU2tkeU4xODlWdlNzTVhLRnd4bVk4ZTA3WnZBNzZKcWlvL3NZVTN4TkVw?=
 =?utf-8?B?eXU0KzRCUDUxaFhLeWUzVk1hVlJXRmcxd2p3U3MrL1U5YXpaY1JKZzRLdXJo?=
 =?utf-8?B?cFlwcDhRRGJSeW5kMTduSlJGSm0zbGtyNU40ZzlRMG8wek5vNmZVQmNNREdk?=
 =?utf-8?B?a01ISE5JbzdRdVdEbTNscjRta2N0Ykl3QUtDcWVORlpXcUlyZHZIT0F3bVdt?=
 =?utf-8?B?Q2Q4VVJvdVZoUkU1eGNSeGFOalpIc00zMm1PQ2VHWE5LdzhQeXN4RmYvTEpT?=
 =?utf-8?B?VlpKekVlUWpUMVB1cHFhNWRpOEFxRGVWdmo0MFh2eXNtQi82ZWplWUVtTGYv?=
 =?utf-8?Q?yG7dGxAp60AJ+8sqZQi19hluux9+mG0qFEQ9tARJJXU5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D05E3E767947824CA3036F5B22C88713@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb90fcf-538f-4de9-537b-08dc93fa0baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 03:02:12.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsTxePfBjhIBy9SO/4jhiiSqesgFk4YdUcwUVMiPw16FxkRd0NVm/w28lV6vm4e+prDUpnSK8qXddsJtUK9IZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

T24gNi8yMC8yNCAwMzo0MSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIG9mIHRoZSB0ZXN0IGNhc2UgbG9vcC8wMTAgYXNzdW1lcyB0aGF0
IHRoZQ0KPiBwcmVwYXJlZCBsb29wIGRldmljZSBpcyAvZGV2L2xvb3AwLCB3aGljaCBpcyBub3Qg
YWx3YXlzIHRydWUuIFdoZW4gb3RoZXINCj4gbG9vcCBkZXZpY2VzIGFyZSBzZXQgdXAgYmVmb3Jl
IHRoZSB0ZXN0IGNhc2UgcnVuLCB0aGUgYXNzdW1wdGlvbiBpcw0KPiB3cm9uZyBhbmQgdGhlIHRl
c3QgY2FzZSBmYWlscy4NCj4NCj4gVG8gYXZvaWQgdGhlIGZhaWx1cmUsIHVzZSB0aGUgcHJlcGFy
ZWQgbG9vcCBkZXZpY2UgbmFtZSBzdG9yZWQgaW4NCj4gJGxvb3BfZGV2aWNlIGluc3RlYWQgb2Yg
L2Rldi9sb29wMC4gQWRqdXN0IHRoZSBncmVwIHN0cmluZyB0byBtZWV0IHRoZQ0KPiBkZXZpY2Ug
bmFtZS4gQWxzbyB1c2UgImxvc2V0dXAgLS1kZXRhY2giIGluc3RlYWQgb2YNCj4gImxvc2V0dXAg
LS1kZXRhY2gtYWxsIiB0byBub3QgZGV0YWNoIHRoZSBsb29wIGRldmljZXMgd2hpY2ggZXhpc3Rl
ZA0KPiBiZWZvcmUgdGhlIHRlc3QgY2FzZSBydW5zLg0KPg0KPiBGaXhlczogMWM0YWU0ZmVkOWI0
ICgibG9vcDogRGV0ZWN0IGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBsb29wIGRldGFjaCBhbmQg
b3BlbiIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
