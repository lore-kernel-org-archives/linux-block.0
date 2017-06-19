Return-Path: <tglx@linutronix.de>
Message-Id: <20170619235447.585891193@linutronix.de>
Date: Tue, 20 Jun 2017 01:37:55 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoph Hellwig <hch@lst.de>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [patch 55/55] genirq/affinity: Assign vectors to all present CPUs
References: <20170619233700.547167146@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-block@vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

Currently the irq vector spread algorithm is restricted to online CPUs,
which ties the IRQ mapping to the currently online devices and doesn't deal
nicely with the fact that CPUs could come and go rapidly due to e.g. power
management.

Instead assign vectors to all present CPUs to avoid this churn.

Build a map of all possible CPUs for a given node, as the architectures
only provide a map of all onlines CPUs. Do this dynamically on each call
for the vector assingments, which is a bit suboptimal and could be
optimized in the future by provinding a mapping from the arch code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Link: http://lkml.kernel.org/r/20170603140403.27379-5-hch@lst.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/irq/affinity.c |   76 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 13 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -1,4 +1,7 @@
-
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -35,13 +38,54 @@ static void irq_spread_init_one(struct c
 	}
 }
 
-static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
+static cpumask_var_t *alloc_node_to_present_cpumask(void)
+{
+	cpumask_var_t *masks;
+	int node;
+
+	masks = kcalloc(nr_node_ids, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!masks)
+		return NULL;
+
+	for (node = 0; node < nr_node_ids; node++) {
+		if (!zalloc_cpumask_var(&masks[node], GFP_KERNEL))
+			goto out_unwind;
+	}
+
+	return masks;
+
+out_unwind:
+	while (--node >= 0)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+	return NULL;
+}
+
+static void free_node_to_present_cpumask(cpumask_var_t *masks)
+{
+	int node;
+
+	for (node = 0; node < nr_node_ids; node++)
+		free_cpumask_var(masks[node]);
+	kfree(masks);
+}
+
+static void build_node_to_present_cpumask(cpumask_var_t *masks)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu)
+		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
+}
+
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_present_cpumask,
+				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
-	for_each_online_node(n) {
-		if (cpumask_intersects(mask, cpumask_of_node(n))) {
+	for_each_node(n) {
+		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -64,7 +108,7 @@ irq_create_affinity_masks(int nvecs, con
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
-	cpumask_var_t nmsk;
+	cpumask_var_t nmsk, *node_to_present_cpumask;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
@@ -73,13 +117,19 @@ irq_create_affinity_masks(int nvecs, con
 	if (!masks)
 		goto out;
 
+	node_to_present_cpumask = alloc_node_to_present_cpumask();
+	if (!node_to_present_cpumask)
+		goto out;
+
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
+	build_node_to_present_cpumask(node_to_present_cpumask);
+	nodes = get_nodes_in_cpumask(node_to_present_cpumask, cpu_present_mask,
+				     &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
@@ -87,7 +137,8 @@ irq_create_affinity_masks(int nvecs, con
 	 */
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec, cpumask_of_node(n));
+			cpumask_copy(masks + curvec,
+				     node_to_present_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -101,7 +152,7 @@ irq_create_affinity_masks(int nvecs, con
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
+		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -133,6 +184,7 @@ irq_create_affinity_masks(int nvecs, con
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
+	free_node_to_present_cpumask(node_to_present_cpumask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
@@ -147,12 +199,10 @@ int irq_calc_affinity_vectors(int maxvec
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int cpus;
+	int ret;
 
-	/* Stabilize the cpumasks */
 	get_online_cpus();
-	cpus = cpumask_weight(cpu_online_mask);
+	ret = min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
 	put_online_cpus();
-
-	return min(cpus, vecs) + resv;
+	return ret;
 }
