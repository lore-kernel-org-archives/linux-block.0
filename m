Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52244 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760000AbdACRb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 12:31:27 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        baolin.wang@linaro.org, riteshh@codeaurora.org, arnd@arndb.de,
        zhang.chunyan@linaro.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH PoCv2 2/2] mmc-mq: initial blk-mq support
Date: Tue, 03 Jan 2017 18:30:18 +0100
Message-id: <1483464618-16133-3-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
References: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170103173125epcas1p1c49a71464988f28a620ded304efd1807@epcas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/mmc/core/block.c    | 104 ++++++++++++++++++++++++++++----------
 drivers/mmc/core/block.h    |   3 +-
 drivers/mmc/core/bus.c      |   3 +-
 drivers/mmc/core/core.c     | 120 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/mmc_test.c |  16 +++---
 drivers/mmc/core/queue.c    | 114 +++++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/queue.h    |   5 ++
 include/linux/mmc/core.h    |  12 +++++
 8 files changed, 327 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d87b613..38a4321 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
+#include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
@@ -131,9 +132,13 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 
 static void mmc_blk_requeue(struct request_queue *q, struct request *req)
 {
-	spin_lock_irq(q->queue_lock);
-	blk_requeue_request(q, req);
-	spin_unlock_irq(q->queue_lock);
+	if (mmc_use_blk_mq())
+		blk_mq_requeue_request(req, false);
+	else {
+		spin_lock_irq(q->queue_lock);
+		blk_requeue_request(q, req);
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
@@ -1150,7 +1155,8 @@ int mmc_access_rpmb(struct mmc_queue *mq)
 	return false;
 }
 
-static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req,
+				    struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1188,13 +1194,19 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		goto retry;
 	if (!err)
 		mmc_blk_reset_success(md, type);
-	blk_end_request(req, err, blk_rq_bytes(req));
+	if (mmc_use_blk_mq()) {
+		mmc_put_card(card);
+		mmc_queue_req_free(mq, mqrq);
+		blk_mq_end_request(req, err);
+	} else
+		blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
 
 static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
-				       struct request *req)
+				       struct request *req,
+				       struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1255,12 +1267,18 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	blk_end_request(req, err, blk_rq_bytes(req));
+	if (mmc_use_blk_mq()) {
+		mmc_put_card(card);
+		mmc_queue_req_free(mq, mqrq);
+		blk_mq_end_request(req, err);
+	} else
+		blk_end_request(req, err, blk_rq_bytes(req));
 
 	return err ? 0 : 1;
 }
 
-static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
+static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req,
+			       struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1270,7 +1288,12 @@ static int mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	if (ret)
 		ret = -EIO;
 
-	blk_end_request_all(req, ret);
+	if (mmc_use_blk_mq()) {
+		mmc_put_card(card);
+		mmc_queue_req_free(mq, mqrq);
+		blk_mq_end_request(req, ret);
+	} else
+		blk_end_request_all(req, ret);
 
 	return ret ? 0 : 1;
 }
@@ -1368,6 +1391,11 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
 			gen_err = true;
 		}
 
+		if (mmc_use_blk_mq()) {
+			mdelay(100);
+			pr_info("%s: mdelay(100)\n", __func__);
+			return MMC_BLK_SUCCESS;
+		}
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
 					&gen_err);
 		if (err)
@@ -1600,7 +1628,8 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 	return ret;
 }
 
-static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
+static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc,
+			       struct mmc_queue_req *mqrq)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
@@ -1612,7 +1641,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	struct request *req;
 	struct mmc_async_req *areq;
 
-	if (rqc) {
+	if (mmc_use_blk_mq())
+		mqrq_cur = mqrq;
+
+	if (!mmc_use_blk_mq() && rqc) {
 		mqrq_cur = mmc_queue_req_find(mq, rqc);
 		if (!mqrq_cur) {
 			WARN_ON(1);
@@ -1644,9 +1676,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 			areq = &mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
-		areq = mmc_start_req(card->host, areq, &status);
+		if (mmc_use_blk_mq())
+			areq = mmc_mq_start_req(card->host, areq,
+						&status, mqrq);
+		else
+			areq = mmc_start_req(card->host, areq, &status);
 		if (!areq)
 			return 0;
+		if (mmc_use_blk_mq())
+			goto out_mq;
 
 		mq_rq = container_of(areq, struct mmc_queue_req, mmc_active);
 		brq = &mq_rq->brq;
@@ -1745,6 +1783,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
 	mmc_queue_req_free(mq, mq_rq);
 
+ out_mq:
 	return 1;
 
  cmd_abort:
@@ -1772,20 +1811,33 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 	return 0;
 }
 
-int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
+int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req,
+		     struct mmc_queue_req *mqrq)
 {
 	int ret;
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
 
-	if (req && !mq->qcnt)
+	if (mmc_use_blk_mq()) {
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
+		blk_mq_start_request(req);
+	} else {
+		if (req && !mq->qcnt)
+			/* claim host only for the first request */
+			mmc_get_card(card);
+	}
+
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
-			blk_end_request_all(req, -EIO);
+			if (mmc_use_blk_mq()) {
+				mmc_put_card(card);
+				mmc_queue_req_free(req->q->queuedata, mqrq);
+				blk_mq_end_request(req, -EIO);
+			} else
+				blk_end_request_all(req, -EIO);
 		}
 		ret = 0;
 		goto out;
@@ -1793,26 +1845,26 @@ int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	if (req && req_op(req) == REQ_OP_DISCARD) {
 		/* complete ongoing async transfer before issuing discard */
-		if (mq->qcnt)
-			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_discard_rq(mq, req);
+		if (!mmc_use_blk_mq() && mq->qcnt)
+			mmc_blk_issue_rw_rq(mq, NULL, NULL);
+		ret = mmc_blk_issue_discard_rq(mq, req, mqrq);
 	} else if (req && req_op(req) == REQ_OP_SECURE_ERASE) {
 		/* complete ongoing async transfer before issuing secure erase*/
-		if (mq->qcnt)
-			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_secdiscard_rq(mq, req);
+		if (!mmc_use_blk_mq() && mq->qcnt)
+			mmc_blk_issue_rw_rq(mq, NULL, NULL);
+		ret = mmc_blk_issue_secdiscard_rq(mq, req, mqrq);
 	} else if (req && req_op(req) == REQ_OP_FLUSH) {
 		/* complete ongoing async transfer before issuing flush */
-		if (mq->qcnt)
-			mmc_blk_issue_rw_rq(mq, NULL);
-		ret = mmc_blk_issue_flush(mq, req);
+		if (!mmc_use_blk_mq() && mq->qcnt)
+			mmc_blk_issue_rw_rq(mq, NULL, NULL);
+		ret = mmc_blk_issue_flush(mq, req, mqrq);
 	} else {
-		ret = mmc_blk_issue_rw_rq(mq, req);
+		ret = mmc_blk_issue_rw_rq(mq, req, mqrq);
 	}
 
 out:
 	/* Release host when there are no more requests */
-	if (!mq->qcnt)
+	if (!mmc_use_blk_mq() && !mq->qcnt)
 		mmc_put_card(card);
 	return ret;
 }
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index cdabb2e..5a32a62 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -1 +1,2 @@
-int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
+int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req,
+		     struct mmc_queue_req *mqrq);
\ No newline at end of file
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index c64266f..485215c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -346,7 +346,8 @@ int mmc_add_card(struct mmc_card *card)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-	mmc_init_context_info(card->host);
+	if (!mmc_use_blk_mq())
+		mmc_init_context_info(card->host);
 
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1076b9d..a152941 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -29,6 +29,8 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/blk-mq.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -44,6 +46,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "queue.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -420,6 +423,78 @@ static void mmc_wait_done(struct mmc_request *mrq)
 	complete(&mrq->completion);
 }
 
+static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
+			 int err);
+
+/*
+ * mmc_wait_done() - done callback for request
+ * @mrq: done request
+ *
+ * Wakes up mmc context, passed as a callback to host controller driver
+ */
+static void mmc_mq_wait_done(struct mmc_request *mrq)
+{
+	struct mmc_host *host = mrq->host;
+	struct mmc_queue_req *mq_rq = mrq->mqrq;
+	struct mmc_async_req *areq = NULL;
+	struct mmc_command *cmd;
+	int err = 0, ret = 0;
+
+	cmd = mrq->cmd;
+
+	if (mq_rq)
+		areq = &mq_rq->mmc_active;
+
+	if (!cmd->error || !cmd->retries ||
+	    mmc_card_removed(host->card)) {
+		if (mq_rq &&
+		    mq_rq->req->cmd_type == REQ_TYPE_FS &&
+		    req_op(mq_rq->req) != REQ_OP_DISCARD &&
+		    req_op(mq_rq->req) != REQ_OP_FLUSH) {
+			err = areq->err_check(host->card, areq);
+			BUG_ON(err != MMC_BLK_SUCCESS);
+		}
+	} else {
+		mmc_retune_recheck(host);
+		pr_info("%s: req failed (CMD%u): %d, retrying...\n",
+			mmc_hostname(host),
+			cmd->opcode, cmd->error);
+		cmd->retries--;
+		cmd->error = 0;
+		__mmc_start_request(host, mrq);
+		return;
+	}
+
+	mmc_retune_release(host);
+
+	if (mq_rq &&
+	    mq_rq->req->cmd_type == REQ_TYPE_FS &&
+	     req_op(mq_rq->req) != REQ_OP_DISCARD &&
+	     req_op(mq_rq->req) != REQ_OP_FLUSH) {
+		mmc_post_req(host, mrq, 0);
+	}
+
+	complete(&mrq->completion);
+
+	if (mq_rq &&
+	    mq_rq->req->cmd_type == REQ_TYPE_FS &&
+	    req_op(mq_rq->req) != REQ_OP_DISCARD &&
+	    req_op(mq_rq->req) != REQ_OP_FLUSH) {
+		struct mmc_blk_request *brq = &mq_rq->brq;
+		struct request *req = mq_rq->req;
+		int bytes;
+
+		mmc_queue_bounce_post(mq_rq);
+
+		bytes = brq->data.bytes_xfered;
+		mmc_put_card(host->card);
+		mmc_queue_req_free(req->q->queuedata, mq_rq);
+		ret = blk_update_request(req, 0, bytes);
+		if (!ret)
+			__blk_mq_end_request(req, 0);
+	}
+}
+
 static inline void mmc_wait_ongoing_tfr_cmd(struct mmc_host *host)
 {
 	struct mmc_request *ongoing_mrq = READ_ONCE(host->ongoing_mrq);
@@ -463,14 +538,20 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
 	return err;
 }
 
-static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
+static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq,
+			   struct mmc_queue_req *mqrq)
 {
 	int err;
 
 	mmc_wait_ongoing_tfr_cmd(host);
 
 	init_completion(&mrq->completion);
-	mrq->done = mmc_wait_done;
+	if (mmc_use_blk_mq()) {
+		mrq->done = mmc_mq_wait_done;
+		mrq->host = host;
+		mrq->mqrq = mqrq;
+	} else
+		mrq->done = mmc_wait_done;
 
 	init_completion(&mrq->cmd_completion);
 
@@ -478,7 +559,10 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err) {
 		mrq->cmd->error = err;
 		mmc_complete_cmd(mrq);
-		complete(&mrq->completion);
+		if (mmc_use_blk_mq())
+			mmc_mq_wait_done(mrq);
+		else
+			complete(&mrq->completion);
 	}
 
 	return err;
@@ -591,7 +675,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
  */
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
-	if (host->areq)
+	if (!mmc_use_blk_mq() && host->areq)
 		return host->context_info.is_done_rcv;
 	else
 		return completion_done(&mrq->completion);
@@ -709,6 +793,24 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 }
 EXPORT_SYMBOL(mmc_start_req);
 
+struct mmc_async_req *mmc_mq_start_req(struct mmc_host *host,
+				       struct mmc_async_req *areq,
+				       enum mmc_blk_status *ret_stat,
+				       struct mmc_queue_req *mqrq)
+{
+	int start_err = 0;
+
+	mmc_pre_req(host, areq->mrq);
+
+	start_err = __mmc_start_req(host, areq->mrq, mqrq);
+
+	if (ret_stat)
+		*ret_stat = MMC_BLK_SUCCESS;
+
+	return areq;
+}
+EXPORT_SYMBOL(mmc_mq_start_req);
+
 /**
  *	mmc_wait_for_req - start a request and wait for completion
  *	@host: MMC host to start command
@@ -723,10 +825,14 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-	__mmc_start_req(host, mrq);
+	__mmc_start_req(host, mrq, NULL);
 
-	if (!mrq->cap_cmd_during_tfr)
-		mmc_wait_for_req_done(host, mrq);
+	if (!mrq->cap_cmd_during_tfr) {
+		if (mmc_use_blk_mq())
+			wait_for_completion(&mrq->completion);
+		else
+			mmc_wait_for_req_done(host, mrq);
+	}
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
 
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 3ab6e52..6d2b62a 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2436,12 +2436,16 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	} while (repeat_cmd && R1_CURRENT_STATE(status) != R1_STATE_TRAN);
 
 	/* Wait for data request to complete */
-	if (use_areq) {
-		mmc_start_req(host, NULL, &blkstat);
-		if (blkstat != MMC_BLK_SUCCESS)
-			ret = RESULT_FAIL;
-	} else {
-		mmc_wait_for_req_done(test->card->host, mrq);
+	if (mmc_use_blk_mq())
+		wait_for_completion(&mrq->completion);
+	else {
+		if (use_areq) {
+			mmc_start_req(host, NULL, &blkstat);
+			if (blkstat != MMC_BLK_SUCCESS)
+				ret = RESULT_FAIL;
+		} else {
+			mmc_wait_for_req_done(test->card->host, mrq);
+		}
 	}
 
 	/*
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 6284101..5e7e515 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -9,6 +9,7 @@
  */
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 #include <linux/blkdev.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
@@ -47,6 +48,21 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 	return BLKPREP_OK;
 }
 
+static int mmc_mq_queue_ready(struct request_queue *q, struct mmc_queue *mq)
+{
+	unsigned int busy;
+
+	busy = atomic_inc_return(&mq->device_busy) - 1;
+
+	if (busy >= mq->qdepth)
+		goto out_dec;
+
+	return 1;
+out_dec:
+	atomic_dec(&mq->device_busy);
+	return 0;
+}
+
 struct mmc_queue_req *mmc_queue_req_find(struct mmc_queue *mq,
 					 struct request *req)
 {
@@ -74,6 +90,8 @@ void mmc_queue_req_free(struct mmc_queue *mq,
 	mqrq->req = NULL;
 	mq->qcnt -= 1;
 	__clear_bit(mqrq->task_id, &mq->qslots);
+	if (mmc_use_blk_mq())
+		atomic_dec(&mq->device_busy);
 }
 
 static int mmc_queue_thread(void *d)
@@ -108,7 +126,7 @@ static int mmc_queue_thread(void *d)
 
 		if (req || mq->qcnt) {
 			set_current_state(TASK_RUNNING);
-			mmc_blk_issue_rq(mq, req);
+			mmc_blk_issue_rq(mq, req, NULL);
 			cond_resched();
 		} else {
 			if (kthread_should_stop()) {
@@ -282,6 +300,44 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
 	return mqrq;
 }
 
+static int mmc_init_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx,
+		unsigned int numa_node)
+{
+	return 0;
+}
+
+static void mmc_exit_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx)
+{
+}
+
+static int mmc_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_queue_req *mqrq_cur;
+
+	WARN_ON(req && req->cmd_type != REQ_TYPE_FS);
+
+	if (!mmc_mq_queue_ready(q, mq))
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
+	mqrq_cur = mmc_queue_req_find(mq, req);
+	BUG_ON(!mqrq_cur);
+	mmc_blk_issue_rq(mq, req, mqrq_cur);
+
+	return BLK_MQ_RQ_QUEUE_OK;
+}
+
+static struct blk_mq_ops mmc_mq_ops = {
+	.queue_rq	= mmc_queue_rq,
+	.init_request	= mmc_init_request,
+	.exit_request	= mmc_exit_request,
+};
+
 /**
  * mmc_init_queue - initialise a queue structure.
  * @mq: mmc queue
@@ -295,6 +351,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		   spinlock_t *lock, const char *subname)
 {
 	struct mmc_host *host = card->host;
+	struct request_queue *q;
 	u64 limit = BLK_BOUNCE_HIGH;
 	bool bounce = false;
 	int ret = -ENOMEM;
@@ -303,11 +360,36 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	mq->card = card;
-	mq->queue = blk_init_queue(mmc_request_fn, lock);
-	if (!mq->queue)
-		return -ENOMEM;
+	if (!mmc_use_blk_mq()) {
+		mq->queue = blk_init_queue(mmc_request_fn, lock);
+		if (!mq->queue)
+			return -ENOMEM;
+
+		mq->qdepth = 2;
+	} else {
+		memset(&mq->tag_set, 0, sizeof(mq->tag_set));
+		mq->tag_set.ops = &mmc_mq_ops;
+		mq->tag_set.queue_depth = 1;
+		mq->tag_set.numa_node = NUMA_NO_NODE;
+		mq->tag_set.flags =
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+		mq->tag_set.nr_hw_queues = 1;
+		mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+
+		ret = blk_mq_alloc_tag_set(&mq->tag_set);
+		if (ret)
+			goto out;
+
+		q = blk_mq_init_queue(&mq->tag_set);
+		if (IS_ERR(q)) {
+			ret = PTR_ERR(q);
+			goto cleanup_tag_set;
+		}
+		mq->queue = q;
+
+		mq->qdepth = 1;
+	}
 
-	mq->qdepth = 2;
 	mq->mqrq = mmc_queue_alloc_mqrqs(mq->qdepth);
 	if (!mq->mqrq)
 		goto blk_cleanup;
@@ -359,6 +441,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 			goto cleanup_queue;
 	}
 
+	if (mmc_use_blk_mq())
+		return 0;
+
 	sema_init(&mq->thread_sem, 1);
 
 	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
@@ -377,6 +462,10 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->mqrq = NULL;
 blk_cleanup:
 	blk_cleanup_queue(mq->queue);
+cleanup_tag_set:
+	if (mmc_use_blk_mq())
+		blk_mq_free_tag_set(&mq->tag_set);
+out:
 	return ret;
 }
 
@@ -388,8 +477,10 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
-	/* Then terminate our worker thread */
-	kthread_stop(mq->thread);
+	if (!mmc_use_blk_mq()) {
+		/* Then terminate our worker thread */
+		kthread_stop(mq->thread);
+	}
 
 	/* Empty the queue */
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -401,6 +492,9 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	kfree(mq->mqrq);
 	mq->mqrq = NULL;
 
+	if (mmc_use_blk_mq())
+		blk_mq_free_tag_set(&mq->tag_set);
+
 	mq->card = NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);
@@ -425,7 +519,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 		blk_stop_queue(q);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		down(&mq->thread_sem);
+		if (!mmc_use_blk_mq())
+			down(&mq->thread_sem);
 	}
 }
 
@@ -441,7 +536,8 @@ void mmc_queue_resume(struct mmc_queue *mq)
 	if (mq->flags & MMC_QUEUE_SUSPENDED) {
 		mq->flags &= ~MMC_QUEUE_SUSPENDED;
 
-		up(&mq->thread_sem);
+		if (!mmc_use_blk_mq())
+			up(&mq->thread_sem);
 
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_start_queue(q);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 95ca330..732007e 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -46,6 +46,11 @@ struct mmc_queue {
 	int			qdepth;
 	int			qcnt;
 	unsigned long		qslots;
+
+	atomic_t		device_busy;
+
+	/* Block layer tags. */
+	struct blk_mq_tag_set	tag_set;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index e33cc74..9cb2195 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -141,6 +141,7 @@ struct mmc_data {
 };
 
 struct mmc_host;
+struct mmc_queue_req;
 struct mmc_request {
 	struct mmc_command	*sbc;		/* SET_BLOCK_COUNT for multiblock */
 	struct mmc_command	*cmd;
@@ -154,6 +155,8 @@ struct mmc_request {
 
 	/* Allow other commands during this ongoing data transfer or busy wait */
 	bool			cap_cmd_during_tfr;
+
+	struct mmc_queue_req	*mqrq;
 };
 
 struct mmc_card;
@@ -164,6 +167,10 @@ struct mmc_request {
 extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
 					   struct mmc_async_req *,
 					   enum mmc_blk_status *);
+extern struct mmc_async_req *mmc_mq_start_req(struct mmc_host *,
+					   struct mmc_async_req *,
+					   enum mmc_blk_status *,
+					   struct mmc_queue_req *);
 extern int mmc_interrupt_hpi(struct mmc_card *);
 extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
 extern void mmc_wait_for_req_done(struct mmc_host *host,
@@ -234,4 +241,9 @@ static inline void mmc_claim_host(struct mmc_host *host)
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
+static inline bool mmc_use_blk_mq(void)
+{
+	return 1;
+}
+
 #endif /* LINUX_MMC_CORE_H */
-- 
1.9.1

