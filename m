Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43271C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDKNex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDKNew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C19358D
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ziU/q5bKhOHNHDM5LNCgN40fuXTioUkBh47RSTcHg6k=; b=I/WDRC/GV2MJMnNWXuuNEl85yl
        ajEf++uyDb9hl4h740Zz5xM4GQub8+KTYtTFMJM0sissiHfQI/47WCk5PF90BBlvir+ZO5K+ibWiQ
        jqCFqRD8BVp0wuU6PK4GK4sxlfLksiVyD+6JqXwfAQxCLnVmUQ9eYyRj/vtBS4gbtNN/HPsPTwW10
        +KRCDsmGQH0TTi1pEaFJ/Km0291ZPzY3ykGoM7kfbJuhwJSeVzz5+XeYK6SATTFyOKKohLsONEr9t
        KjzazZZi5vZ/8ju2CSVGxNd2AKP6vSkk+2A/A2ZS8qeeaZE9Zb7AGpmgGU8Wu/AzR3rM5CgjYYM/P
        OjSKbYaw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE93-00082p-1H;
        Tue, 11 Apr 2023 13:34:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 15/16] blk-mq: pass a flags argument to blk_mq_request_bypass_insert
Date:   Tue, 11 Apr 2023 15:33:28 +0200
Message-Id: <20230411133329.554624-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the two boolean arguments with the same flags that are already
passed to blk_mq_insert_request.  Also add the currently unused
BLK_MQ_INSERT_ASYNC support so that the flags support is complete.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c |  2 +-
 block/blk-mq.c    | 18 +++++++++---------
 block/blk-mq.h    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 5c0d06945c435a..3588a2810820d9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -427,7 +427,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		return;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5a4ae0e4080d45..c0330879aff54a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1443,7 +1443,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
@@ -2457,17 +2457,17 @@ static void blk_mq_run_work_fn(struct work_struct *work)
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
+void blk_mq_request_bypass_insert(struct request *rq, unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	spin_lock(&hctx->lock);
-	if (at_head)
+	if (flags & BLK_MQ_INSERT_AT_HEAD)
 		list_add(&rq->queuelist, &hctx->dispatch);
 	else
 		list_add_tail(&rq->queuelist, &hctx->dispatch);
@@ -2526,7 +2526,7 @@ static void blk_mq_insert_request(struct request *rq, unsigned int flags)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, flags & BLK_MQ_INSERT_AT_HEAD);
+		blk_mq_request_bypass_insert(rq, flags);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2549,7 +2549,7 @@ static void blk_mq_insert_request(struct request *rq, unsigned int flags)
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		blk_mq_request_bypass_insert(rq, true);
+		blk_mq_request_bypass_insert(rq, BLK_MQ_INSERT_AT_HEAD);
 	} else if (q->elevator) {
 		LIST_HEAD(list);
 
@@ -2670,7 +2670,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_request_bypass_insert(rq, 0);
 		blk_mq_run_hw_queue(hctx, false);
 		break;
 	default:
@@ -2718,7 +2718,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
@@ -2837,7 +2837,7 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_request_bypass_insert(rq, 0);
 			if (list_empty(list))
 				blk_mq_run_hw_queue(hctx, false);
 			goto out;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ab2f4bfa0de6a4..e28b18d72caeea 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -61,7 +61,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head);
+void blk_mq_request_bypass_insert(struct request *rq, unsigned int flags);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

