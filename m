Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020104.outbound.protection.outlook.com [52.101.195.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01823C516;
	Sat, 29 Aug 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788008828; cv=fail; b=gNnKKesedjxlgSC4kaDNkD70qJCCzFmrJMg8I42ofF1zgv9vOz//BrEhc6QiSO7dOefO4nfpj0UWRud8X8RmIRLH/PjoRo/NHhbPXj0jZCxN05Dx151m8WG7FYNTSSZ+ruYat3KkSNbZsmb0lxcROCwV6BHBijHvlVPdy792ZaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788008828; c=relaxed/simple;
	bh=sIYhmyHuAmCIx8gsCcjG4RYlTlqMMIwFtpMJrC3clNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P0/uUz+amqoFvZ8ZKVGFUX5v2y519OPKoKJJJ2ICTGCdKbBelgF9VPjEZ8VtF8kA9za3AWfRsP3rvMxrgTWjfNEItoFUeXRgcBfH5VYvFzZLx6DLizfCeSMPIe2BMjrVct5TzU+OAwqWve3Y3cJfne1rPQfsprbVrCEyo1cNN9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ/kohgEWEz2wPPleNHucvCGQVUycuHSzS1n4vQ5O/rczE5dy2HnqEl3rO9ANYOg5gXKBNZvXJb6ZaGzoIiPaVrBi/iU187IgIn8Pl9/5sFs+Jr7nVCLHZUQ65R0BkERCPYUyUOcqj7hCyi5ULnTuqgd6RPzAdLi7GnhJZKZwUdbmBdySPNZKmopcyrz/F8eMZuSmiG9HGJ3L+nZCV0SNucyPxzDT+zhfGLavkBzXdQQ33AypgCo67xdoGMndIhKeVIaxtL6qWg4dNwaOaLOckZJ9YeYjk9l9BQ4H3E1bIdBEyrM9qqmjEq9h0sWUL+f+LRML+glD+CxufIBMe7Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=G0oXycQmw8ACE+8N85Hme3136cY2yzzkZhetdVu7m4Q=;
 b=A7YvsBhaqn2vYxxdO5NX5Qfqr6dlIokBp37W6OeUkJqa7+Oy1/iEXGqxCAAPS9zxT7C+0NxegjooYuyrd1n5Bmu6IQWyyY/S9b3WESI2r/KmVIn0JvQaJuGxlFrLfBCfZjsLvEW71Dg7k4s/X8mwV0beXG1TYElmYC0og0leuKG1TAQ0RnzJ5fNPzoEQFzKr6TI5bQzWn9yWVEYfqZoOApUuOuJsZj977Zs8a0Fokr5ONZH7LAhoK1hO5e0h9qyUG+uT9lJ/9jcKuatks79bM79YDqCMrTIYrgnLRBPG5C/QrkWD5HuYVP2doDCrkFwkRYJzaNQ2bzMxYuwv4wq55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 13:06:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 13:06:59 +0000
Date: Sat, 29 Aug 2026 09:06:55 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: frederic@kernel.org, hch@lst.de, wagi@kernel.org, axboe@kernel.dk, 
	kbusch@kernel.org, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, yphbchou0911@gmail.com, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 8/8] docs: add io_queue flag to isolcpus
Message-ID: <e7ird6ord6enmdtxyz27cqibs5izp3rz6t5l5idt5ot2swh2hb@rnut2snmkecq>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-9-atomlin@atomlin.com>
 <20260715102535.STkb5tE8@linutronix.de>
 <xjcwes5caiwh3eumqfuvankokb7wzzokleqfkfmkh5sgl333sg@nwlgqvj4vdet>
 <20260821151643.4pYBoVaY@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821151643.4pYBoVaY@linutronix.de>
X-ClientProxiedBy: LO4P123CA0645.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: ab495289-e269-40c5-4d79-08df05ce6899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	o8/HUZKINHYAz+LlDJjkUsgTzx6zCxicfGyYmPYMyf6OjFYf22uZ/mxFtqfWZwFN20/pEWtYR4kYXdiHxgH7x1V2xv+ag51kD91xYmMkwm461pvsdJqJ2HvswB2zT/iYFv3OCNAVrx97u5pb5NOd5bSB3daQujndvJP2d9iwbQ/334ictXV9YEkLYVSp3JVmu02ghzDuFy5rK/8TvTItM1JTQ16ChO4aRBMMAIOurngudo1SYsPypJIS4EwKgWLPg0/AdhhbBndstl+l+Kb+KbILiYBUQBdU3KUk3EoPWTSfh0Y/rQ9KJdadXaPTdsvEH8dMk9FffNL7Gu7FCGbfZipst7PoBsEOBrNTtUTGpnNlBXf+jdrgPfEP5Jmo+2xa0J9EGuTTHhjk3clmp1LQcJrCJw28NxOry4ntuG0FuOr6LuItv0SrxgBaa3xN2UiRknwRhI8VMq1wJ6Pg99iLU+0eYvjPZq4QIv2Z3Ftik5584mJu9//8photMTtWKYdJmLQI05vAdjPu1gNaBBcsIiHDrmOmVpoIXJCpwpjzufZj8A7iIhd4knJ8QobVwk1gw2E5yFYXmbKiL1gg6cGLB2cSJPcdsN04k19cuvPpC2B1QCedpDDwuPreZaWGQt0d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1qdVdmNHFidyt1REV6dVhDcis0bENjUmZ4M1pKdmcrS0RPWnVTTC9taWlj?=
 =?utf-8?B?Q1R1UDF2L0tPVTZUUDhKWGIzbDhCMFF1SFFSb0t3WWZ3SzB5VVZqNDAwVWwr?=
 =?utf-8?B?ZDZ6NE5mMU9hQTBUemN1cGFWQlNMcndFQm9wcWNLR1FheThNTkZORzZTWTNX?=
 =?utf-8?B?bjZsL0p6QzJucCs3VEVlM3pWMXpPVXBPaTkxVnZJTVZHTGFJUEZrQ1pEaGJa?=
 =?utf-8?B?a3Fma1pRU0lCSmF0UEdhNkpZY255ajhyeURBejlGNWVONlhzOGR0VW5rN1Fo?=
 =?utf-8?B?NDc4QW1uRjhMNUtKOVpFVW42TnQwS2JEc1JxN09xNU1PV0I2MXVOOWZmZDdt?=
 =?utf-8?B?N05YLzNmV3p6aHFhRG1NL2ZvTnBsVHNhK3FZSDVlSmJtOXEwcjQvelhxNy9p?=
 =?utf-8?B?ZHNmenlvZ2RRaEx0NTlGbGo0TXFoRW9SMmV6eG8xNkxJemE0NXFVMHFpZlU4?=
 =?utf-8?B?RkhSRVFEb3JWWXdFOEVOenB1ekF1bHFsbUg5blVlenhoLzkweU5aaVB3am9p?=
 =?utf-8?B?b0o2SnhJMzhieWhDRHFKSzFXSVJIaFpFVUZvMmtleHBGeGwrS2YxSWpFTzVx?=
 =?utf-8?B?c0xvYUN1ZFR3VHBvVm5KQUk3bGZ0N1F4VXVHb3RkdWdWT25xS1FBbWMwM0FQ?=
 =?utf-8?B?MktaalQxWHNOM1N2ZmJtbkUwelByN1pSM0NsSHhDaThyTmdRUGgrOWtoekRL?=
 =?utf-8?B?aXZWeWZEQVQyeFFBc1JHblBkYnZPWWNUM1lhS2k3bUFBYndTYWkrZDNNbTk3?=
 =?utf-8?B?OXZra2FKc0tYdEducjJHV0s5NU51M1hRbzJiUkZiNi9YOWVnZnJLNklSR25C?=
 =?utf-8?B?cm5KZmx5SmhLQU03STBhelBGeElBaitkZ0d3MnJvN0oreUpyQnl2Q092Y0VZ?=
 =?utf-8?B?a2NFeEdvWittSGZOU3M3Z2pKbnBqWEFHMGRLak5CVWRPM0NYb1pHNzVPVDdZ?=
 =?utf-8?B?YXNtQ1BuQnk0bDNNMHpUNE1zamhCNXd6czdBbDNBR3dlVmlpVXdOV2k1MW1Z?=
 =?utf-8?B?N2hpTkV5UzEzNURjZjhqK0tzWCtiRTZZZFlWdVBmVmF3MmFCZVhMTkNzRlVI?=
 =?utf-8?B?NkU1MTNVV1JKR1pCcWJyU0tGTDlnQWtVZE5zN3VIek9heFB6YnVkOEVFSmNO?=
 =?utf-8?B?QXVUbG5McXhFU2ZsdUtOaWtmSVYxTEFCN0ZYckZxRzNvNDNyMVNpZW1Ud0hQ?=
 =?utf-8?B?eDhHQ3orTDFHc2t0S0l6QmRzWWlMOW02MnEzcHNlNUhnK2JRNnlla0hqeis5?=
 =?utf-8?B?Nit2SjNxVkI4b0VsamYwT0tlVWN5Um9OR3pHZS81UUwwRStkN1VwL0l6Yy8x?=
 =?utf-8?B?RkdobG9JL2pKcXdOUkozYnY2bmtYdUl4MXI2cnNXTmpBWXRTV3pXNkZLL2Nl?=
 =?utf-8?B?eVFhRGlKMVZvMVFrcFJzRzlFYUNCV3JhSjdqcVZLdkNTdHYxalFsd2FXNnkw?=
 =?utf-8?B?NXltL0NMcHVZL24xMjZpN01ocVN1U3lBbFRMY041cUdXRm9Ddy9KREFiVExR?=
 =?utf-8?B?YmkvOHVacWVRS09PUk5TN1FYLzF1V0xrbG5VOG0zdjRZMTc2c3Y3UmJJVGR0?=
 =?utf-8?B?VlpENjN6NSt2aVdMTFVqRFE4TUozVmIzUkg4NUNnMVJMU2pValhvUnJMQW42?=
 =?utf-8?B?Q2xqMk8rVFhKUSsvNE5SNjBFaGNvSkxyUkJXbW1pc3lwaG4vT3RUcnEwZ0Fk?=
 =?utf-8?B?V0NrbTY5TDUzVk9tRC9wRkE0dFJmQVdUM0dUYmFRQ0xNZzk3UzNyVmx1Ymcr?=
 =?utf-8?B?WWlqVXptTWJLVlNkMlVJTlhMNTN6Ukl2VUY5Q2lWVGVnSyt1Ny9ySUR4L0NJ?=
 =?utf-8?B?THk4Y3drcXNnSlVZMFFNRHRqMCtIVkdadkJtaVlwdE5Pc0czM2FqRk5RVnRp?=
 =?utf-8?B?ZHE4SFZoZUsvQ0RrNTcrTy9yNXgwaGMyWERoOUZLakdFNlpjUzh4U3k3RE1i?=
 =?utf-8?B?dGw3ODFsL0RhYzROYzFBWlVXVlF5V3hIQk84Wm1jS0xWVHJlZ0lhUTV1UDBy?=
 =?utf-8?B?NWtkYWtvSy8zU2hOOWhzOTFGT2txZDJWOXdtK2NnOEtrdWxiTUprbGh5YlM5?=
 =?utf-8?B?VExYOXlkVEJYTjZZMlEycUJISXkvRUp4RHVNRVcrUWJUZkcrUGo5YWgxS1dC?=
 =?utf-8?B?ckNxSVpkY0w0VEZVRkJMYjB1K1BuNjAvOTV0Y1hLMTRxL0hIa1VOK0tvZE5O?=
 =?utf-8?B?NnoxV3VXWTJpVlRCZkIzVFFweUhSdHFpV0JKZlJiZXlzZDFnU3NmcWdvbHZ3?=
 =?utf-8?B?N0c2dDUvOVJPVGswbnBFNlFEU092SWFDeEpra0JsMkVVRDNjUlRjSTdKMkpM?=
 =?utf-8?B?cE5LQlNUb2pnVU5ZZmdOeGI0Sk91UFdwVW1QOTBkTlplbnM4N29Ndz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab495289-e269-40c5-4d79-08df05ce6899
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 13:06:58.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jFFMS3tX2NfY9E4j9GAkeA8vYD8Fl2GgRmUHViz7hbKYXZ2azyamF5y3RsQJxZW+BZ4ht0yXGgArskJMA7Epg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6615

On Fri, Aug 21, 2026 at 05:16:43PM +0200, Sebastian Andrzej Siewior wrote:
> Hi Aaron,

Hi Sebastian,

As always, thank you for the detailed feedback and insights.

> Is there a difference if this happens before or after allocation? I
> *think* if it is made post-allocation then the driver expects a certain
> amount of interrupts which need to be there. But otherwise…
> 
> There is no way to limit the amount of queues as far as I am aware which
> makes the isolcpus=managed_irq useless as long as there are more queues
> than CPUs in the system.
> 
> Is there a benefit of having 4 queues which are handled by 2 CPUs or
> would it make more sense to use only 2 queues and not "overcommit"?

Yes, this is the exact issue. In multiqueue drivers using PCI_IRQ_AFFINITY
(e.g., see function nvme_setup_irqs() in drivers/nvme/host/pci.c or
vp_request_msix_vectors() in drivers/virtio/virtio_pci_common.c), the
driver requests a vector range [minvec, maxvec] based on available CPUs,
and function irq_calc_affinity_vectors() in kernel/irq/affinity.c
determines the allocated vector count returned to the driver.

There is no benefit to allocating 4 hardware queues across 2 housekeeping
CPUs:

    1.  Allocating 4 queues on 2 housekeeping cores wastes MSI-X vector
        slots on architectures where per-CPU vector space is constrained
        (e.g., x86), whilst consuming extra memory for unneeded ring
        buffers and queue contexts.

    2.  When 4 queues are allocated for 4 CPUs, group_cpus_evenly() assigns
        a single CPU to each queue (Q0 -> {0}, Q1 -> {1}, Q2 -> {2}, Q3 ->
        {3}). For isolated CPUs 2 and 3, their masks share no intersection
        with housekeeping CPUs {0, 1}. Post-allocation managed_irq in
        irq_do_set_affinity() evaluates:

            cpumask_and(tmp_mask, mask, hk_mask);
            if (!cpumask_intersects(tmp_mask, cpu_online_mask))
                prog_mask = mask;

        Because tmp_mask is empty, it falls back to the isolated CPU,
        rendering isolation completely ineffective whenever queues >= CPUs.

Restricting vector allocation pre-allocation to the housekeeping count
(e.g., queues = 2) cleanly resolves this. It prevents MSI-X vector
exhaustion, avoids overcommit, and guarantees that no hardware interrupt
vector is ever created for an isolated CPU.


> The problem I am having is to figure out where the managed_irq makes
> sense since you need less queues than CPUs and this is hardware
> dependent. Say you replace your NVME after the old one broke and boom,
> now are all CPUs utilised.

Precisely. Modern storage drivers calculate queues based on possible CPUs
by default:

 - File: drivers/nvme/host/pci.c:

    static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
    {
        ...

        dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
        affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;

        ...
    }

Typically, modern devices allocate 1 queue per CPU (queues == CPUs),
single-CPU affinity masks are generated, making post-allocation managed_irq
completely ineffective. Relying on hardware queue scarcity for CPU
isolation is fragile and unpredictable.

> 
> So if managed_irqs would also act pre-allocation then the only
> difference would be "best effort" vs "mandatory".
> There might be the details around what happens if the CPU goes offline
> and can the CPU go offline. I think the block layers drains the I/O
> queues and the actual driver does nothing. In the CPUs > queues case the
> queues (or a few) are mapped to more than one CPU so if one of the CPUs
> goes offline, that IRQ is simply moved to another CPU within its mask
> (which could go to the initially isolated CPU if my memory serves me
> well).

Yes, and this highlights a key behavioural difference:

    1.  Isolated CPUs remain part of the descriptor mask. When a
        housekeeping CPU in that mask goes offline, kernel/irq/cpuhotplug.c
        migrates the managed interrupt onto whatever CPUs remain in the
        mask, including the isolated CPU.

    2.  Under strict pre-allocation (i.e., group_mask_cpus_evenly()),
        isolated cores are excluded when creating the affinity masks.
        See irq_create_affinity_masks():

            if (hk_enabled)
                mask = hk_mask;
            else
                mask = cpu_possible_mask;

            result = group_mask_cpus_evenly(this_vecs, mask, &nr_masks);

Because isolated CPUs are never part of the mask, hotplug migration onto an
isolated CPU is structurally impossible.

Regarding queue draining, blk-mq does not drain hardware queues when a CPU
goes offline; it simply unmaps the offline CPU's software context (ctx). If
all housekeeping cores serving a shared hctx were offlined, an active
isolated core submitting I/O to that hctx would suffer an indefinite stall.

This is why blk_mq_hctx_can_offline_hk_cpu() was added in patch 6/8.
See blk_mq_hctx_notify_offline():

        if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
            if (!blk_mq_hctx_can_offline_hk_cpu(hctx, cpu))
                return -EINVAL;
        }

It explicitly prevents an administrator from offlining the final
housekeeping core serving an online isolated core during runtime
(while permitting suspend via cpuhp_tasks_frozen).

> I am not aware that networking is using this. Judging by
> pci_alloc_irq_vectors_affinity() this is mostly scsi and there is one
> networking driver (which makes a bit curious how CPU hotplug is
> handled).  Anyway, there is some effort on the networking side to
> consolidate this:
> https://lore.kernel.org/20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com

Indeed. Searching for PCI_IRQ_AFFINITY shows it is used almost exclusively
by storage multiqueue drivers (i.e., NVMe, SCSI, virtio-pci) with
drivers/net/ethernet/wangxun/libwx/wx_lib.c being the solitary networking
user.

Network multiqueue operates on unmanaged IRQs, using XPS, RPS/RFS, RSS
indirection tables, and ethtool channel steering, where user space can
adjust affinity via irqbalance or /proc/irq/. Storage multiqueue, by
contrast, relies on immutable kernel-managed IRQs tied to
submission/completion ring pairs, which is why pre-allocation queue capping
is specifically required for blk-mq.

> I'm asking for breaking the current option because it makes no sense and
> so far nobody responded by saying yes, or no that is stupid.
> 
> > How about an opt-in flag:
> > 
> >   - isolcpus=managed_irq
> >         Keeps best-effort post-allocation IRQ steering without capping
> >         hardware queues
> > 
> >   - isolcpus=managed_irq_strict (or managed_irq:strict)
> >         Enables strict pre-allocation queue capping (i.e.,
> >         irq_calc_affinity_vectors() and blk_mq queue limits)
> > 
> > If the preference is to avoid adding a new top-level isolcpus= flag, I am
> > more than happy to refactor io_queue into a strict sub-parameter under
> > managed_irq (e.g., isolcpus=managed_irq:strict). This probably makes more
> > sense.
> 
> Not sure what Frederick's thinks here but I would aim for
> managed_irq_strict if we can't change the current behaviour.
> It should be also documented if both can be used (or are invalid) and
> what to expect if they are mixed.

I completely agree that fixing/or breaking the legacy behaviour makes the most
technical sense given that post-allocation steering is broken on modern
hardware. However, to eliminate regression risk for existing users,
introducing isolcpus=managed_irq_strict (and dropping io_queue) provides an
explicit opt-in.

I will Cc Frederic Weisbecker on the next iteration to establish if
upgrading managed_irq directly or adopting managed_irq_strict is preferred.

Regarding precedence, if both managed_irq and managed_irq_strict are
supplied, managed_irq_strict will take precedence since it is a strict
superset (enforcing pre-allocation queue capping and mask exclusion). This
will be documented in Documentation/admin-guide/kernel-parameters.txt and
Documentation/core-api/irq/managed_irq.rst

> I *think* ':' will be an invalid character and ignored so maybe the '_'
> instead.

Yes; according to housekeeping_isolcpus_setup() in
kernel/sched/isolation.c:

        for (par = str, len = 0; *str && *str != ','; str++, len++) {
            if (!isalpha(*str) && *str != '_')
                illegal = true;
        }

        if (illegal) {
            pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
            return 0;
        }

Any character other than [a-zA-Z_] triggers illegal = true, and aborts
isolcpus parsing. Therefore, managed_irq_strict will be used in the next
iteration.


Kind regards,
-- 
Aaron Tomlin
