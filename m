Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESENT] blk-mq-debugfs: invoke queue_for_each_hw_ctx under sysfs_lock
Date: Mon, 25 Jun 2018 14:23:35 +0800
Message-Id: <1529907815-2170-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

blk_mq_run_hw_queues and blk_mq_start_stopped_hw_queues in
queue_state_write will invoke queue_for_each_hw_ctx. It will race
with blk_mq_realloc_hw_ctxs and incur NULL pointer reference. Put
them under sysfs_lock to serialize the accessing to queue_hw_ctx
and nr_hw_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ffa6223..2e0c444 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -151,6 +151,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 {
 	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
+	int res;
 
 	/*
 	 * The "state" attribute is removed after blk_cleanup_queue() has called
@@ -169,9 +170,17 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		return -EFAULT;
 	op = strstrip(opbuf);
 	if (strcmp(op, "run") == 0) {
+		res = mutex_lock_interruptible(&q->sysfs_lock);
+		if (res)
+			goto out;
 		blk_mq_run_hw_queues(q, true);
+		mutex_unlock(&q->sysfs_lock);
 	} else if (strcmp(op, "start") == 0) {
+		res = mutex_lock_interruptible(&q->sysfs_lock);
+		if (res)
+			goto out;
 		blk_mq_start_stopped_hw_queues(q, true);
+		mutex_unlock(&q->sysfs_lock);
 	} else if (strcmp(op, "kick") == 0) {
 		blk_mq_kick_requeue_list(q);
 	} else {
@@ -180,6 +189,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		pr_err("%s: use 'run', 'start' or 'kick'\n", __func__);
 		return -EINVAL;
 	}
+out:
 	return count;
 }
 
-- 
2.7.4
