Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB91CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 02:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiFOChc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiFOCha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 22:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE4271838F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655260648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oz11FmYWgVYB0jYAc9oiAn6P4BNa9hSCEvt0wJZ5CF0=;
        b=efjr5pX3dA8hIm1JBmRaXMkbmd+9O9R2GZujsXfODEJnKmWMpidEoP03HYQthkYlJv+TDH
        t/MxkGtVQ1hkQTqW5g5/I7ICokGmMlg/2bAmzpIFjUB5Opwf2Rpj8RgztXWieKdyBLODKj
        hNI64ywX5MCb/o4hEc+TjFjfWsw9BSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-A7AA-YvDNfqkavq5WEq9nA-1; Tue, 14 Jun 2022 22:37:27 -0400
X-MC-Unique: A7AA-YvDNfqkavq5WEq9nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABFB6811E7A;
        Wed, 15 Jun 2022 02:37:26 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3CB040CF8E5;
        Wed, 15 Jun 2022 02:37:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] blk-mq: avoid to touch q->elevator without any protection
Date:   Wed, 15 Jun 2022 10:37:11 +0800
Message-Id: <20220615023712.750122-3-ming.lei@redhat.com>
In-Reply-To: <20220615023712.750122-1-ming.lei@redhat.com>
References: <20220615023712.750122-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->elevator is referred in blk_mq_has_sqsched() without any protection,
no .q_usage_counter is held, no queue srcu and rcu read lock is held,
so potential use-after-free may be triggered.

Fix the issue by adding one queue flag for checking if the elevator
uses single queue style dispatch.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 18 ++----------------
 block/elevator.c       | 10 ++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22a89c758f70..112dce569192 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2140,20 +2140,6 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
-/*
- * Is the request queue handled by an IO scheduler that does not respect
- * hardware queues when dispatching?
- */
-static bool blk_mq_has_sqsched(struct request_queue *q)
-{
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.dispatch_request &&
-	    !(e->type->elevator_features & ELEVATOR_F_MQ_AWARE))
-		return true;
-	return false;
-}
-
 /*
  * Return prefered queue to dispatch from (if any) for non-mq aware IO
  * scheduler.
@@ -2186,7 +2172,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	unsigned long i;
 
 	sq_hctx = NULL;
-	if (blk_mq_has_sqsched(q))
+	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
@@ -2214,7 +2200,7 @@ void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 	unsigned long i;
 
 	sq_hctx = NULL;
-	if (blk_mq_has_sqsched(q))
+	if (blk_queue_sq_sched(q))
 		sq_hctx = blk_mq_get_sq_hctx(q);
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_hctx_stopped(hctx))
diff --git a/block/elevator.c b/block/elevator.c
index c319765892bb..a2355acd2780 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -612,6 +612,16 @@ int elevator_switch_mq(struct request_queue *q,
 		}
 	}
 
+	/*
+	 * Is the request queue handled by an IO scheduler that does not
+	 * respect hardware queues when dispatching?
+	 */
+	if (new_e && new_e->ops.dispatch_request &&
+	    !(new_e->elevator_features & ELEVATOR_F_MQ_AWARE))
+		blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+
 	if (new_e)
 		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
 	else
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 608d577734c2..ea6ccaeba643 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,6 +575,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -616,6 +617,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.31.1

