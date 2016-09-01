Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30497 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbcIAXTk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Sep 2016 19:19:40 -0400
Date: Thu, 1 Sep 2016 19:30:10 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
Message-ID: <20160901233010.GC10903@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain>
 <20160901084624.GC4115@lst.de>
 <20160901142410.GA10903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160901142410.GA10903@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 01, 2016 at 10:24:10AM -0400, Keith Busch wrote:
> Yeah, I gathered that's what it was providing, but that's just barely
> not enough information to do something useful. The CPUs that aren't set
> have to use a previously assigned vector/queue, but which one?

Unless I'm totally missing how to infer paired CPUs, I think we need
arrays.

Here's a stab at that. I'm using the "old" algorithm the NVMe driver used
to pair vectors and cpus. It's not the most efficient way of pairing
that I know of, but it is easy to follow (relatively speaking), and it
actually utilizes every hardware resource available so I get very good
CPU <-> Queue mappings.

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9cc08c6..c5c038e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2283,7 +2283,7 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
 		const struct cpumask *affinity_mask)
 {
-	int queue = -1, cpu = 0;
+	int queue;
 
 	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
 			GFP_KERNEL, set->numa_node);
@@ -2293,11 +2293,10 @@ static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
 	if (!affinity_mask)
 		return 0;	/* map all cpus to queue 0 */
 
-	/* If cpus are offline, map them to first hctx */
-	for_each_online_cpu(cpu) {
-		if (cpumask_test_cpu(cpu, affinity_mask))
-			queue++;
-		if (queue >= 0)
+	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+		int cpu;
+
+		for_each_cpu(cpu, &affinity_mask[queue])
 			set->mq_map[cpu] = queue;
 	}
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 98f1222..03a1ffc 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -683,15 +683,11 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 {
 	const struct cpumask *mask = NULL;
 	struct msi_desc *entry;
-	int cpu = -1, i;
+	int i;
 
 	for (i = 0; i < nvec; i++) {
-		if (dev->irq_affinity) {
-			cpu = cpumask_next(cpu, dev->irq_affinity);
-			if (cpu >= nr_cpu_ids)
-				cpu = cpumask_first(dev->irq_affinity);
-			mask = cpumask_of(cpu);
-		}
+		if (dev->irq_affinity)
+			mask = &dev->irq_affinity[i];
 
 		entry = alloc_msi_entry(&dev->dev);
 		if (!entry) {
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 32f6cfc..9fe548b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -4,14 +4,47 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 
-static int get_first_sibling(unsigned int cpu)
+static int find_closest_node(int node)
 {
-	unsigned int ret;
+	int n, val, min_val = INT_MAX, best_node = node;
+
+	for_each_online_node(n) {
+		if (n == node)
+			continue;
+		val = node_distance(node, n);
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+	return best_node;
+}
+
+static void set_vec_cpus(const cpumask_t *qmask, struct cpumask *affinity_mask,
+								int count)
+{
+	int cpu;
+
+	for_each_cpu(cpu, qmask) {
+		if (cpumask_weight(affinity_mask) >= count)
+			break;
+		cpumask_set_cpu(cpu, affinity_mask);
+	}
+}
+
+static void add_cpus(cpumask_t *mask, const cpumask_t *unassigned_cpus,
+	const cpumask_t *new_mask, struct cpumask *affinity_mask,
+	int cpus_per_queue)
+{
+	int next_cpu;
+
+	for_each_cpu(next_cpu, new_mask) {
+		cpumask_or(mask, mask, get_cpu_mask(next_cpu));
+		cpumask_or(mask, mask, topology_sibling_cpumask(next_cpu));
+		cpumask_and(mask, mask, unassigned_cpus);
+	}
+	set_vec_cpus(mask, affinity_mask, cpus_per_queue);
 
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-	return cpu;
 }
 
 /*
@@ -27,37 +60,76 @@ static int get_first_sibling(unsigned int cpu)
  */
 struct cpumask *irq_create_affinity_mask(unsigned int *nr_vecs)
 {
-	struct cpumask *affinity_mask;
-	unsigned int max_vecs = *nr_vecs;
+	struct cpumask *affinity_mask, *masks;
+	unsigned int max_vecs = *nr_vecs, cpu, cpus_per_vec, remainder, i;
+	cpumask_var_t unassigned_cpus;
 
 	if (max_vecs == 1)
 		return NULL;
 
-	affinity_mask = kzalloc(cpumask_size(), GFP_KERNEL);
-	if (!affinity_mask) {
+	masks = kcalloc(max_vecs, sizeof(*affinity_mask), GFP_KERNEL);
+	if (!masks) {
 		*nr_vecs = 1;
 		return NULL;
 	}
 
 	get_online_cpus();
-	if (max_vecs >= num_online_cpus()) {
-		cpumask_copy(affinity_mask, cpu_online_mask);
-		*nr_vecs = num_online_cpus();
-	} else {
-		unsigned int vecs = 0, cpu;
-
-		for_each_online_cpu(cpu) {
-			if (cpu == get_first_sibling(cpu)) {
-				cpumask_set_cpu(cpu, affinity_mask);
-				vecs++;
-			}
-
-			if (--max_vecs == 0)
-				break;
-		}
-		*nr_vecs = vecs;
+
+	cpus_per_vec = num_online_cpus() / max_vecs;
+	remainder = max_vecs - (num_online_cpus() - max_vecs * cpus_per_vec);
+
+	cpumask_copy(unassigned_cpus, cpu_online_mask);
+	cpu = cpumask_first(unassigned_cpus);
+
+	for (i = 0; i < max_vecs; i++) {
+		cpumask_t mask;
+
+		if (!cpumask_weight(unassigned_cpus))
+			break;
+
+		affinity_mask = &masks[i];
+
+		mask = *get_cpu_mask(cpu);
+		set_vec_cpus(&mask, affinity_mask, cpus_per_vec);
+
+		if (cpumask_weight(&mask) < cpus_per_vec)
+			add_cpus(&mask, unassigned_cpus,
+				topology_sibling_cpumask(cpu),
+				affinity_mask, cpus_per_vec);
+		if (cpumask_weight(&mask) < cpus_per_vec)
+			add_cpus(&mask, unassigned_cpus,
+				topology_core_cpumask(cpu),
+				affinity_mask, cpus_per_vec);
+		if (cpumask_weight(&mask) < cpus_per_vec)
+			add_cpus(&mask, unassigned_cpus,
+				cpumask_of_node(cpu_to_node(cpu)),
+				affinity_mask, cpus_per_vec);
+		if (cpumask_weight(&mask) < cpus_per_vec)
+			add_cpus(&mask, unassigned_cpus,
+				cpumask_of_node(
+					find_closest_node(
+						cpu_to_node(cpu))),
+				affinity_mask, cpus_per_vec);
+		if (cpumask_weight(&mask) < cpus_per_vec)
+			add_cpus(&mask, unassigned_cpus,
+				unassigned_cpus, affinity_mask,
+				cpus_per_vec);
+
+		cpumask_andnot(unassigned_cpus, unassigned_cpus, affinity_mask);
+		cpu = cpumask_next(cpu, unassigned_cpus);
+
+		if (remainder && !--remainder)
+			cpus_per_vec++;
 	}
 	put_online_cpus();
 
-	return affinity_mask;
+	i = 0;
+	cpumask_andnot(unassigned_cpus, cpu_possible_mask, cpu_online_mask);
+	for_each_cpu(cpu, unassigned_cpus) {
+		set_vec_cpus(get_cpu_mask(cpu), &masks[i], ~0);
+		i = (i + 1) % max_vecs;
+	}
+	free_cpumask_var(unassigned_cpus);
+
+	return masks;
 }
--
