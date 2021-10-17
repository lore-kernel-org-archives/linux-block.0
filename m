Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB03C433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4093560F8F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhJQCIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJQCIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE1C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i11so11245124ila.12
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Tqp9z4lhhAWkP6OrLx9Za9LfIDVjiUd7WeSrfg9Jh8=;
        b=0xf4v63zXWqoJ3612+Eit088Q66P9ZuyoAKJbIqKq79xkrWzbpLbiJ1kqZ8C1cRxNQ
         Zje5vOc7NIE4ER558P6Exs/9sc05kLeItT4J2YOT12Shy23k3yVXuIavzBQcK8AVlkn1
         P6RHDl9tNy3XQEwGuifhFI296ZQUTE35f//kggj/25z1B1fHQZpLhmKyJ8Rr4Fu2Ik88
         58Ke1LpSEIifxZxfZeszO/UwRw1K7oFjl9wBQfR0qvFurdVwv5+BZKnj7VS4UYE+4dNC
         7JI1Hg97451MwF9mqR0g05wgCxTAfzN6IITyhA2jGagAMXIITk7ZcQYGoKH+Pl5IVOmP
         zLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Tqp9z4lhhAWkP6OrLx9Za9LfIDVjiUd7WeSrfg9Jh8=;
        b=AwDttvYdSNeadBwyuch0+E4ZJo1hXipKsFL/fiAcEochEI2QB90Hh1omYScO4Q5Qov
         LuzbOpz4us2DDLG3WK7uf3/pdC/zE52azvap6LEcE0wOBdv8xxnrHmNWAM5lulrlIXxB
         tsuXkYc93K4j09QquxoxEvulv3Hhll2DnsYNPBG9iqVwOYAgQSsSrPyKvZdn8My6Pp8n
         dSfXwDimBpODdtcW0KxPfrpqDXOq+ng7rWPRmf7loMpUmUjLc5jFK/FuewRd8GPRXwXS
         t5i7Q3nsiHbL9ZfpR7jgKy4/4vfd0rjLbW02M34q368m6HEYSkFfZR75u1LHf9yYML/f
         NJvA==
X-Gm-Message-State: AOAM533OIqUSZYd3CMLyIsrhAgsrAY5vVg6AjOoRvM1ocueGjUHlHsMS
        FCHTNKTgTs1+66ecQXksSPGEe+mXlMaW/Q==
X-Google-Smtp-Source: ABdhPJyCE0u6OD1jMjECPjXSqsWDufOnLui9EejEDDKgQr3D/1rMhDz8a6y6fj1+Sub87837Mv7L9g==
X-Received: by 2002:a92:cd82:: with SMTP id r2mr10112805ilb.198.1634436389214;
        Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] nvme: add support for batched completion of polled IO
Date:   Sat, 16 Oct 2021 20:06:21 -0600
Message-Id: <20211017020623.77815-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017020623.77815-1-axboe@kernel.dk>
References: <20211017020623.77815-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Take advantage of struct io_comp_batch, if passed in to the nvme poll
handler. If it's set, rather than complete each request individually
inline, store them in the io_comp_batch list. We only do so for requests
that will complete successfully, anything else will be completed inline as
before.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 17 ++++++++++++++---
 drivers/nvme/host/nvme.h | 14 ++++++++++++++
 drivers/nvme/host/pci.c  | 31 +++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c2e8545292..4eadecc67c91 100644
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
@@ -381,6 +385,13 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_complete_batch_req(struct request *req)
+{
+	nvme_cleanup_cmd(req);
+	nvme_end_req_zoned(req);
+}
+EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
+
 /*
  * Called to unwind from ->queue_rq on a failed command submission so that the
  * multipathing code gets called to potentially failover to another path.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..ef2467b93adb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,20 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+void nvme_complete_batch_req(struct request *req);
+
+static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
+						void (*fn)(struct request *rq))
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		fn(req);
+		nvme_complete_batch_req(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d1ab9250101a..e916d5e167c1 100644
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
 
+static void nvme_pci_complete_batch(struct io_comp_batch *iob)
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
+				   struct io_comp_batch *iob, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	__u16 command_id = READ_ONCE(cqe->command_id);
@@ -1023,7 +1034,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
+	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
+	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
+					nvme_pci_complete_batch))
 		nvme_pci_complete_rq(req);
 }
 
@@ -1039,7 +1052,8 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline int nvme_process_cq(struct nvme_queue *nvmeq)
+static inline int nvme_poll_cq(struct nvme_queue *nvmeq,
+			       struct io_comp_batch *iob)
 {
 	int found = 0;
 
@@ -1050,7 +1064,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
@@ -1059,6 +1073,11 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 	return found;
 }
 
+static inline int nvme_process_cq(struct nvme_queue *nvmeq)
+{
+	return nvme_poll_cq(nvmeq, NULL);
+ }
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
@@ -1101,7 +1120,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq);
+	found = nvme_poll_cq(nvmeq, iob);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
-- 
2.33.1

