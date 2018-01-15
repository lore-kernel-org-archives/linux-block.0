Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933878AbeAOQEb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 11:04:31 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] genirq/affinity: move irq vectors spread into one function
Date: Tue, 16 Jan 2018 00:03:44 +0800
Message-Id: <20180115160345.2611-2-ming.lei@redhat.com>
In-Reply-To: <20180115160345.2611-1-ming.lei@redhat.com>
References: <20180115160345.2611-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch is preparing for doing two steps spread:

	- spread vectors across non-online CPUs
	- spread vectors across online CPUs

This way is applied for trying best to avoid allocating all offline CPUs
to one single vector.

No functional change, and code gets cleaned up too.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 56 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a37a3b4b6342..99eb38a4cc83 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,6 +94,35 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
 	return nodes;
 }
 
+/* Spread irq vectors, and the result is stored to @irqmsk. */
+static int irq_vecs_spread_affinity(struct cpumask *irqmsk,
+				    int max_irqmsks,
+				    int max_vecs,
+				    struct cpumask *nmsk)
+{
+	int v, ncpus = cpumask_weight(nmsk);
+	int vecs_to_assign, extra_vecs;
+
+	/* How many vectors we will try to spread */
+	vecs_to_assign = min(max_vecs, ncpus);
+
+	/* Account for rounding errors */
+	extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+
+	for (v = 0; v < min(max_irqmsks, vecs_to_assign); v++) {
+		int cpus_per_vec = ncpus / vecs_to_assign;
+
+		/* Account for extra vectors to compensate rounding errors */
+		if (extra_vecs) {
+			cpus_per_vec++;
+			--extra_vecs;
+		}
+		irq_spread_init_one(irqmsk + v, nmsk, cpus_per_vec);
+	}
+
+	return v;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -104,7 +133,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
 struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, curvec;
+	int n, nodes, curvec;
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
@@ -154,33 +183,16 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		int ncpus, v, vecs_to_assign, vecs_per_node;
+		int vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
-		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
 
-		/* Calculate the number of cpus per vector */
-		ncpus = cpumask_weight(nmsk);
-		vecs_to_assign = min(vecs_per_node, ncpus);
-
-		/* Account for rounding errors */
-		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
-
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
-		     curvec++, v++) {
-			cpus_per_vec = ncpus / vecs_to_assign;
-
-			/* Account for extra vectors to compensate rounding errors */
-			if (extra_vecs) {
-				cpus_per_vec++;
-				--extra_vecs;
-			}
-			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
-		}
-
+		curvec += irq_vecs_spread_affinity(&masks[curvec],
+						   last_affv - curvec,
+						   vecs_per_node, nmsk);
 		if (curvec >= last_affv)
 			break;
 		--nodes;
-- 
2.9.5
