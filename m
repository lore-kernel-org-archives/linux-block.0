Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021127.outbound.protection.outlook.com [52.101.95.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA863630AD;
	Thu, 21 May 2026 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406216; cv=fail; b=IlL47jc2xODD32CyaO6HcfbCKGC1572Lm3XZdiIsePTcVvtXJk6Sip439aM7pG1bMrVnkbFwZ+G4P7NPwhg9WXhVRunpaA3aLvKXAneIFZyKSMzujKdw3KFf+MX82yEsrn16vFZygEx2Srjjprn23YdmSVooAjTmMFDIo1ey/5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406216; c=relaxed/simple;
	bh=g1YFpsd8OUmrEQgAxhRhguCmjXTWA+UwrnjSuBiCkUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7u7i7GPmeTmRh5+Otp+gDiUoXLxdhABt0QXd5SPJC1u3eB0FBccsWAiTl7p2v3hK1sHuqiys0PvR+M0lGYtkjatyn/svlj3O2EZkw7CujhOoYda8KYibLUZI6FI4G1jtbKywGPgTSs/i8mHjrS9QkBPP7aok/O7RpHtES3qgqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ2D2H8bcX0ds6QQGP4fT5nDxEGRnUjggXCQ4JT19etzZWImhY7meqITxQ04mz+3wLsZHr0QMOh0mZT9snyoPBPJbezDMIyy3N4JJ+UPYX9rwYiI+tPYOR103KhKMGxnbiTXDLN8B+6hKD2ZJtKoXAq8XbHgs7rt1cJ83yg3it1KzWwl5kw6IMl2EaFomlf7+Q3EL+4X9XF3TIR8dQhboDPTm641rYJ13BYeZ5sSVVzYXJjCfk0T5CcD3794Ka+0rGBUwHt3wQV8UgGphKkaQhUhrt59c80xIPqVyxVbfu5YgoJ4X0nBXPPJTG5/3Q0LSbUjWG97DzZy0iC2mBZf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/NHodQS8CyLfQKTI0gbQ/NnHLueRIacKWTpX/hJ1bk=;
 b=mj5MTTfVfTXOxIUVHacozEFZGd534DYut+oqVozNiEZSnXWEOb+M5UpMCz0VhTQT3ofut7z6muRJTvqEpx+4alsI4A09gtBhwl52BjaXmXbrQV/ZjL58m1KNiH+EKeECnrEBDbXw9EXnjhi5WjKrdp9QeycGPXPGBZxg/F0IoO6FHh8XqR2MQMRMCorbNo5d6qiLt0xQ6t7nqedd0iqIXFxuEx0ALE+1q2si1XU+AWqb6Y/OpJrC2vgnoNZJMQFQF7p7lSKIV+j28yYf6Su18aNzvta+lO4w26B1NwilFAZ+VWxarUrDyDpHms1pHLoeey09EwL5aTIYg27+dejCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:12 +0000
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
Subject: [PATCH v15 3/8] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Thu, 21 May 2026 19:29:51 -0400
Message-ID: <20260521232956.553287-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:408:e8::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a3a2c3-2292-483f-be7b-08deb790e75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	G6PLCdO6O0ngpoOSvEUaiDgotSJ9/jTlY5bncC7c6IwBHbDyYZTDNDf7h7dizleDA1zFxR0EPPyN84xxfehrbbVJkKt4fUKbDLB9qT7r9EJ4Vk7nZMUSSiQerJEdLAsqZNAUQSgdYzxl+5kJTg25SlRyg4za4pZWFgai8mVbDh63RXHUUkKLOUwv/eNPNa+y+a+AcXACj122z2Mocfb+BzGGFH/oYYeVLyXEVk/A+T8SYfn/0NB1a1PayLdUQtMBg2WxW9pYb+GILN4foHMdYuKGKRFYFTp8dE4JZQxNQ+Go9Js1qZH5AsbWOtqhpCHS1TTmNf04EjLJPtmkBh6Ma1P8KrXnkwOWWI9kzuA5tqrNdAm3Fb4FEDdWHb5SSPPBRwaUCy4XVI0iphPtEAwNP+XgR4ngvr/NzhsYGsdhsFp3fVp8PnoD0PVV0sNfRJPcRgPKID4vmkTZaAqnF5qakGtNESZdNt4oOf1gprcFJZIrylhoI25B597z+2PaPZmb6neAls9rYSi7MQK4x7ps9TaFygwYTE7roLF90fjcbGYUt9M205Xp4n5tbS+THdFTTrnBU6Ot1mTnNp9XWicKNPuCwZH/Abf/fT2jxszCQED1YcLiLE3sVhTBJOyZBYjTvDynHl9a53Ns881peLcTF5UuG1cduwJtf9nikBJGgbEQODE8x8Xtv2LLxmxlvwQG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjmmyBgCs4z45WZeTUcxPnTjFR2uuC+yBeQB7eOSfrrP61vTnIJ3xwI34/ES?=
 =?us-ascii?Q?t2mAzOCc+Y86eGZVB/rkMIohFCH5LUndh6h3HYE7IFpXOCBgngAm+Dhq/yHd?=
 =?us-ascii?Q?Ack5+FX31yIKgEQitRkUcc0XXPsSHMEnWM1QQVfrSnuhi5qmX8vqpGms/sx6?=
 =?us-ascii?Q?bo3U9z8kjI+OFpIyaBTwWCA5WmRodesmuVc8wXr32EV8Z0iCTFhgZlxmD+7y?=
 =?us-ascii?Q?bmo0mu8mwlpZIPzOGWkmQIsIiVoc8u7w2v7663m6urYDMm8Ak1hfytIR7KZu?=
 =?us-ascii?Q?ORkhqIvMq4sOWNhaESwL66Wzwnj5m8s0CPpCQ9bzWSvVIo3J3epNC5GhxYhq?=
 =?us-ascii?Q?7zsvjW59N9HZ1cmuyjjCcrlworxBHb9QmJreY9KHU/CWO+cZoH9BYnO1JuTp?=
 =?us-ascii?Q?XMvgb57fjSewBml9ZUssITnw2LU1+PZYnJ0N3iuUtjWS0JstyUqKQOxQ3Lis?=
 =?us-ascii?Q?PQIj3Sg1EdoPf1iYLiaVLxPlXUYer6PwGfWkELt53yPrIb40hdGXwxxfZ8+Q?=
 =?us-ascii?Q?pigpgvRAXk4fxYl1tNudC0fkBkhFb0L6N5HISGAMeELZgBC7qqCtvHOb4gvF?=
 =?us-ascii?Q?VcI5u3skpc+4gs1pgxE0pP8Im/w2ATPMnpmpmnUFxNpLvUULgMtZJF2F2k3y?=
 =?us-ascii?Q?SnfHgQrmVnU8aqUgTIcLt/BoZCqj+cVUvggJ253TGjJr+PRz6/VsDCDuU2VX?=
 =?us-ascii?Q?NeGPq90t5GRQ5WkActw8tP36NuTIx4GZDTljHdPgPG9riZ9Ev5AC0sOqPLHr?=
 =?us-ascii?Q?wDClHPGu2836QjX/t0AjLOXB1JLpEB63eqbPSAJsd6y0G8WSMQge9j1RmW4k?=
 =?us-ascii?Q?/sr370kW7B3hD8U8iEyec5xbAHkvpPAU2veNTzgWgIcxGGECTvh/FOYLjYNg?=
 =?us-ascii?Q?+85+kLgd5nFmPKwdMgeAauzLjl8KLVRUiOGR2XFFZbQuJrMafLlqbJ+YHjCO?=
 =?us-ascii?Q?whBhgsc32xOEAU1gq5BiqJJqimIvXQXBoLy1eL+1Tntrc1+ZmGS2D4f4KrZk?=
 =?us-ascii?Q?5Mi5Nf98YFRddotheA0esS6tThS2jahjJcGcJB0W7s1xjZdhd7BrQUkSW6p6?=
 =?us-ascii?Q?9zbB+UwoO3ZR2LPsmNSfvtC/VYaSd8IP7KZgwQKsJDGgbOA1fh6XXQKJky4/?=
 =?us-ascii?Q?20I6teuy8lpMdbDZZ0uW6hiEfHkKRlvFqOGUoAmkInvVD+hES+goX3MQXv6/?=
 =?us-ascii?Q?qgdd9bxyjbfv/c/pAp4Uv6V2T9nbUxBy4i68xuFsHXVdcJCHs/Gujqq7vZ5l?=
 =?us-ascii?Q?t2NvUa748/mz4tdeuXMteNOCrLUWXXhvKPGUBDyokACMqxE9ykTzoYEi4Hqz?=
 =?us-ascii?Q?UthM84dq69AvEAbLifbIDlLq6WPLGBKcAwM5NMHUaKAAzkDat+PIX9yn+vtM?=
 =?us-ascii?Q?Mzg5HyhKQqdziZhDoXo4iJSTtwoXMTRCTchqvluIRVnmztZU0gn/y/znQ113?=
 =?us-ascii?Q?LZeOvcCrsKvwS6ObQNXcgWwTo5c2XHSZng55fntd3I0ogotjLGS4p97wAObm?=
 =?us-ascii?Q?ByMptydvq325uy1nNPesHkljs8w/LW+8O+A381ruly8Aeer99NdpkLyGalOJ?=
 =?us-ascii?Q?Ai/8WdAFDf2xSusPe4k8qOp+eFO/fzKQ7BDyTA3kTe7ZkeZynAbG8HRKynyy?=
 =?us-ascii?Q?0I9SH07i/T4d4jcOQQYDo4JVYysWCge3i/m2VU6aeVWVGeTenCrnUviLoJKW?=
 =?us-ascii?Q?e4gvpBD0DwDxyIut6Hb2ZN1TJMDpDRM/CzUs6qf33KU8OEOFe2+tTsfvM2DB?=
 =?us-ascii?Q?d1E1N7XkDg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a3a2c3-2292-483f-be7b-08deb790e75f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:11.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqPMq9HYAVQa9Ku6z617AZhT9XfADZDt8152/Zq8xl6l1920sp4KDJEi3e7BS5coLPouAviJZVdoSA1ouqVOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

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
      present CPUs, mirroring group_cpus_evenly()
    - Fix division-by-zero bug by ensuring group_mask_cpus_evenly()
      returns NULL instead of an empty array when evaluated against an
      empty mask]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/group_cpus.h |   3 +
 lib/group_cpus.c           | 110 +++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

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
index b8d54398f88a..75bd082e00bf 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -563,3 +563,113 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
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
+	if (*nummasks == 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
+}
+EXPORT_SYMBOL_GPL(group_mask_cpus_evenly);
-- 
2.51.0

