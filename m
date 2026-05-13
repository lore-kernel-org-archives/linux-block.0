Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022079.outbound.protection.outlook.com [52.101.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7742D3739;
	Wed, 13 May 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633727; cv=fail; b=KZuzFNgbaIBb2yIRbIUjXDH6eyNeMYYG6r249VnEwLyIlWaxbter8+lcUwc+0gjkwSD5aHdLwV5V8FYJEQoLwewml6t7VUziDwybWzaTzPK4W8XgERb6ao0F+B3viIjaQMSiEZSdwDgwbtRp1Ku5DPZ7EJRvJROdQzRFnDsermo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633727; c=relaxed/simple;
	bh=PzBDfA3d7+ASQriMDUWfRKFP0iPi3stFY2fk68+KFoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLO+p8FbwBaU1MPhV5T3TADqGfYiZVUBtSHMxRFvaiIL/CppuYWdir705ymyrtIgJYMORMlfcNaRIsokNU9vX29QjO0xiosOCQPizDg4TFFnZ2meF8hvpb31khn7LL2vJ2LFZZaAE81ISh4G1lybsf+Hu0N9AGFzYlMSh7XNLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osGl0+DVSkTD5HmpTeH0A9NPFkR4FzbYIn/y5MA5pbNC3gmbtLePK6kcOeX2t7GenRKet04Cx0CvqyF4LULBlTTwu6E59Er4FigvWvOTQtruk5iwG9mM2P2ZZ4vremHY0jzxrlBZ/1IHHvG7HO2ZuldlGd46plCOIsjTTNQqPbEpPSFjmZIdDWgWHUMlT3BERIORURxZ86cIB/qzKeS6PTqAcx7U1SjtjhIP4qYYX9qmsl3sBqN7R5gNO4Xow+8aLKhLiaMjTiW1f+IiXKYCDOrHTVodufJO94rayRZFh+Lmm7j9a342WWH7kUQUngGE9RpgdO80Bnw9Zn2OvZkGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIszH2br9ZJYos5PXfUA4/flxCXriDxW07qzDbLS268=;
 b=a2XaTwVCFOaX7gVmqU+Z5u01qyxOuOhJB17uhFPGx4Xbw4UAfmbpwY/tvMUdyUxEm+VHYV/h1tvnv0HZcHuosJv+wXDe18H0nsuCi8m4goasfPnVD7RhsSyWrLuYJr+omCffR5j+a4ZR9MBeLHbSEc7yUj8KU37jhauCA1KWBbdknDF+nR3ZWC2Hp3JCLHyfADEcFEwvql8xcH7r/37hVb/TrNvlX/klqsHOX1+K+5rfytVJZ7Ma73zRdbaKl6mqH5RUmNpmeYRhOcBIkPkjp4cG/9iUewAzKpNQdvrBpJahu5hfALOSrbGEyjCM+J0jUNTuLGp5/ceorV6IBbqMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:24 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:24 +0000
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
Subject: [PATCH v13 3/8] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Tue, 12 May 2026 20:55:04 -0400
Message-ID: <20260513005509.135966-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:408:e3::24) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 582558e0-25f0-45c2-8e08-08deb08a509e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PLKx0DcsdUA8PTfN5nRhhGd0PGHRS5J9jPmgauI0YcKmwW+BaUaOMPYB/FeBcDKuubi2jVSkh/kFRGwJLgYGH1SiqxpQ2dsEzktL5M2wWGsyXW+Gi5+b+XYqDiv1MVQy/0Dpkrr08GvDihOfvHLyTU/UwRiMeBjCG/kb24Jvw83FuQ1FAnL5/Kp7ULjTVRPnKh8k0v83qqb5XEaWMxIm2kSMOW6wWciq65Y1i6lLKv5JDKdYTwyYvNRhRzw9RifSheowi2AZibG90c77/aNwwM7az6OOL4uEboOPnUUHdWVQM0bEhICFjSuyhUwOxVyOGouSFTA8Ge09RMbMs5dULAmoYLIfkFggpDOzgVvicw76s8LOodEDQxUneZT649ldRHNVDMUL9c2KZfLMnT3VUlNlxl4FlUOHFIPC8NQG2moTSkdP4u7xwSPGCWVZx8F07Is7Tcdeug7QQZUqH8Wliqa5ToBwXiTZ8ALwbQJlumYhm8yhFhRvD/j7IxC9iqwTaksTQe0AepKIUTYIqRYvMtgICTe/RQ8mtBNmCh9cgT+2EXco0iSCLc6afoTvcPjIhKH5oUrgtuYzaFhM5fwz/4wnp01+pMxZTy+dqRK7pRNdfNnOqJ0xBKpahc16PlsPKl7AzJN/oTfVK1+GnJKBF4Y59DgBoZHxRGxryzIVApS7aPfJscijlu8FHrDDbPBf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnyICuWMhCPl9GD+CECCAV1Yk09XXSrxrxEKlgdONseGDbiQx0LUPUFVrFbj?=
 =?us-ascii?Q?WXPlXaXr5VM8CEf61FpqB0wtLY3d8PERwYuYEhX3YdX/uyrzXQpivu3nu4PG?=
 =?us-ascii?Q?n8aQj9Fms1w/TgYzJoubnJCkmeZCZ3ksZsZta2LBGeBgORCwt/nMZyEzZRpy?=
 =?us-ascii?Q?/wwVyoXQ0VVlFxTkX8e9JzHa0RkExPP7RT0KGEp8MapCCfNI1AGH+N9oqV+U?=
 =?us-ascii?Q?SVNRxgSm2CO0rg0HFY87tc4/b8O9ELwKP9aKB6lfqA++YHGMz+ucHtciYvS8?=
 =?us-ascii?Q?67ujbxYQAJCM3cTClRsAhOCefUpyr7SQO21HhjoZ+gEwIjgZ+BN3QPmYOvu8?=
 =?us-ascii?Q?3mH0ugIg6sRA0yh7pZaxMzFolHs9RJRetVED6CqBQVQb22ztGODz3dlZxyoe?=
 =?us-ascii?Q?TqGl3ECJamjzPoHR0ecaYi74USPVft+Kk5o+IlzdTJ/Z9tFpfLfvGPhkAyNO?=
 =?us-ascii?Q?n1PS82j0gLtxnR2yv5ZAgwmAiTtlC0R+ytrYbZv2V7VfdNb3gGOb67IpjHgN?=
 =?us-ascii?Q?UEIrofuRY3NK4RU/FnJDPpz2YgJo9cFPc2sRIIaTzGmPHI8yll6xXbxK36VR?=
 =?us-ascii?Q?/xm8iqh1j0yuMEMA/+Y3ZdbNPRu2ZFUXGHVurJFyZMWLvL0T1SeTQNrM/chF?=
 =?us-ascii?Q?txcWxmtBrIeQ+OhUdqa1eJDWr6bvDGLV5xjPDV5W9kF5jEuAoZOX3D/oV9eL?=
 =?us-ascii?Q?fxisdeBG5sJZHQhKpq7oAF85v13e9CPnMQFstnBLH6KayxJxYFRkJYeiDu00?=
 =?us-ascii?Q?ZwLDactjo3zJ7xtjpLm700a47+12HpEsZps6ijJlvPcqHmtdylMNSoSlageN?=
 =?us-ascii?Q?GeKx8hhtr8lsRwCZA4BEnLvpRUFQEo/8RxYYf2U2bMY3LnsHMf6GcO0ZVb9g?=
 =?us-ascii?Q?ZAsED/9stD3QEopttsGhLsHiIwxTY2GyCX1XnbCxTykCv88DUBo2jt6VY8k2?=
 =?us-ascii?Q?Wv+IRxrpn9ESIHyp8O0EwrcJoFxer+sXlegilq6LPusYaas8Ki2wwYNHIP9h?=
 =?us-ascii?Q?ean8lD4Zlii5p8HNDotaaWuvmbhAoJQNZJaxc6pBsm2MuXD7wKnF1GMxJScb?=
 =?us-ascii?Q?ApUcoLvtvOau8lreJebNKlVwfiejXTwhKxco+z5PsG6tKCOPjzPezBisfTkb?=
 =?us-ascii?Q?ABTH5tLLOyJ5g24jh7jxmKBY8Rm+GHpqM6nVcLMf4iD7zJ8MKpT5ppdrDikJ?=
 =?us-ascii?Q?gAng2ZfaD4EI4bpQCdLKH5CgvvH3rD3L3l/kKuTgdxzlW2K1Jhnqf/jWRn8w?=
 =?us-ascii?Q?dMquYpZ77lTSt/UqCGgehGAeYdiVSzM0NtJzfmUOly1x4D95lAD+EDqOGP7t?=
 =?us-ascii?Q?4W8c4MEc8lmchRWXaBAUpqiO3Jl0eOOitOljPjxwgOFNpWKF2CQ3PCZgcJjJ?=
 =?us-ascii?Q?QOM2OhfKOkPHUPAotJHmTD895Ci5XTPho4vXylQ1vT8xAqOF5mKp44ZF8sq1?=
 =?us-ascii?Q?rF1keB9LhTtavVjX8dWwpOiBk22zb9/1GWX5eCHBwFxQA0SCAEsvIqG85GmN?=
 =?us-ascii?Q?M5t7aNNQ4zsM69jhpsPCnOAWRZUl5Z0/pji82Ju/53WtA/IsLJnYJdjT1sev?=
 =?us-ascii?Q?ibeix1WMIHgfwGvwmh98lxkZPUolgTzes//n7Gt0PBzf53+8IBV0S87Ba+wt?=
 =?us-ascii?Q?Hh+UqLmAHJ41CmXVfTJuCNjMkKbOWse6Ss3tggG6fA1e6PjaGMBSRaA4k/LH?=
 =?us-ascii?Q?mW1Khhr+AREUa8F+K62dDGzMznyMXwEpJMPX71uB6OBB/cTK4faMywuebN/J?=
 =?us-ascii?Q?BUZAaO8big=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582558e0-25f0-45c2-8e08-08deb08a509e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:23.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhlsqfDNEAC7L4Jg/UGrqfnqOJOJhol4ewC3bpBmLJjwZOuT94cRm7TaU2N8VcwrEl0XrSQNLwGi06DI5YJSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

From: Daniel Wagner <wagi@kernel.org>

This commit introduces group_mask_cpus_evenly(), which allows callers to
distribute a specific CPU mask evenly across groups. It serves as a bounded
version of group_cpus_evenly().

While group_cpus_evenly() operates on the global cpu_possible_mask,
group_mask_cpus_evenly() confines the distribution strictly within the
boundaries of the caller-provided mask. It preserves the kernel's native
two-stage spreading logic-first prioritising CPUs that are physically
present (cpu_present_mask) to prevent I/O starvation, and then distributing
any remaining vectors to non-present CPUs to maintain hotplug safety.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin:
    - Added check for numgrps == 0
    - Updated commit message to resolve typo
    - Removed unused <linux/sched/isolation.h>
    - Fix TOCTOU race by caching the provided mask
    - Implemented two-stage grouping logic to prioritise physically
      present CPUs, mirroring group_cpus_evenly()]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/group_cpus.h |   3 ++
 lib/group_cpus.c           | 106 +++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index 9d4e5ab6c314..defab4123a82 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -10,5 +10,8 @@
 #include <linux/cpu.h>
 
 struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks);
+struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
+				       const struct cpumask *mask,
+				       unsigned int *nummasks);
 
 #endif
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index b8d54398f88a..2552ccea743e 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -563,3 +563,109 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
 	return masks;
 }
 EXPORT_SYMBOL_GPL(group_cpus_evenly);
+
+/**
+ * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
+ * @numgrps: number of cpumasks to create
+ * @mask: CPUs to consider for the grouping
+ * @nummasks: number of initialized cpumasks
+ *
+ * Return: cpumask array if successful, NULL otherwise. Only the CPUs
+ * marked in the mask will be considered for the grouping. And each
+ * element includes CPUs assigned to this group. nummasks contains the
+ * number of initialized masks which can be less than numgrps.
+ *
+ * Try to put close CPUs from viewpoint of CPU and NUMA locality into
+ * the same group.
+ *
+ * We guarantee in the resulting grouping that all CPUs specified in the
+ * provided mask are covered, and no same CPU is assigned to multiple
+ * groups.
+ */
+struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
+				       const struct cpumask *mask,
+				       unsigned int *nummasks)
+{
+	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
+	cpumask_var_t *node_to_cpumask;
+	cpumask_var_t nmsk, local_mask, npresmsk;
+	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
+
+	if (numgrps == 0)
+		return NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	if (!zalloc_cpumask_var(&local_mask, GFP_KERNEL))
+		goto fail_nmsk;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+		goto fail_local_mask;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
+
+	masks = kzalloc_objs(*masks, numgrps);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
+	build_node_to_cpumask(node_to_cpumask);
+
+	/*
+	 * Create a stable snapshot of the mask. The grouping algorithm
+	 * requires the CPU count to remain constant across its multiple
+	 * passes. This prevents allocation failures if the caller passes a
+	 * dynamic mask (e.g., cpu_online_mask) that changes concurrently.
+	 */
+	cpumask_copy(local_mask, data_race(mask));
+
+	/*
+	 * Grouping present CPUs first. We intersect the provided mask with
+	 * cpu_present_mask to ensure that we prioritise physically
+	 * available CPUs for the initial distribution.
+	 */
+	cpumask_and(npresmsk, local_mask, data_race(cpu_present_mask));
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  npresmsk, nmsk, masks);
+	if (ret < 0)
+		goto fail_node_to_cpumask;
+	nr_present = ret;
+
+	/*
+	 * Allocate non-present CPUs starting from the next group to be
+	 * handled. If the grouping of present CPUs already exhausted the
+	 * group space, assign the non-present CPUs to the already
+	 * allocated out groups.
+	 */
+	if (nr_present >= numgrps)
+		curgrp = 0;
+	else
+		curgrp = nr_present;
+	cpumask_andnot(npresmsk, local_mask, npresmsk);
+	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+				  npresmsk, nmsk, masks);
+	if (ret >= 0)
+		nr_others = ret;
+
+fail_node_to_cpumask:
+	free_node_to_cpumask(node_to_cpumask);
+
+fail_npresmsk:
+	free_cpumask_var(npresmsk);
+
+fail_local_mask:
+	free_cpumask_var(local_mask);
+
+fail_nmsk:
+	free_cpumask_var(nmsk);
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	*nummasks = min(nr_present + nr_others, numgrps);
+	return masks;
+}
+EXPORT_SYMBOL_GPL(group_mask_cpus_evenly);
-- 
2.51.0

