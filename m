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
Subject: [PATCH 2/3] blk-mq: Provide freeze queue timeout
Date: Wed,  1 Mar 2017 14:22:11 -0500
Message-Id: <1488396132-11369-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

A driver may wish to take corrective action if queued requests do not
complete within a set time.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c         | 9 +++++++++
 include/linux/blk-mq.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8da2c04..a5e66a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -81,6 +81,15 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
+				     unsigned long timeout)
+{
+	return wait_event_timeout(q->mq_freeze_wq,
+					percpu_ref_is_zero(&q->q_usage_counter),
+					timeout);
+}
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
+
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8dacf68..b296a90 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -246,6 +246,8 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
+int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
+				     unsigned long timeout);
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
-- 
2.5.5
