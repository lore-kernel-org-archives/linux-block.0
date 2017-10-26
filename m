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
Subject: [PATCH 08/12 v4] mmc: block: shuffle retry and error handling
Date: Thu, 26 Oct 2017 14:57:53 +0200
Message-Id: <20171026125757.10200-9-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Instead of doing retries at the same time as trying to submit new
requests, do the retries when the request is reported as completed
by the driver, in the finalization worker.

This is achieved by letting the core worker call back into the block
layer using a callback in the asynchronous request, ->report_done_status()
that will pass the status back to the block core so it can repeatedly
try to hammer the request using single request, retry etc by calling back
to the core layer using mmc_restart_areq(), which will just kick the
same asynchronous request without waiting for a previous ongoing request.

The beauty of it is that the completion will not complete until the
block layer has had the opportunity to hammer a bit at the card using
a bunch of different approaches that used to be in the while() loop in
mmc_blk_rw_done()

The algorithm for recapture, retry and handle errors is identical to the
one we used to have in mmc_blk_issue_rw_rq(), only augmented to get
called in another path from the core.

We have to add and initialize a pointer back to the struct mmc_queue
from the struct mmc_queue_req to find the queue from the asynchronous
request when reporting the status back to the core.

Other users of the asynchrous request that do not need to retry and
use misc error handling fallbacks will work fine since a NULL
->report_done_status() is just fine. This is currently only done by
the test module.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 337 ++++++++++++++++++++++++-----------------------
 drivers/mmc/core/core.c  |  47 ++++---
 drivers/mmc/core/core.h  |   1 +
 drivers/mmc/core/queue.c |   2 +
 drivers/mmc/core/queue.h |   1 +
 include/linux/mmc/host.h |   5 +-
 6 files changed, 210 insertions(+), 183 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 86ec87c17e71..c1178fa83f75 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1811,198 +1811,207 @@ static void mmc_blk_rw_cmd_abort(struct mmc_queue *mq, struct mmc_card *card,
 /**
  * mmc_blk_rw_try_restart() - tries to restart the current async request
  * @mq: the queue with the card and host to restart
- * @req: a new request that want to be started after the current one
+ * @mqrq: the mmc_queue_request containing the areq to be restarted
  */
-static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req,
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq,
 				   struct mmc_queue_req *mqrq)
 {
-	if (!req)
-		return;
+	/* Proceed and try to restart the current async request */
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+	mmc_restart_areq(mq->card->host, &mqrq->areq);
+}
+
+static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status)
+{
+	struct mmc_queue *mq;
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+	struct mmc_host *host;
+	struct mmc_queue_req *mq_rq;
+	struct mmc_blk_request *brq;
+	struct request *old_req;
+	bool req_pending = true;
+	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 
 	/*
-	 * If the card was removed, just cancel everything and return.
+	 * An asynchronous request has been completed and we proceed
+	 * to handle the result of it.
 	 */
-	if (mmc_card_removed(mq->card)) {
-		req->rq_flags |= RQF_QUIET;
-		blk_end_request_all(req, BLK_STS_IOERR);
-		mq->qcnt--; /* FIXME: just set to 0? */
+	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
+	mq = mq_rq->mq;
+	md = mq->blkdata;
+	card = mq->card;
+	host = card->host;
+	brq = &mq_rq->brq;
+	old_req = mmc_queue_req_to_req(mq_rq);
+	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	switch (status) {
+	case MMC_BLK_SUCCESS:
+	case MMC_BLK_PARTIAL:
+		/*
+		 * A block was successfully transferred.
+		 */
+		mmc_blk_reset_success(md, type);
+		req_pending = blk_end_request(old_req, BLK_STS_OK,
+					      brq->data.bytes_xfered);
+		/*
+		 * If the blk_end_request function returns non-zero even
+		 * though all data has been transferred and no errors
+		 * were returned by the host controller, it's a bug.
+		 */
+		if (status == MMC_BLK_SUCCESS && req_pending) {
+			pr_err("%s BUG rq_tot %d d_xfer %d\n",
+			       __func__, blk_rq_bytes(old_req),
+			       brq->data.bytes_xfered);
+			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+			return;
+		}
+		break;
+	case MMC_BLK_CMD_ERR:
+		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
+		if (mmc_blk_reset(md, card->host, type)) {
+			if (req_pending)
+				mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+			else
+				mq->qcnt--;
+			mmc_blk_rw_try_restart(mq, mq_rq);
+			return;
+		}
+		if (!req_pending) {
+			mq->qcnt--;
+			mmc_blk_rw_try_restart(mq, mq_rq);
+			return;
+		}
+		break;
+	case MMC_BLK_RETRY:
+		retune_retry_done = brq->retune_retry_done;
+		if (retry++ < 5)
+			break;
+		/* Fall through */
+	case MMC_BLK_ABORT:
+		if (!mmc_blk_reset(md, card->host, type))
+			break;
+		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+		mmc_blk_rw_try_restart(mq, mq_rq);
+		return;
+	case MMC_BLK_DATA_ERR: {
+		int err;
+			err = mmc_blk_reset(md, card->host, type);
+		if (!err)
+			break;
+		if (err == -ENODEV) {
+			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+			mmc_blk_rw_try_restart(mq, mq_rq);
+			return;
+		}
+		/* Fall through */
+	}
+	case MMC_BLK_ECC_ERR:
+		if (brq->data.blocks > 1) {
+			/* Redo read one sector at a time */
+			pr_warn("%s: retrying using single block read\n",
+				old_req->rq_disk->disk_name);
+			disable_multi = 1;
+			break;
+		}
+		/*
+		 * After an error, we redo I/O one sector at a
+		 * time, so we only reach here after trying to
+		 * read a single sector.
+		 */
+		req_pending = blk_end_request(old_req, BLK_STS_IOERR,
+					      brq->data.blksz);
+		if (!req_pending) {
+			mq->qcnt--;
+			mmc_blk_rw_try_restart(mq, mq_rq);
+			return;
+		}
+		break;
+	case MMC_BLK_NOMEDIUM:
+		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+		mmc_blk_rw_try_restart(mq, mq_rq);
+		return;
+	default:
+		pr_err("%s: Unhandled return value (%d)",
+				old_req->rq_disk->disk_name, status);
+		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+		mmc_blk_rw_try_restart(mq, mq_rq);
 		return;
 	}
-	/* Else proceed and try to restart the current async request */
-	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
-	mmc_start_areq(mq->card->host, &mqrq->areq, NULL);
+
+	if (req_pending) {
+		/*
+		 * In case of a incomplete request
+		 * prepare it again and resend.
+		 */
+		mmc_blk_rw_rq_prep(mq_rq, card,
+				disable_multi, mq);
+		mmc_start_areq(card->host, areq, NULL);
+		mq_rq->brq.retune_retry_done = retune_retry_done;
+	} else {
+		/* Else, this request is done */
+		mq->qcnt--;
+	}
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 {
-	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_card *card = md->queue.card;
-	struct mmc_blk_request *brq;
-	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	enum mmc_blk_status status;
-	struct mmc_queue_req *mqrq_cur = NULL;
-	struct mmc_queue_req *mq_rq;
-	struct request *old_req;
 	struct mmc_async_req *new_areq;
 	struct mmc_async_req *old_areq;
-	bool req_pending = true;
+	struct mmc_card *card = mq->card;
 
-	if (new_req) {
-		mqrq_cur = req_to_mmc_queue_req(new_req);
+	if (new_req)
 		mq->qcnt++;
-	}
 
 	if (!mq->qcnt)
 		return;
 
-	do {
-		if (new_req) {
-			/*
-			 * When 4KB native sector is enabled, only 8 blocks
-			 * multiple read or write is allowed
-			 */
-			if (mmc_large_sector(card) &&
-				!IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
-				pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-					new_req->rq_disk->disk_name);
-				mmc_blk_rw_cmd_abort(mq, card, new_req, mqrq_cur);
-				return;
-			}
-
-			mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
-			new_areq = &mqrq_cur->areq;
-		} else
-			new_areq = NULL;
-
-		old_areq = mmc_start_areq(card->host, new_areq, &status);
-		if (!old_areq) {
-			/*
-			 * We have just put the first request into the pipeline
-			 * and there is nothing more to do until it is
-			 * complete.
-			 */
-			return;
-		}
+	/*
+	 * If the card was removed, just cancel everything and return.
+	 */
+	if (mmc_card_removed(card)) {
+		new_req->rq_flags |= RQF_QUIET;
+		blk_end_request_all(new_req, BLK_STS_IOERR);
+		mq->qcnt--; /* FIXME: just set to 0? */
+		return;
+	}
 
+	if (new_req) {
+		struct mmc_queue_req *mqrq_cur = req_to_mmc_queue_req(new_req);
 		/*
-		 * An asynchronous request has been completed and we proceed
-		 * to handle the result of it.
+		 * When 4KB native sector is enabled, only 8 blocks
+		 * multiple read or write is allowed
 		 */
-		mq_rq =	container_of(old_areq, struct mmc_queue_req, areq);
-		brq = &mq_rq->brq;
-		old_req = mmc_queue_req_to_req(mq_rq);
-		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
-
-		switch (status) {
-		case MMC_BLK_SUCCESS:
-		case MMC_BLK_PARTIAL:
-			/*
-			 * A block was successfully transferred.
-			 */
-			mmc_blk_reset_success(md, type);
-
-			req_pending = blk_end_request(old_req, BLK_STS_OK,
-						      brq->data.bytes_xfered);
-			/*
-			 * If the blk_end_request function returns non-zero even
-			 * though all data has been transferred and no errors
-			 * were returned by the host controller, it's a bug.
-			 */
-			if (status == MMC_BLK_SUCCESS && req_pending) {
-				pr_err("%s BUG rq_tot %d d_xfer %d\n",
-				       __func__, blk_rq_bytes(old_req),
-				       brq->data.bytes_xfered);
-				mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-				return;
-			}
-			break;
-		case MMC_BLK_CMD_ERR:
-			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
-			if (mmc_blk_reset(md, card->host, type)) {
-				if (req_pending)
-					mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-				else
-					mq->qcnt--;
-				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-				return;
-			}
-			if (!req_pending) {
-				mq->qcnt--;
-				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-				return;
-			}
-			break;
-		case MMC_BLK_RETRY:
-			retune_retry_done = brq->retune_retry_done;
-			if (retry++ < 5)
-				break;
-			/* Fall through */
-		case MMC_BLK_ABORT:
-			if (!mmc_blk_reset(md, card->host, type))
-				break;
-			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-			return;
-		case MMC_BLK_DATA_ERR: {
-			int err;
-
-			err = mmc_blk_reset(md, card->host, type);
-			if (!err)
-				break;
-			if (err == -ENODEV) {
-				mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-				return;
-			}
-			/* Fall through */
-		}
-		case MMC_BLK_ECC_ERR:
-			if (brq->data.blocks > 1) {
-				/* Redo read one sector at a time */
-				pr_warn("%s: retrying using single block read\n",
-					old_req->rq_disk->disk_name);
-				disable_multi = 1;
-				break;
-			}
-			/*
-			 * After an error, we redo I/O one sector at a
-			 * time, so we only reach here after trying to
-			 * read a single sector.
-			 */
-			req_pending = blk_end_request(old_req, BLK_STS_IOERR,
-						      brq->data.blksz);
-			if (!req_pending) {
-				mq->qcnt--;
-				mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-				return;
-			}
-			break;
-		case MMC_BLK_NOMEDIUM:
-			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
-			return;
-		default:
-			pr_err("%s: Unhandled return value (%d)",
-					old_req->rq_disk->disk_name, status);
-			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			mmc_blk_rw_try_restart(mq, new_req, mqrq_cur);
+		if (mmc_large_sector(card) &&
+		    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
+			pr_err("%s: Transfer size is not 4KB sector size aligned\n",
+			       new_req->rq_disk->disk_name);
+			mmc_blk_rw_cmd_abort(mq, card, new_req, mqrq_cur);
 			return;
 		}
 
-		if (req_pending) {
-			/*
-			 * In case of a incomplete request
-			 * prepare it again and resend.
-			 */
-			mmc_blk_rw_rq_prep(mq_rq, card,
-					disable_multi, mq);
-			mmc_start_areq(card->host,
-					&mq_rq->areq, NULL);
-			mq_rq->brq.retune_retry_done = retune_retry_done;
-		}
-	} while (req_pending);
+		mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+		new_areq = &mqrq_cur->areq;
+		new_areq->report_done_status = mmc_blk_rw_done;
+	} else
+		new_areq = NULL;
 
-	mq->qcnt--;
+	old_areq = mmc_start_areq(card->host, new_areq, &status);
+	if (!old_areq) {
+		/*
+		 * We have just put the first request into the pipeline
+		 * and there is nothing more to do until it is
+		 * complete.
+		 */
+		return;
+	}
+	/*
+	 * FIXME: yes, we just discard the old_areq, it will be
+	 * post-processed when done, in mmc_blk_rw_done(). We clean
+	 * this up in later patches.
+	 */
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 865db736c717..620dcbed15b7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -738,12 +738,28 @@ void mmc_finalize_areq(struct work_struct *work)
 	/* Successfully postprocess the old request at this point */
 	mmc_post_req(host, areq->mrq, 0);
 
-	areq->finalization_status = status;
+	/* Call back with status, this will trigger retry etc if needed */
+	if (areq->report_done_status)
+		areq->report_done_status(areq, status);
+
+	/* This opens the gate for the next request to start on the host */
 	complete(&areq->complete);
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
 /**
+ * mmc_restart_areq() - restart an asynchronous request
+ * @host: MMC host to restart the command on
+ * @areq: the asynchronous request to restart
+ */
+int mmc_restart_areq(struct mmc_host *host,
+		     struct mmc_async_req *areq)
+{
+	return __mmc_start_data_req(host, areq->mrq);
+}
+EXPORT_SYMBOL(mmc_restart_areq);
+
+/**
  *	mmc_start_areq - start an asynchronous request
  *	@host: MMC host to start command
  *	@areq: asynchronous request to start
@@ -763,7 +779,6 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				     struct mmc_async_req *areq,
 				     enum mmc_blk_status *ret_stat)
 {
-	enum mmc_blk_status status;
 	int start_err = 0;
 	struct mmc_async_req *previous = host->areq;
 
@@ -772,31 +787,27 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq);
 
 	/* Finalize previous request, if there is one */
-	if (previous) {
+	if (previous)
 		wait_for_completion(&previous->complete);
-		status = previous->finalization_status;
-	} else {
-		status = MMC_BLK_SUCCESS;
-	}
+
+	/* Just always succeed */
 	if (ret_stat)
-		*ret_stat = status;
+		*ret_stat = MMC_BLK_SUCCESS;
 
 	/* Fine so far, start the new request! */
-	if (status == MMC_BLK_SUCCESS && areq) {
+	if (areq) {
 		init_completion(&areq->complete);
 		areq->mrq->areq = areq;
 		start_err = __mmc_start_data_req(host, areq->mrq);
+		/* Cancel a prepared request if it was not started. */
+		if (start_err) {
+			mmc_post_req(host, areq->mrq, -EINVAL);
+			host->areq = NULL;
+		} else {
+			host->areq = areq;
+		}
 	}
 
-	/* Cancel a prepared request if it was not started. */
-	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
-		mmc_post_req(host, areq->mrq, -EINVAL);
-
-	if (status != MMC_BLK_SUCCESS)
-		host->areq = NULL;
-	else
-		host->areq = areq;
-
 	return previous;
 }
 EXPORT_SYMBOL(mmc_start_areq);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 88b852ac8f74..1859804ecd80 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -112,6 +112,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq);
 struct mmc_async_req;
 
 void mmc_finalize_areq(struct work_struct *work);
+int mmc_restart_areq(struct mmc_host *host, struct mmc_async_req *areq);
 struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				     struct mmc_async_req *areq,
 				     enum mmc_blk_status *ret_stat);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 023bbddc1a0b..db1fa11d9870 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -145,6 +145,7 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
 	if (!mq_rq->sg)
 		return -ENOMEM;
+	mq_rq->mq = mq;
 
 	return 0;
 }
@@ -155,6 +156,7 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 
 	kfree(mq_rq->sg);
 	mq_rq->sg = NULL;
+	mq_rq->mq = NULL;
 }
 
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 68f68ecd94ea..dce7cedb9d0b 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -52,6 +52,7 @@ struct mmc_queue_req {
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
 	struct mmc_async_req	areq;
+	struct mmc_queue	*mq;
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
 	void			*drv_op_data;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 638f11d185bd..74859a71e14b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -216,8 +216,11 @@ struct mmc_async_req {
 	 * Returns 0 if success otherwise non zero.
 	 */
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
+	/*
+	 * Report finalization status from the core to e.g. the block layer.
+	 */
+	void (*report_done_status)(struct mmc_async_req *, enum mmc_blk_status);
 	struct work_struct finalization_work;
-	enum mmc_blk_status finalization_status;
 	struct completion complete;
 	struct mmc_host *host;
 };
-- 
2.13.6
