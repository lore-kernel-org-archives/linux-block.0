Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D263C47404
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D13A20830
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 02:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfJFCpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 22:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfJFCpv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Oct 2019 22:45:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFE7E83F3F;
        Sun,  6 Oct 2019 02:45:51 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFEC060872;
        Sun,  6 Oct 2019 02:45:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V2 RESEND 5/5] blk-mq: handle requests dispatched from IO scheduler in case that hctx is dead
Date:   Sun,  6 Oct 2019 10:45:16 +0800
Message-Id: <20191006024516.19996-6-ming.lei@redhat.com>
In-Reply-To: <20191006024516.19996-1-ming.lei@redhat.com>
References: <20191006024516.19996-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 06 Oct 2019 02:45:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If hctx becomes dead, all in-queue IO requests aimed at this hctx have to
be re-submitted, so cover requests queued in scheduler queue.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b35fdbd1f17..94fd47cef1bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2313,6 +2313,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	enum hctx_type type;
 	bool hctx_dead;
 	struct request *rq;
+	struct elevator_queue *e;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
@@ -2323,12 +2324,31 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	hctx_dead = cpumask_first_and(hctx->cpumask, cpu_online_mask) >=
 		nr_cpu_ids;
 
-	spin_lock(&ctx->lock);
-	if (!list_empty(&ctx->rq_lists[type])) {
-		list_splice_init(&ctx->rq_lists[type], &tmp);
-		blk_mq_hctx_clear_pending(hctx, ctx);
+	e = hctx->queue->elevator;
+	if (!e) {
+		spin_lock(&ctx->lock);
+		if (!list_empty(&ctx->rq_lists[type])) {
+			list_splice_init(&ctx->rq_lists[type], &tmp);
+			blk_mq_hctx_clear_pending(hctx, ctx);
+		}
+		spin_unlock(&ctx->lock);
+	} else if (hctx_dead) {
+		LIST_HEAD(sched_tmp);
+
+		while ((rq = e->type->ops.dispatch_request(hctx))) {
+			if (rq->mq_hctx != hctx)
+				list_add(&rq->queuelist, &sched_tmp);
+			else
+				list_add(&rq->queuelist, &tmp);
+		}
+
+		while (!list_empty(&sched_tmp)) {
+			rq = list_entry(sched_tmp.next, struct request,
+					queuelist);
+			list_del_init(&rq->queuelist);
+			blk_mq_sched_insert_request(rq, true, true, true);
+		}
 	}
-	spin_unlock(&ctx->lock);
 
 	if (list_empty(&tmp))
 		return 0;
-- 
2.20.1

