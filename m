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
Subject: [PATCH 3/4] irq: pass first vector to __irq_build_affinity_masks
Date: Fri,  2 Nov 2018 22:59:50 +0800
Message-Id: <20181102145951.31979-4-ming.lei@redhat.com>
In-Reply-To: <20181102145951.31979-1-ming.lei@redhat.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

No functional change, and prepare for the following patch to
support allocating (and affinitizing) sets of IRQs, in which
each set of IRQ needs whole 2-stage spread, and the 1st vector
should point to the 1st one in this set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a16b601604aa..9c74f21ab10e 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -95,14 +95,14 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 }
 
 static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs,
+				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
 				    struct cpumask *nmsk,
 				    struct cpumask *masks)
 {
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	int last_affv = affd->pre_vectors + numvecs;
+	int last_affv = firstvec + numvecs;
 	int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 
@@ -121,7 +121,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 			if (++done == numvecs)
 				break;
 			if (++curvec == last_affv)
-				curvec = affd->pre_vectors;
+				curvec = firstvec;
 		}
 		goto out;
 	}
@@ -130,7 +130,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 		int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - affd->pre_vectors)) / nodes;
+		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
@@ -158,7 +158,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 		if (done >= numvecs)
 			break;
 		if (curvec >= last_affv)
-			curvec = affd->pre_vectors;
+			curvec = firstvec;
 		--nodes;
 	}
 
@@ -191,8 +191,8 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
 	usedvecs = __irq_build_affinity_masks(affd, curvec, numvecs,
-					    node_to_cpumask, cpu_present_mask,
-					    nmsk, masks);
+					affd->pre_vectors, node_to_cpumask,
+					cpu_present_mask, nmsk, masks);
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -206,8 +206,8 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 		curvec = affd->pre_vectors + usedvecs;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
 	usedvecs += __irq_build_affinity_masks(affd, curvec, numvecs,
-					     node_to_cpumask, npresmsk,
-					     nmsk, masks);
+					affd->pre_vectors, node_to_cpumask, npresmsk,
+					nmsk, masks);
 	put_online_cpus();
 
 	free_cpumask_var(npresmsk);
-- 
2.9.5
