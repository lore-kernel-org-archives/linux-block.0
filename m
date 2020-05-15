Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEAC433E4
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C7020671
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5OZ9GZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgEOBnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 21:43:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbgEOBmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 21:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589506970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6a02fBfLYBRoEDl3z8C/5k6hd1rp7cTSm1L4whG44b4=;
        b=O5OZ9GZPOd3EjwYZO/jLtGciw9hHSH66n5CHUj/eOryEbe0rXyjtlyhAzRgZw7ylkBILfR
        LhDqYRYk2p/TfUzqu7jpXVWd0M+d5NodrfygVURyFZDJkOYksKSronbHXn7mqkqoc8UZB6
        zAATVHIgDBrf755bYQujZGGEelB+1ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-pWvprKqKMDu2ErEZvXqmrA-1; Thu, 14 May 2020 21:42:42 -0400
X-MC-Unique: pWvprKqKMDu2ErEZvXqmrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DED6D461;
        Fri, 15 May 2020 01:42:40 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB275D9D7;
        Fri, 15 May 2020 01:42:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6/6] blk-mq: stop to allocate new requst and drain request before hctx becomes inactive
Date:   Fri, 15 May 2020 09:41:53 +0800
Message-Id: <20200515014153.2403464-7-ming.lei@redhat.com>
In-Reply-To: <20200515014153.2403464-1-ming.lei@redhat.com>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU of hctx.
If yes, mark this hctx as inactive, meantime wait for completion of all
allocated IO requests originated from this hctx. Meantime check if this
hctx has become inactive during allocating request, if yes, give up it
and retry from new online CPU.

This way guarantees that there isn't any inflight IO before shutdown
the managed IRQ line when all CPUs of this IRQ line is offline.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |   1 +
 block/blk-mq-tag.c     |  10 ++++
 block/blk-mq.c         | 122 +++++++++++++++++++++++++++++++++++++----
 include/linux/blk-mq.h |   3 +
 4 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6d40eff04524..15df3a36e9fa 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INACTIVE),
 };
 #undef HCTX_STATE_NAME
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0ae79ca6e2da..c8e34c1f547f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -184,6 +184,16 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	/*
+	 * we are in request allocation, check if the current hctx is inactive.
+	 * If yes, give up this allocation. We will retry on another new online
+	 * CPU.
+	 */
+	if (data->preempt_disabled && unlikely(test_bit(BLK_MQ_S_INACTIVE,
+					&data->hctx->state))) {
+		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
+		return BLK_MQ_TAG_FAIL;
+	}
 	return tag + tag_offset;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 18999198a37f..0551aa1740ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,9 +40,9 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
-static struct request *blk_mq_get_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data);
+static struct request *__blk_mq_get_request(struct request_queue *q,
+					    struct bio *bio,
+					    struct blk_mq_alloc_data *data);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -338,18 +338,19 @@ struct blk_mq_smp_call_info {
 	struct request_queue *q;
 	struct blk_mq_alloc_data *data;
 	struct request *rq;
+	struct bio *bio;
 };
 
 static void __blk_mq_alloc_request(void *alloc_info)
 {
 	struct blk_mq_smp_call_info *info = alloc_info;
 
-	info->rq = blk_mq_get_request(info->q, NULL, info->data);
+	info->rq = __blk_mq_get_request(info->q, info->bio, info->data);
 }
 
-static struct request *blk_mq_get_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data)
+static struct request *__blk_mq_get_request(struct request_queue *q,
+					    struct bio *bio,
+					    struct blk_mq_alloc_data *data)
 {
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
@@ -413,6 +414,34 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	return rq;
 }
 
+static struct request *blk_mq_get_request(struct request_queue *q,
+					  struct bio *bio,
+					  struct blk_mq_alloc_data *data)
+{
+	int ret;
+	struct blk_mq_smp_call_info info;
+	struct request *rq = __blk_mq_get_request(q, bio, data);
+
+	if (rq)
+		return rq;
+
+	if (data->flags & BLK_MQ_REQ_NOWAIT)
+		return NULL;
+
+	/*
+	 * The allocation fails because of inactive hctx, so retry from
+	 * online cpus.
+	 */
+	info.q = q;
+	info.bio = bio;
+	info.data = data;
+
+	ret = smp_call_function_any(cpu_online_mask, __blk_mq_alloc_request, &info, 1);
+	if (ret)
+		return ERR_PTR(ret);
+	return info.rq;
+}
+
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		blk_mq_req_flags_t flags)
 {
@@ -2316,13 +2345,81 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
-static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
+struct rq_iter_data {
+	bool has_rq;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static bool blk_mq_has_request(struct request *rq, void *data, bool reserved)
 {
-	return 0;
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
 }
 
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 {
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
 	return 0;
 }
 
@@ -2333,12 +2430,15 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
 
-	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 682ce79e8973..e3f6608346b5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -407,6 +407,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE	= 3,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
-- 
2.25.2

