Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/3] blk-mq: Export blk_mq_freeze_queue_wait
Date: Wed,  1 Mar 2017 14:22:10 -0500
Message-Id: <1488396132-11369-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

Drivers can start a freeze, so this provides a way to wait for frozen.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 94593c6..8da2c04 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -75,10 +75,11 @@ void blk_mq_freeze_queue_start(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
-static void blk_mq_freeze_queue_wait(struct request_queue *q)
+void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
 	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
 }
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
 /*
  * Guarantee no request is in use, so we can change any data structure of
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 001d30d..8dacf68 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -245,6 +245,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
+void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
-- 
2.5.5
