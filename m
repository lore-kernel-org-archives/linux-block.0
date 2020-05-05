Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A3C3A5A9
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A91206D7
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 02:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjvLdajt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEECKm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 22:10:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726549AbgEECKl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 22:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGSa9q4TdaDfEuiH4P9rUbNM5GqbTwgy5k8o3ZDdEAs=;
        b=DjvLdajtpAjEcbTOuQnQgv9mTfKa8fDA+D5aez9yOVYJL0Mgm+YOlPCEmXwYASnzc+XuHX
        ahKGveoeo890Nnzaw3w1Yu5Ein8DHhgg/6XCqz94WYaoj5Lvk6/8HEy+st6Q3ZLqb5UJeI
        TxXblVlDUHcaikuP+792WHq3fmUpPi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-o31Y7XC3MWC1ysFCxyOv4A-1; Mon, 04 May 2020 22:10:38 -0400
X-MC-Unique: o31Y7XC3MWC1ysFCxyOv4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DD8107ACCA;
        Tue,  5 May 2020 02:10:36 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E1A60BEC;
        Tue,  5 May 2020 02:10:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before hctx becomes inactive
Date:   Tue,  5 May 2020 10:09:26 +0800
Message-Id: <20200505020930.1146281-8-ming.lei@redhat.com>
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU of hct=
x.
If yes, mark this hctx as inactive, meantime wait for completion of all
in-flight IOs originated from this hctx. Meantime check if this hctx has
become inactive in blk_mq_get_driver_tag(), if yes, release the
allocated tag.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line when all CPUs of this IRQ line is offline.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |   1 +
 block/blk-mq.c         | 124 +++++++++++++++++++++++++++++++++++++----
 include/linux/blk-mq.h |   3 +
 3 files changed, 117 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ddec58743e88..dc66cb689d2f 100644
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
index 54c107be7a47..4a2250ac4fbb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1038,11 +1038,36 @@ static bool __blk_mq_get_driver_tag(struct reques=
t *rq)
 	return true;
 }
=20
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
 {
 	if (rq->tag !=3D -1)
 		return true;
-	return __blk_mq_get_driver_tag(rq);
+
+	if (!__blk_mq_get_driver_tag(rq))
+		return false;
+	/*
+	 * In case that direct issue IO process is migrated to other CPU
+	 * which may not belong to this hctx, add one memory barrier so we
+	 * can order driver tag assignment and checking BLK_MQ_S_INACTIVE.
+	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
+	 * and driver tag assignment are run on the same CPU because
+	 * BLK_MQ_S_INACTIVE is only set after the last CPU of this hctx is
+	 * becoming offline.
+	 *
+	 * Process migration might happen after the check on current processor
+	 * id, smp_mb() is implied by processor migration, so no need to worry
+	 * about it.
+	 */
+	if (unlikely(direct_issue && rq->mq_ctx->cpu !=3D raw_smp_processor_id(=
)))
+		smp_mb();
+	else
+		barrier();
+
+	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
+		blk_mq_put_driver_tag(rq);
+		return false;
+	}
+	return true;
 }
=20
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
@@ -1091,7 +1116,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 		 * Don't clear RESTART here, someone else could have set it.
 		 * At most this will cost an extra queue run.
 		 */
-		return blk_mq_get_driver_tag(rq);
+		return blk_mq_get_driver_tag(rq, false);
 	}
=20
 	wait =3D &hctx->dispatch_wait;
@@ -1117,7 +1142,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_c=
tx *hctx,
 	 * allocation failure and adding the hardware queue to the wait
 	 * queue.
 	 */
-	ret =3D blk_mq_get_driver_tag(rq);
+	ret =3D blk_mq_get_driver_tag(rq, false);
 	if (!ret) {
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
@@ -1218,7 +1243,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 			break;
 		}
=20
-		if (!blk_mq_get_driver_tag(rq)) {
+		if (!blk_mq_get_driver_tag(rq, false)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed. The
@@ -1250,7 +1275,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *=
q, struct list_head *list,
 			bd.last =3D true;
 		else {
 			nxt =3D list_first_entry(list, struct request, queuelist);
-			bd.last =3D !blk_mq_get_driver_tag(nxt);
+			bd.last =3D !blk_mq_get_driver_tag(nxt, false);
 		}
=20
 		ret =3D q->mq_ops->queue_rq(hctx, &bd);
@@ -1864,7 +1889,7 @@ static blk_status_t __blk_mq_try_issue_directly(str=
uct blk_mq_hw_ctx *hctx,
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
=20
-	if (!blk_mq_get_driver_tag(rq)) {
+	if (!blk_mq_get_driver_tag(rq, true)) {
 		blk_mq_put_dispatch_budget(hctx);
 		goto insert;
 	}
@@ -2273,13 +2298,87 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, =
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
+		.hctx	=3D hctx,
+	};
+
+	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
+			blk_mq_inflight_rq, &count_data);
+	return count_data.count;
+}
+
+static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
+		struct blk_mq_hw_ctx *hctx)
+{
+	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) !=3D cpu)
+		return false;
+	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
+		return false;
+	return true;
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
+	if (!blk_mq_last_cpu_in_hctx(cpu, hctx))
+		return 0;
+
+	/*
+	 * Order setting BLK_MQ_S_INACTIVE versus checking rq->tag and rqs[tag]=
,
+	 * in blk_mq_tags_inflight_rqs.  It pairs with the smp_mb() in
+	 * blk_mq_get_driver_tag.
+	 */
+	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	smp_mb__after_atomic();
+	while (blk_mq_tags_inflight_rqs(hctx))
+		msleep(5);
+	return 0;
+}
+
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
+{
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	return 0;
 }
=20
@@ -2290,12 +2389,15 @@ static int blk_mq_hctx_notify_offline(unsigned in=
t cpu, struct hlist_node *node)
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
=20
-	hctx =3D hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return 0;
+
 	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
 	type =3D hctx->type;
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3763207d88eb..77bf861d72ec 100644
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

