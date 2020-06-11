Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B56C433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D4D20814
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CbqrwmcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgFKGpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD6C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xRIlBdWnprAMLkAF+l7/C2HjkUzQrYOOGkYDj/dX30g=; b=CbqrwmcGqJ1tvs8r0thdJgdK+G
        i845AKhJdlef8ekk0vnipTHernVic7JGhHgBQbHtVJeiJ7qmi7vvh+Fz+fVDl3UfEFSSucM6ECF9S
        89+7g5Otmm9cV/KZhMkshxfrxOHwPSvhj86qtYOHrWUPhdMmVQnM9nUn+QuZvVJQvRFwD1Yirc5YP
        IeOEsKTSuhVtgDAqdRa/WxegpQuDG6vowlqcv5jHEG+PsAKNGfEJCbfwkY/ie44PfR00JHSVUHmyd
        L5J85AqbX+Z1YcOQDP/95QT/Yrtsk6zFdltU8ab+hazwn0c9oYh8U5pstXeZ1wp4xWBwKS0TpnPRM
        T0f5mQzw==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxt-0007Qu-9V; Thu, 11 Jun 2020 06:45:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 12/12] nvme: use blk_mq_complete_request_remote to avoid an indirect function call
Date:   Thu, 11 Jun 2020 08:44:52 +0200
Message-Id: <20200611064452.12353-13-hch@lst.de>
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

Use the new blk_mq_complete_request_remote helper to avoid an indirect
function call in the completion fast path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c     | 4 +++-
 drivers/nvme/host/nvme.h   | 7 ++++---
 drivers/nvme/host/pci.c    | 3 ++-
 drivers/nvme/host/rdma.c   | 4 +++-
 drivers/nvme/host/tcp.c    | 6 ++++--
 drivers/nvme/target/loop.c | 3 ++-
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index cb0007592c12ad..c04e97b858e54f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,7 @@ static DECLARE_COMPLETION(nvme_fc_unload_proceed);
  */
 static struct device *fc_udev_device;
 
+static void nvme_fc_complete_rq(struct request *rq);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -2033,7 +2034,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
-	nvme_end_request(rq, status, result);
+	if (!nvme_end_request(rq, status, result))
+		nvme_fc_complete_rq(rq);
 
 check_error:
 	if (terminate_assoc)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cb500d51c3a968..6f3a9e49f6b6b3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -472,7 +472,7 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 	return (len >> 2) - 1;
 }
 
-static inline void nvme_end_request(struct request *req, __le16 status,
+static inline bool nvme_end_request(struct request *req, __le16 status,
 		union nvme_result result)
 {
 	struct nvme_request *rq = nvme_req(req);
@@ -481,8 +481,9 @@ static inline void nvme_end_request(struct request *req, __le16 status,
 	rq->result = result;
 	/* inject error when permitted by fault injection framework */
 	nvme_should_fail(req);
-	if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
+	if (unlikely(blk_should_fake_timeout(req->q)))
+		return true;
+	return blk_mq_complete_request_remote(req);
 }
 
 static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d690d5593a8095..6a44d5874c7945 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -963,7 +963,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
-	nvme_end_request(req, cqe->status, cqe->result);
+	if (!nvme_end_request(req, cqe->status, cqe->result))
+		nvme_pci_complete_rq(req);
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9c02cf494a8257..97b1054efb8409 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -149,6 +149,7 @@ MODULE_PARM_DESC(register_always,
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event);
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
+static void nvme_rdma_complete_rq(struct request *rq);
 
 static const struct blk_mq_ops nvme_rdma_mq_ops;
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops;
@@ -1155,7 +1156,8 @@ static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 
 	if (!refcount_dec_and_test(&req->ref))
 		return;
-	nvme_end_request(rq, req->status, req->result);
+	if (!nvme_end_request(rq, req->status, req->result))
+		nvme_rdma_complete_rq(rq);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1843110ec34f8a..1b5c24624df167 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -464,7 +464,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	nvme_end_request(rq, cqe->status, cqe->result);
+	if (!nvme_end_request(rq, cqe->status, cqe->result))
+		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
 	return 0;
@@ -654,7 +655,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-	nvme_end_request(rq, cpu_to_le16(status << 1), res);
+	if (!nvme_end_request(rq, cpu_to_le16(status << 1), res))
+		nvme_complete_rq(rq);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d54e730cbf2a7..1b9c246a849bc3 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -116,7 +116,8 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 			return;
 		}
 
-		nvme_end_request(rq, cqe->status, cqe->result);
+		if (!nvme_end_request(rq, cqe->status, cqe->result))
+			nvme_loop_complete_rq(rq);
 	}
 }
 
-- 
2.26.2

