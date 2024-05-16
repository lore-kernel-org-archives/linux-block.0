Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE744501A
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847284; cv=fail; b=PQSWyjjgyO0l52aVS3LZzLSpWygCUwcROCAloWVWiNlmb7KjFjrdf+OfTct2W9LfYQWJQLiXuGAE1x0zzlU/9rRrSOgC032IxG6FSrE7fsoXg3pv3KVSJYrPEpr7p5dneDSdyM1pS7qMvMvdhIrK35vpPdm3/dO4mrqTYE8ntH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847284; c=relaxed/simple;
	bh=T0RuF6KTraQRmeNtZCjMHzhEZjkVd4W7l73u9Gi+Ffc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQu6KCl9/u0WgnmLye0R++26CKcIi6cE4TjmIbXmxFOhcmj0cELS3RTnRERrPnp2RlRy7e4bTFowvXjsqTN5ZsjiTkixY0obTcz5Hu1WWr8OEECk6nW7lMlbcb4m+bT/2gXH3qaiza7131aAlbMcDDXW9rF2WkSo5VdhLABaLqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DlmS4xeE; arc=fail smtp.client-ip=40.107.117.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DlmS4xeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuvNpPjv1Fy7nZEP2eaIST4WOq2MGIJ0agEgB9fz4QCGGp1rMC5IB8oS25upoUhiOi93pRC373VwqgBSsF8pf2BAnndYUWyYb2Niu/W2nQXGdKNsOQnsMJ1ll5ipZ6ljxIcBBbhr4J906ncKLmozojHtHkQ/HdRREsblpVUonAeg379nzheKFJev/l3Cx8iFkpVxGGLXJziUxYBxU336xmQA9yppMDAOc9afw9CIKWV5WLyuOOZQa3Ea9qeto/0T8wWR6nhae8yU2C2ndCp4haV7JK24afGHn3RQYm1terC1apMKkqsY+T1h0b9I7iWkW0OW0tmGC5rLQ+chDvq4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXG+WcElvjJU/i5B3UuuMYKkGfEtSKS/NB6jHFGVmTs=;
 b=Ahybnek2IM9EGPJsoXIXz9shUld+oyvwpbIshFcaXohXCGtowfdze5Y2LEIRM/4WG8XUst+T8m+x4Twa2oeTfZ6NEnAST1q7nC9QOxjQleK0elFRu9Gr+bQsPVs2W1vR/me8+Cd2GpXJSdH1dlfJNrPJdC5MRMCzHhG3mkuUYrMI1QqWivMQ/bVqZGZIVFPy2S0LGZsfmH7zMxEnb5F+KCvb+57+ohmrMxihROgbaiZcZgBzoTDLUyy8VL36fZkmMbxrh3lpZ7NO06vrufnXUDhrK4c/TwNKZKCkgocIb3A1KNWfuj5KR4MaPbWg9525XzsxpBdQX1k281fIBVhqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXG+WcElvjJU/i5B3UuuMYKkGfEtSKS/NB6jHFGVmTs=;
 b=DlmS4xeEVx0gL1MzeOkwGo5HQLIquqUvELSVwTA0K5G2maUrxCdVGVQTbvdHLxffCYYt966wEAPQpuckw6dI1ZOPoPI+ZB31WSDjgELrNl7l3whBFBLv6ZMB9enuRpUUrKOMQeN3JniUGm7GLX7SAgP2/W71l7InKRLl39QBO8WGpyv2Q+Ka+dsqJBjSz8X9l+yiJdeLTNtXILcVudbBK0nbvSS3Zlh8S0iMqaqXhdzei2iA+CWiGpq12Y86cq9SsRHxajx43QAnj3UcVEq0WOr5dcIerYeP5AWDBR38OBJvwJNjIFNz7Xn1Z/iLWjJ0AueH4O3OxM5bFxxXioQNHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com (2603:1096:400:42a::11)
 by TYSPR06MB6337.apcprd06.prod.outlook.com (2603:1096:400:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:14:36 +0000
Received: from TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::8e76:5af3:e027:ccee]) by TYSPR06MB6411.apcprd06.prod.outlook.com
 ([fe80::8e76:5af3:e027:ccee%3]) with mapi id 15.20.7587.025; Thu, 16 May 2024
 08:14:35 +0000
Message-ID: <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
Date: Thu, 16 May 2024 16:14:33 +0800
User-Agent: Mozilla Thunderbird
From: YangYang <yang.yang@vivo.com>
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <20240509170149.7639-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:404:a6::30) To TYSPR06MB6411.apcprd06.prod.outlook.com
 (2603:1096:400:42a::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB6411:EE_|TYSPR06MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f82139c-4b16-4922-fb8c-08dc75803960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1lOTGNrM0ZrWFRjcmhDUXZudzl5aVJydWlnUktQYW9BZjc4WWc2czBWb2Ji?=
 =?utf-8?B?N3F4SlFnZ1N3c1lPa1owb1FxTWQ2ckNmdHN0UE8xZEhqQzQ5T1R2b2UxbUZs?=
 =?utf-8?B?UTVlSlNJdnRTWlVlWkZTSTBxcXV0SzhFTDVKUUN0THp6UXRuZ1FsL0lja0kx?=
 =?utf-8?B?K1I3L1JzRFdBU1MxazZ1VXR6Nm02UHVXSkI0ekFtRE9BMGx0ZEp4M3FGYm04?=
 =?utf-8?B?NnFLL2V6SVI2VHdLdFYyTnBQeVFxWTNmWWd6cTdTNU9mSDdGeUZpQzNyMGY4?=
 =?utf-8?B?MU1zdHV6NEZTbFE0ZENjSW5jcVhvV0xCNE1YL0R3aWhHRTlTWWJ2dFNVK1p4?=
 =?utf-8?B?ZzhDZmdjZ1dIbTVKOStXRXpVdFd1K2VSS0RSbTZhVk4rbG1IQkpJY29KODhI?=
 =?utf-8?B?bEIxdDh4YXc2dWkrTUtDSHJOcjd1aUxJRTRubDhOeFliZnB1VHBPV085SUkv?=
 =?utf-8?B?LzRLVDVyY3U0c1hQaFpHcVpMQ3dWVjhDWmJuVFNFSklEdmdJU1BJa2VTTnB1?=
 =?utf-8?B?M1lwRGlKenNmdlAvems4ZTNLcjJLYVpHQ09KMkU4L3dML0gvM0lEYTJNdFFX?=
 =?utf-8?B?SU1DbHlFRSswNGt6NHlFaFBwcEdTczV6dVNwQjRRMTVjTEw5cVc1WmlKKzBK?=
 =?utf-8?B?V1hHcys5TkM1U1ppak9ScS9WVlBZcWExOVV5cmVjVmorWU1zeU9jLzRWTlB3?=
 =?utf-8?B?Y0ZpVXp4STdaSXZybjhhTU9KRkRlTEc1VmNMVVN6a3J0bU44ZVR5bEg0M1FS?=
 =?utf-8?B?YXl3SGVWRFlxaGptVTFjSUFIMFVYK0hSc1B0WkRFd0pvR2tRYnd5M0JMbkRR?=
 =?utf-8?B?dWEwWEVVQVY3UDRsM3VTVVNGQ0ZmRmVaRHFpWTNJbmE0M2lqTWg4QXRsZ1hB?=
 =?utf-8?B?bkdJSkJqWDFHb2ZOVEZPYXl4L1paNmlWRVc3Z05ZNThZV1Q1WTE3Mk9OMVRy?=
 =?utf-8?B?MVp2ZlIva0p1NklsRUdFL3lpUnc2di9lSFM1dmNvUjBSZVBoZGZ3cFNMOUVY?=
 =?utf-8?B?UWdTYnZvRTU2OXh6eHRTZEg5NlJ5Z2pDczhhR3kxQjFadDd3TUJxdnozK01C?=
 =?utf-8?B?QXRLMWNrbWh2bVJqZVFCTld1U1Z3ZDhUN2JQbGk5Q2NoYy9FUi9FWWVMTFZk?=
 =?utf-8?B?bHhZa2xVWEJuRnNHcmM0c3FYOVhKTHFSYkRLb3VsQlB3SFJ6bitEcDg4di9s?=
 =?utf-8?B?TnZxaEZ6OU5yWSttc1ViNlRZN3BqWmdkTFEyN3oxcU8zdGtreG92UGtpenNE?=
 =?utf-8?B?RXQwRERYdnkveUlCbGRvYmpDb29DZkk1emw5Ti80NUV3V1hIb3hyUFBoMzdz?=
 =?utf-8?B?TVhPRHQ3TWpzU0s4TS9yc3FSUTFDQVFlTkRFOHdIVGl3N0czUUl5OWJnN3Ju?=
 =?utf-8?B?UjdQbEFpTDRZa0xKN0pqU0JNR1Fta3lyMXpwUG1IYXh3VW4wcjhQVDlHZkIy?=
 =?utf-8?B?cW5uK1ZGVzJ0VjVFUjVnbmR0bHBvNDY2YktkeUpXM1hZOVozMC9GelJIWExo?=
 =?utf-8?B?RzN5QmNuYUdsQUNyUk5hRWlKQ1lkcGZMdVRIbCsrQnliM3lSTm1RNGlacWlE?=
 =?utf-8?B?Vnp1aWZGNzdTT1F4bDVnbWtXb0JtdVBZWHVGeUkyd2ZoeXAyeWkreTc2THU3?=
 =?utf-8?Q?OEXutECe8HkHLLY6vr3EAenNZZsTP4txTuYJwXMqQo34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB6411.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW5KZFJhcnR6NUdEY1RUTDZlaVJlYUFJYWVkcFpLeUxLVmNNK2M1NHpWaDVK?=
 =?utf-8?B?NDUwM1B2dTYvSjkvSjcxQ1hzWlFNM3gvQlVVNldiVFkzQXJvamRibFN6L2NV?=
 =?utf-8?B?aUV0ci9taU9hMGxDQldoR2dqbGxxZFVRN2kyL3JONVQxaTg3VHRrUlEzYUx4?=
 =?utf-8?B?bTNtOW1UL0YzTlpsT0V2bmlaYTZrQ0VYZUE5dTI0SzZzYVVVL0Qvd0lpUjV0?=
 =?utf-8?B?TTNGZ2x3b1c4Q3VXaTRqR3ZuSk1nSm56Yjd2Um44Q2drWXFFY3ora0toUE8w?=
 =?utf-8?B?dWJYMjlBR3h5S3k1alcveXVnTFNzdjBOYVdBZkUyc0x4dHl5c0xUM0ZOdkd0?=
 =?utf-8?B?VU81aktyMlY0YWFYSmw3Q2h0SVBwM29PNndjVVVRaDRPTFFoeERrOXRrLzZY?=
 =?utf-8?B?Vi9QaHRwY1Fmbk5hakFOc2hCMkRVODhyQXdXYU1HeEI3QTN2bEhjRUExYVhF?=
 =?utf-8?B?SWIxQnNZMlF6MUEzQmtoNXc3ZXByeTFVd2hiOW0wTVBYaCsxQU1WNFg2eW1K?=
 =?utf-8?B?OHpBMGZpbzJUd3dLUUptYUJKSXVHU1RJcndJQnRwVlpteVFLN2N6eHVtNGJJ?=
 =?utf-8?B?Y29sZ2xmTTY2NUJMU0U0cGRrWHFhZFF5TlBpbUdVV2FsdWZISHNvdGMzcFNi?=
 =?utf-8?B?c3JNQWtsanhPWVBuSlNTajVFL2FWYy96L2N1dnlkZ0UrUmlZV1pGNWdraytm?=
 =?utf-8?B?VWdOem14bmlnMHo2ZGhZQWw2bEtFMUMwR2xvSk5NdDI1L2QzR01pTDVwaE5z?=
 =?utf-8?B?OFNvS1JGODkzUmljanhWRUdYcStyZG5zUk1yb084QTgwOWtpbFBOY1lHZ29B?=
 =?utf-8?B?YkNqV01menk0dXpNT3FGR3N3YXQrWmowdm8wa0dBc1RiMUIzYTlLc3U2VXRS?=
 =?utf-8?B?OHVLQTN4SGFiWEVNckw5bkhLSmFicXJldXM2NmREV1BxWDM5cGlwaEI5NHJH?=
 =?utf-8?B?dE5wYW1kejh6QkdSSWZCaW5XejMzOWgwTElJaHZoQjJEUzNXNnpUdDF1YW9F?=
 =?utf-8?B?TWVIOUtWckd4czFFcHlYMDk0M2VSZ0IyK3RVOFpYOEEwSFlTYkZCRUg4SXlY?=
 =?utf-8?B?dnByMkVnYmkzelVXbUI3NjQ3NG9XZ2tSRXhLV3Y2T3JPT0cxKzdiV2ZiUjJ0?=
 =?utf-8?B?V2tvd3VjRlpqUzRNOFhFT2FvM2N5ZHlVR0x2WFVyQUpoVDFTV2xGTzRlWkdp?=
 =?utf-8?B?OHpYci9ibjQ2dHlHZWdZUGxOemlCT2tmb3ZHZjJPOFhYOEZoamhwRE1HSEk2?=
 =?utf-8?B?NUtrVzdNNmVNckd3V0ZQL21yL3dWRGhmd3d3aUdZaVpiMmZNbkt6UVBZUzc0?=
 =?utf-8?B?RUI4NHJVTWt0MzdKSHZ3d3d0TU9iOEZVdnUwK3JpS085aVpFaW1HRUJmQkNo?=
 =?utf-8?B?d1hPSE5pTFJIZFoxeDNKZElXd0k2NlFxKzl5amplQXFDRGl3d0pCdjAwU1JR?=
 =?utf-8?B?dGRyRGtuOW5KUHVmM0ZieW50QkU1M3BRb1RYQ1BSNStYTGFBdFcwaHhoUGQ2?=
 =?utf-8?B?TzlVZmhBcVpEbUkwTHp2c0RzaStIdmM4bHFsaFhGWC9pcVlBZ1U3V2ZaQWhu?=
 =?utf-8?B?eTJvY21FeWwxTnhKSGpTNjc2d0krNWpCOVBsRWFZS2VRTnR4SW5Xc2hQbm1u?=
 =?utf-8?B?b2g5MkFYWk9RbUoxMUV6VytFa0lhYThOSEFoTy9oOWlqWkZlbHBpM0NPM283?=
 =?utf-8?B?YW91SU5TWk5mNU9qQWhMZXd1SjZHZjBFbkNvQ3JKQzhxV2tTWlZ6UmtjSDcx?=
 =?utf-8?B?R2RveWhJRDhUTkxkejhMQ2NaNTN3QkRoRURzZ3RGaUlZaE14b3Z2NHZiRVZL?=
 =?utf-8?B?a0M4aFJuYStBNVpsVGdGckczem11T3orbTVUM2d2YXpHdjlOZzdqTThMSXVy?=
 =?utf-8?B?SjdtRlR5RWxDZEM2OUtCajJNQzdGT3RDc0xXT1FBaTIrbmRQZWRUaXo3ZElV?=
 =?utf-8?B?ZTBrd25qQWxLMlh4NG5RYUdCbnphNGErZ1RvTHFFNHZTR3I0YW1WSXFSSFVl?=
 =?utf-8?B?dHY2QUxvZVdnWkFPVUVMYmtDZ0xwYndVODkzVDhRQ2ZVdDJyZE9MOHVYbkYv?=
 =?utf-8?B?TEwrOFRmNkRoOFJNOXhQUlMzdmJHRmMwekpZcUVMTnNLWTVXUllxakVNYlBV?=
 =?utf-8?Q?o9/YFIigEWCJIutcOMY3cM5fW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f82139c-4b16-4922-fb8c-08dc75803960
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB6411.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:14:35.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/zcu6ypi/F9X64ddLBOIOpfACCNAQh0OlAyciJjCDEqyaWAQ3TQd7F8IGi0wcvI9Kn06Ek9MKLhDt0fJz6xYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6337

On 2024/5/10 1:01, Bart Van Assche wrote:
> The current tag reservation code is based on a misunderstanding of the
> meaning of data->shallow_depth. Fix the tag reservation code as follows:
> * By default, do not reserve any tags for synchronous requests because
>    for certain use cases reserving tags reduces performance. See also
>    Harshit Mogalapalli, [bug-report] Performance regression with fio
>    sequential-write on a multipath setup, 2024-03-07
>    (https://lore.kernel.org/linux-block/5ce2ae5d-61e2-4ede-ad55-551112602401@oracle.com/)
> * Reduce min_shallow_depth to one because min_shallow_depth must be less
>    than or equal any shallow_depth value.
> * Scale dd->async_depth from the range [1, nr_requests] to [1,
>    bits_per_sbitmap_word].
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 94eede4fb9eb..acdc28756d9d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -487,6 +487,20 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	return rq;
>   }
>   
> +/*
> + * 'depth' is a number in the range 1..INT_MAX representing a number of
> + * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests since
> + * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
> + * Values larger than q->nr_requests have the same effect as q->nr_requests.
> + */
> +static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qdepth)
> +{
> +	struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
> +	const unsigned int nrr = hctx->queue->nr_requests;
> +
> +	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
> +}
> +
>   /*
>    * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
>    * function is used by __blk_mq_get_tag().
> @@ -503,7 +517,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>   	 * Throttle asynchronous requests and writes such that these requests
>   	 * do not block the allocation of synchronous requests.
>   	 */
> -	data->shallow_depth = dd->async_depth;
> +	data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
>   }
>   
>   /* Called by blk_mq_update_nr_requests(). */
> @@ -513,9 +527,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
>   
> -	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> +	dd->async_depth = q->nr_requests;
>   
> -	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
> +	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);

If sbq->min_shallow_depth is set to 1, sbq->wake_batch will also be set
to 1. I guess this may result in batch wakeup not working as expected.

>   }
>   
>   /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
> 

