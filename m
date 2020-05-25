Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC3C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DF02073B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzDbETa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbgEYJij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 05:38:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389365AbgEYJii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590399517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4f5fk42qEpDF0lVE10DSXZj0FxTlGq73DImwMr62WP4=;
        b=CzDbETa7OM3JURqCi2c0Dy164fXzuxiUgDcJG5HGRVAK2F83xK/vaiKb7b+ueKSCnm4faf
        znhkB5sFhTpajkDHaqEoAAUL4DiYmmglfIixRy52WOsmeay+TK/tNY+/sVjb1XucyOvI/a
        wEnXVhL4xyo0gJL6VG439s1FX13AJNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-a5w-Rz9ZNx62wzjhC2Q0oA-1; Mon, 25 May 2020 05:38:35 -0400
X-MC-Unique: a5w-Rz9ZNx62wzjhC2Q0oA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B05AE100726B;
        Mon, 25 May 2020 09:38:33 +0000 (UTC)
Received: from localhost (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA40583858;
        Mon, 25 May 2020 09:38:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Date:   Mon, 25 May 2020 17:38:03 +0800
Message-Id: <20200525093807.805155-3-ming.lei@redhat.com>
In-Reply-To: <20200525093807.805155-1-ming.lei@redhat.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All requests in the 'list' of blk_mq_dispatch_rq_list belong to same
hctx, so it is better to pass hctx instead of request queue, because
blk-mq's dispatch target is hctx instead of request queue.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 14 ++++++--------
 block/blk-mq.c       |  6 +++---
 block/blk-mq.h       |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a31e281e9d31..632c6f8b63f7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -96,10 +96,9 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
 	int ret = 0;
+	struct request *rq;
 
 	do {
-		struct request *rq;
-
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
@@ -131,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
 
 	return ret;
 }
@@ -161,10 +160,9 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
 	int ret = 0;
+	struct request *rq;
 
 	do {
-		struct request *rq;
-
 		if (!list_empty_careful(&hctx->dispatch)) {
 			ret = -EAGAIN;
 			break;
@@ -200,7 +198,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		/* round robin for fair dispatch */
 		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
 
-	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
 	return ret;
@@ -240,7 +238,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
+		if (blk_mq_dispatch_rq_list(hctx, &rq_list, false)) {
 			if (has_sched_dispatch)
 				ret = blk_mq_do_dispatch_sched(hctx);
 			else
@@ -253,7 +251,7 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		ret = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(q, &rq_list, false);
+		blk_mq_dispatch_rq_list(hctx, &rq_list, false);
 	}
 
 	return ret;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 63f71ec09326..b0049f4d5128 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1233,10 +1233,10 @@ static void blk_mq_handle_zone_resource(struct request *rq,
 /*
  * Returns true if we did some work AND can potentially do more.
  */
-bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
+bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			     bool got_budget)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct request_queue *q = hctx->queue;
 	struct request *rq, *nxt;
 	bool no_tag = false;
 	int errors, queued;
@@ -1258,7 +1258,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 
 		rq = list_first_entry(list, struct request, queuelist);
 
-		hctx = rq->mq_hctx;
+		WARN_ON_ONCE(hctx != rq->mq_hctx);
 		if (!got_budget && !blk_mq_get_dispatch_budget(q)) {
 			blk_mq_put_driver_tag(rq);
 			no_budget_avail = true;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9540770de9dc..9c0e93d4fe38 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -40,7 +40,7 @@ struct blk_mq_ctx {
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *, bool);
+bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *, bool);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
-- 
2.25.2

