Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E5C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACD20665
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfHLNnr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:43:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfHLNnr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67D6530EA19E;
        Mon, 12 Aug 2019 13:43:46 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918851000324;
        Mon, 12 Aug 2019 13:43:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V2 3/5] blk-mq: stop to handle IO before hctx's all CPUs become offline
Date:   Mon, 12 Aug 2019 21:43:10 +0800
Message-Id: <20190812134312.16732-4-ming.lei@redhat.com>
In-Reply-To: <20190812134312.16732-1-ming.lei@redhat.com>
References: <20190812134312.16732-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 12 Aug 2019 13:43:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
up queue mapping. Thomas mentioned the following point[1]:

"
 That was the constraint of managed interrupts from the very beginning:

  The driver/subsystem has to quiesce the interrupt line and the associated
  queue _before_ it gets shutdown in CPU unplug and not fiddle with it
  until it's restarted by the core when the CPU is plugged in again.
"

However, current blk-mq implementation doesn't quiesce hw queue before
the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
one cpuhp state handled after the CPU is down, so there isn't any chance
to quiesce hctx for blk-mq wrt. CPU hotplug.

Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
and wait for completion of in-flight requests.

[1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c         |  2 +-
 block/blk-mq-tag.h         |  2 ++
 block/blk-mq.c             | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h     |  1 +
 include/linux/cpuhotplug.h |  1 +
 5 files changed, 70 insertions(+), 1 deletion(-)

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
index 6968de9d7402..6931b2ba2776 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2206,6 +2206,61 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
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
+static void blk_mq_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx->tags))
+			break;
+		msleep(5);
+	}
+}
+
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+	unsigned prev_cpu = -1;
+
+	while (true) {
+		unsigned next_cpu = cpumask_next_and(prev_cpu, hctx->cpumask,
+				cpu_online_mask);
+
+		if (next_cpu >= nr_cpu_ids)
+			break;
+
+		/* return if there is other online CPU on this hctx */
+		if (next_cpu != cpu)
+			return 0;
+
+		prev_cpu = next_cpu;
+	}
+
+	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
+	blk_mq_drain_inflight_rqs(hctx);
+
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2222,6 +2277,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
+	clear_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
+
 	spin_lock(&ctx->lock);
 	if (!list_empty(&ctx->rq_lists[type])) {
 		list_splice_init(&ctx->rq_lists[type], &tmp);
@@ -2242,6 +2299,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2301,6 +2361,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
+	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
@@ -3537,6 +3600,8 @@ static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
+				NULL, blk_mq_hctx_notify_online);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 838a22888413..49413dcdb6aa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -58,6 +58,7 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
+	struct hlist_node	cpuhp_online;
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 068793a619ca..bb80f52040cb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
+	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
-- 
2.20.1

