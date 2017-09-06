Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] block: remove blk_mq_reinit_tagset
Date: Wed,  6 Sep 2017 18:30:32 +0300
Message-Id: <1504711832-28425-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
References: <1504711832-28425-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

No callers left.

Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-tag.c     | 7 -------
 include/linux/blk-mq.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index bce1c76fc768..c81b40ecd3f1 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -327,13 +327,6 @@ int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
 }
 EXPORT_SYMBOL_GPL(blk_mq_tagset_iter);
 
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
-			 int (reinit_request)(void *, struct request *))
-{
-	return blk_mq_tagset_iter(set, set->driver_data, reinit_request);
-}
-EXPORT_SYMBOL_GPL(blk_mq_reinit_tagset);
-
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6bc29f73a9aa..cfd64e500d82 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -261,8 +261,6 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 int blk_mq_tagset_iter(struct blk_mq_tag_set *set, void *data,
 		int (reinit_request)(void *, struct request *));
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
-			 int (reinit_request)(void *, struct request *));
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.7.4
