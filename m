Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	kernel-team@fb.com,
	osandov@fb.com,
	linux-block@vger.kernel.org,
	hch@lst.de,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] blk-mq: make blk_abort_request() trigger timeout path
Date: Tue, 12 Dec 2017 11:01:32 -0800
Message-Id: <20171212190134.535941-5-tj@kernel.org>
In-Reply-To: <20171212190134.535941-1-tj@kernel.org>
References: <20171212190134.535941-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

With issue/complete and timeout paths now using the generation number
and state based synchronization, blk_abort_request() is the only one
which depends on REQ_ATOM_COMPLETE for arbitrating completion.

There's no reason for blk_abort_request() to be a completely separate
path.  This patch makes blk_abort_request() piggyback on the timeout
path instead of trying to terminate the request directly.

This removes the last dependency on REQ_ATOM_COMPLETE in blk-mq.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-mq.c      | 2 +-
 block/blk-mq.h      | 2 --
 block/blk-timeout.c | 7 ++++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3a08d7a..73d6444 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -785,7 +785,7 @@ struct blk_mq_timeout_data {
 	unsigned int nr_expired;
 };
 
-void blk_mq_rq_timed_out(struct request *req, bool reserved)
+static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 154b2fa..1fa83fa 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -94,8 +94,6 @@ extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
-extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
-
 void blk_mq_release(struct request_queue *q);
 
 /**
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 6427be7..051924f 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -156,12 +156,13 @@ void blk_timeout_work(struct work_struct *work)
  */
 void blk_abort_request(struct request *req)
 {
-	if (blk_mark_rq_complete(req))
-		return;
 
 	if (req->q->mq_ops) {
-		blk_mq_rq_timed_out(req, false);
+		req->deadline = jiffies;
+		mod_timer(&req->q->timeout, 0);
 	} else {
+		if (blk_mark_rq_complete(req))
+			return;
 		blk_delete_timer(req);
 		blk_rq_timed_out(req);
 	}
-- 
2.9.5
