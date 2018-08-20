Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeHUALc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 20:11:32 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2] block: fix rdma queue mapping
Date: Mon, 20 Aug 2018 13:54:20 -0700
Message-Id: <20180820205420.25908-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvme-rdma attempts to map queues based on irq vector affinity.
However, for some devices, completion vector irq affinity is
configurable by the user which can break the existing assumption
that irq vectors are optimally arranged over the host cpu cores.

So we map queues in two stages:
First map queues according to corresponding to the completion
vector IRQ affinity taking the first cpu in the vector affinity map.
if the current irq affinity is arranged such that a vector is not
assigned to any distinct cpu, we map it to a cpu that is on the same
node. If numa affinity can not be sufficed, we map it to any unmapped
cpu we can find. Then, map the remaining cpus in the possible cpumap
naively.

Tested-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fixed double semicolon typo

 block/blk-mq-cpumap.c  | 39 +++++++++++---------
 block/blk-mq-rdma.c    | 80 ++++++++++++++++++++++++++++++++++++------
 include/linux/blk-mq.h |  1 +
 3 files changed, 93 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3eb169f15842..34811db8cba9 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -30,30 +30,35 @@ static int get_first_sibling(unsigned int cpu)
 	return cpu;
 }
 
-int blk_mq_map_queues(struct blk_mq_tag_set *set)
+void blk_mq_map_queue_cpu(struct blk_mq_tag_set *set, unsigned int cpu)
 {
 	unsigned int *map = set->mq_map;
 	unsigned int nr_queues = set->nr_hw_queues;
-	unsigned int cpu, first_sibling;
+	unsigned int first_sibling;
 
-	for_each_possible_cpu(cpu) {
-		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue for
-		 * performace optimizations.
-		 */
-		if (cpu < nr_queues) {
+	/*
+	 * First do sequential mapping between CPUs and queues.
+	 * In case we still have CPUs to map, and we have some number of
+	 * threads per cores then map sibling threads to the same queue for
+	 * performace optimizations.
+	 */
+	if (cpu < nr_queues) {
+		map[cpu] = cpu_to_queue_index(nr_queues, cpu);
+	} else {
+		first_sibling = get_first_sibling(cpu);
+		if (first_sibling == cpu)
 			map[cpu] = cpu_to_queue_index(nr_queues, cpu);
-		} else {
-			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = cpu_to_queue_index(nr_queues, cpu);
-			else
-				map[cpu] = map[first_sibling];
-		}
+		else
+			map[cpu] = map[first_sibling];
 	}
+}
+
+int blk_mq_map_queues(struct blk_mq_tag_set *set)
+{
+	unsigned int cpu;
 
+	for_each_possible_cpu(cpu)
+		blk_mq_map_queue_cpu(set, cpu);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 996167f1de18..3bce60cd5bcf 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -14,6 +14,61 @@
 #include <linux/blk-mq-rdma.h>
 #include <rdma/ib_verbs.h>
 
+static int blk_mq_rdma_map_queue(struct blk_mq_tag_set *set,
+		struct ib_device *dev, int first_vec, unsigned int queue)
+{
+	const struct cpumask *mask;
+	unsigned int cpu;
+	bool mapped = false;
+
+	mask = ib_get_vector_affinity(dev, first_vec + queue);
+	if (!mask)
+		return -ENOTSUPP;
+
+	/* map with an unmapped cpu according to affinity mask */
+	for_each_cpu(cpu, mask) {
+		if (set->mq_map[cpu] == UINT_MAX) {
+			set->mq_map[cpu] = queue;
+			mapped = true;
+			break;
+		}
+	}
+
+	if (!mapped) {
+		int n;
+
+		/* map with an unmapped cpu in the same numa node */
+		for_each_node(n) {
+			const struct cpumask *node_cpumask = cpumask_of_node(n);
+
+			if (!cpumask_intersects(mask, node_cpumask))
+				continue;
+
+			for_each_cpu(cpu, node_cpumask) {
+				if (set->mq_map[cpu] == UINT_MAX) {
+					set->mq_map[cpu] = queue;
+					mapped = true;
+					break;
+				}
+			}
+		}
+	}
+
+	if (!mapped) {
+		/* map with any unmapped cpu we can find */
+		for_each_possible_cpu(cpu) {
+			if (set->mq_map[cpu] == UINT_MAX) {
+				set->mq_map[cpu] = queue;
+				mapped = true;
+				break;
+			}
+		}
+	}
+
+	WARN_ON_ONCE(!mapped);
+	return 0;
+}
+
 /**
  * blk_mq_rdma_map_queues - provide a default queue mapping for rdma device
  * @set:	tagset to provide the mapping for
@@ -21,31 +76,36 @@
  * @first_vec:	first interrupt vectors to use for queues (usually 0)
  *
  * This function assumes the rdma device @dev has at least as many available
- * interrupt vetors as @set has queues.  It will then query it's affinity mask
- * and built queue mapping that maps a queue to the CPUs that have irq affinity
- * for the corresponding vector.
+ * interrupt vetors as @set has queues.  It will then query vector affinity mask
+ * and attempt to build irq affinity aware queue mappings. If optimal affinity
+ * aware mapping cannot be acheived for a given queue, we look for any unmapped
+ * cpu to map it. Lastly, we map naively all other unmapped cpus in the mq_map.
  *
  * In case either the driver passed a @dev with less vectors than
  * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
  * vector, we fallback to the naive mapping.
  */
 int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
-		struct ib_device *dev, int first_vec)
+                struct ib_device *dev, int first_vec)
 {
-	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
+	/* reset cpu mapping */
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = UINT_MAX;
+
 	for (queue = 0; queue < set->nr_hw_queues; queue++) {
-		mask = ib_get_vector_affinity(dev, first_vec + queue);
-		if (!mask)
+		if (blk_mq_rdma_map_queue(set, dev, first_vec, queue))
 			goto fallback;
+	}
 
-		for_each_cpu(cpu, mask)
-			set->mq_map[cpu] = queue;
+	/* map any remaining unmapped cpus */
+	for_each_possible_cpu(cpu) {
+		if (set->mq_map[cpu] == UINT_MAX)
+			blk_mq_map_queue_cpu(set, cpu);
 	}
 
 	return 0;
-
 fallback:
 	return blk_mq_map_queues(set);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d710e92874cc..6eb09c4de34f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -285,6 +285,7 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
+void blk_mq_map_queue_cpu(struct blk_mq_tag_set *set, unsigned int cpu);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
-- 
2.17.1
