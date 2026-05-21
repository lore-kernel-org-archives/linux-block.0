Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021085.outbound.protection.outlook.com [52.101.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C08367293;
	Thu, 21 May 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330168; cv=fail; b=RAiavjHBsY4enAVFrOqeySIk9vU+iww9nExlywpyVgvtbku0SgSa+X3wPUjSKBw2na4L8iFg0b8uMnoP6OW0zc0Ybnbts3G39L938wG9l9wYn1GW13U9g2lJ0nE5m8gANsQTF4/ySAUIrpG1cKuOkSIEtnORiCliPWd0qHvGJnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330168; c=relaxed/simple;
	bh=nmNWzHgZXVZLd32j3xE3giRRFdQnwsqSUInyS8Fth0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QkvfO3uf6v79qzv79TWVH4WQ9MMWdGlfqLxXFz7yjhPSNh9aMMJH5/I3dX0tJhBFcZJWjJS483+vSe79ia3dnfXiudoVx3JRZ1dAdu+8Fcx5MqWXcS5x9naiDSp7hMEIOK4eTHMe7XN67N4M6lESbwrYuWTGO5Gf960+zyI7x4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpUpNqapnUG1v3R9/ShV0dq/5437pIA3zIdQWiP3um091r+sXbSoHNlow+njEGfvF3ZVgnEv8GI1tdlVVI7Ev0NsPVh3X2MFcrdHXxIXVFTCZUThdbGSDX+IXk2BeI/IoSK9BKRfn3tM9a4IVqm7KSkUwQIuiQrQvDUdBoX/NhGWkUDQS4Bnx6oPghOMNuizhU45eTxiMUD2A2wAX8xeUd983QQa0RFTdQntZmUF07I25BsahUb4g66P60VxovP9FusVwfZWxCF52xsHUSFrfMDZglK1MzlU3C/bW/V7IsmGhKmLAJDKqq4yIhkVdXx/eNIgPT10bmRnVHTKumlvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N161XYlZo7nCxcxU0KuwLc+uCTx1bI0lomrcFLmP9r4=;
 b=KNK2aqdqTAe2MAWEBgSRd0qeTMJbuSSL8zpOWpZv/kZLSYEsP0ERMM3CpVAs0Mnhs0wkEMfcddjMvaJ3OXBgDyodri7TqKq6SpHzWuzUzcDqH3F4jU6jbZ5rh6EiqBcWSqvhaviAthAFomNTVR3l4LTWTbnXggtd1JI/nzC217wGtZD1mbMmQX+MDkerPOq5cczy71Q0eiihd0vfipAkU+psWICGhXRFUJEcV1DUR1vNxpg3XnWsrZLedaMRLJj7vkqkpODP/C8eqLaZ4nzC4L2rKfTM95CQsT6nweBykMxBgRhurLZ06CMniSCMoBTIkiwovQYkqwo6e4JIOAoODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB3280.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 02:22:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Thu, 21 May 2026
 02:22:39 +0000
Date: Wed, 20 May 2026 22:22:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
	dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] blk-mq: expose tag starvation counts via debugfs
Message-ID: <zyxk4twb7oezvrevox67omima2s3ykxhbrlzofykfva4bht4jz@cjkyl2mg554s>
References: <20260517213614.350367-1-atomlin@atomlin.com>
 <20260517213614.350367-3-atomlin@atomlin.com>
 <fc307bd1-2c41-4bb1-8a10-b9ffde685d30@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc307bd1-2c41-4bb1-8a10-b9ffde685d30@oracle.com>
X-ClientProxiedBy: BN9PR03CA0661.namprd03.prod.outlook.com
 (2603:10b6:408:10e::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1934be8e-3b50-457d-3394-08deb6dfd47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003|4143699003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	nq611E3ulQVu7PJj2ThpYGgG730DflsytuZ1iVUEhN9g8GMkD8kjun2E1T1DLYDKpetV1B2as5weAp4s994jh1SCmA4qswt3GyBGrzaA2H19/mLMQZ02ecyTZBOS3mSoJEP2qu5VMr0FL+eV9NCvpf79eVD2d8tzSl+Pia2hjoC63Ytz1p1vygAQ5oBJtA4SQQaEn2LMzL7ea3MsToiUAhWEo9IDzSL9u8kcYTdnnhYNSF0u7lwf6NL1izZ4zNzKb4fVEUEXEh+dG/X9nkjI7q9MXeVW0xqZM2PxanCwIaRBAQyUYTvlNh+zNNsWFS1dJiW1SFBoKyIqbNdRhtLql903wTMkSdZbscjVi33IVYtvgyYGwL9wFGqPZUrCatFFmvzCvt/AxtDdgxw3t0HZ7rFtUFswwZaPdqKKj1Hj9mpdFouMH+05qX0Z8TmvJ8KEILGdz+6Bi+t8JBd79TBB2v3GLHPZh8cXGNsPjS9IKU6L1rd+aWbQRTJQ1dswIpVUdF3EcjumjNtFS+HkFMl1v4XfwhiLSl3VJrfcXWh9qv7vS0Vw1lXkNDFb5U88OG+rXqcko6u9VgPaB7ooaY+Yco/5ishsnt8fJ/Sk1mXKRkpw5EddyfpWIDskgZHdOSWyBoweTNKR1Y5cQFCs8BdIpZbJgfRSXFbvxVuZtvmSlM9XWjkVys+cFmsJ1ItSSBvUEY+zBFFqmnGglcrz0VesBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003)(4143699003)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUdtYmVZdWtXY1VaWjhELzZxSjJFUnlMNW5rV3RNcnI2aW9pMVRFV051b2dq?=
 =?utf-8?B?dUJ3N0ZhcXRYOEsyZmpybXF5dTJlb1ljZEpGai8vSFhTTWVNNjBsa2lqQk5Q?=
 =?utf-8?B?MFFlRmxuWFJ0aG50cW13SUpGYTkvcVozVWpqUCtTZFRubEx2WXBEbkUzLzBU?=
 =?utf-8?B?N1RoQWtsK0x6MU9OYVZiQmttUUJlUUl6dzdicTdHc3NNdmNGL2llci91MEpM?=
 =?utf-8?B?NDZRcFovTjBTVDFveERXeEFIZDhMNlNzZGpGSjE2R1d2Um5XWXc3NWdaY0dx?=
 =?utf-8?B?bnRoOEhkQ3IrWmNndnpHY3ZER3ovUWdkT2g5RU9XREZJUHpPOU9jaTBXRHJT?=
 =?utf-8?B?S1lnK3htaGN6aElJT1E0bURVSlBOcWhuUndsbEFqYUZCbXk3eTlMdjk2bHVS?=
 =?utf-8?B?TjBzemxaa2dabjMrUElVYjBoYnVKWm1IYVhJcW5vVkMwaFpqeHh2ZlFVeERD?=
 =?utf-8?B?bG8veS81ZzNlQW9DMWlNSFo0bGwzb0VrSEkydlNoejVzTXpQdkErYWRJbjVC?=
 =?utf-8?B?YnZGeVVrcTV3OGswNGJ2eHJ0MlFMTnZXb09PdDNoRmdaeGxwdVhwWm52Wk95?=
 =?utf-8?B?Z29INTFtZW9RV2ZNN1Z0RDFSV3VKVUF6Z3FTb2R6L2NJVFYwV2Q5OGcwdnQv?=
 =?utf-8?B?dkYzQXJjeGkrYThjaERrbjR1VWxyUmFiMWtEVll3YzA2aTdhQ3c2M0tuTk5h?=
 =?utf-8?B?UlJ5TVJ5S0M3algzQ2hhS2xCQ2VMT29WUk1BRnVCYkx3azZMQW9HcWRBMUx0?=
 =?utf-8?B?SmJsaVRTTFFZeDM0Z3ozTkFrME1HbHM3NmdsR0Zyam9IcWpKcGorTXNadHYz?=
 =?utf-8?B?YnNMZnc4RnBtaUk0NitvYURKNHd2ZDRXdDdDNXFoRy9FYU84NFJyTWF1VDFT?=
 =?utf-8?B?TFVuQUZtMDNYaTRNY3RhS21ubFdFNVBSQ3Bic3A0NGpCcjBYNnZCRzZ4dWV0?=
 =?utf-8?B?TDZZM25RMTdiYmw5UDYvWDhNaWJtUjc1Qk9QT2JneFdSaWFXWkxNdzJXUmdt?=
 =?utf-8?B?cXU5d2FHSkFmWG5hZncyNVJBcXdzeElpYVZGMHM1bm1YK3A4dHVlMFU1OXM1?=
 =?utf-8?B?OFpmZnRBcFV5TEdNcDUzQTVQc0d5eVBCQUlWTmxSbkVJcDFkYmRwZWd3VDhr?=
 =?utf-8?B?RGY2ZGZBN3NaODZLNkFOekd3ZzRIQjJnSHhGYVZFMTB2eDU5RitmK3BkamJL?=
 =?utf-8?B?SEJtYTFQV3NUQWVuY2NyYTYyTmIzZEQ0RXNzUk1LVllrM1BRRjNrdWpEeWgw?=
 =?utf-8?B?Zm1zY0UrSDVJV0laUzFHWFQ4S0hJa3BZZzBjQkpTWW11YjlkMTNoZ3dNNzRa?=
 =?utf-8?B?cnVHa3VBallxT2NtODVxS2JZZ1M3c0g4UFAzWWNpQ1BMOHk3VEh0OVBVZC9r?=
 =?utf-8?B?dU9PMHc4dlB6dmtKSXdwOENXTFFMT3JoaHlVZWlvcjl3R0dia1lLeWtnVUYz?=
 =?utf-8?B?bzhMbnZYcFcrdFd6eGNZQzRLR3QvWUVKQ08xTVRuYWZoOWduZVJiNy9oVVZv?=
 =?utf-8?B?QmtDbDlzT3ZidkRpcERvb2pLQml1YUFCcWxyVlRIaWVjeGpzb2RFbWpYMzhm?=
 =?utf-8?B?WjBuNHlHVEFIV1JheUl5RG5jVTAwMk9JQXV6SnZ3bXhHb2l2UHg1MlA2MmxG?=
 =?utf-8?B?ZWNWRjJqaHVZajRwOXJ0a1ZwUzIxZmQxUEw5ZHlnQ3RGOCtaUHRWSXhLMWZw?=
 =?utf-8?B?OTUxTHNuTURTOTRwNVI0RjhsaEJLbGxCeUNxcWNtUnJWRkdSdEZMYVRUZ3No?=
 =?utf-8?B?Zm9sV09xTE5xWVFOeEFXWUcrbTJsdUQyb0Nva1hFUmNSUDIrRTdoN3RKOU92?=
 =?utf-8?B?UUVQUzlNKzc1WVBPYVJ5ZzVmcUlHS2R4MmJsZE5ySUJwZFpmZmFxcWdBK3kv?=
 =?utf-8?B?WkRPUy9TbEMzWkplM2FkYlpzNmwxcElXeDhwZ2FrSmRhNTFuWjBtSzJncGJT?=
 =?utf-8?B?bG1ta0dkWDNqdUJJT1B4bDlGTVlER3BYajJSeWhLOFVvVm92ZVAycENKMzZ3?=
 =?utf-8?B?c1hYeThleEdmVEYvUnBWQmJwbDRoODdweWxWcTVjclhHZVdUelJlT044ZjRw?=
 =?utf-8?B?QW1QTzh0M1BqYWFtN2paYkRNQlhnK1c2NEJHRnFRUUJOZU4rRGhQb1RibmRk?=
 =?utf-8?B?S09MajR5d2lxcXJhV2tPZ3NrY2EvV3BLVnRKUW1tSFQ2SFFNaElKVEFJZEN0?=
 =?utf-8?B?VGs3ekx0UUNXajhUcGZCeHBOK2NxVG1NTU81Mk92eTRwcUYzY3lyNU5ZQnlT?=
 =?utf-8?B?SUwxeEZ1aDRtVVY3K2ZrOXhsdE9XQjdIcjExWmFtd3MwUHFyWUQ2MFEzbTN6?=
 =?utf-8?B?Uk9odngvMmZNS2lDRmVzQWR0OU83NDE3Mk1Dams1L3hkTXQ1MGxFdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1934be8e-3b50-457d-3394-08deb6dfd47d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:22:39.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsqqvy5e7lgo+C4qza0ET1bjQdNJ250VZ/cJsPdZYvyVe8591lYszPE2ys7arr3djcHODXASnl3CWgrVSzulPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3280

On Mon, May 18, 2026 at 09:14:49AM +0100, John Garry wrote:
> On 17/05/2026 22:36, Aaron Tomlin wrote:
> > In high-performance storage environments, particularly when utilising
> > RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
> > latency spikes can occur when fast devices are starved of available
> > tags.
> > 
> > This patch introduces two new debugfs attributes for each block
> > hardware queue:
> >    - /sys/kernel/debug/block/[device]/hctxN/wait_on_hw_tag
> >    - /sys/kernel/debug/block/[device]/hctxN/wait_on_sched_tag
> 
> How would these counters be used? You are just saying that we may have
> performance latency spikes and so here are two new counters.

[ ... ]

> > These files expose atomic counters that increment each time a submitting
> > context is forced into an uninterruptible sleep via io_schedule() due to
> > the complete exhaustion of physical driver tags or software scheduler
> > tags, respectively.
> > 
> > To ensure negligible performance overhead even in production
> > environments where CONFIG_BLK_DEBUG_FS is actively enabled, this
> > tracking logic utilises dynamically allocated per-CPU counters. When
> > this configuration is disabled, the tracking logic compiles down to a
> > safe no-op.
> 
> How does one normalise the values which are measured? I mean, during a
> period of high contention, we may get a bunch of threads waiting for a
> driver tag and the value in wait_on_hw_tag may jump considerably - how do
> you normalize this value in wait_on_hw_tag for meaningful analysis?

Hi John,

Thanks for the review.

Based on feedback from Jens regarding this series [1], I am actually going to
drop Patch 2 entirely in v7. 

To answer your questions in the context of the new tracepoint approach:

Storage engineers can use bpftrace(8) to hook the newly proposed
"block_rq_tag_wait" tracepoint. This allows us to track tag starvation
dynamically, filter it by specific devices, or even group it by the
specific process (comm) experiencing the latency spike.

Moving this to userspace completely solves the normalization problem you
highlighted. For example, using bpftrace, userspace can hook both the tag
starvation event (i.e., block_rq_tag_wait) and the standard block issue
event (i.e., block_rq_issue) over a defined time window (e.g., 5 seconds).

Userspace can then divide the waits by the total issues to get a
meaningful, normalized starvation ratio (e.g., "4% of I/Os were starved of
hardware tags in the last 5 seconds"). This is far more useful for analysis
than a contextless debugfs integer jumping by an arbitrary amount.

Thanks again for taking a look. I'll make sure to Cc you on v7.

[1]: https://lore.kernel.org/lkml/t47wegcgfc43nimo4vqfdedqih43ydfietb7tsaobeitxgdhxs@6lnzvbj5rhab/


Kind regards,
-- 
Aaron Tomlin
