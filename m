Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/4] genirq/affinity: move actual irq vector spread into one helper
Date: Thu,  8 Mar 2018 18:53:56 +0800
Message-Id: <20180308105358.1506-3-ming.lei@redhat.com>
In-Reply-To: <20180308105358.1506-1-ming.lei@redhat.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

No functional change, just prepare for converting to 2-stage
irq vector spread.

Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 97 +++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4b1c4763212d..e119e86bed48 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,50 +94,19 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-/**
- * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
- * @nvecs:	The total number of vectors
- * @affd:	Description of the affinity requirements
- *
- * Returns the masks pointer or NULL if allocation failed.
- */
-struct cpumask *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
+				    cpumask_var_t *node_to_cpumask,
+				    const struct cpumask *cpu_mask,
+				    struct cpumask *nmsk,
+				    struct cpumask *masks)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, curvec;
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
+	int curvec = affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_cpumask;
-
-	/*
-	 * If there aren't any vectors left after applying the pre/post
-	 * vectors don't bother with assigning affinity.
-	 */
-	if (!affv)
-		return NULL;
-
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return NULL;
-
-	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto out;
+	int n, nodes, cpus_per_vec, extra_vecs;
 
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		goto out;
-
-	/* Fill out vectors at the beginning that don't need affinity */
-	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
-
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	build_node_to_cpumask(node_to_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_possible_mask,
-				     &nodemsk);
+	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is greater than or equal the
@@ -150,7 +119,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 			if (++curvec == last_affv)
 				break;
 		}
-		goto done;
+		goto out;
 	}
 
 	for_each_node_mask(n, nodemsk) {
@@ -160,7 +129,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_possible_mask, node_to_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
@@ -186,7 +155,51 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		--nodes;
 	}
 
-done:
+out:
+	return curvec - affd->pre_vectors;
+}
+
+/**
+ * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
+ * @nvecs:	The total number of vectors
+ * @affd:	Description of the affinity requirements
+ *
+ * Returns the masks pointer or NULL if allocation failed.
+ */
+struct cpumask *
+irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+{
+	int curvec;
+	struct cpumask *masks;
+	cpumask_var_t nmsk, *node_to_cpumask;
+
+	/*
+	 * If there aren't any vectors left after applying the pre/post
+	 * vectors don't bother with assigning affinity.
+	 */
+	if (nvecs == affd->pre_vectors + affd->post_vectors)
+		return NULL;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+		return NULL;
+
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto out;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto out;
+
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_copy(masks + curvec, irq_default_affinity);
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	build_node_to_cpumask(node_to_cpumask);
+	curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
+					   cpu_possible_mask, nmsk, masks);
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
-- 
2.9.5
