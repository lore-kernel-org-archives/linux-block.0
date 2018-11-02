Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/4] irq: move 2-stage irq spread into one helper
Date: Fri,  2 Nov 2018 22:59:49 +0800
Message-Id: <20181102145951.31979-3-ming.lei@redhat.com>
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

No functional change, and prepare for the following patch to
support allocating (and affinitizing) sets of IRQs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 92 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 36 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..a16b601604aa 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,7 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int irq_build_affinity_masks(const struct irq_affinity *affd,
+static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
@@ -166,6 +166,58 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	return done;
 }
 
+/*
+ * build affinity in two stages:
+ *	1) spread present CPU on these vectors
+ *	2) spread other possible CPUs on these vectors
+ */
+static int irq_build_affinity_masks(const struct irq_affinity *affd,
+				    int startvec, int numvecs,
+				    cpumask_var_t *node_to_cpumask,
+				    struct cpumask *masks)
+{
+	int curvec = startvec, usedvecs = -1;
+	cpumask_var_t nmsk, npresmsk;
+
+	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+			return usedvecs;
+
+	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+			goto fail;
+
+	/* Stabilize the cpumasks */
+	get_online_cpus();
+	build_node_to_cpumask(node_to_cpumask);
+
+	/* Spread on present CPUs starting from affd->pre_vectors */
+	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
+					    node_to_cpumask, cpu_present_mask,
+					    nmsk, masks);
+
+	/*
+	 * Spread on non present CPUs starting from the next vector to be
+	 * handled. If the spreading of present CPUs already exhausted the
+	 * vector space, assign the non present CPUs to the already spread
+	 * out vectors.
+	 */
+	if (usedvecs >= numvecs)
+		curvec = affd->pre_vectors;
+	else
+		curvec = affd->pre_vectors + usedvecs;
+	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
+	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
+					     node_to_cpumask, npresmsk,
+					     nmsk, masks);
+	put_online_cpus();
+
+	free_cpumask_var(npresmsk);
+
+ fail:
+	free_cpumask_var(nmsk);
+
+	return usedvecs;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -178,7 +230,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t nmsk, npresmsk, *node_to_cpumask;
+	cpumask_var_t *node_to_cpumask;
 	struct cpumask *masks = NULL;
 
 	/*
@@ -188,15 +240,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return NULL;
-
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto outcpumsk;
-
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
-		goto outnpresmsk;
+		return NULL;
 
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
@@ -206,30 +252,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 
-	/* Stabilize the cpumasks */
-	get_online_cpus();
-	build_node_to_cpumask(node_to_cpumask);
-
-	/* Spread on present CPUs starting from affd->pre_vectors */
 	usedvecs = irq_build_affinity_masks(affd, curvec, affvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
-
-	/*
-	 * Spread on non present CPUs starting from the next vector to be
-	 * handled. If the spreading of present CPUs already exhausted the
-	 * vector space, assign the non present CPUs to the already spread
-	 * out vectors.
-	 */
-	if (usedvecs >= affvecs)
-		curvec = affd->pre_vectors;
-	else
-		curvec = affd->pre_vectors + usedvecs;
-	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	usedvecs += irq_build_affinity_masks(affd, curvec, affvecs,
-					     node_to_cpumask, npresmsk,
-					     nmsk, masks);
-	put_online_cpus();
+					    node_to_cpumask, masks);
 
 	/* Fill out vectors at the end that don't need affinity */
 	if (usedvecs >= affvecs)
@@ -241,10 +265,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
-outnpresmsk:
-	free_cpumask_var(npresmsk);
-outcpumsk:
-	free_cpumask_var(nmsk);
 	return masks;
 }
 
-- 
2.9.5
