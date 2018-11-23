Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D2AC43610
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB99220866
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cm/bE8T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB99220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbeKXFTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKXFTn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so3380048pgs.2
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CnlK+mr+M53qC/l7xd/anJL6Z+EIH23uc9OwRaNRk8U=;
        b=cm/bE8T3Kta2xHCzhGZUR0YiZpOTT9eA4UFaAuwuDrrbIgz6U1hfQ+BUQ+EPKo2ZsY
         mVYYnuWMAuUU+x1Tw1i4RjDa+gPWVBeSOdTK7b9q3vJa+yR3MtKp1XpUNcAKPh3Ftw9G
         KZcipwf8t/QJ8cE82fRikn+i8bYK6mE/AXhBIds/K5HqSHv1VUL1ISQVnSvk2FWd/HK2
         AUtEn3BrbOITycXI6IodiFm/Lej7vJEHh5pC9cSnyguFgnuKCS2DIQ1T6aNyIFidpoRa
         3AJPImRkL2430sS+LvXSgNWOV+idADORnTiavhoEWl1oW+71wgST75aBJoZ2t5n3yCt6
         Mbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CnlK+mr+M53qC/l7xd/anJL6Z+EIH23uc9OwRaNRk8U=;
        b=YghPcGs32Pi+vjhRwGrq+mDSs5Ci5iObLDQgU5fn7uGc4O0/zfF64s2udjm0d+tQvQ
         CrgYcl6K2t0mQCuney6kozQZ76UTrA1IfODfGwrsttEgyukigNpqdULw2KABqL0jA2bh
         ZSpulCqyI8B3LYZc+qyAd0Ri7RWdGbX38noQnpFWnlwJr9JzMHC2z1+JXYBFdJ0NxKeW
         5F6ugXiAIIg2rVLdHx+PB0zu6DuZLZyStoLzVIAi2LYJ5Dvl03ZEWpqcHYQ7EhkxZUdY
         xKCi9XWeHIJ7uZ+D47MqHQGI+CZjvEMTrGsIKpPePbwbEzXuiW0dRcUDhtcNAj3eyNd3
         xHlA==
X-Gm-Message-State: AA+aEWYbyRuHi116v79ixWN4TDLDJPJyh5/GJ66GQSboDh31j/MwsOVj
        yTomwJ5o09dXC5kJ8MAOwCpSFci1OxQ=
X-Google-Smtp-Source: AFSGD/WiVRAY+8yD38P7lLwJM2Y723RYUBarHR9DOQA824plr0pZG9ZK0Jbp6XyRFyzvN8V3YTnVCw==
X-Received: by 2002:a63:8c0d:: with SMTP id m13mr15154819pgd.422.1542998056989;
        Fri, 23 Nov 2018 10:34:16 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] blk-mq: when polling for IO, look for any completion
Date:   Fri, 23 Nov 2018 11:34:06 -0700
Message-Id: <20181123183411.8708-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we want to support async IO polling, then we have to allow finding
completions that aren't just for the one we are looking for. Always pass
in -1 to the mq_ops->poll() helper, and have that return how many events
were found in this poll loop.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c         |  2 +-
 block/blk-mq.c           | 71 ++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c  | 14 ++++----
 drivers/nvme/host/rdma.c | 39 +++++++++-------------
 include/linux/blkdev.h   |  2 +-
 5 files changed, 60 insertions(+), 68 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04f5be473638..9e99aa852d6e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1273,7 +1273,7 @@ blk_qc_t submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio);
 
-bool blk_poll(struct request_queue *q, blk_qc_t cookie)
+int blk_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	if (!q->poll_fn || !blk_qc_t_valid(cookie))
 		return false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b16204df65d1..ec6c79578332 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3285,15 +3285,12 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 		return false;
 
 	/*
-	 * poll_nsec can be:
+	 * If we get here, hybrid polling is enabled. Hence poll_nsec can be:
 	 *
-	 * -1:	don't ever hybrid sleep
 	 *  0:	use half of prev avg
 	 * >0:	use this specific value
 	 */
-	if (q->poll_nsec == -1)
-		return false;
-	else if (q->poll_nsec > 0)
+	if (q->poll_nsec > 0)
 		nsecs = q->poll_nsec;
 	else
 		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
@@ -3330,11 +3327,41 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q,
+			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
 {
-	struct request_queue *q = hctx->queue;
+	struct request *rq;
+
+	if (q->poll_nsec == -1)
+		return false;
+
+	if (!blk_qc_t_is_internal(cookie))
+		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
+	else {
+		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
+		/*
+		 * With scheduling, if the request has completed, we'll
+		 * get a NULL return here, as we clear the sched tag when
+		 * that happens. The request still remains valid, like always,
+		 * so we should be safe with just the NULL check.
+		 */
+		if (!rq)
+			return false;
+	}
+
+	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
+}
+
+static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
+{
+	struct blk_mq_hw_ctx *hctx;
 	long state;
 
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		return 0;
+
+	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
 	 * the state. Like for the other success return cases, the
@@ -3342,7 +3369,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	 * the IO isn't complete, we'll get called again and will go
 	 * straight to the busy poll loop.
 	 */
-	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
+	if (blk_mq_poll_hybrid(q, hctx, cookie))
 		return 1;
 
 	hctx->poll_considered++;
@@ -3353,7 +3380,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, rq->tag);
+		ret = q->mq_ops->poll(hctx, -1U);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
@@ -3374,32 +3401,6 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return 0;
 }
 
-static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
-{
-	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
-
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
-
-	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return 0;
-	}
-
-	return __blk_mq_poll(hctx, rq);
-}
-
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 57e790391b82..de50d80ecc84 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1012,15 +1012,15 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-		u16 *end, int tag)
+static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				  u16 *end, unsigned int tag)
 {
-	bool found = false;
+	int found = 0;
 
 	*start = nvmeq->cq_head;
-	while (!found && nvme_cqe_pending(nvmeq)) {
-		if (nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found = true;
+	while (nvme_cqe_pending(nvmeq)) {
+		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
+			found++;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1062,7 +1062,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
 	u16 start, end;
-	bool found;
+	int found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181cafedc58..c2c3e1a5b7af 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1409,12 +1409,11 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	WARN_ON_ONCE(ret);
 }
 
-static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
-		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
+static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
+		struct nvme_completion *cqe, struct ib_wc *wc)
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
-	int ret = 0;
 
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -1422,7 +1421,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
 		nvme_rdma_error_recovery(queue->ctrl);
-		return ret;
+		return;
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
@@ -1437,6 +1436,8 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 	} else if (req->mr) {
+		int ret;
+
 		ret = nvme_rdma_inv_rkey(queue, req);
 		if (unlikely(ret < 0)) {
 			dev_err(queue->ctrl->ctrl.device,
@@ -1445,19 +1446,14 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 		/* the local invalidation completion will end the request */
-		return 0;
+		return;
 	}
 
-	if (refcount_dec_and_test(&req->ref)) {
-		if (rq->tag == tag)
-			ret = 1;
+	if (refcount_dec_and_test(&req->ref))
 		nvme_end_request(rq, req->status, req->result);
-	}
-
-	return ret;
 }
 
-static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
+static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_qe *qe =
 		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
@@ -1465,11 +1461,10 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	struct ib_device *ibdev = queue->device->dev;
 	struct nvme_completion *cqe = qe->data;
 	const size_t len = sizeof(struct nvme_completion);
-	int ret = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		nvme_rdma_wr_error(cq, wc, "RECV");
-		return 0;
+		return;
 	}
 
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
@@ -1484,16 +1479,10 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
-		ret = nvme_rdma_process_nvme_rsp(queue, cqe, wc, tag);
+		nvme_rdma_process_nvme_rsp(queue, cqe, wc);
 	ib_dma_sync_single_for_device(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 
 	nvme_rdma_post_recv(queue, qe);
-	return ret;
-}
-
-static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
-{
-	__nvme_rdma_recv_done(cq, wc, -1);
 }
 
 static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
@@ -1758,10 +1747,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 		struct ib_cqe *cqe = wc.wr_cqe;
 
 		if (cqe) {
-			if (cqe->done == nvme_rdma_recv_done)
-				found |= __nvme_rdma_recv_done(cq, &wc, tag);
-			else
+			if (cqe->done == nvme_rdma_recv_done) {
+				nvme_rdma_recv_done(cq, &wc);
+				found++;
+			} else {
 				cqe->done(cq, &wc);
+			}
 		}
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9b53db06ad08..f3015e9b5ae3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -867,7 +867,7 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
-bool blk_poll(struct request_queue *q, blk_qc_t cookie);
+int blk_poll(struct request_queue *q, blk_qc_t cookie);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {
-- 
2.17.1

