Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6584BC43217
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F54610D1
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhJLST5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhJLSTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED105C06174E
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r134so13543593iod.11
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k37AHCp3gxbOm+kB3mONj2ZpBCnDrxLtP5yZn3K0HAw=;
        b=xLzKlSET2fR6nBbzaKk8t0rd/n9qOxVIXuvmVFyJjDCKcWTxdfqs20/qLQOmcJt5Fn
         VyPAalxyj7ws2PdRVPuDZ+HLUkAkcz2eX5sV3iYxQ3VxPd8DLzLPi+zEBZx1wmsp4eBk
         Hs22OF236nM5Sgz/X1hO768y4+UvcTfIbxARacNd+N6CQAR4XFSD4YFgtuceul8GSm/f
         ubMtOMFT2G8s2Lm7hYwlynmlcPfrNLl32VkU50ffFjejsvQQy0PajecQqcON355Sv7sD
         bWyYNadnLLicxO1dxToCf5kgE8BZKqo0heHc0rI0im35ZoBVroBVbVtuExSgjRjH8y7Z
         6PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k37AHCp3gxbOm+kB3mONj2ZpBCnDrxLtP5yZn3K0HAw=;
        b=nDZA+M3yRFN/76X7fTwKZXJ7q06v+jkxkkOjIDnxu6KVl20eP5Wh5nKnaRBgrPFkX6
         tl8fmlmH02+m2FiZcXTD10ufxcLH13UFyGColgE4fM+zyhtNRPr/hfcSKL9qoEv3rUZV
         Kq0UWde2JH/arYj9NeCuFnIb2dvIWtpJHxujIFSY5kJhEK60sSh1dep8c8trrw4CDsQ5
         DkmhDTHUujBCOI4Cx+K97S7Y7MaElysycUD0R9QofDmnRUHpIw46hsZ1KpgqdUblU+xi
         xt57OdQXAo+6W33dz7AxfJseNNm3DrUxuaoLYmBP/DAtCJuYa4NDiFDkiGHzg9+LUO5P
         iqXg==
X-Gm-Message-State: AOAM530dhk/nKZH2odwZd6cQ0+z6wG+YgTxgvh6oOO9C1xFxWdjhBOeU
        2cwhybI/VZmDiCiy4FnGLe8YldXXPk2OLg==
X-Google-Smtp-Source: ABdhPJxt9Bpfn9NYmP2VoZf1TdMwyoTtlYbJC9lQKgtGkT/hJlYN6SLGYkhRN3OZpBXc9hOaDsU/MA==
X-Received: by 2002:a6b:ea11:: with SMTP id m17mr10276462ioc.139.1634062669277;
        Tue, 12 Oct 2021 11:17:49 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] nvme: add support for batched completion of polled IO
Date:   Tue, 12 Oct 2021 12:17:39 -0600
Message-Id: <20211012181742.672391-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
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
 drivers/nvme/host/pci.c | 69 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4ad63bb9f415..4713da708cd4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static void nvme_pci_complete_rq(struct request *req)
+static void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev = iod->nvmeq->dev;
@@ -969,9 +969,34 @@ static void nvme_pci_complete_rq(struct request *req)
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
 
+static void nvme_pci_complete_batch(struct io_batch *ib)
+{
+	struct request *req;
+
+	req = ib->req_list;
+	while (req) {
+		nvme_pci_unmap_rq(req);
+		if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
+			nvme_cleanup_cmd(req);
+		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+				req_op(req) == REQ_OP_ZONE_APPEND)
+			req->__sector = nvme_lba_to_sect(req->q->queuedata,
+					le64_to_cpu(nvme_req(req)->result.u64));
+		req->status = nvme_error_status(nvme_req(req)->status);
+		req = req->rq_next;
+	}
+
+	blk_mq_end_request_batch(ib);
+}
+
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
@@ -996,7 +1021,8 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
 }
 
-static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
+static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
+				   struct io_batch *ib, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	__u16 command_id = READ_ONCE(cqe->command_id);
@@ -1023,8 +1049,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
-		nvme_pci_complete_rq(req);
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
+		enum nvme_disposition ret;
+
+		ret = nvme_decide_disposition(req);
+		if (unlikely(!ib || req->end_io || ret != COMPLETE)) {
+			nvme_pci_complete_rq(req);
+		} else {
+			req->rq_next = ib->req_list;
+			ib->req_list = req;
+		}
+	}
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
@@ -1050,7 +1085,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, NULL, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
@@ -1092,6 +1127,27 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
+static inline int nvme_poll_cq(struct nvme_queue *nvmeq, struct io_batch *ib)
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
+		nvme_handle_cqe(nvmeq, ib, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+	}
+
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
+}
+
+
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -1101,7 +1157,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *ib)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq);
+	found = nvme_poll_cq(nvmeq, ib);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -1639,6 +1695,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
+	.complete_batch = nvme_pci_complete_batch,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
-- 
2.33.0

