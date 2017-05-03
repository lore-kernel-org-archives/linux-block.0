Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33761 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756429AbdECTTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id q20so17110979pfg.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:18 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 8/9] kyber: add debugfs attributes
Date: Wed,  3 May 2017 12:19:01 -0700
Message-Id: <1a5a3fe25ce7cc918061257558498d265ba5dbe4.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Expose the domain token pools, asynchronous sbitmap depth, domain
request lists, and batching state.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c |   2 +-
 block/blk-mq-debugfs.h |   2 +
 block/kyber-iosched.c  | 130 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 53a37c467685..6c12b4dbc8ec 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -262,7 +262,7 @@ static const char *const rqf_name[] = {
 };
 #undef RQF_NAME
 
-static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
+int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 29ecb43aa412..7c67f813a294 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -11,6 +11,8 @@ struct blk_mq_debugfs_attr {
 	const struct seq_operations *seq_ops;
 };
 
+int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
+
 int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
 int blk_mq_debugfs_register_hctx(struct request_queue *q,
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 3b0090bc5dd1..b9faabc75fdb 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -26,6 +26,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
@@ -683,6 +684,131 @@ static struct elv_fs_entry kyber_sched_attrs[] = {
 };
 #undef KYBER_LAT_ATTR
 
+#ifdef CONFIG_BLK_DEBUG_FS
+#define KYBER_DEBUGFS_DOMAIN_ATTRS(domain, name)			\
+static int kyber_##name##_tokens_show(void *data, struct seq_file *m)	\
+{									\
+	struct request_queue *q = data;					\
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;	\
+									\
+	sbitmap_queue_show(&kqd->domain_tokens[domain], m);		\
+	return 0;							\
+}									\
+									\
+static void *kyber_##name##_rqs_start(struct seq_file *m, loff_t *pos)	\
+	__acquires(&khd->lock)						\
+{									\
+	struct blk_mq_hw_ctx *hctx = m->private;			\
+	struct kyber_hctx_data *khd = hctx->sched_data;			\
+									\
+	spin_lock(&khd->lock);						\
+	return seq_list_start(&khd->rqs[domain], *pos);			\
+}									\
+									\
+static void *kyber_##name##_rqs_next(struct seq_file *m, void *v,	\
+				     loff_t *pos)			\
+{									\
+	struct blk_mq_hw_ctx *hctx = m->private;			\
+	struct kyber_hctx_data *khd = hctx->sched_data;			\
+									\
+	return seq_list_next(v, &khd->rqs[domain], pos);		\
+}									\
+									\
+static void kyber_##name##_rqs_stop(struct seq_file *m, void *v)	\
+	__releases(&khd->lock)						\
+{									\
+	struct blk_mq_hw_ctx *hctx = m->private;			\
+	struct kyber_hctx_data *khd = hctx->sched_data;			\
+									\
+	spin_unlock(&khd->lock);					\
+}									\
+									\
+static const struct seq_operations kyber_##name##_rqs_seq_ops = {	\
+	.start	= kyber_##name##_rqs_start,				\
+	.next	= kyber_##name##_rqs_next,				\
+	.stop	= kyber_##name##_rqs_stop,				\
+	.show	= blk_mq_debugfs_rq_show,				\
+};									\
+									\
+static int kyber_##name##_waiting_show(void *data, struct seq_file *m)	\
+{									\
+	struct blk_mq_hw_ctx *hctx = data;				\
+	struct kyber_hctx_data *khd = hctx->sched_data;			\
+	wait_queue_t *wait = &khd->domain_wait[domain];			\
+									\
+	seq_printf(m, "%d\n", !list_empty_careful(&wait->task_list));	\
+	return 0;							\
+}
+KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_READ, read)
+KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_SYNC_WRITE, sync_write)
+KYBER_DEBUGFS_DOMAIN_ATTRS(KYBER_OTHER, other)
+#undef KYBER_DEBUGFS_DOMAIN_ATTRS
+
+static int kyber_async_depth_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct kyber_queue_data *kqd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u\n", kqd->async_depth);
+	return 0;
+}
+
+static int kyber_cur_domain_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	struct kyber_hctx_data *khd = hctx->sched_data;
+
+	switch (khd->cur_domain) {
+	case KYBER_READ:
+		seq_puts(m, "READ\n");
+		break;
+	case KYBER_SYNC_WRITE:
+		seq_puts(m, "SYNC_WRITE\n");
+		break;
+	case KYBER_OTHER:
+		seq_puts(m, "OTHER\n");
+		break;
+	default:
+		seq_printf(m, "%u\n", khd->cur_domain);
+		break;
+	}
+	return 0;
+}
+
+static int kyber_batching_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+	struct kyber_hctx_data *khd = hctx->sched_data;
+
+	seq_printf(m, "%u\n", khd->batching);
+	return 0;
+}
+
+#define KYBER_QUEUE_DOMAIN_ATTRS(name)	\
+	{#name "_tokens", 0400, kyber_##name##_tokens_show}
+static const struct blk_mq_debugfs_attr kyber_queue_debugfs_attrs[] = {
+	KYBER_QUEUE_DOMAIN_ATTRS(read),
+	KYBER_QUEUE_DOMAIN_ATTRS(sync_write),
+	KYBER_QUEUE_DOMAIN_ATTRS(other),
+	{"async_depth", 0400, kyber_async_depth_show},
+	{},
+};
+#undef KYBER_QUEUE_DOMAIN_ATTRS
+
+#define KYBER_HCTX_DOMAIN_ATTRS(name)					\
+	{#name "_rqs", 0400, .seq_ops = &kyber_##name##_rqs_seq_ops},	\
+	{#name "_waiting", 0400, kyber_##name##_waiting_show}
+static const struct blk_mq_debugfs_attr kyber_hctx_debugfs_attrs[] = {
+	KYBER_HCTX_DOMAIN_ATTRS(read),
+	KYBER_HCTX_DOMAIN_ATTRS(sync_write),
+	KYBER_HCTX_DOMAIN_ATTRS(other),
+	{"cur_domain", 0400, kyber_cur_domain_show},
+	{"batching", 0400, kyber_batching_show},
+	{},
+};
+#undef KYBER_HCTX_DOMAIN_ATTRS
+#endif
+
 static struct elevator_type kyber_sched = {
 	.ops.mq = {
 		.init_sched = kyber_init_sched,
@@ -696,6 +822,10 @@ static struct elevator_type kyber_sched = {
 		.has_work = kyber_has_work,
 	},
 	.uses_mq = true,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
+	.hctx_debugfs_attrs = kyber_hctx_debugfs_attrs,
+#endif
 	.elevator_attrs = kyber_sched_attrs,
 	.elevator_name = "kyber",
 	.elevator_owner = THIS_MODULE,
-- 
2.12.2
