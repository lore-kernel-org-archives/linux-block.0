Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B504A23
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611920; cv=fail; b=gMmIjf7Eu5jiYXgCzr9dhhckM45mFfGqbSl+ZOUgxbQbAsG1uf9wayQB8vLIfW3k67gnXI73Kpv9mvmm8ZwEND1eE0DauPN8ttvaP+X35HNAVyEoglpCG0zNh6qFphhJZj+7JLe4TmMfG/Eryo2DtAkyKpc/3DXyrqhPIgQHpb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611920; c=relaxed/simple;
	bh=gecoLVPyA335f+/n8ZBHYvufWl3ub+Bb3mEYzE1PaQw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tFx+xmzPVlu5nm7xQlnzZnuGTkFEpUH0kvbZjJpcsg3KJ+ZD8SYKfDLRdddXqJVXm6YJp4EtkPcusP5rlXRVuy9uhE6KZwcuEEnBIAvmvo/Z+kS3YX2ljLF1NjeTYICUqdBjXAnjaNJTiTZW2RYUDkAKgZVM8F1PultaW/Nq4sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PataIbME; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PataIbME"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd6f8NtHdCAyvB8/wZS79Tv+57WpCCDeG9WituHMEC8AP7W2T3QHS9OdeWC8IAp6q5RxqhlGPbT7o/rwm6xR9EsmevmO1UDEY+Egn/7JO5DezmBRet9vH+QbN6FBbuNW5Vw/93a2th3VGzaeTKkeIbvivOo7Y7f1DqgVZwZ0c7MYcG+2csurZ+y647vDG+lAUyMBGmvXM/8mjPjVUvgk46Iqf5jkQFW6GaKLdMOrLyy1QDMP62kMZhB7rkLUeRkYN0aOWLzJI/NKrRAt1dbFswPHSskWWKVfE2BileZ7vCt35TVZJynYghWIxSSkIwlFoE8TRmHng8RrAXVMpcLCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gecoLVPyA335f+/n8ZBHYvufWl3ub+Bb3mEYzE1PaQw=;
 b=NKET/P2ArYHBVzkF2QzMClFfOu23En5HOCQiFpUAUrBpiLsGs1yPl7KZdmANL955WhTR8YqyS6e97zGnDDCCowGMi89GZZlAuWho2UpiWwnVkajX5qFiiA8oVg8OP5SF+A05iMJ3Kwcg1f9YPONs7QqHn4vOjIM1GEUxA8ZWapU+mld2wWCSdZqUlrtwbrILuC+NUAmOUZJIRIMnaGeB+aLrqF12t8wt6bBFb/xKGTre4puojhEPPrL2O+nJawz0tVbZHzlWAtFKdmIftSL1U7PuxKkDV64PkZhLIE/JPkhJK729bQu7vxe90WTGSEE1ijHxspkHWOU0xb1fnvrzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gecoLVPyA335f+/n8ZBHYvufWl3ub+Bb3mEYzE1PaQw=;
 b=PataIbMEgRujKuu+RNAcJDOW6NFPntcQhxnc0mxIDXAMGvnoSE0+wv1K3fdU6YXqYD6R4BKD93C4ledpRHpAWpw+3N1UFtQpto+83oIquaLXcoJAO12AlZF/txmKs8Gm4qD/YvsyTxDX9GEev3CuVNyq2SWjVgmxiR9xYR34MLCMzvLL/4Vqg22iSZNjiIq6PTvXXT/7V9TUakNILM4Aray5FpkbfSYcaJIOoXaDRUOrDgH4BcEIi9cwYgP+L4bgiwBmm5WkZqW/i96KnDaQoKxVjYlkdKvT/d3Ibfq7CKlsCTjTZfaE9txMuZjatnwCvC6NDyLYyeuVEznU6Li4Vg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 00:38:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 00:38:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Thread-Topic: [PATCH 2/2] block: make REQ_OP_ZONE_OPEN a write operation
Thread-Index: AQHcRtkKTD85zxFfyU+08vSfheve17TWuLCA
Date: Tue, 28 Oct 2025 00:38:35 +0000
Message-ID: <9fc2df84-f21b-413f-ac85-b6124a1c3dcd@nvidia.com>
References: <20251027002733.567121-1-dlemoal@kernel.org>
 <20251027002733.567121-3-dlemoal@kernel.org>
In-Reply-To: <20251027002733.567121-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4271:EE_
x-ms-office365-filtering-correlation-id: 617b0e56-280a-4296-3f9c-08de15ba5472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?djdEczg4N09sR3V2WlN2Mk5oblJxeVo2akMyNElBeXpkbHE0RDdDSmo5STZx?=
 =?utf-8?B?RmVzc25jTE5aN2ZQYThGR1QwOGhBNER4MHdHRlN1M0o3OEROK1FUbUZ5SVBV?=
 =?utf-8?B?OEJPU1BaYW8xdkloN0g3VEt6VnJ5Mkpkazh1YitFUWtkVkcvWU1icUtpbEwv?=
 =?utf-8?B?L2xjcHhhcGtPU2FJcEROcGhFOVgyeENJd2UzbUIzODlqMnJkN1B6Wmp3VXpK?=
 =?utf-8?B?bnFFcktib2F5L0hReVI1YWE3QU5rcEx0b1JUK293TnRKWlNRSjBpWkhtS3RF?=
 =?utf-8?B?Wmg2VEwvQzRudGhJakJxN0dkcDgzdklBSDdMTzFObjhoUVFCQjQvRnRFdURw?=
 =?utf-8?B?OTRLUWNLVHJwazc1WDVWU1hOUVJPVHIrZ3huT2hmdVZYSGYrZEJ1S3hzWFhV?=
 =?utf-8?B?WUdWbFNEL0lFZ3pneXJGRGk1WXBZczJ5ZjM4clgzQ0grTFVBdHpEclRtRUtH?=
 =?utf-8?B?UEVqTGt4UFBUYTV2bndoWjlFbzlKcnFNeGRObDc3SUZtMVZUdzNiN0t5OFoy?=
 =?utf-8?B?TU0ycU95SWIyOXg4U1A4WG9ONjI2S1NoS2VTM2tnUDZLZE9qRmNJQ3JnelZK?=
 =?utf-8?B?T013RzB4WjVJYmQ1bDRiKzc2NE1GQ2FSZElDZEh3d3lsSGxjWkRmNnZqOW1W?=
 =?utf-8?B?cE11VUNITFQwQXB3eFlMS2M5ZTdVek53ZzdwZk83ZWJ5Yk9nMDZCbFhBQVd5?=
 =?utf-8?B?TEhoK0l6aDViUWZGWlVNVk5Xd2NxdGVyY2N6d0ExZEkxL3hmTG5UNTJWTDN0?=
 =?utf-8?B?YjZNMDNtTlNLNDJvZEZ0bE91bDF4K2lyRkFyd0tZNlBwVGxaeHkzOFlPcGox?=
 =?utf-8?B?VmwvVXZIR2xqMk5LTFZHbmhKcTZQWHkxRVVQdXR2bTYwSXdGSzViRTVWQmlu?=
 =?utf-8?B?NGcvK0VyTkNrQlZzd2dvUnFNVU0vcVc4eDlUWHpNSjZrNk5RU2Y1TEtkTW11?=
 =?utf-8?B?WXhPendEZmlpblZRUnNtTnJRa0xYUXZlWGlPamRiakhHWGdqNlJPdm9oYUk3?=
 =?utf-8?B?R2QvaGIwcE1UWnZPUGNDWlJlNmkwYU9KcmMvT0hpdlFSc2czdkFsMlE5Z0VX?=
 =?utf-8?B?ekx5Uk1iS2NxK01UYVV1Yk95YkdLdXFvQWR6UnROUkVvRmpIU3pheWZEODdP?=
 =?utf-8?B?N2VHUmZNZllMYnA1Ukl0cDhWRTJ5a25BY2FXR0puU0UrZWpsZEI3TTBHWTFN?=
 =?utf-8?B?Z0NPeERIMzRCMmRaZXp0eGNSRnBUa0UvZkp4d1ZmbUFCaW9hRHFCK1ExdVBI?=
 =?utf-8?B?NmpHU0prV1owWWxyTlRRTWg1M0czV2JwRXpMaXNKWkRiTXVZK1kwbzQ2VU1n?=
 =?utf-8?B?UFlkVTdDMitVT2dhSVlZUFlCb0F5V3BWbEM0RWROTy9ma29iMWFLK21RelFE?=
 =?utf-8?B?aTBDZWRIOWtQYzQ2RnZCTGxhUkJ5aS9YUURsWnpBNzk1bjJuRDBxV01hUzgv?=
 =?utf-8?B?SWZZdGpLMmc3dDl2R0UzVzRHL3draFEyRmFObDlpelVvbkNlVWluM0tmdi9u?=
 =?utf-8?B?U0xFZWFGblBZUENLQnpDWmJiakpWdmZ0MHMzRGE4ejRpSGNPMHFQd3EySmN2?=
 =?utf-8?B?aktxY1JHTGlTZitYbXU2KzIyeTM0U04yQ1U3RXQxeTBkdGlQbm1uUXJZWmxH?=
 =?utf-8?B?WStDMmZRakIxQjlteU5GRXdtZ3dKemp2T1RxQkk2WS93eTVoWDV0Qjh1ZGNT?=
 =?utf-8?B?VTBoUnhtemdjLzdwSEVnWDRIRGEyTm9ZWFA5UkJnSWgyUnFaVlpPYlpPOUp5?=
 =?utf-8?B?dkkzN2dOSzZtd0o1Qnd0VERsNm9ucElZcFBlZGFsL3BYelRWY0V6bUxaVGdN?=
 =?utf-8?B?cUp4aVFJbVZqc2hBclJObHBkWGFzN25IbXFxUTVzU1Qra00vcHdRUFdlSDR6?=
 =?utf-8?B?U0Z5dkdDZTBCSzBCZnROSVNGZTF1dUJPU2pqQXo1YVpjQ2g0dTk2THpsOUtU?=
 =?utf-8?B?U0krUlYrMndSM2pzaHRmK25ZSlo5R0lsVjN5eVJURTQwZHV3bndVdUsyNE5w?=
 =?utf-8?B?SmFEcjJCa21aQVIwb0tOWHExTWsxK0JtNmNDekdDejNvSi9WcHhxTFVQemxK?=
 =?utf-8?Q?6sRoUV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVNtbkJBM0hSVHhQL0FmR2VUVGp5eHhhSEp3TVg0cXZjYmliMFk4ZDUwVUht?=
 =?utf-8?B?NHVXdFFzbDlkNVc4UVEvaVNQNjBFa0xhU09DcWxrd2JKWmFmMThOYk1Kc2Jw?=
 =?utf-8?B?aVR4aXRra2NJSWl3VmY0Q1FxQkFCdFFaaUhpaDFWd1NqditKMW1hUWlqa3RT?=
 =?utf-8?B?RzE1T1NrdHVrSXREN2dLQlJRZmhTejVWUWhWSVM1cTRIS1gyTVFIV2ZkclFn?=
 =?utf-8?B?QlpRRzFsNytVd1lvelVod25oWUIrbmxaZUJ5SFJXUC9vazVvVnpQejM0QWdw?=
 =?utf-8?B?QjJRN1IzNWVpblZnaVh5RHN6UWhQUHBkNDg0NE1OakVHek4wUVBvU2pyS1B6?=
 =?utf-8?B?cnorcWlKZXNNYUtjTVV1Sy9rbmVMUFpXZlBIYW9TQkIwM3dUQ1JkSHZKUkZ0?=
 =?utf-8?B?alJ3VlNrTEhReXkzMEtYRU8ySXdzTVFzajZJb0M3WjFWSVZyTFptZ2dJelpN?=
 =?utf-8?B?TjZucGxXbklEK0JEYksyLzk5Y3dQSkhDNzhMN3VPYXRYdDVoaU83VGlGeG9o?=
 =?utf-8?B?MXR6dDY1OENwbTduREpoUmgrcmZ4TlRMLzhpY0tJQVcxd2ZKT3dCeCtsc3Za?=
 =?utf-8?B?clRTK3dHUXpjL2lwWkRqb0x3ZFhiZVdZQ1hOeWV1YXZBZXJSaCtZTzduSzZq?=
 =?utf-8?B?QnB5VkZyWGtWSzkxa003T2hhUWE2UFdkZXQ2emdhZWd3UDhsNkVrS09RWlFS?=
 =?utf-8?B?dHdEYTkvaTVsSGI1cHRSd3YzajBJOEswT2NlM3JPbkE2bEhYdC9EYVYyK3gz?=
 =?utf-8?B?aDhUcFkwR3lMd29KWEVkMmIxR0hxQ09idDNXUHhFZW9EZ2R1THZ0aEV6TzBN?=
 =?utf-8?B?MzVUZDZ3WElQOEFFTk9rVmRNWUZVZWxzL0tJV0c3UUVGV3doMEh3K1lFenZx?=
 =?utf-8?B?LzZ2MVpOUWtLczB1TUE4eDFsVTFPaW81WHhUeWJjU0ZjTUtUNlRXaDJFS0ZC?=
 =?utf-8?B?VkVPY1g3L25ZNnE1R1VhNk1Hd3VUang4bUNlZTNJaTJTL0tVU2hpSndUb3Z2?=
 =?utf-8?B?a0N3ek1wdlYxYnBsYUE4dERNOEcvRGJtN0lrQi9ZcFdJZHhoSFp6NzZBdjhE?=
 =?utf-8?B?TWQrU2dvV1lSSXplQnlIU3VaZlRrL2phaGZwU215ME5SRGloUHJ4bENlVVht?=
 =?utf-8?B?aDZDU25HdFJmQzA0QnJvMWV4amJoV2R6ZFE5bWlOZXo0T3Q3azdiSG9EektN?=
 =?utf-8?B?OVE3dDI1aU95dFR3b2ptNk1ROW9DQnB1TFBGOWJneVVuQmY2Uy9yMUFNUFVz?=
 =?utf-8?B?WkUyaFFtK0xIWXllS3EzZlVlcXBYVy9LVlJkRElxOHlBU3p4THZqVE9sMzlq?=
 =?utf-8?B?ZmVwR3QxVWxIeEkzb0t3Mk4zWVZzTTJsK3MremZkMnVFaGlpQ0VCd0MvbTE0?=
 =?utf-8?B?TzcvMEtvc2t4c2hlQWp5UURHL2YxT3NXYW1zT3FIbjhneUZ0SUJiYkpZZy83?=
 =?utf-8?B?aUNENjJZZjc3SVJMbHg4Lzd3ZTA5cm1NaGFYV284WWVnRDFVY25odzM0UnZu?=
 =?utf-8?B?VERzUDNzUGNKSm1CdGhmbWw5UWY3ZWRsS01CamE5R242bk9UajI5NG95OEFE?=
 =?utf-8?B?T1ZSYnY0TkQ5c21GZXQ0eGdndHgrZ0laL05HVVR4a3QyUThBM1Z4R3NKY2RB?=
 =?utf-8?B?RlprK2x3NEZxMlM0Y1BqTFlpVUp1MXc0ZTVaNXVVNWR2U2ozK0VTbUE3bHNL?=
 =?utf-8?B?V0dkTUw2WFhwcFRRcE1HZ05XUGpraXpNNklWZXF0bGpHWnZ6cFJIajcvMXNh?=
 =?utf-8?B?VFRvd3QzUi9xK1pjaDN3NHdzaVhYTEVJT0xuSC9vUVhTRW9DL21VRVExTGhL?=
 =?utf-8?B?c01FaG9NMytNbEFrT2w5NG8vWUdCNWlZMTk4TTdXTUxjVlh0am9CNGE3UXJW?=
 =?utf-8?B?SDRsalMrMjNRZURJckhwdGh6blZVUFdUa0ZmK0RpVGJLYWd6VG12b2xKcDFq?=
 =?utf-8?B?MkR6OUdndDZ3UFA1N04xTXBBanJwWTZ2bzB1ZmFXcXQwVzNqNk5JR2JFSjdY?=
 =?utf-8?B?SG9hWFg2T1hVOUVPZXg0d1hlWXZPZ2EyM1REanF6aFhGL3Q0ZmcxQzZrd0ox?=
 =?utf-8?B?dlBwOEd1MjRRV2R4MW9sM0cxVTA0QzlYSDNTdTk2M0cxdXpqYnV1OGVaYmhQ?=
 =?utf-8?B?STZMMHZtTG00WmptVWErZFk5eUxHenEyU2N0cHNmZHN3OW5rMDZQcStqS2Zm?=
 =?utf-8?Q?whwk+naJRz6OiBd7WZs04iu6tK/96G8QQ2+qoZRUmPCA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A53784E4B0114EA89B2DDB8C97F424@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b0e56-280a-4296-3f9c-08de15ba5472
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 00:38:35.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76F6SWc6cD7WJ2pXyHYESyBx89Q3Gn1om8ojG0r60y/OcAQXLJj+SxvX44ELl5B447QGDFfjGJR0loqv8m8bmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

T24gMTAvMjYvMjUgMTc6MjcsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBBIFJFUV9PUF9PUEVO
X1pPTkUgcmVxdWVzdCBjaGFuZ2VzIHRoZSBjb25kaXRpb24gb2YgYSBzZXF1ZW50aWFsIHpvbmUg
b2YNCj4gYSB6b25lZCBibG9jayBkZXZpY2UgdG8gdGhlIGV4cGxpY2l0bHkgb3BlbiBjb25kaXRp
b24NCj4gKEJMS19aT05FX0NPTkRfRVhQX09QRU4pLiBBcyBzdWNoLCBpdCBzaG91bGQgYmUgY29u
c2lkZXJlZCBhIHdyaXRlDQo+IG9wZXJhdGlvbi4NCj4NCj4gQ2hhbmdlIHRoaXMgb3BlcmF0aW9u
IGNvZGUgdG8gYmUgYW4gb2RkIG51bWJlciB0byByZWZsZWN0IHRoaXMuIFRoZQ0KPiBmb2xsb3dp
bmcgb3BlcmF0aW9uIG51bWJlcnMgYXJlIGNoYW5nZWQgdG8ga2VlcCB0aGUgbnVtYmVyaW5nIGNv
bXBhY3QuDQo+DQo+IE5vIHByb2JsZW1zIHdlcmUgcmVwb3J0ZWQgd2l0aG91dCB0aGlzIGNoYW5n
ZSBhcyB0aGlzIG9wZXJhdGlvbiBoYXMgbm8NCj4gZGF0YS4gSG93ZXZlciwgdGhpcyB1bmlmaWVz
IHRoZSB6b25lIG9wZXJhdGlvbiB0byByZWZsZWN0IHRoYXQgdGhleQ0KPiBtb2RpZnkgdGhlIGRl
dmljZSBzdGF0ZSBhbmQgYWxzbyBhbGxvd3Mgc3RyZW5ndGhlbmluZyBjaGVja3MgaW4gdGhlDQo+
IGJsb2NrIGxheWVyLCBlLmcuIGNoZWNraW5nIGlmIHRoaXMgb3BlcmF0aW9uIGlzIG5vdCBpc3N1
ZWQgYWdhaW5zdCBhDQo+IHJlYWQtb25seSBkZXZpY2UuDQo+DQo+IEZpeGVzOiA2YzFiMWRhNThm
OGMgKCJibG9jazogYWRkIHpvbmUgb3BlbiwgY2xvc2UgYW5kIGZpbmlzaCBvcGVyYXRpb25zIikN
Cj4gQ2M6c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUg
TW9hbDxkbGVtb2FsQGtlcm5lbC5vcmc+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
