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
Subject: [PATCH 11/12 v4] mmc: block: issue requests in massive parallel
Date: Thu, 26 Oct 2017 14:57:56 +0200
Message-Id: <20171026125757.10200-12-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
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
 drivers/mmc/core/block.c | 79 +++++++++++++++++++++++++++++++++---------------
 drivers/mmc/core/core.c  | 38 +++++++++++++++++------
 2 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 184907f5fb97..f06f381146a5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1824,7 +1824,8 @@ static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
 	mmc_restart_areq(mq->card->host, &mq_rq->areq);
 }
 
-static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status)
+static void mmc_blk_rw_done_error(struct mmc_async_req *areq,
+				  enum mmc_blk_status status)
 {
 	struct mmc_queue *mq;
 	struct mmc_blk_data *md;
@@ -1832,7 +1833,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 	struct mmc_host *host;
 	struct mmc_queue_req *mq_rq;
 	struct mmc_blk_request *brq;
-	struct request *old_req;
+	struct request *req;
 	bool req_pending = true;
 	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 
@@ -1846,33 +1847,18 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
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
@@ -1911,7 +1897,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		if (brq->data.blocks > 1) {
 			/* Redo read one sector at a time */
 			pr_warn("%s: retrying using single block read\n",
-				old_req->rq_disk->disk_name);
+				req->rq_disk->disk_name);
 			disable_multi = 1;
 			break;
 		}
@@ -1920,7 +1906,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		 * time, so we only reach here after trying to
 		 * read a single sector.
 		 */
-		req_pending = blk_end_request(old_req, BLK_STS_IOERR,
+		req_pending = blk_end_request(req, BLK_STS_IOERR,
 					      brq->data.blksz);
 		if (!req_pending) {
 			mmc_blk_rw_try_restart(mq_rq);
@@ -1933,7 +1919,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		return;
 	default:
 		pr_err("%s: Unhandled return value (%d)",
-				old_req->rq_disk->disk_name, status);
+		       req->rq_disk->disk_name, status);
 		mmc_blk_rw_cmd_abort(mq_rq);
 		mmc_blk_rw_try_restart(mq_rq);
 		return;
@@ -1950,6 +1936,49 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 	}
 }
 
+static void mmc_blk_rw_done(struct mmc_async_req *areq,
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
+		mmc_blk_rw_done_error(areq, status);
+		return;
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
+	}
+}
+
 static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
 {
 	struct request *req = mmc_queue_req_to_req(mq_rq);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 209ebb8a7f3f..0f57e9fe66b6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -735,15 +735,35 @@ void mmc_finalize_areq(struct work_struct *work)
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
+		mmc_post_req(host, areq->mrq, 0);
+		/*
+		 * Call back with error status, this will trigger retry
+		 * etc if needed
+		 */
+		if (areq->report_done_status)
+			areq->report_done_status(areq, status);
+		host->areq = NULL;
+		complete(&areq->complete);
+	}
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
-- 
2.13.6
