Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977973A1A55;
	Wed, 20 May 2026 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313856; cv=fail; b=ikZL5v7HRCe6O9h5tTLzeZxsYXFts15wX0Tou+I4n/6TO9VZ8fN7VrviAVwVDBlzHC9pqTM6+OnqkmvOo7426POL6zGBsDBoPoPSe9mLnHPPaykcxep+dlnuqpRJz9ehA1BQycgwT1tFg+mP02iV+uxO9H3uW9ibA6OgoQDwBWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313856; c=relaxed/simple;
	bh=1SNI0LOwbRLSEdkCLnhgVbNdodbDx9QSjFN9GuabouE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdFMVXKOxvihb9IUxEc/D7A1ejgmTs6tYxYXeMCLyaCeZfP7OzOf063Cg3dd+Phwi2fwkheON1Au68rhpVDR/+odV/FwYbDWc9gzUrADHTUmBInwJeUMevIvDYAVWMsPdCKs6AMy1X+hk0+cvuNghMLQ1tzuECjW8OTvEXFYofc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biDnmdzaBjBa1HZyMMWu5nvpSFdaUpx/0+ilKPsEri2VdiOC4hQtXutiYeaHAl4kJOA3fakD57iuBbpIbkELkI7/WtexAVhmtmPpprqHgi/jGhUzML4Jy0qWXc71dqpcNtIGtaKoKCV36xLRkew4G4OkxpEO5NSMgg1sG1TH1FIWVZp+TaaXtE4WyLmr9HEVs3Huqcu5MghiBzCxxDnSeP/K5WqCzJO2DR8aUz2faxHD0qmP3CCfKTS4O41aG9/DMzUmLA0StaMlaBzzlanWdawZzIPx0vLCllnYqNm5bizhG7ESlNh2/QZcm3bZxfJPE5A4Y27Jw9fGSKuhDRTHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyNpgLPglcJXckX8Y2LIHEWItAxqmdbC20GkdAgnYBE=;
 b=HYKjaIQBWH6+QC4d7veVoT1FaAt+MZuQ7+ZQsy+naHSTneXgPtcxhk3eHA8qubodrLVWaVsOsoSwkwOEC+zSUp7294P+fuF4qxw3nYpagITWngMHHKt+6UXc10lop7gThu4gYYCMd5XiEJR/8n6QHpZElkicVjyrAp9CAeS9/zgmmrw/1a8HNCGC81t2pLKdK4K5vKpXMyzn+cImpphW8RVlSaleMhZKJOxaydLMwIXNG+zGrIRSt3MeUyGCCnhcJopy2axoi3bXayChjq9kPaHtK3ViZPm9y665u4ps2GvR4nE6HbWvHSGG4wGkPbHSbVF+NJvv/pcLD8/ieQYM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:52 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:52 +0000
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
Subject: [PATCH v14 5/8] blk-mq: use hk cpus only when isolcpus=io_queue is enabled
Date: Wed, 20 May 2026 17:50:27 -0400
Message-ID: <20260520215030.496803-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: b360182d-a288-40f3-d236-08deb6b9dc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	upIsEncH62mVfACbgOKtjdMggtOBLD9kJD9A8yXsK0mg61yODhK0Om5K6SHspQoD+MlZbUdh4fHEK09kfnEcPTRuwHKM15ReG13obmzFtC7QMyWNF416mQou7OLuPulAKCu7MjjRXwnIEGuKCDQr7QdONalhDKmBsPVbULfFw194DRwkyFvqITzQW7D0gOcvqG5A0Mksd5YEXpyGjtqAv3+YZI5z9be9/QLrcdCPW4O6JiF6+AR5swgAjmaBdONoIwDAfvcOSOwROno7dTN2lcCUlxg74EBPCB01Ai6r7/8kb05VyZN1U56pOUdYR5ZsnUtjR10/PlwOpQZDlcteVxToRX952QeA9otp7cydAYcwnuqbayj0T3ibLxnAb67P8XwCiPRWZSDSfuD9pgPgN5lJC0vLpl2udHMhLSTvfGxIIB/fI8nM+WzZuUOTZh7sZVEr2lm4bHo6meHiuZ14R0Xs2TFvC6+9iClD+ar+jOlaB62p/k0sU83/9bry0SjUGuG32tZHNO1mwVgKu4AORfab3q8RRH7A/YbrL8F3FgHRgGv2YiQ64Od7Jq4k2srmCPq5ywBj0VcXjzYBmX8/8IesDbfRg7Y/TmKyLVEPVrhKJcJLqdIhkE0UcXqfwK2RHycNURmyXzuuonJ3KwVLhQRAbUv+xHNN5EKh5x5f1TPfTDrvMcWZ46WOpL61PbIy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMNajAtxT9balWowjo+NsSS5mVZCItbFgmnl9Owo294DgrJ2pR8JpU33uuw2?=
 =?us-ascii?Q?i7vSYKxP2Qi3Dixq2hJr/C8gTslhDDXAgVjpiRkCFwQyiT3FyISkrqfsE7Wy?=
 =?us-ascii?Q?oWxEDlwz61zVmKhs1OTK3nlEdUVEmvh8B+juu90BWMXaSIu51DMkIEffhVOZ?=
 =?us-ascii?Q?W4Q2Op+44OrJMKaV6IzykahAtsg9Vf+434xBm4/JYA/FRDCsY2zYzRWLEs0T?=
 =?us-ascii?Q?6pnxMqa6dB+6zCwZM6k41ko95mEqbUremSVdpczb4yC3q18D2RLRZV+EVggu?=
 =?us-ascii?Q?Q8ZICzT0V0wXaf0Pu/w9IQKRSRzBzEo7Udg3at+zyhh2uvUyebhWqBMxOPIX?=
 =?us-ascii?Q?uiGJ5BZ8OCd8I0lGOMZzo2yN7NXXtR3gWE/NYI/0Ocwv7YkgqKPXZgxArh8v?=
 =?us-ascii?Q?K+dbb1o7n5i6Vgpm3SAFwQxMKaLZh1NCM4tY0j7gR9/0Ri29MK2Bl8uYYzcT?=
 =?us-ascii?Q?iTalGBDUcl+dBR+3zy2D5LDqvBFwNlxXiSRHWY8AvF+0X0bvZC0trWkqXhH0?=
 =?us-ascii?Q?R4gwgi7PYsrHAMzP9OoinyOToCHgHTb4f5FSzrx6YXAuMEh1EvqwhEzMDK6f?=
 =?us-ascii?Q?1jPy0pLQowGLw2gns+3Q5m9BXd3KJ4v4MaOhI89WxSQROpfBhVvepu4WDU2Q?=
 =?us-ascii?Q?IzMjgtcC5DFzGVtLAaQ78TCJZtLxhvC+0HahpCy+M30AOtAkeaefLHgSwVM9?=
 =?us-ascii?Q?IC+Rn0U78Y1n6VPbVRvz12GicrkUz3iBb2+enFLSDd9TohFakG1g2I+YDvIO?=
 =?us-ascii?Q?fVupaClBZ1zS/LdLPL04+/aUVIGWqivAeJuEycFZpgE4tAT3UsYTYUc6D/HG?=
 =?us-ascii?Q?iEbs4WjKBJrQsyAydaCUd8FsKc4up+8nkMTzOJmgp4Zx3J/BWIekQkfU9bOm?=
 =?us-ascii?Q?DtW/Utx5gL2KtrRtz1cnsCrM4bXRJrPr7zKQXnd+d2R8NgZO7FdDijGUJxUc?=
 =?us-ascii?Q?YZuG8rXHjdHVW+f2wWoMBTlwAV1EX6+loND8tnpvxhhN4v9x18ToAPaoR0eJ?=
 =?us-ascii?Q?pkE+Lq0+wlBuF0j0SURxa9z7dwC3UoxnS0sL9RBhWylWjldGqeQzcOailS0U?=
 =?us-ascii?Q?R/2iRJtHbjZn7xBCEMdaoFyC1bceVJt4jWY4VTTnLqm0Xll84hDPBpCgdlKc?=
 =?us-ascii?Q?dNAPjDeygn3fKbAnhzf/IfnU+oumjalqZETedn5fZmDDXMcMHlyjRlVdpglJ?=
 =?us-ascii?Q?mX+q8b3e2FF5M+lYajbVIN9MsPJFoNSVHuO3btLsvOs1uSHfTQmTWMiQ5awk?=
 =?us-ascii?Q?nv7/8FmfF3x5hZyD1rblcOLZw+QoD0szFdYJBgc8I+ShVT57sWW60cUBJKZ1?=
 =?us-ascii?Q?7G8OhAFXDoImoWVPMc/P0N1D1OVcJ6Bg3hsBQ23xYaxQIiUS9LT+7M96pR/u?=
 =?us-ascii?Q?d2HPp/So1aDt787UsTGlNbQtZHArfZbgymvBD/XcnLFsLAVET7kTVyMuslxN?=
 =?us-ascii?Q?cypm7hWi6wlOSK916kSWjtaajyl5reKzN1jm9/lHf+O9d1HqpXX/FNvmAzuY?=
 =?us-ascii?Q?rP2mprQWnkSijwf1mFiXcHRbNxcdrzLqNFaImirlgd5Ieqcgy49TU8kCceC4?=
 =?us-ascii?Q?yzJcbCDTJGELLQJZP2wrifj7382AQVvMbO59Skk8K/lPO6zJHInDLH0k9Bhl?=
 =?us-ascii?Q?Eh/SIMeYJFTerUZXZElkOIlPQvqXrkpUlAYlSkWH9iqfzA1oc7nByII6gNqh?=
 =?us-ascii?Q?2dmldSUIWWM0UobYASOUYtLHXKtPcFxhTE+xnaffHCkLNwyEiHRdJrSJXTeR?=
 =?us-ascii?Q?gfzaAXDgmA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b360182d-a288-40f3-d236-08deb6b9dc8a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:51.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED6MAD/k1CedcV7T1kzG7PNDcZmDkwnakFhSNLgPB/mODYrZs94P4U1kbcrDdeKaSBXCumUrlrbHuwUrPU5COQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

From: Daniel Wagner <wagi@kernel.org>

Extend the capabilities of the generic CPU to hardware queue (hctx)
mapping code, so it maps houskeeping CPUs and isolated CPUs to the
hardware queues evenly.

A hctx is only operational when there is at least one online
housekeeping CPU assigned (aka active_hctx). Thus, check the final
mapping that there is no hctx which has only offline housekeeing CPU and
online isolated CPUs.

Example mapping result:

  16 online CPUs

  isolcpus=io_queue,2-3,6-7,12-13

Queue mapping:
        hctx0: default 0 2
        hctx1: default 1 3
        hctx2: default 4 6
        hctx3: default 5 7
        hctx4: default 8 12
        hctx5: default 9 13
        hctx6: default 10
        hctx7: default 11
        hctx8: default 14
        hctx9: default 15

IRQ mapping:
        irq 42 affinity 0 effective 0  nvme0q0
        irq 43 affinity 0 effective 0  nvme0q1
        irq 44 affinity 1 effective 1  nvme0q2
        irq 45 affinity 4 effective 4  nvme0q3
        irq 46 affinity 5 effective 5  nvme0q4
        irq 47 affinity 8 effective 8  nvme0q5
        irq 48 affinity 9 effective 9  nvme0q6
        irq 49 affinity 10 effective 10  nvme0q7
        irq 50 affinity 11 effective 11  nvme0q8
        irq 51 affinity 14 effective 14  nvme0q9
        irq 52 affinity 15 effective 15  nvme0q10

A corner case is when the number of online CPUs and present CPUs
differ and the driver asks for less queues than online CPUs, e.g.

  8 online CPUs, 16 possible CPUs

  isolcpus=io_queue,2-3,6-7,12-13
  virtio_blk.num_request_queues=2

Queue mapping:
        hctx0: default 0 1 2 3 4 5 6 7 8 12 13
        hctx1: default 9 10 11 14 15

IRQ mapping
        irq 27 affinity 0 effective 0 virtio0-config
        irq 28 affinity 0-1,4-5,8 effective 5 virtio0-req.0
        irq 29 affinity 9-11,14-15 effective 0 virtio0-req.1

Noteworthy is that for the normal/default configuration (!isoclpus) the
mapping will change for systems which have non hyperthreading CPUs. The
main assignment loop will completely rely that group_mask_cpus_evenly to
do the right thing. The old code would distribute the CPUs linearly over
the hardware context:

queue mapping for /dev/nvme0n1
        hctx0: default 0 8
        hctx1: default 1 9
        hctx2: default 2 10
        hctx3: default 3 11
        hctx4: default 4 12
        hctx5: default 5 13
        hctx6: default 6 14
        hctx7: default 7 15

The assign each hardware context the map generated by the
group_mask_cpus_evenly function:

queue mapping for /dev/nvme0n1
        hctx0: default 0 1
        hctx1: default 2 3
        hctx2: default 4 5
        hctx3: default 6 7
        hctx4: default 8 9
        hctx5: default 10 11
        hctx6: default 12 13
        hctx7: default 14 15

In case of hyperthreading CPUs, the resulting map stays the same.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
[atomlin:
    - Updated blk_mq_validate() to use test_bit() for the new bitmap
    - Replaced __free cleanups with traditional goto unwinding to align
      with subsystem styling
    - Updated blk_mq_map_fallback() to use qmap->queue_offset ensuring
      secondary maps do not incorrectly route to the primary default map
    - Added a bitmap_empty() check to prevent out-of-bounds CPU routing
      when all mapped CPUs are offline
    - Migrated active_hctx to a dynamically sized bitmap to fix an
      out-of-bounds write when hardware queues exceed the system CPU
      count
    - Fixed absolute vs. relative hardware queue index mix-up in
      blk_mq_map_queues() and validation checks
    - Fixed typographical errors
    - Reduced stack frame size of blk_mq_num_queues()
    - Resolved a TOCTOU race against CPU hotplug events by snapshotting
      cpu_online_mask to ensure mapping and validation phases agree
    - Corrected a loop overwrite bug in blk_mq_map_queues() by iterating
      directly over masks to prevent orphaned queues from being activated
    - Restored topology-aware multi-queue fallback in
      blk_mq_map_hw_queues() by correctly routing missing IRQ affinity
      masks to the map_software path instead of the naive fallback
    - Fixed a silent validation bypass in blk_mq_map_hw_queues() caused by
      overlapping IRQ affinity masks by evaluating the active_hctx bitmap
      in a secondary pass
    - Hardened isolation logic in blk_mq_map_hw_queues() to require online
      housekeeping CPUs before marking a hardware queue as active]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 block/blk-mq-cpumap.c | 233 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 216 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 705da074ad6c..3df5c368cc08 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -22,7 +22,11 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
 {
 	unsigned int num;
 
-	num = cpumask_weight(mask);
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		num = cpumask_weight_and(mask, housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+	else
+		num = cpumask_weight(mask);
+
 	return min_not_zero(num, max_queues);
 }
 
@@ -33,7 +37,8 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of possible CPUs.
+ * device based on the number of possible CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_possible_queues(unsigned int max_queues)
 {
@@ -48,7 +53,8 @@ EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);
  *		ignored.
  *
  * Calculates the number of queues to be used for a multiqueue
- * device based on the number of online CPUs.
+ * device based on the number of online CPUs. This helper
+ * takes isolcpus settings into account.
  */
 unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 {
@@ -56,23 +62,139 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_num_online_queues);
 
+static bool blk_mq_validate(struct blk_mq_queue_map *qmap,
+			    const unsigned long *active_hctx,
+			    const struct cpumask *online_mask)
+{
+	/*
+	 * Verify if the mapping is usable when housekeeping
+	 * configuration is enabled
+	 */
+	for (int queue = 0; queue < qmap->nr_queues; queue++) {
+		int cpu;
+
+		if (test_bit(queue, active_hctx)) {
+			/*
+			 * This hctx has at least one online CPU thus it
+			 * is able to serve any assigned isolated CPU.
+			 */
+			continue;
+		}
+
+		/*
+		 * There is no housekeeping online CPU for this hctx, all
+		 * good as long as all non-housekeeping CPUs are also
+		 * offline.
+		 */
+		for_each_cpu(cpu, online_mask) {
+			if (qmap->mq_map[cpu] != qmap->queue_offset + queue)
+				continue;
+
+			pr_warn("Unable to create a usable CPU-to-queue mapping with the given constraints\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void blk_mq_map_fallback(struct blk_mq_queue_map *qmap)
+{
+	unsigned int cpu;
+
+	/*
+	 * Map all CPUs to the first hctx of this specific map to ensure
+	 * at least one online CPU is serving it, respecting the map's
+	 * boundaries so secondary maps do not route into the default map.
+	 */
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = qmap->queue_offset;
+}
+
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
-	const struct cpumask *masks;
+	struct cpumask *masks;
+	const struct cpumask *constraint;
 	unsigned int queue, cpu, nr_masks;
+	unsigned long *active_hctx;
+	cpumask_var_t online_mask;
 
-	masks = group_cpus_evenly(qmap->nr_queues, &nr_masks);
-	if (!masks) {
-		for_each_possible_cpu(cpu)
-			qmap->mq_map[cpu] = qmap->queue_offset;
-		return;
-	}
+	active_hctx = bitmap_zalloc(qmap->nr_queues, GFP_KERNEL);
+	if (!active_hctx)
+		goto fallback;
 
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		for_each_cpu(cpu, &masks[queue % nr_masks])
+	if (!alloc_cpumask_var(&online_mask, GFP_KERNEL))
+		goto free_fallback_hctx;
+
+	/*
+	 * Snapshot online CPUs to prevent TOCTOU races between the
+	 * mapping phase and the validation phase.
+	 */
+	cpumask_copy(online_mask, cpu_online_mask);
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		constraint = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		constraint = cpu_possible_mask;
+
+	/* Map CPUs to the hardware contexts (hctx) */
+	masks = group_mask_cpus_evenly(qmap->nr_queues, constraint, &nr_masks);
+	if (!masks)
+		goto free_fallback;
+
+	/*
+	 * Iterate directly over the generated CPU masks.
+	 * Calculate the final, highest hardware queue index that maps to this
+	 * mask. This skips all intermediate overwrites and safely evaluates
+	 * active_hctx only for queues that survive the mapping.
+	 */
+	for (unsigned int idx = 0; idx < nr_masks; idx++) {
+		bool active = false;
+		queue = qmap->nr_queues - 1 -
+			((qmap->nr_queues - 1 - idx) % nr_masks);
+
+		for_each_cpu(cpu, &masks[idx]) {
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+
+			if (!active && cpumask_test_cpu(cpu, online_mask)) {
+				__set_bit(queue, active_hctx);
+				active = true;
+			}
+		}
+	}
+
+	/*
+	 * If all CPUs in the generated masks are offline, the active_hctx
+	 * bitmap will be empty. Attempting to route unassigned CPUs to an
+	 * empty bitmap will map them out-of-bounds. Fall back instead.
+	 */
+	if (bitmap_empty(active_hctx, qmap->nr_queues))
+		goto free_fallback;
+
+	/* Map any unassigned CPU evenly to the hardware contexts (hctx) */
+	queue = find_first_bit(active_hctx, qmap->nr_queues);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, constraint) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = find_next_bit_wrap(active_hctx, qmap->nr_queues, queue + 1);
 	}
+
+	if (!blk_mq_validate(qmap, active_hctx, online_mask))
+		goto free_fallback;
+
 	kfree(masks);
+	free_cpumask_var(online_mask);
+	bitmap_free(active_hctx);
+
+	return;
+
+free_fallback:
+	kfree(masks);
+	free_cpumask_var(online_mask);
+free_fallback_hctx:
+	bitmap_free(active_hctx);
+
+fallback:
+	blk_mq_map_fallback(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
 
@@ -109,24 +231,101 @@ void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset)
 
 {
-	const struct cpumask *mask;
+	cpumask_var_t mask, online_mask;
+	const struct cpumask *constraint;
+	unsigned long *active_hctx;
 	unsigned int queue, cpu;
 
 	if (!dev->bus->irq_get_affinity)
+		goto map_software;
+
+	active_hctx = bitmap_zalloc(qmap->nr_queues, GFP_KERNEL);
+	if (!active_hctx)
+		goto fallback;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		bitmap_free(active_hctx);
 		goto fallback;
+	}
+
+	if (!alloc_cpumask_var(&online_mask, GFP_KERNEL))
+		goto free_fallback_mask;
+
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		constraint = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	else
+		constraint = cpu_possible_mask;
 
+	/*
+	 * Snapshot online CPUs to prevent TOCTOU races between the
+	 * mapping phase and the validation phase.
+	 */
+	cpumask_copy(online_mask, cpu_online_mask);
+
+	/* Map CPUs to the hardware contexts (hctx) */
 	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = dev->bus->irq_get_affinity(dev, queue + offset);
-		if (!mask)
-			goto fallback;
+		const struct cpumask *affinity_mask;
+
+		affinity_mask = dev->bus->irq_get_affinity(dev, offset + queue);
+		if (!affinity_mask)
+			goto free_map_software;
 
-		for_each_cpu(cpu, mask)
+		for_each_cpu(cpu, affinity_mask) {
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+			cpumask_set_cpu(cpu, mask);
+		}
+	}
+
+	/*
+	 * Evaluate active_hctx after mapping to handle overlapping masks.
+	 * This ensures queues that were overwritten do not falsely pass validation.
+	 */
+	for_each_cpu(cpu, mask) {
+		if (cpumask_test_cpu(cpu, online_mask) &&
+			cpumask_test_cpu(cpu, constraint)) {
+			queue = qmap->mq_map[cpu] - qmap->queue_offset;
+			__set_bit(queue, active_hctx);
+		}
+	}
+
+	/*
+	 * If all CPUs assigned to this map are offline, the bitmap will
+	 * be empty. Fall back instead of routing out of bounds.
+	 */
+	if (bitmap_empty(active_hctx, qmap->nr_queues))
+		goto free_fallback;
+
+	/* Map any unassigned CPU evenly to the hardware contexts (hctx) */
+	queue = find_first_bit(active_hctx, qmap->nr_queues);
+	for_each_cpu_andnot(cpu, cpu_possible_mask, mask) {
+		qmap->mq_map[cpu] = qmap->queue_offset + queue;
+		queue = find_next_bit_wrap(active_hctx, qmap->nr_queues, queue + 1);
 	}
 
+	if (!blk_mq_validate(qmap, active_hctx, online_mask))
+		goto free_fallback;
+
+	bitmap_free(active_hctx);
+	free_cpumask_var(mask);
+	free_cpumask_var(online_mask);
+
 	return;
 
+free_fallback:
+	free_cpumask_var(online_mask);
+free_fallback_mask:
+	bitmap_free(active_hctx);
+	free_cpumask_var(mask);
+
 fallback:
+	blk_mq_map_fallback(qmap);
+	return;
+
+free_map_software:
+	free_cpumask_var(online_mask);
+	free_cpumask_var(mask);
+	bitmap_free(active_hctx);
+map_software:
 	blk_mq_map_queues(qmap);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
-- 
2.51.0

