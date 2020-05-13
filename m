Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1491C2D0F9
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CCC205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrUsSR2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgEMJ5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:57:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53487 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732755AbgEMJzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZSmOciSTSakM6Vtl7e8s66/+xEcnsSEhy1sbA1S8lg=;
        b=ZrUsSR2wmjr/F6IPiTOmUAmQDCJdX9SgsYdz6Hiv4uhKPai5pdSAutKBQUtdtJXNpBZnyb
        KmJn7lADqOxvXFxxaSTfZa9T/H6QhkODP3lgi5/Za9PJrDry7LFMeBw1PG6ZRwnJg4NHHe
        q/LGyGZb0q+7zLrRDydC0j0cZnkike4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-C8F3uCocMz-q2sXeOKJxyQ-1; Wed, 13 May 2020 05:55:43 -0400
X-MC-Unique: C8F3uCocMz-q2sXeOKJxyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA0BEC1A0;
        Wed, 13 May 2020 09:55:42 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2FB85C1BB;
        Wed, 13 May 2020 09:55:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 9/9] blk-mq: support batching dispatch in case of io scheduler
Date:   Wed, 13 May 2020 17:54:43 +0800
Message-Id: <20200513095443.2038859-10-ming.lei@redhat.com>
In-Reply-To: <20200513095443.2038859-1-ming.lei@redhat.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

[1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
[2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 76 +++++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.c       |  2 --
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 78fc8d80caaf..77d5093916b7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/list_sort.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,69 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
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
+static inline void blk_mq_do_dispatch_rq_lists(struct blk_mq_hw_ctx *hctx,
+		struct list_head *lists, bool multi_hctxs, unsigned count)
+{
+
+	if (likely(!multi_hctxs)) {
+		blk_mq_dispatch_rq_list(hctx, lists, true, count);
+		return;
+	}
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
+		blk_mq_dispatch_rq_list(rq->mq_hctx, &list, true, cnt);
+	}
+}
+
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
 /*
@@ -97,6 +161,9 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	LIST_HEAD(rq_list);
 	int ret = 0;
 	struct request *rq;
+	int cnt = 0;
+	unsigned int max_dispatch = blk_mq_sched_get_batching_nr(hctx);
+	bool multi_hctxs = false;
 
 	do {
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
@@ -130,7 +197,14 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true, 1));
+		cnt++;
+
+		if (rq->mq_hctx != hctx && !multi_hctxs)
+			multi_hctxs = true;
+	} while (cnt < max_dispatch);
+
+	if (cnt)
+		blk_mq_do_dispatch_rq_lists(hctx, &rq_list, multi_hctxs, cnt);
 
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bfdfdd61e663..b83c59d640b4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1319,8 +1319,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && got_budget);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-- 
2.25.2

