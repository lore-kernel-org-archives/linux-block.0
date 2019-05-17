Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F366C04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 09:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A33420818
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 09:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfEQJOl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 05:14:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbfEQJOl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 05:14:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25579307D925;
        Fri, 17 May 2019 09:14:40 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B739A348F4;
        Fri, 17 May 2019 09:14:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
Date:   Fri, 17 May 2019 17:14:24 +0800
Message-Id: <20190517091424.19751-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 17 May 2019 09:14:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Managed interrupts can not migrate affinity when their CPUs are offline.
If the CPU is allowed to shutdown before they're returned, commands
dispatched to managed queues won't be able to complete through their
irq handlers.

Wait in cpu hotplug handler until all inflight requests on the tags
are completed or timeout. Wait once for each tags, so we can save time
in case of shared tags.

Based on the following patch from Keith, and use simple delay-spin
instead.

https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq-tag.h |  5 ++++
 block/blk-mq.c     | 65 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..b24334f99c5d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -332,7 +332,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..f8de50485b42 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -19,6 +19,9 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	#define BLK_MQ_TAGS_DRAINED           0
+	unsigned long flags;
 };
 
 
@@ -35,6 +38,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08a6248d8536..d1d1b1a9628f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2214,6 +2214,60 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx	*hctx;
+	struct blk_mq_tags	*tags;
+
+	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	tags = hctx->tags;
+
+	if (tags)
+		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
+
+	return 0;
+}
+
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
+{
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
+		(*(unsigned long *)data)++;
+
+	return true;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
+{
+	unsigned long cnt = 0;
+
+	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &cnt);
+
+	return cnt;
+}
+
+static void blk_mq_drain_inflight_rqs(struct blk_mq_tags *tags, int dead_cpu)
+{
+	unsigned long msecs_left = 1000 * 5;
+
+	if (!tags)
+		return;
+
+	if (test_and_set_bit(BLK_MQ_TAGS_DRAINED, &tags->flags))
+		return;
+
+	while (msecs_left > 0) {
+		if (!blk_mq_tags_inflight_rqs(tags))
+			break;
+		msleep(5);
+		msecs_left -= 5;
+	}
+
+	if (msecs_left > 0)
+		printk(KERN_WARNING "requests not completed from dead "
+				"CPU %d\n", dead_cpu);
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2245,6 +2299,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
+
+	/*
+	 * Interrupt for this queue will be shutdown, so wait until all
+	 * requests from this hw queue is done or timeout.
+	 */
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)
+		blk_mq_drain_inflight_rqs(hctx->tags, cpu);
+
 	return 0;
 }
 
@@ -3540,7 +3602,8 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
 
 static int __init blk_mq_init(void)
 {
-	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
+	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead",
+				blk_mq_hctx_notify_prepare,
 				blk_mq_hctx_notify_dead);
 	return 0;
 }
-- 
2.20.1

