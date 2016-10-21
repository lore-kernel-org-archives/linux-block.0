Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] blk-mq: use GFP_KERNEL for allocations in blk_mq_map_queues()
Date: Fri, 21 Oct 2016 16:51:25 +0200
Message-Id: <20161021145125.31284-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

There is one caller of blk_mq_map_queues() which already doing a GFP_KERNEL
allocation for ->mq_map so I don't see the need for GFP_ATOMIC later in
blk_mq_map_queues().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-mq-cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 19b1d9c5f07e..7fc37f28b433 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -39,7 +39,7 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set)
 	unsigned int i, nr_cpus, nr_uniq_cpus, queue, first_sibling;
 	cpumask_var_t cpus;
=20
-	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC))
+	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
 		return -ENOMEM;
=20
 	cpumask_clear(cpus);
--=20
2.9.3
