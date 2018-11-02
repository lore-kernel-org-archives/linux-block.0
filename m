Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] Revert "irq: add support for allocating (and affinitizing) sets of IRQs"
Date: Fri,  2 Nov 2018 22:59:48 +0800
Message-Id: <20181102145951.31979-2-ming.lei@redhat.com>
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This reverts commit 1d44f6f43e229ca06bf680aa7eb5ad380eaa5d72.
---
 drivers/pci/msi.c         | 14 --------------
 include/linux/interrupt.h |  4 ----
 kernel/irq/affinity.c     | 40 +++++++++-------------------------------
 3 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 265ed3e4c920..af24ed50a245 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,13 +1036,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1094,13 +1087,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ca397ff40836..1d6711c28271 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -247,14 +247,10 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
- * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
-	int	nr_sets;
-	int	*sets;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 2046a0f0f0f1..f4f29b9d90ee 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -180,7 +180,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
 	struct cpumask *masks = NULL;
-	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -211,23 +210,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
-	/*
-	 * Spread on present CPUs starting from affd->pre_vectors. If we
-	 * have multiple sets, build each sets affinity mask separately.
-	 */
-	nr_sets = affd->nr_sets;
-	if (!nr_sets)
-		nr_sets = 1;
-
-	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
-		int nr;
-
-		nr = irq_build_affinity_masks(affd, curvec, this_vecs,
-					      node_to_cpumask, cpu_present_mask,
-					      nmsk, masks + usedvecs);
-		usedvecs += nr;
-	}
+	/* Spread on present CPUs starting from affd->pre_vectors */
+	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
+					    node_to_cpumask, cpu_present_mask,
+					    nmsk, masks);
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -272,21 +258,13 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int set_vecs;
+	int ret;
 
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
-		int i;
-
-		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
-	} else {
-		get_online_cpus();
-		set_vecs = cpumask_weight(cpu_possible_mask);
-		put_online_cpus();
-	}
-
-	return resv + min(set_vecs, vecs);
+	get_online_cpus();
+	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
+	put_online_cpus();
+	return ret;
 }
-- 
2.9.5
