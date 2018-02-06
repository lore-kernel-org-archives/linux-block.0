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
Subject: [PATCH 4/5] genirq/affinity: irq vector spread among online CPUs as far as possible
Date: Tue,  6 Feb 2018 20:17:41 +0800
Message-Id: <20180206121742.29336-5-ming.lei@redhat.com>
In-Reply-To: <20180206121742.29336-1-ming.lei@redhat.com>
References: <20180206121742.29336-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
may cause irq vector assigned to all offline CPUs, and this kind of
assignment may cause much less irq vectors mapped to online CPUs, and
performance may get hurt.

For example, in a 8 cores system, 0~3 online, 4~8 offline/not present,
see 'lscpu':

	[ming@box]$lscpu
	Architecture:          x86_64
	CPU op-mode(s):        32-bit, 64-bit
	Byte Order:            Little Endian
	CPU(s):                4
	On-line CPU(s) list:   0-3
	Thread(s) per core:    1
	Core(s) per socket:    2
	Socket(s):             2
	NUMA node(s):          2
	...
	NUMA node0 CPU(s):     0-3
	NUMA node1 CPU(s):
	...

For example, one device has 4 queues:

1) before 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
	irq 39, cpu list 0
	irq 40, cpu list 1
	irq 41, cpu list 2
	irq 42, cpu list 3

2) after 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
	irq 39, cpu list 0-2
	irq 40, cpu list 3-4,6
	irq 41, cpu list 5
	irq 42, cpu list 7

3) after applying this patch against V4.15+:
	irq 39, cpu list 0,4
	irq 40, cpu list 1,6
	irq 41, cpu list 2,5
	irq 42, cpu list 3,7

This patch tries to do irq vector spread among online CPUs as far as
possible by 2 stages spread.

The above assignment 3) isn't the optimal result from NUMA view, but it
returns more irq vectors with online CPU mapped, given in reality one CPU
should be enough to handle one irq vector, so it is better to do this way.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 9801aecf8763..6755ed77d017 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -106,6 +106,9 @@ int irq_build_affinity_masks(const struct irq_affinity *affd,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
 
+	if (!cpumask_weight(cpu_mask))
+		return 0;
+
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
@@ -175,9 +178,9 @@ struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
-	int curvec;
+	int curvec, vecs_offline, vecs_online;
 	struct cpumask *masks;
-	cpumask_var_t nmsk, *node_to_cpumask;
+	cpumask_var_t nmsk, cpu_mask, *node_to_cpumask;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -193,9 +196,12 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!masks)
 		goto out;
 
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		goto out;
+
 	node_to_cpumask = alloc_node_to_cpumask();
 	if (!node_to_cpumask)
-		goto out;
+		goto out_free_cpu_mask;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
@@ -204,15 +210,32 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
-	curvec += irq_build_affinity_masks(affd, curvec, affv,
-					   node_to_cpumask,
-					   cpu_possible_mask, nmsk, masks);
+	/* spread on online CPUs starting from the vector of affd->pre_vectors */
+	vecs_online = irq_build_affinity_masks(affd, curvec, affv,
+					       node_to_cpumask,
+					       cpu_online_mask, nmsk, masks);
+
+	/* spread on offline CPUs starting from the next vector to be handled */
+	if (vecs_online >= affv)
+		curvec = affd->pre_vectors;
+	else
+		curvec = affd->pre_vectors + vecs_online;
+	cpumask_andnot(cpu_mask, cpu_possible_mask, cpu_online_mask);
+	vecs_offline = irq_build_affinity_masks(affd, curvec, affv,
+						node_to_cpumask,
+					        cpu_mask, nmsk, masks);
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
+	if (vecs_online + vecs_offline >= affv)
+		curvec = affv + affd->pre_vectors;
+	else
+		curvec = affd->pre_vectors + vecs_online + vecs_offline;
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
 	free_node_to_cpumask(node_to_cpumask);
+out_free_cpu_mask:
+	free_cpumask_var(cpu_mask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
-- 
2.9.5
