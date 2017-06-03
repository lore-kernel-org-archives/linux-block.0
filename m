Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] genirq/affinity: assign vectors to all present CPUs
Date: Sat,  3 Jun 2017 16:03:59 +0200
Message-Id: <20170603140403.27379-5-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently we only assign spread vectors to online CPUs, which ties the
IRQ mapping to the currently online devices and doesn't deal nicely with
the fact that CPUs could come and go rapidly due to e.g. power management.

Instead assign vectors to all present CPUs to avoid this churn.

For this we have to build a map of all possible CPUs for a give node, as
the architectures only provide a map of all onlines CPUs.  We do this
dynamically on each call for the vector assingments, which is a bit
suboptimal and could be optimized in the future by provinding a mapping
from the arch code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/affinity.c | 71 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 3cec0042fad2..337e6ffba93f 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -63,13 +63,54 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	}
 }
 
-static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
+static cpumask_var_t *alloc_node_to_present_cpumask(void)
+{
+	int node;
+	cpumask_var_t *masks;
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
@@ -92,7 +133,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
-	cpumask_var_t nmsk;
+	cpumask_var_t nmsk, *node_to_present_cpumask;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
@@ -101,13 +142,19 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
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
+			&nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
@@ -115,7 +162,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 */
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec, cpumask_of_node(n));
+			cpumask_copy(masks + curvec,
+				     node_to_present_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -129,7 +177,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
+		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -161,6 +209,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
+	free_node_to_present_cpumask(node_to_present_cpumask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
@@ -175,12 +224,6 @@ int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int cpus;
-
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	cpus = cpumask_weight(cpu_online_mask);
-	put_online_cpus();
 
-	return min(cpus, vecs) + resv;
+	return min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
 }
-- 
2.11.0
