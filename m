Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbeIRPp2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:28 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/3] blk-mq: introduce blk_mq_unfreeze_queue_no_drain_io
Date: Tue, 18 Sep 2018 18:13:09 +0800
Message-Id: <20180918101310.13154-3-ming.lei@redhat.com>
In-Reply-To: <20180918101310.13154-1-ming.lei@redhat.com>
References: <20180918101310.13154-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces blk_mq_unfreeze_queue_no_drain_io() so that
it can be used when no necessary to check if IO is drained, such
as nvme pci resetting(nvme_reset_work).

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 25 +++++++++++++++++++++++--
 include/linux/blk-mq.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..a22f82061b93 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -191,20 +191,41 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void blk_mq_unfreeze_queue(struct request_queue *q)
+static void __blk_mq_unfreeze_queue(struct request_queue *q,
+		bool need_drop_zero)
 {
 	int freeze_depth;
 
 	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
-		percpu_ref_reinit(&q->q_usage_counter);
+		if (need_drop_zero)
+			percpu_ref_reinit(&q->q_usage_counter);
+		else
+			percpu_ref_resurge(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
+
+void blk_mq_unfreeze_queue(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, true);
+}
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
+ * Compared with blk_mq_unfreeze_queue(), the verion of _no_drain_io
+ * doesn't require the queue is really frozen, and it is useful in
+ * case of timeout handling in which IO can't be drained and has to
+ * be retried after controler is recovered.
+ */
+void blk_mq_unfreeze_queue_no_drain_io(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_no_drain_io);
+
+/*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
  */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..5e0740ec407f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -279,6 +279,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
+void blk_mq_unfreeze_queue_no_drain_io(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
-- 
2.9.5
