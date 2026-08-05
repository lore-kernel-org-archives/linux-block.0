Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC9481A8C;
	Wed,  5 Aug 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946990; cv=fail; b=E7tsLaK5Q6KnB/WkXuY+v1iHH0YC2lWa3ooAUxqzKexLzpvJu6X4laYHgMfUymCXzFvualRdOPfgKJ2F77qz/iK7nExBzLzcfr95uWOhs3MBYYAxrP2CLcpx5LPOVSaGEgV8bny6SeDiVb60pgDYsepTqkUv5qfMylQRno3PeR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946990; c=relaxed/simple;
	bh=yfk8UE9p2pCkMMQr0KezJNXyZex+fM7AlMNkxnXfcFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uVzlkHKYv4vIlTDKRfe1X5Ir+anEZq4s/xO9nzpVnnvCxvq/nthGTwAOycv3oy3mJCQNqyxT9zVPMlfL7a+hyXuGiFJW47r/A9YhXT4YRb1ExYP+pWawW5qhsiN02b71Xp6bNj8JB8SBXRGzFppofC7JT3JqlFopyuRe2QyRv+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUTZl145GeHcd+SDvVYOk67psWlJYfMhWanMcpzCn02WBEkjcC+0bS/FE+/GbAJ3c8t4N5slyFtwqYmT8DBOPzyv+lgIXa8O1sjTt8XPAFo0TzFjtKvHkCgtHtqIheBlT7VBoVsQzxh6XYsKttwl0LdeoN0vMk1O5dWn9oSZIskO2SUZ1CXZsZuSpIje743gLGkjdSUcjIGGrnuNHqrFpXfYh3+Djk4XTLEKY7yGf12X3cuEAKb9BWjkESELvk+0ZUtra7YWxZHCD7tiPCyBRQvdrMfQBTlltvqUXbVzEyLUJDuf/qgCMbNUEiw3uuBkAH+w0RlCnjuMryf2LITUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=D51UVcz1uaVe5zEzomDji8497e5hgBojpYuJphdP+1g=;
 b=gN7PRVooD4kBEyX1TE5azSPSVDThy96b8/3PqHlWMWbT7FPs36P+RWn+MHMfMVX47qAaezBxGvaWKH2ZjGzB9gH46M8ZgO8Lsw2E2tLAzAWjafGZDt/1RGubijZ7M1Anf2Oxh3rT15C3LqByIYUDYOg363ThhDr7tJLu0GIb789ZRldZaGib1Lwm3NfonU6Pd5+D/wVSK3OKT6zBXsSkKWtZTA3Cg43ARtu1cN9ciD7Q07F6awMZt+qW8B0fkSYvFiVFixnz/fZoE3r54OU/0mI+iJC8eDmGEXzzBmJYG/+gf3IaeJYigkB2wZ9ZmM+XUjvqO2bzXOtfDlmQI+DuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:23:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 16:23:03 +0000
Date: Wed, 5 Aug 2026 12:22:59 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, 
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 8/8] docs: add io_queue flag to isolcpus
Message-ID: <xjcwes5caiwh3eumqfuvankokb7wzzokleqfkfmkh5sgl333sg@nwlgqvj4vdet>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-9-atomlin@atomlin.com>
 <20260715102535.STkb5tE8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715102535.STkb5tE8@linutronix.de>
X-ClientProxiedBy: BN1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:408:e2::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8fb3d4-7093-488d-10bd-08def30dd2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|5023799004|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Lm8QC7yceKcMdT32e7seiQsAkTrGb8a3D00I1ap4mfnF6nfaoynbDfLMPQvReUvR1lbq9B5DQDJBGgLa9C1sYytlvjzIAug27yTgk7wOx8++fUof0CvoYVRjZ/eM4VFYnD1XOFDkd+NTLG6n4QvKAY4dcwgP7ojw4GArT189/W1OSrEati5RR+3AlpUudCpkVHhxHLFL4Ec0rgwHav3lo9fHOSx7Np6g+PjYkjykV3p7nXldS4PZQQjenL3NUWZ3w6IOWtgQLe4IvUdooWLnEZmnCOeXT1KJFQCqGIncZQsJW0wY/yP026CvtDSrL12DTfK5h+hVa9/X7SbbKFC9VZlfc6UAK1Mh3VbatOyuTBxAV38F9o+8id4CcJdDq1i0YV9jU9rO+mxbv+qiVlym8/j6YZSkdQU1hrFbOtM04Gomz/BWXI+5JvCf4aN6QQUXXn0goDaWNQxrxESY/zq/5aiWKGP22vTJ8WGbsnYNboLF7zBUOIsXyVzl3wrceDJNvy1EmapQvQHVpUpJffCzRKutZmYvyrwYhU+4nPrSFaXm09z6UU44ChXrwPfhYC0SGK4FDHGAqQVBUlypWk5Jfmw4S9h8SdKs7O8ayXIY/eqsTHwWTU++gACjFBYksObNKU7RYgQLWr+ELLBQl/z85wG04QvrEBI/fQLVfKx0Ltw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUdoUnlmUkJ6SklwVkNQcEV4ZkVWbG9YTDNkRkFIQkFrTUFSc010S21CaGg1?=
 =?utf-8?B?aktlakhOZnZPTHNqYytqWVdWV0pjVXMwa2pRU0dNR3pSSU1vcy9KSExkNFJT?=
 =?utf-8?B?VG8zdkYzTFYwcGk5amJoYkxSeG55a0QyVi9CWXYxUitWZ0htem5BTGtCdExE?=
 =?utf-8?B?MVJDWnVaK3ZrTzZIRnJaQ1NOYzdLUk1Kd2pTdFo0ZUVET0tmT3NKMDFNSjdp?=
 =?utf-8?B?ZWYyMjlYeEZMVHlmcGFZOW9ZQnVjN1pKdDdvMzJGL2crZFVTdnJHT09WaE9x?=
 =?utf-8?B?Qlkwem1HQytmT1hkdTRqeEY5MGhWU3o4Z3Nva1IyczQzRWE2NzVJQTV6S29V?=
 =?utf-8?B?b3hZQzVQckY2cXVHR1JMVW9oNFVEMWFuTEhjdzNwdm1icFJ1MkVyNEJqcW44?=
 =?utf-8?B?T3RwM1pGM1g5YXJzNExBRU9oTXlsQ1k4M1ZKRTkyUU9jNmk1L3ZYS3FUdTFU?=
 =?utf-8?B?Z0E4ZDBjUVpmdS9XRStWSXdqa3dqZ0tzSncwMExGWGdneWtWaU1IVFkybm9K?=
 =?utf-8?B?N05STGs0OHJRMEx6a3VpTjN5Y2M0T2dqSVlCRW5YZlVLWDFiN2xDUUpwYkJv?=
 =?utf-8?B?T2NCbm5LT2cwT2p5Q3hlYnlnQ1RJaUYzTnFxSU9XSmNXeURuQWlPL3VwYVhV?=
 =?utf-8?B?Rm95U3oveHJzRFdvU2ZCYkVTRVhwUGhpNTlKeVZQWkJucDFxeFpjRi8ydDda?=
 =?utf-8?B?SUNGWFVuakpkUGdjc2swZzNFTy9kMEZ1MlAwU2xYaTJnT3ZCZnhhVnB3blFk?=
 =?utf-8?B?OUhZdDlXTTZ0RTRSaThhVUFLcWpZa214L2d2MkJOL29OR1JuZ3o2Y3VPa1Ux?=
 =?utf-8?B?UEFVT2xGQU1vMkZrSUZZY3dWZVF0eUFSeWFyRzdPemVZOUF2K1ZqUXBUVTA0?=
 =?utf-8?B?TktQK2UyNzAxbHpRRFUzSnMwQWtTeU5Wa2ZQb3RFaHhRMzY3K2xpZDJRS0lM?=
 =?utf-8?B?ZFVNb3pOZHlwY3pPQk9mb015b0QzVkN5WXlVbnFXQVIwWTY1MGJReWVlZDNX?=
 =?utf-8?B?OVNER3Z2Vis0ai90OElQRjRualRSZ1VBa3Z5ekVFdmR1a1BvQUQ3TEt1N2hu?=
 =?utf-8?B?MFN1d2l5TmZxQnF0REZ3ZUhYOTJnWERpdjhPemwrdjBEQnM0VzFKdUcxekd3?=
 =?utf-8?B?WVlnd2ZzTXJYMmRQa05UTVJZWFhqTjdnTmFKeCtEUjM5Q3ZZUXJPa2JVQ29I?=
 =?utf-8?B?enJ0eWV3STdTVWV1R3NFYjdTNTZLUlZOM0tlTjJ3bmp5NnlRcmRXMXlYMEli?=
 =?utf-8?B?M2RSc2NWak5nd3MrZkFVeUFxSVE5czRKZUNiMEw1NmFlY2FCM2FuTUFwNkwx?=
 =?utf-8?B?QkFrMnpzYmZpSTQwN2ZNQUo0czRFbWozaUU4SFJBTHp2VDhkcjNBekRiR0hZ?=
 =?utf-8?B?WXJlYXJSTEJTeSsyTXpuZDREUnZTOU5jSGU1ZEhjcTRFK3FrMTRvQktXSVE0?=
 =?utf-8?B?dnAxeVVMN3RvZjR0Mk9Qd0NuQ1BkT3hpVkxRMFlnSmlXbjdhM1VMUkhIVmpT?=
 =?utf-8?B?UksvSHlvaVM3SzBMTkQwYmMzV0d6WVNTUG8rNitCQmM2VXdVQVJUZnViSjBN?=
 =?utf-8?B?MXVkTlREMFI5NndvTEVIMUU0MURKSENyRnZqcmFQa1pNN2JhQlpXVHkybHJW?=
 =?utf-8?B?ckNoQisrNlNpODFRczZqaHhOazI2S0dReFYwUlorQVVTdTI5cWxlZ3c1QXFp?=
 =?utf-8?B?MVVPL1g3aHh4NUkzblA4ZGZ0N3ZFdzVJOHBBbGN3OEJUc3FVSlR1VTRYZXlx?=
 =?utf-8?B?RmxQeWhUc1NaR29WN25zejZLQjREeC95SWt1eDBYQWVvSDIxeW4xVVhLbmJk?=
 =?utf-8?B?bFZCd01tLzBSU1V0cGx3RVlDYWdYb2FGOGJHWTRNUzlUdGhNMFpTNXArTEVy?=
 =?utf-8?B?WFE1a0pCdXgvNEtWWkhiQW1oRjJxR1c2MzlsckNYWUlUT3pTQUtadERteGJ4?=
 =?utf-8?B?MHczdFYzUGRzcEU5bjZHQmpYV0ZxblZqeU1HbGJyY3VOcDFIbnVVaTlQUGZI?=
 =?utf-8?B?UHMwdHFTUHAyTkZRaDJGNFZMSFQ2MVBsT2Y1YS9UNldVcGhUaWErUjZjdy9R?=
 =?utf-8?B?d2dNWU1uQ2pzWG1sbGJOTmtzSyszSTJSR2RkS2I4WVFjSStYSmRKTll6cmxT?=
 =?utf-8?B?L1J0WlBGTXczWEkrNWg3ODViUFpVZzhBcXoyYWdiYkp3Vm4yd0RudWRTTk9W?=
 =?utf-8?B?b25odWN3WGJnUzVCZFFKbm1jRkJ5UDhwcHloUEtYTzBvdjQ5ZlJwa0NWQkE4?=
 =?utf-8?B?TzhuZlFzNjJ5dDY0WDdYWWJ3SUhHT3dod2hBNTV3emhZTVpQSmFkbXZWaGRR?=
 =?utf-8?B?MnBoRXU2UUI4Mncwb3pteGRjbEZGbXJzd1ZOVWExaWJYdld4MGZjQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8fb3d4-7093-488d-10bd-08def30dd2ed
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:23:03.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScU6ylVoxgaqGutiHEmJHg+ROLqOk/Y6wlM+kaFXuey3YiCaTGUKuRPeL9DLYvOwlCWK2XAR3+0LTxQCl/EVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6281

On Wed, Jul 15, 2026 at 12:25:35PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-21 19:29:56 [-0400], Aaron Tomlin wrote:
> > From: Daniel Wagner <wagi@kernel.org>
> > 
> > The io_queue flag informs multiqueue device drivers where to place
> > hardware queues. Document this new flag in the isolcpus
> > command-line argument description.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > [atomlin:
> >     - Refined io_queue kernel parameter documentation
> >     - Removed an inaccurate claim in the documentation stating
> >       that io_queue takes precedence over managed_irq]
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> From high level, this looks like managed_irq with the exception that you
> can limit the number of assigned interrupts while managed_irq is best
> effort. Is this true or do I oversimplify something?

Hi Sebastian,

Thank you for reviewing the patch set and for your feedback.

Yes. Though the underlying mechanisms differ in a fundamental way between
the two flags:

isolcpus=managed_irq (post-allocation, best-effort):

    managed_irq operates downstream at the IRQ affinity level (i.e.,
    kernel/irq/manage.c and kernel/irq/cpuhotplug.c). It attempts to steer
    the effective affinity of already-allocated IRQ vectors away from
    isolated CPUs. However, when a multiqueue storage or networking driver
    allocates one hardware queue per CPU, the affinity mask for an isolated
    CPU's queue contains only that specific CPU. Because the intersection
    between the queue's mask and the housekeeping CPUs is empty,
    managed_irq falls back to assigning the interrupt to the isolated CPU.
    It is therefore inherently "best effort" and cannot guarantee isolation
    for 1-queue-per-CPU devices.

isolcpus=io_queue (pre-allocation, strict constraint):

    io_queue operates upstream during device probe, MSI-X vector
    calculation, and block-multiqueue topology setup
    (irq_calc_affinity_vectors(), irq_create_affinity_masks(), and blk-mq).
    Rather than attempting to steer vectors after allocation, it caps the
    total number of hardware queues and MSI-X vectors to match the weight
    of the online housekeeping CPUs. Isolated CPUs are strictly excluded
    during initial vector mask generation (group_mask_cpus_evenly()). I/O
    requests submitted from isolated CPUs are routed through shared
    submission queues mapped onto housekeeping cores, ensuring completion
    interrupts land exclusively on housekeeping CPUs.

In summary, while managed_irq influences where already-created interrupts
land, io_queue restricts how many queues are created and how the hardware
topology is constructed.

I hope this helps.

> If so, can this be integrated?

I do not want managed_irq unconditionally enforced vector capping. Instead
of creating a standalone HK_TYPE_IO_QUEUE housekeeping flag, the strict
vector capping and mask restriction could be integrated under an opt-in
flag?

How about an opt-in flag:

  - isolcpus=managed_irq
        Keeps best-effort post-allocation IRQ steering without capping
        hardware queues

  - isolcpus=managed_irq_strict (or managed_irq:strict)
        Enables strict pre-allocation queue capping (i.e.,
        irq_calc_affinity_vectors() and blk_mq queue limits)

If the preference is to avoid adding a new top-level isolcpus= flag, I am
more than happy to refactor io_queue into a strict sub-parameter under
managed_irq (e.g., isolcpus=managed_irq:strict). This probably makes more
sense.

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 4d0f545fb3ec..fb828bb60b9e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2815,6 +2814,31 @@ Kernel parameters
> >  			  housekeeping CPUs has no influence on those
> >  			  queues.
> >  
> > +			io_queue
> > +			  Applicable to managed IRQs only. Restrict
> > +			  multiqueue hardware queue allocation to online
> > +			  housekeeping CPUs. This guarantees that all
> > +			  managed hardware completion interrupts are routed
> > +			  exclusively to housekeeping cores, shielding
> > +			  isolated CPUs from I/O interruptions even if they
> > +			  initiated the request.
> > +
> > +			  Note: Using io_queue restricts the number of
> > +			  allocated hardware queues to match the number of
> > +			  housekeeping CPUs. This prevents MSI-X vector
> > +			  exhaustion and forces isolated CPUs to share
> > +			  submission queues.
> > +
> > +			  Note: Offlining housekeeping CPUs which serve
> > +			  isolated CPUs will fail. The isolated CPUs must
> > +			  be offlined before offlining the housekeeping
> > +			  CPUs.
> > +
> > +			  Note: When I/O is submitted by an application on
> > +			  an isolated CPU, the hardware completion
> > +			  interrupt is handled entirely by a housekeeping
> > +			  CPU.
> 
> This is named io_queue but it does affect I/O in general unless the
> driver uses managed_irqs. This may or may not be clear to the user.
> So the io_queue might not be the perfect name given that affects alles
> devices in the system. We do have just I/O devices using it right now.
> 
> I think this still deserves an explanation in
> Documentation/core-api/irq/managed_irq.rst like how to use it, what is
> the expected outcome and how does it interact with the managed_irq
> argument. Does it make sense to use both, is it exclusive or, what would
> be the use case for both arguments.

Regarding the name io_queue, you are correct that it specifically affects
devices employing managed IRQs (i.e., NVMe, SCSI, and blk-mq devices).
The name was chosen because its primary operational objective is to shield
real-time and latency-sensitive isolated cores from multiqueue storage and
block I/O completion interrupts. Non-managed IRQ devices continue to be
governed by standard irqaffinity settings and irqbalance.

I would be happy to provide clear usage guidelines based on the above, if
we can agree on the new proposal, irq_managed:strict?


Kind regards,
-- 
Aaron Tomlin
