Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757998AbdJMLTX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 07:19:23 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V11 2/4] mmc: block: Add CQE and blk-mq support
Date: Fri, 13 Oct 2017 14:12:17 +0300
Message-Id: <1507893139-11969-3-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1507893139-11969-1-git-send-email-adrian.hunter@intel.com>
References: <1507893139-11969-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add CQE support to the block driver, including:
    - optionally using DCMD for flush requests
    - "manually" issuing discard requests
    - issuing read / write requests to the CQE
    - supporting block-layer timeouts
    - handling recovery
    - supporting re-tuning

CQE offers 25% - 50% better random multi-threaded I/O.  There is a slight
(e.g. 2%) drop in sequential read speed but no observable change to sequential
write.

CQE automatically sends the commands to complete requests.  However it only
supports reads / writes and so-called "direct commands" (DCMD).  Furthermore
DCMD is limited to one command at a time, but discards require 3 commands.
That makes issuing discards through CQE very awkward, but some CQE's don't
support DCMD anyway.  So for discards, the existing non-CQE approach is
taken, where the mmc core code issues the 3 commands one at a time i.e.
mmc_erase(). Where DCMD is used, is for issuing flushes.

For host controllers without CQE support, blk-mq support is extended to
asynchonous reads/writes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 801 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/block.h |  12 +
 drivers/mmc/core/queue.c | 426 +++++++++++++++++++++++--
 drivers/mmc/core/queue.h |  61 ++++
 include/linux/mmc/host.h |   1 +
 5 files changed, 1271 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4cd7f9..5a1fa678667b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -112,6 +112,7 @@ struct mmc_blk_data {
 #define MMC_BLK_WRITE		BIT(1)
 #define MMC_BLK_DISCARD		BIT(2)
 #define MMC_BLK_SECDISCARD	BIT(3)
+#define MMC_BLK_CQE_RECOVERY	BIT(4)
 
 	/*
 	 * Only set in main mmc_blk_data associated
@@ -1264,7 +1265,10 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 		break;
 	}
 	mq_rq->drv_op_result = ret;
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	if (req->mq_ctx)
+		blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	else
+		blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
@@ -1307,7 +1311,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	else
 		mmc_blk_reset_success(md, type);
 fail:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	if (req->mq_ctx)
+		blk_mq_end_request(req, status);
+	else
+		blk_end_request(req, status, blk_rq_bytes(req));
 }
 
 static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
@@ -1377,7 +1384,10 @@ static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	if (!err)
 		mmc_blk_reset_success(md, type);
 out:
-	blk_end_request(req, status, blk_rq_bytes(req));
+	if (req->mq_ctx)
+		blk_mq_end_request(req, status);
+	else
+		blk_end_request(req, status, blk_rq_bytes(req));
 }
 
 static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
@@ -1387,7 +1397,10 @@ static void mmc_blk_issue_flush(struct mmc_queue *mq, struct request *req)
 	int ret = 0;
 
 	ret = mmc_flush_cache(card);
-	blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	if (req->mq_ctx)
+		blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
+	else
+		blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
 }
 
 /*
@@ -1413,15 +1426,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	}
 }
 
-#define CMD_ERRORS							\
-	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
-	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
+#define CMD_ERRORS_EXCL_OOR						\
+	(R1_ADDRESS_ERROR |	/* Misaligned address */		\
 	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
 	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
 	 R1_CARD_ECC_FAILED |	/* Card ECC failed */			\
 	 R1_CC_ERROR |		/* Card controller error */		\
 	 R1_ERROR)		/* General/unknown error */
 
+#define CMD_ERRORS							\
+	(CMD_ERRORS_EXCL_OOR |						\
+	 R1_OUT_OF_RANGE)	/* Command argument out of range */	\
+
 static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
 {
 	u32 val;
@@ -1698,6 +1714,138 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 		*do_data_tag_p = do_data_tag;
 }
 
+#define MMC_CQE_RETRIES 2
+
+static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct request_queue *q = req->q;
+	struct mmc_host *host = mq->card->host;
+	unsigned long flags;
+	bool put_card;
+	int err;
+
+	mmc_cqe_post_req(host, mrq);
+
+	if (mrq->cmd && mrq->cmd->error)
+		err = mrq->cmd->error;
+	else if (mrq->data && mrq->data->error)
+		err = mrq->data->error;
+	else
+		err = 0;
+
+	if (err) {
+		if (mqrq->retries++ < MMC_CQE_RETRIES)
+			blk_mq_requeue_request(req, true);
+		else
+			blk_mq_end_request(req, BLK_STS_IOERR);
+	} else if (mrq->data) {
+		if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
+			blk_mq_requeue_request(req, true);
+		else
+			__blk_mq_end_request(req, BLK_STS_OK);
+	} else {
+		blk_mq_end_request(req, BLK_STS_OK);
+	}
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+
+	put_card = mmc_tot_in_flight(mq) == 0;
+
+	mmc_cqe_check_busy(mq);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	if (!mq->cqe_busy)
+		blk_mq_run_hw_queues(q, true);
+
+	if (put_card)
+		mmc_put_card(mq->card, &mq->ctx);
+}
+
+void mmc_blk_cqe_recovery(struct mmc_queue *mq)
+{
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	int err;
+
+	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
+
+	err = mmc_cqe_recovery(host);
+	if (err)
+		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
+	else
+		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+
+	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
+}
+
+static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (mq->in_recovery)
+		mmc_blk_cqe_complete_rq(mq, req);
+	else
+		blk_mq_complete_request(req);
+}
+
+static int mmc_blk_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
+{
+	mrq->done		= mmc_blk_cqe_req_done;
+	mrq->recovery_notifier	= mmc_cqe_recovery_notifier;
+
+	return mmc_cqe_start_req(host, mrq);
+}
+
+static struct mmc_request *mmc_blk_cqe_prep_dcmd(struct mmc_queue_req *mqrq,
+						 struct request *req)
+{
+	struct mmc_blk_request *brq = &mqrq->brq;
+
+	memset(brq, 0, sizeof(*brq));
+
+	brq->mrq.cmd = &brq->cmd;
+	brq->mrq.tag = req->tag;
+
+	return &brq->mrq;
+}
+
+static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
+
+	mrq->cmd->opcode = MMC_SWITCH;
+	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(EXT_CSD_FLUSH_CACHE << 16) |
+			(1 << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
+	mrq->cmd->flags = MMC_CMD_AC | MMC_RSP_R1B;
+
+	return mmc_blk_cqe_start_req(mq->card->host, mrq);
+}
+
+static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+
+	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
+
+	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
+}
+
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_card *card,
 			       int disable_multi,
@@ -1766,6 +1914,645 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	mqrq->areq.err_check = mmc_blk_err_check;
 }
 
+#define MMC_MAX_RETRIES		5
+#define MMC_DATA_RETRIES	2
+#define MMC_NO_RETRIES		(MMC_MAX_RETRIES + 1)
+
+/* Single sector read during recovery */
+static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	blk_status_t status;
+
+	while (1) {
+		mmc_blk_rw_rq_prep(mqrq, mq->card, 1, mq);
+
+		mmc_wait_for_req(mq->card->host, &mqrq->brq.mrq);
+
+		/*
+		 * Not expecting command errors, so just give up in that case.
+		 * If there are retries remaining, the request will get
+		 * requeued.
+		 */
+		if (mqrq->brq.cmd.error)
+			return;
+
+		if (blk_rq_bytes(req) <= 512)
+			break;
+
+		status = mqrq->brq.data.error ? BLK_STS_IOERR : BLK_STS_OK;
+
+		blk_update_request(req, status, 512);
+	}
+
+	mqrq->retries = MMC_NO_RETRIES;
+}
+
+static inline bool mmc_blk_oor_valid(struct mmc_blk_request *brq)
+{
+	return !!brq->mrq.sbc;
+}
+
+static inline u32 mmc_blk_stop_err_bits(struct mmc_blk_request *brq)
+{
+	return mmc_blk_oor_valid(brq) ? CMD_ERRORS : CMD_ERRORS_EXCL_OOR;
+}
+
+static inline bool mmc_blk_in_tran_state(u32 status)
+{
+	/*
+	 * Some cards mishandle the status bits, so make sure to check both the
+	 * busy indication and the card state.
+	 */
+	return status & R1_READY_FOR_DATA &&
+	       (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
+}
+
+/*
+ * Check for errors the host controller driver might not have seen such as
+ * response mode errors or invalid card state.
+ */
+static bool mmc_blk_status_error(struct request *req, u32 status)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_blk_request *brq = &mqrq->brq;
+	u32 stop_err_bits = mmc_blk_stop_err_bits(brq);
+
+	return brq->cmd.resp[0]  & CMD_ERRORS    ||
+	       brq->stop.resp[0] & stop_err_bits ||
+	       status            & stop_err_bits ||
+	       (rq_data_dir(req) == WRITE && !mmc_blk_in_tran_state(status));
+}
+
+static inline bool mmc_blk_cmd_started(struct mmc_blk_request *brq)
+{
+	return !brq->sbc.error && !brq->cmd.error &&
+	       !(brq->cmd.resp[0] & CMD_ERRORS);
+}
+
+static unsigned int mmc_blk_clock_khz(struct mmc_host *host)
+{
+	if (host->actual_clock)
+		return host->actual_clock / 1000;
+
+	/* Clock may be subject to a divisor, fudge it by a factor of 2. */
+	if (host->ios.clock)
+		return host->ios.clock / 2000;
+
+	/* How can there be no clock */
+	WARN_ON_ONCE(1);
+	return 100; /* 100 kHz is minimum possible value */
+}
+
+static unsigned long mmc_blk_data_timeout_jiffies(struct mmc_host *host,
+						  struct mmc_data *data)
+{
+	unsigned int ms = DIV_ROUND_UP(data->timeout_ns, 1000000);
+	unsigned int khz;
+
+	if (data->timeout_clks) {
+		khz = mmc_blk_clock_khz(host);
+		ms += DIV_ROUND_UP(data->timeout_clks, khz);
+	}
+
+	return msecs_to_jiffies(ms);
+}
+
+static int mmc_blk_card_stuck(struct mmc_card *card, struct request *req,
+			      u32 *resp_errs)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_data *data = &mqrq->brq.data;
+	unsigned long timeout;
+	u32 status;
+	int err;
+
+	timeout = jiffies + mmc_blk_data_timeout_jiffies(card->host, data);
+
+	while (1) {
+		bool done = time_after(jiffies, timeout);
+
+		err = __mmc_send_status(card, &status, 5);
+		if (err) {
+			pr_err("%s: error %d requesting status\n",
+			       req->rq_disk->disk_name, err);
+			break;
+		}
+
+		/* Accumulate any response error bits seen */
+		if (resp_errs)
+			*resp_errs |= status;
+
+		if (mmc_blk_in_tran_state(status))
+			break;
+
+		/* Timeout if the device never becomes ready */
+		if (done) {
+			pr_err("%s: Card stuck in wrong state! %s %s\n",
+				mmc_hostname(card->host),
+				req->rq_disk->disk_name, __func__);
+			err = -ETIMEDOUT;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int mmc_blk_send_stop(struct mmc_card *card)
+{
+	struct mmc_command cmd = {
+		.opcode = MMC_STOP_TRANSMISSION,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
+	};
+
+	return mmc_wait_for_cmd(card->host, &cmd, 5);
+}
+
+static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
+{
+	int err;
+
+	mmc_retune_hold_now(card->host);
+
+	mmc_blk_send_stop(card);
+
+	err = mmc_blk_card_stuck(card, req, NULL);
+
+	mmc_retune_release(card->host);
+
+	return err;
+}
+
+static void mmc_blk_rw_recovery(struct mmc_queue *mq, struct request *req)
+{
+	int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_blk_request *brq = &mqrq->brq;
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = mq->card;
+	u32 status;
+	u32 blocks;
+	int err;
+
+	/*
+	 * Status error bits might get lost during re-tuning so don't allow
+	 * re-tuning yet.
+	 */
+	mmc_retune_hold_now(card->host);
+
+	/*
+	 * Some errors the host driver might not have seen. Set the number of
+	 * bytes transferred to zero in that case.
+	 */
+	err = __mmc_send_status(card, &status, 0);
+	if (err || mmc_blk_status_error(req, status))
+		brq->data.bytes_xfered = 0;
+
+	mmc_retune_release(card->host);
+
+	/*
+	 * Try again to get the status. This also provides an opportunity for
+	 * re-tuning.
+	 */
+	if (err)
+		err = __mmc_send_status(card, &status, 0);
+
+	/*
+	 * Nothing more to do after the number of bytes transferred has been
+	 * updated and there is no card.
+	 */
+	if (err && mmc_detect_card_removed(card->host))
+		return;
+
+	/* Try to get back to "tran" state */
+	if (err || !mmc_blk_in_tran_state(status))
+		err = mmc_blk_fix_state(mq->card, req);
+
+	/*
+	 * Special case for SD cards where the card might record the number of
+	 * blocks written.
+	 */
+	if (!err && mmc_blk_cmd_started(brq) && mmc_card_sd(card) &&
+	    rq_data_dir(req) == WRITE && !mmc_sd_num_wr_blocks(card, &blocks))
+		brq->data.bytes_xfered = blocks << 9;
+
+	/* Reset if the card is in a bad state */
+	if (err && mmc_blk_reset(md, card->host, type)) {
+		pr_err("%s: recovery failed!\n", req->rq_disk->disk_name);
+		mqrq->retries = MMC_NO_RETRIES;
+		return;
+	}
+
+	/*
+	 * If anything was done, just return and if there is anything remaining
+	 * on the request it will get requeued.
+	 */
+	if (brq->data.bytes_xfered)
+		return;
+
+	/* Reset before last retry */
+	if (mqrq->retries + 1 == MMC_MAX_RETRIES)
+		mmc_blk_reset(md, card->host, type);
+
+	/* Command errors fail fast, so use all MMC_MAX_RETRIES */
+	if (brq->sbc.error || brq->cmd.error)
+		return;
+
+	/* Reduce the remaining retries for data errors */
+	if (mqrq->retries < MMC_MAX_RETRIES - MMC_DATA_RETRIES) {
+		mqrq->retries = MMC_MAX_RETRIES - MMC_DATA_RETRIES;
+		return;
+	}
+
+	/* FIXME: Missing single sector read for large sector size */
+	if (rq_data_dir(req) == READ && !mmc_large_sector(card)) {
+		/* Read one sector at a time */
+		mmc_blk_ss_read(mq, req);
+		return;
+	}
+}
+
+static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
+{
+	mmc_blk_eval_resp_error(brq);
+
+	return brq->sbc.error || brq->cmd.error || brq->stop.error ||
+	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
+}
+
+static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	u32 status = 0;
+	int err;
+
+	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
+		return 0;
+
+	mmc_retune_hold_now(card->host);
+
+	err = mmc_blk_card_stuck(card, req, &status);
+
+	mmc_retune_release(card->host);
+
+	/*
+	 * Do not assume data transferred correctly if there are any error bits
+	 * set.
+	 */
+	if (!err && status & mmc_blk_stop_err_bits(&mqrq->brq)) {
+		mqrq->brq.data.bytes_xfered = 0;
+		err = -EIO;
+	}
+
+	/* Copy the exception bit so it will be seen later on */
+	if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
+		mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
+
+	return err;
+}
+
+static inline void mmc_blk_rw_reset_success(struct mmc_queue *mq,
+					    struct request *req)
+{
+	int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
+
+	mmc_blk_reset_success(mq->blkdata, type);
+}
+
+static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	unsigned int nr_bytes = mqrq->brq.data.bytes_xfered;
+
+	if (nr_bytes) {
+		if (blk_update_request(req, BLK_STS_OK, nr_bytes))
+			blk_mq_requeue_request(req, true);
+		else
+			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
+		blk_mq_requeue_request(req, true);
+	} else {
+		if (mmc_card_removed(mq->card))
+			req->rq_flags |= RQF_QUIET;
+		blk_mq_end_request(req, BLK_STS_IOERR);
+	}
+}
+
+static bool mmc_blk_urgent_bkops_needed(struct mmc_queue *mq,
+					struct mmc_queue_req *mqrq)
+{
+	return mmc_card_mmc(mq->card) &&
+	       (mqrq->brq.cmd.resp[0] & R1_EXCEPTION_EVENT ||
+		mqrq->brq.stop.resp[0] & R1_EXCEPTION_EVENT);
+}
+
+static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
+				 struct mmc_queue_req *mqrq)
+{
+	if (mmc_blk_urgent_bkops_needed(mq, mqrq))
+		mmc_start_bkops(mq->card, true);
+}
+
+void mmc_blk_mq_complete(struct request *req)
+{
+	struct mmc_queue *mq = req->q->queuedata;
+
+	if (mq->use_cqe)
+		mmc_blk_cqe_complete_rq(mq, req);
+	else
+		mmc_blk_mq_complete_rq(mq, req);
+}
+
+static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
+				       struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+	bool failed;
+
+	failed = mmc_blk_rq_error(&mqrq->brq) ||
+		 mmc_blk_card_busy(mq->card, req);
+
+	if (!mmc_queue_direct_complete(host))
+		mmc_retune_release(host);
+
+	if (failed)
+		mmc_blk_rw_recovery(mq, req);
+	else
+		mmc_blk_rw_reset_success(mq, req);
+
+	mmc_blk_urgent_bkops(mq, mqrq);
+}
+
+static void mmc_blk_mq_acct_req_done(struct mmc_queue *mq, struct request *req)
+{
+	struct request_queue *q = req->q;
+	unsigned long flags;
+	bool put_card;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+
+	put_card = mmc_tot_in_flight(mq) == 0;
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	if (put_card)
+		mmc_put_card(mq->card, &mq->ctx);
+}
+
+static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct mmc_host *host = mq->card->host;
+
+	if (host->ops->post_req)
+		host->ops->post_req(host, mrq, 0);
+
+	/*
+	 * Block layer timeouts race with completions which means the normal
+	 * completion path cannot be used during recovery.
+	 */
+	if (mq->in_recovery)
+		mmc_blk_mq_complete_rq(mq, req);
+	else
+		blk_mq_complete_request(req);
+
+	mmc_blk_mq_acct_req_done(mq, req);
+}
+
+void mmc_blk_mq_recovery(struct mmc_queue *mq)
+{
+	struct request *req = mq->recovery_req;
+
+	mq->recovery_req = NULL;
+	mq->rw_wait = false;
+
+	mmc_blk_mq_poll_completion(mq, req);
+
+	mmc_blk_mq_post_req(mq, req);
+}
+
+static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
+					 struct request **prev_req)
+{
+	if (mmc_queue_direct_complete(mq->card->host))
+		return;
+
+	mutex_lock(&mq->complete_lock);
+
+	if (!mq->complete_req)
+		goto out_unlock;
+
+	mmc_blk_mq_poll_completion(mq, mq->complete_req);
+
+	if (prev_req)
+		*prev_req = mq->complete_req;
+	else
+		mmc_blk_mq_post_req(mq, mq->complete_req);
+
+	mq->complete_req = NULL;
+
+out_unlock:
+	mutex_unlock(&mq->complete_lock);
+}
+
+void mmc_blk_mq_complete_work(struct work_struct *work)
+{
+	struct mmc_queue *mq = container_of(work, struct mmc_queue,
+					    complete_work);
+
+	mmc_blk_mq_complete_prev_req(mq, NULL);
+}
+
+static void mmc_blk_mq_req_done(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	unsigned long flags;
+
+	if (mmc_blk_rq_error(&mqrq->brq) ||
+	    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
+		spin_lock_irqsave(q->queue_lock, flags);
+		mq->recovery_needed = true;
+		mq->recovery_req = req;
+		spin_unlock_irqrestore(q->queue_lock, flags);
+		wake_up(&mq->wait);
+		schedule_work(&mq->recovery_work);
+		return;
+	}
+
+	if (!mmc_queue_direct_complete(host)) {
+		bool waiting;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		mq->complete_req = req;
+		mq->rw_wait = false;
+		waiting = mq->waiting;
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		if (waiting)
+			wake_up(&mq->wait);
+		else
+			kblockd_schedule_work(&mq->complete_work);
+
+		return;
+	}
+
+	mmc_blk_rw_reset_success(mq, req);
+
+	mq->rw_wait = false;
+	wake_up(&mq->wait);
+
+	mmc_blk_mq_post_req(mq, req);
+}
+
+static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
+{
+	struct request_queue *q = mq->queue;
+	unsigned long flags;
+	bool done;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (mq->recovery_needed) {
+		*err = -EBUSY;
+		done = true;
+	} else {
+		done = !mq->rw_wait;
+	}
+	mq->waiting = !done;
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return done;
+}
+
+static int mmc_blk_rw_wait(struct mmc_queue *mq, struct request **prev_req)
+{
+	int err = 0;
+
+	wait_event(mq->wait, mmc_blk_rw_wait_cond(mq, &err));
+
+	mmc_blk_mq_complete_prev_req(mq, prev_req);
+
+	return err;
+}
+
+static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
+				  struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_host *host = mq->card->host;
+	struct request *prev_req = NULL;
+	int err = 0;
+
+	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
+
+	mqrq->brq.mrq.done = mmc_blk_mq_req_done;
+
+	if (host->ops->pre_req)
+		host->ops->pre_req(host, &mqrq->brq.mrq);
+
+	err = mmc_blk_rw_wait(mq, &prev_req);
+	if (err)
+		goto out_post_req;
+
+	mq->rw_wait = true;
+
+	err = mmc_start_request(host, &mqrq->brq.mrq);
+
+	if (prev_req)
+		mmc_blk_mq_post_req(mq, prev_req);
+
+	if (err)
+		mq->rw_wait = false;
+
+	/* Release re-tuning here where there is no synchronization required */
+	if (mmc_queue_direct_complete(host))
+		mmc_retune_release(host);
+
+out_post_req:
+	if (err && host->ops->post_req)
+		host->ops->post_req(host, &mqrq->brq.mrq, err);
+
+	return err;
+}
+
+static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
+{
+	if (mq->use_cqe)
+		return host->cqe_ops->cqe_wait_for_idle(host);
+
+	return mmc_blk_rw_wait(mq, NULL);
+}
+
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_blk_data *md = mq->blkdata;
+	struct mmc_card *card = md->queue.card;
+	struct mmc_host *host = card->host;
+	int ret;
+
+	ret = mmc_blk_part_switch(card, md->part_type);
+	if (ret)
+		return MMC_REQ_FAILED_TO_START;
+
+	switch (mmc_issue_type(mq, req)) {
+	case MMC_ISSUE_SYNC:
+		ret = mmc_blk_wait_for_idle(mq, host);
+		if (ret)
+			return MMC_REQ_BUSY;
+		switch (req_op(req)) {
+		case REQ_OP_DRV_IN:
+		case REQ_OP_DRV_OUT:
+			mmc_blk_issue_drv_op(mq, req);
+			break;
+		case REQ_OP_DISCARD:
+			mmc_blk_issue_discard_rq(mq, req);
+			break;
+		case REQ_OP_SECURE_ERASE:
+			mmc_blk_issue_secdiscard_rq(mq, req);
+			break;
+		case REQ_OP_FLUSH:
+			mmc_blk_issue_flush(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return MMC_REQ_FAILED_TO_START;
+		}
+		return MMC_REQ_FINISHED;
+	case MMC_ISSUE_DCMD:
+	case MMC_ISSUE_ASYNC:
+		switch (req_op(req)) {
+		case REQ_OP_FLUSH:
+			ret = mmc_blk_cqe_issue_flush(mq, req);
+			break;
+		case REQ_OP_READ:
+		case REQ_OP_WRITE:
+			if (mq->use_cqe)
+				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
+			else
+				ret = mmc_blk_mq_issue_rw_rq(mq, req);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			ret = -EINVAL;
+		}
+		if (!ret)
+			return MMC_REQ_STARTED;
+		return ret == -EBUSY ? MMC_REQ_BUSY : MMC_REQ_FAILED_TO_START;
+	default:
+		WARN_ON_ONCE(1);
+		return MMC_REQ_FAILED_TO_START;
+	}
+}
+
 static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			       struct mmc_blk_request *brq, struct request *req,
 			       bool old_req_pending)
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 860ca7c8df86..5ad22c1c0318 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -6,4 +6,16 @@
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
 
+void mmc_blk_cqe_recovery(struct mmc_queue *mq);
+
+enum mmc_issued;
+
+enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req);
+void mmc_blk_mq_complete(struct request *req);
+void mmc_blk_mq_recovery(struct mmc_queue *mq);
+
+struct work_struct;
+
+void mmc_blk_mq_complete_work(struct work_struct *work);
+
 #endif
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4f33d277b125..1879dc042227 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -22,6 +22,7 @@
 #include "block.h"
 #include "core.h"
 #include "card.h"
+#include "host.h"
 
 /*
  * Prepare a MMC request. This just filters out odd stuff.
@@ -34,10 +35,152 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 
 	req->rq_flags |= RQF_DONTPREP;
+	req_to_mmc_queue_req(req)->retries = 0;
 
 	return BLKPREP_OK;
 }
 
+static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
+{
+	/* Allow only 1 DCMD at a time */
+	return mq->in_flight[MMC_ISSUE_DCMD];
+}
+
+void mmc_cqe_check_busy(struct mmc_queue *mq)
+{
+	if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
+		mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
+
+	mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
+}
+
+static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
+{
+	return host->caps2 & MMC_CAP2_CQE_DCMD;
+}
+
+enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+				       struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+		return MMC_ISSUE_SYNC;
+	case REQ_OP_FLUSH:
+		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
+	default:
+		return MMC_ISSUE_ASYNC;
+	}
+}
+
+enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
+{
+	struct mmc_host *host = mq->card->host;
+
+	if (mq->use_cqe)
+		return mmc_cqe_issue_type(host, req);
+
+	if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
+		return MMC_ISSUE_ASYNC;
+
+	return MMC_ISSUE_SYNC;
+}
+
+static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
+{
+	if (!mq->recovery_needed) {
+		mq->recovery_needed = true;
+		schedule_work(&mq->recovery_work);
+	}
+}
+
+void mmc_cqe_recovery_notifier(struct mmc_request *mrq)
+{
+	struct mmc_queue_req *mqrq = container_of(mrq, struct mmc_queue_req,
+						  brq.mrq);
+	struct request *req = mmc_queue_req_to_req(mqrq);
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	__mmc_cqe_recovery_notifier(mq);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
+static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
+{
+	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
+	struct mmc_request *mrq = &mqrq->brq.mrq;
+	struct mmc_queue *mq = req->q->queuedata;
+	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
+	bool recovery_needed = false;
+
+	switch (issue_type) {
+	case MMC_ISSUE_ASYNC:
+	case MMC_ISSUE_DCMD:
+		if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
+			if (recovery_needed)
+				__mmc_cqe_recovery_notifier(mq);
+			return BLK_EH_RESET_TIMER;
+		}
+		/* No timeout */
+		return BLK_EH_HANDLED;
+	default:
+		/* Timeout is handled by mmc core */
+		return BLK_EH_RESET_TIMER;
+	}
+}
+
+static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
+						 bool reserved)
+{
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	if (mq->recovery_needed || !mq->use_cqe)
+		ret = BLK_EH_RESET_TIMER;
+	else
+		ret = mmc_cqe_timed_out(req);
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return ret;
+}
+
+static void mmc_mq_recovery_handler(struct work_struct *work)
+{
+	struct mmc_queue *mq = container_of(work, struct mmc_queue,
+					    recovery_work);
+	struct request_queue *q = mq->queue;
+
+	mmc_get_card(mq->card, &mq->ctx);
+
+	mq->in_recovery = true;
+
+	if (mq->use_cqe)
+		mmc_blk_cqe_recovery(mq);
+	else
+		mmc_blk_mq_recovery(mq);
+
+	mq->in_recovery = false;
+
+	spin_lock_irq(q->queue_lock);
+	mq->recovery_needed = false;
+	spin_unlock_irq(q->queue_lock);
+
+	mmc_put_card(mq->card, &mq->ctx);
+
+	blk_mq_run_hw_queues(q, true);
+}
+
 static int mmc_queue_thread(void *d)
 {
 	struct mmc_queue *mq = d;
@@ -154,11 +297,10 @@ static void mmc_queue_setup_discard(struct request_queue *q,
  * @req: the request
  * @gfp: memory allocation policy
  */
-static int mmc_init_request(struct request_queue *q, struct request *req,
-			    gfp_t gfp)
+static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
+			      gfp_t gfp)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
-	struct mmc_queue *mq = q->queuedata;
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
@@ -169,6 +311,12 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 	return 0;
 }
 
+static int mmc_init_request(struct request_queue *q, struct request *req,
+			    gfp_t gfp)
+{
+	return __mmc_init_request(q->queuedata, req, gfp);
+}
+
 static void mmc_exit_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
@@ -177,6 +325,124 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 	mq_rq->sg = NULL;
 }
 
+static int mmc_mq_init_request(struct blk_mq_tag_set *set, struct request *req,
+			       unsigned int hctx_idx, unsigned int numa_node)
+{
+	return __mmc_init_request(set->driver_data, req, GFP_KERNEL);
+}
+
+static void mmc_mq_exit_request(struct blk_mq_tag_set *set, struct request *req,
+				unsigned int hctx_idx)
+{
+	struct mmc_queue *mq = set->driver_data;
+
+	mmc_exit_request(mq->queue, req);
+}
+
+static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+	struct request_queue *q = req->q;
+	struct mmc_queue *mq = q->queuedata;
+	struct mmc_card *card = mq->card;
+	struct mmc_host *host = card->host;
+	enum mmc_issue_type issue_type;
+	enum mmc_issued issued;
+	bool get_card, cqe_retune_ok;
+	int ret;
+
+	if (mmc_card_removed(mq->card)) {
+		req->rq_flags |= RQF_QUIET;
+		return BLK_STS_IOERR;
+	}
+
+	issue_type = mmc_issue_type(mq, req);
+
+	spin_lock_irq(q->queue_lock);
+
+	if (mq->recovery_needed) {
+		spin_unlock_irq(q->queue_lock);
+		return BLK_STS_RESOURCE;
+	}
+
+	switch (issue_type) {
+	case MMC_ISSUE_DCMD:
+		if (mmc_cqe_dcmd_busy(mq)) {
+			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
+			spin_unlock_irq(q->queue_lock);
+			return BLK_STS_RESOURCE;
+		}
+		break;
+	case MMC_ISSUE_ASYNC:
+		break;
+	default:
+		/*
+		 * Timeouts are handled by mmc core, so set a large value to
+		 * avoid races.
+		 */
+		req->timeout = 600 * HZ;
+		break;
+	}
+
+	mq->in_flight[issue_type] += 1;
+	get_card = mmc_tot_in_flight(mq) == 1;
+	cqe_retune_ok = mmc_cqe_qcnt(mq) == 1;
+
+	spin_unlock_irq(q->queue_lock);
+
+	if (!(req->rq_flags & RQF_DONTPREP)) {
+		req_to_mmc_queue_req(req)->retries = 0;
+		req->rq_flags |= RQF_DONTPREP;
+	}
+
+	if (get_card)
+		mmc_get_card(card, &mq->ctx);
+
+	if (mq->use_cqe) {
+		host->retune_now = host->need_retune && cqe_retune_ok &&
+				   !host->hold_retune;
+	}
+
+	blk_mq_start_request(req);
+
+	issued = mmc_blk_mq_issue_rq(mq, req);
+
+	switch (issued) {
+	case MMC_REQ_BUSY:
+		ret = BLK_STS_RESOURCE;
+		break;
+	case MMC_REQ_FAILED_TO_START:
+		ret = BLK_STS_IOERR;
+		break;
+	default:
+		ret = BLK_STS_OK;
+		break;
+	}
+
+	if (issued != MMC_REQ_STARTED) {
+		bool put_card = false;
+
+		spin_lock_irq(q->queue_lock);
+		mq->in_flight[issue_type] -= 1;
+		if (mmc_tot_in_flight(mq) == 0)
+			put_card = true;
+		spin_unlock_irq(q->queue_lock);
+		if (put_card)
+			mmc_put_card(card, &mq->ctx);
+	}
+
+	return ret;
+}
+
+static const struct blk_mq_ops mmc_mq_cqe_ops = {
+	.queue_rq	= mmc_mq_queue_rq,
+	.init_request	= mmc_mq_init_request,
+	.exit_request	= mmc_mq_exit_request,
+	.complete	= mmc_blk_mq_complete,
+	.timeout	= mmc_mq_timed_out,
+};
+
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
@@ -198,6 +464,74 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 
 	/* Initialize thread_sem even if it is not used */
 	sema_init(&mq->thread_sem, 1);
+
+	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
+	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
+
+	mutex_init(&mq->complete_lock);
+
+	init_waitqueue_head(&mq->wait);
+}
+
+static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
+			     const struct blk_mq_ops *mq_ops, spinlock_t *lock)
+{
+	int ret;
+
+	memset(&mq->tag_set, 0, sizeof(mq->tag_set));
+	mq->tag_set.ops = mq_ops;
+	mq->tag_set.queue_depth = q_depth;
+	mq->tag_set.numa_node = NUMA_NO_NODE;
+	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
+			    BLK_MQ_F_BLOCKING;
+	mq->tag_set.nr_hw_queues = 1;
+	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
+	mq->tag_set.driver_data = mq;
+
+	ret = blk_mq_alloc_tag_set(&mq->tag_set);
+	if (ret)
+		return ret;
+
+	mq->queue = blk_mq_init_queue(&mq->tag_set);
+	if (IS_ERR(mq->queue)) {
+		ret = PTR_ERR(mq->queue);
+		goto free_tag_set;
+	}
+
+	mq->queue->queue_lock = lock;
+	mq->queue->queuedata = mq;
+
+	return 0;
+
+free_tag_set:
+	blk_mq_free_tag_set(&mq->tag_set);
+
+	return ret;
+}
+
+#define MMC_QUEUE_DEPTH 64
+
+static int mmc_mq_init(struct mmc_queue *mq, struct mmc_card *card,
+			 spinlock_t *lock)
+{
+	struct mmc_host *host = card->host;
+	int q_depth;
+	int ret;
+
+	if (mq->use_cqe)
+		q_depth = min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
+	else
+		q_depth = MMC_QUEUE_DEPTH;
+
+	ret = mmc_mq_init_queue(mq, q_depth, &mmc_mq_cqe_ops, lock);
+	if (ret)
+		return ret;
+
+	blk_queue_rq_timeout(mq->queue, 60 * HZ);
+
+	mmc_setup_queue(mq, card);
+
+	return 0;
 }
 
 /**
@@ -216,6 +550,12 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	int ret = -ENOMEM;
 
 	mq->card = card;
+
+	mq->use_cqe = host->cqe_enabled;
+
+	if (mq->use_cqe || mmc_host_use_blk_mq(host))
+		return mmc_mq_init(mq, card, lock);
+
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!mq->queue)
 		return -ENOMEM;
@@ -251,11 +591,63 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	return ret;
 }
 
+static void mmc_mq_queue_suspend(struct mmc_queue *mq)
+{
+	blk_mq_quiesce_queue(mq->queue);
+
+	/*
+	 * The host remains claimed while there are outstanding requests, so
+	 * simply claiming and releasing here ensures there are none.
+	 */
+	mmc_claim_host(mq->card->host);
+	mmc_release_host(mq->card->host);
+}
+
+static void mmc_mq_queue_resume(struct mmc_queue *mq)
+{
+	blk_mq_unquiesce_queue(mq->queue);
+}
+
+static void __mmc_queue_suspend(struct mmc_queue *mq)
+{
+	struct request_queue *q = mq->queue;
+	unsigned long flags;
+
+	if (!mq->suspended) {
+		mq->suspended |= true;
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		blk_stop_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+
+		down(&mq->thread_sem);
+	}
+}
+
+static void __mmc_queue_resume(struct mmc_queue *mq)
+{
+	struct request_queue *q = mq->queue;
+	unsigned long flags;
+
+	if (mq->suspended) {
+		mq->suspended = false;
+
+		up(&mq->thread_sem);
+
+		spin_lock_irqsave(q->queue_lock, flags);
+		blk_start_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	}
+}
+
 void mmc_cleanup_queue(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
 	unsigned long flags;
 
+	if (q->mq_ops)
+		return;
+
 	/* Make sure the queue isn't suspended, as that will deadlock */
 	mmc_queue_resume(mq);
 
@@ -283,17 +675,11 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 void mmc_queue_suspend(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
-
-	if (!mq->suspended) {
-		mq->suspended |= true;
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_stop_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		down(&mq->thread_sem);
-	}
+	if (q->mq_ops)
+		mmc_mq_queue_suspend(mq);
+	else
+		__mmc_queue_suspend(mq);
 }
 
 /**
@@ -303,17 +689,11 @@ void mmc_queue_suspend(struct mmc_queue *mq)
 void mmc_queue_resume(struct mmc_queue *mq)
 {
 	struct request_queue *q = mq->queue;
-	unsigned long flags;
-
-	if (mq->suspended) {
-		mq->suspended = false;
 
-		up(&mq->thread_sem);
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_start_queue(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
+	if (q->mq_ops)
+		mmc_mq_queue_resume(mq);
+	else
+		__mmc_queue_resume(mq);
 }
 
 /*
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 68f68ecd94ea..373930a2c1c0 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -7,6 +7,20 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
+enum mmc_issued {
+	MMC_REQ_STARTED,
+	MMC_REQ_BUSY,
+	MMC_REQ_FAILED_TO_START,
+	MMC_REQ_FINISHED,
+};
+
+enum mmc_issue_type {
+	MMC_ISSUE_SYNC,
+	MMC_ISSUE_DCMD,
+	MMC_ISSUE_ASYNC,
+	MMC_ISSUE_MAX,
+};
+
 static inline struct mmc_queue_req *req_to_mmc_queue_req(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
@@ -56,12 +70,15 @@ struct mmc_queue_req {
 	int			drv_op_result;
 	void			*drv_op_data;
 	unsigned int		ioc_count;
+	int			retries;
 };
 
 struct mmc_queue {
 	struct mmc_card		*card;
 	struct task_struct	*thread;
 	struct semaphore	thread_sem;
+	struct mmc_ctx		ctx;
+	struct blk_mq_tag_set	tag_set;
 	bool			suspended;
 	bool			asleep;
 	struct mmc_blk_data	*blkdata;
@@ -73,6 +90,22 @@ struct mmc_queue {
 	 * associated mmc_queue_req data.
 	 */
 	int			qcnt;
+
+	int			in_flight[MMC_ISSUE_MAX];
+	unsigned int		cqe_busy;
+#define MMC_CQE_DCMD_BUSY	BIT(0)
+#define MMC_CQE_QUEUE_FULL	BIT(1)
+	bool			use_cqe;
+	bool			recovery_needed;
+	bool			in_recovery;
+	bool			rw_wait;
+	bool			waiting;
+	struct work_struct	recovery_work;
+	wait_queue_head_t	wait;
+	struct request		*recovery_req;
+	struct request		*complete_req;
+	struct mutex		complete_lock;
+	struct work_struct	complete_work;
 };
 
 extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
@@ -83,4 +116,32 @@ extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 				     struct mmc_queue_req *);
 
+void mmc_cqe_check_busy(struct mmc_queue *mq);
+void mmc_cqe_recovery_notifier(struct mmc_request *mrq);
+
+enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req);
+
+static inline int mmc_tot_in_flight(struct mmc_queue *mq)
+{
+	return mq->in_flight[MMC_ISSUE_SYNC] +
+	       mq->in_flight[MMC_ISSUE_DCMD] +
+	       mq->in_flight[MMC_ISSUE_ASYNC];
+}
+
+static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
+{
+	return mq->in_flight[MMC_ISSUE_DCMD] +
+	       mq->in_flight[MMC_ISSUE_ASYNC];
+}
+
+static inline bool mmc_queue_rw_async(struct mmc_host *host)
+{
+	return host->caps & MMC_CAP_WAIT_WHILE_BUSY;
+}
+
+static inline bool mmc_queue_direct_complete(struct mmc_host *host)
+{
+	return host->caps & MMC_CAP_DIRECT_COMPLETE;
+}
+
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9109265fe529..9aa6a1284125 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -324,6 +324,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_DIRECT_COMPLETE	(1 << 27)	/* RW reqs can be completed within mmc_request_done() */
 #define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
-- 
1.9.1
