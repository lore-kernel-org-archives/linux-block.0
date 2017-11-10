Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/12 v5] mmc: block: issue requests in massive parallel
Date: Fri, 10 Nov 2017 11:01:42 +0100
Message-Id: <20171110100143.12256-12-linus.walleij@linaro.org>
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
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
mmc_blk_rw_done() and completing quickly, and an errorpath
calling down to mmc_blk_rw_done_error().

This has a profound effect: we reintroduce the parallelism on
the successful path as mmc_post_req() can now be called in
while the next request is in transit (just like prior to
commit "mmc: core: move the asynchronous post-processing")
and blk_end_request() is called while the next request is
already on the hardware.

The latter has the profound effect of issuing a new request
again so that we actually may have three requests
in transit at the same time: one on the hardware, one being
prepared (such as DMA flushing) and one being prepared for
issuing next by the block layer. This shows up when we
transit to multiqueue, where this can be exploited.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- Fixes on the errorpath: when a request reports error back,
  keep the areq on the host as it is not yet finished
  (no assigning NULL to host->areq), do not postprocess
  the request or complete it. This will happen eventually
  when the request succeeds.
- When restarting the command, use mmc_restart_areq() as
  could be expected.
- Augmend the .report_done_status() callback to return a
  bool indicating whether the areq is now finished or not,
  to handle the error case where we eventually give up on
  the request and have returned an error to the block
  layer.
- Make sure to post-process the request on the error path
  and pre-process it again when resending an asynchronous
  request. This satisfies the host's semantic expectation
  that every request will be in pre->req->post sequence
  even if there are errors.
- To assure the ordering of pre/post-processing, we need
  to post-process any prepared request with -EINVAL if
  there is an error, then re-preprocess it again after
  error recovery. To this end a helper pointer in
  host->pending_areq is added so the error path can
  act on this.
- Rebasing on the "next" branch in the MMC tree.
---
 drivers/mmc/core/block.c | 98 ++++++++++++++++++++++++++++++++----------------
 drivers/mmc/core/core.c  | 58 +++++++++++++++++++++++-----
 include/linux/mmc/host.h |  4 +-
 3 files changed, 117 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2cd9fe5a8c9b..e3ae7241b2eb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1827,7 +1827,8 @@ static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
 	mmc_restart_areq(mq->card->host, areq);
 }
 
-static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status)
+static bool mmc_blk_rw_done_error(struct mmc_async_req *areq,
+				  enum mmc_blk_status status)
 {
 	struct mmc_queue *mq;
 	struct mmc_blk_data *md;
@@ -1835,7 +1836,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 	struct mmc_host *host;
 	struct mmc_queue_req *mq_rq;
 	struct mmc_blk_request *brq;
-	struct request *old_req;
+	struct request *req;
 	bool req_pending = true;
 	int type, retune_retry_done = 0;
 
@@ -1849,42 +1850,27 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 	card = mq->card;
 	host = card->host;
 	brq = &mq_rq->brq;
-	old_req = mmc_queue_req_to_req(mq_rq);
-	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+	req = mmc_queue_req_to_req(mq_rq);
+	type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 
 	switch (status) {
-	case MMC_BLK_SUCCESS:
 	case MMC_BLK_PARTIAL:
-		/*
-		 * A block was successfully transferred.
-		 */
+		/* This should trigger a retransmit */
 		mmc_blk_reset_success(md, type);
-		req_pending = blk_end_request(old_req, BLK_STS_OK,
+		req_pending = blk_end_request(req, BLK_STS_OK,
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
-			mmc_blk_rw_cmd_abort(mq_rq);
-			return;
-		}
 		break;
 	case MMC_BLK_CMD_ERR:
-		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
+		req_pending = mmc_blk_rw_cmd_err(md, card, brq, req, req_pending);
 		if (mmc_blk_reset(md, card->host, type)) {
 			if (req_pending)
 				mmc_blk_rw_cmd_abort(mq_rq);
 			mmc_blk_rw_try_restart(mq_rq);
-			return;
+			return false;
 		}
 		if (!req_pending) {
 			mmc_blk_rw_try_restart(mq_rq);
-			return;
+			return false;
 		}
 		break;
 	case MMC_BLK_RETRY:
@@ -1897,7 +1883,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 			break;
 		mmc_blk_rw_cmd_abort(mq_rq);
 		mmc_blk_rw_try_restart(mq_rq);
-		return;
+		return false;
 	case MMC_BLK_DATA_ERR: {
 		int err;
 			err = mmc_blk_reset(md, card->host, type);
@@ -1906,7 +1892,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		if (err == -ENODEV) {
 			mmc_blk_rw_cmd_abort(mq_rq);
 			mmc_blk_rw_try_restart(mq_rq);
-			return;
+			return false;
 		}
 		/* Fall through */
 	}
@@ -1914,7 +1900,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		if (brq->data.blocks > 1) {
 			/* Redo read one sector at a time */
 			pr_warn("%s: retrying using single block read\n",
-				old_req->rq_disk->disk_name);
+				req->rq_disk->disk_name);
 			areq->disable_multi = true;
 			break;
 		}
@@ -1923,23 +1909,23 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		 * time, so we only reach here after trying to
 		 * read a single sector.
 		 */
-		req_pending = blk_end_request(old_req, BLK_STS_IOERR,
+		req_pending = blk_end_request(req, BLK_STS_IOERR,
 					      brq->data.blksz);
 		if (!req_pending) {
 			mmc_blk_rw_try_restart(mq_rq);
-			return;
+			return false;
 		}
 		break;
 	case MMC_BLK_NOMEDIUM:
 		mmc_blk_rw_cmd_abort(mq_rq);
 		mmc_blk_rw_try_restart(mq_rq);
-		return;
+		return false;
 	default:
 		pr_err("%s: Unhandled return value (%d)",
-				old_req->rq_disk->disk_name, status);
+		       req->rq_disk->disk_name, status);
 		mmc_blk_rw_cmd_abort(mq_rq);
 		mmc_blk_rw_try_restart(mq_rq);
-		return;
+		return false;
 	}
 
 	if (req_pending) {
@@ -1948,9 +1934,55 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		 * prepare it again and resend.
 		 */
 		mmc_blk_rw_rq_prep(mq_rq, areq->disable_multi);
-		mmc_start_areq(card->host, areq);
 		mq_rq->brq.retune_retry_done = retune_retry_done;
+		mmc_restart_areq(card->host, areq);
+		return false;
+	}
+
+	return true;
+}
+
+static bool mmc_blk_rw_done(struct mmc_async_req *areq,
+			    enum mmc_blk_status status)
+{
+	struct mmc_queue_req *mq_rq;
+	struct request *req;
+	struct mmc_blk_request *brq;
+	struct mmc_queue *mq;
+	struct mmc_blk_data *md;
+	bool req_pending;
+	int type;
+
+	/*
+	 * Anything other than success or partial transfers are errors.
+	 */
+	if (status != MMC_BLK_SUCCESS) {
+		return mmc_blk_rw_done_error(areq, status);
+	}
+
+	/* The quick path if the request was successful */
+	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
+	brq = &mq_rq->brq;
+	mq = mq_rq->mq;
+	md = mq->blkdata;
+	req = mmc_queue_req_to_req(mq_rq);
+	type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	mmc_blk_reset_success(md, type);
+	req_pending = blk_end_request(req, BLK_STS_OK,
+				      brq->data.bytes_xfered);
+	/*
+	 * If the blk_end_request function returns non-zero even
+	 * though all data has been transferred and no errors
+	 * were returned by the host controller, it's a bug.
+	 */
+	if (req_pending) {
+		pr_err("%s BUG rq_tot %d d_xfer %d\n",
+		       __func__, blk_rq_bytes(req),
+		       brq->data.bytes_xfered);
+		mmc_blk_rw_cmd_abort(mq_rq);
 	}
+	return true;
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 42795fdfb730..95e8e9206f04 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -735,15 +735,52 @@ void mmc_finalize_areq(struct work_struct *work)
 		mmc_start_bkops(host->card, true);
 	}
 
-	/* Successfully postprocess the old request at this point */
-	mmc_post_req(host, areq->mrq, 0);
-
-	/* Call back with status, this will trigger retry etc if needed */
-	if (areq->report_done_status)
-		areq->report_done_status(areq, status);
-
-	/* This opens the gate for the next request to start on the host */
-	complete(&areq->complete);
+	/*
+	 * Here we postprocess the request differently depending on if
+	 * we go on the success path or error path. The success path will
+	 * immediately let new requests hit the host, whereas the error
+	 * path will hold off new requests until we have retried and
+	 * succeeded or failed the current asynchronous request.
+	 */
+	if (status == MMC_BLK_SUCCESS) {
+		/*
+		 * This immediately opens the gate for the next request
+		 * to start on the host while we perform post-processing
+		 * and report back to the block layer.
+		 */
+		host->areq = NULL;
+		complete(&areq->complete);
+		mmc_post_req(host, areq->mrq, 0);
+		if (areq->report_done_status)
+			areq->report_done_status(areq, MMC_BLK_SUCCESS);
+	} else {
+		/*
+		 * Post-process this request. Then, if
+		 * another request was already prepared, back that out
+		 * so we can handle the errors without anything prepared
+		 * on the host.
+		 */
+		if (host->areq_pending)
+			mmc_post_req(host, host->areq_pending->mrq, -EINVAL);
+		/*
+		 * Call back with error status, this will trigger retry
+		 * etc if needed
+		 */
+		if (areq->report_done_status) {
+			if (areq->report_done_status(areq, status)) {
+				/*
+				 * This happens when we finally give up after
+				 * a few retries or on unrecoverable errors.
+				 */
+				mmc_post_req(host, areq->mrq, 0);
+				host->areq = NULL;
+				/* Re-prepare the next request */
+				if (host->areq_pending)
+					mmc_pre_req(host, host->areq_pending->mrq);
+				complete(&areq->complete);
+			}
+		}
+	}
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
@@ -765,6 +802,7 @@ int mmc_restart_areq(struct mmc_host *host,
 		     struct mmc_async_req *areq)
 {
 	areq->mrq->areq = areq;
+	mmc_pre_req(host, areq->mrq);
 	return __mmc_start_data_req(host, areq->mrq);
 }
 EXPORT_SYMBOL(mmc_restart_areq);
@@ -797,6 +835,7 @@ int mmc_start_areq(struct mmc_host *host,
 
 	/* Prepare a new request */
 	mmc_pre_req(host, areq->mrq);
+	host->areq_pending = areq;
 
 	/* Finalize previous request, if there is one */
 	if (previous) {
@@ -805,6 +844,7 @@ int mmc_start_areq(struct mmc_host *host,
 	}
 
 	/* Fine so far, start the new request! */
+	host->areq_pending = NULL;
 	init_completion(&areq->complete);
 	areq->mrq->areq = areq;
 	ret = __mmc_start_data_req(host, areq->mrq);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f1c362e0765c..985bc479c8a8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -220,8 +220,9 @@ struct mmc_async_req {
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
 	/*
 	 * Report finalization status from the core to e.g. the block layer.
+	 * Returns true if the request is now finished.
 	 */
-	void (*report_done_status)(struct mmc_async_req *, enum mmc_blk_status);
+	bool (*report_done_status)(struct mmc_async_req *, enum mmc_blk_status);
 	struct work_struct finalization_work;
 	struct completion complete;
 	struct mmc_host *host;
@@ -420,6 +421,7 @@ struct mmc_host {
 	struct dentry		*debugfs_root;
 
 	struct mmc_async_req	*areq;		/* active async req */
+	struct mmc_async_req	*areq_pending;	/* prepared but not issued async req */
 
 	/* finalization workqueue, handles finalizing requests */
 	struct workqueue_struct	*req_done_wq;
-- 
2.13.6
