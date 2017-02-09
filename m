Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/16] mmc: queue: issue requests in massive parallel
Date: Thu,  9 Feb 2017 16:34:02 +0100
Message-Id: <20170209153403.9730-16-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This makes a crucial change to the issueing mechanism for the
MMC requests:

Before commit "mmc: core: move the asynchronous post-processing"
some parallelism on the read/write requests was achieved by
speculatively postprocessing a request and re-preprocess and
re-issue the request if something went wrong, which we discover
later when checking for an error.

This is kind of ugly. Instead we need a mechanism like here:

We issue requests, and when they come back from the hardware,
we know if they finished successfully or not. If the request
was successful, we complete the asynchronous request and let a
new request immediately start on the hardware. If, and only if,
it returned an error from the hardware we go down the error
path.

This is achieved by splitting the work path from the hardware
in two: a successful path ending up calling down to
mmc_blk_rw_done_success() and an errorpath calling down to
mmc_blk_rw_done_error().

This has a profound effect: we reintroduce the parallelism on
the successful path as mmc_post_req() can now be called in
while the next request is in transit (just like prior to
commit "mmc: core: move the asynchronous post-processing")
but ALSO we can call mmc_queue_bounce_post() and
blk_end_request() in parallel.

The latter has the profound effect of issuing a new request
again so that we actually need to have at least three requests
in transit at the same time: we haven't yet dropped the
reference to our struct mmc_queue_req so we need at least
three. I put the pool to 4 requests for now.

I expect the imrovement to be noticeable on systems that use
bounce buffers since they can now process requests in parallel
with post-processing their bounce buffers, but I don't have a
test target for that.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 61 +++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/core/block.h |  4 +++-
 drivers/mmc/core/core.c  | 27 ++++++++++++++++++---
 drivers/mmc/core/queue.c |  2 +-
 4 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index acca15cc1807..f1008ce5376b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1622,8 +1622,51 @@ static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
 	mmc_restart_areq(mq->card->host, &mq_rq->areq);
 }
 
-void mmc_blk_rw_done(struct mmc_async_req *areq,
-		     enum mmc_blk_status status)
+/**
+ * Final handling of an asynchronous request if there was no error.
+ * This is the common path that we take when everything is nice
+ * and smooth. The status from the command is always MMC_BLK_SUCCESS.
+ */
+void mmc_blk_rw_done_success(struct mmc_async_req *areq)
+{
+	struct mmc_queue_req *mq_rq;
+	struct mmc_blk_request *brq;
+	struct mmc_blk_data *md;
+	struct request *old_req;
+	bool req_pending;
+	int type;
+
+	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
+	md = mq_rq->mq->blkdata;
+	brq = &mq_rq->brq;
+	old_req = mq_rq->req;
+	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	mmc_queue_bounce_post(mq_rq);
+	mmc_blk_reset_success(md, type);
+	req_pending = blk_end_request(old_req, 0,
+				      brq->data.bytes_xfered);
+	/*
+	 * If the blk_end_request function returns non-zero even
+	 * though all data has been transferred and no errors
+	 * were returned by the host controller, it's a bug.
+	 */
+	if (req_pending) {
+		pr_err("%s BUG rq_tot %d d_xfer %d\n",
+		       __func__, blk_rq_bytes(old_req),
+		       brq->data.bytes_xfered);
+		return;
+	}
+}
+
+/**
+ * Error, recapture, retry etc for asynchronous requests.
+ * This is the error path that we take when there is bad status
+ * coming back from the hardware and we need to do a bit of
+ * cleverness.
+ */
+void mmc_blk_rw_done_error(struct mmc_async_req *areq,
+			   enum mmc_blk_status status)
 {
 	struct mmc_queue *mq;
 	struct mmc_queue_req *mq_rq;
@@ -1652,6 +1695,8 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
 
 	switch (status) {
 	case MMC_BLK_SUCCESS:
+		pr_err("%s: MMC_BLK_SUCCESS on error path\n", __func__);
+		/* This should not happen: anyway fall through */
 	case MMC_BLK_PARTIAL:
 		/*
 		 * A block was successfully transferred.
@@ -1660,18 +1705,6 @@ void mmc_blk_rw_done(struct mmc_async_req *areq,
 
 		req_pending = blk_end_request(old_req, 0,
 					      brq->data.bytes_xfered);
-		/*
-		 * If the blk_end_request function returns non-zero even
-		 * though all data has been transferred and no errors
-		 * were returned by the host controller, it's a bug.
-		 */
-		if (status == MMC_BLK_SUCCESS && req_pending) {
-			pr_err("%s BUG rq_tot %d d_xfer %d\n",
-			       __func__, blk_rq_bytes(old_req),
-			       brq->data.bytes_xfered);
-			mmc_blk_rw_cmd_abort(card, old_req);
-			return;
-		}
 		break;
 	case MMC_BLK_CMD_ERR:
 		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 0326fa5d8217..eae47ae7c903 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -5,7 +5,9 @@ struct mmc_async_req;
 enum mmc_blk_status;
 struct mmc_queue_req;
 
-void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status);
+void mmc_blk_rw_done_success(struct mmc_async_req *areq);
+void mmc_blk_rw_done_error(struct mmc_async_req *areq,
+			   enum mmc_blk_status status);
 void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq);
 
 #endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 50a8942b98c2..04666ad91df0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -634,11 +634,32 @@ void mmc_finalize_areq(struct kthread_work *work)
 		mmc_start_bkops(host->card, true);
 	}
 
-	/* Successfully postprocess the old request at this point */
-	mmc_post_req(host, areq->mrq, 0);
-	mmc_blk_rw_done(areq, status);
+	/*
+	 * Postprocess the old request at this point:
+	 * on success: take a fast path!
+	 * on error: take the slow path, retrying etc
+	 */
+	if (status != MMC_BLK_SUCCESS) {
+		mmc_post_req(host, areq->mrq, 0);
+		/*
+		 * This call can lead to retransmissions using
+		 * mmc_restart_areq() so do not complete until
+		 * after this call!
+		 */
+		mmc_blk_rw_done_error(areq, status);
+		complete(&areq->complete);
+		mmc_queue_req_put(mq_rq);
+		return;
+	}
 
+	/*
+	 * There will not be any retransmissions etc
+	 * at this point, so let the next request get
+	 * access to the hardware.
+	 */
 	complete(&areq->complete);
+	mmc_post_req(host, areq->mrq, 0);
+	mmc_blk_rw_done_success(areq);
 	mmc_queue_req_put(mq_rq);
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cab0f51dbb4d..e7ba5bef2df3 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -307,7 +307,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	mq->qdepth = 2;
+	mq->qdepth = 4;
 	spin_lock_init(&mq->mqrq_lock);
 	mq->mqrq = kcalloc(mq->qdepth, sizeof(struct mmc_queue_req),
 			   GFP_KERNEL);
-- 
2.9.3
