Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A5C433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9433B20734
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 09:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHukx5CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFCJo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:44:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgFCJo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 05:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591177465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaQOnvNQ5JddZ5aUPe4W1eRbYfnbBNmX87793NOtAvw=;
        b=jHukx5CJwkbbwc6l0bLcoSUf/5Nn4CfiWI4pmrkewTGRGgPOUH+0DC5revnyApyncIhLGa
        4hiNcdhRu/bQfnHW6LdfaF5naitaqksxN/Vm/g+zcEm/270g7bwZhT/jBJfMdrth1ckNTP
        eDfJIzsepCeZC6NlCKbDV06G2o0lEY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-oiTBJydgPoWTgmGOR8s3vw-1; Wed, 03 Jun 2020 05:44:23 -0400
X-MC-Unique: oiTBJydgPoWTgmGOR8s3vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD63DEC1A0;
        Wed,  3 Jun 2020 09:44:21 +0000 (UTC)
Received: from localhost (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8095810013C0;
        Wed,  3 Jun 2020 09:44:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V5 6/6] blk-mq: support batching dispatch in case of io scheduler
Date:   Wed,  3 Jun 2020 17:43:37 +0800
Message-Id: <20200603094337.2064181-7-ming.lei@redhat.com>
In-Reply-To: <20200603094337.2064181-1-ming.lei@redhat.com>
References: <20200603094337.2064181-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 block/blk-mq-sched.c | 96 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-mq.c       |  2 -
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4c72073830f3..02ba7e86cce3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/list_sort.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,74 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 	blk_mq_run_hw_queue(hctx, true);
 }
 
+/*
+ * We know bfq and deadline apply single scheduler queue instead of multi
+ * queue. However, the two are often used on single queue devices, also
+ * the current @hctx should affect the real device status most of times
+ * because of locality principle.
+ *
+ * So use current hctx->dispatch_busy directly for figuring out batching
+ * dispatch count.
+ */
+static unsigned int blk_mq_sched_get_batching_nr(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->dispatch_busy)
+		return 1;
+	return hctx->queue->nr_requests;
+}
+
+static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct request *rqa = container_of(a, struct request, queuelist);
+	struct request *rqb = container_of(b, struct request, queuelist);
+
+	return rqa->mq_hctx > rqb->mq_hctx;
+}
+
+static inline bool blk_mq_do_dispatch_rq_lists(struct blk_mq_hw_ctx *hctx,
+		struct list_head *lists, bool multi_hctxs, unsigned count)
+{
+	bool ret;
+
+	if (!count)
+		return false;
+
+	if (likely(!multi_hctxs))
+		return blk_mq_dispatch_rq_list(hctx, lists, count);
+
+	/*
+	 * Requests from different hctx may be dequeued from some scheduler,
+	 * such as bfq and deadline.
+	 *
+	 * Sort the requests in the list according to their hctx, dispatch
+	 * batching requests from same hctx
+	 */
+	list_sort(NULL, lists, sched_rq_cmp);
+
+	ret = false;
+	while (!list_empty(lists)) {
+		LIST_HEAD(list);
+		struct request *new, *rq = list_first_entry(lists,
+				struct request, queuelist);
+		unsigned cnt = 0;
+
+		list_for_each_entry(new, lists, queuelist) {
+			if (new->mq_hctx != rq->mq_hctx)
+				break;
+			cnt++;
+		}
+
+		if (new->mq_hctx == rq->mq_hctx)
+			list_splice_tail_init(lists, &list);
+		else
+			list_cut_before(&list, lists, &new->queuelist);
+
+		ret = blk_mq_dispatch_rq_list(rq->mq_hctx, &list, cnt);
+	}
+
+	return ret;
+}
+
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
 /*
@@ -97,7 +166,15 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	LIST_HEAD(rq_list);
 	int ret = 0;
 	struct request *rq;
-
+	int cnt;
+	unsigned int max_dispatch;
+	bool multi_hctxs, run_queue;
+
+ again:
+	/* prepare one batch for dispatch */
+	cnt = 0;
+	max_dispatch = blk_mq_sched_get_batching_nr(hctx);
+	multi_hctxs = run_queue = false;
 	do {
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
@@ -120,7 +197,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			 * no guarantee anyone will kick the queue.  Kick it
 			 * ourselves.
 			 */
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+			run_queue = true;
 			break;
 		}
 
@@ -130,7 +207,20 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+		cnt++;
+
+		if (rq->mq_hctx != hctx && !multi_hctxs)
+			multi_hctxs = true;
+	} while (cnt < max_dispatch);
+
+	/* dispatch more if we may do more */
+	if (blk_mq_do_dispatch_rq_lists(hctx, &rq_list, multi_hctxs, cnt) &&
+			!ret)
+		goto again;
+
+	/* in-flight request's completion can rerun queue */
+	if (!cnt && run_queue)
+		blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
 
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index adb2e81c1aac..a98a19353461 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1297,8 +1297,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && nr_budgets);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-- 
2.25.2

