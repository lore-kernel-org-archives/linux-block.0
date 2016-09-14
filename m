Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763111AbcINOTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:22 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] genirq/affinity: Remove old irq spread infrastructure
Date: Wed, 14 Sep 2016 16:18:50 +0200
Message-Id: <1473862739-15032-5-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |  7 ------
 kernel/irq/affinity.c     | 58 -----------------------------------------------
 2 files changed, 65 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4e59d12..72f0721 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -278,7 +278,6 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs);
 struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
 int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec);
 
@@ -313,12 +312,6 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	return 0;
 }
 
-static inline struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
-{
-	*nr_vecs = 1;
-	return NULL;
-}
-
 static inline struct cpumask *
 irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
 {
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 7812fec..17f51d63 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -152,61 +152,3 @@ int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
 	put_online_cpus();
 	return ret;
 }
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-	return cpu;
-}
-
-/*
- * Take a map of online CPUs and the number of available interrupt vectors
- * and generate an output cpumask suitable for spreading MSI/MSI-X vectors
- * so that they are distributed as good as possible around the CPUs.  If
- * more vectors than CPUs are available we'll map one to each CPU,
- * otherwise we map one to the first sibling of each socket.
- *
- * If there are more vectors than CPUs we will still only have one bit
- * set per CPU, but interrupt code will keep on assigning the vectors from
- * the start of the bitmap until we run out of vectors.
- */
-struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
-{
-	struct cpumask *affinity_mask;
-	unsigned int max_vecs = *nr_vecs;
-
-	if (max_vecs == 1)
-		return NULL;
-
-	affinity_mask = kzalloc(cpumask_size(), GFP_KERNEL);
-	if (!affinity_mask) {
-		*nr_vecs = 1;
-		return NULL;
-	}
-
-	get_online_cpus();
-	if (max_vecs >= num_online_cpus()) {
-		cpumask_copy(affinity_mask, cpu_online_mask);
-		*nr_vecs = num_online_cpus();
-	} else {
-		unsigned int vecs = 0, cpu;
-
-		for_each_online_cpu(cpu) {
-			if (cpu == get_first_sibling(cpu)) {
-				cpumask_set_cpu(cpu, affinity_mask);
-				vecs++;
-			}
-
-			if (--max_vecs == 0)
-				break;
-		}
-		*nr_vecs = vecs;
-	}
-	put_online_cpus();
-
-	return affinity_mask;
-}
-- 
2.1.4

