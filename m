Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5D8C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDKNel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDKNel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411B449E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tiXDgQGPYjl789Cgad+cmsa+krsd8Lb3N0m+nVqO1+g=; b=y9dNKbPlUxrP3C5OqoRiKupHDn
        +on7sqsqESlr9LQGqTSNAptqdhUfa8eBygHcE3AgPYPQU/pkONhoGcMwnnoT0rbcXxXF+xArDE3Fg
        CjxH745diVYjngyL7Mdnu1Aq8qwkbCQ4quPtvzM+eeZwdv2Mr4D9sH3QkPURhZIGpga5wj2TyOxfY
        xaS7njnhnkVfxfNdh0xSW8vGtmgA5IUV7lQS7oKF/5uImPAE/I4i3VITXx6REzyT2HQu58TbjMF+y
        aTFkDaqSKZOrEHh2XNIsPXrj595g+JbxIJYEJtXtnhlBilLGO0zzmC3m1uQ5XL6Jwn96CbHWOMctd
        RIj9yaPw==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8s-00081O-24;
        Tue, 11 Apr 2023 13:34:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 13/16] blk-mq: don't run the hw_queue from blk_mq_request_bypass_insert
Date:   Tue, 11 Apr 2023 15:33:26 +0200
Message-Id: <20230411133329.554624-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
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
---
 block/blk-flush.c |  2 +-
 block/blk-mq.c    | 24 +++++++++++-------------
 block/blk-mq.h    |  3 +--
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index cbb5b069809117..5c0d06945c435a 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -427,7 +427,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_request_bypass_insert(rq, false);
 		return;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4cec6bae15df6b..edc82ecf7f5b77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1443,7 +1443,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		if (rq->rq_flags & RQF_DONTPREP) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
-			blk_mq_request_bypass_insert(rq, false, false);
+			blk_mq_request_bypass_insert(rq, false);
 		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
 			rq->rq_flags &= ~RQF_SOFTBARRIER;
 			list_del_init(&rq->queuelist);
@@ -2458,13 +2458,11 @@ static void blk_mq_run_work_fn(struct work_struct *work)
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
 
@@ -2474,9 +2472,6 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 	else
 		list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
-
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, false);
 }
 
 static void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx,
@@ -2531,7 +2526,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * and it is added to the scheduler queue, there is no chance to
 		 * dispatch it given we prioritize requests in hctx->dispatch.
 		 */
-		blk_mq_request_bypass_insert(rq, at_head, false);
+		blk_mq_request_bypass_insert(rq, at_head);
 	} else if (rq->rq_flags & RQF_FLUSH_SEQ) {
 		/*
 		 * Firstly normal IO request is inserted to scheduler queue or
@@ -2554,7 +2549,7 @@ static void blk_mq_insert_request(struct request *rq, bool at_head)
 		 * Simply queue flush rq to the front of hctx->dispatch so that
 		 * intensive flush workloads can benefit in case of NCQ HW.
 		 */
-		blk_mq_request_bypass_insert(rq, true, false);
+		blk_mq_request_bypass_insert(rq, true);
 	} else if (q->elevator) {
 		LIST_HEAD(list);
 
@@ -2674,7 +2669,8 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_request_bypass_insert(rq, false, true);
+		blk_mq_request_bypass_insert(rq, false);
+		blk_mq_run_hw_queue(hctx, false);
 		break;
 	default:
 		blk_mq_end_request(rq, ret);
@@ -2721,7 +2717,8 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 			break;
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false, true);
+			blk_mq_request_bypass_insert(rq, false);
+			blk_mq_run_hw_queue(hctx, false);
 			goto out;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2839,8 +2836,9 @@ static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
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
index c2aec5cbfa7663..cc17e942753117 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -59,8 +59,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
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

