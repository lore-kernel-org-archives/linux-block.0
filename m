Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42B1C861D;
	Sun, 17 May 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779052282; cv=fail; b=ieAhmUZNcGw0vGoFPNL50IH2yyGhEjxItVBvUyKaF0uWTsPQd/v7bh6D8WSDSzUDnI9MHkBiRQKuZk1kusq8Oo/mS37gLINwXbKHz2xO445ZOnEwot0kOhLRf3so/FbIaFulOi7C6uPApdGXAqCky0U+1V9DrwBNf1tXkwtd3LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779052282; c=relaxed/simple;
	bh=Hp3YaYRVmk6at2JfeQJIk6QH1YC2xDThiA+cBrOxSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qIeGOhRuzRIXmZRoG/JmrfTK4AaY1sRSt+0fS7oxgRyFHLojQepACHKoLyVBZkkxTOv4svg9P4HzMnb9/RwABYZA3ZAwFahrht3g9QBffJbG+D3m5en12IBHyig6z8H0w2rMh0uD4Jn6LzxPJEJlDdEuKbKdrslq9INbrH574Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYXTD95YpYt2wTC3C+RzCfYT3DwxStoNJr2gpteFlUOR5maPuALNw8P8hSJGCgbL7RPmtRTQroFmKJTPbdtZ3rRVZqTSHZbbaeMZrLgEDOATSCB1kyEcZ/4Sz2HyJOBFeswn7Hc/2EbGjnO++tuwnq028hHordpmepqoanrcuzH3oflvbbFFn07qFdSwtuZPZz5h5vxGsMUSkFc9JXTt/Lcmat7czasAcvYhOAM9l0yhCvyRmJFeFZyKXgtcoN2eeKe0T/Bc0jI0MS5BA+gq5YAaybF9MOhNfLEUMDbJq/QpuXRwRUdHK2oIOT1sV7sBk33sZtBxjrUyuWqzKYz/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW1tJPuBitAfVl2Zz9cJRwUtzSGFWYVEQH/UPJpIlho=;
 b=hm9MIBa11OTjh30XiuswvJM2XW91J4r3WJYe9UivN4O/L0wKKgVJ9oCtTXFHDnPsv2ysJx+d8xD+WONliXj5IPV4CZdtebnCF4Rz6GkY9v81L9HbcJA2lnuow0VAbTZOPmJPU3hbbbttWnhvwoAA9hLyig0dWL99UzXU9nkSkq2mE4RV6xJQqy9UGn97iw+PvugzgdP8SkR4gl7soygBcM2DR7/0tAKir+yzMBcMVc4GRZFQgXONcvZqWzAsOiA1V1faRw6IZ72De5R4BHzm6Pd2YTU4VOKV4lN3ndjrnN9C83jJ+k/R0ZtNP37m166at3dvMZU44pxURFmxqt3oHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB3715.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sun, 17 May
 2026 21:11:17 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 17 May 2026
 21:11:17 +0000
Date: Sun, 17 May 2026 17:11:13 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
	dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] blk-mq: expose tag starvation counts via debugfs
Message-ID: <w3fwmr7wdz5o667cwa52yrsnujw7bqx3koz5bmtbmtmcnxurof@upu6pdckeded>
References: <20260427020142.358912-1-atomlin@atomlin.com>
 <20260427020142.358912-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427020142.358912-3-atomlin@atomlin.com>
X-ClientProxiedBy: BN0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:408:ea::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9c064d-a131-4bcd-86fe-08deb458d599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|4143699003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ixRpuSL4WYCC3+dgX2ObcaGDLWKTuV/3XF2QddRO7LsYEJjMk74MY6fH3JltjK48tA1fFDFbLLg0oGWRI1EYedc+uiAHrKT+438coPT7MI4IaqDvVb6Jx/EmmBYSHM1SQIewNgXUxSTL7kXGs8AT9wEcDNCI8IJ8HuJBL5w1c0bx62OsAQawVz1fAF6suyfRWQRdgJjPqvyx8IXteFpAwEPlYmbHxppFYrsYwxG4/Dop2INHKtuOloEfFARPwP+kM740wr5kN1fXWLC1/YOElRPKuTHB1g3Njj/2Wu3P1vBw5DmB1AJOnKoauxnD0cA1iBrxsDh5SobmL7nXGn/NZjKsff0bJu7l8QMLMyqUIntqZmcT0CbnfNifTIxJc/37c5UVWfOgAF52k3NhxcI+V3GBaPZsaisCirCYhOx9qmg6FOnk23QeBXgeiyrq3ISOebNMr5yrpM+UiPvWKX4n3D6mJcBEFRpEOs7Ykn4zE2OpQXCRPEu3RqFMmKih7lkEJOxy+xAytQx8fQrzLPnYjkfA3eit0GRfcC+lm7RYL5HV/CKw9a12LX/9MGmCGJbeQKQBA6+w2mtt8knnngyypSL32WzpXs2CCuryX8I+a9go6RK6cQzgbzwLXikGFuIA0a/6bNMGz6X21wVZUQUYHvlpNAdS693oPq7LIaeVkLh8zcZBB6DEO1DkMTRxR4Ct
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEg2NWlxdTNJaVY1YVA5aDFnM1orZzlIRHN5T0ZJTlhZN1A4T3pET09PSzIv?=
 =?utf-8?B?VGQ1eUVDNUJYSEN5MmNiYXgybCszQW9QTitZOTIvcVBoRWk1SmFXNWV3SXRV?=
 =?utf-8?B?Q0JwUm00Y0M5MWZxb2doYTR4QysvSE5ad2pXbUp4cGNqZkkxOTBSbFdCSVBi?=
 =?utf-8?B?bWx3dno3dk1RZ0lrT0J2RFNjMytpYmE2OTZBb3ROZGJYejVPS1FvSzNkb3c0?=
 =?utf-8?B?aVJpcXNhTHdxS3dVRHE2ay9GN29qQzd6WlROV09OS1drVlcxT3ltdkJhb3Jz?=
 =?utf-8?B?L0hjQkRteWNKUlMzU0NCUUd3T0dXYVdWNG43V295NVBkOFhYbmJ4YjVaQWQx?=
 =?utf-8?B?WFlrOWR4dnZaaUFqSjhLMkI4bGtxK0Rya3BoaE5aUnlNWmo4M3FZYjA0ZU9K?=
 =?utf-8?B?d01SdnJzbm42b0haeUhFeVVROGNwVmprelJ6OU1ESkJySGZNeExSZzVpSUtl?=
 =?utf-8?B?bUxnYUhLeEtDeWJHQW9BRHkzTFQrbk9rTUE1d3ZkajdWaDl3ZzR2eHJjRDJq?=
 =?utf-8?B?OGtxVkR5QU5ZWE1KTTFjUS9Hc0ZVOWtKN1gxQzVJSWhhcVZmeTZWZVZtNHRD?=
 =?utf-8?B?V0tBWnhYbFhPU3VtNTFBTWJ5M0dzVEFIUjgvQXlLNkJBVEt5TXZrbDJYck05?=
 =?utf-8?B?c1h6T1N3MjNjVmJsSXh1Q0hzNjU0bXE5UWpqMy9DN2ZXZEVQQ3V1Nm5iRkJs?=
 =?utf-8?B?aU5Qa1RBZEROdk45UEVDdEp5ZW9ySHRHR2k3ejE2aFoyTyt2VnVKaTRzcUtK?=
 =?utf-8?B?QVZxcTQrWUFSUVhWMlFDR1YvcGNDdTM0UURBdUk4YUd3ZEJ0bmo3ZjdvcVNj?=
 =?utf-8?B?Ulp3SDNIeURxUzFhRHUwV1g3b0wvNk9KeFhPRTRrNnNISkM5RU15R09HVXF3?=
 =?utf-8?B?czNQVnBSb1JSR1hCaWsrQjdEUmVFc0VYOGdid3o0Q1ZGdmU4dFVqWEJLK004?=
 =?utf-8?B?V0Z3cHNIVDhzRitvMnVURzlMaU1UMGlua3pjdUpoUXhsOXlscFNJb0hWWmhr?=
 =?utf-8?B?UFpWSW85M1o2QWxZRmQva0ZnVjhLRGpORVdLUVNkM1ZYWlVTdTFkc0ZQWkMx?=
 =?utf-8?B?L2pGTXorZXZBZjRIeW9uYlp2OUtaVEZNN0hESlFZbWhEMEROc1FRSWUrS05V?=
 =?utf-8?B?TzZnVVd5bUVCazJVRzFSeXY4UFlBNnhhNWpoeVRJTHErSjZWUDFtYURKaGdl?=
 =?utf-8?B?SGJ1WVJqVzhxWGxDeGNYYytwMzJmSVB4cFVXUmNobjhnRDRFNTBrK0FLRjI5?=
 =?utf-8?B?NmFDY1BIRXZ1LzQ1YW9uY29YT25QaHdYSVpNNU1wTk5nazdaQlM2T3l6Y3g1?=
 =?utf-8?B?YVlMZ3NxN0l2NWxrSlV0UEl0bUFINCtXS3QzMkRMUjc4NXNoS21OZTB4eERa?=
 =?utf-8?B?dTQ0Yng4N0x3cmNZMmlBRGpTUCtaQm5YTVN1enpBRkN4eExlaHh6U0F6aThP?=
 =?utf-8?B?eDhWV21aajJhU1dQU0NzUlp0TklrODZsRUJqckhlMktJMk85MTFXOE91bS9Q?=
 =?utf-8?B?QjJ4bUlJTVl2L0N3c2dSeVQzakFKRzJROWhYNE1uemkzNHFWM256QWNrT3BS?=
 =?utf-8?B?VXd0OTJZVFVsY1dERnVucXM1M3duenRLekdsbno3UFRHVlNHQlMwR2NFSGl5?=
 =?utf-8?B?alhYdy9BU2g0UEdNZVUyai9lVWZQSERhdklYbDNpVU1KdzdweEZpMmdhWTI1?=
 =?utf-8?B?SGFzdXNVSzZJUElNek0zQjNRYnM4OXVXUFN6M0lpSjhna2dzcGxjdVk4elZ0?=
 =?utf-8?B?dnJlV08xNVduRG9Wa01WUVptYzZzei9WVWJYS3A1MjFzaDdFV09QUWZYWFhk?=
 =?utf-8?B?MW55emhrMWJZTTJzU2pGbHFzT0ZQWVN0VzVON3B0bXlmL283RnNZSi9pR2Vx?=
 =?utf-8?B?U09qeFlQSU8rOWRIejhFVDQ1eFVDY1JxNkVWVlNlOXBrMC9zNUxsc2FYaFR5?=
 =?utf-8?B?S0ZtS3BoM0syNUJpQjYzTmYyaTZNTjNTQ1JuSVdoUktyUStSZHY3Nm9IVHN3?=
 =?utf-8?B?TmxPWU1tZ0cvUmlidjdXczQ3em43RWNmb0dPSUdsOVZma1NKTHpWV0czS20r?=
 =?utf-8?B?OHg2ZHZNRUxyTGtSOEs4SlQ4RXl0SG9NREpBdGtuc3prSFBtOUJWbTVxWFps?=
 =?utf-8?B?MlY5N0F6WENvU0hIbHR4cWIzQ3lWd0p4VW53b05oUTNoYSswKzdDY1c3ZWZK?=
 =?utf-8?B?MzN3ZVNQVGRLQ29sVnlOTHppanNNQ2xBTFZXeWo3LzVKVlR4WnBuYWdVZGZ4?=
 =?utf-8?B?Qkhsa3VMRDFwVDVudUJ4TUhsNjgyelpUVzBsSGNSQlUrSC8xSGlUelgzb0N5?=
 =?utf-8?B?NDRGay9yKzIrT1N3ZmFWeEMxaWsyZlhxcm5vbWxDa1dJS0liYzFoQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9c064d-a131-4bcd-86fe-08deb458d599
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 21:11:17.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fAMT+Q5zV7o0NdB+POLGrOjZYRIX7S2XDV3Wa8n3eGKxGd+YrwZTOoKoiVsezr/hHLTmgpTcmAa/wwD3Htd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3715

On Sun, Apr 26, 2026 at 10:01:42PM -0400, Aaron Tomlin wrote:
> +/**
> + * blk_mq_debugfs_inc_wait_tags - increment the tag starvation counters
> + * @hctx: hardware context associated with the tag allocation
> + * @is_sched: true if the starved pool is the software scheduler
> + *
> + * Evaluates the exhausted tag pool and safely increments the appropriate
> + * per-cpu debugfs starvation counter.
> + *
> + * Note: The per-cpu pointers are explicitly checked to prevent a NULL
> + * pointer dereference in the event that the system was under heavy memory
> + * pressure and the initial per-cpu allocation failed.
> + */
> +void blk_mq_debugfs_inc_wait_tags(struct blk_mq_hw_ctx *hctx,
> +				  bool is_sched)
> +{
> +	unsigned long __percpu *tags = is_sched ?
> +			READ_ONCE(hctx->wait_on_sched_tag) :
> +			READ_ONCE(hctx->wait_on_hw_tag);
> +
> +	if (likely(tags))
> +		this_cpu_inc(*tags);
> +}

Hi Jens,

I have realised that this particular code path, invoked from
blk_mq_get_tag() immediately prior to io_schedule(), is in fact, a
preemptible context. Consequently, utilising this_cpu_inc() here will
invariably trigger a warning when operating under a kernel with
CONFIG_DEBUG_PREEMPT=y enabled.

To rectify this, I intend to transition to the use of raw_cpu_inc(). Given
that this is solely for a debugfs interface, I believe it is far more
prudent to prioritise the mitigation of execution overhead over absolute
statistical precision, should a preemption race occur.


Kind regards,
-- 
Aaron Tomlin
