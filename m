Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FD2FFFA5;
	Sun, 19 Jul 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464021; cv=fail; b=BTBbVg4p6yUgdxGqevpyVAbrL9r5k1zKbtsGk/UO1qEKh25bHzZxq/HPKwD5nFTZfABySrDwp5bljJtwLgWczGxiAapmzaGW/HCVOsdpdI/WPWtlQROgg0N2TZm8iTTlqN8oBZaOo6JWP7qwRWCHyKam7eE74/XCd0WqABd3XG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464021; c=relaxed/simple;
	bh=UML1uVli60CeEuDsHwAqInwa3gYWw2hJGrCJKkkSTJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnmdZhDKhakWRp3t/5ubyvz0VtVj19npsALa7KDhpjbzCQeLx7HCUvY9YZEdl/ElRJkrpchaS6ZBw8a53dqx+QYu1i1qHFY0NHWrjt4rfYbVAY7LMMrb7XVrvbqXkJI8CFfaa1UWNHok1ClgRi89nJaSlRQyJrKFUmsMIGX2MRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=J8uRvAtP; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="J8uRvAtP"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JCNM9d1710378;
	Sun, 19 Jul 2026 12:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=u4UoClIJAzPRh5+JZY+S5ozckqYI04jeF3x74dhYi9E=; b=
	J8uRvAtP2niWuqxXZfVzs+xT6KqJy9W+8dj8/wsLlbJTtRfDryQjM62IrVjyMQma
	eirH1QqqmYDIdUwNGHCJShmpNRGki/OGS9C5kAclAQ2Dl9Y3Xvu8skEjMYExSncI
	RilYdsz3UFAUjcr9YPOEW3k+k/gbbcnCDUVfUp+4tHJoelXXICsMYCPp3qct58WB
	AJHrd3qfDujNMG6ZPJfA825/q+FmNVeJ92rIJaJ5kxxrRknO1vCkrXASZlqbCcDX
	a6qVwmMRNDtNwj5D38qlHchwbfsFvl4+p4DCvlBSnmViupqVyKlwLb0dbRbv419f
	rULBufbrrqTySkZd9yWVZw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg0f594pe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 12:26:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no5AgBvl4OPSZIwZAM50C7HzrV1TWrcxDnW5KjW7reccOrxviroSa5Y8o4HQwQezlj9fCTlVk1pDms2/u/Asx2PcyjnTgRpSPRv/b0h3TnKObX2KrwqrfXj/91bDNcdRdMK+10jNePA3KL6u8+cbBJXy2pPqazV11iU9Pe4X0yhIWsfhiNbEjSVE0bary2ueIbKFOQ769uyKB3RomZFEYv96RXYobGaN5CsMqZfQ/6XrBrTZlGn94Jl347LJ7PIcWTpcE6MnnWzEnfLw6KcsMrhHLU9Yz6F80Jp2p5vShccXRMXyoL0U0IFzalMC/LMpYLsgKWcR52vHfW1v/MDuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4UoClIJAzPRh5+JZY+S5ozckqYI04jeF3x74dhYi9E=;
 b=LSivXQKceTqH3Bo9/0h0VC6v063T9UbH7IuecNgxxPFS9w8lYkV5YZbUnyXgDD1KNe93fhQwqZTi84dS9W4o0ZfUkvYhteoxKOqQCsxC7ET/cXdTuRoafMpKgcpewiugp1sSuqFvRt4Tum6aw0ILvtD98V8rYcWr/UIeDxeT0mzOG5PPN9LJJ6kEv4W+sfc/IyGO/ENfnSBfnl8OdE2UPN/2tIbgJhxefk5czM/nYWRNM8yB9HG7UYFUjR8lRir9Wgxf7/ShOQIVvMKMnUWiTdT+tHJ04QyN2MYSGL1+uPGo7cltn2INQ6sz/w6VgO5ASRHM292tK6PSt59kW7F0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:26:48 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:26:48 +0000
Message-ID: <1c0aa683-4e70-4081-98cd-74b0d0bc9a76@windriver.com>
Date: Sun, 19 Jul 2026 20:26:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix circular lock dependency in
 nbd_disconnect_and_put
To: josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yun.zhou@windriver.com
References: <20260630031021.3321628-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260630031021.3321628-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DS0PR11MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 0973e241-6095-47d9-499b-08dee59100bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	htv+WbSxNp64BzcMk+4f6vxQdkJoGczWH+vfYIaOJPyQdzDeCOjQwrAd6M+Fm/oR2u0RqPA1R9rQUymr/MwDlP/jOdfSoKsL5sRmH7bvyxaXgzo2DHFWk0Hy+5AB/VIpWECTMQrLyJT8n1mN5SapZcIejLlBk0s7x8oFwmDdOLHpM3CqWPSboxhx2IyJpF4f8uv+6iqfQ4YEJ8Jwk0lWdtqPx2hGtMbKRjK8P9bax7iHek0NySak731oHyZ8n95ygeJu0hGjJJMJHGVOOzuzuymC7SQiFa8P1yA1pY/66kN+RR+reaVljWGywuYce1gppSRTcVcW5SXU0aaja4/rfCwiw7IQQmQtTKFPqjICwZBy9Zq3fFQFBaHXQAPxu3QooD8arXd4iA/TPt5i3lUuex7FnCr+BuoWgfLEshOD2DNIBC6DmUaSuf9rFCDFk6w2/Drt+iRyfyWuWADGkSKuucW8RItEJvrgU07UJjcvSFib3gTNqolEPuRwVDk2M4XNSbJUIwnkuYUCdB3lGR5EaXofjE7AoUXnhCDCg6LXnNX2l3pabtYUwgFpdx4/hgk1E7BdCbe1mVc50PcAG+eggRTqSBJ+RB5vnteZtCo8VbqER7UpNOxFddnP0T2DtgD0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ppYU10ZDF5TVMvdU5pbzdGOU9wemg1bTVzMndVdEF5RStCZ2drVERGR3NC?=
 =?utf-8?B?RkhPc2xrZnMyNnV4bG1ENjRRRFhUYm9GeUJyYkV5dUQ1NnBCWkticWM4K3Va?=
 =?utf-8?B?Yzk3NDBEQWlia09VQkhtYTZSQVpWVU82bDdhWjlBeFlsU2ZuMHZucWtReC8x?=
 =?utf-8?B?UVhmZ29reTQ5UHZpcklxcmxhaVFrODJlVHgvT2FzQ1VOWGM0ZlkzZnRiR3ZC?=
 =?utf-8?B?MWx3V051UkRLZFVlaW9iOXloUEFXNU9Fck8vak1tYnU4d2RSMXNWUXN3bmRu?=
 =?utf-8?B?REU2SUJ1K2gwbVRuNW9HNEZvVlp1a09ZcjNybXhJWUk0QXlHSWg5Uk1uT0Qv?=
 =?utf-8?B?eldTclk5cUdEZXRUTlRHZDJNWDB6WllkNHFCa1Q1a2lKblF3ZWRlUHluSVp5?=
 =?utf-8?B?MjJTR0k0dGovSTNwL2VwbnlQeFM5UDJpOFA4R0NodkpDa1liZm1rZFpacFFy?=
 =?utf-8?B?cU1CSCtqa2tsRXl4S3pMdVhBRlQwazJEOWdHdkhsbjJ5azlKSjBWdEt3aEVH?=
 =?utf-8?B?bjk1NVQwRXp4Qm93YmFqODJSa2R3S2hDMGRaWTRsYmxBQ0l0OVpGZXUyNkNr?=
 =?utf-8?B?d3dFTk9GdGF6RGsxUksrNm56bm42SWpGOTBsN3FtNGhWU2FPM0ZRZGpPZjgx?=
 =?utf-8?B?aTNTL3gvT0ZaREsvSW1VaGdqVTFRWk9YbmxCMmhFVHVFZHBHUlE2QTdPaStK?=
 =?utf-8?B?UmtUUm5aaUVPUG5qYjdZazBRbUpoSVdRMHF6Y2dzK3VMeFFhSTY2T3VRdHFT?=
 =?utf-8?B?V2hIV25zcEdFYlpCTjlmNE5FdjlENVY5TVFhemtnK2tqQldNbG9vWUc1VjdP?=
 =?utf-8?B?emw4d2tkeXluOWtaV3R2a0lxeXZ6YWM4Qk5ia0pFZEZ5Yi9wRk5USisyVVpH?=
 =?utf-8?B?K2NwdmlKZ2s3ZkpReUgxd2VyMFhndDBYY09EMjZRMFFxeWpkay9pUVVGbW9T?=
 =?utf-8?B?L3lPTUlUdmdDU2s4QVZzMkgvTkRSUm9pb1RTb0U5VSs3R3Judld5TWd0cVZZ?=
 =?utf-8?B?YTRRdExibHQvaWdLcTB0VjlRVTV3ejBVZnVjbjluRzhIWW4yWmt0RUN1Ynh1?=
 =?utf-8?B?ZWRFdFlYeitMdHh4SEF5M0o1U1d6Mk1aNmZDekpweGlHakQyZ2lUUlZQaWVL?=
 =?utf-8?B?dW1UOTdjTXQrVVVsazhzcUdubXpsTzR0VWhBaDFTcHc5M2VyZE1xUVV3bTJM?=
 =?utf-8?B?bXdvNGtQdSsyc1UwYjZYMk54QTU3UEpTd2Q0YnhlenBYVWgwbE5BWnhpV0Iw?=
 =?utf-8?B?a2JzU01uVlJiK0lxVE00UnpQL0c5cjVOOFFGUnAvaVMvTzcvbVJPVzNNcHBB?=
 =?utf-8?B?cEJ4dXRGa3ZKM2ZyeWQ3eUFxWW1tQXIzMGRKTFRVOGRJVE5sV3drdlVFb0Vv?=
 =?utf-8?B?a2JXaWkyN2U4RmZMTUxNV0ZKU1B5MFcrRlUwTmlpNUlFcHpQbVRYT3I5TExG?=
 =?utf-8?B?SExFeXdCVHo0MkxWNllGTzl5eUI0R0g5bGtDeXV5UEszSVppN2t6anlTUGJO?=
 =?utf-8?B?dWMrRkJKZlRhT1drTlhqOWNYdnd2WDJRNEFvSTRMUmlLdDFITC9jdU84M1Iv?=
 =?utf-8?B?THRjdTl4d2hRRjVocjZFa3REU3l5bHJtRTRVQ2plYlE1RGtKSTNVZlZNYmp6?=
 =?utf-8?B?a3poNTJmMUoxWEprWWlJd1hwMHRVQVZVY3ZUQ3FCd3RrU3pYNUlSS1Bhbmxu?=
 =?utf-8?B?K2FOYWZmaEF1Y25DVVBMdVpVVk5leWV0SGxSNEI0RTNyUHlaNTUweVFuYUh6?=
 =?utf-8?B?WHdTOWhhVkRQSWZUOUtMOG04Z2NraUZIc2ViOGpWMmpqQXVtOGl4Z29PV2Nx?=
 =?utf-8?B?MWx0UEtHODBhYTZkTmxpV2NvdWNnVUJYNzFZZk9nS3pZNHRZNXdXdHdieHNh?=
 =?utf-8?B?a0lKd01RWjJ3QUp4aXQyY2ZQQjVvc2VzWklnMVcrYUhzeCszSklRQ3d0dDlR?=
 =?utf-8?B?ck11dmN2YVQraXlnQS9OdDc2RjFCdkZROTJkUVZkUjZEY2hvelVDU1BCR2VI?=
 =?utf-8?B?UUNudWdoODRRNnhYVlcrajhIT2xpcUV1MlR3c2YvRVc4N0phQVBTN0Z4MHRy?=
 =?utf-8?B?cy9idXdDdStYVjBXaVZ1L0dVcDg3ei85YVArelI1akM3WFF5c2RBRnMzOW90?=
 =?utf-8?B?cnNaVFFwNGRNWjZaS2VKaHpiU0FsbldvWG8xcWIzY283azNabjlpNDJveGRI?=
 =?utf-8?B?VHFmY2hJWXRyV0tobVhHQzA0UHNOVStjREpVb3U4RU5sdEJPS3ZUT1lhbndw?=
 =?utf-8?B?VUdXTmJOQ1RzTE16c094dTVTOTJWbnJCRjFSK3UwZGZhUkVnRUh4b0cwaEIx?=
 =?utf-8?B?VzF2cmdWZVBzS3ZPZkRVVWxscm93QWFBUlJQRlBxQmhUZWRYakQwQT09?=
X-Exchange-RoutingPolicyChecked:
	rGshkrLtlSgtZ03yLCXhA5TqoJf0T3iYaBQLs3LQ9WS2nj8XC5GRitKx3sYJrx2OUpEnmTU4pSdVpjWNnieymYs+VGs5VHRZC7o4/VL/z0elJMwYoSvd5L731I9+wBZOAZAp1+YpwBMf/U1mXypUU8eHrjJC+0VBg1T6q581yeWGPx4K/TgoUJl1MtdOUacYae6BsSw5I2m4A9qhiGvO4UtCsFAosKSki9xeiYCI8tMQqOWMURzXT/Xo5evEthSvjAByZjB5ozFVV2vCEwBuT3BOhV+JP7O69zT6JMICHeaGsYaklOXE1EqAWGHoF70CAEJu8Oso4A0vWQN3PZdysw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0973e241-6095-47d9-499b-08dee59100bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:26:48.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSqC16SqVtfCV9puN8qDScaIqxIFLut0WOAECnibNKfIB+o1pMGaqREBmzZ2ULHqMsbeWeAzsl/kGHmfad2MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzNSBTYWx0ZWRfXwCf2r0EEjFbp
 f7QUVpdSCkEsSEmHFE61H8vlDAwGEspH48qSGGBTbEjF8TcxacePs98aPSieczVPPm6fyncUU+i
 9/V2LQaN3cCq+tn60TrBsF20RCG0xHpBqpKK6sxggnz/ElWXGesDVCs89K9TwVbHSl6BafkiqkU
 4/gzyW9hy+mh6iNLsEjtaA/SNnvmci9w3VrXwAY7GCUofBEPNzr/4D8ZLod5XBK3LLS6BHfOTKm
 wm2j4yguLCDVpV2c4XgAKECbjup2SnvQDOqLjTBqZuhjuJXZ2HEmQXCdVe3jDV/l6n6sUreEXxf
 hJUcsIWGyEpubUUjA9I6jMleXFw01oUYIchg+sGFzi6CRgUAOJo6y2y6kI2osQUVVqcAMAJx4iW
 +dx52dc3blObsuzhQ/8TWGunAW4PCLfPg/+ENj5vy8ApKQoQvnzQVXmrCAY+1/ZztBSOAg0fZhc
 /5S0KyrG4uRjagoVlQg==
X-Proofpoint-GUID: wzEgm__Qsu5ITrwgopwVm5Rz8FTiHb4c
X-Proofpoint-ORIG-GUID: wzEgm__Qsu5ITrwgopwVm5Rz8FTiHb4c
X-Authority-Analysis: v=2.4 cv=IM0yzAvG c=1 sm=1 tr=0 ts=6a5cc289 cx=c_pps
 a=pvbKGUK/Si0pumwNLfsG/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=8ekC2YOIjpCFBrEBdRYA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzNSBTYWx0ZWRfX/GzFgm1vyAu4
 PE3dVQ35+s87wgc4H7GM50eVSSGIEE1QFn6bhmdq4fev86auO9G80FQDfZ1WG/NlCGrJBVHtFeE
 ue9ZXYhyjZ6UJAGQZFAuP1wn423hdVMp4K3WcY7uPJYP6uWEkFBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190135

Friendly ping.

On 6/30/2026 11:10 AM, Yun Zhou wrote:
> Move flush_workqueue() out of the config_lock critical section in
> nbd_disconnect_and_put() to break a circular lock dependency.
> 
> The lockdep splat shows:
> 
>    config_lock -> (wq_completion)nbd0-recv
>      from nbd_disconnect_and_put() holding config_lock then calling
>      flush_workqueue() which waits for recv_work to complete.
> 
>    (work_completion)(&args->work) -> config_lock
>      from recv_work() -> nbd_config_put() -> refcount_dec_and_mutex_lock()
>      which may acquire config_lock when the last reference is dropped.
> 
> Fix by splitting the config_lock region: first hold config_lock to
> perform nbd_disconnect(), sock_shutdown(), and clear NBD_RT_BOUND (to
> prevent nbd_genl_reconfigure from queueing new recv_work during the
> window), then release config_lock before flush_workqueue(), and
> re-acquire it for nbd_clear_que(). This is safe because:
> 
> - sock_shutdown() ensures recv_work will observe errors and exit
> - NBD_RT_BOUND cleared prevents concurrent reconfigure from reconnecting
> - flush_workqueue() guarantees all recv_work has completed before
>    the second config_lock section clears the queue
> 
> Fixes: e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
> Reported-by: syzbot+3add0454d5a2619b8e80@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3add0454d5a2619b8e80
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   drivers/block/nbd.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c5d3ae8f5fc5..87b97bd9d0d3 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2329,14 +2329,23 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
>   	nbd_disconnect(nbd);
>   	sock_shutdown(nbd);
>   	wake_up(&nbd->config->conn_wait);
> +	/*
> +	 * Clear NBD_RT_BOUND before releasing config_lock so that
> +	 * nbd_genl_reconfigure() won't queue new recv_work between
> +	 * here and flush_workqueue().
> +	 */
> +	nbd->task_setup = NULL;
> +	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
> +	mutex_unlock(&nbd->config_lock);
> +
>   	/*
>   	 * Make sure recv thread has finished, we can safely call nbd_clear_que()
>   	 * to cancel the inflight I/Os.
>   	 */
>   	flush_workqueue(nbd->recv_workq);
> +
> +	mutex_lock(&nbd->config_lock);
>   	nbd_clear_que(nbd);
> -	nbd->task_setup = NULL;
> -	clear_bit(NBD_RT_BOUND, &nbd->config->runtime_flags);
>   	mutex_unlock(&nbd->config_lock);
>   
>   	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,

