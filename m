Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] genirq/affinity: support to do irq vectors spread starting from any vector
Date: Tue,  6 Feb 2018 20:17:40 +0800
Message-Id: <20180206121742.29336-4-ming.lei@redhat.com>
In-Reply-To: <20180206121742.29336-1-ming.lei@redhat.com>
References: <20180206121742.29336-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now two parameters(start_vec, affv) are introduced to irq_build_affinity_masks(),
then this helper can build the affinity of each irq vector starting from
the irq vector of 'start_vec', and handle at most 'affv' vectors.

This way is required to do 2-stages irq vectors spread among all
possible CPUs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6af3f6727f63..9801aecf8763 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,17 +94,17 @@ static int get_nodes_in_cpumask(const cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
+int irq_build_affinity_masks(const struct irq_affinity *affd,
+			     const int start_vec, const int affv,
 			     const cpumask_var_t *node_to_cpumask,
 			     const struct cpumask *cpu_mask,
 			     struct cpumask *nmsk,
 			     struct cpumask *masks)
 {
-	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
-	int curvec = affd->pre_vectors;
+	int curvec = start_vec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	int n, nodes, cpus_per_vec, extra_vecs;
+	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
 
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
@@ -116,8 +116,10 @@ int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
 				     node_to_cpumask[n]);
-			if (++curvec == last_affv)
+			if (++done == affv)
 				break;
+			if (++curvec == last_affv)
+				curvec = affd->pre_vectors;
 		}
 		goto out;
 	}
@@ -150,13 +152,16 @@ int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
 			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
 		}
 
-		if (curvec >= last_affv)
+		done += v;
+		if (done >= affv)
 			break;
+		if (curvec >= last_affv)
+			curvec = affd->pre_vectors;
 		--nodes;
 	}
 
 out:
-	return curvec - affd->pre_vectors;
+	return done;
 }
 
 /**
@@ -169,6 +174,7 @@ int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
 struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
+	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec;
 	struct cpumask *masks;
 	cpumask_var_t nmsk, *node_to_cpumask;
@@ -198,7 +204,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
-	curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
+	curvec += irq_build_affinity_masks(affd, curvec, affv,
+					   node_to_cpumask,
 					   cpu_possible_mask, nmsk, masks);
 	put_online_cpus();
 
-- 
2.9.5
