Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011022.outbound.protection.outlook.com [52.101.129.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744814A0C
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052150; cv=fail; b=Ioi8SOl+Z8fSf3MG3e1cYIgNxkEu7OaMft9jkkvUFtyXcdt01HV/eAHtElDBxENyMeu2cuZ9BRjQF14kvTAF52dBhVH9hO3Inx9mWO8UR2dMvtPK/bjxbYzVyG4f2dTm+oui4Hm0IuNSFhsScBDrQaCc3O7SYHhet0jFEDnv1JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052150; c=relaxed/simple;
	bh=yiPe1D7Db4n7BspEdWZPtpj+lO0WROf3ps2aMRlCZQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dxrr/Syt3jVrpH9oQ/NZsI+Kqqz0Ak7/vlR34gorV0NZGvcy+bPqXE37A3a5Qffx55XC2ufT9gTuCLA1DDi52ZMtceytOUwJdu9MowAfkBhlpG70AFgrKRWI3UB74NNEKaALoWhrmvAs64wLP/7Y5AtyZokzJfJcLB2rNBtUuWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QZnpimy2; arc=fail smtp.client-ip=52.101.129.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QZnpimy2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/C/K/Fv3ohmLJNmU0S+APvG7cDXouhmyBnLmNWSJJZe9mTi6QI7kKZcrWew6WFtCsXiHVBzt2urUR1tJGp/olZGgvrny2Ydc16EE0pN4XcM5iYFVD72d28Qt7gEDsWOHNAGgCTT9700FuKydxTwBVZeI6jvz7YXv6l3C1lOqOG2mNWBP65cbkdXrUaeXKNYs4FnfhAGv0O177ZZxxjCl4Re+u7WrC6+/CV78064bLr9Dq8f+x92YElp9OVwe4hegFGbgHUTl+yJ01pAOL6tQ9lRY3cG7vg1XdeGrckdNyZ/J0p90FKOtp+OReHNE2wKYJCOLalG6eRfqJknjvDWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZk+cVYqN5FCDAxImm9+XdVcULTlhwX4DKbdhZFF1oA=;
 b=ic6Efv5TCs54pMdEvo1bSw3VsVnVYaU80Tn1Kw7nlVyMmAIVZokRe0k+OZKWf6VhZtJKchDxB5LWfYCsVrjvyYPCndauGr9KSBX5iftetcnLU4+HyqWNMxkfUWUD255YMCrPKqMNsF3Dj/mVt06RrA5WJsCvtNYqTgdVndZX5FnjNOBMulUkCvssIlkdrqUB4S52AcsxCWM9M/p95/w4vXNNvYq/eIw0DaAS0ws/YIixNfVbGl59Wyd/2CfJfc8QGNSWsz7Bm7cgE1OntPjD9GkXSz/PmPW2UM54EQmccHxn0C0YIpHnazF9aDCz36ygryMCNUTfnx7xeYQjP758+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZk+cVYqN5FCDAxImm9+XdVcULTlhwX4DKbdhZFF1oA=;
 b=QZnpimy2rvR1y+12RgJzknbt9OWseJCLNfBLGwqcSyjdTpvjHHgc5rAtKKIzSiUrXzg6qhh4enzlrhrnRMYW0AjPunC5v3oIprHJgtoQ1e4kCKEMG5EeaY5DUHDN8KGrNBJTtWDxhNAXfauXmDv+8ZpztIb6qZ/RMAMcqrsfYFx2acfUfe143yvkeyzMzKCQo+wyknoJitcdwA3OQ8EsTNP8Ldyn0yhZ4dX3TkWM025C6ZcCZJq0jAo4UTe3CSv6m6/MUA5am9KulFsjhBznDOh8FzlOLLQGMeuFiDxizXoRWB/awNA6fKHmHBO2ysw3vteaJkb3HN7YiyE9xV9qdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB6546.apcprd06.prod.outlook.com (2603:1096:400:458::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 04:15:44 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:15:44 +0000
Message-ID: <490ec709-9c87-421f-ba56-27a394a0d1c7@vivo.com>
Date: Wed, 16 Oct 2024 12:15:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: mark the disk dead before taking open_mutx in
 del_gendisk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-3-hch@lst.de>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <20241009113831.557606-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c61d2e-bce8-443b-d286-08dced99343b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjRZY3lJVFNUa05MT0ZNNExSSmxtNkpmQXpYenAxVVc0NUZUQ2ZEaDJSQ2wy?=
 =?utf-8?B?QVBSZ1dEMGlsT3ZxQm9STjRaSUpLTHhxb3Y1d2syeEo4dEVsY3lnaE5hdHM1?=
 =?utf-8?B?UVhma3JqMWJEUG1hWWlrRWNxRExHcGVHVk1CM2FOMkhGd0wzRzRjOTE2Q3B3?=
 =?utf-8?B?Y2RhQ2l3SStTUmEyZlNmNkZySG90eFlqVG9RK3hWM0UrZ0J5dVhwUFNKaEkw?=
 =?utf-8?B?Mm9kR1ZzLy82VHlVWUZsdnNwYmZYaUlpZVBoVlFROUtxQlJrZ2xMYnE0WnJ5?=
 =?utf-8?B?UzVDTFBVWG5GMy94VFZWbGpJY1o5ZzFoS2hWVHVhcFIvYklaTnEwVG9XVDB2?=
 =?utf-8?B?MWtOQktSZHF3azhmdE5uOTloRTdWaUlvQS8zQjcvUnplRmd3MGtTd0ZVRGRx?=
 =?utf-8?B?VXRKMSsvRVZ6dEkzaWlaMzZQZHVRSkJiRFdocG9BTUVhQWwzK1dtaVVsVURO?=
 =?utf-8?B?TERUT1hZQUkwaUc1UE50dzhzSWpSVHhTeUpmS1k1cHluQlZVWnVNUWhFNGNa?=
 =?utf-8?B?T0JMQnhIUGpFbjVOeUhvNG9mTklITld6dDdwTWZFWlk3M1lqbGt1alA5a0to?=
 =?utf-8?B?aEhjYlJ1UXlIbVBzRGd0R1VGNWhPazlIRFJWejV3OExNbnMwSUpOZnFITTky?=
 =?utf-8?B?Qk9JclNWdDROa1VkOTFnVUVjSGIxUDEvaFpCNGtKTElHdkFONGttUWRINDFG?=
 =?utf-8?B?cG95eGcwSk50cG5LblY3K0JENXFUcmNYOUFPejAzVUtNajNOYUp5YTlLbkUv?=
 =?utf-8?B?K3VNSlY2RE4yUm0yZGhVVXc0MWE1eUY5Q3dOSTRKVUpRUUduRkoySFN5b3RU?=
 =?utf-8?B?aDZKM0R6SWpPNitRYjg1Qk9NdkpPb1paNURuVFNiUVVuSThWdCtMTlhCeTNy?=
 =?utf-8?B?K0lBWmdDbGRNd0Nqcm1ObWdqZFBOZW9GNTg3SWpYK3BVUWV6Q09XY1Q2Yisr?=
 =?utf-8?B?U1VBaE9mQy9KVDVXWWwzb3pCaWVtanNkcFJZQ0tkVkoxNDliRzlKTjd4UVUv?=
 =?utf-8?B?N2V4OWlubDZqMDNsdTFHT2tuN0V0aHhXYmxqQW4vMnlhQnl2N00yY2dWdGl5?=
 =?utf-8?B?WEtEcngxNHpSUjdYNGVDNXA0dDJnZk5uOVRyM2VGYWVhK2p0bE9SQm1SZjR4?=
 =?utf-8?B?b2wzM2xCZWpHL1JGS3M2VDdVUmc2QzFJSERSbnF3UDBRQ3ZmNWx4OStJWEN3?=
 =?utf-8?B?N21panpGMTZEOGw0ekFtU0EvNlRJQ0JqQUJrVWZYTW1UY084YXMrUG5SWGZq?=
 =?utf-8?B?MXRuZ3kvcHljTGRveXl3YWxjbWpiZWFPdHR5dzBJMmdkcWwxaXBsT0dqdVpR?=
 =?utf-8?B?NnhNY2tUanF6d21adHVrcWE3STg5NmpGWTlJLzl0OVRVclgvL2kvNXZQMDlG?=
 =?utf-8?B?NXNlOG9hWDV3V2ZiOEU1a0pqWE8yMjE3dEkyL2JKZm1HVzNKUkRpTjd1Qit3?=
 =?utf-8?B?eURTMytxQmxqK0lzUVJCaVRQMlJqQXNyekw4Y29rUEhTV2tzSGZYbEh2YXk5?=
 =?utf-8?B?aUIvaUZvQ09paDI3T1BYRmMwVnZ3RVIySXU2cHNNbnpXQTIyQ3J0YXN1eUpz?=
 =?utf-8?B?ZTM4TE9EdmlhVE9IM0NoNDRsNnI5VC9OdEV0ZGNoSkZkUFdZT2V6cjdHRmhY?=
 =?utf-8?B?QTBQNmE5UXVqZ3ZCK1NzWTZtUFNhYi9kbFc0V2l6V3ZsYWVjRkpGYnlHSFg1?=
 =?utf-8?B?SWpWTUFRTlB5L05PMjR6b2RBZjAwMkRiMmdMRWpDRzlGQkFxZnNaSFBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmpaZVJuM2xLMitpRHFaZlBYcHV4Z2cwZ1dpakRFUkE1eUN5L2MyamlEQzh3?=
 =?utf-8?B?elRVTHVNV2tRVkZlQ00yNEZtdmFuQkpIU01id2hSeWx6cUtUL2FkdlRJWGRS?=
 =?utf-8?B?eWd4b2xHMVFWV2VpQ1ZrdlVsVGkwWWRlVC9mUnN3dDI0Y3VFWHUxcU11Skc5?=
 =?utf-8?B?aFVrU3BRcnY1VDRBS0dBdGNMeFJJZTBnbTdNWGEyYklRYWVnT1lJbzZoandG?=
 =?utf-8?B?SnFRRGhDQXhwL1Yrc0VVRjRaUDlBdlVlZWNZZ2tkTXY4WE5aNmhJMjQyMHhm?=
 =?utf-8?B?MWFmcytycVRDUDdsUXZ0NGJacmU3bEpIanZBeHpTS2xCcjNjUkV4M3FwTkhI?=
 =?utf-8?B?SytpelZSQUZyQ0tyckFrTVI2T3I2dUUyand5S2ZWOEN6NUN3RmNOa3EwNC9G?=
 =?utf-8?B?eHVPS1BpT25tU2l4NUVodE5vTkRIZ1V1aGJCcFd5dzBpejMycTRwQ2ZOVWVl?=
 =?utf-8?B?dTE4OEpKbnRJT3AwQ3R6Zm12bHloVWJ6MlFvWi9MdkdNcVJiUXhqTnFiYUNr?=
 =?utf-8?B?V3VlQ210RUcvdVpFdU1KNThTN09kWXdMWTEycWVoYTBaL0V2MXNKMWU4R0FP?=
 =?utf-8?B?K2hQZVFKQ25BK2tIZVNLRnlrUm9YMGVxVjVYSkNxVHNYdjJLdmczZzdNVkxI?=
 =?utf-8?B?THNNanRLOS93Y2cvNzNDTFk3OHR6UFh1Yy9PK1c4blcwRllJS3ZoMVhTODFn?=
 =?utf-8?B?RHZMQkVES1RZbHg4MU9wY0gwY2lFSnYvUTE0aTdHbGIra3RzVFBGcnBRa1Vn?=
 =?utf-8?B?MEtkSjBlUUQzVUM5ZzdJRDFPVGVtU1djVGpVWVh6aWxlZWNkZDU5cEh3eGNR?=
 =?utf-8?B?UUlhQm9FeFd2Q1NTVm1JSXVMQ0Z0clRVZDUyOFRzKzB3YlB1TTg3Y3NWRi90?=
 =?utf-8?B?NTE4NUM3R2JUNDQwZmdZMTRFa3djTnFjVHllYU9tRHZrTEwwdis1WEltV1lO?=
 =?utf-8?B?dTB6bzVIbHFrOVc3bkdPUmNIaUJsVzRMMWpsWWRHbi9SQ1RiYVZVRWJ6bkMy?=
 =?utf-8?B?S0k2VkJpNCs1UUZpL1lOT0k4MGN6UzlkV1phaGQwYityRlU5aThsMzN6Ulhm?=
 =?utf-8?B?OEZvdnk0NXViemwxOXpuMlcyTVZxZ2M2K0ptMm9iOTFvdWh5K0UxaEViQU8r?=
 =?utf-8?B?ZlRQQjd4VU44YjRQaGgyQ0dLdnYrVE1Hb0wxbmcvRi95QXkvZU45a1RnQlFH?=
 =?utf-8?B?SDZObzB6T0FTUjExS1BlK1A5RVZoU2JLREM1L2R6a0E5V3I2cnRXQ2tuWndu?=
 =?utf-8?B?cStEakVLWGY1cXlPTzd0S3gyZXV1c2VtbmUwWjFRWjFyR29LUnhwTVFmeU1o?=
 =?utf-8?B?LzBENlhRSDV2dUdZVmk0RDVUdlM1WmcxemN1eFRnNnA0b0p4czlnVngyTFpL?=
 =?utf-8?B?a1BxQ1lCUForMFdKT2ZlUFVhOXNITjJoRjJaQkNnb3h0WWl2enZzN3h0SnNW?=
 =?utf-8?B?N3dOT21zTVdNazB2OVFkd2I3Z3dJVy9Wb0M3MGRlOG5lcEp5MDhYUmlualBU?=
 =?utf-8?B?OTYvN0ZoTkthY20wWng5aklHSjdKb045cVBkRU1aSGViTVlDdTNoYnBNMGxm?=
 =?utf-8?B?ajdzMkxrWXJsK1lITlNnb2RRM3RDOFB2cVlXVUVKNFFtTmtEMnh0bTIxb0ww?=
 =?utf-8?B?ZDNoNkJtZm1zUk9neDhoaldsWXFvZERhSDV1QmsrMnl3cHhZdGRjaXdKRyt5?=
 =?utf-8?B?YXhKd3JKZXpqS3hKWEF6WitYc2x6YzR6YkptQldmTjhqVHY0TVN0QjMrd05Q?=
 =?utf-8?B?NkVNM0czN1pZMHlNaVdnaUsrSGpHVjV1NWFReWEvbjZZSHJFVWcwc3h6eFRG?=
 =?utf-8?B?MmdGaXRxdUsweTY0N1F0SVAwYjd3WmJkTDZ5Vi9TLzlZNFlOeEx5RXUxbmpQ?=
 =?utf-8?B?TmhaRGhVU0R4eHh1UkJhbWJ2SWEzQVRTR2M1RmZoam1nM0N3MjFoalBwcDJj?=
 =?utf-8?B?TGUvamloMDFUZ01TK2xpSTRhUHFqSk1XbHl4NzB6aUdzWjNrMDhZRG4rNWdl?=
 =?utf-8?B?UFEveDZncEZaTDgzVkI2MmpKcXByUVB4VTRBeDJjUlBIOU9CQ21zOUtYa3pl?=
 =?utf-8?B?dE9sTFNHNGphMnZSY2hpVUNoc2FCRGN6L1JiUHFwUkdxNDdna2Y1N1pMa0Jq?=
 =?utf-8?Q?qqn7dQAz83R/ilA7n2pELk9yo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c61d2e-bce8-443b-d286-08dced99343b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:15:44.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjqpF4guHj01o2T8tEvwU8qcj4ts8Pg/QALDipRv6tKisWz8stCSlBSZVcUXEPp+oKQEVFmdU4/e8Ii+XuYR8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6546

On 2024/10/9 19:38, Christoph Hellwig wrote:
> Now that we stop sd and sr from submitting passthrough commands from
> their ->release methods we can and should start the drain before taking
> ->open_mutex, so that we can entirely prevent this kind of deadlock by
> ensuring that the disk is clearly marked dead before open_mutex is
> taken in del_gendisk.
> 
> This includes a revert of commit 7e04da2dc701 ("block: fix deadlock
> between sd_remove & sd_release"), which was a partial fix for a similar
> deadlock.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>   block/genhd.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 7026569fa8a0be..c15e8f1163664b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -655,16 +655,6 @@ void del_gendisk(struct gendisk *disk)
>   	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
>   		return;
>   
> -	disk_del_events(disk);
> -
> -	/*
> -	 * Prevent new openers by unlinked the bdev inode.
> -	 */
> -	mutex_lock(&disk->open_mutex);
> -	xa_for_each(&disk->part_tbl, idx, part)
> -		bdev_unhash(part);
> -	mutex_unlock(&disk->open_mutex);
> -
>   	/*
>   	 * Tell the file system to write back all dirty data and shut down if
>   	 * it hasn't been notified earlier.
> @@ -673,10 +663,22 @@ void del_gendisk(struct gendisk *disk)
>   		blk_report_disk_dead(disk, false);
>   
>   	/*
> -	 * Drop all partitions now that the disk is marked dead.
> +	 * Then mark the disk dead to stop new requests from being served ASAP.
> +	 * This needs to happen before taking ->open_mutex to prevent deadlocks
> +	 * with SCSI ULPs that send passthrough commands from their ->release
> +	 * methods.
>   	 */
> -	mutex_lock(&disk->open_mutex);
>   	__blk_mark_disk_dead(disk);
> +
> +	disk_del_events(disk);
> +
> +	/*
> +	 * Prevent new openers by unlinking the bdev inode, and drop all
> +	 * partitions.
> +	 */
> +	mutex_lock(&disk->open_mutex);
> +	xa_for_each(&disk->part_tbl, idx, part)
> +		bdev_unhash(part);
>   	xa_for_each_start(&disk->part_tbl, idx, part, 1)
>   		drop_partition(part);
>   	mutex_unlock(&disk->open_mutex);


Looks good. Feel free to add:

Reviewed-by: Yang Yang <yang.yang@vivo.com>

Thanks.
