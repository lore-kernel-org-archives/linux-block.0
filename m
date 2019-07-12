Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640AC742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98CC214AF
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfGLCsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfGLCsL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E259A308FC22;
        Fri, 12 Jul 2019 02:48:10 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06E291001DC0;
        Fri, 12 Jul 2019 02:48:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH 6/7] blk-mq: re-submit IO in case that hctx is dead
Date:   Fri, 12 Jul 2019 10:47:25 +0800
Message-Id: <20190712024726.1227-7-ming.lei@redhat.com>
In-Reply-To: <20190712024726.1227-1-ming.lei@redhat.com>
References: <20190712024726.1227-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 12 Jul 2019 02:48:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in one hctx are offline, we shouldn't run this hw queue
for completing request any more.

So steal bios from the request, and resubmit them, and finally free
the request in blk_mq_hctx_notify_dead().

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 028c5d78e409..e4588d30840c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2263,10 +2263,32 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static void blk_mq_resubmit_io(struct request *rq)
+{
+	struct bio_list list;
+	struct request_queue *q = rq->q;
+	struct bio *bio;
+
+	bio_list_init(&list);
+	blk_steal_bios(&list, rq);
+
+	while (true) {
+		bio = bio_list_pop(&list);
+		if (!bio)
+			break;
+
+		generic_make_request(bio);
+	}
+
+	if (q->mq_ops->free_request)
+		q->mq_ops->free_request(rq);
+	blk_mq_end_request(rq, 0);
+}
+
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * 'cpu' has gone away. If this hctx is dead, we can't dispatch request
+ * to the hctx any more, so steal bios from requests of this hctx, and
+ * re-submit them to the request queue, and free these requests finally.
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
@@ -2274,6 +2296,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
+	bool hctx_dead;
+	struct request *rq;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
@@ -2282,6 +2306,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (test_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state))
 		clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
 
+	hctx_dead = cpumask_first_and(hctx->cpumask, cpu_online_mask) >=
+		nr_cpu_ids;
+
 	spin_lock(&ctx->lock);
 	if (!list_empty(&ctx->rq_lists[type])) {
 		list_splice_init(&ctx->rq_lists[type], &tmp);
@@ -2292,11 +2319,20 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (list_empty(&tmp))
 		return 0;
 
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	if (!hctx_dead) {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+		blk_mq_run_hw_queue(hctx, true);
+		return 0;
+	}
+
+	while (!list_empty(&tmp)) {
+		rq = list_entry(tmp.next, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_io(rq);
+	}
 
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
 
-- 
2.20.1

