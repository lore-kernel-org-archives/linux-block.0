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
Subject: [PATCH 09/12 v4] mmc: queue: stop flushing the pipeline with NULL
Date: Thu, 26 Oct 2017 14:57:54 +0200
Message-Id: <20171026125757.10200-10-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Remove all the pipeline flush: i.e. repeatedly sending NULL
down to the core layer to flush out asynchronous requests,
and also sending NULL after "special" commands to achieve the
same flush.

Instead: let the "special" commands wait for any ongoing
asynchronous transfers using the completion, and apart from
that expect the core.c and block.c layers to deal with the
ongoing requests autonomously without any "push" from the
queue.

Add a function in the core to wait for an asynchronous request
to complete.

Update the tests to use the new function prototypes.

This kills off some FIXME's such as gettin rid of the mq->qcnt
queue depth variable that was introduced a while back.

It is a vital step toward multiqueue enablement that we stop
pulling NULL off the end of the request queue to flush the
asynchronous issueing mechanism.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c    | 168 ++++++++++++++++----------------------------
 drivers/mmc/core/core.c     |  50 +++++++------
 drivers/mmc/core/core.h     |   6 +-
 drivers/mmc/core/mmc_test.c |  31 ++------
 drivers/mmc/core/queue.c    |  11 ++-
 drivers/mmc/core/queue.h    |   7 --
 6 files changed, 106 insertions(+), 167 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c1178fa83f75..ab01cab4a026 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1805,7 +1805,6 @@ static void mmc_blk_rw_cmd_abort(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_card_removed(card))
 		req->rq_flags |= RQF_QUIET;
 	while (blk_end_request(req, BLK_STS_IOERR, blk_rq_cur_bytes(req)));
-	mq->qcnt--;
 }
 
 /**
@@ -1873,13 +1872,10 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		if (mmc_blk_reset(md, card->host, type)) {
 			if (req_pending)
 				mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			else
-				mq->qcnt--;
 			mmc_blk_rw_try_restart(mq, mq_rq);
 			return;
 		}
 		if (!req_pending) {
-			mq->qcnt--;
 			mmc_blk_rw_try_restart(mq, mq_rq);
 			return;
 		}
@@ -1923,7 +1919,6 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		req_pending = blk_end_request(old_req, BLK_STS_IOERR,
 					      brq->data.blksz);
 		if (!req_pending) {
-			mq->qcnt--;
 			mmc_blk_rw_try_restart(mq, mq_rq);
 			return;
 		}
@@ -1947,26 +1942,16 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		 */
 		mmc_blk_rw_rq_prep(mq_rq, card,
 				disable_multi, mq);
-		mmc_start_areq(card->host, areq, NULL);
+		mmc_start_areq(card->host, areq);
 		mq_rq->brq.retune_retry_done = retune_retry_done;
-	} else {
-		/* Else, this request is done */
-		mq->qcnt--;
 	}
 }
 
 static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 {
-	enum mmc_blk_status status;
-	struct mmc_async_req *new_areq;
-	struct mmc_async_req *old_areq;
 	struct mmc_card *card = mq->card;
-
-	if (new_req)
-		mq->qcnt++;
-
-	if (!mq->qcnt)
-		return;
+	struct mmc_queue_req *mqrq_cur = req_to_mmc_queue_req(new_req);
+	struct mmc_async_req *areq = &mqrq_cur->areq;
 
 	/*
 	 * If the card was removed, just cancel everything and return.
@@ -1974,44 +1959,25 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	if (mmc_card_removed(card)) {
 		new_req->rq_flags |= RQF_QUIET;
 		blk_end_request_all(new_req, BLK_STS_IOERR);
-		mq->qcnt--; /* FIXME: just set to 0? */
 		return;
 	}
 
-	if (new_req) {
-		struct mmc_queue_req *mqrq_cur = req_to_mmc_queue_req(new_req);
-		/*
-		 * When 4KB native sector is enabled, only 8 blocks
-		 * multiple read or write is allowed
-		 */
-		if (mmc_large_sector(card) &&
-		    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
-			pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-			       new_req->rq_disk->disk_name);
-			mmc_blk_rw_cmd_abort(mq, card, new_req, mqrq_cur);
-			return;
-		}
-
-		mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
-		new_areq = &mqrq_cur->areq;
-		new_areq->report_done_status = mmc_blk_rw_done;
-	} else
-		new_areq = NULL;
 
-	old_areq = mmc_start_areq(card->host, new_areq, &status);
-	if (!old_areq) {
-		/*
-		 * We have just put the first request into the pipeline
-		 * and there is nothing more to do until it is
-		 * complete.
-		 */
-		return;
-	}
 	/*
-	 * FIXME: yes, we just discard the old_areq, it will be
-	 * post-processed when done, in mmc_blk_rw_done(). We clean
-	 * this up in later patches.
+	 * When 4KB native sector is enabled, only 8 blocks
+	 * multiple read or write is allowed
 	 */
+	if (mmc_large_sector(card) &&
+	    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
+		pr_err("%s: Transfer size is not 4KB sector size aligned\n",
+		       new_req->rq_disk->disk_name);
+		mmc_blk_rw_cmd_abort(mq, card, new_req, mqrq_cur);
+		return;
+	}
+
+	mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+	areq->report_done_status = mmc_blk_rw_done;
+	mmc_start_areq(card->host, areq);
 }
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
@@ -2020,70 +1986,56 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 
-	if (req && !mq->qcnt)
-		/* claim host only for the first request */
-		mmc_get_card(card, NULL);
+	if (!req) {
+		pr_err("%s: tried to issue NULL request\n", __func__);
+		return;
+	}
 
 	ret = mmc_blk_part_switch(card, md->part_type);
 	if (ret) {
-		if (req) {
-			blk_end_request_all(req, BLK_STS_IOERR);
-		}
-		goto out;
+		blk_end_request_all(req, BLK_STS_IOERR);
+		return;
 	}
 
-	if (req) {
-		switch (req_op(req)) {
-		case REQ_OP_DRV_IN:
-		case REQ_OP_DRV_OUT:
-			/*
-			 * Complete ongoing async transfer before issuing
-			 * ioctl()s
-			 */
-			if (mq->qcnt)
-				mmc_blk_issue_rw_rq(mq, NULL);
-			mmc_blk_issue_drv_op(mq, req);
-			break;
-		case REQ_OP_DISCARD:
-			/*
-			 * Complete ongoing async transfer before issuing
-			 * discard.
-			 */
-			if (mq->qcnt)
-				mmc_blk_issue_rw_rq(mq, NULL);
-			mmc_blk_issue_discard_rq(mq, req);
-			break;
-		case REQ_OP_SECURE_ERASE:
-			/*
-			 * Complete ongoing async transfer before issuing
-			 * secure erase.
-			 */
-			if (mq->qcnt)
-				mmc_blk_issue_rw_rq(mq, NULL);
-			mmc_blk_issue_secdiscard_rq(mq, req);
-			break;
-		case REQ_OP_FLUSH:
-			/*
-			 * Complete ongoing async transfer before issuing
-			 * flush.
-			 */
-			if (mq->qcnt)
-				mmc_blk_issue_rw_rq(mq, NULL);
-			mmc_blk_issue_flush(mq, req);
-			break;
-		default:
-			/* Normal request, just issue it */
-			mmc_blk_issue_rw_rq(mq, req);
-			break;
-		}
-	} else {
-		/* No request, flushing the pipeline with NULL */
-		mmc_blk_issue_rw_rq(mq, NULL);
+	switch (req_op(req)) {
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+		/*
+		 * Complete ongoing async transfer before issuing
+		 * ioctl()s
+		 */
+		mmc_wait_for_areq(card->host);
+		mmc_blk_issue_drv_op(mq, req);
+		break;
+	case REQ_OP_DISCARD:
+		/*
+		 * Complete ongoing async transfer before issuing
+		 * discard.
+		 */
+		mmc_wait_for_areq(card->host);
+		mmc_blk_issue_discard_rq(mq, req);
+		break;
+	case REQ_OP_SECURE_ERASE:
+		/*
+		 * Complete ongoing async transfer before issuing
+		 * secure erase.
+		 */
+		mmc_wait_for_areq(card->host);
+		mmc_blk_issue_secdiscard_rq(mq, req);
+		break;
+	case REQ_OP_FLUSH:
+		/*
+		 * Complete ongoing async transfer before issuing
+		 * flush.
+		 */
+		mmc_wait_for_areq(card->host);
+		mmc_blk_issue_flush(mq, req);
+		break;
+	default:
+		/* Normal request, just issue it */
+		mmc_blk_issue_rw_rq(mq, req);
+		break;
 	}
-
-out:
-	if (!mq->qcnt)
-		mmc_put_card(card, NULL);
 }
 
 static inline int mmc_blk_readonly(struct mmc_card *card)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 620dcbed15b7..209ebb8a7f3f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -747,6 +747,15 @@ void mmc_finalize_areq(struct work_struct *work)
 }
 EXPORT_SYMBOL(mmc_finalize_areq);
 
+void mmc_wait_for_areq(struct mmc_host *host)
+{
+	if (host->areq) {
+		wait_for_completion(&host->areq->complete);
+		host->areq = NULL;
+	}
+}
+EXPORT_SYMBOL(mmc_wait_for_areq);
+
 /**
  * mmc_restart_areq() - restart an asynchronous request
  * @host: MMC host to restart the command on
@@ -775,40 +784,37 @@ EXPORT_SYMBOL(mmc_restart_areq);
  *	return the completed request. If there is no ongoing request, NULL
  *	is returned without waiting. NULL is not an error condition.
  */
-struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
-				     struct mmc_async_req *areq,
-				     enum mmc_blk_status *ret_stat)
+int mmc_start_areq(struct mmc_host *host,
+		   struct mmc_async_req *areq)
 {
-	int start_err = 0;
 	struct mmc_async_req *previous = host->areq;
+	int ret;
+
+	/* Delete this check when we trust the code */
+	if (!areq)
+		pr_err("%s: NULL asynchronous request!\n", __func__);
 
 	/* Prepare a new request */
-	if (areq)
-		mmc_pre_req(host, areq->mrq);
+	mmc_pre_req(host, areq->mrq);
 
 	/* Finalize previous request, if there is one */
 	if (previous)
 		wait_for_completion(&previous->complete);
 
-	/* Just always succeed */
-	if (ret_stat)
-		*ret_stat = MMC_BLK_SUCCESS;
-
 	/* Fine so far, start the new request! */
-	if (areq) {
-		init_completion(&areq->complete);
-		areq->mrq->areq = areq;
-		start_err = __mmc_start_data_req(host, areq->mrq);
-		/* Cancel a prepared request if it was not started. */
-		if (start_err) {
-			mmc_post_req(host, areq->mrq, -EINVAL);
-			host->areq = NULL;
-		} else {
-			host->areq = areq;
-		}
+	init_completion(&areq->complete);
+	areq->mrq->areq = areq;
+	ret = __mmc_start_data_req(host, areq->mrq);
+	/* Cancel a prepared request if it was not started. */
+	if (ret) {
+		mmc_post_req(host, areq->mrq, -EINVAL);
+		host->areq = NULL;
+		pr_err("%s: failed to start request\n", __func__);
+	} else {
+		host->areq = areq;
 	}
 
-	return previous;
+	return ret;
 }
 EXPORT_SYMBOL(mmc_start_areq);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 1859804ecd80..5b8d0f1147ef 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -113,9 +113,9 @@ struct mmc_async_req;
 
 void mmc_finalize_areq(struct work_struct *work);
 int mmc_restart_areq(struct mmc_host *host, struct mmc_async_req *areq);
-struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
-				     struct mmc_async_req *areq,
-				     enum mmc_blk_status *ret_stat);
+int mmc_start_areq(struct mmc_host *host,
+		   struct mmc_async_req *areq);
+void mmc_wait_for_areq(struct mmc_host *host);
 
 int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		unsigned int arg);
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 478869805b96..256fdce38449 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -839,10 +839,8 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 {
 	struct mmc_test_req *rq1, *rq2;
 	struct mmc_test_async_req test_areq[2];
-	struct mmc_async_req *done_areq;
 	struct mmc_async_req *cur_areq = &test_areq[0].areq;
 	struct mmc_async_req *other_areq = &test_areq[1].areq;
-	enum mmc_blk_status status;
 	int i;
 	int ret = RESULT_OK;
 
@@ -864,25 +862,16 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	for (i = 0; i < count; i++) {
 		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
 				     blocks, blksz, write);
-		done_areq = mmc_start_areq(test->card->host, cur_areq, &status);
+		ret = mmc_start_areq(test->card->host, cur_areq);
+		mmc_wait_for_areq(test->card->host);
 
-		if (status != MMC_BLK_SUCCESS || (!done_areq && i > 0)) {
-			ret = RESULT_FAIL;
-			goto err;
-		}
-
-		if (done_areq)
-			mmc_test_req_reset(container_of(done_areq->mrq,
+		mmc_test_req_reset(container_of(cur_areq->mrq,
 						struct mmc_test_req, mrq));
 
 		swap(cur_areq, other_areq);
 		dev_addr += blocks;
 	}
 
-	done_areq = mmc_start_areq(test->card->host, NULL, &status);
-	if (status != MMC_BLK_SUCCESS)
-		ret = RESULT_FAIL;
-
 err:
 	kfree(rq1);
 	kfree(rq2);
@@ -2360,7 +2349,6 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	struct mmc_request *mrq;
 	unsigned long timeout;
 	bool expired = false;
-	enum mmc_blk_status blkstat = MMC_BLK_SUCCESS;
 	int ret = 0, cmd_ret;
 	u32 status = 0;
 	int count = 0;
@@ -2388,11 +2376,8 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 
 	/* Start ongoing data request */
 	if (use_areq) {
-		mmc_start_areq(host, &test_areq.areq, &blkstat);
-		if (blkstat != MMC_BLK_SUCCESS) {
-			ret = RESULT_FAIL;
-			goto out_free;
-		}
+		mmc_start_areq(host, &test_areq.areq);
+		mmc_wait_for_areq(host);
 	} else {
 		mmc_wait_for_req(host, mrq);
 	}
@@ -2425,11 +2410,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	} while (repeat_cmd && R1_CURRENT_STATE(status) != R1_STATE_TRAN);
 
 	/* Wait for data request to complete */
-	if (use_areq) {
-		mmc_start_areq(host, NULL, &blkstat);
-		if (blkstat != MMC_BLK_SUCCESS)
-			ret = RESULT_FAIL;
-	} else {
+	if (!use_areq) {
 		mmc_wait_for_req_done(test->card->host, mrq);
 	}
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index db1fa11d9870..cf43a2d5410d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -42,6 +42,7 @@ static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
 	struct request_queue *q = mq->queue;
+	bool claimed_card = false;
 
 	current->flags |= PF_MEMALLOC;
 
@@ -55,7 +56,11 @@ static int mmc_queue_thread(void *d)
 		mq->asleep = false;
 		spin_unlock_irq(q->queue_lock);
 
-		if (req || mq->qcnt) {
+		if (req) {
+			if (!claimed_card) {
+				mmc_get_card(mq->card, NULL);
+				claimed_card = true;
+			}
 			set_current_state(TASK_RUNNING);
 			mmc_blk_issue_rq(mq, req);
 			cond_resched();
@@ -72,6 +77,9 @@ static int mmc_queue_thread(void *d)
 	} while (1);
 	up(&mq->thread_sem);
 
+	if (claimed_card)
+		mmc_put_card(mq->card, NULL);
+
 	return 0;
 }
 
@@ -207,7 +215,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->queue->exit_rq_fn = mmc_exit_request;
 	mq->queue->cmd_size = sizeof(struct mmc_queue_req);
 	mq->queue->queuedata = mq;
-	mq->qcnt = 0;
 	ret = blk_init_allocated_queue(mq->queue);
 	if (ret) {
 		blk_cleanup_queue(mq->queue);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index dce7cedb9d0b..67ae311b107f 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -67,13 +67,6 @@ struct mmc_queue {
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
 	struct request_queue	*queue;
-	/*
-	 * FIXME: this counter is not a very reliable way of keeping
-	 * track of how many requests that are ongoing. Switch to just
-	 * letting the block core keep track of requests and per-request
-	 * associated mmc_queue_req data.
-	 */
-	int			qcnt;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
-- 
2.13.6
