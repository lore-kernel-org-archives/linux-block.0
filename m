Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4FC2BB1D
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBB9221F7
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g88Jd7u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgDRDKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:10:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgDRDKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 23:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587179405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ASIMmUvmJu5xtUINiX4AFPjbCO1AEBrY+Tyt7TrLt5E=;
        b=g88Jd7u9SSh5VELKTddIDjcu7gjfk+I21wKlWI1hIAqixhUx104jBozH/heGoNkNuyzzoY
        oNF/r2SQ8Yso/kuICdrj7nO2FaoN/OMtgMTgLNeCmI+J7Z0msuikRUpyYhfzPmWoXQqrbR
        htZeZt2Pjn5hXpILijWZIZRoka27DkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-m2CXZWfcPKWcWWXeyyKgbg-1; Fri, 17 Apr 2020 23:10:01 -0400
X-MC-Unique: m2CXZWfcPKWcWWXeyyKgbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B833A107ACC4;
        Sat, 18 Apr 2020 03:09:59 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70AF911A034;
        Sat, 18 Apr 2020 03:09:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 5/9] blk-mq: stop to handle IO and drain IO before hctx becomes inactive
Date:   Sat, 18 Apr 2020 11:09:21 +0800
Message-Id: <20200418030925.31996-6-ming.lei@redhat.com>
In-Reply-To: <20200418030925.31996-1-ming.lei@redhat.com>
References: <20200418030925.31996-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU
of hctx. If yes, mark this hctx as inactive, meantime wait for
completion of all in-flight IOs originated from this hctx.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |   1 +
 block/blk-mq.c         | 118 ++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h         |   3 +-
 include/linux/blk-mq.h |   3 ++
 4 files changed, 116 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8e745826eb86..b62390918ca5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] =3D {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INACTIVE),
 };
 #undef HCTX_STATE_NAME
=20
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a28daefd7dd6..0b56d7d78269 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1021,7 +1021,7 @@ static inline unsigned int queued_to_index(unsigned=
 int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
=20
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
 {
 	struct blk_mq_alloc_data data =3D {
 		.q =3D rq->q,
@@ -1054,6 +1054,23 @@ static bool blk_mq_get_driver_tag(struct request *=
rq)
 		data.hctx->tags->rqs[rq->tag] =3D rq;
 	}
 allocated:
+	/*
+	 * Add one memory barrier in case that direct issue IO process
+	 * is migrated to other CPU which may not belong to this hctx,
+	 * so we can order driver tag assignment and checking
+	 * BLK_MQ_S_INACTIVE. Otherwise, barrier() is enough given the
+	 * two code paths are run on single CPU in case that
+	 * BLK_MQ_S_INACTIVE is set.
+	 */
+	if (unlikely(direct_issue && rq->mq_ctx->cpu !=3D raw_smp_processor_id(=
)))
+		smp_mb();
+	else
+		barrier();
+
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))) {
+		blk_mq_put_driver_tag(rq);
+		return false;
+	}
 	return rq->tag !=3D -1;
 }
=20
@@ -1103,7 +1120,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 		 * Don't clear RESTART here, someone else could have set it.
 		 * At most this will cost an extra queue run.
 		 */
-		return blk_mq_get_driver_tag(rq);
+		return blk_mq_get_driver_tag(rq, false);
 	}
=20
 	wait =3D &hctx->dispatch_wait;
@@ -1129,7 +1146,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 	 * allocation failure and adding the hardware queue to the wait
 	 * queue.
 	 */
-	ret =3D blk_mq_get_driver_tag(rq);
+	ret =3D blk_mq_get_driver_tag(rq, false);
 	if (!ret) {
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
@@ -1226,7 +1243,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
 			break;
=20
-		if (!blk_mq_get_driver_tag(rq)) {
+		if (!blk_mq_get_driver_tag(rq, false)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed. The
@@ -1258,7 +1275,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 			bd.last =3D true;
 		else {
 			nxt =3D list_first_entry(list, struct request, queuelist);
-			bd.last =3D !blk_mq_get_driver_tag(nxt);
+			bd.last =3D !blk_mq_get_driver_tag(nxt, false);
 		}
=20
 		ret =3D q->mq_ops->queue_rq(hctx, &bd);
@@ -1851,7 +1868,7 @@ static blk_status_t __blk_mq_try_issue_directly(str=
uct blk_mq_hw_ctx *hctx,
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
=20
-	if (!blk_mq_get_driver_tag(rq)) {
+	if (!blk_mq_get_driver_tag(rq, true)) {
 		blk_mq_put_dispatch_budget(hctx);
 		goto insert;
 	}
@@ -2259,13 +2276,95 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, =
struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
=20
-static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+struct count_inflight_data {
+	unsigned count;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
 {
-	return 0;
+	struct count_inflight_data *count_data =3D data;
+
+	/*
+	 * Can't check rq's state because it is updated to MQ_RQ_IN_FLIGHT
+	 * in blk_mq_start_request(), at that time we can't prevent this rq
+	 * from being issued.
+	 *
+	 * So check if driver tag is assigned, if yes, count this rq as
+	 * inflight.
+	 */
+	if (rq->tag >=3D 0 && rq->mq_hctx =3D=3D count_data->hctx)
+		count_data->count++;
+
+	return true;
+}
+
+static bool blk_mq_inflight_rq(struct request *rq, void *data,
+			       bool reserved)
+{
+	return rq->tag >=3D 0;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct count_inflight_data count_data =3D {
+		.count	=3D 0,
+		.hctx	=3D hctx,
+	};
+
+	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
+			blk_mq_inflight_rq, &count_data);
+
+	return count_data.count;
+}
+
+static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx))
+			break;
+		msleep(5);
+	}
 }
=20
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_nod=
e *node)
 {
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
+	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) !=3D cpu) ||
+			(cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask)
+			 < nr_cpu_ids))
+		return 0;
+
+	/*
+	 * The current CPU is the last one in this hctx, S_INACTIVE
+	 * can be observed in dispatch path without any barrier needed,
+	 * cause both are run on one same CPU.
+	 */
+	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	/*
+	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
+	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
+	 */
+	smp_mb();
+	blk_mq_hctx_drain_inflight_rqs(hctx);
+	return 0;
+}
+
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+{
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
+	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	return 0;
 }
=20
@@ -2281,6 +2380,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu=
, struct hlist_node *node)
 	LIST_HEAD(tmp);
 	enum hctx_type type;
=20
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	hctx =3D hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
 	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
 	type =3D hctx->type;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d0c72d7d07c8..a1fbd0b8657b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -167,7 +167,8 @@ static inline struct blk_mq_tags *blk_mq_tags_from_da=
ta(struct blk_mq_alloc_data
=20
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
-	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	return test_bit(BLK_MQ_S_STOPPED, &hctx->state) ||
+		test_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 }
=20
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 786614753d73..650b208b42ea 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	=3D 1,
 	BLK_MQ_S_SCHED_RESTART	=3D 2,
=20
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE	=3D 3,
+
 	BLK_MQ_MAX_DEPTH	=3D 10240,
=20
 	BLK_MQ_CPU_WORK_BATCH	=3D 8,
--=20
2.25.2

