Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C7EC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDLFds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLFdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5215584
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VCBwvnKb/0vjY4TPYqqSpEsrtFGwmwLsDW+7iDaqK0I=; b=yrDNh/JShCXQVGzEf+9f0qcS5y
        c+AwAJ8zs3YD28sw2yYCpuAWhe7yIfag8xvqb/PaRiisHBmUIkDOtw4AohiDgymA+PskJbBh2pWFH
        sVAP4i9fXEInJIRl2w/6PnF8E4SIkhumspRE5+ZEhIh/yZhnmzIPermsFEdnv6DAvZ3FXKaHOsM9q
        V3nwDO7DBNZEbj9zXCxxxEm5Tjeo8PbnTokWK+0PMEbeS2FbjQmjtOsCxccMINkBfNAXJrrWpBVoP
        K0CMrAPpuJUWcKIzJGiMRana5x80DquvO4GOV59vV6C9msTO3ywR86NLFfRJn6QdOMarxBCbH8jvT
        m9boFTqA==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6t-001rMD-0u;
        Wed, 12 Apr 2023 05:33:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 17/18] blk-mq: pass a flags argument to blk_mq_request_bypass_insert
Date:   Wed, 12 Apr 2023 07:32:47 +0200
Message-Id: <20230412053248.601961-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the boolean at_head argument with the same flags that are already
passed to blk_mq_insert_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-flush.c |  2 +-
 block/blk-mq.c    | 18 +++++++++---------
 block/blk-mq.h    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3561aba8cc23f8..fa9607160c84a2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -426,7 +426,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c23c32f429a0e9..3f1b30e59e115f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1441,7 +1441,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
@@ -2455,17 +2455,17 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
- * @at_head: true if the request should be inserted at the head of the list.
+ * @flags: BLK_MQ_INSERT_*
  *
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head)
+void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	spin_lock(&hctx->lock);
-	if (at_head)
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
 		list_add(&rq->queuelist, &hctx->dispatch);
 	else
 		list_add_tail(&rq->queuelist, &hctx->dispatch);
@@ -2524,7 +2524,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
+		blk_mq_request_bypass_insert(rq, flags);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2547,7 +2547,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		blk_mq_request_bypass_insert(rq, true);
+		blk_mq_request_bypass_insert(rq, BLK_MQ_INSERT_AT_HEAD);
 	} else if (q->elevator) {
 		LIST_HEAD(list);
 
@@ -2668,7 +2668,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		break;
 	default:
@@ -2716,7 +2716,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
@@ -2835,7 +2835,7 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			if (list_empty(list))
 				blk_mq_run_hw_queue(hctx, false);
 			goto out;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2c165de2f3f1fe..849b53396f78b6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -68,7 +68,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head);
+void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

