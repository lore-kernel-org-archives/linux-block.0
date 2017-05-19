Return-Path: <BATV+c76b9e6b5f659e20e25d+5017+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] genirq/affinity: assign vectors to all present CPUs
Date: Fri, 19 May 2017 10:57:51 +0200
Message-Id: <20170519085756.29742-3-hch@lst.de>
In-Reply-To: <20170519085756.29742-1-hch@lst.de>
References: <20170519085756.29742-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently we only assign spread vectors to online CPUs, which ties the
IRQ mapping to the currently online devices and doesn't deal nicely with
the fact that CPUs could come and go rapidly due to e.g. power management.

Instead assign vectors to all present CPUs to avoid this churn.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/affinity.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e2d356dd7581..414b0be64bfc 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -4,6 +4,8 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 
+static cpumask_var_t node_to_present_cpumask[MAX_NUMNODES] __read_mostly;
+
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				int cpus_per_vec)
 {
@@ -40,8 +42,8 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
-	for_each_online_node(n) {
-		if (cpumask_intersects(mask, cpumask_of_node(n))) {
+	for_each_node(n) {
+		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -77,9 +79,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
+	nodes = get_nodes_in_cpumask(cpu_present_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
@@ -87,7 +87,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 */
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec, cpumask_of_node(n));
+			cpumask_copy(masks + curvec,
+				     node_to_present_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -101,7 +102,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
+		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -128,8 +129,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	}
 
 done:
-	put_online_cpus();
-
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
@@ -147,12 +146,26 @@ int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
-	int cpus;
 
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	cpus = cpumask_weight(cpu_online_mask);
-	put_online_cpus();
+	return min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
+}
+
+static int __init irq_build_cpumap(void)
+{
+	int node, cpu;
+
+	for (node = 0; node < nr_node_ids; node++) {
+		if (!zalloc_cpumask_var(&node_to_present_cpumask[node],
+				GFP_KERNEL))
+			panic("can't allocate early memory\n");
+	}
 
-	return min(cpus, vecs) + resv;
+	for_each_present_cpu(cpu) {
+		node = cpu_to_node(cpu);
+		cpumask_set_cpu(cpu, node_to_present_cpumask[node]);
+	}
+
+	return 0;
 }
+
+subsys_initcall(irq_build_cpumap);
-- 
2.11.0
