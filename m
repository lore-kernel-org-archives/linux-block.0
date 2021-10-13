Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C503861027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhJMQ42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhJMQ42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:28 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC43C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i189so484042ioa.1
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doaFOKk5ebYYoE13YQULp5d2Lpok+sMDrhuPP3+ZyVc=;
        b=HM0nqPvHkVUfP00UfLItNwBwB/yXC02o2juVZqb/BQTJbzmkIyZsulQNGSOupWRuQ0
         bKGCqpgsXI15fgEeiGUpZfHSj0PcmometO7whNuTCfKXbNa5vXi6YVqysLACMaf0+UpL
         QTrgnpcpaoSQ3PMuhVxxRTKKrdM/fGh7wfGKqwzFmP5I22HLBN5Y4F/mKn8SDaRWwLOk
         IjNWB5Sg7oR91SZa1uVahJf4AuqfXcXUo/BqKhgb4ELtkYBxIH7Q0Euav/8OTt4raxne
         qKFrsGMU+exQ6whXgh4wP9C+D27mASSXXJie12JWgVoyqUkFQ4COtDrzrA+zj8LFfVbP
         0IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doaFOKk5ebYYoE13YQULp5d2Lpok+sMDrhuPP3+ZyVc=;
        b=DDlDLUwuX7jGFNp3160eDnmsToOQr/Uy7l3sVOkTJvMl70zPWZMdcXKC6P98jA8RKe
         daqrlbXVlWWtdoFBekXGFtv2O8Nu6w85nmvHWfjQmuHyg/lWJvBvNXtnSdjwbjf+YkcE
         bR2xO7OEblAPunfDGS6GJ9hiqWzwW0Wc2mlPsX3o8PjsKWIpkQYxbxd4KAnwajAOf9xe
         VMmEzaQoe7Fs+UPj3pzCKcj0ZBn0TzUb3O2rE0tnwBDMsxMnCIR21oRpYnWG+JxVSmz7
         5dbxUBnsRkh4i/70iQ7HKaTnpLFkw1GFNCctowMrdYyv7BZ9cOmZ8xxKeQpX21GxCE2j
         HVAw==
X-Gm-Message-State: AOAM532oEkapoL4VMUALvcuOXtTEaLbHcuexusn9zJ5pu9wsl7hU7t+k
        KeLX7gEm353pu2WfbeiAqWzVyghuL1dlIw==
X-Google-Smtp-Source: ABdhPJwHuFFlPk7IEEyBjbyv2uqYu7un0eXfsDF/M2jVKAifwkKwbfV9n7CxGEOot5qj3MrKTONXZw==
X-Received: by 2002:a5e:9612:: with SMTP id a18mr282315ioq.57.1634144063921;
        Wed, 13 Oct 2021 09:54:23 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] nvme: add support for batched completion of polled IO
Date:   Wed, 13 Oct 2021 10:54:13 -0600
Message-Id: <20211013165416.985696-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Take advantage of struct io_batch, if passed in to the nvme poll handler.
If it's set, rather than complete each request individually inline, store
them in the io_batch list. We only do so for requests that will complete
successfully, anything else will be completed inline as before.

Add an mq_ops->complete_batch() handler to do the post-processing of
the io_batch list once polling is complete.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 18 +++++++++++---
 drivers/nvme/host/nvme.h | 17 +++++++++++++
 drivers/nvme/host/pci.c  | 54 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c2e8545292..4b14258a3bac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,15 +346,19 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void nvme_end_req_zoned(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
 			le64_to_cpu(nvme_req(req)->result.u64));
+}
+
+static inline void nvme_end_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	blk_mq_end_request(req, status);
 }
@@ -381,6 +385,14 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_complete_batch_req(struct request *req)
+{
+	nvme_cleanup_cmd(req);
+	nvme_end_req_zoned(req);
+	req->status = BLK_STS_OK;
+}
+EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
+
 /*
  * Called to unwind from ->queue_rq on a failed command submission so that the
  * multipathing code gets called to potentially failover to another path.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..e0c079f704cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,23 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+void nvme_complete_batch_req(struct request *req);
+
+static __always_inline void nvme_complete_batch(struct io_batch *iob,
+						void (*fn)(struct request *rq))
+{
+	struct request *req;
+
+	req = rq_list_peek(&iob->req_list);
+	while (req) {
+		fn(req);
+		nvme_complete_batch_req(req);
+		req = rq_list_next(req);
+	}
+
+	blk_mq_end_request_batch(iob);
+}
+
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9db6e23f41ef..ae253f6f5c80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static void nvme_pci_complete_rq(struct request *req)
+static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev = iod->nvmeq->dev;
@@ -969,9 +969,19 @@ static void nvme_pci_complete_rq(struct request *req)
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
+}
+
+static void nvme_pci_complete_rq(struct request *req)
+{
+	nvme_pci_unmap_rq(req);
 	nvme_complete_rq(req);
 }
 
+static void nvme_pci_complete_batch(struct io_batch *iob)
+{
+	nvme_complete_batch(iob, nvme_pci_unmap_rq);
+}
+
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
@@ -996,7 +1006,8 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
 }
 
-static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
+static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
+				   struct io_batch *iob, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	__u16 command_id = READ_ONCE(cqe->command_id);
@@ -1023,8 +1034,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
-		nvme_pci_complete_rq(req);
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
+		/*
+		 * Do normal inline completion if we don't have a batch
+		 * list, if we have an end_io handler, or if the status of
+		 * the request isn't just normal success.
+		 */
+		if (!iob || req->end_io || nvme_req(req)->status)
+			nvme_pci_complete_rq(req);
+		else
+			rq_list_add_tail(&iob->req_list, req);
+	}
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
@@ -1050,7 +1070,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, NULL, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
@@ -1092,6 +1112,27 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
+static inline int nvme_poll_cq(struct nvme_queue *nvmeq, struct io_batch *iob)
+{
+	int found = 0;
+
+	while (nvme_cqe_pending(nvmeq)) {
+		found++;
+		/*
+		 * load-load control dependency between phase and the rest of
+		 * the cqe requires a full read memory barrier
+		 */
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+	}
+
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
+}
+
+
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -1101,7 +1142,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *iob)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq);
+	found = nvme_poll_cq(nvmeq, iob);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -1639,6 +1680,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
+	.complete_batch = nvme_pci_complete_batch,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
-- 
2.33.0

