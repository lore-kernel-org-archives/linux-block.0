Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E36C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600C420814
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GK28BEkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFKGpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259EC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Gt85C9Bv675IiqqR4LleeQW+13eN11uTjjifoSAzxdM=; b=GK28BEkUPwURw+vskg8uq0OPhN
        Ik8amX98mD1v+cPNFzm8tk4FCo8tp+I3dDR+qHDgtY7Vr3nPgWDg1cfVXjuRVIBeMSb85TdWNM9L+
        tuH5I7zXOaIFKTDy7JvsiTmI5ANRl8M8EJ4mbocLz018VME+zyraEwKc1fF8iuOh4ExlHsSS+phOZ
        ldliSRT1+Aztt5qIcWdnwPgK9z4Lp9MR5OiNHNH/hXJxWp2EpTurEIvAWhJuVolKLkhwVIc0mbuxn
        Uv7itvmm9Q6qu6EKkzTL89UtKk1ozbxTLs74EBKiggG22XNP0iT0Uve6IGAbKjnRkV01MUZvx1e9V
        Q9IDUGQw==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxk-0007OO-J0; Thu, 11 Jun 2020 06:45:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 09/12] blk-mq: factor out a blk_mq_complete_need_ipi helper
Date:   Thu, 11 Jun 2020 08:44:49 +0200
Message-Id: <20200611064452.12353-10-hch@lst.de>
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

Add a helper to decide if we can complete locally or need an IPI.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45294cd5d875cc..f83c81566de904 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -654,6 +654,24 @@ static void __blk_mq_complete_request_remote(void *data)
 	__blk_mq_complete_request(data);
 }
 
+static inline bool blk_mq_complete_need_ipi(struct request *rq)
+{
+	int cpu = raw_smp_processor_id();
+
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
+		return false;
+
+	/* same CPU or cache domain?  Complete locally */
+	if (cpu == rq->mq_ctx->cpu ||
+	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
+	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+		return false;
+
+	/* don't try to IPI to an offline CPU */
+	return cpu_online(rq->mq_ctx->cpu);
+}
+
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
@@ -663,11 +681,6 @@ static void __blk_mq_complete_request_remote(void *data)
  **/
 void blk_mq_complete_request(struct request *rq)
 {
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct request_queue *q = rq->q;
-	bool shared = false;
-	int cpu;
-
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -675,25 +688,15 @@ void blk_mq_complete_request(struct request *rq)
 	 * to redirect the completion.
 	 */
 	if (rq->cmd_flags & REQ_HIPRI) {
-		q->mq_ops->complete(rq);
-		return;
-	}
-
-	if (!IS_ENABLED(CONFIG_SMP) ||
-	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
-		__blk_mq_complete_request(rq);
+		rq->q->mq_ops->complete(rq);
 		return;
 	}
 
-	cpu = raw_smp_processor_id();
-	if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
-		shared = cpus_share_cache(cpu, ctx->cpu);
-
-	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
+	if (blk_mq_complete_need_ipi(rq)) {
 		rq->csd.func = __blk_mq_complete_request_remote;
 		rq->csd.info = rq;
 		rq->csd.flags = 0;
-		smp_call_function_single_async(ctx->cpu, &rq->csd);
+		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
 	} else {
 		__blk_mq_complete_request(rq);
 	}
-- 
2.26.2

