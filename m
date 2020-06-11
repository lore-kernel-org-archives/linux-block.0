Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF99C433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C520812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kE7WSm3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFKGpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E6C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rSYI7M7fVSVtrbKxYHd7+I0EiDZfAoh+NuRzq7bbVQQ=; b=kE7WSm3PyIQpuM8pfiwSls/Pf6
        WXVHiXLCMCDifmLxyC/A9HQX1RlKUau1+P99+tBPNGRX9cpi9d7moP3yo/pPCCYIXut7OPh0+5Ju8
        avI4Mm3nEETDQpUYmckYG/v6ypALxrdjC4uUC7wC8WWJjHL4GCLlwpNHCYnlOrukDg4gr3aNIPxiZ
        X/w7kzGDF+uQd2QV6FJlPWXKfDm/pFS9zT4rt0UtZe5a2famwpd3zPUMW7S//+k1cL+GmsHsdwF27
        W4wiGDrV2xsSoa9dJ+XQkzIdp8daQQz8D3XReXkk2mJKM64aQYq9bGBz4kH+j7dxJlfSusppjxtBE
        CJn59Nxg==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxe-0007NJ-Ut; Thu, 11 Jun 2020 06:45:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 07/12] blk-mq: move failure injection out of blk_mq_complete_request
Date:   Thu, 11 Jun 2020 08:44:47 +0200
Message-Id: <20200611064452.12353-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the call to blk_should_fake_timeout out of blk_mq_complete_request
and into the drivers, skipping call sites that are obvious error
handlers, and remove the now superflous blk_mq_force_complete_rq helper.
This ensures we don't keep injecting errors into completions that just
terminate the Linux request after the hardware has been reset or the
command has been aborted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c                    | 34 +++++++------------------------
 block/blk-timeout.c               |  6 ++----
 block/blk.h                       |  9 --------
 block/bsg-lib.c                   |  5 ++++-
 drivers/block/loop.c              |  6 ++++--
 drivers/block/mtip32xx/mtip32xx.c |  3 ++-
 drivers/block/nbd.c               |  5 ++++-
 drivers/block/null_blk_main.c     |  5 +++--
 drivers/block/skd_main.c          |  9 +++++---
 drivers/block/virtio_blk.c        |  3 ++-
 drivers/block/xen-blkfront.c      |  3 ++-
 drivers/md/dm-rq.c                |  3 ++-
 drivers/mmc/core/block.c          |  8 ++++----
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/host/nvme.h          |  3 ++-
 drivers/s390/block/dasd.c         |  2 +-
 drivers/s390/block/scm_blk.c      |  3 ++-
 drivers/scsi/scsi_lib.c           | 12 +++--------
 include/linux/blk-mq.h            | 12 +++++++++--
 19 files changed, 61 insertions(+), 72 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11c706a9942043..b73b193809097b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -655,16 +655,13 @@ static void __blk_mq_complete_request_remote(void *data)
 }
 
 /**
- * blk_mq_force_complete_rq() - Force complete the request, bypassing any error
- * 				injection that could drop the completion.
- * @rq: Request to be force completed
+ * blk_mq_complete_request - end I/O on a request
+ * @rq:		the request being processed
  *
- * Drivers should use blk_mq_complete_request() to complete requests in their
- * normal IO path. For timeout error recovery, drivers may call this forced
- * completion routine after they've reclaimed timed out requests to bypass
- * potentially subsequent fake timeouts.
- */
-void blk_mq_force_complete_rq(struct request *rq)
+ * Description:
+ *	Complete a request by scheduling the ->complete_rq operation.
+ **/
+void blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -702,7 +699,7 @@ void blk_mq_force_complete_rq(struct request *rq)
 	}
 	put_cpu();
 }
-EXPORT_SYMBOL_GPL(blk_mq_force_complete_rq);
+EXPORT_SYMBOL(blk_mq_complete_request);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -724,23 +721,6 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
 		*srcu_idx = srcu_read_lock(hctx->srcu);
 }
 
-/**
- * blk_mq_complete_request - end I/O on a request
- * @rq:		the request being processed
- *
- * Description:
- *	Ends all I/O on a request. It does not handle partial completions.
- *	The actual completion happens out-of-order, through a IPI handler.
- **/
-bool blk_mq_complete_request(struct request *rq)
-{
-	if (unlikely(blk_should_fake_timeout(rq->q)))
-		return false;
-	blk_mq_force_complete_rq(rq);
-	return true;
-}
-EXPORT_SYMBOL(blk_mq_complete_request);
-
 /**
  * blk_mq_start_request - Start processing a request
  * @rq: Pointer to request to be started
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 8aa68fae96ad8d..3a1ac64347588d 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -20,13 +20,11 @@ static int __init setup_fail_io_timeout(char *str)
 }
 __setup("fail_io_timeout=", setup_fail_io_timeout);
 
-int blk_should_fake_timeout(struct request_queue *q)
+bool __blk_should_fake_timeout(struct request_queue *q)
 {
-	if (!test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags))
-		return 0;
-
 	return should_fail(&fail_io_timeout, 1);
 }
+EXPORT_SYMBOL_GPL(__blk_should_fake_timeout);
 
 static int __init fail_io_timeout_debugfs(void)
 {
diff --git a/block/blk.h b/block/blk.h
index aa16e524dc35e0..220220d868eac6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -223,18 +223,9 @@ ssize_t part_fail_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
 ssize_t part_fail_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count);
-
-#ifdef CONFIG_FAIL_IO_TIMEOUT
-int blk_should_fake_timeout(struct request_queue *);
 ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
-#else
-static inline int blk_should_fake_timeout(struct request_queue *q)
-{
-	return 0;
-}
-#endif
 
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		unsigned int *nr_segs);
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 6cbb7926534cd7..fb7b347f80105b 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -181,9 +181,12 @@ EXPORT_SYMBOL_GPL(bsg_job_get);
 void bsg_job_done(struct bsg_job *job, int result,
 		  unsigned int reply_payload_rcv_len)
 {
+	struct request *rq = blk_mq_rq_from_pdu(job);
+
 	job->result = result;
 	job->reply_payload_rcv_len = reply_payload_rcv_len;
-	blk_mq_complete_request(blk_mq_rq_from_pdu(job));
+	if (likely(!blk_should_fake_timeout(rq->q)))
+		blk_mq_complete_request(rq);
 }
 EXPORT_SYMBOL_GPL(bsg_job_done);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2e96d8b8758b63..c5b659a27cc354 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -509,7 +509,8 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
-	blk_mq_complete_request(rq);
+	if (likely(!blk_should_fake_timeout(rq->q)))
+		blk_mq_complete_request(rq);
 }
 
 static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
@@ -2048,7 +2049,8 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 			cmd->ret = ret;
 		else
 			cmd->ret = ret ? -EIO : 0;
-		blk_mq_complete_request(rq);
+		if (likely(!blk_should_fake_timeout(rq->q)))
+			blk_mq_complete_request(rq);
 	}
 }
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f6bafa9a68b9df..153e2cdecb4d40 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -492,7 +492,8 @@ static void mtip_complete_command(struct mtip_cmd *cmd, blk_status_t status)
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 
 	cmd->status = status;
-	blk_mq_complete_request(req);
+	if (likely(!blk_should_fake_timeout(req->q)))
+		blk_mq_complete_request(req);
 }
 
 /*
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a675d..01794cd2b6cae4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -784,6 +784,7 @@ static void recv_work(struct work_struct *work)
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
 	struct nbd_cmd *cmd;
+	struct request *rq;
 
 	while (1) {
 		cmd = nbd_read_stat(nbd, args->index);
@@ -796,7 +797,9 @@ static void recv_work(struct work_struct *work)
 			break;
 		}
 
-		blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
+		rq = blk_mq_rq_from_pdu(cmd);
+		if (likely(!blk_should_fake_timeout(rq->q)))
+			blk_mq_complete_request(rq);
 	}
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362ee..82259242b9b5c9 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1283,7 +1283,8 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 	case NULL_IRQ_SOFTIRQ:
 		switch (cmd->nq->dev->queue_mode) {
 		case NULL_Q_MQ:
-			blk_mq_complete_request(cmd->rq);
+			if (likely(!blk_should_fake_timeout(cmd->rq->q)))
+				blk_mq_complete_request(cmd->rq);
 			break;
 		case NULL_Q_BIO:
 			/*
@@ -1423,7 +1424,7 @@ static bool should_requeue_request(struct request *rq)
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("rq %p timed out\n", rq);
-	blk_mq_force_complete_rq(rq);
+	blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 51569c199a6cc9..3a476dc1d14f57 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1417,7 +1417,8 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 	case SKD_CHECK_STATUS_REPORT_GOOD:
 	case SKD_CHECK_STATUS_REPORT_SMART_ALERT:
 		skreq->status = BLK_STS_OK;
-		blk_mq_complete_request(req);
+		if (likely(!blk_should_fake_timeout(req->q)))
+			blk_mq_complete_request(req);
 		break;
 
 	case SKD_CHECK_STATUS_BUSY_IMMINENT:
@@ -1440,7 +1441,8 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 	case SKD_CHECK_STATUS_REPORT_ERROR:
 	default:
 		skreq->status = BLK_STS_IOERR;
-		blk_mq_complete_request(req);
+		if (likely(!blk_should_fake_timeout(req->q)))
+			blk_mq_complete_request(req);
 		break;
 	}
 }
@@ -1560,7 +1562,8 @@ static int skd_isr_completion_posted(struct skd_device *skdev,
 		 */
 		if (likely(cmp_status == SAM_STAT_GOOD)) {
 			skreq->status = BLK_STS_OK;
-			blk_mq_complete_request(rq);
+			if (likely(!blk_should_fake_timeout(rq->q)))
+				blk_mq_complete_request(rq);
 		} else {
 			skd_resolve_req_exception(skdev, skreq, rq);
 		}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9d21bf0f155eed..741804bd8a1403 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -171,7 +171,8 @@ static void virtblk_done(struct virtqueue *vq)
 		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
-			blk_mq_complete_request(req);
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
 			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 3b889ea950c21c..3bb3dd8da9b0c1 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1655,7 +1655,8 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			BUG();
 		}
 
-		blk_mq_complete_request(req);
+		if (likely(!blk_should_fake_timeout(req->q)))
+			blk_mq_complete_request(req);
 	}
 
 	rinfo->ring.rsp_cons = i;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f60c025121215b..5aec1cd093481d 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -288,7 +288,8 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
 	struct dm_rq_target_io *tio = tio_from_request(rq);
 
 	tio->error = error;
-	blk_mq_complete_request(rq);
+	if (likely(!blk_should_fake_timeout(rq->q)))
+		blk_mq_complete_request(rq);
 }
 
 /*
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7896952de1ac75..4791c82f8f7c78 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1446,7 +1446,7 @@ static void mmc_blk_cqe_req_done(struct mmc_request *mrq)
 	 */
 	if (mq->in_recovery)
 		mmc_blk_cqe_complete_rq(mq, req);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 }
 
@@ -1926,7 +1926,7 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
 	 */
 	if (mq->in_recovery)
 		mmc_blk_cqe_complete_rq(mq, req);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 }
 
@@ -1936,7 +1936,7 @@ void mmc_blk_mq_complete(struct request *req)
 
 	if (mq->use_cqe)
 		mmc_blk_cqe_complete_rq(mq, req);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		mmc_blk_mq_complete_rq(mq, req);
 }
 
@@ -1988,7 +1988,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	 */
 	if (mq->in_recovery)
 		mmc_blk_mq_complete_rq(mq, req);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 
 	mmc_blk_mq_dec_in_flight(mq, req);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0585efa47d8fd8..569671e264b509 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -304,7 +304,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_force_complete_rq(req);
+	blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fa5c75501049de..cb500d51c3a968 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -481,7 +481,8 @@ static inline void nvme_end_request(struct request *req, __le16 status,
 	rq->result = result;
 	/* inject error when permitted by fault injection framework */
 	nvme_should_fail(req);
-	blk_mq_complete_request(req);
+	if (likely(!blk_should_fake_timeout(req->q)))
+		blk_mq_complete_request(req);
 }
 
 static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index cf87eb27879f08..eb17fea8075c6f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2802,7 +2802,7 @@ static void __dasd_cleanup_cqr(struct dasd_ccw_req *cqr)
 			blk_update_request(req, BLK_STS_OK,
 					   blk_rq_bytes(req) - proc_bytes);
 			blk_mq_requeue_request(req, true);
-		} else {
+		} else if (likely(!blk_should_fake_timeout(req->q))) {
 			blk_mq_complete_request(req);
 		}
 	}
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index e01889394c8412..a4f6f2e62b1dcf 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -256,7 +256,8 @@ static void scm_request_finish(struct scm_request *scmrq)
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
 		error = blk_mq_rq_to_pdu(scmrq->request[i]);
 		*error = scmrq->error;
-		blk_mq_complete_request(scmrq->request[i]);
+		if (likely(!blk_should_fake_timeout(scmrq->request[i]->q)))
+			blk_mq_complete_request(scmrq->request[i]);
 	}
 
 	atomic_dec(&bdev->queued_reqs);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0ba7a65e7c8d96..6ca91d09eca1ec 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1589,18 +1589,12 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
+	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
+		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-
-	/*
-	 * If the block layer didn't complete the request due to a timeout
-	 * injection, scsi must clear its internal completed state so that the
-	 * timeout handler will see it needs to escalate its own error
-	 * recovery.
-	 */
-	if (unlikely(!blk_mq_complete_request(cmd->request)))
-		clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
+	blk_mq_complete_request(cmd->request);
 }
 
 static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d6fcae17da5a2a..8e6ab766aef76e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -503,8 +503,7 @@ void __blk_mq_end_request(struct request *rq, blk_status_t error);
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
-bool blk_mq_complete_request(struct request *rq);
-void blk_mq_force_complete_rq(struct request *rq);
+void blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
@@ -537,6 +536,15 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
+bool __blk_should_fake_timeout(struct request_queue *q);
+static inline bool blk_should_fake_timeout(struct request_queue *q)
+{
+	if (IS_ENABLED(CONFIG_FAIL_IO_TIMEOUT) &&
+	    test_bit(QUEUE_FLAG_FAIL_IO, &q->queue_flags))
+		return __blk_should_fake_timeout(q);
+	return false;
+}
+
 /**
  * blk_mq_rq_from_pdu - cast a PDU to a request
  * @pdu: the PDU (Protocol Data Unit) to be casted
-- 
2.26.2

