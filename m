Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6329DB6E;
	Wed, 13 May 2026 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633744; cv=fail; b=sD+U//Aviq/+8NpEizbq0X/jV5XVRYhSD1HBsDVHfTW3ve4T553iyxG9Pk3NYPMWYKaRJSmfl1jMPpeLgYdDQyfaz0zJ7zd0vfV5szVPLH7QMCJdrh4t6GAzWMIuYxjptfK9iat5kru1H82MdNj5Qm29Pmk6DPvqTAAI3z0dRM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633744; c=relaxed/simple;
	bh=K0PE2r23/D5CeCTZ5fQwYlQ1hQQE+jeQ4WvQoxuvBHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFYEGZTbgVampdC0IqZIQkwGqyOO0W2gAr2MpCLFjDx1wpmdv+TbFcXYAQU71vX6PdYv/aBKlbvfAWAcRunBbMuPfZ7yhK9o+5wCf+ZyesoH8ZEv0SyaMo9V8cf1fOGV4yJa3MbzbGMSEpFRy0nOOrY8deyTeGPwmDZLXXYl8d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uao4DSsOSabfCBJJhq2hVWLFbMNwgyfqMQ1pt/G+iGDWvO03zGyTrpOoMRJ8yjadFfBFsdj+6AEZj76wMcTSp9xuVTx2aTeXpB+qWFDsSitMkovkW8H3r22vYdceWy9Zr9+g7iAfIH3u9jYnuHH0BTNtatGjh6DAGeiqngkOE66FRVO8cET46Prd777pJzs41voZWlzAFlgkhZVcMXsZr+4Lc7fSWn+zTinqwSbXaMF1OhYdeO7wMCC9DCEkmy5wvbqIhyq8qlyF2zkrcBGwMVF+5DdCWas8db335Wvj6TMDlFvxvGe/2H03MHY8cY//tH1xFUUB6AqKr1zz4L4B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRVBVLhEC+p2EPS6xr4c2p3DatNZmB+uqYKwjCOwuOI=;
 b=XJ4fjRfvXDO7T4JwqczBP7yel7h2cvZXR+lGPYPlOs+EI9NYe6krOlZbEU6G2AaunsSLg87z2nQOAM8UKVKc7BR8heTb372C1F6yhxcYr4aBWGZyYifssLffZVmgGDljKKRwFuHwBgAiocG2OPlKg/sdTp5J+BsAJrI8R3gYyXwKF17RF9eGSqRCzpE0NbFCIQMO5OLhX1T4Vb8AzL2n5TtVATRJLLUrhF+D1aNKQj/ktb+sHNKQVGE0nSkOH/OInLJFT4lqKFTZPqt0A5VEErvZ2WnIOAfJpLdoffwhGWEwi99Oe04uJkSB6l8afgOuIRNesAdWjc2jnz8BNDyJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 00:55:38 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 00:55:38 +0000
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
Subject: [PATCH v13 7/8] genirq/affinity: Restrict managed IRQ affinity to housekeeping CPUs
Date: Tue, 12 May 2026 20:55:08 -0400
Message-ID: <20260513005509.135966-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513005509.135966-1-atomlin@atomlin.com>
References: <20260513005509.135966-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:408:fd::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c70925-9b5e-48c2-d5e7-08deb08a591f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iZE9gsrvckGOoTcAPiYy2BulRPxDUNOzwp+BTexpcIS5MDXNwA1XMgacfl016zO+38r8NR9dfPpGu1keL3FecImC+wU3nhO9NANZxmFxa0TOJuoOxFz5wT7dwrFhrToVNq6uJBE8gc81L4WKiwyN4mtbKa2vQ5Cn/tRxkPJWI2RYKlbTXTbh96MUlocb4C7nu5rBN/fU95BDzyw83+LiZO6dyci+263pDQ7SzkW4s/Lj9ydhe+cvtV5VPXEWsXRkK/Pf6sxRdnTusBYavPDmuOZ6vwN+2hL29GETwzWeBuUw8u03APSeCcufU0KYbfhz1u2buaS30GEcg19iCfDpl09pn7e2p5c5QB5vGVHabwLgBSZa9NAPDEn72ekv+NK+6KHsFgm/DVzfcIbXsHi50otNrYdUwkLLtiWZVSFSTYu9wHxsnkaMFvA2BsNdVGlCYdiRwIhrKMrC4N1YA60MOLoLmVfny+IQDGtbaGJ1EiA5/kyiRgzHz+E6hEIrp24WV4QFqR4UnsHrTLoMQpUyoRE6fexylCGpRmTAzu8STp/rUHv7iN46mUxUSlCCmuAwva+Y6v8RPcd8dGDHNm5oeJ5lFIQ8YNUbnVkOYW3KRzRo6nKjsDoyi9fEFTFdOO+WpwfqOucjcuRF2l1Z8qAtSZo2KqCtFJZybmI51+KQ3IjMKj/dzCsx0AMQnVIKn3pA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAxoMdgtqIMwDNVc6fuv0ldANEt+h95upuPEWhYuabXj0dy8c9UKQw2y/ow/?=
 =?us-ascii?Q?WZFDvNcbXaJmzZn6yXR0g9bigzLLPPIQqKVaIITTQ32v7xCkdzc9gUuqiEUC?=
 =?us-ascii?Q?JFc21ahyloX4o5NBxnYQXamvLgb+ocxVjourZ2hpdfTWC5bbxQboZ+nT5swS?=
 =?us-ascii?Q?TiJ/HNZPjQN4C/9oSHb5zw27mp1ODAKSjIUSM73y/PC00M8DNDtd3fFnl88v?=
 =?us-ascii?Q?PDB9+XbxzHNQuIQmwO911tUgXFOGSbncPRdc0tKC5QIADFFrSiR277a+sSce?=
 =?us-ascii?Q?R7LNcy3roWw2mnb12w4UiqA3758PSv4SUZSC0qzX9owRB8p0cJHGNJrZ8H8z?=
 =?us-ascii?Q?xQE2mrar5t0KtJ8uRCYce0tjvsg0tqhdN28Qu+6anyLzV1EudoQDSLgVraHo?=
 =?us-ascii?Q?Q/b0yRwMgACJrZN+KomMwgXLaI1uW72mi6Acf6iaQShEAi5GXnYp9KAq3ZwH?=
 =?us-ascii?Q?AEyC9+2b+wAB4Ox5U+i23q/YC7JxOXPmT5a7EtKQvZ+Z1haY1omaSYd1dQcg?=
 =?us-ascii?Q?+uy7iiTGRtTFQAVhJE9apt+duS5ia5vBl69cW3TIooKQmyEbaCqwYOu96ie4?=
 =?us-ascii?Q?EhA3rObQvmaeFSlrxNr2/DnWgtxtFarfEjI9P3qvfJ26FIGGjMOdnHDUyLdN?=
 =?us-ascii?Q?/Qy5Nt5/OaBCSXlHHL5ikK5CTfLXG82kBqgajlrSCGbnXqZARaec4NPhxq43?=
 =?us-ascii?Q?ownV5F9bx6Q6X4JuDh4BzyiJ5GN/GrJXpslEypq9XvCCx+j331FxZzkUh08n?=
 =?us-ascii?Q?mMo4gTuq6CqJOzNbWUTMoIV9GF1zObzb3glT1iVNKpUNepg+piNDX7sqHHQ3?=
 =?us-ascii?Q?AYwpQPNfioYbEVTavi9JF9aH084XCuOg6SUS8gPyzXP7oPku04H5D3Bd1m80?=
 =?us-ascii?Q?sYWK/yYB6C+koIbs7GLe751criLH6Nh8ou2b9tRW5d+AyKuf5xE38zKWuc3B?=
 =?us-ascii?Q?Sj3TKwXuKllHdgRwisMWM+r4qMW0Nj9b53fTKGhtFOUOciQ9V0N5LabhlQfI?=
 =?us-ascii?Q?xYz7f4hqF4HJj/6Y/20Jc+PJOKtOk82AKoBFhdDmUaSV5sLxlUSvS+5Qh+Tr?=
 =?us-ascii?Q?hrzw2/rzTyLF4u2Jt4qx5dcOF1QxsAPgeIVJsPAn2ZU2G+VbGhkgYe7GTzT+?=
 =?us-ascii?Q?4Gjb2ma+pDvLKkMY0BJ1K1w3nIDLW+AuTKDmwTmMgwd0mRJSHQ5JhUA9oF9B?=
 =?us-ascii?Q?EyHvDqzbvqIpZ6pjNBJWyTvWKEyU0sqCDtQED8ttCuATIEfYQQ/suARN+Fay?=
 =?us-ascii?Q?F2RrQNN0AwG8GTnuMM8rHwbkKnc0aXoXRmXNteTj4xgDIxn0L3EtGO2yNOPT?=
 =?us-ascii?Q?SUarmVk3Fi9BekqCgXGbrWvPBCYEqEfhmb9C4B2KhquYKEXfAMS/C2IMsbRV?=
 =?us-ascii?Q?SpOOz/A5bPG/I08OpOzFPw6p/wAH5KghogDZr0Q7hh6NlTxSjjvCUYgxpgKs?=
 =?us-ascii?Q?f14zmviaumYPKbKZwo5lNeCDsxoL69wulKDWyaLBCqjBcV3iDeCj+KAMN66f?=
 =?us-ascii?Q?Y9U4/1TQsMzjzMWzApGKcyIsEgF5HToGmJ6DQdIUeHg0LxszWSReTUK8s3Kl?=
 =?us-ascii?Q?UBeK2AmQovBqApv8kuLuEd82rSICBf8gefoKEQ+nJkiskV5kE8Hl4ZvZFaAn?=
 =?us-ascii?Q?Swd+2gsRVIhgIEYuRtgBqWjc62CE562wW7ZDU67vNVgsdkNuj0m0CbuKCluF?=
 =?us-ascii?Q?TK0rNWOnIFtzz9POOcCi9jKXI4ammoP0a8xcn5VLeUQ45u1B38dmq2QkUeme?=
 =?us-ascii?Q?vCyNPpklIw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c70925-9b5e-48c2-d5e7-08deb08a591f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 00:55:38.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzUxr4IE/P6Rdl2Kn/HrTf8Bw0fb3+2yYNh02vXaSu/Vfc6xgcOSBJ1ORoEmV+yAHjc5zm6Nu8A/ODZGOSEAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4226

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

    1. Vector Limits: Updated irq_calc_affinity_vectors() to bound the
       maximum number of allocated vectors to the weight of the
       housekeeping mask. This prevents drivers from wasting memory on
       dead hardware queues that cannot be routed to isolated CPUs.

    2. Multi-set Alignment: When isolation constraints result in fewer
       available masks than requested vectors for a given set, the
       remaining vector slots are padded with irq_default_affinity. The
       loop correctly advances by the requested vector count (this_vecs)
       to prevent shifting and corrupting the 1:1 hardware queue mapping
       for subsequent sets.

    3. Zero Overhead: The housekeeping mask is conditionally assigned via
       a direct pointer, completely avoiding temporary mask allocations
       (e.g., alloc_cpumask_var) and bitwise operations when CPU
       isolation is disabled. This guarantees zero performance or memory
       overhead for standard configurations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/irq/affinity.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 78f2418a8925..1d39dce685c7 100644
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
+			cpumask_copy(&masks[curvec + j].mask, irq_default_affinity);
+
 		kfree(result);
 
-		curvec += nr_masks;
-		usedvecs += nr_masks;
+		curvec += this_vecs;
+		usedvecs += this_vecs;
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
@@ -115,10 +128,14 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	if (resv > minvec)
 		return 0;
 
-	if (affd->calc_sets)
+	if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
-	else
-		set_vecs = cpumask_weight(cpu_possible_mask);
+	} else {
+		if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
+			set_vecs = cpumask_weight(housekeeping_cpumask(HK_TYPE_IO_QUEUE));
+		else
+			set_vecs = cpumask_weight(cpu_possible_mask);
+	}
 
 	return resv + min(set_vecs, maxvec - resv);
 }
-- 
2.51.0

