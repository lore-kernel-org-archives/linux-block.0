Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022104.outbound.protection.outlook.com [52.101.101.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374939F160;
	Wed, 20 May 2026 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313850; cv=fail; b=PLm2+/1cdsJvmZ7CzVJXdXNE7O2p7u3VkbpIv5NC6Egdn3GRNodFNvDMsmLDpAb2N/H/4lpKEXHzkiYU8EZ+xPU+Vo0QXpAdN1t+agJySz1HILkhB1XY5TFZIJtRHsUWGx1sdUXU2wyFJGIzWEoE2IrKZ7+FCzV9bN0UsingcZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313850; c=relaxed/simple;
	bh=hXNp73LStpJu0P5docvAKs7XTN8rNNa3FfSzIYZk/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nqt8LL+zPaBexl1XlOb6t1Ftf7dlJIjugVhc9KaRFo2ZcUN919o2qlOiSun6BlsO86vnIYTK8/nE1nm6vSvZTj+FxOuaHm90FUfzU31mrUGS5GqKLcVVDCJCbUu4CUn2+Jxg8GgOWTpN6NJjyQi15in2PhIOfcRTXXE5Gi4vVe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjQPOw9u/qe7Ro8eJtet9QWNScgJh9p2UvN6Risl7iEcTAV7y5sydhmowPzWi5+WA5UA/tpgzYpE96WR9wXgXsAZUdqSzZFBXTYczhmMGoQUuQHXA4n1slX/6oXGIgjs3bvsGofgDv6DCKwtEJQol7i0FT80sBEQ1+Nqw7u+j9oT8tKOMcWF+gg+U1Dei+/0yZUAZ7xtEog83GuA1LYvmid+t3yQPEM+xfCh6u0iEc6gZnVsb6KNMmL8eDAVsmG9N4duhfhNdcgzZQfgmllyZ9MjivI9jDBcTfeq00G9v0mFAZQWYkcn3z+LNPr/OhJ66MmlBH5uTIWLQmoeeLIQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaOB4wVhhGa3ZpNrecnHrqVOFjn11m/h4x2rBCwlxZQ=;
 b=Ufz//vFBfcrBmXSYHn7oDYTS/HH1nusc3cGfcTLynC+y1TlbOqkbcqeZek+D3fvE6OOUnkRD+tBQ+Z/JejaURv6c0wkp3MNTY9zyDXyBkPuVgw1kP0WJlnFeYcl40XFwoQ6kyvBJXtK6//K3zedD4Am90fFPPA6VySX95TCT1gLtMYoO0ZK1tYJnILWnE69jeb7Psnb8IyaMXHbWB8V0ycAmGLgj5TzSeM9o/ZansFPtg5sldUrX8WuQGnIaoar4wOvm+16NdcrvUqhZ2TnNacZ8BCoaQNo2RMHtsGzz1tOjV6JdEReWEqm7gzEyElansDMIMwfg3Qh7qpE4lnOjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:45 +0000
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
Subject: [PATCH v14 3/8] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Wed, 20 May 2026 17:50:25 -0400
Message-ID: <20260520215030.496803-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::17) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdf1b15-4d2f-41f4-6a27-08deb6b9d865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A4J6J5F6LKmNlmwcy7gb5OsCjcVwKLfbF9PwRKW0b+AYSOqAan7PweJzJwpjoAXVoXC322Iz0VmDU5QyoRxf+N/USqbxFs8SYvhZdTas6bJ3WhxHH+uldAhUcTx0N2DcCr3PXKm2yKuDOnJppqAs9uDEsve8B7Vmscq2qk4JfmUCI7TWi5zcIScVNh5WFGiV8EcvfLg24QyUBWMjQbuD0ZcNfOr1F7jJ51q8YBzZzU1Ma6Mh5PzxDMZJXJyy6jBghA66ePHiCfi/qhai8cVn7UwqFNAyOW1qCMcMdKsAfgdKwqCbr9y+pVIW4cTO097fO6X8o6ii07/89IuLsgQD+7zPxolthY+Yzb/DnV/XT4u1TwkJaI8D0S6WI4kDY0c8v4zv2R5wj8ZAn+EAu9J2sOyYz/SqY0+UFljKu/vK+Qvz5ch2IW0UVyqVDYArvDOsrkUmT/+GB0ktc4DsyuwOvKayY9LKKyNjwSnUjYAZ6igXEuPaI75ku8y/0m5+IOaFMVfVV3wris4ndwufkVQlT1HBFRHP3HyLzl2avY/r38z1a7ayflKV3Pc5kd9mA8RXSovt50XuwnMEYhMT8fQtbQMAZebq5auC+YDzr9BMZgF7uZR7e4PRtOj/wkVwkKGrYxaxzzUZkAsJiF52JZiGb7xR0+B5uoaRyleCIqQZoyTR2/KukQG9JcpTdhrvORPQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOZbhPhSEqLybdf0FqXIXS0JXPfBjAHGSyjoN2sZ5EdJVQe6JBxIsgrhvrk7?=
 =?us-ascii?Q?Pkz1LP6u56XCNPYoPX1q2UpsHTr+jRsiKtXdntUhC6z9REtC2mLzXVptoSCX?=
 =?us-ascii?Q?i1IMnGQTQqHrcokOviF0qGV7VPtXkdH0iw6LgMO86DCS+EUix0HyhBBM3Y5V?=
 =?us-ascii?Q?0czwzdPgI2Z3wryJtVpiV9ukELKAs5DvUMMe6GI8dTc7PFAKJdyj3mCc6jGE?=
 =?us-ascii?Q?jVamWpsXioqB6EVUeTtlBk6E0obYXRl19u/XvCgNx4cKiDRgHMw8Z2jqAlgI?=
 =?us-ascii?Q?w62ZP8qVT2kgfiliUHNyIh5R2ZfTzL1ropyfdFDpcK7rv48oazbmYaeeBfII?=
 =?us-ascii?Q?V/gMhMU/pZybbUZML4qVH47bOqBB5O/fjmB9V3RNOf10ZH36vmeK+9WM0Cx6?=
 =?us-ascii?Q?d9c9aVAR2tlv1mQdA4gQgNFwZSx3jlZaTweslmndQPaG35oo3/+TLQcXlPRF?=
 =?us-ascii?Q?dklPtBqsUHStHw7znwUYGCZvfK6WuZuESCEBq28kSFq/MyEruF/OaCmvxsdP?=
 =?us-ascii?Q?aNHG9snzpU1FHpWgfYmMerrgyC0lIMfuhplzl9Omlq+PgOJNRir+70MVzDna?=
 =?us-ascii?Q?RbO7NO3uCfjqhcBT8i3rts8TWgcI2xPGUDW0RdTdiwf5NEWI4tKAymD3kLlN?=
 =?us-ascii?Q?lcqAkR4OHnwldcDGmgBkqPb/0pfR2Zt1CW0kY9MKNJSqebzKCBqN1iUpG9WV?=
 =?us-ascii?Q?tphB7B12VUwI6RlHCkyGnNyZTbnx/doyWCy18YqcQvg7M5vKSHdNxAEPSeFp?=
 =?us-ascii?Q?3wbSVVeDJm3OG6AZQ4VOhN+HrvAnW8WNi47ZMt9/KwzQSQC6Jop+3FhbB7fP?=
 =?us-ascii?Q?e9fp3iStOCKY2XWKlN5RRSSB2UENrDN6f8kkPKSuNBdF8dbQzFPXjCx0V6nR?=
 =?us-ascii?Q?GJe9UZRYW6rJTzim641/CCsdM0sGBZYEbcSOPgZYfadAemOLZ2t0dz5LTU83?=
 =?us-ascii?Q?OWFfsxKYhyDW0qCJyvZ9PsshSKI580oc/tp/3inLunlnOTw1XxCYOShnaTO0?=
 =?us-ascii?Q?GXO+GjUGglxAVuc5VVwUsBCciQw/juO+CF+Q+zmdlFFt+2Knf0RWxlxghBpR?=
 =?us-ascii?Q?ioQyFMaCV8gB8lR49BXizjUDPFmpgtjI/Ndgr87o3YoLUyvp/3wmmFU7aE1u?=
 =?us-ascii?Q?dQzzhGIaBi7LIioWgonA/ukdPctvHkbYIgc9tZEVHqJBewJ6j0wiYWQzPHN7?=
 =?us-ascii?Q?OjzsDcGVkt2HS72OisP3qri4mk/jmpJN+f1m5SBdL0W2LI21ggCuNuZQwNag?=
 =?us-ascii?Q?BVclqxZsrIFM1wRbIjVqtHsL3pkkrIYb4yRPfq7pJRUyUcz1KU8P4MQLXjh6?=
 =?us-ascii?Q?qMFisXXgQveis5Kn4yzg9Q/X3L9Z0QHhVtLyRtihBm0IGCwTV4orVqV1HufT?=
 =?us-ascii?Q?l4ZrxFjnOxLWYX+TeKgO+m6Hn0301IBhV2xhXnfOxkPY7Up1ct7lVY3KFpVJ?=
 =?us-ascii?Q?nKaTxTepkaWXcNT/7NokNqzBYAP+90r9ZTM+ixsZQPFqfHS/SaSYV+hH3vZt?=
 =?us-ascii?Q?twhx7jeCbMwriMeCWADQoCHXVCzqhnyjI7/E6GAZMAYk9dNXBnXecy7saUrx?=
 =?us-ascii?Q?Y4wFzo2pfZw8lH7ZW89ndwUKypuXHHSfgRCWvbmB9lvmg/UaUe4xrrAHXhje?=
 =?us-ascii?Q?V2lyCgIBOWdC3pyfmRrh+tmnqrQnpXALd/ZLfspYtaQGQcSXIgPKPPICLDuD?=
 =?us-ascii?Q?Fkhg032o6uwUN5BPfitKDE1pwAprtwZv4tuY/M2fVyqIi/TM7cgYFl9Tn0z5?=
 =?us-ascii?Q?5DiQCg+C1w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf1b15-4d2f-41f4-6a27-08deb6b9d865
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:45.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeTC7gOo2GEm7W/R9HWJHeDs0jMKk3WR13qRZTxCEo8kQ/e1pRBd2QQ8ErdtWob6YJhaCJ86WCJ7MMq3fbSL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

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
    - Removed ineffective data_race() annotations around cpumask pointers
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
index b8d54398f88a..8503ab712e42 100644
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
+	cpumask_copy(local_mask, mask);
+
+	/*
+	 * Grouping present CPUs first. We intersect the provided mask with
+	 * cpu_present_mask to ensure that we prioritise physically
+	 * available CPUs for the initial distribution.
+	 */
+	cpumask_and(npresmsk, local_mask, cpu_present_mask);
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

