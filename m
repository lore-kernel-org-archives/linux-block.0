Return-Path: <sbates@raithlin.com>
From: Stephen Bates <sbates@raithlin.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de
Subject: [PATCH 1/2] Add poll_considered statistic
Date: Tue, 13 Sep 2016 12:23:15 -0600
Message-Id: <1473790996-27038-2-git-send-email-sbates@raithlin.com>
In-Reply-To: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
References: <1473790996-27038-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

In order to help determine the effectiveness of polling in a running
system it is usful to determine the ratio of how often the poll
function is called vs how often the completion is checked. For this
reason we add a poll_considered variable and add it to the sysfs entry
for io_poll.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-core.c       | 8 ++++++--
 block/blk-mq-sysfs.c   | 4 +++-
 include/linux/blk-mq.h | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 34ff808..14d7c07 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3307,19 +3307,23 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_plug *plug;
 	long state;
+	unsigned int queue_num;
+	struct blk_mq_hw_ctx *hctx;
 
 	if (!q->mq_ops || !q->mq_ops->poll || !blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return false;
 
+	queue_num = blk_qc_t_to_queue_num(cookie);
+	hctx = q->queue_hw_ctx[queue_num];
+	hctx->poll_considered++;
+
 	plug = current->plug;
 	if (plug)
 		blk_flush_plug_list(plug, false);
 
 	state = current->state;
 	while (!need_resched()) {
-		unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
-		struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[queue_num];
 		int ret;
 
 		hctx->poll_invoked++;
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index fe822aa..ea8c3f5 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -176,7 +176,9 @@ static ssize_t blk_mq_sysfs_rq_list_show(struct blk_mq_ctx *ctx, char *page)
 
 static ssize_t blk_mq_hw_sysfs_poll_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
-	return sprintf(page, "invoked=%lu, success=%lu\n", hctx->poll_invoked, hctx->poll_success);
+	return sprintf(page, "considered=%lu, invoked=%lu, success=%lu\n",
+		       hctx->poll_considered, hctx->poll_invoked,
+		       hctx->poll_success);
 }
 
 static ssize_t blk_mq_hw_sysfs_queued_show(struct blk_mq_hw_ctx *hctx,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e1544f0..7710f79 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -61,6 +61,7 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_cpu_notifier	cpu_notifier;
 	struct kobject		kobj;
 
+	unsigned long		poll_considered;
 	unsigned long		poll_invoked;
 	unsigned long		poll_success;
 };
-- 
2.1.4
