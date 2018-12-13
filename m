Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD7EC67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936F520849
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pPa44Joh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936F520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeLMGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QK17lslDLMRhPNR8yTzH9mTyZUh7dXGT1Z0ul7MONnI=; b=pPa44JohVbHBVsLZAO9k1bhSK
        eFWUHCU9LSRmGMXZKz9mLRUZOHKnJu0x5BsMWuF+VM00VJXXAnkacWh0cyJV9AbyUAmuS1V0T9HtP
        eKI9+Z8zk8//8y46nSZAYC88YgREE44GIM+grPNFFE51N4w6EKudEOiIjFciThwpkEAJnuYv9MwkS
        vW7cgQpgads1yidZHmfRNb1Tdn/9/2oMA9/mu6xa4Zi0MU4+fEkvwWd9VoFNu1t+UeMgXzKC8Vbvc
        CtRKIfv7vtk28A5uJ9N6+5Qa31yLCGzlTlcKHkuDERBLcvNGUoTlUQOlHNiL+uBMF44mHZ1xv0HL8
        /VDO6x8gA==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKdZ-0006LR-42; Thu, 13 Dec 2018 06:38:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/6] block: introduce blk_execute_rq_polled
Date:   Wed, 12 Dec 2018 22:38:13 -0800
Message-Id: <20181213063819.13614-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Used forsynchronous requests that needs polling. If we are knowingly
sending a request down to a poll queue, we need a synchronous interface
to poll for its completion.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-exec.c       | 29 +++++++++++++++++++++++++++++
 block/blk-mq.c         |  8 --------
 include/linux/blk-mq.h |  8 ++++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index a34b7d918742..572032d60001 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -90,3 +90,32 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
 		wait_for_completion_io(&wait);
 }
 EXPORT_SYMBOL(blk_execute_rq);
+
+/**
+ * blk_execute_rq_polled - execute a request and poll for its completion
+ * @q:		queue to insert the request in
+ * @bd_disk:	matching gendisk
+ * @rq:		request to insert
+ * @at_head:    insert request at head or tail of queue
+ *
+ * Description:
+ *    Insert a fully prepared request at the back of the I/O scheduler queue
+ *    for execution and wait for completion.
+ */
+void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
+		   struct request *rq, int at_head)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+
+	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
+
+	rq->cmd_flags |= REQ_HIPRI;
+	rq->end_io_data = &wait;
+	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
+
+	while (!completion_done(&wait)) {
+		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	}
+}
+EXPORT_SYMBOL(blk_execute_rq_polled);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65770da99159..65d3f3a69c0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1747,14 +1747,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 	blk_account_io_start(rq, true);
 }
 
-static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
-{
-	if (rq->tag != -1)
-		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
-
-	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
-}
-
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
 					    blk_qc_t *cookie, bool last)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 57eda7b20243..c77cba1ec0f5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -357,4 +357,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
+static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	if (rq->tag != -1)
+		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
+
+	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
+}
+
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 81f1b105946b..9f48d8855916 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -860,6 +860,8 @@ extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
 extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
+void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
+		   struct request *rq, int at_head);
 
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
-- 
2.17.1

