Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33923C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1210820812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHf4Phgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFKGp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE4C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SPcSsdpz1wTyt6AF6u+jC/mbmhjSlFh9pg97d+DCRkw=; b=RHf4PhgvyAoegFiUKXZi7zlUbz
        wMtfyfGpkzNvlQdMxvY8MkyUb1WbJz0MCswKropl9Wr8HP7l3DUMNCJwRwWoHBKPAAnkT0XB/ZYYB
        4aea/iXwXzc84N8gxZ7V/70YqQzye00MxpeTP16qtgrchblKuoThGI42R1Rh2EaVdB+XU8d9Md+IX
        Hgxw7jeohl3k7qH0EHJ8HCcWF5goyLddqhp9sgRfoxEQZBJpCY7DXkG7m869OZkBedhACzzJ5z1rV
        7b/9dPo+ng8uOtKkwnxXQd5bJvtMZc52vhKoUqVpfOsjhXH8XTHz0UQ8ymQVJ0VAKt/T67HHVr7m8
        GSwEb3yQ==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxq-0007QH-5m; Thu, 11 Jun 2020 06:45:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 11/12] nvme-rdma: factor out a nvme_rdma_end_request helper
Date:   Thu, 11 Jun 2020 08:44:51 +0200
Message-Id: <20200611064452.12353-12-hch@lst.de>
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

Factor a small sniplet of duplicated code into a new helper in
preparation for making this sniplet a little bit less trivial.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856dc0c67bd..9c02cf494a8257 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1149,6 +1149,15 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
+static void nvme_rdma_end_request(struct nvme_rdma_request *req)
+{
+	struct request *rq = blk_mq_rq_from_pdu(req);
+
+	if (!refcount_dec_and_test(&req->ref))
+		return;
+	nvme_end_request(rq, req->status, req->result);
+}
+
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
@@ -1173,16 +1182,11 @@ static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_request *req =
 		container_of(wc->wr_cqe, struct nvme_rdma_request, reg_cqe);
-	struct request *rq = blk_mq_rq_from_pdu(req);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (unlikely(wc->status != IB_WC_SUCCESS))
 		nvme_rdma_wr_error(cq, wc, "LOCAL_INV");
-		return;
-	}
-
-	if (refcount_dec_and_test(&req->ref))
-		nvme_end_request(rq, req->status, req->result);
-
+	else
+		nvme_rdma_end_request(req);
 }
 
 static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue,
@@ -1547,15 +1551,11 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
 	struct nvme_rdma_request *req =
 		container_of(qe, struct nvme_rdma_request, sqe);
-	struct request *rq = blk_mq_rq_from_pdu(req);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+	if (unlikely(wc->status != IB_WC_SUCCESS))
 		nvme_rdma_wr_error(cq, wc, "SEND");
-		return;
-	}
-
-	if (refcount_dec_and_test(&req->ref))
-		nvme_end_request(rq, req->status, req->result);
+	else
+		nvme_rdma_end_request(req);
 }
 
 static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
@@ -1694,11 +1694,9 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 		/* the local invalidation completion will end the request */
-		return;
+	} else {
+		nvme_rdma_end_request(req);
 	}
-
-	if (refcount_dec_and_test(&req->ref))
-		nvme_end_request(rq, req->status, req->result);
 }
 
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
-- 
2.26.2

