Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35789 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbdECTTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:19 -0400
Received: by mail-pg0-f42.google.com with SMTP id o3so77872969pgn.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:19 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 9/9] mq-deadline: add debugfs attributes
Date: Wed,  3 May 2017 12:19:02 -0700
Message-Id: <306d6a725cd8a55578b53d15d05128979cf3a037.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Expose the fifo lists, cached next requests, batching state, and
dispatch list. It'd also be possible to add the sorted lists, but there
aren't already seq_file helpers for rbtrees.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c |   8 +++-
 block/blk-mq-debugfs.h |   1 +
 block/mq-deadline.c    | 123 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6c12b4dbc8ec..3a33f7e2f68c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -262,9 +262,8 @@ static const char *const rqf_name[] = {
 };
 #undef RQF_NAME
 
-int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
+int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
-	struct request *rq = list_entry_rq(v);
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
 	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
 
@@ -287,6 +286,11 @@ int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
+{
+	return __blk_mq_debugfs_rq_show(m, list_entry_rq(v));
+}
+
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
 	__acquires(&hctx->lock)
 {
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 7c67f813a294..b72e5c5f065e 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -11,6 +11,7 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
 int blk_mq_debugfs_register(struct request_queue *q);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 236121633ca0..1b964a387afe 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -19,6 +19,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 
@@ -517,6 +518,125 @@ static struct elv_fs_entry deadline_attrs[] = {
 	__ATTR_NULL
 };
 
+#ifdef CONFIG_BLK_DEBUG_FS
+#define DEADLINE_DEBUGFS_DDIR_ATTRS(ddir, name)				\
+static void *deadline_##name##_fifo_start(struct seq_file *m,		\
+					  loff_t *pos)			\
+	__acquires(&dd->lock)						\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	spin_lock(&dd->lock);						\
+	return seq_list_start(&dd->fifo_list[ddir], *pos);		\
+}									\
+									\
+static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
+					 loff_t *pos)			\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	return seq_list_next(v, &dd->fifo_list[ddir], pos);		\
+}									\
+									\
+static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
+	__releases(&dd->lock)						\
+{									\
+	struct request_queue *q = m->private;				\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+									\
+	spin_unlock(&dd->lock);						\
+}									\
+									\
+static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
+	.start	= deadline_##name##_fifo_start,				\
+	.next	= deadline_##name##_fifo_next,				\
+	.stop	= deadline_##name##_fifo_stop,				\
+	.show	= blk_mq_debugfs_rq_show,				\
+};									\
+									\
+static int deadline_##name##_next_rq_show(void *data,			\
+					  struct seq_file *m)		\
+{									\
+	struct request_queue *q = data;					\
+	struct deadline_data *dd = q->elevator->elevator_data;		\
+	struct request *rq = dd->next_rq[ddir];				\
+									\
+	if (rq)								\
+		__blk_mq_debugfs_rq_show(m, rq);			\
+	return 0;							\
+}
+DEADLINE_DEBUGFS_DDIR_ATTRS(READ, read)
+DEADLINE_DEBUGFS_DDIR_ATTRS(WRITE, write)
+#undef DEADLINE_DEBUGFS_DDIR_ATTRS
+
+static int deadline_batching_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u\n", dd->batching);
+	return 0;
+}
+
+static int deadline_starved_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u\n", dd->starved);
+	return 0;
+}
+
+static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
+	__acquires(&dd->lock)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	spin_lock(&dd->lock);
+	return seq_list_start(&dd->dispatch, *pos);
+}
+
+static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	return seq_list_next(v, &dd->dispatch, pos);
+}
+
+static void deadline_dispatch_stop(struct seq_file *m, void *v)
+	__releases(&dd->lock)
+{
+	struct request_queue *q = m->private;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	spin_unlock(&dd->lock);
+}
+
+static const struct seq_operations deadline_dispatch_seq_ops = {
+	.start	= deadline_dispatch_start,
+	.next	= deadline_dispatch_next,
+	.stop	= deadline_dispatch_stop,
+	.show	= blk_mq_debugfs_rq_show,
+};
+
+#define DEADLINE_QUEUE_DDIR_ATTRS(name)						\
+	{#name "_fifo_list", 0400, .seq_ops = &deadline_##name##_fifo_seq_ops},	\
+	{#name "_next_rq", 0400, deadline_##name##_next_rq_show}
+static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
+	DEADLINE_QUEUE_DDIR_ATTRS(read),
+	DEADLINE_QUEUE_DDIR_ATTRS(write),
+	{"batching", 0400, deadline_batching_show},
+	{"starved", 0400, deadline_starved_show},
+	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
+	{},
+};
+#undef DEADLINE_QUEUE_DDIR_ATTRS
+#endif
+
 static struct elevator_type mq_deadline = {
 	.ops.mq = {
 		.insert_requests	= dd_insert_requests,
@@ -533,6 +653,9 @@ static struct elevator_type mq_deadline = {
 	},
 
 	.uses_mq	= true,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.queue_debugfs_attrs = deadline_queue_debugfs_attrs,
+#endif
 	.elevator_attrs = deadline_attrs,
 	.elevator_name = "mq-deadline",
 	.elevator_owner = THIS_MODULE,
-- 
2.12.2
