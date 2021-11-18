Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D656126A
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhKRPd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232392AbhKRPdy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 10:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637249454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0qXyzCLpKoHJxB72U/n7U27y7fSMiqUaVNkT1qDnIaM=;
        b=OYH65+6rLhpoDCjuJfEV/Sy0MIy37tyMuHjJn2W/WV6TD6v/uqba4WQGw5OxoX5Ea8VtP0
        f4xu0c9uw54sTeZkxyW7n7+3fY5CSECtjgnwrRN+WxTs/SOxsKe2teI8JmkyzSycurxpUD
        0+1fmvka4yUkupxcA7IMcfQqntMI4yE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-0aBF_Nn0Nr25IYed0YKBWA-1; Thu, 18 Nov 2021 10:30:50 -0500
X-MC-Unique: 0aBF_Nn0Nr25IYed0YKBWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38A71006AA3;
        Thu, 18 Nov 2021 15:30:49 +0000 (UTC)
Received: from localhost (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E55F1179B3;
        Thu, 18 Nov 2021 15:30:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: don't insert FUA request with data into scheduler queue
Date:   Thu, 18 Nov 2021 23:30:41 +0800
Message-Id: <20211118153041.2163228-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never insert flush request into scheduler queue before.

Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
blk_insert_flush") tries to handle FUA data request as normal request.
This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
case of kyber since RQF_ELVPRIV isn't set for flush request, then
->finish_request won't be called.

Fix the issue by inserting FUA data request with blk_mq_request_bypass_insert()
when the device supports FUA, just like what we did before.

[1] https://lore.kernel.org/linux-block/CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com/

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: d92ca9d8348f ("blk-mq: don't handle non-flush requests in blk_insert_flush")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 12 ++++++------
 block/blk-mq.c    |  4 +++-
 block/blk.h       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8e364bda5166..1fce6d16e6d3 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -379,7 +379,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
  * @rq is being submitted.  Analyze what needs to be done and put it on the
  * right queue.
  */
-bool blk_insert_flush(struct request *rq)
+void blk_insert_flush(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned long fflags = q->queue_flags;	/* may change, cache */
@@ -409,7 +409,7 @@ bool blk_insert_flush(struct request *rq)
 	 */
 	if (!policy) {
 		blk_mq_end_request(rq, 0);
-		return true;
+		return;
 	}
 
 	BUG_ON(rq->bio != rq->biotail); /*assumes zero or single bio rq */
@@ -420,8 +420,10 @@ bool blk_insert_flush(struct request *rq)
 	 * for normal execution.
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
-	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH)))
-		return false;
+	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
+		blk_mq_request_bypass_insert(rq, false, true);
+		return;
+	}
 
 	/*
 	 * @rq should go through flush machinery.  Mark it part of flush
@@ -437,8 +439,6 @@ bool blk_insert_flush(struct request *rq)
 	spin_lock_irq(&fq->mq_flush_lock);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
 	spin_unlock_irq(&fq->mq_flush_lock);
-
-	return true;
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c219271f9d6a..fa1a00d71b61 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2647,8 +2647,10 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
+	if (op_is_flush(bio->bi_opf)) {
+		blk_insert_flush(rq);
 		return;
+	}
 
 	if (plug && (q->nr_hw_queues == 1 ||
 	    blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
diff --git a/block/blk.h b/block/blk.h
index 4a910742cce9..7c6f7635bff0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -272,7 +272,7 @@ void __blk_account_io_done(struct request *req, u64 now);
  */
 #define ELV_ON_HASH(rq) ((rq)->rq_flags & RQF_HASHED)
 
-bool blk_insert_flush(struct request *rq);
+void blk_insert_flush(struct request *rq);
 
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
-- 
2.31.1

