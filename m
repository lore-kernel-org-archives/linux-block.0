Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] blk-mq: include all present CPUs in the default queue mapping
Date: Sat,  3 Jun 2017 16:04:01 +0200
Message-Id: <20170603140403.27379-7-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This way we get a nice distribution independent of the current cpu
online / offline state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-cpumap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 8e61e8640e17..5eaecd40f701 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -35,7 +35,6 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set)
 {
 	unsigned int *map = set->mq_map;
 	unsigned int nr_queues = set->nr_hw_queues;
-	const struct cpumask *online_mask = cpu_online_mask;
 	unsigned int i, nr_cpus, nr_uniq_cpus, queue, first_sibling;
 	cpumask_var_t cpus;
 
@@ -44,7 +43,7 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set)
 
 	cpumask_clear(cpus);
 	nr_cpus = nr_uniq_cpus = 0;
-	for_each_cpu(i, online_mask) {
+	for_each_present_cpu(i) {
 		nr_cpus++;
 		first_sibling = get_first_sibling(i);
 		if (!cpumask_test_cpu(first_sibling, cpus))
@@ -54,7 +53,7 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set)
 
 	queue = 0;
 	for_each_possible_cpu(i) {
-		if (!cpumask_test_cpu(i, online_mask)) {
+		if (!cpumask_test_cpu(i, cpu_present_mask)) {
 			map[i] = 0;
 			continue;
 		}
-- 
2.11.0
