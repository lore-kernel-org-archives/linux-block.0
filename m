Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christogh Hellwig <hch@lst.de>
Subject: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in irq_create_affinity_masks()
Date: Mon,  7 Nov 2016 10:47:38 -0800
Message-Id: <1478544462-9549-4-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Christogh Hellwig <hch@lst.de>

Only calculate the affinity for the main I/O vectors, and skip the
pre or post vectors specified by struct irq_affinity.

Also remove the irq_affinity cpumask argument that has never been used.
If we ever need it in the future we can pass it through struct
irq_affinity.

Signed-off-by: Christogh Hellwig <hch@lst.de>
---
 drivers/pci/msi.c         |  4 ++--
 include/linux/interrupt.h |  4 ++--
 kernel/irq/affinity.c     | 46 +++++++++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c58d3c2..1761b8a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -558,7 +558,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
 	u16 control;
 
 	if (affinity) {
-		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		masks = irq_create_affinity_masks(nvec, NULL);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
@@ -697,7 +697,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	int ret, i;
 
 	if (affinity) {
-		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		masks = irq_create_affinity_masks(nvec, NULL);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 092adfb..bca8f1c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -290,7 +290,7 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
+struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
 int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -325,7 +325,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 }
 
 static inline struct cpumask *
-irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
+irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
 {
 	return NULL;
 }
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 8d92597..17360bd 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -51,16 +51,16 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
- * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
- *			is used
- * @nvecs:		The number of vectors
+ * @nvecs:	The total number of vectors
+ * @affd:	Description of the affinity requirements
  *
  * Returns the masks pointer or NULL if allocation failed.
  */
-struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
-					  int nvec)
+struct cpumask *
+irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
-	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
+	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
+	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
 	cpumask_var_t nmsk;
@@ -68,46 +68,46 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	masks = kzalloc(nvec * sizeof(*masks), GFP_KERNEL);
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		goto out;
 
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_copy(masks + curvec, cpu_possible_mask);
+
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	/* If the supplied affinity mask is NULL, use cpu online mask */
-	if (!affinity)
-		affinity = cpu_online_mask;
-
-	nodes = get_nodes_in_cpumask(affinity, &nodemsk);
+	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is less than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
-	if (nvec <= nodes) {
+	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec, cpumask_of_node(n));
-			if (++curvec == nvec)
+			if (++curvec == affv)
 				break;
 		}
-		goto outonl;
+		goto done;
 	}
 
 	/* Spread the vectors per node */
-	vecs_per_node = nvec / nodes;
+	vecs_per_node = affv / nodes;
 	/* Account for rounding errors */
-	extra_vecs = nvec - (nodes * vecs_per_node);
+	extra_vecs = affv - (nodes * vecs_per_node);
 
 	for_each_node_mask(n, nodemsk) {
 		int ncpus, v, vecs_to_assign = vecs_per_node;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, affinity, cpumask_of_node(n));
+		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
 
-		for (v = 0; curvec < nvec && v < vecs_to_assign; curvec++, v++) {
+		for (v = 0; curvec < affv && v < vecs_to_assign; curvec++, v++) {
 			cpus_per_vec = ncpus / vecs_to_assign;
 
 			/* Account for extra vectors to compensate rounding errors */
@@ -119,12 +119,16 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
 		}
 
-		if (curvec >= nvec)
+		if (curvec >= affv)
 			break;
 	}
 
-outonl:
+done:
 	put_online_cpus();
+
+	/* Fill out vectors at the end that don't need affinity */
+	for (; curvec < nvecs; curvec++)
+		cpumask_copy(masks + curvec, cpu_possible_mask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
-- 
2.1.4
