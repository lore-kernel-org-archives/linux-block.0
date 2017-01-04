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
Subject: [PATCH 4/6] blk-mq: Update queue map when changing queue count
Date: Wed,  4 Jan 2017 17:41:09 -0500
Message-Id: <1483569671-1462-5-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The queue map needs to match how many hardware queues exist, otherwise
it may indicate a less than optimal mapping, contain a hctx_id that
was freed, or attempt to initialize a request map for invalid context.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8e67a1..9b7ed03 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2223,7 +2223,6 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 	 * we should change hctx numa_node according to new topology (this
 	 * involves free and re-allocate memory, worthy doing?)
 	 */
-
 	blk_mq_map_swqueue(q, online_mask);
 
 	blk_mq_sysfs_register(q);
@@ -2481,6 +2480,11 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 		blk_mq_freeze_queue(q);
 
 	set->nr_hw_queues = nr_hw_queues;
+	if (set->ops->map_queues)
+		set->ops->map_queues(set);
+	else
+		blk_mq_map_queues(set);
+
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
 
-- 
2.5.5
