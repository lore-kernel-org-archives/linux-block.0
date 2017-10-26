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
Subject: [PATCH 10/12 v4] mmc: queue/block: pass around struct mmc_queue_req*s
Date: Thu, 26 Oct 2017 14:57:55 +0200
Message-Id: <20171026125757.10200-11-linus.walleij@linaro.org>
In-Reply-To: <20171026125757.10200-1-linus.walleij@linaro.org>
References: <20171026125757.10200-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Instead of passing two pointers around several pointers to
mmc_queue_req, request, mmc_queue, and reassigning to the left and
right, issue mmc_queue_req and dereference the queue and request
from the mmq_queue_req where needed.

The struct mmc_queue_req is the thing that has a lifecycle after
all: this is what we are keeping in our queue, and what the block
layer helps us manager. Augment a bunch of functions to take a
single argument so we can see the trees and not just a big
jungle of arguments.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 129 ++++++++++++++++++++++++-----------------------
 drivers/mmc/core/block.h |   5 +-
 drivers/mmc/core/queue.c |   2 +-
 3 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ab01cab4a026..184907f5fb97 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1208,9 +1208,9 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
  * processed it with all other requests and then they get issued in this
  * function.
  */
-static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_drv_op(struct mmc_queue_req *mq_rq)
 {
-	struct mmc_queue_req *mq_rq;
+	struct mmc_queue *mq = mq_rq->mq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_blk_ioc_data **idata;
@@ -1220,7 +1220,6 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	int ret;
 	int i;
 
-	mq_rq = req_to_mmc_queue_req(req);
 	rpmb_ioctl = (mq_rq->drv_op == MMC_DRV_OP_IOCTL_RPMB);
 
 	switch (mq_rq->drv_op) {
@@ -1264,12 +1263,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		break;
 	}
 	mq_rq->drv_op_result = ret;
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	blk_end_request_all(mmc_queue_req_to_req(mq_rq),
+			    ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
-static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_discard_rq(struct mmc_queue_req *mq_rq)
 {
-	struct mmc_blk_data *md = mq->blkdata;
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+	struct mmc_blk_data *md = mq_rq->mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
 	int err = 0, type = MMC_BLK_DISCARD;
@@ -1310,10 +1311,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	blk_end_request(req, status, blk_rq_bytes(req));
 }
 
-static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
-				       struct request *req)
+static void mmc_blk_issue_secdiscard_rq(struct mmc_queue_req *mq_rq)
 {
-	struct mmc_blk_data *md = mq->blkdata;
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+	struct mmc_blk_data *md = mq_rq->mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
 	int err = 0, type = MMC_BLK_SECDISCARD;
@@ -1380,14 +1381,15 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	blk_end_request(req, status, blk_rq_bytes(req));
 }
 
-static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_issue_flush(struct mmc_queue_req *mq_rq)
 {
-	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_blk_data *md = mq_rq->mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 	int ret = 0;
 
 	ret = mmc_flush_cache(card);
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	blk_end_request_all(mmc_queue_req_to_req(mq_rq),
+			    ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 /*
@@ -1698,18 +1700,18 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		*do_data_tag_p = do_data_tag;
 }
 
-static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
-			       struct mmc_card *card,
-			       int disable_multi,
-			       struct mmc_queue *mq)
+static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mq_rq,
+			       int disable_multi)
 {
 	u32 readcmd, writecmd;
-	struct mmc_blk_request *brq = &mqrq->brq;
-	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct mmc_queue *mq = mq_rq->mq;
+	struct mmc_card *card = mq->card;
+	struct mmc_blk_request *brq = &mq_rq->brq;
+	struct request *req = mmc_queue_req_to_req(mq_rq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
 
-	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
+	mmc_blk_data_prep(mq, mq_rq, disable_multi, &do_rel_wr, &do_data_tag);
 
 	brq->mrq.cmd = &brq->cmd;
 	brq->mrq.areq = NULL;
@@ -1764,9 +1766,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.sbc = &brq->sbc;
 	}
 
-	mqrq->areq.err_check = mmc_blk_err_check;
-	mqrq->areq.host = card->host;
-	INIT_WORK(&mqrq->areq.finalization_work, mmc_finalize_areq);
+	mq_rq->areq.err_check = mmc_blk_err_check;
+	mq_rq->areq.host = card->host;
+	INIT_WORK(&mq_rq->areq.finalization_work, mmc_finalize_areq);
 }
 
 static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
@@ -1798,10 +1800,12 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 	return req_pending;
 }
 
-static void mmc_blk_rw_cmd_abort(struct mmc_queue *mq, struct mmc_card *card,
-				 struct request *req,
-				 struct mmc_queue_req *mqrq)
+static void mmc_blk_rw_cmd_abort(struct mmc_queue_req *mq_rq)
 {
+	struct mmc_queue *mq = mq_rq->mq;
+	struct mmc_card *card = mq->card;
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+
 	if (mmc_card_removed(card))
 		req->rq_flags |= RQF_QUIET;
 	while (blk_end_request(req, BLK_STS_IOERR, blk_rq_cur_bytes(req)));
@@ -1809,15 +1813,15 @@ static void mmc_blk_rw_cmd_abort(struct mmc_queue *mq, struct mmc_card *card,
 
 /**
  * mmc_blk_rw_try_restart() - tries to restart the current async request
- * @mq: the queue with the card and host to restart
- * @mqrq: the mmc_queue_request containing the areq to be restarted
+ * @mq_rq: the mmc_queue_request containing the areq to be restarted
  */
-static void mmc_blk_rw_try_restart(struct mmc_queue *mq,
-				   struct mmc_queue_req *mqrq)
+static void mmc_blk_rw_try_restart(struct mmc_queue_req *mq_rq)
 {
+	struct mmc_queue *mq = mq_rq->mq;
+
 	/* Proceed and try to restart the current async request */
-	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
-	mmc_restart_areq(mq->card->host, &mqrq->areq);
+	mmc_blk_rw_rq_prep(mq_rq, 0);
+	mmc_restart_areq(mq->card->host, &mq_rq->areq);
 }
 
 static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status status)
@@ -1863,7 +1867,7 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 			pr_err("%s BUG rq_tot %d d_xfer %d\n",
 			       __func__, blk_rq_bytes(old_req),
 			       brq->data.bytes_xfered);
-			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
+			mmc_blk_rw_cmd_abort(mq_rq);
 			return;
 		}
 		break;
@@ -1871,12 +1875,12 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
 		if (mmc_blk_reset(md, card->host, type)) {
 			if (req_pending)
-				mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			mmc_blk_rw_try_restart(mq, mq_rq);
+				mmc_blk_rw_cmd_abort(mq_rq);
+			mmc_blk_rw_try_restart(mq_rq);
 			return;
 		}
 		if (!req_pending) {
-			mmc_blk_rw_try_restart(mq, mq_rq);
+			mmc_blk_rw_try_restart(mq_rq);
 			return;
 		}
 		break;
@@ -1888,8 +1892,8 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 	case MMC_BLK_ABORT:
 		if (!mmc_blk_reset(md, card->host, type))
 			break;
-		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-		mmc_blk_rw_try_restart(mq, mq_rq);
+		mmc_blk_rw_cmd_abort(mq_rq);
+		mmc_blk_rw_try_restart(mq_rq);
 		return;
 	case MMC_BLK_DATA_ERR: {
 		int err;
@@ -1897,8 +1901,8 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		if (!err)
 			break;
 		if (err == -ENODEV) {
-			mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-			mmc_blk_rw_try_restart(mq, mq_rq);
+			mmc_blk_rw_cmd_abort(mq_rq);
+			mmc_blk_rw_try_restart(mq_rq);
 			return;
 		}
 		/* Fall through */
@@ -1919,19 +1923,19 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		req_pending = blk_end_request(old_req, BLK_STS_IOERR,
 					      brq->data.blksz);
 		if (!req_pending) {
-			mmc_blk_rw_try_restart(mq, mq_rq);
+			mmc_blk_rw_try_restart(mq_rq);
 			return;
 		}
 		break;
 	case MMC_BLK_NOMEDIUM:
-		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-		mmc_blk_rw_try_restart(mq, mq_rq);
+		mmc_blk_rw_cmd_abort(mq_rq);
+		mmc_blk_rw_try_restart(mq_rq);
 		return;
 	default:
 		pr_err("%s: Unhandled return value (%d)",
 				old_req->rq_disk->disk_name, status);
-		mmc_blk_rw_cmd_abort(mq, card, old_req, mq_rq);
-		mmc_blk_rw_try_restart(mq, mq_rq);
+		mmc_blk_rw_cmd_abort(mq_rq);
+		mmc_blk_rw_try_restart(mq_rq);
 		return;
 	}
 
@@ -1940,25 +1944,25 @@ static void mmc_blk_rw_done(struct mmc_async_req *areq, enum mmc_blk_status stat
 		 * In case of a incomplete request
 		 * prepare it again and resend.
 		 */
-		mmc_blk_rw_rq_prep(mq_rq, card,
-				disable_multi, mq);
+		mmc_blk_rw_rq_prep(mq_rq, disable_multi);
 		mmc_start_areq(card->host, areq);
 		mq_rq->brq.retune_retry_done = retune_retry_done;
 	}
 }
 
-static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
+static void mmc_blk_issue_rw_rq(struct mmc_queue_req *mq_rq)
 {
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+	struct mmc_queue *mq = mq_rq->mq;
 	struct mmc_card *card = mq->card;
-	struct mmc_queue_req *mqrq_cur = req_to_mmc_queue_req(new_req);
-	struct mmc_async_req *areq = &mqrq_cur->areq;
+	struct mmc_async_req *areq = &mq_rq->areq;
 
 	/*
 	 * If the card was removed, just cancel everything and return.
 	 */
 	if (mmc_card_removed(card)) {
-		new_req->rq_flags |= RQF_QUIET;
-		blk_end_request_all(new_req, BLK_STS_IOERR);
+		req->rq_flags |= RQF_QUIET;
+		blk_end_request_all(req, BLK_STS_IOERR);
 		return;
 	}
 
@@ -1968,22 +1972,23 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 	 * multiple read or write is allowed
 	 */
 	if (mmc_large_sector(card) &&
-	    !IS_ALIGNED(blk_rq_sectors(new_req), 8)) {
+	    !IS_ALIGNED(blk_rq_sectors(req), 8)) {
 		pr_err("%s: Transfer size is not 4KB sector size aligned\n",
-		       new_req->rq_disk->disk_name);
-		mmc_blk_rw_cmd_abort(mq, card, new_req, mqrq_cur);
+		       req->rq_disk->disk_name);
+		mmc_blk_rw_cmd_abort(mq_rq);
 		return;
 	}
 
-	mmc_blk_rw_rq_prep(mqrq_cur, card, 0, mq);
+	mmc_blk_rw_rq_prep(mq_rq, 0);
 	areq->report_done_status = mmc_blk_rw_done;
 	mmc_start_areq(card->host, areq);
 }
 
-void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq)
 {
 	int ret;
-	struct mmc_blk_data *md = mq->blkdata;
+	struct request *req = mmc_queue_req_to_req(mq_rq);
+	struct mmc_blk_data *md = mq_rq->mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 
 	if (!req) {
@@ -2005,7 +2010,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		 * ioctl()s
 		 */
 		mmc_wait_for_areq(card->host);
-		mmc_blk_issue_drv_op(mq, req);
+		mmc_blk_issue_drv_op(mq_rq);
 		break;
 	case REQ_OP_DISCARD:
 		/*
@@ -2013,7 +2018,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		 * discard.
 		 */
 		mmc_wait_for_areq(card->host);
-		mmc_blk_issue_discard_rq(mq, req);
+		mmc_blk_issue_discard_rq(mq_rq);
 		break;
 	case REQ_OP_SECURE_ERASE:
 		/*
@@ -2021,7 +2026,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		 * secure erase.
 		 */
 		mmc_wait_for_areq(card->host);
-		mmc_blk_issue_secdiscard_rq(mq, req);
+		mmc_blk_issue_secdiscard_rq(mq_rq);
 		break;
 	case REQ_OP_FLUSH:
 		/*
@@ -2029,11 +2034,11 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		 * flush.
 		 */
 		mmc_wait_for_areq(card->host);
-		mmc_blk_issue_flush(mq, req);
+		mmc_blk_issue_flush(mq_rq);
 		break;
 	default:
 		/* Normal request, just issue it */
-		mmc_blk_issue_rw_rq(mq, req);
+		mmc_blk_issue_rw_rq(mq_rq);
 		break;
 	}
 }
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..bbc1c8029b3b 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -1,9 +1,8 @@
 #ifndef _MMC_CORE_BLOCK_H
 #define _MMC_CORE_BLOCK_H
 
-struct mmc_queue;
-struct request;
+struct mmc_queue_req;
 
-void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
+void mmc_blk_issue_rq(struct mmc_queue_req *mq_rq);
 
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cf43a2d5410d..5511e323db31 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -62,7 +62,7 @@ static int mmc_queue_thread(void *d)
 				claimed_card = true;
 			}
 			set_current_state(TASK_RUNNING);
-			mmc_blk_issue_rq(mq, req);
+			mmc_blk_issue_rq(req_to_mmc_queue_req(req));
 			cond_resched();
 		} else {
 			mq->asleep = true;
-- 
2.13.6
