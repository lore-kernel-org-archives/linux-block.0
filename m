Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E53793CC;
	Wed, 20 May 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313841; cv=fail; b=M3wmoa0CSEuO5A2vJ7SPxj0mlBd4ITOpFK77fPuOSEXEY/kPHT+RNtnlVX1MAp+EX+b6q3bF+Y4ldIIoloD7D4D9LelBQpr1H6TgKMZIJskG4AdG7rjlFv14c9tDKibbTnZxfk+aM4sRDpNQUyAucVqjtc5wz5X6bD90VmF6gSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313841; c=relaxed/simple;
	bh=UWFhq/2kL3lnPgDi4dhRNKnTTyNwz8PhGPr4C9Np9XY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ij3oY8m2XxbHqvhuZ/tHIkrD2hJIbq+JqtaFnYSTEHMULtKGzwfdNapWB7EdXcdotJwstZr8cBL/5HVes/7FrxpZ3+85T6QGKzeGWa9IslXm+xwsUkovzi50tZNVvdc7GCK3uEgFqwstvY+qL27UcgtO76qSMtGn2A5U9F/MWMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6jeI+qDJtvppj/dUITikspdM7GSla6T/QZ4BrUG3Ve1yrGqE3aGTBQKvER8gl8KE06JMrusjabopaYTyF4s/f5kH35KGk0mjH0R7cK8VFr++i7/Ixzd/TC6NWepHqq16V0ZHKLiJW9YSrMyTTNKPeCcfQ0Ayal+VpofTFEeJyY7cbUFHUXs81HeZ0P4p41pMPAiLOcI2n/3T+LsLlYTpcHKDKBioUIX5+OT0qa4vM2SvmUC8fLIzJDzn3FKgzAELuR13qvItX3ciuQnIpJzfmY23D5u9KAbE0bl4YcX6T+Gh3PjtSHquemGg4a6pyST8mpWf81i/EDEIaFSO1Py8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIKexwYWA9ekxU2w63RZmw4uHzsQB2YSMNUJELNLgYo=;
 b=enVrBPPZed9bU3uBcRSoqPv+kESn98c10BWVkboUmqR7GyM2KHIvRCh7PckMpX7FAFpos6wxrw4AOvkmU2zxLq5RruYgGsEWJWDo1z8uNgoIt4wl0SBrxalnyC1drMS7Z0+9F8SBhDTHaWd43cqFJUPOyYyrYGPky7HNmBuc3MkIyr5SgBh5qf5N2Rca9gVSgp7ipT+rMO6XLzN16G+6TaweFvI1tihqqDxAp+HAEJ/NSic088Jo5mydYJ/7BWrLE9HA5t6bYqcD1j/UW8PKGiRPhEK/qBDdqz9lj7QwRjFxudJroUcVvYwT5wDg9siVv0ZrycUdnI2I/hVeaq4QnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:35 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:34 +0000
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
Subject: [PATCH v14 0/8] blk: honor isolcpus configuration
Date: Wed, 20 May 2026 17:50:22 -0400
Message-ID: <20260520215030.496803-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:208:329::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: e0912188-bf26-47a0-9c00-08deb6b9d1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|5023799004|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/s5Dr6YIPSbu+YH8gTqIo/uKMHQ5AIkiJ/xJudADBZcqfS73uO6W3tSZzvlLezkwSIan8ef7qHj8DAs5mvT85swHoFJ3UmTZGDyM1Z61CkCpAaSTkBtwmC0WR1xxD95YOpDI1yuGdRqGSz5l7XwsPwyBIE2IslSQfVm3e86xstyJ76f1geHhCJVXWvFpdcndf/rMFOq78ufcWBOAkvelOFHit9s+Mr7PYEcla1UTNhs2CvGmPA6HhqDlaLeQdSlQ3LO8TyuXxA65YxXfeG0LtNenKWwZoGiBPyb0E2uckuhYQCg83Lg4D1iEn8MGf/BvasfdoKReoHENbaIYR2Zhyn+/Bni7E45wKTfx9KxPdjB48aOJU8YbuYS3mP/gzgyqnrOoVxRBFvyfrnO8OD/tky5Q9PNK/j6Ccr7AvNm9SIhypHHpvPCJECQTd1PnqsQHA4lSFLOq8H8qN5RgQn0mlRouf6FrAMXAGtaZ+qzmt6+eAMpEeptRcA49mjMiz+lzuIJzCQyPSqgl7c0jITzNQXnsrLXRLwAmffKS+8ta8KB0eL960Q+9cu2UOa4PbjBaHS/D3pIa/ZZTUps+oyYLgLgHVS8nl+y8NxjNYS61HPEzYPmmYEEhbvZgZ8EQ97OdiDktLfDqVgRLBsL7w4C8bw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(5023799004)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlwO8PQMdDcAd8xIRVQqWM6cTdaH6U59lDtrPM6ye3sbgOT/ESGVI3gqVyX2?=
 =?us-ascii?Q?XQAUwC59iOe6OWg2rzrQKcxSkGaFB0rjRvWh/1qQ15JmvU15pn80P0ACDq6V?=
 =?us-ascii?Q?lxBRKZY27V+zN5vh9xT8Ln/rx1Z13l61qwwbu9DmPChEtqtGun/dvFywdajK?=
 =?us-ascii?Q?zREgn1GN3fZuvHfBSma5mI09P83bA6g0dBqhX8c7QP+13InQwRHQBuUWAU66?=
 =?us-ascii?Q?53L9nXywamaBLrDbDILt9qFZGnwovf6foXToboCUr0l9E0PQZfybtnr4RxDO?=
 =?us-ascii?Q?SvS8NizAYQ0f1SajJBUqlR4e8ZAE3wfhxqlGmHzFFaOM4SCPilh84l/t58Ji?=
 =?us-ascii?Q?28YQ9+qH3UaaN0GYXzvYz049lx0FVQkLW2dyG7Tg94R5A3U51ZKGp2x2wuq2?=
 =?us-ascii?Q?JsWWE6yZ7/dTKvSOyrTrkvVaqNPl/CtWpsKsQsdymz8Ie24UMnAw5BSvSGVR?=
 =?us-ascii?Q?+gL+8IgpYczUuB2Ft6S/uC25nGEzM6qJ+IhmBEPr0FirAnV5awf63uZAPuAp?=
 =?us-ascii?Q?mwEOQPCJdGW6SS4rhMFQkxTeAg5yhmdgC+KkC1PiQ/2N7ki/b6RJ0r1fV48/?=
 =?us-ascii?Q?DkE23rH65LURZRl0fErWbbSUJRooJisUyHtp6uryi0xGNK79dp/4PKtOF12E?=
 =?us-ascii?Q?be/gecAWRrRXF0+Z7gXFi6p0KnoF2tz4E7NlWmROlvAg+KXJivMSTH+glxmF?=
 =?us-ascii?Q?6WAsHlPYv10mg7s33EVHYQZaW8CJDzi5YslJG5LR5i/tlyqhkXSt9Y5AVwAB?=
 =?us-ascii?Q?ZRQaPwQTqecj1RxP5tkpbxEGu3a5sKvfnoZv6ghgYz2wLZx/MZBhojtBUW+M?=
 =?us-ascii?Q?N8IR0ur63jlZEt0CLG9rRIk6nCQ1d5Zc/naKWIMBuy07DyjgXugGn27EG+gS?=
 =?us-ascii?Q?SUWo7hWkOhV7lY6ULj+kEYLQdchLkqpbPgkhruc3r8Nv7aIZEj/dvT6MCXTd?=
 =?us-ascii?Q?GzgC/OcFVjgSWGhAkIsnRsekO4/J/c5Zt/ZHyBuhEhKZXC8yOBkTFvMJQxL7?=
 =?us-ascii?Q?Su9HFamaKKCryhvuZ2/EG9ZSwJYzmgfamOqQEnZ8Ydk6NkiEwmMmU7u2Ds6r?=
 =?us-ascii?Q?GPzUKPp3prYGTiCPkRDsJzUg6IZykVmhzF8C16L2aZvpyMuAFxp3V1NMp3+E?=
 =?us-ascii?Q?Za+9YmfRG72D/g14AUpmFrQ8TtqYirsXBfvMs1CWuxdTUAMkDoVHoVkAitIJ?=
 =?us-ascii?Q?veytd8nfV9wwZ79ld2qZWm8Q7hXSwu0iG8bsgn4KbtbPeQm6nF1z4YSSTcmW?=
 =?us-ascii?Q?4d5Tb+ANEyLNEF41mqvG74IAVaC2KlT7wxWOnM4q5VQV1Nfbt9i6olwkBOJx?=
 =?us-ascii?Q?H/iRMk1x/pxMdfmAX/8KUO87Bm2t6qIOjz6BGqpy4dd/h9nxTY0rkdS7C5qb?=
 =?us-ascii?Q?fl0YSi1F9yv0JRU1ym5oXWaPVdZMdzrNGbrEt2CdNvRUq78TnN3DwZGrjy1B?=
 =?us-ascii?Q?BOvABlSXZV4S82vKJfbf/+2UL0CXbqmlR5KGa/x5wgXr6Ic5wS740wIOhS5U?=
 =?us-ascii?Q?j8yvKaqDKHKTeqTfApHKoQsjPQDA1EINEcc3+h0dl4D1O5fbMt81MidnuES9?=
 =?us-ascii?Q?V2mCiAdqYZB0NYH8hi4eHCrmcqnQledn2NYWmUjJluDwcYQ3TY99UoVTkpNF?=
 =?us-ascii?Q?u+/cn9b10t4S1q2A1/gR3OZGpTWGxZUVTuRLKHy/PyORAu1mKCF/xwbl1neQ?=
 =?us-ascii?Q?2vQAkhoKReVI3Plz4D36bfiwR3MtG3gLyFP9n41ocKdnDM9bEA2j1MELzkYE?=
 =?us-ascii?Q?l0L90jsqmA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0912188-bf26-47a0-9c00-08deb6b9d1fa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:34.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkAHWK8Ez54+l2VFx/joBc9+R/SN1Un+NbaRWlfIk2u8Gx2FJHOX36J3SinV/QU2AHKdBt35oJb6qtGLAylf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

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
 block/blk-mq-cpumap.c                         | 233 ++++++++++++++++--
 block/blk-mq.c                                |  49 ++++
 drivers/scsi/aacraid/comminit.c               |   3 +-
 include/linux/group_cpus.h                    |   3 +
 include/linux/sched/isolation.h               |   1 +
 kernel/irq/affinity.c                         |  31 ++-
 kernel/sched/isolation.c                      |   7 +
 lib/group_cpus.c                              | 108 +++++++-
 9 files changed, 422 insertions(+), 39 deletions(-)


base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.51.0

