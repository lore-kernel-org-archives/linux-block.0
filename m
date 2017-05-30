Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH] blk-mq: Take tagset lock when updaing hw queues
Date: Tue, 30 May 2017 14:39:11 -0400
Message-Id: <1496169551-26868-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The tagset lock needs to be held when iterating the tag_list, so a
lockdep assert was added when updating number of hardware queues. The
drivers calling this API, however, were unaware of the new requirement,
so are failing the assertion.

This patch takes the lock within the blk-mq function so the drivers do
not have to be modified in order to be safe.

Fixes: 705cda97e ("blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list")

Reported-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2224ffd..1bccced 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2641,7 +2641,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
+							int nr_hw_queues)
 {
 	struct request_queue *q;
 
@@ -2665,6 +2666,13 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 }
+
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+{
+	mutex_lock(&set->tag_list_lock);
+	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
+	mutex_unlock(&set->tag_list_lock);
+}
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
 /* Enable polling stats and return whether they were already enabled. */
-- 
2.5.5
