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
Subject: [PATCH 11/16] mmc: block: shuffle retry and error handling
Date: Thu,  9 Feb 2017 16:33:58 +0100
Message-Id: <20170209153403.9730-12-linus.walleij@linaro.org>
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Instead of doing retries at the same time as trying to submit new
requests, do the retries when the request is reported as completed
by the driver, in the finalization worker.

This is achieved by letting the core worker call back into the block
layer using mmc_blk_rw_done(), that will read the status and repeatedly
try to hammer the request using single request etc by calling back to
the core layer using mmc_restart_areq()

The beauty of it is that the completion will not complete until the
block layer has had the opportunity to hammer a bit at the card using
a bunch of different approaches in the while() loop in
mmc_blk_rw_done()

The algorithm for recapture, retry and handle errors is essentially
identical to the one we used to have in mmc_blk_issue_rw_rq(),
only augmented to get called in another path.

We have to add and initialize a pointer back to the struct mmc_queue
from the struct mmc_queue_req to find the queue from the asynchronous
request.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 307 +++++++++++++++++++++++------------------------
 drivers/mmc/core/block.h |   3 +
 drivers/mmc/core/core.c  |  23 +++-
 drivers/mmc/core/queue.c |   2 +
 drivers/mmc/core/queue.h |   1 +
 include/linux/mmc/core.h |   1 +
 include/linux/mmc/host.h |   1 -
 7 files changed, 177 insertions(+), 161 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c459d80c66bf..0bd9070f5f2e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1614,182 +1614,181 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
  * @mq: the queue with the card and host to restart
  * @req: a new request that want to be started after the current one
  */
-static void mmc_blk_rw_try_restart(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_rw_try_restart(struct mmc_queue *mq)
 {
-	if (!req)
-		return;
-
-	/*
-	 * If the card was removed, just cancel everything and return.
-	 */
-	if (mmc_card_removed(mq->card)) {
-		req->rq_flags |= RQF_QUIET;
-		blk_end_request_all(req, -EIO);
-		return;
-	}
-	/* Else proceed and try to restart the current async request */
+	/* Proceed and try to restart the current async request */
 	mmc_blk_rw_rq_prep(mq->mqrq_cur, mq->card, 0, mq);
-	mmc_start_areq(mq->card->host, &mq->mqrq_cur->areq, NULL);
+	mmc_restart_areq(mq->card->host, &mq->mqrq_cur->areq);
 }
 
-static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
+void mmc_blk_rw_done(struct mmc_async_req *areq,
+		     enum mmc_blk_status status)
 {
-	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_card *card = md->queue.card;
-	struct mmc_blk_request *brq;
-	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
-	enum mmc_blk_status status;
+	struct mmc_queue *mq;
 	struct mmc_queue_req *mq_rq;
+	struct mmc_blk_request *brq;
+	struct mmc_blk_data *md;
 	struct request *old_req;
-	struct mmc_async_req *new_areq;
-	struct mmc_async_req *old_areq;
+	struct mmc_card *card;
+	struct mmc_host *host;
+	int disable_multi = 0, retry = 0, type, retune_retry_done = 0;
 	bool req_pending = true;
 
-	if (!new_req && !mq->mqrq_prev->req)
-		return;
-
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
-				mmc_blk_rw_cmd_abort(card, new_req);
-				return;
-			}
-
-			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-			new_areq = &mq->mqrq_cur->areq;
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
-
+	/*
+	 * An asynchronous request has been completed and we proceed
+	 * to handle the result of it.
+	 */
+	mq_rq =	container_of(areq, struct mmc_queue_req, areq);
+	mq = mq_rq->mq;
+	md = mq->blkdata;
+	card = mq->card;
+	host = card->host;
+	brq = &mq_rq->brq;
+	old_req = mq_rq->req;
+	type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	mmc_queue_bounce_post(mq_rq);
+
+	switch (status) {
+	case MMC_BLK_SUCCESS:
+	case MMC_BLK_PARTIAL:
 		/*
-		 * An asynchronous request has been completed and we proceed
-		 * to handle the result of it.
+		 * A block was successfully transferred.
 		 */
-		mq_rq =	container_of(old_areq, struct mmc_queue_req, areq);
-		brq = &mq_rq->brq;
-		old_req = mq_rq->req;
-		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
-		mmc_queue_bounce_post(mq_rq);
-
-		switch (status) {
-		case MMC_BLK_SUCCESS:
-		case MMC_BLK_PARTIAL:
-			/*
-			 * A block was successfully transferred.
-			 */
-			mmc_blk_reset_success(md, type);
+		mmc_blk_reset_success(md, type);
 
-			req_pending = blk_end_request(old_req, 0,
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
-				mmc_blk_rw_cmd_abort(card, old_req);
-				return;
-			}
-			break;
-		case MMC_BLK_CMD_ERR:
-			req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
-			if (mmc_blk_reset(md, card->host, type)) {
-				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_try_restart(mq, new_req);
-				return;
-			}
-			if (!req_pending) {
-				mmc_blk_rw_try_restart(mq, new_req);
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
+		req_pending = blk_end_request(old_req, 0,
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
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
 			return;
-		case MMC_BLK_DATA_ERR: {
-			int err;
-
-			err = mmc_blk_reset(md, card->host, type);
-			if (!err)
-				break;
-			if (err == -ENODEV) {
-				mmc_blk_rw_cmd_abort(card, old_req);
-				mmc_blk_rw_try_restart(mq, new_req);
-				return;
-			}
-			/* Fall through */
 		}
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
-			req_pending = blk_end_request(old_req, -EIO,
-						      brq->data.blksz);
-			if (!req_pending) {
-				mmc_blk_rw_try_restart(mq, new_req);
-				return;
-			}
-			break;
-		case MMC_BLK_NOMEDIUM:
+		break;
+	case MMC_BLK_CMD_ERR:
+		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
+		if (mmc_blk_reset(md, host, type)) {
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq);
 			return;
-		default:
-			pr_err("%s: Unhandled return value (%d)",
-					old_req->rq_disk->disk_name, status);
+		}
+		if (!req_pending) {
+			mmc_blk_rw_try_restart(mq);
+			return;
+		}
+		break;
+	case MMC_BLK_RETRY:
+		retune_retry_done = brq->retune_retry_done;
+		if (retry++ < 5)
+			break;
+		/* Fall through */
+	case MMC_BLK_ABORT:
+		if (!mmc_blk_reset(md, host, type))
+			break;
+		mmc_blk_rw_cmd_abort(card, old_req);
+		mmc_blk_rw_try_restart(mq);
+		return;
+	case MMC_BLK_DATA_ERR: {
+		int err;
+			err = mmc_blk_reset(md, host, type);
+		if (!err)
+			break;
+		if (err == -ENODEV) {
 			mmc_blk_rw_cmd_abort(card, old_req);
-			mmc_blk_rw_try_restart(mq, new_req);
+			mmc_blk_rw_try_restart(mq);
 			return;
 		}
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
+		req_pending = blk_end_request(old_req, -EIO,
+					      brq->data.blksz);
+		if (!req_pending) {
+			mmc_blk_rw_try_restart(mq);
+			return;
+		}
+		break;
+	case MMC_BLK_NOMEDIUM:
+		mmc_blk_rw_cmd_abort(card, old_req);
+		mmc_blk_rw_try_restart(mq);
+		return;
+	default:
+		pr_err("%s: Unhandled return value (%d)",
+		       old_req->rq_disk->disk_name, status);
+		mmc_blk_rw_cmd_abort(card, old_req);
+		mmc_blk_rw_try_restart(mq);
+		return;
+	}
 
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
+	if (req_pending) {
+		/*
+		 * In case of a incomplete request
+		 * prepare it again and resend.
+		 */
+		mmc_blk_rw_rq_prep(mq_rq, card,
+				   disable_multi, mq);
+		mq_rq->brq.retune_retry_done = retune_retry_done;
+		mmc_restart_areq(host, &mq->mqrq_cur->areq);
+	}
+}
+
+static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
+{
+	enum mmc_blk_status status;
+	struct mmc_async_req *new_areq;
+	struct mmc_async_req *old_areq;
+	struct mmc_card *card = mq->card;
+
+	if (!new_req && !mq->mqrq_prev->req)
+		return;
+
+	if (new_req) {
+		/*
+		 * When 4KB native sector is enabled, only 8 blocks
+		 * multiple read or write is allowed
+		 */
+		if (mmc_large_sector(card) &&
+		    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
+			pr_err("%s: Transfer size is not 4KB sector size aligned\n",
+			       new_req->rq_disk->disk_name);
+			mmc_blk_rw_cmd_abort(card, new_req);
+			return;
 		}
-	} while (req_pending);
+
+		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+		new_areq = &mq->mqrq_cur->areq;
+	} else
+		new_areq = NULL;
+
+	old_areq = mmc_start_areq(card->host, new_areq, &status);
+	if (!old_areq) {
+		/*
+		 * We have just put the first request into the pipeline
+		 * and there is nothing more to do until it is
+		 * complete.
+		 */
+		return;
+	}
+	/* FIXME: yes, we just disregard the old_areq */
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..b4b489911599 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -1,9 +1,12 @@
 #ifndef _MMC_CORE_BLOCK_H
 #define _MMC_CORE_BLOCK_H
 
+struct mmc_async_req;
+enum mmc_blk_status;
 struct mmc_queue;
 struct request;
 
+void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status);
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
 #endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4b84f18518ac..34337ef6705e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -39,6 +39,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
 
+#include "block.h"
 #include "core.h"
 #include "card.h"
 #include "bus.h"
@@ -632,13 +633,25 @@ void mmc_finalize_areq(struct kthread_work *work)
 
 	/* Successfully postprocess the old request at this point */
 	mmc_post_req(host, areq->mrq, 0);
+	mmc_blk_rw_done(areq, status);
 
-	areq->finalization_status = status;
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
@@ -667,12 +680,10 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
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
+	status = MMC_BLK_SUCCESS;
 	if (ret_stat)
 		*ret_stat = status;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index bc116709c806..ae6837317fe0 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -268,7 +268,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->mqrq)
 		goto blk_cleanup;
 	mq->mqrq_cur = &mq->mqrq[0];
+	mq->mqrq_cur->mq = mq;
 	mq->mqrq_prev = &mq->mqrq[1];
+	mq->mqrq_prev->mq = mq;
 	mq->queue->queuedata = mq;
 
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 39d8e710287e..c18d3f908433 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -34,6 +34,7 @@ struct mmc_queue_req {
 	struct scatterlist	*bounce_sg;
 	unsigned int		bounce_sg_len;
 	struct mmc_async_req	areq;
+	struct mmc_queue	*mq;
 };
 
 struct mmc_queue {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 5db0fb722c37..55b45dcddee6 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -159,6 +159,7 @@ struct mmc_card;
 struct mmc_async_req;
 
 void mmc_finalize_areq(struct kthread_work *work);
+int mmc_restart_areq(struct mmc_host *host, struct mmc_async_req *areq);
 struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 				struct mmc_async_req *areq,
 				enum mmc_blk_status *ret_stat);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a7c0ed887391..47d80b8470cd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -171,7 +171,6 @@ struct mmc_async_req {
 	 */
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
 	struct kthread_work finalization_work;
-	enum mmc_blk_status finalization_status;
 	struct completion complete;
 	struct mmc_host *host;
 };
-- 
2.9.3
