Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192EEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354874AbiELOA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354839AbiELOAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 10:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4471E15D3
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652364017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wBRhvzOm8tviAzCWarzupagnhcKdDUHar2A5ckt2EpM=;
        b=UAGWAwn5vpX/KbKSzlwhnSwdo2VE8Ez9MgbZCpRIMpr1MrtHBRwO6V4eYVW2wRdCDJDbvq
        MiG74JIZi4Qfjxq4+wzDVQkoCKYVYHChntb072Eiw1uUu0Rp9KSR3k2SUv/dqDTP9s20pN
        9GnOi+cTvqEcA6FLS48416v0PDXW5m0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-St9HtqVPNW6KpqMXvpDPaQ-1; Thu, 12 May 2022 10:00:16 -0400
X-MC-Unique: St9HtqVPNW6KpqMXvpDPaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB473101AA42;
        Thu, 12 May 2022 14:00:15 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AA5C41617C;
        Thu, 12 May 2022 14:00:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: fix passthrough plugging
Date:   Thu, 12 May 2022 22:00:10 +0800
Message-Id: <20220512140010.1458645-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First we can't add request into plug list in blk_mq_request_bypass_insert
which may be called when flushing plug list, so nested plug is caused.

Second if polled passthrough request is inserted via blk_execute_rq(),
it can't be added to plug list too since io polling needs the request
to be issued to driver.

Fixes the two by moving plugging into blk_execute_rq_no_wait().

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 1c2d2fff6dc0 ("block: wire-up support for passthrough plugging")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 114 +++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 51 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2cf011b57cf9..ed1869a305c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1169,6 +1169,62 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 	complete(waiting);
 }
 
+/*
+ * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
+ * queues. This is important for md arrays to benefit from merging
+ * requests.
+ */
+static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
+{
+	if (plug->multiple_queues)
+		return BLK_MAX_REQUEST_COUNT * 2;
+	return BLK_MAX_REQUEST_COUNT;
+}
+
+static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
+{
+	struct request *last = rq_list_peek(&plug->mq_list);
+
+	if (!plug->rq_count) {
+		trace_block_plug(rq->q);
+	} else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
+		   (!blk_queue_nomerges(rq->q) &&
+		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+		blk_mq_flush_plug_list(plug, false);
+		trace_block_plug(rq->q);
+	}
+
+	if (!plug->multiple_queues && last && last->q != rq->q)
+		plug->multiple_queues = true;
+	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+		plug->has_elevator = true;
+	rq->rq_next = NULL;
+	rq_list_add(&plug->mq_list, rq);
+	plug->rq_count++;
+}
+
+static void __blk_execute_rq_nowait(struct request *rq, bool at_head,
+		rq_end_io_fn *done, bool use_plug)
+{
+	WARN_ON(irqs_disabled());
+	WARN_ON(!blk_rq_is_passthrough(rq));
+
+	rq->end_io = done;
+
+	blk_account_io_start(rq);
+
+	if (use_plug && current->plug) {
+		blk_add_rq_to_plug(current->plug, rq);
+		return;
+	}
+	/*
+	 * don't check dying flag for MQ because the request won't
+	 * be reused after dying flag is set
+	 */
+	blk_mq_sched_insert_request(rq, at_head, true, false);
+}
+
+
 /**
  * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @rq:		request to insert
@@ -1184,18 +1240,8 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
  */
 void blk_execute_rq_nowait(struct request *rq, bool at_head, rq_end_io_fn *done)
 {
-	WARN_ON(irqs_disabled());
-	WARN_ON(!blk_rq_is_passthrough(rq));
-
-	rq->end_io = done;
+	__blk_execute_rq_nowait(rq, at_head, done, true);
 
-	blk_account_io_start(rq);
-
-	/*
-	 * don't check dying flag for MQ because the request won't
-	 * be reused after dying flag is set
-	 */
-	blk_mq_sched_insert_request(rq, at_head, true, false);
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
@@ -1233,8 +1279,13 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
 
+	/*
+	 * iopoll requires request to be submitted to driver, so can't
+	 * use plug
+	 */
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(rq, at_head, blk_end_sync_rq);
+	__blk_execute_rq_nowait(rq, at_head, blk_end_sync_rq,
+			!blk_rq_is_poll(rq));
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
@@ -2340,40 +2391,6 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
 
-/*
- * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
- * queues. This is important for md arrays to benefit from merging
- * requests.
- */
-static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
-{
-	if (plug->multiple_queues)
-		return BLK_MAX_REQUEST_COUNT * 2;
-	return BLK_MAX_REQUEST_COUNT;
-}
-
-static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
-{
-	struct request *last = rq_list_peek(&plug->mq_list);
-
-	if (!plug->rq_count) {
-		trace_block_plug(rq->q);
-	} else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
-		   (!blk_queue_nomerges(rq->q) &&
-		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
-		blk_mq_flush_plug_list(plug, false);
-		trace_block_plug(rq->q);
-	}
-
-	if (!plug->multiple_queues && last && last->q != rq->q)
-		plug->multiple_queues = true;
-	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
-		plug->has_elevator = true;
-	rq->rq_next = NULL;
-	rq_list_add(&plug->mq_list, rq);
-	plug->rq_count++;
-}
-
 /**
  * blk_mq_request_bypass_insert - Insert a request at dispatch list.
  * @rq: Pointer to request to be inserted.
@@ -2387,12 +2404,7 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 				  bool run_queue)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-	struct blk_plug *plug = current->plug;
 
-	if (plug) {
-		blk_add_rq_to_plug(plug, rq);
-		return;
-	}
 	spin_lock(&hctx->lock);
 	if (at_head)
 		list_add(&rq->queuelist, &hctx->dispatch);
-- 
2.31.1

