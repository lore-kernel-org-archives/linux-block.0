Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/16] blk-mq: provide dummy blk_mq_map_queue_type() helper
Date: Tue, 30 Oct 2018 12:32:39 -0600
Message-Id: <20181030183252.17857-4-axboe@kernel.dk>
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Doesn't do anything right now, but it's needed as a prep patch
to get the interfaces right.

While in there, correct the blk_mq_map_queue() CPU type to an unsigned
int.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 889f0069dd80..d9facfb9ca51 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -73,13 +73,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
 
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-		int cpu)
+						     unsigned int cpu)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
 	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
+							  unsigned int hctx_type,
+							  unsigned int cpu)
+{
+	return blk_mq_map_queue(q, cpu);
+}
+
 /*
  * sysfs helpers
  */
-- 
2.17.1
