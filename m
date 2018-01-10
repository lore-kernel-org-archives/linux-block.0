Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	bart.vanassche@wdc.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing rq->__deadline bit
Date: Tue,  9 Jan 2018 17:29:26 -0700
Message-Id: <1515544167-10751-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
References: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We only have one atomic flag left. Instead of using an entire
unsigned long for that, steal the bottom bit of the deadline
field that we already reserved.

Remove ->atomic_flags, since it's now unused.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  2 +-
 block/blk-mq-debugfs.c |  8 --------
 block/blk-mq.c         |  2 +-
 block/blk.h            | 19 +++++++++----------
 include/linux/blkdev.h |  2 --
 5 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f843ae4f858d..7ba607527487 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2853,7 +2853,7 @@ void blk_start_request(struct request *req)
 		wbt_issue(req->q->rq_wb, &req->issue_stat);
 	}
 
-	BUG_ON(test_bit(REQ_ATOM_COMPLETE, &req->atomic_flags));
+	BUG_ON(blk_rq_is_complete(req));
 	blk_add_timer(req);
 }
 EXPORT_SYMBOL(blk_start_request);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a9c9f8b6162..ac99b78415ec 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -291,12 +291,6 @@ static const char *const rqf_name[] = {
 };
 #undef RQF_NAME
 
-#define RQAF_NAME(name) [REQ_ATOM_##name] = #name
-static const char *const rqaf_name[] = {
-	RQAF_NAME(COMPLETE),
-};
-#undef RQAF_NAME
-
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
@@ -313,8 +307,6 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
-	seq_puts(m, ", .atomic_flags=");
-	blk_flags_show(m, rq->atomic_flags, rqaf_name, ARRAY_SIZE(rqaf_name));
 	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
 		   rq->internal_tag);
 	if (mq_ops->show_rq)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d875c51bcff8..7248ee043651 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -294,7 +294,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->rq_flags |= RQF_PREEMPT;
 	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
-	/* do not touch atomic flags, it needs atomic ops against the timer */
 	rq->cpu = -1;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
@@ -313,6 +312,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
+	rq->__deadline = 0;
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
diff --git a/block/blk.h b/block/blk.h
index bcd9cf7db0d4..c84ae0e21ebd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -120,24 +120,23 @@ void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req);
 
 /*
- * Internal atomic flags for request handling
- */
-enum rq_atomic_flags {
-	REQ_ATOM_COMPLETE = 0,
-};
-
-/*
  * EH timer and IO completion will both attempt to 'grab' the request, make
- * sure that only one of them succeeds
+ * sure that only one of them succeeds. Steal the bottom bit of the
+ * __deadline field for this.
  */
 static inline int blk_mark_rq_complete(struct request *rq)
 {
-	return test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
+	return test_and_set_bit(0, &rq->__deadline);
 }
 
 static inline void blk_clear_rq_complete(struct request *rq)
 {
-	clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
+	clear_bit(0, &rq->__deadline);
+}
+
+static inline bool blk_rq_is_complete(struct request *rq)
+{
+	return test_bit(0, &rq->__deadline);
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aa6698cf483c..d4b2f7bb18d6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -156,8 +156,6 @@ struct request {
 
 	int internal_tag;
 
-	unsigned long atomic_flags;
-
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
 	int tag;
-- 
2.7.4
