Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E58C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C86820771
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 10:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Oe083e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbgF3KZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:25:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732512AbgF3KZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 06:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593512755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZS4p+DNW99uJ1FMui7I5DY160q67sO6CUqLxyjtRLY=;
        b=U1Oe083eeymnpvFSUxmXnoheROh/2t5WNLadnTY9t/ruLcFVQst01Z5bH6FKiGg9wzQeRd
        ae/CdPzYf7JrkVNJFhYi9NS/50SQ/MaMAKNtdd5bkBRLLCt8wnUxyaT5BZb6Xu10n3HCOk
        p717rxYx94S03K+RkgvLRZk9XpA31w0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-0zFzSOxMM5C5xt9CQmUYeA-1; Tue, 30 Jun 2020 06:25:45 -0400
X-MC-Unique: 0zFzSOxMM5C5xt9CQmUYeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D801D80183C;
        Tue, 30 Jun 2020 10:25:43 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8136360C81;
        Tue, 30 Jun 2020 10:25:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V7 6/6] blk-mq: support batching dispatch in case of io
Date:   Tue, 30 Jun 2020 18:25:01 +0800
Message-Id: <20200630102501.2238972-7-ming.lei@redhat.com>
In-Reply-To: <20200630102501.2238972-1-ming.lei@redhat.com>
References: <20200630102501.2238972-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

More and more drivers want to get batching requests queued from
block layer, such as mmc, and tcp based storage drivers. Also
current in-tree users have virtio-scsi, virtio-blk and nvme.

For none, we already support batching dispatch.

But for io scheduler, every time we just take one request from scheduler
and pass the single request to blk_mq_dispatch_rq_list(). This way makes
batching dispatch not possible when io scheduler is applied. One reason
is that we don't want to hurt sequential IO performance, becasue IO
merge chance is reduced if more requests are dequeued from scheduler
queue.

Try to support batching dispatch for io scheduler by starting with the
following simple approach:

1) still make sure we can get budget before dequeueing request

2) use hctx->dispatch_busy to evaluate if queue is busy, if it is busy
we fackback to non-batching dispatch, otherwise dequeue as many as
possible requests from scheduler, and pass them to blk_mq_dispatch_rq_list().

Wrt. 2), we use similar policy for none, and turns out that SCSI SSD
performance got improved much.

In future, maybe we can develop more intelligent algorithem for batching
dispatch.

Baolin has tested this patch and found that MMC performance is improved[3].

[1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
[2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/
[3] https://lore.kernel.org/linux-block/CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com/

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Tested-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 89 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-mq.c       |  2 -
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4c72073830f3..1c52e56a19b1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/list_sort.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,37 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 	blk_mq_run_hw_queue(hctx, true);
 }
 
+static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct request *rqa = container_of(a, struct request, queuelist);
+	struct request *rqb = container_of(b, struct request, queuelist);
+
+	return rqa->mq_hctx > rqb->mq_hctx;
+}
+
+static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
+{
+	struct blk_mq_hw_ctx *hctx =
+		list_first_entry(rq_list, struct request, queuelist)->mq_hctx;
+	struct request *rq;
+	LIST_HEAD(hctx_list);
+	unsigned int count = 0;
+	bool ret;
+
+	list_for_each_entry(rq, rq_list, queuelist) {
+		if (rq->mq_hctx != hctx) {
+			list_cut_before(&hctx_list, rq_list, &rq->queuelist);
+			goto dispatch;
+		}
+		count++;
+	}
+	list_splice_tail_init(rq_list, &hctx_list);
+
+dispatch:
+	ret = blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
+	return ret;
+}
+
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
 /*
@@ -90,20 +122,29 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
  * be run again.  This is necessary to avoid starving flushes.
  */
-static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
+	bool multi_hctxs = false, run_queue = false;
+	bool dispatched = false, busy = false;
+	unsigned int max_dispatch;
 	LIST_HEAD(rq_list);
-	int ret = 0;
-	struct request *rq;
+	int count = 0;
+
+	if (hctx->dispatch_busy)
+		max_dispatch = 1;
+	else
+		max_dispatch = hctx->queue->nr_requests;
 
 	do {
+		struct request *rq;
+
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
 		if (!list_empty_careful(&hctx->dispatch)) {
-			ret = -EAGAIN;
+			busy = true;
 			break;
 		}
 
@@ -120,7 +161,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			 * no guarantee anyone will kick the queue.  Kick it
 			 * ourselves.
 			 */
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+			run_queue = true;
 			break;
 		}
 
@@ -129,8 +170,42 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * if this rq won't be queued to driver via .queue_rq()
 		 * in blk_mq_dispatch_rq_list().
 		 */
-		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+		list_add_tail(&rq->queuelist, &rq_list);
+		if (rq->mq_hctx != hctx)
+			multi_hctxs = true;
+	} while (++count < max_dispatch);
+
+	if (!count) {
+		if (run_queue)
+			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+	} else if (multi_hctxs) {
+		/*
+		 * Requests from different hctx may be dequeued from some
+		 * schedulers, such as bfq and deadline.
+		 *
+		 * Sort the requests in the list according to their hctx,
+		 * dispatch batching requests from same hctx at a time.
+		 */
+		list_sort(NULL, &rq_list, sched_rq_cmp);
+		do {
+			dispatched |= blk_mq_dispatch_hctx_list(&rq_list);
+		} while (!list_empty(&rq_list));
+	} else {
+		dispatched = blk_mq_dispatch_rq_list(hctx, &rq_list, count);
+	}
+
+	if (busy)
+		return -EAGAIN;
+	return !!dispatched;
+}
+
+static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+{
+	int ret;
+
+	do {
+		ret = __blk_mq_do_dispatch_sched(hctx);
+	} while (ret == 1);
 
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2b10243bcd0d..257d0e0e544d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1375,8 +1375,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && nr_budgets);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-- 
2.25.2

