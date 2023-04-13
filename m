Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4690C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDMGmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDMGlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:41:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC68A64
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7TnNfdPb4qh6G/HjMQCHtB+g3qDrSxujWJ1m/s1dFEM=; b=1ZQAopgG1340Uf6UJB6QDlM6cg
        gJzvVikqmPpGIAJ6u6JwNksbJ27MTf6mKna43V0A0GFqZ8CC96tKUldMzM0Yk2WuxQf8w34IL1j/h
        sQjP1tVz/cblnGTC/eZB+iUnoDaKMb5acKK5vXNazbTpnsKjgvTgfj6hm8/fnWEfvxXGZlXN98jKX
        R0LfBgCvCk5GNgpUIiCikIy/KhknzJbv/Nt2I/lfDacyz1l0bXncaG8SQtYcSrHCQPYtwgNYxdG0p
        ahVwkFKWCdBYqhT8N+8uCuuZKWqRwRWqwQYz7WlQFyZQn7sh0OU+WJtLwYcX0NdYmpv0nmJdb+ToC
        q//YWJTQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeI-005BWw-00;
        Thu, 13 Apr 2023 06:41:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 15/20] blk-mq: don't run the hw_queue from blk_mq_request_bypass_insert
Date:   Thu, 13 Apr 2023 08:40:52 +0200
Message-Id: <20230413064057.707578-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_request_bypass_insert takes a bool parameter to control how to run
the queue at the end of the function.  Move the blk_mq_run_hw_queue call
to the callers that want it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-flush.c |  4 +++-
 block/blk-mq.c    | 24 +++++++++++-------------
 block/blk-mq.h    |  3 +--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 62ef98f604fbf9..3561aba8cc23f8 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -389,6 +389,7 @@ void blk_insert_flush(struct request *rq)
 	unsigned long fflags = q->queue_flags;	/* may change, cache */
 	unsigned int policy = blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	/*
 	 * @policy now records what operations need to be done.  Adjust
@@ -425,7 +426,8 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d1941db1ad3c97..cde7ba9c39bf6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1442,7 +1442,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, false, false);
+			blk_mq_request_bypass_insert(rq, false);
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
@@ -2457,13 +2457,11 @@ static void blk_mq_run_work_fn(struct work_struct *work)
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
  * @at_head: true if the request should be inserted at the head of the list.
- * @run_queue: If we should run the hardware queue after inserting the request.
  *
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
-				  bool run_queue)
+void blk_mq_request_bypass_insert(struct request *rq, bool at_head)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
@@ -2473,9 +2471,6 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 	else
 		list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
-
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, false);
 }
 
 static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
@@ -2530,7 +2525,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, at_head, false);
+		blk_mq_request_bypass_insert(rq, at_head);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2553,7 +2548,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		blk_mq_request_bypass_insert(rq, true, false);
+		blk_mq_request_bypass_insert(rq, true);
 	} else if (q->elevator) {
 		LIST_HEAD(list);
 
@@ -2673,7 +2668,8 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_run_hw_queue(hctx, false);
 		break;
 	default:
 		blk_mq_end_request(rq, ret);
@@ -2720,7 +2716,8 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false, true);
+			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2838,8 +2835,9 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false,
-						     list_empty(list));
+			blk_mq_request_bypass_insert(rq, false);
+			if (list_empty(list))
+				blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
 			blk_mq_end_request(rq, ret);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e2d59e33046e30..f30f99166f3870 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -65,8 +65,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 /*
  * Internal helpers for request insertion into sw queues
  */
-void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
-				  bool run_queue);
+void blk_mq_request_bypass_insert(struct request *rq, bool at_head);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

