Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE1C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 04:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C12520867
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 04:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfJHESv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:18:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfJHESu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Oct 2019 00:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BE213065450;
        Tue,  8 Oct 2019 04:18:50 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 594725D70D;
        Tue,  8 Oct 2019 04:18:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V3 3/5] blk-mq: stop to handle IO and drain IO before hctx becomes dead
Date:   Tue,  8 Oct 2019 12:18:19 +0800
Message-Id: <20191008041821.2782-4-ming.lei@redhat.com>
In-Reply-To: <20191008041821.2782-1-ming.lei@redhat.com>
References: <20191008041821.2782-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 08 Oct 2019 04:18:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU
of hctx. If yes, mark this hctx as BLK_MQ_S_INTERNAL_STOPPED, meantime
wait for completion of all in-flight IOs originated from this hctx.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq-tag.h |  2 ++
 block/blk-mq.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 008388e82b5c..31828b82552b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -325,7 +325,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..321fd6f440e6 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a664f196782a..3384242202eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2225,8 +2225,46 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
+{
+	unsigned *count = data;
+
+	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
+		(*count)++;
+
+	return true;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
+{
+	unsigned count = 0;
+
+	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
+
+	return count;
+}
+
+static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx->tags))
+			break;
+		msleep(5);
+	}
+}
+
 static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 {
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) == cpu) &&
+	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) >=
+	     nr_cpu_ids)) {
+		set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
+		blk_mq_hctx_drain_inflight_rqs(hctx);
+        }
 	return 0;
 }
 
@@ -2246,6 +2284,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
+	clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
+
 	spin_lock(&ctx->lock);
 	if (!list_empty(&ctx->rq_lists[type])) {
 		list_splice_init(&ctx->rq_lists[type], &tmp);
-- 
2.20.1

