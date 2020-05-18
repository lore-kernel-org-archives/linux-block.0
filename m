Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78EC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC46207C4
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Of5bO4U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgERGkG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:40:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D0C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wvuVef6Gq7IaKrd5ggX6dBkWn6Ka02KswgIUTAoLUuY=; b=Of5bO4U9LtM11TmQaJ7+XYhZ5r
        QsSB66pr3NnnD9VNWZ71LcF/WnaDKvvPZPtdbQOL+npDI1Fck5vN82aoru5dXmSgLxhdtjiOSuxZh
        E8JNej5y3w8WL7RaGPRB0upKyKyK8XN8aHcgaFw3dEAttRNrRLqSky/rPInqkHBea92v3eWrp/1hS
        z/vIi5S2dyCYt0RS5SG7IhkomSOIfRCnAJyTpdA0sci+EXiYNDAqJH3OfDg9f3t2UBiOeqVxL6OWh
        np19wOcpNxPh+RmpgrgOYtuAwOJJlCXayizJ8QgtgQUaMxvgWtVN8/QUO90Lfl/vqwkbvyp5cC2sG
        wf0WuZSA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRV-00021j-GP; Mon, 18 May 2020 06:40:06 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 9/9] blk-mq: drain I/O when all CPUs in a hctx are offline
Date:   Mon, 18 May 2020 08:39:37 +0200
Message-Id: <20200518063937.757218-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
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
the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
one cpuhp state handled after the CPU is down, so there isn't any chance
to quiesce hctx for blk-mq wrt. CPU hotplug.

Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
and wait for completion of in-flight requests.

We will stop request allocation on any cpu in hctx->cpumask and wait for
completion of all allocated requests when one hctx is becoming inactive in
the following patch. This way may cause dead-lock for some stacking blk-mq
drivers, such as dm-rq and loop.

Before one CPU becomes offline, check if it is the last online CPU of hctx.
If yes, mark this hctx as inactive, meantime wait for completion of all
allocated requests originated from this hctx. Meantime check if this
hctx has become inactive during allocating request, if yes, give up it
and retry from new online CPU.

This way guarantees that there isn't any inflight I/O before shutdown the
managed IRQ line when all CPUs of this IRQ line is offline.

Add a BLK_MQ_F_STACKING and set it for dm-rq and loop, so we don't need
to wait for completion of in-flight requests from these drivers to avoid
a potential dead-lock. It is safe to do this for stacking drivers as those
do not use interrupts at all and their I/O completions are triggered by
underlying devices I/O completion.

[1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: rebased, merged two patches, slightly simplified a few helpers,
      use a while loop to keep trying until we find an online CPU]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c     |  2 +
 block/blk-mq-tag.c         |  8 ++++
 block/blk-mq.c             | 98 ++++++++++++++++++++++++++++++++++++++
 drivers/block/loop.c       |  2 +-
 drivers/md/dm-rq.c         |  2 +-
 include/linux/blk-mq.h     | 10 ++++
 include/linux/cpuhotplug.h |  1 +
 7 files changed, 121 insertions(+), 2 deletions(-)

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
index b4b8d4e8e6e20..8c05b952e98a9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -187,6 +187,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	/*
+	 * Give up this allocation if the hctx is inactive.  The caller will
+	 * retry on an active hctx.
+	 */
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
+		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
+		goto fail;
+	}
 	preempt_enable();
 	return tag + tag_offset;
 fail:
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 74c2d8f61426c..6fc25936568cb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -403,6 +403,8 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		return ERR_PTR(ret);
 
 	rq = __blk_mq_alloc_request(&data);
+	while (unlikely(!rq && !(flags & BLK_MQ_REQ_NOWAIT)))
+		rq = __blk_mq_alloc_request_on_cpumask(cpu_online_mask, &data);
 	if (!rq)
 		goto out_queue_exit;
 	rq->__data_len = 0;
@@ -2010,8 +2012,14 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
+	/*
+	 * Waiting allocations only fail because of an inactive hctx, retry on
+	 * an online CPU in that case.
+	 */
 	data.cmd_flags = bio->bi_opf;
 	rq = __blk_mq_alloc_request(&data);
+	while (unlikely(!rq && !(data.cmd_flags & REQ_NOWAIT)))
+		rq = __blk_mq_alloc_request_on_cpumask(cpu_online_mask, &data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
@@ -2283,6 +2291,84 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+struct rq_iter_data {
+	bool has_rq;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
+{
+	struct rq_iter_data *iter_data = data;
+
+	if (rq->mq_hctx == iter_data->hctx) {
+		iter_data->has_rq = true;
+		return false;
+	}
+
+	return true;
+}
+
+static bool blk_mq_tags_has_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
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
+	struct request_queue *q = hctx->queue;
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
+	if (!blk_mq_last_cpu_in_hctx(cpu, hctx))
+		return 0;
+
+	/* Prevent new request from being allocated on the current hctx/cpu */
+	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+
+	/*
+	 * Grab one refcount for avoiding scheduler switch, and
+	 * return immediately if queue has been frozen.
+	 */
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return 0;
+
+	/* wait until all requests in this hctx are gone */
+	while (blk_mq_tags_has_request(hctx))
+		msleep(5);
+
+	percpu_ref_put(&q->q_usage_counter);
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
@@ -2296,6 +2382,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
@@ -2319,6 +2408,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2378,6 +2470,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
+	if (!(hctx->flags & BLK_MQ_F_STACKING))
+		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
+				&hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
@@ -3632,6 +3727,9 @@ static int __init blk_mq_init(void)
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

