Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22086F2F0;
	Mon,  1 Jul 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815979; cv=fail; b=nSKfCiWPOUN5Qk19DAMS+rtTrRzuPE96dgXgIhVGKoN+7jpz3Gc5vtnTlxF6Dx+CeCPByRcYpKZ8/FWYuLoTmxukuO/o5cgqW6JLmUxdWAfqXv7soULMsugE9GGTOsy1hhEIKnUGlK/AXu6YdgjcTqjGm6u3SShH/YEVfRJtlAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815979; c=relaxed/simple;
	bh=/ZOigpOyGjPOcS916b3qFRi2Fg8CxwWsljLNQGTU4I4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pzYQAs5YLZetT8NE3jmCp6ao8b9Vzn8t+QLbJqeoWMyc9NayXqwhmhg9VTLOFjG6Dbp+SIHbLMvkb8jSmFQtvgUJeasvM4ITomSdj4P1a40v2Vgq1ey+3aiLGmU21z6OWOWwhhEh74yBGkAYrwa7xEK4/n0+NMvoy7Nx4du1Ky0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dieAHfvr; arc=fail smtp.client-ip=40.107.255.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dieAHfvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbCW/TvB6og50NfzfyXiRDG6vaqKsDOr10G65licbwCe67NAo5XPocJHVmjq2iDTsnUsyIjj6cVo0VOlrsZ0xQ122lUqqQ1VLOu5fD/QI2C9pV+lKUmF/LB4vbCYktxeGTq2s+ErY5biI7QH8OcFTRA3v8bL7KZL7KOZwuiAj+TDMbaMxX6Utp/FISc0YvdZSvr1yHhM7Q1yGx7fxQfoIoj6u1rYo8FnZ/K52YoBt9uwIihCt4coMxSU6PDEvmCrzkScMWLnoIXJiPZdUwNuM04AC95hwsijddixbgds85r/YIeoKVdWALwgSkXxzAWA2Z+ZnwCbVZbPY7pVM1vKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBXUcjVERV7erpMKB2vqUkMl6uSsuV/zztV3gsr2LPg=;
 b=N0BNpF9cfenMufJcxiJ9TM8H/jySFxXPXORxBgkSmc7G/IW3GTblr6RnS5dkCMTiZu+jnxUSjKqSBody5BjKLEwzrFGnfM98eURC3QVJdjgNOLZprlIAKfl3HxJkWgnjbScNWdTf+rLP6nMF0Hh0SviKfh8Xo0XC9GE9b/i7vfR+uWA/izQMVxvwS1hJ92AJ7fQ4zQHAjXA+17LcF7V9fxZL/5IUx6HYVzfCoysJDAVBM4JaRjasIKTBal6fHMApU1ZURAA1fxb41mv7KgZ8C1x97dMlhN4no+A6SNjNIzt5r5uBu8WaLRIOjWSistGWSa2U+uOlJ7lpQXD52APyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBXUcjVERV7erpMKB2vqUkMl6uSsuV/zztV3gsr2LPg=;
 b=dieAHfvr6mKNnqsbbk8aQpuKgsi41Rx6Q8BxUB4IAQUVZaRqQv997MoSVxc/x3w8MVCUq+OOPFJtTbpLzNYPIXrdd70LqeVha782Oc0ZviOYGnhSgQvRFgOvbqfJeFxIir4xg+ItxOACQ41cpnCzmnISBHHGL4yTlQ6ee3G5rPVJAa6xxkAyiGgx6o1vDHV6Ofpqth8omC0Fy3VVuTJ1t3QXM+yMtn68czcoMHCumTJPl5/V2sVLegyMyVrVpaekZAGLPHz9TvqRLmPMfbJti6ea8yJOCRx2ppuzMlwb8diC9Vy+LyCoaaEiItSI2YVYL3rSPFc9LjF/BiIZjzV1EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by JH0PR06MB6319.apcprd06.prod.outlook.com (2603:1096:990:b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 06:39:32 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:39:32 +0000
Message-ID: <bc774f3a-2208-4410-bf4e-5b01a6c2e453@vivo.com>
Date: Mon, 1 Jul 2024 14:39:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
References: <20240617024556.211451-1-yang.yang@vivo.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <20240617024556.211451-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:3::35) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|JH0PR06MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb70528-0f3c-465f-e397-08dc99989060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFlLRktyS01qNXJQN0F4SlBBNjQ0bE0zd0RaUGRFR2tObHdVVmJGWGRvK1JX?=
 =?utf-8?B?dTExRFB2ZnFwZkNjSHJXVDlCcTBZVE4wWmtaSmkwbDR4UmhJd0dEMU5RdzVW?=
 =?utf-8?B?WWNXOXJXSnVDbEpkWitFWE50Y2JoT3hPWUJUL0s1THlVdE0zeXR0MmxIcjhu?=
 =?utf-8?B?c2pucjVWNWlWUWxuMUtDdnAzTEtGOWh0QVBRSHJLMW5yZmpqQTBPeHUwQjRy?=
 =?utf-8?B?WU5McjJ4bTYrai9DUmZ5bnF6MjVBTjJma0tqemY4bmE3WXhqNFRIbmgzOVNI?=
 =?utf-8?B?ZEptT1Z4R3ZvU2RBd1gwT2xJaU13Q3ZqeE44QjBlNG00Nm14eThXM0FxdzJp?=
 =?utf-8?B?UGdUNjlqbkVrQTZ6M3dpT01xQjh1Ryszb3dmcWhrekhTd29NRDhCL3UvSDVI?=
 =?utf-8?B?eUdRZG9BTUlSc3czcG9VcUQvU05vVElaL3BCWXp0cXMwNlJRODRPOWQ3QTFM?=
 =?utf-8?B?eW9tTW00WHJ4S25VMEJvcVBXMlc2MDFNa0RSUnVGZWVFS1pzc1BpeElJSEFG?=
 =?utf-8?B?dWYxNFVBVXRxdVR4VkRicXdDZmFiS1VSY3NUK2F2ZTBmY01WVytrQWZPRTRj?=
 =?utf-8?B?cW53emIzcjFPeVMzcXl6UGxXR25XUjByMDJQTjNqT0NGa3pVTHpvN3ZkbStU?=
 =?utf-8?B?Tmg4VUx2c0JUaldyTHdyZk5UVFI1L3o1Wk9yTUg4Ui90d3p5S0hZeExaN1BF?=
 =?utf-8?B?eFB0dFZNNVVBMGdKaDdSTkcrOXZ5enhIMUNhMnFPQkpNNlFmQ2U2V0ZaK3ZN?=
 =?utf-8?B?Mm5XYUlERXc2REZGb3JWQzlaMG9zbDZYWEJNYWNXU0lNenV4SXI2czBvWW83?=
 =?utf-8?B?dDdtSzRYNUcxRnJwZmZ3TktocmhadlFvRDJ6QkxScC9mZDNxZ0ZaQTlUVW5I?=
 =?utf-8?B?MXNMeWpJbGlVWG1kNU1hMm9xMmVOL05zY24xaFJ2ejBXSFNCSndYa1NBQ1ZM?=
 =?utf-8?B?b3dhQkxEMW1zOFB4RkpTZ3Roc2NaRXE5V0JMV0hpUVBtcW1FU0VxZmE4TEpY?=
 =?utf-8?B?RFpyZ2NCUUp5NVI4c3JzQzVCaXV3NDMwWUlrdEpoQ3dIQ1oxUjRZUkt3aXpJ?=
 =?utf-8?B?azIwSmVoWFB4MUV1eW10ekZmU2UzWFRrOHBtL3V1UmZVbWZrdmNhTmdkNytY?=
 =?utf-8?B?cG5MdlBxcnJab3IxdzU1cG9FL1hEWFoxbXNaYm1paSsyYmtHcDR1MnFFbldY?=
 =?utf-8?B?aE5HODEvUHQvZldBM0czVERQT0RlVldZOUdDUDJrTzVvYTQwR0VxeThWdnZy?=
 =?utf-8?B?L1pVYlRPSTV4YTNDbnA1RkVEbHJCODNVbzIzVG5JWUVuUzVNZFQvTG9oa2VV?=
 =?utf-8?B?andUZy96aVVjV1gyWWVTeDBYblhWcEhXaVd2ajNIMkQ3TWgvakswMndCYVB6?=
 =?utf-8?B?cWNxVzdNV2VUd0FEYkdpS1d4SDE1SThqZFpYSk5TVEs1YWc2NnRoT0IyUng1?=
 =?utf-8?B?NU9HK1VXMVdDMXNPeGJVbmpvM3FYYTRGdFFJYmpkakRPTmtOYmJvZmU1UDZ2?=
 =?utf-8?B?dHg2d2Jpbm5KcElHanJVMFF4b1VOS1h3NHNrOFBTM2hvMHRQSTk5UyszOTU1?=
 =?utf-8?B?UlNqRXNvT3o3WGtJZXkxd2VTb1FWelpwWVoyQjRKcGVKOTBqa213aDF5NHZk?=
 =?utf-8?B?Tk5kcHdSMnREWkJLeDRRcjBTZU9uN21OaTFWelBhY012Tm5lN28xeTlRSXMy?=
 =?utf-8?B?MFppQ2kwNytSVGZvS0Z2MXVwZUs4dUxESy9OakVBSmFZSkgyYlJvUHYrS2wz?=
 =?utf-8?B?R1pzNGpWZmx4SEswQXFiSXBEZk54R0tkZEUrMEIweEVxbS9uNWNqTmx5bldZ?=
 =?utf-8?B?aTFhUkRiU0QxL0RsNXZlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVNCem5WdEgrREE1NTgyMnV0bWJxSkdwditkOTZwcDkrQVZuZHhDeWJucEVO?=
 =?utf-8?B?dVQ2MDJoRHhPRXFzMjlqTFJldXlWZ2lNOTZ1YVVoMHQ4VWpvVDdWTUhEem1u?=
 =?utf-8?B?K3BySjlNNlBxcnJwYmxEMVQ0eDRKWVFGVVR3VkRYck9FZkpDcmVqeGlBVlA2?=
 =?utf-8?B?TTNCVXFRZkY0Tm5vRjl5dzN0MDY3RHhzQXR6QzZVYWoyaEpiSDYzTUIyU21R?=
 =?utf-8?B?bjFvL0ZwOXZMNG4zVjdpOHF6VU1qYVlsTU8wQU5LQ0QxTjQ3N1NDQWw0MW9h?=
 =?utf-8?B?YWtJZGVMOVpvT210TnRvY3dvVmdaSFE3WEZ4ZExieU03ek11a1cwbW5GTGtX?=
 =?utf-8?B?OTB0MUozVTNDSzZreWVjMWpzak1UQmE1ek1mTUpTT3pzSkxKQ2ZIUlFURU1P?=
 =?utf-8?B?VnlHdFVsYk8xalJGM2ltMU1idGVzVFZQYlN1Z2drV0VTS1hvT2VsRDFTYkpG?=
 =?utf-8?B?bWQxZG9ac3B2Q2hPS1ZuM1VaU2MyS1Z4S0lWUkZVTTZWSEF1bUJ3VExWeXNy?=
 =?utf-8?B?aVYyMXBHYzZvc1VsNTR4R0NNUit5UmwzRUdUMFFaejgwSFNuUVZFdUptQ1lT?=
 =?utf-8?B?bXhRL1BIaUJGUm5PZ0N6L0FhL09BTGRjRWhtNS92T2lFQUtLVi82ZWR4cXdU?=
 =?utf-8?B?ZVhOUTZOUHkrNGpwclpCTC8wSEd0ZWNmeGJpNng0bVY3Z3QvWTVKSXV0WGZE?=
 =?utf-8?B?RE1zckdpYVh2OUkvZlo4Y2w2T3NLODVWQ2hETkpRYWtDT2FTR1hjK0VCZXhw?=
 =?utf-8?B?SmV0V1prc2gzWlgyTmVuSWx2UE12MGg5Q3kxM3pmcXJUMHR6Z3VZT29rQzF0?=
 =?utf-8?B?eXBkdUxvOTRROVRncGlKNURtVkZPc215Qlh0bFZGTjZ2SEVSb2hOWnRPRDZq?=
 =?utf-8?B?K1VjdXlTMk9BS21KYnFVQlVuUFFKa0xveElJYnNhUVlFQ0ZabmxaMmU5MzBW?=
 =?utf-8?B?TFZzN0VsWWw2aUlhQThmazdYQW9sU2EvdEtYcmsxVnUxSTVkR2ZZVisyWXdN?=
 =?utf-8?B?c2hvWkJQQmVkeDRHQWpTMVZQMnlaUThKaHVGRnV3ZEgrcnRJRmVzZU1XVXBP?=
 =?utf-8?B?b0IyNkhVSllYZ0xDZ0FhdFl3TmgwOStvSVNISFFFSitVZVBXZlJ5N1pmd1Vs?=
 =?utf-8?B?VGR5NHo4WmZwMWdJK1dveWJaOUhjOEt3VTA2YXI5cXF5R091K2RVUjF5aHJ4?=
 =?utf-8?B?djZMMnJLY2tkMkJ2N3pHM2piN254a3U0d0NqNHZvcW0vZmVSTGpKUVdQWld1?=
 =?utf-8?B?ZytlakExL2I0MVRWTHJSZ05BaTE4cXpMRkloSEJqMVZHZFpHYklLTmNGVGZw?=
 =?utf-8?B?VUgvMmRsMHpNbTJkdVFQRzhRczgvTkp4NXRneHlmbnpKRDhsekl5QWNpYldS?=
 =?utf-8?B?QkxVaTJCaHdxbE0veE5xcFY3UHEvV2ZiS1RocFBtSmZYd3RFaVAvZE5RS2dt?=
 =?utf-8?B?WnVMR1BBUVJiNjdjSHdyM05pdnRkQkVZeGNiSWk0aWYrdWcySTQwS2VaQ1dS?=
 =?utf-8?B?NVdoRW8wR1NmdmIyaklSWnM3VVY1YmJic3ZBcTE4S2wzakNubGpDQldoUWg5?=
 =?utf-8?B?emhteldGZ21FOHNHOFA4bTY0Y0p6SnJqRHJYcWZVdWxuc0lxaTFWNW5NWEMx?=
 =?utf-8?B?QTZEbElkZXZsMHAwaTR4cUMrZXNDQi9HUW5raHJxUjJsQlRUdktSeFlZdnE1?=
 =?utf-8?B?VTdWVjhYNTlUNGFYdG8rRFpPSGJZWk96UmFabEpIWFNBcXpDWG4zU1U5MmQ5?=
 =?utf-8?B?OGxEWE95aGJkdExDdkhvUVpBTERPK2E2YlNYZnNSQ2NKSTBDV2NCWHB4SVhT?=
 =?utf-8?B?S1RlczVRb0IxV1dWSkJtdkhrbXlMRnUzRmFZVGNMTHRxVGUybnZyRTVRNkpB?=
 =?utf-8?B?VEptYllGWm41UUxtVC8xcWJpMnJTdVRaSlNLUkNEZEJpb2tzWjdLaVVLTUtm?=
 =?utf-8?B?bHErNUQ5N3NWalhYMkNSUUpTbnV2eXhobG1wSDVrei9MdnliZXBXQWE1VUFm?=
 =?utf-8?B?aG10OFB1OGRpM1hiazYrdkNxRWlnb0hWRjc0a3E4OFJ4Qzd3TUhsS0diTng3?=
 =?utf-8?B?QkQ1ODZUTWN2Z3g1OFN3dHU3dUd2N3FsVnRkeGpkS3lqOFc0TkovOUpjSlVx?=
 =?utf-8?Q?BvGRWLA9CGFnaqfcbnyTAcEt/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb70528-0f3c-465f-e397-08dc99989060
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 06:39:31.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf3USDoPzgXlU9M1S/bjpsu1PMPfUpfPV0vgBI1ksztB1RyRAuSuXzspjfEDv9eLpV7EcadOuswH3PJxL3aoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6319

On 2024/6/17 10:45, Yang Yang wrote:
> Configuration for sbq:
>    depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>    map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>    T1:                                       T2:
>    __blk_mq_get_tag                          .
>    __sbitmap_queue_get                       .
>    sbitmap_get                               .
>    sbitmap_find_bit                          .
>    sbitmap_find_bit_in_word                  .
>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>    sbitmap_deferred_clear                    __sbitmap_queue_get
>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>        return false;                         __sbitmap_get_word -> nr=-1
>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>      atomic_long_andnot()                    /* map->cleared=0 */
>                                                if (!(map->cleared))
>                                                  return false;
>                                       /*
>                                        * map->cleared is cleared by T1
>                                        * T2 fail to acquire the tag
>                                        */
> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
> 
> This patch achieves two purposes:
> 1. Check on ->cleared and update on both ->cleared and ->word need to
> be done atomically, and using spinlock could be the simplest solution.
> So revert commit 661d4f55a794 ("sbitmap: remove swap_lock"), which
> may cause potential race.
> 
> 2. Add extra check in sbitmap_deferred_clear(), to identify whether
> ->word has free bits.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> 
> ---
> Changes from v3:
>    - Add more arguments to sbitmap_deferred_clear(), for those who
>      don't care about the return value, just pass 0
>    - Consider the situation when using sbitmap_get_shallow()
>    - Consider the situation when ->round_robin is true
>    - Modify commit message
> Changes from v2:
>    - Modify commit message by suggestion
>    - Add extra check in sbitmap_deferred_clear() by suggestion
> Changes from v1:
>    - simply revert commit 661d4f55a794 ("sbitmap: remove swap_lock")
> ---
>   include/linux/sbitmap.h |  5 +++++
>   lib/sbitmap.c           | 45 ++++++++++++++++++++++++++++++++---------
>   2 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..ec0b0e73c906 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>   	 * @cleared: word holding cleared bits
>   	 */
>   	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_lock: Held while swapping word <-> cleared
> +	 */
> +	spinlock_t swap_lock;
>   } ____cacheline_aligned_in_smp;
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..9bd85a9b74b9 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -60,12 +60,32 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>   /*
>    * See if we have deferred clears that we can batch move
>    */
> -static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> -{
> -	unsigned long mask;
> +static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
> +		unsigned int depth, unsigned int alloc_hint, bool wrap)
> +{
> +	unsigned long mask, flags, word_mask;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&map->swap_lock, flags);
> +
> +	if (!map->cleared) {
> +		if (depth > 0) {
> +#if BITS_PER_LONG == 64
> +			word_mask = U64_MAX >> (BITS_PER_LONG - depth);
> +#else
> +			word_mask = U32_MAX >> (BITS_PER_LONG - depth);
> +#endif
> +			if (!wrap && alloc_hint)
> +				word_mask &= ~((1UL << alloc_hint) - 1);
> +
> +			if ((READ_ONCE(map->word) & word_mask) == word_mask)
> +				ret = false;
> +			else
> +				ret = true;
> +		}
>   
> -	if (!READ_ONCE(map->cleared))
> -		return false;
> +		goto out_unlock;
> +	}
>   
>   	/*
>   	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -77,7 +97,10 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   	 */
>   	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>   	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> -	return true;
> +	ret = true;
> +out_unlock:
> +	spin_unlock_irqrestore(&map->swap_lock, flags);
> +	return ret;
>   }
>   
>   int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
> @@ -85,6 +108,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   		      bool alloc_hint)
>   {
>   	unsigned int bits_per_word;
> +	int i;
>   
>   	if (shift < 0)
>   		shift = sbitmap_calculate_shift(depth);
> @@ -116,6 +140,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   		return -ENOMEM;
>   	}
>   
> +	for (i = 0; i < sb->map_nr; i++)
> +		spin_lock_init(&sb->map[i].swap_lock);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_init_node);
> @@ -126,7 +153,7 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>   	unsigned int i;
>   
>   	for (i = 0; i < sb->map_nr; i++)
> -		sbitmap_deferred_clear(&sb->map[i]);
> +		sbitmap_deferred_clear(&sb->map[i], 0, 0, 0);
>   
>   	sb->depth = depth;
>   	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
> @@ -179,7 +206,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>   					alloc_hint, wrap);
>   		if (nr != -1)
>   			break;
> -		if (!sbitmap_deferred_clear(map))
> +		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
>   			break;
>   	} while (1);
>   
> @@ -496,7 +523,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>   		unsigned int map_depth = __map_depth(sb, index);
>   		unsigned long val;
>   
> -		sbitmap_deferred_clear(map);
> +		sbitmap_deferred_clear(map, 0, 0, 0);
>   		val = READ_ONCE(map->word);
>   		if (val == (1UL << (map_depth - 1)) - 1)
>   			goto next;

Gentle ping.

Thanks.
