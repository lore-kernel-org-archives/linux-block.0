Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/5] genirq/affinity: rename *node_to_possible_cpumask as *node_to_cpumask
Date: Mon,  5 Mar 2018 11:13:53 +0800
Message-Id: <20180305031357.23950-2-ming.lei@redhat.com>
In-Reply-To: <20180305031357.23950-1-ming.lei@redhat.com>
References: <20180305031357.23950-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The following patches will introduce two stage irq spread for improving
irq spread on all possible CPUs.

No funtional change.

Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a37a3b4b6342..4b1c4763212d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -39,7 +39,7 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	}
 }
 
-static cpumask_var_t *alloc_node_to_possible_cpumask(void)
+static cpumask_var_t *alloc_node_to_cpumask(void)
 {
 	cpumask_var_t *masks;
 	int node;
@@ -62,7 +62,7 @@ static cpumask_var_t *alloc_node_to_possible_cpumask(void)
 	return NULL;
 }
 
-static void free_node_to_possible_cpumask(cpumask_var_t *masks)
+static void free_node_to_cpumask(cpumask_var_t *masks)
 {
 	int node;
 
@@ -71,7 +71,7 @@ static void free_node_to_possible_cpumask(cpumask_var_t *masks)
 	kfree(masks);
 }
 
-static void build_node_to_possible_cpumask(cpumask_var_t *masks)
+static void build_node_to_cpumask(cpumask_var_t *masks)
 {
 	int cpu;
 
@@ -79,14 +79,14 @@ static void build_node_to_possible_cpumask(cpumask_var_t *masks)
 		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
 }
 
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
+static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
 	for_each_node(n) {
-		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
+		if (cpumask_intersects(mask, node_to_cpumask[n])) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
@@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_possible_cpumask;
+	cpumask_var_t nmsk, *node_to_cpumask;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -125,8 +125,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!masks)
 		goto out;
 
-	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
-	if (!node_to_possible_cpumask)
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
 		goto out;
 
 	/* Fill out vectors at the beginning that don't need affinity */
@@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	build_node_to_possible_cpumask(node_to_possible_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
+	build_node_to_cpumask(node_to_cpumask);
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_possible_mask,
 				     &nodemsk);
 
 	/*
@@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
-				     node_to_possible_cpumask[n]);
+				     node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				break;
 		}
@@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
+		cpumask_and(nmsk, cpu_possible_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -192,7 +192,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
-	free_node_to_possible_cpumask(node_to_possible_cpumask);
+	free_node_to_cpumask(node_to_cpumask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
-- 
2.9.5
