Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022143.outbound.protection.outlook.com [52.101.101.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4936606A;
	Thu, 21 May 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406207; cv=fail; b=JGrBxObqDbBJjhISrGkM/JN2oTeMzMADegnyFUErzw1IZa/dsmIPz/JGer5NFrH1JRAXZ7a/EYyyxtWu7N6xZ002cpnJwXzN/kJrhGKpaxWs9W4KBSYb/IMC1KFM4vBiTAsupu5qbWqkgyvSO1nz2z2PAOuOn6edKSpxQtMAI90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406207; c=relaxed/simple;
	bh=E/7dudd26pzCgwXAVb5745ht4jd2uGKkNR0BloQG/PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rANyuT97r3y7iu76g8Gg383sER3yLDtJXetXrgJKctWamD/P8sCLw0fmbvqtcaMdqmbeJWrh1reg0fLLf/GQXCWz+b9msqRwdriAk3Kx4OMJ4653A5yOzCuFv8AR0R8yy+TGREfP25emRge3R1CGMW1JRB7Fk7RT7XKeCLpLUCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fueer05J/rdCS6jGXKdvazm1UP4zJ+B3aMGSUtYlOUCMsj8nr04lPq4WboGH+hAoQqTmPjSWshgNcOHuMUqiyY8swiQQk6BC6n0cMDugViJ0Z2alMAouE/VPsoo754fmXjJpKc9+CEAGgqn2oxUHkZYGJUjpuIefcTTpLpUSDlFQjF76NMMrbmrCsdwPg8gJJc0U/h3cYn10x77cf3jWQ2/qBtG5iu/lqjNHV1vJv7IXifyfw6MYGW6l3WAKQ5fDUm0MlWXlfRQQ1yHmU57IIU/aaOEkvRfPEmmacBk1EME1jKu9Sa6eoFv4+gBt/hjNmrSaT5ETNb+7rdMkJ23Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWyputnUcrlFBP/vS8ceijU8o5YPTYDswKOCV2T3sA4=;
 b=e0KVPpSwznFvRq0wGmMBZQuu3EwQQMKpANHJjOK2ajCGDLxORa1ZxPY4PaVQe6ZtEbCDnng/gDkgIaAMjUv1Eevg4Hy/S7vKT/0R5+2aG/giLaMEWiZs50kHBbtQkkRlgraCagbc7ECQ27TvRL9leU+IP5pdIEevDHbBp7DIUlvgCLcixRToJlctFG7bsE0kUahXghaKgG5lH9fm+n4u+JCZazWxuRbGktSmKJUTpt8dorVWBhVvtiJoTyNNrI+H7SENvpbDBMI/nCrxE+8CdQZTI9XKllJv7+4w39Oaui778k2CgonIVaCjy2FVCJxnZ1Qhd2Dfwqv9wIxMunO/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:00 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	rishil1999@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 0/8] blk: honor isolcpus configuration
Date: Thu, 21 May 2026 19:29:48 -0400
Message-ID: <20260521232956.553287-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:408:111::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe0fd1b-dcb5-42aa-6b6f-08deb790e083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|6133799003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info:
	3JlI1biIDIClcV7pZMfMOe/thr+bkcseXEGiOnvJ3MWbf10qpGLYLzZk1k9Wlx9OteDCpZdzBIzM9ErgHjaWqR8tx02W6HSU8tsrTwf+2rfczkAHHSpzVwFOaX5Vxr1m93AwC1/kgPBGSMCm+oRx0kOBKivh2doOOhyQMyxo52XCzAinDgvilPNDu/qYUKVOALoGp5r3gxu9OdDf9bYU9AtvUBmVlPTDXEpCtZdkm4PNOtE12TntkTProFdomqoR4dDNfIEZZLP+fMxBgUhsXwqbyv8PkbAhBQc4G1s8AZsZ4slroT+uF6z0h4/ysJoHDymXJkpC1TZ5WYRgl6KBVGYJ2MWB65EtR100jFFhKIawW76Whrk0BRiWa9Fc1vQO5Z/G5DBoQsLJEXg4ooKmDqFDFyQNs+wpntLY41o0v4aQ3jv6j6DckxqNnPv0F5W05RgcFuJ4iewHimMmWJv1OFjc3F1yDT6iNZC3gCGgsG4F4pMOMZ3bSicDsZmP52DvIJhtrql8RDhjCqnrpCRAorXYH5Fj86m9Zoyum43s3wMkM8s2So1Q273lcjG5ExFfjpvJ0C936yqTQUQDzfFjTgMcZePsbia9q4d9E26NP7826a98navQrFDiuctx0I6W4SRD9OPq5YCk5qdww02kbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(6133799003)(3023799007)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+j+7Nvks8xt2e0T0/JHtbMIlfQpilaYmducZ53ap4F/NJvvAZThprYFxMtAi?=
 =?us-ascii?Q?PvyZOh1l4ysDxMMYBqzI2nPtE5PDZ7CagwsEMxA2ERqNxZiNJygy6rAeDPh8?=
 =?us-ascii?Q?s4jQwHECAE6Uy3Vp3zpOCioQWQly/bDk2ito272VLBgEjfy1+hvOOjQOk7eM?=
 =?us-ascii?Q?IkqcS6Q2KSTDoiHBFA88DALvULzCfbgIraUZ165b48v/ML+w4EKmvlWpUqbD?=
 =?us-ascii?Q?skrH6rE5n0KLnjHlEfiAMCJJ0crepxhBaGO0H0UkYx12dZDMMLINEhbYkG6i?=
 =?us-ascii?Q?YoxZ03PmaSyLehqr/vW2AjvXWJS7r005dByAZ2flZGMdDw/zGFMuFd6oXdDf?=
 =?us-ascii?Q?938VdirARlzVruqgHdMjoymZJJNvKExyR4vcZtTRoAM2+L/wjwcNGTWgnU6X?=
 =?us-ascii?Q?KLChP8QorP9x9pZUwqo8fRMll+qrDZh60bsv6YRR0jR5Mpaib6mA3h4v9FNw?=
 =?us-ascii?Q?ttEuKjdZBGJqLNqhh+8vXk1qxrhvHIY+JKOuaoQm5JfJ2V/pliyS1UXISuS2?=
 =?us-ascii?Q?+mVJVFd/BCWpwY/oKphmoxpOSVds+88eY5XFctG7CL15JwDiu6YQyd1azweA?=
 =?us-ascii?Q?vDD1uU60FBJ/KQssgJZkH1mhe+xXmrQuXmQc92Xc7SIQtMT93OqVva6tqwOR?=
 =?us-ascii?Q?EAzprFmVdWgsTGc5d/RmwBMTqMKsWxALVyC7H2FQlCSTXvgpVtW9mCk+sahK?=
 =?us-ascii?Q?GmrBHPi4Lqh2AOxqnuMPmhcSkAl/XkfgoOgyplGGT/KkVT2nNuVsvJ+GfiOZ?=
 =?us-ascii?Q?dGfXh4LqDkiQ6ZBppMoWv4I4AIa6Zg4pcoxLJdgY8rQ/k5qvhyakOMCYOYA+?=
 =?us-ascii?Q?OdDl5izYkZyHIPj1SmCAf0MQWrljNtBsUTWuf3Mabgvv5F3x4wYqRwehIxuS?=
 =?us-ascii?Q?oWjebllAei3C5+rehyambogAbOSLva6N/K+KOKUE8TWrHeZlnpfJPVb4tXQr?=
 =?us-ascii?Q?v+ElW0HEeIrtgfS7oNBQzJ8z+p4YwCXy7aXjeOFwIpAsQSO/2eAPUF8mW1gE?=
 =?us-ascii?Q?MmnlajZtg8XlYK0dhZFcRBkjU+oU7XVdRy55z9fWT1GXwOfAsHOHGpqkLgFt?=
 =?us-ascii?Q?PkHD8RNwbnsj3q8eJb8Ucw8hXulFawUJRglKb+wh59tSKSedHCgzqo66L2AD?=
 =?us-ascii?Q?UFOIqmtUFtqZGflisfrpKCshuM9M/swuXE2K5tCfWXaFazFVGjV4eWq8JVpg?=
 =?us-ascii?Q?pgmwdctyVH7NWpMSTa9Le6cWEAjs3Tvhyp6DqDF1DxqMJrRD8Rmfvlbyi0Eq?=
 =?us-ascii?Q?c18bY6W6N/Q2v45UhjAQy86w7YZdIlRBYQr0qJsHp0igy3uMS0srhjpWvnkb?=
 =?us-ascii?Q?mYNOjwv8i4RIkRJaFCd8q9TBpzLJ55Q6ww1STapTsFEInsBB4eNzOHHDrkKv?=
 =?us-ascii?Q?QSa2J5e+pUZCxIZ0DWybKKrJ84RaI+cynf+ydWxhS8ZcRCoPrO7BdLD7WeCj?=
 =?us-ascii?Q?vS++0vZY7SiTRErTQsrTiistdRe4eLZajM+/hr2kz63VpVWfjyK+rGavTfg7?=
 =?us-ascii?Q?8dxjAF5rq4PSsYlgl5bE5jEhv/KkdQqJL76d2iKlq4+A7ui0S7rrzf28vx50?=
 =?us-ascii?Q?DfAbfb9RJDSj3cg3a33cD+pc5eG3u7sBzNDQ9CWJo1fTNemewsF+OJ5zHXeV?=
 =?us-ascii?Q?T5wIeDe8pSB4SMra+h2OGjUlNwpTRaD4WirtZjjXFQl3YQqPUZ7nL7Ehkma9?=
 =?us-ascii?Q?EFKjtptrd3TLqBgyJBSgG1s86svIPYkH3Hk/wFhSQ8NHNXq/Qm9+oTryKFps?=
 =?us-ascii?Q?iR3nKa5Xig=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe0fd1b-dcb5-42aa-6b6f-08deb790e083
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:00.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z87ZYnftG595gusED7e+h4ULXulcpZxBEQDVa62s9h1nOi9jN5yHTaRVSwCEiyOmeQuI3TJTfaR9v3k5MHyq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

Hi,

I have decided to drive this series forward on behalf of Daniel Wagner, the
original author. The series has been rebased on v7.1-rc4-100-g8bc67e4db64a.

This series introduces a new CPU isolation feature, "isolcpus=io_queue",
designed to protect isolated cores from the disruptive hardware interrupts
generated by high-performance multi-queue devices.

When enabled, it fundamentally alters how the generic IRQ subsystem and the
block layer (blk-mq) map hardware queues:

    1.  Restricted IRQ Affinity: Managed hardware interrupts are strictly
        confined to online housekeeping CPUs.

    2.  Transparent I/O Submission: Applications running on isolated CPUs
        can still seamlessly submit I/O requests; however, the resulting
        hardware completion interrupts are safely routed to a designated
        housekeeping CPU.

    3.  Topology-Aware Queue Allocation: The generic CPU-to-hardware-queue
        mapping logic is extended to distribute hardware contexts evenly
        among the available housekeeping CPUs, preventing MSI-X vector
        exhaustion while maintaining optimal cache locality where possible.

To prevent I/O stalls, the block layer is additionally hardened to reject
hot-plug requests that attempt to offline a housekeeping CPU if it is the
last remaining CPU actively serving an online isolated core.

The complex "top-down" mask plumbing introduced in v12, which modified
struct irq_affinity and expanded block layer APIs, has been abandoned. It
is replaced by a centralised approach: direct isolation querying via
housekeeping_cpumask(HK_TYPE_IO_QUEUE) within the genirq/affinity
subsystem. This architectural simplification successfully decouples core
changes from driver-specific implementations.

Please let me know your thoughts.


Changes since v14:

 - Fixed a division-by-zero by ensuring group_mask_cpus_evenly() safely
   frees its allocations and returns NULL instead of an empty array if the
   provided mask yields zero groups.

 - Fixed a device probe -ENOSPC regression in blk_mq_num_queues(). If the
   housekeeping mask intersection evaluated to 0 (e.g., against a localised
   NUMA node), min_not_zero() would erroneously return the absolute maximum
   hardware queues. The result is now safely clamped to a minimum of 1.

 - Added a mapping verification check to prevent unrelated housekeeping
   CPUs from aborting the global hotplug offline sequence.

 - Aligned the pr_warn format specifier with the unsigned int declaration
   of hctx->queue_num in blk_mq_hctx_can_offline_hk_cpu().

 - Linked to v14: https://lore.kernel.org/lkml/20260520215030.496803-1-atomlin@atomlin.com/

Changes since v13:

 - Removed ineffective data_race() annotations around mask and
   cpu_present_mask pointers. Wrapping the pointers failed to suppress
   KCSAN warnings for the underlying inline bitmap memory accesses.

 - Fixed a silent validation bypass in blk_mq_map_hw_queues() caused by
   overlapping IRQ affinity masks by removing the short-circuiting
   optimisation and evaluating the active_hctx bitmap in a secondary pass.

 - Restored topology-aware multi-queue fallback by correctly routing
   missing IRQ affinity masks to the map_software path instead of the naive
   map-all fallback.

 - Dropped hctx->queue->disk->disk_name from warning to avoid a UAF.

 - Fixed an isolation leak where excess allocated hardware queues were
   improperly padded with irq_default_affinity. Because these queues are
   marked as managed, they bypassed user-space IRQ balancing; they are now
   safely padded with the housekeeping mask.

 - Enforced the housekeeping vector cap prior to evaluating driver-provided
   calc_sets() callbacks, preventing modern multi-queue drivers from
   bypassing the cap and wasting memory on dead queues.

 - Introduced a safety net to the vector calculation to prevent fatal
   -ENOSPC device probe aborts on heavily isolated systems where the
   housekeeping CPU count is lower than the device's structural minimum.

 - Removed an inaccurate claim stating that the io_queue isolation flag
   takes precedence over managed_irq. Both flags are parsed, evaluated, and
   enforced entirely independently by their respective subsystems.

 - Linked to v13: https://lore.kernel.org/lkml/20260513005509.135966-1-atomlin@atomlin.com/

Changes since v12:

 - Resolved TOCTOU race conditions against CPU hotplug events in
   blk_mq_map_queues() and group_mask_cpus_evenly() by taking lockless
   snapshots of the online CPU mask prior to algorithmic evaluation.

 - Migrated the active_hctx tracking to a dynamically sized bitmap
   (bitmap_zalloc), resolving a critical out-of-bounds memory write that
   occurred when hardware queues exceeded the system CPU count.

 - Wrapped the disk pointer fetch in blk_mq_hctx_can_offline_hk_cpu() with
   READ_ONCE() to prevent a TOCTOU NULL pointer dereference against
   concurrent device teardowns.

 - Introduced bitmap_empty() checks to prevent the mapping logic from
   routing unassigned CPUs into unallocated memory when all mapped CPUs are
   offline, safely forcing a fallback mapping instead.

 - Implemented a native two-stage distribution logic in
   group_mask_cpus_evenly() that first prioritises physically present CPUs
   to prevent I/O starvation before distributing remaining vectors to
   non-present CPUs for hotplug safety.

 - Restricted the maximum number of allocated vectors in
   irq_calc_affinity_vectors() to the weight of the housekeeping mask,
   preventing drivers from wasting memory on dead hardware queues that
   physically cannot be routed.

 - Added padding logic using irq_default_affinity for sets where isolation
   constraints yield fewer masks than requested vectors, preserving the 1:1
   hardware queue mapping sequence for subsequent sets.

 - Fixed a logic flaw that prematurely rejected valid offline requests by
   manually iterating over cpu_online_mask and reverse-mapping to
   accurately detect isolated CPUs, properly permitting the offlining of
   non-housekeeping CPUs.

 - Corrected an absolute versus relative queue index calculation bug in
   blk_mq_map_queues() that was overwriting loop iterations, by iterating
   directly over the generated masks.

 - Replaced scoped __free cleanups with traditional goto unwinding in the
   block layer to align with subsystem styling guidelines.

 - Refined the io_queue kernel command-line parameter documentation for
   better clarity and precision.

 - Linked to v12: https://lore.kernel.org/lkml/20260422185215.100929-1-atomlin@atomlin.com/

Changes since v11:

 - Removed duplicate paragraph from the commit message in patch 11
   (Marco Crivellari)

 - Ensure ZERO_SIZE_PTR is not returned by group_mask_cpus_evenly()
   (Marco Crivellari)

 - Linked to v11: https://lore.kernel.org/lkml/20260416192942.1243421-1-atomlin@atomlin.com/

Changes since v10:

 - Completely rewrote the isolcpus=io_queue documentation in
   Documentation/admin-guide/kernel-parameters.txt to clarify its exclusive
   application to managed IRQs, queue allocation limits, vector exhaustion
   prevention, and hardware interrupt routing (Ming Lei)

 - Fixed a stack frame bloat issue by avoiding the on-stack declaration of
   struct cpumask (Waiman Long)

 - Linked to v10: https://lore.kernel.org/linux-nvme/20260401222312.772334-1-atomlin@atomlin.com/

Changes since v9:

 - Fixed a page fault regression encountered when initialising secondary
   queue maps (e.g., NVMe poll queues). Restored the qmap->queue_offset to
   the mq_map assignment to ensure CPUs are strictly mapped to absolute
   hardware indices (Keith Busch)

 - Corrected the active_hctx tracker to utilise relative queue indices,
   preventing out-of-bounds mask assignments

 - Fixed the blk_mq_validate() sanity check to properly evaluate absolute
   queue indices against the offset-adjusted loop index

 - Corrected typographical errors within block/blk-mq-cpumap.c
   (Keith Busch)

 - Clarified the commit message regarding the removal of the !SMP fallback
   code, explicitly noting that the core scheduler now mandates SMP
   unconditionally (Sebastian Andrzej Siewior)

 - Added missing "Signed-off-by:" tags to properly record the patch series
   chain of custody

 - Linked to v9: https://lore.kernel.org/lkml/20260330221047.630206-1-atomlin@atomlin.com/

Changes since v8:

 - Added "Reviewed-by:" tags

 - Introduced irq_spread_hk_filter() to safely restrict managed IRQ
   affinity to housekeeping CPUs (Thomas Gleixner)

 - Removed the unsafe global static variable blk_hk_online_mask from
   blk-mq-cpumap.c and blk-mq.c. blk_mq_online_queue_affinity() now returns
   a stable pointer, delegating safe intersection to the callers to prevent
   concurrent modification races (Thomas Gleixner, Hannes Reinecke)

 - Resolved BUG: kernel NULL pointer dereference in __blk_mq_all_tag_iter
   reported by the kernel test robot during cpuhotplug rcutorture stress
   testing

 - Linked to v8: https://lore.kernel.org/lkml/20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org/

Changes since v7:

 - Added commit 524f5eea4bbe ("lib/group_cpus: remove !SMP code")

 - Merged the new mapping logic directly into the existing function to
   avoid special casing

 - Refined the group_mask_cpus_evenly() implementation with the following
   updates:

   - Corrected the function name typo (changed group_masks_cpus_evenly to
     group_mask_cpus_evenly)

   - Updated the documentation comment to accurately reflect the function's
     behavior

   - Renamed the cpu_mask argument to mask for consistency

 - Added a new patch for aacraid to include the missing number of queues
   calculation

 - Restricted updates to only affect SCSI drivers that support
   PCI_IRQ_AFFINITY and do not utilise nvme-fabrics

 - Removed the __free cleanup attribute usage for cpumask_var_t allocations
   due to compatibility issues

 - Updated the documentation to explicitly highlight the limitations
   surrounding CPU offlining

 - Collected accumulated Reviewed-by and Acked-by tags

 - Linked to v7: https://patch.msgid.link/20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org

Changes since v6:

 - Sent out the first part of the series independently:
   https://lore.kernel.org/all/20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org/

 - Added comprehensive kernel command-line documentation

 - Added validation logic to ensure the resulting CPU-to-queue mapping is
   fully operational

 - Rewrote the isolcpus mapping code to properly account for active
   hardware contexts (hctx)

 - Introduced blk_mq_map_hk_irq_queues, which utilizes the mask retrieved
   from irq_get_affinity()

 - Refactored blk_mq_map_hk_queues to require the caller to explicitly test
   for HK_TYPE_MANAGED_IRQ

 - Linked to v6: https://patch.msgid.link/20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org

Changes since v5:

 - Reintroduced the io_queue type for the isolcpus kernel parameter

 - Prevented the offlining of a housekeeping CPU if an isolated CPU is
   still present, upgrading this behavior from a simple warning to a hard
   restriction

 - Linked to v5: https://lore.kernel.org/r/20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org

Changes since v4:

 - Rebased the series onto the latest for-6.14/block branch.

 - Updated the documentation regarding the managed_irq parameters

 - Reworded the commit message for "blk-mq: issue warning when offlining
   hctx with online isolcpus" for better clarity

 - Split the input and output parameters in the patch "lib/group_cpus: let
   group_cpu_evenly return number of groups"

 - Dropped the patch "sched/isolation: document HK_TYPE housekeeping
   option"

 - Linked to v4: https://lore.kernel.org/r/20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org

Changes since v3:

 - Added the patch "blk-mq: issue warning when offlining hctx with online
   isolcpus"

 - Fixed the check in group_cpus_evenly(); the condition now properly uses
   housekeeping_enabled() instead of cpumask_weight(), as the latter always
   returns a valid mask

 - Dropped the Fixes: tag from "lib/group_cpus.c: honor housekeeping config
   when grouping CPUs"

 - Fixed an overlong line warning in the patch "scsi: use block layer
   helpers to calculate num of queues"

 - Dropped the patch "sched/isolation: Add io_queue housekeeping option" in
   favor of simply documenting the housekeeping hk_type enum

 - Added the patch "lib/group_cpus: let group_cpu_evenly return number of
   groups"

 - Collected accumulated Reviewed-by and Acked-by tags

 - Split the patchset by moving foundational changes into a separate
   preparation series:
   https://lore.kernel.org/linux-nvme/20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org/

 - Linked to v3: https://lore.kernel.org/r/20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de

Changes since v2:

 - Integrated patches from Ming Lei
   (https://lore.kernel.org/all/20210709081005.421340-1-ming.lei@redhat.com/):
   "virtio: add APIs for retrieving vq affinity" and "blk-mq: introduce
   blk_mq_dev_map_queues"

 - Replaced all instances of blk_mq_pci_map_queues and
   blk_mq_virtio_map_queues with the new unified blk_mq_dev_map_queues

 - Updated and expanded the helper functions used for calculating the
   number of queues

 - Added the CPU-to-hctx mapping function specifically to support the
   isolcpus=io_queue parameter

 - Documented the hk_type enum and the newly introduced isolcpus=io_queue
   parameter

 - Added the patch "scsi: pm8001: do not overwrite PCI queue mapping"

 - Linked to v2: https://lore.kernel.org/r/20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de

Changes since v1:

 - Updated the feature documentation for clarity and completeness

 - Split the blk/nvme-pci patch into smaller, logical commits

 - Dropped the HK_TYPE_IO_QUEUE macro in favor of reusing
   HK_TYPE_MANAGED_IRQ

 - Linked to v1: https://lore.kernel.org/r/20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de


Aaron Tomlin (1):
  genirq/affinity: Restrict managed IRQ affinity to housekeeping CPUs

Daniel Wagner (7):
  scsi: aacraid: use block layer helpers to calculate num of queues
  lib/group_cpus: remove dead !SMP code
  lib/group_cpus: Add group_mask_cpus_evenly()
  isolation: Introduce io_queue isolcpus type
  blk-mq: use hk cpus only when isolcpus=io_queue is enabled
  blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
  docs: add io_queue flag to isolcpus

 .../admin-guide/kernel-parameters.txt         |  26 +-
 block/blk-mq-cpumap.c                         | 238 ++++++++++++++++--
 block/blk-mq.c                                |  55 ++++
 drivers/scsi/aacraid/comminit.c               |   3 +-
 include/linux/group_cpus.h                    |   3 +
 include/linux/sched/isolation.h               |   1 +
 kernel/irq/affinity.c                         |  31 ++-
 kernel/sched/isolation.c                      |   7 +
 lib/group_cpus.c                              | 112 ++++++++-
 9 files changed, 436 insertions(+), 40 deletions(-)


base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.51.0

