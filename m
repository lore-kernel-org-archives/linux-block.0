Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbeAOQEk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 11:04:40 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] genirq/affinity: try best to make sure online CPU is assigned to vector
Date: Tue, 16 Jan 2018 00:03:45 +0800
Message-Id: <20180115160345.2611-3-ming.lei@redhat.com>
In-Reply-To: <20180115160345.2611-1-ming.lei@redhat.com>
References: <20180115160345.2611-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
causes irq vector assigned to all offline CPUs, and IO hang is reported
on HPSA by Laurence.

This patch fixes this issue by trying best to make sure online CPU can be
assigned to irq vector. And take two steps to spread irq vectors:

1) spread irq vectors across offline CPUs in the node cpumask

2) spread irq vectors across online CPUs in the node cpumask

Fixes: 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 99eb38a4cc83..8b716548b3db 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -103,6 +103,10 @@ static int irq_vecs_spread_affinity(struct cpumask *irqmsk,
 	int v, ncpus = cpumask_weight(nmsk);
 	int vecs_to_assign, extra_vecs;
 
+	/* May happen when spreading vectors across offline cpus */
+	if (!ncpus)
+		return 0;
+
 	/* How many vectors we will try to spread */
 	vecs_to_assign = min(max_vecs, ncpus);
 
@@ -165,13 +169,16 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_possible_cpumask(node_to_possible_cpumask);
-	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
-				     &nodemsk);
 
 	/*
+	 * Don't spread irq vector across offline node.
+	 *
 	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
+	 *
 	 */
+	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_online_mask,
+				     &nodemsk);
 	if (affv <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec,
@@ -182,14 +189,22 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		goto done;
 	}
 
+	nodes_clear(nodemsk);
+	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
+				     &nodemsk);
 	for_each_node_mask(n, nodemsk) {
 		int vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
 
-		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
+		/* spread vectors across offline cpus in the node cpumask */
+		cpumask_andnot(nmsk, node_to_possible_cpumask[n], cpu_online_mask);
+		irq_vecs_spread_affinity(&masks[curvec], last_affv - curvec,
+				vecs_per_node, nmsk);
 
+		/* spread vectors across online cpus in the node cpumask */
+		cpumask_and(nmsk, node_to_possible_cpumask[n], cpu_online_mask);
 		curvec += irq_vecs_spread_affinity(&masks[curvec],
 						   last_affv - curvec,
 						   vecs_per_node, nmsk);
-- 
2.9.5
