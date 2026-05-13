Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021076.outbound.protection.outlook.com [52.101.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11216A956;
	Wed, 13 May 2026 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633720; cv=fail; b=aATbmbrh1b6dPOubyShGewT6NcODaZCjc7PnnUlnkqmrhRIhMsKzlzw1+OL6cMhEXSINmsML3hOrORRMMeNvH4Yql0sK91vg/dBlavKPqO4LLzFsc9UePM31yXwM+0HT+Y9157ZqqLjSxaG4tvSIvq22+vpzh1mNCySkqId/5Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633720; c=relaxed/simple;
	bh=GTUxGFCY34WjyM4lXM56tO+Uhqe2eu3uD0f9Ntwn9Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X4oOXo+ZHu2DvgqDTaVlxryX5YJnXJCWP118IN6MQyHVWXWF8JHaJwnA1abmSZLUFQANRXtM8F+FlVby+I+nW/RcclNH+6EyjUym5bVwg57Y4PwWa8KR8JWqjPmtxu8d60O4jARwKYvFPWyaC8V6ZzgIVoBsaBfWm+AqTyutrOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCBATpOf9fX5yEa8un5X/n0TiP6Qu8NsueDYBUNWBYbIA56DPXq2fwChT1K1KeVwLjEHNpCZv0F763wJFsv3W5eKwjBjwQJbieaRC9ec7MqP8DowisHTrAZB1cHWJPwEdNoxzcPzgnu8XtcD0C2u2bVmxIKQREsCR3iS0tIV21VZ4EyP/Qeo6NsS+gIbzMD1lij2dBIfM8gRoQzRQ8JmQ9TBnGgEILo0GXOJrRzRJhadM9irlajGdWTVzfVJNh2p40olxJy/AOKrX+4FJcqcEbqK057AoPsYwiAc0IZ4sfE5UMbP4rHfePInVF1NzEL+GQb/2vqhtri4cbQw5B0g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnuYwV4/Eg6N1Vdx0buG6NHC/UWLngh/hjtmtMgnzp0=;
 b=zI1l5a5b3moN5KWOidtt8p6xiJgYHRi1TgKxD/zevUV6iS4EaUF+zyVNqG2htO/Q3bJPOwQdDjOY2svavbUrmpWm6x7gO/5GYZivLt2tLE3oI+zP8yrJw6mlo3rsyKFFwht/Bu024XhYdTxIB3b+E3l9Z2SpZ8SeHOlBdIKc6gSvrOKPTtRuBHLYSt5QthLX3vX1/zeQ47RKkQASxVWEJb2PT9f3hj0q+mnCad5yziHy78S1z6bISdBKujU0Evo0G9g2qeM5fAJfL46B+can3dNJ6aG6QiIGLbjdeHz254OAPhUFtr9OeU/vvG8y7S0rMQivhsMkr7SO5ud65uW98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:14 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:13 +0000
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
Subject: [PATCH v13 0/8] blk: honor isolcpus configuration
Date: Tue, 12 May 2026 20:55:01 -0400
Message-ID: <20260513005509.135966-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0684.namprd03.prod.outlook.com
 (2603:10b6:408:10e::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b1630f-1ed9-4b30-e9c7-08deb08a4a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HViWuuRYUr3kDXnukEmC2X6R6LpmqGg4ejFFLp33rioARC6kzU6o9QZRTlYIcEvyUXMp6Isan2Xf7zc0afyHf5WDfREqJOsEd5/Mgh19j8Rr9oimtKpb3XHYc+qf+gFftJ7cTbO+XXHL9IIZ3JMqU5SBtrsRsPauuueXDp2ESlvd2gOHJr5AY8/h53WXSPUKM67Vp8gHyFig3beZaNs116Bx8QoNvaLWJVI7NkIOJSquFPSFdU+EexN/+LkhvDn6IU8bKUJTb3sbLf+aKbOSYMCZsWVRSK/d332ze8LrP4Ctw3siEsu+Mx+maTPUATSR0ZEKnbz23pA7lFSD7BB/cv4GDB9CKYfOH7EMjzEujJXfLezIHl0KA5JY4qZQ09YywVXaDXn0is8lmfcHrE1eSlPAOoXAT7pj7Zs6wg/+n71E0WBBo7KXUGb1lBjnKccVxmFdWGXXn1kb/NtV9J72snXPneni8DGW8eqEvvVcSgO60HO6RnSSWN8p/7S38/6B8p9eHwlE765WCauEG0yaoEUgOJ721bp7QSSZS2twi1SF5h0l4U4K+MZw5Vdl/AK1YFSiFMGFt2MxRmxOovTiYltOnLDooNQi17o2VpiV5+1nu0pdFSm3zSEV2TsbYDm1uvhD/+OObPxywMsU29zpSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKmoTN9gcnGuU7KVfW02nxYbYsF5cBIFcm1m/oj4ZG/bFkykJQzpHmx2kZRT?=
 =?us-ascii?Q?ippKFM9745nUrh6e6JDnHIjz//dSAEsSbcjnYHeFc+vL6JSlU61O1MuzgIKJ?=
 =?us-ascii?Q?7imTgpaCPJjRaHZV3QsQfl/OeLNCnM+B+ZrLEdBCdwRyTk3OdOO1PjmgWAl+?=
 =?us-ascii?Q?EXcmOu2hxKeMNng5mKHb1FjSsdyXOrLqNV2/6T5wqIlZkuj66bYsIwOMJ/4q?=
 =?us-ascii?Q?hHa761rWtIkyPy99v+vfwyJByEACn74Fv/FFf8TQTJDRR+bVys/Z3juV37CJ?=
 =?us-ascii?Q?k6EvXn6l7accoyYazH8JFsEBcGd1noo7w+cgd6nqSSkv0yp6Zg7Qu0YD/iuj?=
 =?us-ascii?Q?D0KuE11tC3pF/bwLs1iJDJkTc07D/dzpnDRf31EUN3OBOIkHzx85McLPgJyz?=
 =?us-ascii?Q?IasrSAeH+vdZi0dbCgRXwwZInanUYry/jm7CRgyZS+wv5H7fLdnYTNrUkdFD?=
 =?us-ascii?Q?qV+WQSvwFQ7l7FuiAHUJr1otTpedgD7LjnhjcVp1lCTOKOjrXerLDmQMLKg6?=
 =?us-ascii?Q?tbz0VamvIBfb0kQw3j+eSPeb4lc6PmGYqjc+KdwQyqasRkHczvpBeQ4yV+9s?=
 =?us-ascii?Q?eW7wMgxBOkB/eD1IAFNcMmp43DP6u4bbAETrg7ltWN1zSRmbUnEGjkL2guab?=
 =?us-ascii?Q?slnvjXF/+vdhT2Hr6XG8TsAraU1n7su/K0+czD+00sv+4WpzQYXd5/vSaFBB?=
 =?us-ascii?Q?bq15Ok3x1oedMLPDsUJgmhCqe4PVRPf7bqqUC6pQThHj0R1eN+nDU6dFr6oK?=
 =?us-ascii?Q?sAmZ63wy2OsS8InzXpPn5X9AcL1Q5uvgSKJo3Jwi/pALFPthT7sT6cfxJWb9?=
 =?us-ascii?Q?+XvMEGFJ9lzQgbXvm6qh49/r1h4TRV5OkqrdyTtvC3EjcppreEwzenmksyk0?=
 =?us-ascii?Q?Uyz9WlIMVaxWMisO6zgZcxcqVJAyV0nwiRXx5XN0FAy1s+lvToh8lMn5YRBw?=
 =?us-ascii?Q?96XEj3pM4dvj3UmTPmNcfAIh8BwS2MlkN5OU79fpbMa8K1dNXxcyOgHTruLk?=
 =?us-ascii?Q?Ksz1XlFCe6yBbMdTrbdu0hhjpeC40jf0ecPHOFufcoJ+FanH09u1KoL3USvK?=
 =?us-ascii?Q?GDfg274x1wAUBITM7DsgUAoUTcp0VN3UWesYKaYr+STx6xRBPPckZF5ArOUt?=
 =?us-ascii?Q?q4wFe/siiq/1qpbtzgAv61MrpcLvZwWvpLlz1w7fQDlaIF9EgJ3zAYrozPXw?=
 =?us-ascii?Q?64Z2QwiNjc6VVkL7qxCwXXxu4J5a64GJQzqD3EVrb/B6l9qwqEXYEo86gRtr?=
 =?us-ascii?Q?FeVza5fdFlmIgdVyCfjSPgcEsp3l6SbUK7xou3vRpyuCfA4igkJ0Ub+zNsZG?=
 =?us-ascii?Q?1ji13vfuid+xwDAEoELvryAcDrwHnGnlqNehF+nB4BicXP3MRQ8FfY21b+R5?=
 =?us-ascii?Q?ZRt8sGvOYOwHsRmHCJN2IpkiIEWN0IfssliC5tFMeUkSoL35ppZFuMS68iG0?=
 =?us-ascii?Q?MwRYLwLMVxWn93cJ1i+baO2Hc1UqSGvDkB1LqkwFqyv56rQjweuJ2sUQYgbG?=
 =?us-ascii?Q?l4XRxsHrucb6k/OuxD3JiEEjWH8L89B6SjC8k5TViyUNu4YJBPx2w5SqZtRu?=
 =?us-ascii?Q?r08JrfwraLN7IZRgMvDRFBIB47X1sj+1Dv57v3uf41x6kN8zlisGKAb2Wdvw?=
 =?us-ascii?Q?zBxFaMXTSEPlUpLS16P7Y+r5MbA6AZ8Woa854evWSJpO0IuQSNxbOA99+SNh?=
 =?us-ascii?Q?IY/L7uoJ6F/HIkq2mOGSOJ8OzW0mleD80BMbOkWvCaLp1UGBBA/Xft1UA2DK?=
 =?us-ascii?Q?SvA/6NxZmA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b1630f-1ed9-4b30-e9c7-08deb08a4a4f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:13.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVCYsWL6n01Vx/ZeKt/OWSpBUTTwFHM3Ib5mPVuNmNi9ciMIQ2lGduZPeFqokRjQkBm6kvc5TVWCvRp08IUNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

Hi,

I have decided to drive this series forward on behalf of Daniel Wagner, the
original author. The series has been rebased on v7.1-rc2-593-g1d5dcaa3bd65.

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

This iteration abandons the complex "top-down" mask plumbing introduced in
v12, which modified struct irq_affinity and expanded block layer APIs, in
favour of centralised, direct isolation querying via
housekeeping_cpumask(HK_TYPE_IO_QUEUE) within the genirq/affinity
subsystem. This architectural simplification successfully decouples core
changes from driver-specific implementations, allowing us to drop the
virtio enablement and API modification patches (v12 patches 4, 5, 7, 8, and
9).

Please let me know your thoughts.


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

 .../admin-guide/kernel-parameters.txt         |  30 ++-
 block/blk-mq-cpumap.c                         | 224 ++++++++++++++++--
 block/blk-mq.c                                |  56 +++++
 drivers/scsi/aacraid/comminit.c               |   3 +-
 include/linux/group_cpus.h                    |   3 +
 include/linux/sched/isolation.h               |   1 +
 kernel/irq/affinity.c                         |  35 ++-
 kernel/sched/isolation.c                      |   7 +
 lib/group_cpus.c                              | 108 ++++++++-
 9 files changed, 427 insertions(+), 40 deletions(-)


base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
-- 
2.51.0

