Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9B2EA754;
	Sun, 24 May 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662374; cv=fail; b=CcebA25xZGi02RCM3kvhBCZ4gqvmBQwgGU4ByYRpwbe0hOt8VnYpKmvnsDl8Rb/a7YlM39ov9hdOaGlameCUhx5PFK3kal6pyiiqJfmsZkqrKoU1Mf7D/x0UyigWnlJ4kfO6I1cITBLXmBIvI1t+oCuD2RrKfqyHXj2smYdEc50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662374; c=relaxed/simple;
	bh=/g4mYWkJvdm38qNHAx4JBK5AOSOSxZ3R2oNUsYYrSZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=trJo/WQNSt+y1cTs50C9EWbJVl8zBwHsxj4gEF2FJ/I9NZEg7doclH6ucYbTmMFBPTn/tkITxv6T5vvghFhyG2kYiQNdlxm2TPXIa9fAjqRp9GuRJ6EEoyYqWwl8TA5WrbYy35wEKZtLFPXlSSiXrhUSlhNB1JZSGa/i7e/gFrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgeh6J/2gDtH+5VqcxDrDcYBUERIg9W3PM2RwT320gUoOKzMoHOqxKJZgu6uLZTSMGpZ6bx1Qh4lnvkDq4MERpDoiScya1CTQWrsTsktAEbvm5OlF9U3TkSUk4N2bBnJgdmSAaVRSNQ0CHLPKwqYLUoVhOM/hOyJo0i3QlDt83BRPdVWIcnO5TWFaztT2q3cn6RhIZNfTMtC1PdDU08uQRzi1FyodkoyACePfGVyrau9BvgF1Tg2RWyWi6fcpxDe5T+WqLDAFor1BzzDbY68hl5IKpVO87OnR0jhBLZ0+P/iV7eylVHXchzD00Dodu5nkldAgXflWZcea0z9OZQgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iedFUtdIDi/L5ChDUbGM9Ch9W79Lbof/bdUZv8wDGk=;
 b=fTsMuG7dSvTgpApFV/hBY3TGcYuxjC0yNtvghop3GJEB7hDce5QT0aUoHQSlO54ZxdMGMPpE4oHBD08pJl77qKWgyJyq9uQGp4dIlSmtgq22xVLXIWR94qtmxuw5BCLFUzs0+hzOJmkAh8EPHDFG8br5B4yeJQ8ZOynHoTvlXA5D5xsiMWRFpiTZ8Bwq98nW1rHueY66SbNbg+lIORHDMw8Q6/g8+c7jffOnrWAZpZkv2xQ3bUfczvkRtGX8xT/nnK/H8TtGWg2jjOfbcn2IqZaQDUyqrSBf/myVLVn6uFvXfDUAoioWRs/efrOJpoypneZYptRGAqQ1iSWkbo55JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8471.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 22:39:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 22:39:27 +0000
Date: Sun, 24 May 2026 18:39:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
	dlemoal@kernel.org, ritesh.list@gmail.com, john.g.garry@oracle.com, 
	loberman@redhat.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <3y7rgqz6h5bssklwmyjqxugwbwctiufagaramd6f4iai4itukl@d3kzd4lxhi4o>
References: <20260524014204.622699-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260524014204.622699-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0427.namprd03.prod.outlook.com
 (2603:10b6:408:113::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: b927a888-3c9a-4322-8bce-08deb9e54f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NSJXRTYGnK94lZX8QevdJpM9e0g+9C6ouCmap9zJRFmrOvDRC5IMpiMfDCNduRiqo1UGUb5o8NfobuuRUIc7Uw219f2VRibm6Qos9iD9qHEl4ReXeIJiUByZE7uf9DSZVmiaesYxH06OqUSxI3PeyWZvL9ytk/CCpZEBmH1ud6y4nSo3EOIrNOxLusTv9faC4FTpfdYAGx0q+rMTMhOWO5apabeaagmhdwif1E7t3/pW+1iRFrHlTpo1DyQ7d7LNn3HsUGrcZGboGKRVbg9QiVn8TpIxP1a40Sxlft7s7GnGAlREyWWYmvW5V3oCg71EgCwETpbHfRkcTzujT8hhg/BZPYYflXTeaN5j1moYPQTD/d0qHBx431dBy4ywgMu/s8fHIxrBFfl2riNT0GJTiE040rHWg3Vy/VwTUl+qaeqYS2WXHfaDAyNQUq2gkejEc+d4GUERrtKEaNaml8dMq9MqWsu0FQWmhjjoaJBYpnimxkgfX+HKqe1KjyPgKjWhaEG0CSSs5MqKImEloTNqhRl928m24zJPyihXlW1j0g8huNJpBl7JmzchPail1KdTPipaAWQvNzXdV5SguZxFA+5YGiyymsTzci5zxfafFi1h1Zi4yP39CkOZMIvWeImLQ0YlmfUA8EbmY1QtEsUFNzRkFnufxrzDODYaXGhsAJ9P5R0C3wvaWl8f+hiT0tUJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnQyTjdjZDhvS3VwWXYzY0VkNFNtZzJyUUR6Rzh1QnFjK21qV2tJQzAzKzdN?=
 =?utf-8?B?aHU1OHhUREF2UUxvclRzaXpoeTJ2TDJxOE44Wk9ndDBPbXVRRUd2VTkyekhv?=
 =?utf-8?B?ck9yQ0JLM0tLWVpyNzh5cDJrcDJsbHVvWnd2dnZ3dmFZVFV6empUamZyY25R?=
 =?utf-8?B?a01qNU1Hcnc5YlFROU1NNVZPK3BZaENDOG9Hbk9HdWNJdEhGNlpTcFloUEJy?=
 =?utf-8?B?bVhaQnZDMVphK0dVWTF2bHpId1ZuVWEvaWtvUCttbGk3cVhiKzJ3ZjNXVUIv?=
 =?utf-8?B?YktzWmdyY2U5NjNrVFVwc2xDOTYwb2k2TEhtc29DaG00TG0xclNFTFRmYUVu?=
 =?utf-8?B?Y2pqV1QxRTF1Snl3ZmFpeDg4ZHpnT2g4RVovUFRCRXN5WjlFU2xTTWNmcFBR?=
 =?utf-8?B?b2RwL0pDdHhJYS9XZWltM2pSdEQ1WjRIMndQQTJ1emRFY0RyenMzcDJBbjhU?=
 =?utf-8?B?V2ZXTTFMUlg2V3JMdHJIaVozNmJpTVk0WVI1OHhPOEc4cG16U0J4L2pOSUNI?=
 =?utf-8?B?ajlRSGJqSmhLdFhPN1dtd3FhUitabzViOGE1VEoyU1RTNW5YUjk3Y1lYUEpp?=
 =?utf-8?B?NVFjT1QwaVM4TUJielpPU1Zpd1lKM2ozSGd0cjZRU3Z1ZzZEand2WTVmN1p5?=
 =?utf-8?B?UzVGeXZubUpOVm5tMHBvdlRCa0Z0VjFiaUcwWW1oN1NzS0diMnlVajg1dm50?=
 =?utf-8?B?OUowNjFJcjlCZ2dmUnBkZW5wS1lRVVZoVjF6bDVYMlFYcUdNNCttSXlMaEZW?=
 =?utf-8?B?RVJKa3NZWkRtQkRCZktWanZBUTVRZkVQQXRaNXI4VjdOb3VKMC9BODdoaFhD?=
 =?utf-8?B?TGlWMGJKQityV0tNcGt3K0g4TzZsRTE0Z3pTc0NuQzhxK3BDSnV3dVlJd250?=
 =?utf-8?B?dWV3ZmVQQ1FLUktsakdYQStCbEJrdE5ZZVhsUDBOTUlvVXFKTksvZHBudm9h?=
 =?utf-8?B?bVJFd292MFBEUm0xNkV4RHZMM3NSZ0kvUEJ5clBVazhMSEsxZ0ViR2lSQ1k3?=
 =?utf-8?B?T2xSQThHaWtXSU9kc3JQcTFOKzZha1R1eE5VQW15M0haR3ZCUjZ4OEZ3bURS?=
 =?utf-8?B?aUhJSk56NFlyTmN1c0E0N1RqaWIyY2tXdlVDWGcycUVZV0VsZ1JmWUR2TDFV?=
 =?utf-8?B?MGJtNzVxSXRCbkVibE1ka3JsalV2SXNKd3pVOWFSWUViZDdQT0JaUlZIN05Y?=
 =?utf-8?B?SDZ5SXZUUjRZQjd0ckwyY3gvSy9WNnZYZ3JxblZhUDdPQmk2WC9MWHN3dDdW?=
 =?utf-8?B?czJHRStCRmYzMVo1UncxcGhsZWFlaVVXSytCRENrSWw4d1p4MXBxTU5pdVVO?=
 =?utf-8?B?c2gybm5xRERRK3dJVXl3MmFkdXBaTDV4RkJDWjBqU0FwRVIxdk4rd0k4VmJs?=
 =?utf-8?B?Yit6UzU3UENGSE9jaG52bXZRUlZOTkk5dWdRZWdnenF0VkxtYlhCVWRyNmFL?=
 =?utf-8?B?NXFPTFA2ZXcwQjFtbGFhKzhCa214N3N4Um1hSFlHc1dpcDBmRFFvajN5Njdx?=
 =?utf-8?B?MHN2bVkzemNidjMwdnlrblByeXJFUzN1Wkpodm1RTitCVHZnYWtIQlhCY28y?=
 =?utf-8?B?alNiWFhBeVVJM3ZrNGYzSkprZ29oeVdlOGcrYS9abklEYm5iSmNTb3QyenFD?=
 =?utf-8?B?MXB4Q0lEK2JDdDNPdDZ2WDdiSlRKTytwZE0zTUZNaUpVVzFCQ2c0VzNhUElE?=
 =?utf-8?B?cFN4Q0NSb1lyRVNGN2tpNC8wZVNkdkV6Y2QrZ0JrM3B4NW1tWHY3Nm5IOHZT?=
 =?utf-8?B?Ny9tRVZONEJVak5GSzBqNU02Tk5qWGlpQzY0ZnprSE80WlRqc3VNaGM1Mkxz?=
 =?utf-8?B?QXA2akdJMUR2c21LcTdUTUFpaDJ5Vk1wOG1HbUtveW5IcHlnWmxSS1NYZStM?=
 =?utf-8?B?MkRLUkZWWHJoL0tDZDhseXVtTGI3VDZ2UjFQSllZTGdpNFgxMnlWQmt6YUNU?=
 =?utf-8?B?Zm5aKzZzRzloOW9Kd2xFQVMvL1lvNjhNVXBKQllYT0plMU16cFllNmJNajcv?=
 =?utf-8?B?UE11U1RNT0V2cmprNmJsVElWZkFQcDBKOE5ndHlGRUxhelNXbmpwR1pSZllX?=
 =?utf-8?B?cTZWaEhhYTB3LzBRcGM2UExoc2tQcHJiVlZjSWk4OVZud1JZRXVnR2J5Nmtx?=
 =?utf-8?B?OTlIc3RiR1J0QWRjTWNnbCsyNkNuRWxIUUJyWERxcHJJL050TnNUeEJwNG5w?=
 =?utf-8?B?YjFCRGh3cm5DUmFwVlhUbWRMbnExVXBlYURudW5OcWpTNlJ1SkM5U1VlMjdV?=
 =?utf-8?B?b0lIMGRCU010VkRTaUpLemZsZGFVQnFJTE9La0JoQ3ZGQVpJVlp4azc4RXp6?=
 =?utf-8?B?dFBtb1ArOFJ1QnhzSGdzNVhuMG1QNTNxR3NnWlJMd3RJZmxCQ1hSZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b927a888-3c9a-4322-8bce-08deb9e54f92
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 22:39:27.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwKu4huPouYuEi4iye1iL3I7zm0qsfvBrRY/A1x70ZBbvWjGEUlE4e5eh9Q/xNBbUZ25a/ggINf5t7OE1e8+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8471

On Sat, May 23, 2026 at 09:42:04PM -0400, Aaron Tomlin wrote:
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 6aa79e2d799c..736e176f6d17 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -226,6 +226,61 @@ DECLARE_EVENT_CLASS(block_rq,
>  		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
>  );
>  
> +/**
> + * block_rq_tag_wait - triggered when a request is starved of a tag
> + * @q: request queue of the target device
> + * @hctx: hardware context of the request experiencing starvation
> + * @is_sched_tag: indicates whether the starved pool is the software scheduler
> + * @alloc_flags: allocation flags dictating the specific tag pool
> + *
> + * Called immediately before the submitting context is forced to block due
> + * to the exhaustion of available tags (i.e., physical hardware driver
> + * tags, software scheduler tags, or reserved tags). This trace point
> + * indicates that the context will be placed into an uninterruptible state
> + * via io_schedule() until an active request completes and relinquishes its
> + * assigned tag.
> + */
> +TRACE_EVENT(block_rq_tag_wait,
> +
> +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> +		 bool is_sched_tag, unsigned int alloc_flags),
> +
> +	TP_ARGS(q, hctx, is_sched_tag, alloc_flags),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
> +		__field( u32,		hctx_id			)
> +		__field( u32,		nr_tags			)
> +		__field( bool,		is_sched_tag		)
> +		__field( bool,		is_reserved		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= q->disk ? disk_devt(q->disk) : 0;
> +		__entry->hctx_id	= hctx->queue_num;
> +		__entry->is_sched_tag	= is_sched_tag;
> +		__entry->is_reserved	= alloc_flags & BLK_MQ_REQ_RESERVED;
> +
> +		if (__entry->is_reserved) {
> +			__entry->nr_tags = is_sched_tag ?
> +					   hctx->sched_tags->nr_reserved_tags :
> +					   hctx->tags->nr_reserved_tags;
> +		} else {
> +			__entry->nr_tags = is_sched_tag ?
> +					   hctx->sched_tags->nr_tags :
> +					   hctx->tags->nr_tags;
> +		}
> +
> +	),
> +
> +	TP_printk("%d,%d hctx=%u starved on %s%s tags (depth=%u)",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->hctx_id,
> +		  __entry->is_sched_tag ? "scheduler" : "hardware",
> +		  __entry->is_reserved ? " reserved" : "",
> +		  __entry->nr_tags)
> +);

This is wrong.

If __entry->is_reserved is false, the current logic incorrectly reports the
total capacity pool depth (i.e., both reserved and standard tags combined).

I have refactored the TP_fast_assign block to evaluate the reserved status
orthogonally, ensuring nr_reserved_tags is correctly reported for I/O
schedulers. Additionally, the unreserved pool calculation has been fixed to
accurately subtract nr_reserved_tags from nr_tags.

I will include these corrections in the next iteration. Given the extent of
the functional changes to the tracepoint assignment logic, I will drop the
existing "Reviewed-by:" tags.

-- 
Aaron Tomlin
