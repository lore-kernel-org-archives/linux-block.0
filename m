Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE39C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B887206A1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDbWXXWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2Nxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Nxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D604C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7DCVQEdPsEaLfO0RtH5p0pCV9P2DvBaAr3bo+N/V5T8=; b=lDbWXXWba56X7D8FAiOiXTkHv7
        JadG935URSn6UYVsS+4F8VeCAvGgaTvVzXOuiEMbihoYtRY/D3X9v0LotNjnjX827fTKmi5+Yfvlu
        9rrdXSRqzJNsTQlYyqazMIKtSSJ0P/IfV8/6hN2lQ/Tk+v73AiJXK28Y72A6Z6mgpnq91BniNSBuq
        vNuKjhX8c2M3LxeIm4kjh3gD9MKB79ddksbyQwD2+lEqAJmSy+Mc7s1Jwn80hQ56gPnTeMfyVZ5Rs
        kEIEFmtz92s4M+HmCsDLLqj/lV54o1zmFQpuYRiLGchitaSW2qBUD4lGJ2OYYjvu39P9W+k/on6Ug
        3pAYf1qQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefS7-0000rH-Ap; Fri, 29 May 2020 13:53:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Date:   Fri, 29 May 2020 15:53:15 +0200
Message-Id: <20200529135315.199230-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529135315.199230-1-hch@lst.de>
References: <20200529135315.199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
up queue mapping. Thomas mentioned the following point[1]:

"That was the constraint of managed interrupts from the very beginning:

 The driver/subsystem has to quiesce the interrupt line and the associated
 queue _before_ it gets shutdown in CPU unplug and not fiddle with it
 until it's restarted by the core when the CPU is plugged in again."

However, current blk-mq implementation doesn't quiesce hw queue before
the last CPU in the hctx is shutdown.  Even worse, CPUHP_BLK_MQ_DEAD is a
cpuhp state handled after the CPU is down, so there isn't any chance to
quiesce the hctx before shutting down the CPU.

Add new CPUHP_AP_BLK_MQ_ONLINE state to stop allocating from blk-mq hctxs
where the last CPU goes away, and wait for completion of in-flight
requests.  This guarantees that there is no inflight I/O before shutting
down the managed IRQ.

Add a BLK_MQ_F_STACKING and set it for dm-rq and loop, so we don't need
to wait for completion of in-flight requests from these drivers to avoid
a potential dead-lock. It is safe to do this for stacking drivers as those
do not use interrupts at all and their I/O completions are triggered by
underlying devices I/O completion.

[1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: different retry mechanism, merged two patches, minor cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |   8 +++
 block/blk-mq.c             | 112 ++++++++++++++++++++++++++++++++++++-
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 include/linux/blk-mq.h     |  10 ++++
 include/linux/cpuhotplug.h |   1 +
 7 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 96b7a35c898a7..15df3a36e9fa4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INACTIVE),
 };
 #undef HCTX_STATE_NAME
 
@@ -239,6 +240,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(TAG_SHARED),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
+	HCTX_FLAG_NAME(STACKING),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 762198b62088c..96a39d0724a29 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	/*
+	 * Give up this allocation if the hctx is inactive.  The caller will
+	 * retry on an active hctx.
+	 */
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
+		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
+		return BLK_MQ_NO_TAG;
+	}
 	return tag + tag_offset;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d8c17ab0c7c22..b005323f777a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -375,14 +375,30 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 			e->type->ops.limit_depth(data->cmd_flags, data);
 	}
 
+retry:
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
 	if (!(data->flags & BLK_MQ_REQ_INTERNAL))
 		blk_mq_tag_busy(data->hctx);
 
+	/*
+	 * Waiting allocations only fail because of an inactive hctx.  In that
+	 * case just retry the hctx assignment and tag allocation as CPU hotplug
+	 * should have migrated us to an online CPU by now.
+	 */
 	tag = blk_mq_get_tag(data);
-	if (tag == BLK_MQ_NO_TAG)
-		return NULL;
+	if (tag == BLK_MQ_NO_TAG) {
+		if (data->flags & BLK_MQ_REQ_NOWAIT)
+			return NULL;
+
+		/*
+		 * Give up the CPU and sleep for a random short time to ensure
+		 * that thread using a realtime scheduling class are migrated
+		 * off the the CPU, and thus off the hctx that is going away.
+		 */
+		msleep(3);
+		goto retry;
+	}
 	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 }
 
@@ -2324,6 +2340,86 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+struct rq_iter_data {
+	struct blk_mq_hw_ctx *hctx;
+	bool has_rq;
+};
+
+static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
+{
+	struct rq_iter_data *iter_data = data;
+
+	if (rq->mq_hctx != iter_data->hctx)
+		return true;
+	iter_data->has_rq = true;
+	return false;
+}
+
+static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->sched_tags ?
+			hctx->sched_tags : hctx->tags;
+	struct rq_iter_data data = {
+		.hctx	= hctx,
+	};
+
+	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
+	return data.has_rq;
+}
+
+static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
+		struct blk_mq_hw_ctx *hctx)
+{
+	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+		return false;
+	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
+		return false;
+	return true;
+}
+
+static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
+	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
+		return 0;
+
+	/*
+	 * Prevent new request from being allocated on the current hctx.
+	 *
+	 * The smp_mb__after_atomic() Pairs with the implied barrier in
+	 * test_and_set_bit_lock in sbitmap_get().  Ensures the inactive flag is
+	 * seen once we return from the tag allocator.
+	 */
+	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	smp_mb__after_atomic();
+
+	/*
+	 * Try to grab a reference to the queue and wait for any outstanding
+	 * requests.  If we could not grab a reference the queue has been
+	 * frozen and there are no requests.
+	 */
+	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
+		while (blk_mq_hctx_has_requests(hctx))
+			msleep(5);
+		percpu_ref_put(&hctx->queue->q_usage_counter);
+	}
+
+	return 0;
+}
+
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2337,6 +2433,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
@@ -2360,6 +2459,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2419,6 +2521,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
@@ -3673,6 +3778,9 @@ static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
+				blk_mq_hctx_notify_online,
+				blk_mq_hctx_notify_offline);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e5..d7904b4d8d126 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2037,7 +2037,7 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3f8577e2c13be..f60c025121215 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	md->tag_set->ops = &dm_mq_ops;
 	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
 	md->tag_set->numa_node = md->numa_node_id;
-	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
+	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
 	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
 	md->tag_set->driver_data = md;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a4..a20f8c241d665 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,6 +140,8 @@ struct blk_mq_hw_ctx {
 	 */
 	atomic_t		nr_active;
 
+	/** @cpuhp_online: List to store request if CPU is going to die */
+	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
 	struct hlist_node	cpuhp_dead;
 	/** @kobj: Kernel object for sysfs. */
@@ -391,6 +393,11 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
+	/*
+	 * Set when this device requires underlying blk-mq device for
+	 * completing IO:
+	 */
+	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
@@ -400,6 +407,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE	= 3,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 77d70b6335318..24b3a77810b6d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
+	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
-- 
2.26.2

