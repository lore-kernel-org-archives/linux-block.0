Return-Path: <BATV+0f69485e8eba9f9d9296+5085+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: shli@kernel.org,
	osandov@osandov.com,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: provide an explicit n:1 mapping for single queue devices
Date: Wed, 26 Jul 2017 22:19:34 +0200
Message-Id: <20170726201934.4940-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This avoids having to deal with the nr_hw_queues = 1 case in the various
queue mapping helpers by special casing it in the blk-mq core.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Shaohua Li <shli@kernel.org>
---
 block/blk-mq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..50d1f069d83b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2458,9 +2458,20 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+static int blk_mq_map_single_queue(struct blk_mq_tag_set *set)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+	return 0;
+}
+
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
-	if (set->ops->map_queues)
+	if (set->nr_hw_queues == 1)
+		return blk_mq_map_single_queue(set);
+	else if (set->ops->map_queues)
 		return set->ops->map_queues(set);
 	else
 		return blk_mq_map_queues(set);
-- 
2.11.0
