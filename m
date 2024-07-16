Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092623B0;
	Tue, 16 Jul 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122258; cv=fail; b=NTJ30N/GvOnoRzJho9o8vKCmG9dh+uQeE0NLtMDOD2Z/dUQxBhZGqLi36oxhby/av56eKKryAi4YBbrJ0WmrxTtW5mFYs1GSbr0DF1PDpMPD8uDPwPeoEDwAFnSv+w8V40BzPm1AiX8h5chMefdcr929kK6EKitV44WGnqyo6v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122258; c=relaxed/simple;
	bh=OQ44DLDlRAx6yQ901WSNeLJS39yJA4/OvQXJoxpl7Rc=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mJ4k/K2ZIWuGilXWzYNZ5dhX2/MOp3+Fhi3jXt3+S7HicUEeEytM7DcOHXo4pWNB2qR5bJ//VmxjMudgqxpN0a9kxyT4dj1DFX7ztMYtH4/qZY57iT88x64iq9EWoAhmUjKvY9DLtzxbtFr7FGGxwRDCDlQHe/sduN5bLjxqnW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RDykFiWS; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RDykFiWS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0HV++/aWLnJaJGhpK0FAmFRHZKF291UYDXZJscJ8vyDrx82mp0Tf6WU7PVG/Fbaiqj5fZs3Gh7MogJ+CJfnTfHKaNWuwRiivVOfXhVmIUYKF5H6Cb2lRSuRtfA46JBQ9uSnv8DH6lgja6J6uqHGu83ml7+swj9VSCQAtgZNS0H6HRlEtN4rMf8Al6LeWlDhHO1E+WlXPoe0GFGwq6g8gJ+T5tspHO9LmaPPRN3EVMXuxYfiXUArDDRLcBgpcZ7HPDzWF7/lhCTXZuBRYpWZzfQJYg98+JY9PnioxcKy8igBJmTr+LczP/et3wH0IqnuexnPTDWHC7HYWzthvWajRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFglRCGKkJ6mSCFYJF4QkNZT1E2nnBqueUutc5yEUf0=;
 b=f2k2lLTFPxWrJDOtRpDR/GyelE2n4H/XrUyXHIMEnbS9AcwH5pxEr2GxnVByakKJfr9uNfFuO4GJz6qtPLufY0pbMZXWTQCJoSIY68p1OilnEak0+m7Eew+DZ/NVOqxXfZY12VifiaC8ydNKgbhk4O1YCXVHYhcm3ebKIekaaw12oxxy3nDu5mAOcJtUubf3HF0PJUrcahI99yqK/I1V2C4wCti9gCgV92GmjrezrP/JFbxwUldbJWAxvYAsG//LHwKo7Z+C77bZKGK8uF3ZNqRZDMZyw+CIrPU5wWuaiNryOd6ohWS/X0J2xFAO4Yt+t1twVQKJaIveVNQBlJpZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFglRCGKkJ6mSCFYJF4QkNZT1E2nnBqueUutc5yEUf0=;
 b=RDykFiWSopUxXXEkKoS0S7+W09H3wjqm0oWs30rDmVGbl+Ya0nsBSylfR5UjD+20unE6jCtaWrpfgdXCRibtvKWIBURK9dTbBUjoAj1CBY6LmVkAc3F+D2EnjmOF8qkPIYDU5HdhxHU8Iw1EHw7T1WPxNYl0KLte3UIACTQWUs0bLYNI3IHWIp0JZx5ZEK0/vVgmgmBaQnHg2u8FvU8FRbY9DmWo+b24zPZ34ZKuhgSEEWkSg/VOaZfkQ+LZzNrkfaWsOAZKtiDAkHowcuPeVZvmwi3FWrApBXHTLUQmzGwTPip/OMoU5NI+FPQ3sD/mz2GtjZZ+BDGNBbovhDSOfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:30:47 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:30:47 +0000
Message-ID: <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
Date: Tue, 16 Jul 2024 17:30:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
 <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ab9a29-b90d-4994-91cb-08dca579f911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXBISWJ2a0ZuTGlxa3BNTU9GbzY4OWNDQlEyV2U0ckZsdk1zRCtpVnJ2b1Vi?=
 =?utf-8?B?YTFSN2hwZjRjZk96K05FN2lpclRlNjJDWnJMTjg0RlRKRW9KeUM0UUdRcE5q?=
 =?utf-8?B?ZjVpVlBGZzQvQlhlYjh2dzd1Z3FWVEE0QjRiU3BGZUlaQkFKSHRUcUVwUk53?=
 =?utf-8?B?ZStCV2xPUHIyMS9XMDJYRHNWNXVEM0wxMkpnVlMvemVwb1ZKNFk3M1cyRTdY?=
 =?utf-8?B?dThIcjFycTRRQ3VaeDNGSGZFLzhLdm1LTVIrTmdQZ3ZaU094M1daZGwwMWVn?=
 =?utf-8?B?Wm9kMHNGTmJKSTVsUnJZSmNYaERvWHFnd21Xc0l2cG54TnVnL1M0RmZic1Zw?=
 =?utf-8?B?bmliSWFqV09NSGkwMFJaczBaOGlVOC9qSnBNenlYaU5sZGlhSFNTWGZqMkEy?=
 =?utf-8?B?VlZ3cE1WdStvM2VtV0V4cndWM29OZ01PcnJyRUxjNUllVFAyejRUZDdDZnNH?=
 =?utf-8?B?cXByMXBuMEpvNmVDb1NHa3ZUUUt4YnU5N2hEbGMyTTM2ZUIxYTgrZXhhYWF2?=
 =?utf-8?B?SjhqWmVBR0UvdlVVVS9xenRhSWI4ODBFZ3BWY1BaQlY3SlJSNjJaSWJVVkU3?=
 =?utf-8?B?WlU4d1NybWMrZm5VYm9DUldybGYxRW5KOER0VU9LVkFEa3lIc3l5WkpNQzBT?=
 =?utf-8?B?NzR4WmYzb0QrTXVwdFVoRWttMkZxOGhkTk9qQ3ZudXpkckpXbzYvVEt6ZUVV?=
 =?utf-8?B?VE5hSHhPc3RnbktqTzY2Wjhkd0U2aGdSNWp0ZGFrbDdHS0tLUExZdjZEQncv?=
 =?utf-8?B?V2ZtMWV3QnV0cVlBT1VMdjdDUnNEM0EyeVorVWNHdkFXZEdqeHZJT0xadm93?=
 =?utf-8?B?UGxvYkRYRC9LbVJFeUhXc0ZIbTRXTlVTMC9qdlhvem5GUFN1U3UydjErOHMx?=
 =?utf-8?B?bzY4YzhvTW0yb1ZOckpoQ25YakdtZmdtNElzcDY3cDM5NTZubVU4U2dLQnZa?=
 =?utf-8?B?YTV4eUpoZVoxYWtxQjcwanFTTENiUFlBSkNQOEs1U2NEMXFCeXhuYTEySHd3?=
 =?utf-8?B?V21rZmZvMGFjazJmU2xWMDkwbzBEc21ZZm1WUHlEUzRDd2VNdWNMamxlU3dx?=
 =?utf-8?B?MFIyTGlZZW95RDRyOU55SUswUmJma0diUXhHZGM2TmQ5RUtKblFYZWw2RXNh?=
 =?utf-8?B?VFRGaVJmSWdGNjhWeHBNNTBhZGkxb05STDJYSmx2OGlFaGcrZ1JTRUJnRUNC?=
 =?utf-8?B?NXMzcXhyeC9HbURZZTFaZlErdmJ1dGh1WkxHQ0dwSDd1QmlZUlIxM0xDeERU?=
 =?utf-8?B?Q01rRUozWXlqcU8xZXdNSllHcUExTU9PSjdKUzB2SzRjRnY2UGpnOXJRZzJT?=
 =?utf-8?B?cmJGTTBoVlZ3Y0dYL2dCV0dESzB6Y2t2ekVNOGxZS003dzR3RDhZLzdINGJ3?=
 =?utf-8?B?cVg5cXhZOTVhVHUyQVFzNmlUSXhOMUdtRXQvTW1UZGFKWExxTUxjbWNuSmlq?=
 =?utf-8?B?Z2k1Z1Y4NTRjU3JUSlBPcktiSXppdnpuUGVuMUp4OGQ1MVNjYzVIK1NoRFdW?=
 =?utf-8?B?L0NFTUN2TEY0U3oyT0pwZTVhWmYwRzNqZXlVTXRpWUVpcE1lN0xYUEcwY1Qw?=
 =?utf-8?B?T1F4WCs0OVJ2OTJ4dWpUZm94OGIwdmFIYmlRWFRuWDU2eTFYMUtQekhPdHR5?=
 =?utf-8?B?SkhqMzZDWk1CK1pVUmF6WjM4VVJHdnZSdWswcmxFZis2US9QOThIeHVnSTB0?=
 =?utf-8?B?VnB0NmlhcWhmczd3dkE1QTE4OXVmN2lUT252cTEvNmJEeVlTN0gzTnhCSHNR?=
 =?utf-8?B?dmZITG5McWk4RVNjK3pwWGw0bDBaN2NLaFFtYnQ5N2w5eWlyUGdMcXc2Z0xa?=
 =?utf-8?B?b0lvRm9BSHE5T0g3Zmg2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdVV2EwSFEwYVYyZzlZODE4K2NveE00RmNyazZ1elFnSzhHQVZxZ3UyU0VJ?=
 =?utf-8?B?V2k2Y0VWWkpDRStyTjlBeFQ4WlRadnZ0RytqbmlFZkYvZi9wNDBqZE5aUVBE?=
 =?utf-8?B?ZUp6Yko2bHpQUnNHNDhJQ1RlVmNEbURhSG5wUkhJWkRtRE5td281NDE1dFZ6?=
 =?utf-8?B?OXJMNk51SWJSWjJBekdHN1lDRlJJemdTWDJNRFgvOXlObzZUMXVCU211Vk53?=
 =?utf-8?B?eEZMLzBpL3MzU0xRNEJhc3J4SDNONGt4V1lGc0IvWVU2RTZyWVNEWWl4TG10?=
 =?utf-8?B?WVFld0tzaFkwbkhObnhBQXd1Uk1BNy9aMkdFVTFoSXc5Q3IvdUZnUjg0blZF?=
 =?utf-8?B?MmRrdElYUFVwQ3JERGtHOGVXcGR4WjhWSUdnRWFEVEpNbEszZnZLZUdYempl?=
 =?utf-8?B?MG5nemdpL0xvL0tjY2k1WXM5WWFGOFRFaUpOQ3BaRDNvYkdoYVlnclRCVkhv?=
 =?utf-8?B?NEhIU0tMWjhYakVpL0hib0RRR3I1dHhJM1ZHUE84VGRpSTVkdHAyejN1NGQ5?=
 =?utf-8?B?YWM2ZDFDU0l4eFV6ck5ObGJuRXk5RllrdDJ0OGlESHk3dHdsTnlzVFhmL0JD?=
 =?utf-8?B?Y1FxOFVhZlV0Z0hhVVoxSk5XWHUrQzlYeVVmVTUvYUtLTTZBakNHUnF6dE94?=
 =?utf-8?B?NVFZRFU0QmNFdmFBREllRU1mc20wMHBDWGhtMHJpV2tPNE1aMjF3Ty93d0RX?=
 =?utf-8?B?ck00d2dLM3hLSU5HaWxGQ2FxNTVzTmlVZ1BrZkljak1zdWFCajVJQmRsOGta?=
 =?utf-8?B?YXF0OWVyREMzeWVkNm1mUHMrQnhsWGM3dk1kdExjNXpDK0xyTHlkUmt6b3Q2?=
 =?utf-8?B?OTR6OC81YzY1U1BjazMxV21wVjJCS0Z3MkgrS08vN2xqWGQ2a0o0NFQ4cnN5?=
 =?utf-8?B?RWdaS3Q5TXJyeENXdTduTEVhWUFoTWhwWTQyWi9GNnJhYWxaN29PNFhhRy96?=
 =?utf-8?B?K2NqK3VYYkU5QTB1ZmxjT3VBSmx6Yy92bFYwQUxyUmw4ODJkS3F5OXdxRjNQ?=
 =?utf-8?B?VmdqYSsyMzJEdEdZRHE0ODZoT3lGTm1IWjRuZmdGWjdTRkMxenpaUXUya3oy?=
 =?utf-8?B?bnhtdkdvKzNDQzhlcDhhZWs0Tm1TNUlRRWtuS0JFbE5DNGVlNmdtN1h5TS9q?=
 =?utf-8?B?UW1EZXYvblFKUk5vNHN1YWhwZk1aYmYyZkVodUUzSkIranFDNjhWUEZzZzB4?=
 =?utf-8?B?ZXBDbnQxZmJrTkVzL1Y4UlFhNkxET2x2cjZLaW90MElEbWtWdlRySUZYRjdK?=
 =?utf-8?B?Rmw3R0JlZzhiU1htMzJtUzJjY2t4cEdBdVBTOU9pUGxGNjcyZFk0UDVPTHVP?=
 =?utf-8?B?cktpb3M0QVIrQ2owSHdqS0RpTmFoek5CVTVEYi96RXdWdVk0UWFycnJreldK?=
 =?utf-8?B?cGVMeXI0c1Nxdk9hTitIVUFwd0dhSjExUEtCVTdXMlZZQU1lWlJwZjRqQmQ1?=
 =?utf-8?B?YkxMRE1oSC9lSkJHTFJBdUFQdGtDYXQvakg3ZDVZREcreHRib3kwMy9oYUIr?=
 =?utf-8?B?SG5jWEJZQWRDaFE2OVBJOWE4Y0dMeFBBYXV6Wm1aTVFLMU05UFM2NHFsbVlU?=
 =?utf-8?B?eE9uWXloM0JzaEwvb0ZTZEFIVngwVTdya0hOSTJxcFhIZ2JLNk5kT3hGSjJG?=
 =?utf-8?B?a0hpU3pQSXl1bWtiTzZOdWR3Q1E1ZEkxTmpRWmV3aXR2R1FrWFc5M1l3TVp3?=
 =?utf-8?B?LzRsV01lLy9Ed0wvSUNxY2Q4am5uUVlDblU2RmtBT2R5ZGV5aTJsT0hleXht?=
 =?utf-8?B?MTUveTdIOFJDVUxxOGdzU1dRM1hiQm9lUUNNa0taeWJkVXhwbHV6RjFaMCtO?=
 =?utf-8?B?LzBUN0NBUzRZK200eXMxYUFHMUs5ZG5wSm82dHRZS3FmcDg4N2hvVld2YXJE?=
 =?utf-8?B?UGNxMGJGUGFjSEd0K0V3S1FpT2J0d0RXeXI0Q0JCMmVHS2R3MDIzWEZBUHZh?=
 =?utf-8?B?WGcvb0pQSEdiY09MV3MyVzUxSjAzbUFnS1VwaUV4WVptM1RETmZoNGc0YThR?=
 =?utf-8?B?a1o4amVyMlJsQVhDVGJOT1Bld0p2dExscDBtV2NzQjBIVHRRQ25mMXNQNjVr?=
 =?utf-8?B?M3Vham5sOTd4M3FNc01vR0hWVGhmUDVEb25rTCtNdFI5WmlDMFFtZ3hwUkZl?=
 =?utf-8?Q?rzXUQROMgIyfYFpEgQfp/VzBT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab9a29-b90d-4994-91cb-08dca579f911
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:30:46.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctq4ecgSvJFmC11R18pruLAx8pnwYBuZ34bfwkhz94vYNCC9wDGjvFrA62r2gsPfwdvInksnZ9ciHZE6VIC69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7096

On 2024/7/16 17:15, Yu Kuai wrote:
> Hi,
> 
> 在 2024/07/16 16:38, Yang Yang 写道:
>> Our test report the following hung task:
>>
>> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 seconds.
>> [ 2538.459427] Call trace:
>> [ 2538.459430]  __switch_to+0x174/0x338
>> [ 2538.459436]  __schedule+0x628/0x9c4
>> [ 2538.459442]  schedule+0x7c/0xe8
>> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
>> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
>> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
>> [ 2538.459459]  mutex_lock+0x30/0xd8
>> [ 2538.459462]  del_gendisk+0xdc/0x350
>> [ 2538.459466]  sd_remove+0x30/0x60
>> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
>> [ 2538.459474]  device_release_driver+0x18/0x28
>> [ 2538.459478]  bus_remove_device+0x15c/0x174
>> [ 2538.459483]  device_del+0x1d0/0x358
>> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
>> [ 2538.459493]  scsi_forget_host+0x50/0x70
>> [ 2538.459497]  scsi_remove_host+0x80/0x180
>> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
>> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
>> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
>> [ 2538.459514]  device_release_driver+0x18/0x28
>> [ 2538.459518]  bus_remove_device+0x15c/0x174
>> [ 2538.459523]  device_del+0x1d0/0x358
>> [ 2538.459528]  usb_disable_device+0x84/0x194
>> [ 2538.459532]  usb_disconnect+0xec/0x300
>> [ 2538.459537]  hub_event+0xb80/0x1870
>> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
>> [ 2538.459545]  worker_thread+0x244/0x334
>> [ 2538.459549]  kthread+0x114/0x1bc
>>
>> [ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 seconds.
>> [ 2538.461014] Call trace:
>> [ 2538.461016]  __switch_to+0x174/0x338
>> [ 2538.461021]  __schedule+0x628/0x9c4
>> [ 2538.461025]  schedule+0x7c/0xe8
>> [ 2538.461030]  blk_queue_enter+0xc4/0x160
>> [ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
>> [ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
>> [ 2538.461040]  ioctl_internal_command+0x5c/0x164
>> [ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
>> [ 2538.461051]  sd_release+0x50/0x94
>> [ 2538.461054]  blkdev_put+0x190/0x28c
>> [ 2538.461058]  blkdev_release+0x28/0x40
>> [ 2538.461063]  __fput+0xf8/0x2a8
>> [ 2538.461066]  __fput_sync+0x28/0x5c
>> [ 2538.461070]  __arm64_sys_close+0x84/0xe8
>> [ 2538.461073]  invoke_syscall+0x58/0x114
>> [ 2538.461078]  el0_svc_common+0xac/0xe0
>> [ 2538.461082]  do_el0_svc+0x1c/0x28
>> [ 2538.461087]  el0_svc+0x38/0x68
>> [ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
>> [ 2538.461093]  el0t_64_sync+0x1a8/0x1ac
>>
>>    T1:                T2:
>>    sd_remove
>>    del_gendisk
>>    __blk_mark_disk_dead
>>    blk_freeze_queue_start
>>    ++q->mq_freeze_depth
>>                    bdev_release
>>                   mutex_lock(&disk->open_mutex)
>>                    sd_release
>>                   scsi_execute_cmd
>>                   blk_queue_enter
>>                   wait_event(!q->mq_freeze_depth)
> 
> This looks wrong, there is a condition blk_queue_dying() in
> blk_queue_enter().

  584 static void __blk_mark_disk_dead(struct gendisk *disk)
  585 {
  ......
  591
  592     if (test_bit(GD_OWNS_QUEUE, &disk->state))
  593         blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);

SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
this scenario.

Thanks.

> 
> Thanks,
> Kuai
> 
>>    mutex_lock(&disk->open_mutex)
>>
>> This is a classic ABBA deadlock. To fix the deadlock, make sure we don't
>> try to acquire disk->open_mutex after freezing the queue.
>>
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>> ---
>>   block/genhd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 8f1f3c6b4d67..c5fca3e893a0 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
>>        */
>>       if (!test_bit(GD_DEAD, &disk->state))
>>           blk_report_disk_dead(disk, false);
>> -    __blk_mark_disk_dead(disk);
>>       /*
>>        * Drop all partitions now that the disk is marked dead.
>>        */
>>       mutex_lock(&disk->open_mutex);
>> +    __blk_mark_disk_dead(disk);
>>       xa_for_each_start(&disk->part_tbl, idx, part, 1)
>>           drop_partition(part);
>>       mutex_unlock(&disk->open_mutex);
>>
> 

