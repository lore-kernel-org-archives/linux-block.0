Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B92AC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288F620820
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVcqYCHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgFKGpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66157C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vU7h4+SGUeFsLVj1M+2dE8h2GtTp5BnCcBzbhSg0Wkg=; b=RVcqYCHEX6G6AUICE7cKohcd8S
        NLAyiRcWw9FQpHC046MQrXRt05ZcEU2vEBrRFv/NHiFh01f5j2Duo4hTxUmmSIVWilVIV6AZSUu51
        ZAXj3ZyxmdL3cfvY2Y2UpH6tFgT+iteo4EnDIvWKxpYuSfhr++G5cPAZ17Z3wEl6wQixP8VlKiHUC
        3JhSE0HmfNl4Tyf7anqkoMQso8jsiXKfPkpePJt19LMjkgpxAE5hnVSVFXHZ3thlyY70UKTkDDKLs
        PRMwwIFpwRyL24/ZUbpT3e0/lmpc7c8AODm8rkjJFcmRFvkYSTMm8sQ6ZmWi/3zDSvIOU9llISkk+
        C7/VrdUQ==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxn-0007PB-C8; Thu, 11 Jun 2020 06:45:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 10/12] blk-mq: add a new blk_mq_complete_request_remote API
Date:   Thu, 11 Jun 2020 08:44:50 +0200
Message-Id: <20200611064452.12353-11-hch@lst.de>
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

This is a variant of blk_mq_complete_request_remote that only completes
the request if it needs to be bounced to another CPU or a softirq.  If
the request can be completed locally the function returns false and lets
the driver complete it without requring and indirect function call.

Suggestions for a better name welcome.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 45 ++++++++++++++++++++++++------------------
 include/linux/blk-mq.h |  1 +
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f83c81566de904..31d4bdd5bdb7bd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -632,8 +632,11 @@ static int blk_softirq_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+
+static void __blk_mq_complete_request_remote(void *data)
 {
+	struct request *rq = data;
+
 	/*
 	 * For most of single queue controllers, there is only one irq vector
 	 * for handling I/O completion, and the only irq's affinity is set
@@ -649,11 +652,6 @@ static void __blk_mq_complete_request(struct request *rq)
 		rq->q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request_remote(void *data)
-{
-	__blk_mq_complete_request(data);
-}
-
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
 {
 	int cpu = raw_smp_processor_id();
@@ -672,14 +670,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
-/**
- * blk_mq_complete_request - end I/O on a request
- * @rq:		the request being processed
- *
- * Description:
- *	Complete a request by scheduling the ->complete_rq operation.
- **/
-void blk_mq_complete_request(struct request *rq)
+bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
@@ -687,10 +678,8 @@ void blk_mq_complete_request(struct request *rq)
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_HIPRI) {
-		rq->q->mq_ops->complete(rq);
-		return;
-	}
+	if (rq->cmd_flags & REQ_HIPRI)
+		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
 		rq->csd.func = __blk_mq_complete_request_remote;
@@ -698,8 +687,26 @@ void blk_mq_complete_request(struct request *rq)
 		rq->csd.flags = 0;
 		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
 	} else {
-		__blk_mq_complete_request(rq);
+		if (rq->q->nr_hw_queues > 1)
+			return false;
+		blk_mq_trigger_softirq(rq);
 	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
+
+/**
+ * blk_mq_complete_request - end I/O on a request
+ * @rq:		the request being processed
+ *
+ * Description:
+ *	Complete a request by scheduling the ->complete_rq operation.
+ **/
+void blk_mq_complete_request(struct request *rq)
+{
+	if (!blk_mq_complete_request_remote(rq))
+		rq->q->mq_ops->complete(rq);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8e6ab766aef76e..1641ec6cd7e551 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -504,6 +504,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+bool blk_mq_complete_request_remote(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.26.2

