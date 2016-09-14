Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762704AbcINOTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] genirq/affinity: Provide smarter irq spreading infrastructure
Date: Wed, 14 Sep 2016 16:18:48 +0200
Message-Id: <1473862739-15032-3-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The current irq spreading infrastructure is just looking at a cpumask and
tries to spread the interrupts over the mask. Thats suboptimal as it does
not take numa nodes into account.

Change the logic so the interrupts are spread across numa nodes and inside
the nodes. If there are more cpus than vectors per node, then we set the
affinity to several cpus. If HT siblings are available we take that into
account and try to set all siblings to a single vector.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |  15 +++++
 kernel/irq/affinity.c     | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index b6683f0..4e59d12 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -279,6 +279,8 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs);
+struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
+int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec);
 
 #else /* CONFIG_SMP */
 
@@ -316,6 +318,19 @@ static inline struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
 	*nr_vecs = 1;
 	return NULL;
 }
+
+static inline struct cpumask *
+irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
+{
+	return NULL;
+}
+
+static inline int
+irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+{
+	return maxvec;
+}
+
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 32f6cfc..7812fec 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -4,6 +4,155 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 
+static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
+				int cpus_per_vec)
+{
+	const struct cpumask *siblmsk;
+	int cpu, sibl;
+
+	for ( ; cpus_per_vec > 0; ) {
+		cpu = cpumask_first(nmsk);
+
+		/* Should not happen, but I'm too lazy to think about it */
+		if (cpu >= nr_cpu_ids)
+			return;
+
+		cpumask_clear_cpu(cpu, nmsk);
+		cpumask_set_cpu(cpu, irqmsk);
+		cpus_per_vec--;
+
+		/* If the cpu has siblings, use them first */
+		siblmsk = topology_sibling_cpumask(cpu);
+		for (sibl = -1; cpus_per_vec > 0; ) {
+			sibl = cpumask_next(sibl, siblmsk);
+			if (sibl >= nr_cpu_ids)
+				break;
+			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
+				continue;
+			cpumask_set_cpu(sibl, irqmsk);
+			cpus_per_vec--;
+		}
+	}
+}
+
+static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
+{
+	int n, nodes;
+
+	/* Calculate the number of nodes in the supplied affinity mask */
+	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
+		if (cpumask_intersects(mask, cpumask_of_node(n))) {
+			node_set(n, *nodemsk);
+			nodes++;
+		}
+	}
+	return nodes;
+}
+
+/**
+ * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
+ * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
+ *			is used
+ * @nvecs:		The number of vectors
+ *
+ * Returns the masks pointer or NULL if allocation failed.
+ */
+struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
+					  int nvec)
+{
+	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
+	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct cpumask *masks;
+	cpumask_var_t nmsk;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	masks = kzalloc(nvec * sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto out;
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	/* If the supplied affinity mask is NULL, use cpu online mask */
+	if (!affinity)
+		affinity = cpu_online_mask;
+
+	nodes = get_nodes_in_cpumask(affinity, &nodemsk);
+
+	/*
+	 * If the number of nodes in the mask is less than or equal the
+	 * number of vectors we just spread the vectors across the nodes.
+	 */
+	if (nvec <= nodes) {
+		for_each_node_mask(n, nodemsk) {
+			cpumask_copy(masks + curvec, cpumask_of_node(n));
+			if (++curvec == nvec)
+				break;
+		}
+		goto outonl;
+	}
+
+	/* Spread the vectors per node */
+	vecs_per_node = nvec / nodes;
+	/* Account for rounding errors */
+	extra_vecs = nvec - (nodes * vecs_per_node);
+
+	for_each_node_mask(n, nodemsk) {
+		int ncpus, v, vecs_to_assign = vecs_per_node;
+
+		/* Get the cpus on this node which are in the mask */
+		cpumask_and(nmsk, affinity, cpumask_of_node(n));
+
+		/* Calculate the number of cpus per vector */
+		ncpus = cpumask_weight(nmsk);
+
+		for (v = 0; curvec < nvec && v < vecs_to_assign; curvec++, v++) {
+			cpus_per_vec = ncpus / vecs_to_assign;
+
+			/* Account for extra vectors to compensate rounding errors */
+			if (extra_vecs) {
+				cpus_per_vec++;
+				if (!--extra_vecs)
+					vecs_per_node++;
+			}
+			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
+		}
+
+		if (curvec >= nvec)
+			break;
+	}
+
+outonl:
+	put_online_cpus();
+out:
+	free_cpumask_var(nmsk);
+	return masks;
+}
+
+/**
+ * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
+ * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
+ *			is used
+ * @maxvec:		The maximum number of vectors available
+ */
+int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+{
+	int cpus, ret;
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	/* If the supplied affinity mask is NULL, use cpu online mask */
+	if (!affinity)
+		affinity = cpu_online_mask;
+
+	cpus = cpumask_weight(affinity);
+	ret = (cpus < maxvec) ? cpus : maxvec;
+
+	put_online_cpus();
+	return ret;
+}
+
 static int get_first_sibling(unsigned int cpu)
 {
 	unsigned int ret;
-- 
2.1.4

