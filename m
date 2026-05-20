Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022116.outbound.protection.outlook.com [52.101.101.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7753A0E85;
	Wed, 20 May 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313864; cv=fail; b=PfXCXeKyxmfny0byG06TsmX95l9vxGwaxaxyY3g5HlL7cXXzvBicjgaFNMqxO1T44o3XTQB+UMHf8Cy8U9kHNpC9cDXS3RKZn+Rsh/ZdTAtZyZ6Fz0422iZ7XhCGlPfqCSQSiqqKSM0fIt+C3DZICUZY8ztocI7AHbBOAr0IoYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313864; c=relaxed/simple;
	bh=xwkp1m4Mho42vVEQyCbCAZLNrcLouq5kFANDAmnKf3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loLVRa2wP7zpacGgUGC0F1+quqvEEG9i8Uk4Fks3XMpmBkpBc9B+SCXQsUaexH0q5bhEGsN3zluodyur5V45prxW58gXOIiIupEJGgaPsNOAa8J1sI76gm4WLwaWuMSZoav+J9hU94Ol7KYQYpIF4mgrKojTaZW4YbRrTEB7q/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXrW7u+mW24IoSnufg1YptpMLesCnJsIwyepPqRUzdxJqTxn9hRuo3n8adSFn6LCkDq2IkGniTzbuvBeDw/JtVuUISBMf6L4HsqMm5TxafaHy7n957wkSOzPYNQPyoD33QXYLXltzVpOReYjO3c6onPFOre0HiWNRZm3km+fvBLuW1Ay/Z6Vtqh03+QUUtH+vjvP8SIMz+Q3b+HRtdNjAyvmwgJ+Id6a8KskZaFYEO8dx5zHXAKFD/9ofWBo8ZS2OCGqcUGp3L4Buz1u90lr+DAOBgD7hJafgiwwpCwmCkNkgfBI8mczd6Qk9wEryGfA1u+JMUAh5Wpw5buGmSsiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeKeEqwHpZKZATHUqnFE+WIBucVi8HgWbjUcpz9Q9+s=;
 b=HJ0XI0k2kRD3Uj7DQJyi5Z9o9FJounWQiLhu3tBvOzM+rJKp/DG7e2W6n0frp5+Ue9he40UUk2kvqJShslFloXb5Su8T2W22nuL1ZOdYPOaH4wiS/XHV2Zr7px+jB8ZFpuCWaURJfBpzFaT+pIoLsnGzDhK2uznA4rip7SxWDUEO8+ftV0Ep39tHD1pZURKfLa6/DljY4ld0xlzPfMJxRBhfFyls9tD+Yxzk7e5Z3ZdPE3N/+XFOVddJOD3cEkw5QfLHxPPx3C0EoVVRRiWnWoSiEQr+1fRGSqISYPeZoqvMXl51HpsLiWQdWLfrpOCsXf3J2TZfHxVZIC/U7O+Vnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO4P123MB6626.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:50:59 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 20 May 2026
 21:50:59 +0000
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
Subject: [PATCH v14 7/8] genirq/affinity: Restrict managed IRQ affinity to housekeeping CPUs
Date: Wed, 20 May 2026 17:50:29 -0400
Message-ID: <20260520215030.496803-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520215030.496803-1-atomlin@atomlin.com>
References: <20260520215030.496803-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO4P123MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: a963de0f-4fe6-464b-1811-08deb6b9e0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|6133799003|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	O+3+3asRv9URJPaOzFMWyg6y0DAB2mn+M48WPybJVOjcOMszDQOM0QEZ10Y319IWEKwNwa+G6vzNJouNMMgjujeDgU/8JHmb1dzKp1/YJMFoytGh4jfZkROaF6WKHR08d7pZaubZycOnbkcdi2vOhROGJrWPOZRtMtJx3Rz/LWZ+KQ+V3jnnKA8Fi3p4v6Pxjp8NDhNSTA7n/Uv22ausYYI9bluY63xcNo4IfSSyzlRFoTYbyet9azx/YN8BpYbFcxCjb0kVGaFjbJo2s3AqZMmRBnzxfUxlxcQXKKAWH2GBau/fe4vutWQxVyMABMp51zxaAGe/JFKaRQyO9My4fFg+irl+ejNSEv+AD6ibSMTQbS+0fafiKScnvxRl0PBXu3deYYL0uPYEtXUCKuxFv7atCvMGy69Z76lf+6LffGLQ7hzLdYBXzk5VGjbhqAVJID/O09wiEcuq5KTXzRaUouXK6HeXcKI+dS59R4CkVLH1NwC/7VbOC5VFZqTTX/ph4Wrr0xRpQrAoTXWakF8PaLogIyHUebRF7eWsYC2bSVDDv0Q3VuNHb4JnUpdSMSxfmCLdyEujyEQ67D7vzYo0NrDnFYxcRrIBVkV27gf+R/u4eU+Bc1happEXmQvcXy49ZhneliUm8p1eKNmAUzug1Tf385zMcg8kYwjl1aOBse4NlNNn3iWkrV1v/oDqrvjs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYNFHIvCr+xS64+KLxXgnGMo5ztXGIyLIJWpeQgbO681uLon8AjKt8/+xPlm?=
 =?us-ascii?Q?RFpABslDuNgdusO9Cas4iqBJAA2zrwhI/qTp7iRWXBxjHSZ66/nIRvz91iEX?=
 =?us-ascii?Q?aDSJRDYBzXTGmGiC1Aqbuyh/gXhCDvu27Ugn03xv7h7BszXX4GEbkEmbBI2X?=
 =?us-ascii?Q?cIW/8aqF+AsYt39SCEfsaeGd6n2I2kCqVccCum0FBYZJEjsaI/GsTFoRAPmK?=
 =?us-ascii?Q?iL/cYrjvHwaxSGmyPnBZ5cxB6tIgSz1SN/9zAfr9foZ+JDtXA2OicUWnC9RO?=
 =?us-ascii?Q?Tq9UAGyy/2zlwEiFx02KCwxd//xSH3UhlQ5rGUWc8CaBvzQg0rQEdimrH/yh?=
 =?us-ascii?Q?4MvrD8mYm73eHQkEqskCBQGyhRj42YRlJvtmr/Qp5ipNZ6KhkG0asSxll6kL?=
 =?us-ascii?Q?3xBC6RtisG2udWemUQDA9XVpR8D3K/Ev5ZCslc1Ii11pqt0fkE+LR6xgJXpt?=
 =?us-ascii?Q?6fNuhtc6Qm4rR0v27itmK967blzkbdKIIODT2AOGGILXGo3LR0KRWDDaYRts?=
 =?us-ascii?Q?Ybxlry1Fl4hvICQYtMrL/of3u/kXuAVXTJz+bQdXwpBVVIuNjOX738zWtrBT?=
 =?us-ascii?Q?9mcbEiZj/hn15pX/1c0VVmBndnjETiaC3UwMtyyQFNdZC0ip8wnwjnlxa+Jm?=
 =?us-ascii?Q?AcnfdG5hVgnqQ7QTSgsAVE96bpDurwqj1ELsdjpfnKO0lDfP4mHr8Aux3Uwr?=
 =?us-ascii?Q?kZJ+TF+BjYkj744TDuyQCLOnSM5XuKqlZXjXQaukg2fp02x332hmCM9uL9/P?=
 =?us-ascii?Q?U+88VFho4rPHeI6nU8/01sLTEGaOoqFbcCX6SIym4UCVFEI5KKCyQQfey4Av?=
 =?us-ascii?Q?Ruc+rCdoubxtCwRncsf5RFaM+xMS0CDBG64uk+/0OC5btn3qnx0fT6w/U4ip?=
 =?us-ascii?Q?L6bkSz+xIqrLHAkQFOoOMDl/CxuOPBUOyjb5ZlvimyzIIcj3vAVpSS1ET/7p?=
 =?us-ascii?Q?HTCdEJ9vV/K/4WnK5DA/kbt/uPu3k87rYsrHBSmB2vlU/QAZTBV8fHyaye+v?=
 =?us-ascii?Q?KBI9IRnN4wwfVqnq9qh+W51zeWizz6QcqDdx5bjqh8akDg6250dq1FL/PA36?=
 =?us-ascii?Q?REChdYfizc7K9xN7RUmddnPNa2e1PEpGAlY6UH1FfC3xBjIYnqIlqsnEWern?=
 =?us-ascii?Q?ta8EWTlktLK23tJjIbahLDi9/xzrq3X0l6rAZ8Kyx1LIi0cNaftubYfBX3rl?=
 =?us-ascii?Q?VKd6GeA8yzte3lCmrp1+xj4S30o973yB+Y3ylrUgGMgnwZy12E16NHr6PRfa?=
 =?us-ascii?Q?UskuX1KnSo+GftgtxW1MI7c+wYFw9piMa+HQ0MkPOL59lQwk+l29HM4INhSt?=
 =?us-ascii?Q?fGLwQSZl3aLVA1+if0Y/Fd9Jr8JRIu8hIVHxDTqmsKpEF5dyv5O+2ts2s8zZ?=
 =?us-ascii?Q?f498o52OeLiabzqq0L1yiNOeEJ/016e3/g2Vsvetik7dFTe3uAsyq8op1/AD?=
 =?us-ascii?Q?acriL8texN1ibswL1Fs3waqVpCpkNFZ8/q+XTcWuw8YydHaYkze4CzlQzVyX?=
 =?us-ascii?Q?EucZxFgUVffFWiHcv0fOZl533v9mdwMv55e4cL4Rop8A9lHIHuPY4zU4CjGK?=
 =?us-ascii?Q?yuayN/b2RxuiA0Tt/mcHzwI80vn9n2lQVggHTX95EObP8X+OtgLbRJmhHWZ/?=
 =?us-ascii?Q?bI0+87zFFwBn3GgfQwZ3+6uqLNDW2QskXoAv6p8/UXqfpTpdltmN/yiFL2Tf?=
 =?us-ascii?Q?rBJrysYbHByNKuX7kRQMGOlk/SUtO/fsrPOV+FK82wnHbh8W9M7q+bfVRINI?=
 =?us-ascii?Q?IHQ2LGLcIQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a963de0f-4fe6-464b-1811-08deb6b9e0fc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:50:59.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLVoVdBqG403pZFA1slN7Hzh7I2gAPPCgVBWcZH3UIOszbJTz8TjWKOxC4cvNlWXnd58rbYSoCnaFQynTjnW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6626

At present, the managed interrupt spreading algorithm distributes vectors
across all available CPUs within a given node or system. On systems
employing CPU isolation (e.g., "isolcpus=io_queue"), this behaviour
defeats the primary purpose of isolation by routing hardware interrupts
(such as NVMe completion queues) directly to isolated cores.

Update irq_create_affinity_masks() to respect the housekeeping CPU mask.
By passing the HK_TYPE_IO_QUEUE mask directly to the topological
distribution function (group_mask_cpus_evenly()), we ensure that managed
interrupts are kept strictly off isolated CPUs.

This patch additionally addresses the architectural constraints of
restricted vector distribution:

    1.  Vector Limits and Overrides: Updated irq_calc_affinity_vectors()
        to strictly bound the maximum number of allocated vectors to the
        weight of the housekeeping mask. This correctly overrides
        drivers providing a calc_sets() callback, preventing them from
        wasting memory on dead hardware queues that cannot be routed to
        isolated CPUs.

    2.  Multi-set Alignment and Leak Prevention: When isolation
        constraints result in fewer available masks than requested
        vectors for a given set, the remaining vector slots are padded
        with the housekeeping mask. This replaces the historical
        irq_default_affinity padding, ensuring excess managed queues do
        not leak interrupts onto isolated CPUs.

    3.  Minimum Vector Safety Net: To prevent fatal -ENOSPC device probe
        aborts on heavily isolated systems (where the housekeeping CPU
        count might be lower than a device's structural minimum), the
        final vector calculation is safeguarded to never drop below
        minvec. Queues will safely share the available housekeeping CPUs
        instead of failing the probe.

    4.  Zero Overhead: The housekeeping mask is conditionally assigned
        via a direct pointer, completely avoiding temporary mask
        allocations (e.g., alloc_cpumask_var) and bitwise operations
        when CPU isolation is disabled. This guarantees zero performance
        or memory overhead for standard configurations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/irq/affinity.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 78f2418a8925..dade92f8b4b3 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/sched/isolation.h>
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 {
@@ -25,8 +26,10 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 struct irq_affinity_desc *
 irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 {
-	unsigned int affvecs, curvec, usedvecs, i;
+	unsigned int affvecs, curvec, usedvecs, i, j;
 	struct irq_affinity_desc *masks = NULL;
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
+	bool hk_enabled = housekeeping_enabled(HK_TYPE_IO_QUEUE);
 
 	/*
 	 * Determine the number of vectors which need interrupt affinities
@@ -70,19 +73,29 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int nr_masks, this_vecs = affd->set_size[i];
-		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
+		struct cpumask *result;
+		const struct cpumask *mask;
 
+		if (hk_enabled)
+			mask = hk_mask;
+		else
+			mask = cpu_possible_mask;
+
+		result = group_mask_cpus_evenly(this_vecs, mask,
+						&nr_masks);
 		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
-
-		for (int j = 0; j < nr_masks; j++)
+		for (j = 0; j < nr_masks; j++)
 			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		for (j = nr_masks; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, mask);
+
 		kfree(result);
 
-		curvec += nr_masks;
-		usedvecs += nr_masks;
+		curvec += this_vecs;
+		usedvecs += this_vecs;
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
@@ -115,10 +128,12 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	if (resv > minvec)
 		return 0;
 
-	if (affd->calc_sets)
+	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+		set_vecs = cpumask_weight(housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+	else if (affd->calc_sets)
 		set_vecs = maxvec - resv;
 	else
 		set_vecs = cpumask_weight(cpu_possible_mask);
 
-	return resv + min(set_vecs, maxvec - resv);
+	return max(minvec, resv + min(set_vecs, maxvec - resv));
 }
-- 
2.51.0

