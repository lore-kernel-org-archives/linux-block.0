Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] irq: add support for allocating (and affinitizing) sets of IRQs
Date: Fri,  2 Nov 2018 22:59:51 +0800
Message-Id: <20181102145951.31979-5-ming.lei@redhat.com>
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

From: Jens Axboe <axboe@kernel.dk>

A driver may have a need to allocate multiple sets of MSI/MSI-X
interrupts, and have them appropriately affinitized. Add support for
defining a number of sets in the irq_affinity structure, of varying
sizes, and get each set affinitized correctly across the machine.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c         | 14 ++++++++++
 include/linux/interrupt.h |  4 +++
 kernel/irq/affinity.c     | 71 ++++++++++++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..265ed3e4c920 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,6 +1036,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * vectors. The caller needs to handle that.
+	 */
+	if (affd && affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1087,6 +1094,13 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	/*
+	 * If the caller is passing in sets, we can't support a range of
+	 * supported vectors. The caller needs to handle that.
+	 */
+	if (affd && affd->nr_sets && minvec != maxvec)
+		return -EINVAL;
+
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1d6711c28271..ca397ff40836 100644
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
index 9c74f21ab10e..d49d3bff702c 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -172,26 +172,28 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs,
+				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
 				    struct cpumask *masks)
 {
-	int curvec = startvec, usedvecs = -1;
+	int curvec = startvec, nr_present, nr_others;
+	int ret = -ENOMEM;
 	cpumask_var_t nmsk, npresmsk;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-			return usedvecs;
+			return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 			goto fail;
 
+	ret = 0;
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
-					affd->pre_vectors, node_to_cpumask,
+	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
+					firstvec, node_to_cpumask,
 					cpu_present_mask, nmsk, masks);
 
 	/*
@@ -200,22 +202,24 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	 * vector space, assign the non present CPUs to the already spread
 	 * out vectors.
 	 */
-	if (usedvecs >= numvecs)
-		curvec = affd->pre_vectors;
+	if (nr_present >= numvecs)
+		curvec = firstvec;
 	else
-		curvec = affd->pre_vectors + usedvecs;
+		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
-					affd->pre_vectors, node_to_cpumask, npresmsk,
+	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
+					firstvec, node_to_cpumask, npresmsk,
 					nmsk, masks);
 	put_online_cpus();
 
+	if (nr_present < numvecs)
+			WARN_ON(nr_present + nr_others < numvecs);
+
 	free_cpumask_var(npresmsk);
 
  fail:
 	free_cpumask_var(nmsk);
-
-	return usedvecs;
+	return ret;
 }
 
 /**
@@ -232,6 +236,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	cpumask_var_t *node_to_cpumask;
 	struct cpumask *masks = NULL;
+	int i, nr_sets;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -252,8 +257,28 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
-	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, masks);
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
+		int ret;
+
+		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
+						curvec, node_to_cpumask, masks);
+		if (ret) {
+				kfree(masks);
+				masks = NULL;
+				goto outnodemsk;
+		}
+		curvec += this_vecs;
+		usedvecs += this_vecs;
+	}
 
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
@@ -278,13 +303,21 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int ret;
+	int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	get_online_cpus();
-	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
-	put_online_cpus();
-	return ret;
+	if (affd->nr_sets) {
+		int i;
+
+		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
+			set_vecs += affd->sets[i];
+	} else {
+		get_online_cpus();
+		set_vecs = cpumask_weight(cpu_possible_mask);
+		put_online_cpus();
+	}
+
+	return resv + min(set_vecs, vecs);
 }
-- 
2.9.5
