Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] irq: add support for allocating (and affinitizing) sets of IRQs
Date: Thu, 25 Oct 2018 15:16:23 -0600
Message-Id: <20181025211626.12692-12-axboe@kernel.dk>
In-Reply-To: <20181025211626.12692-1-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A driver may have a need to allocate multiple sets of MSI/MSI-X
interrupts, and have them appropriately affinitized. Add support for
defining a number of sets in the irq_affinity structure, of varying
sizes, and get each set affinitized correctly across the machine.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/interrupt.h |  4 ++++
 kernel/irq/affinity.c     | 31 +++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3376fc..9fce2131902c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -247,10 +247,14 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
+ * @nr_sets:		Length of passed in *sets array
+ * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
+	int	nr_sets;
+	int	*sets;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..0055e252e438 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -180,6 +180,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
 	struct cpumask *masks = NULL;
+	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -210,10 +211,23 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/* Spread on present CPUs starting from affd->pre_vectors */
-	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
+	/*
+	 * Spread on present CPUs starting from affd->pre_vectors. If we
+	 * have multiple sets, build each sets affinity mask separately.
+	 */
+	nr_sets = affd->nr_sets;
+	if (!nr_sets)
+		nr_sets = 1;
+
+	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
+		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		int nr;
+
+		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
+					      node_to_cpumask, cpu_present_mask,
+					      nmsk, masks + usedvecs);
+		usedvecs += nr;
+	}
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
+	int i, set_vecs;
 	int ret;
 
 	if (resv > minvec)
 		return 0;
 
 	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
+	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
 	put_online_cpus();
-	return ret;
+
+	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+		set_vecs += affd->sets[i];
+
+	return resv + max(ret, set_vecs);
 }
-- 
2.17.1
