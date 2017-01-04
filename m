Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Merlin <marc@merlins.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/6] irq/affinity: Assign all online CPUs to vectors
Date: Wed,  4 Jan 2017 17:41:06 -0500
Message-Id: <1483569671-1462-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This patch makes sure all online CPUs are assigned to vectors in
cases where the nodes don't have the same number of online CPUs.
The calculation for how many vectors needs to be assigned should account
for the number of CPUs for a particular node on each round of assignment
in order to ensure all online CPUs are assigned a vector when they don't
evenly divide, and calculate extras accordingly.

Since we attempt to divide evently among the nodes, this may still result
in unused vectors if some nodes have fewer CPUs than nodes previosuly
set up, but at least every online CPU will be assigned to something.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 kernel/irq/affinity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4544b11..b25dce0 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -96,17 +96,19 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Spread the vectors per node */
 	vecs_per_node = affv / nodes;
-	/* Account for rounding errors */
-	extra_vecs = affv - (nodes * vecs_per_node);
 
 	for_each_node_mask(n, nodemsk) {
-		int ncpus, v, vecs_to_assign = vecs_per_node;
+		int ncpus, v, vecs_to_assign;
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
+		vecs_to_assign = min(vecs_per_node, ncpus);
+
+		/* Account for rounding errors */
+		extra_vecs = ncpus - vecs_to_assign;
 
 		for (v = 0; curvec < last_affv && v < vecs_to_assign;
 		     curvec++, v++) {
@@ -123,6 +125,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 		if (curvec >= last_affv)
 			break;
+		vecs_per_node = (affv - curvec) / --nodes;
 	}
 
 done:
-- 
2.5.5
