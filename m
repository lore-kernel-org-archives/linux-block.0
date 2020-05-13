Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB3C2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB522205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5y2f0vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEMDtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:49:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728692AbgEMDtf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy9ng9J/9IM+YQnMXypI0xMgHqWb5jb/uhDT7d6eVMo=;
        b=a5y2f0vKwGmq+HTdeKn9qN/O0NbRgupDxpvDZGxSmSK7iY0Aari197K0i4ISh+q6BWKUly
        X5vnk/Bt72AM5Pd6HwWrvNZMJnMScxh1hubcMjJcB0OZJhuvg+Hvmt3eq75N3NBed2b28x
        S7DD9Jl+invr8rots8IjbXallAR/A8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-aM2dvNq6M8GyJctDPXCziw-1; Tue, 12 May 2020 23:49:28 -0400
X-MC-Unique: aM2dvNq6M8GyJctDPXCziw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4DE4107ACCD;
        Wed, 13 May 2020 03:49:26 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB1E6A960;
        Wed, 13 May 2020 03:49:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is inactive
Date:   Wed, 13 May 2020 11:48:02 +0800
Message-Id: <20200513034803.1844579-12-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in one hctx are offline and this hctx becomes inactive, we
shouldn't run this hw queue for completing request any more.

So allocate request from one live hctx, and clone & resubmit the request,
either it is from sw queue or scheduler queue.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7c640482fb24..c9a3e48a1ebc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2402,6 +2402,109 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static void blk_mq_resubmit_end_rq(struct request *rq, blk_status_t error)
+{
+	struct request *orig_rq = rq->end_io_data;
+
+	blk_mq_cleanup_rq(orig_rq);
+	blk_mq_end_request(orig_rq, error);
+
+	blk_put_request(rq);
+}
+
+static void blk_mq_resubmit_rq(struct request *rq)
+{
+	struct request *nrq;
+	unsigned int flags = 0;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
+		hctx->tags;
+	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
+
+	if (rq->rq_flags & RQF_PREEMPT)
+		flags |= BLK_MQ_REQ_PREEMPT;
+	if (reserved)
+		flags |= BLK_MQ_REQ_RESERVED;
+	/*
+	 * Queue freezing might be in-progress, and wait freeze can't be
+	 * done now because we have request not completed yet, so mark this
+	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
+	 * freeze hung forever.
+	 */
+	flags |= BLK_MQ_REQ_FORCE;
+
+	/* avoid allocation failure by clearing NOWAIT */
+	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
+	if (!nrq)
+		return;
+
+	blk_rq_copy_request(nrq, rq);
+
+	nrq->timeout = rq->timeout;
+	nrq->rq_disk = rq->rq_disk;
+	nrq->part = rq->part;
+
+	memcpy(blk_mq_rq_to_pdu(nrq), blk_mq_rq_to_pdu(rq),
+			rq->q->tag_set->cmd_size);
+
+	nrq->end_io = blk_mq_resubmit_end_rq;
+	nrq->end_io_data = rq;
+	nrq->bio = rq->bio;
+	nrq->biotail = rq->biotail;
+
+	/* bios ownership has been transfered to new request */
+	rq->bio = rq->biotail = NULL;
+	rq->__data_len = 0;
+
+	if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
+		blk_mq_request_bypass_insert(nrq, false, true);
+}
+
+static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx)
+{
+	LIST_HEAD(sched);
+	LIST_HEAD(re_submit);
+	LIST_HEAD(flush_in);
+	LIST_HEAD(flush_out);
+	struct request *rq, *nxt;
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (!e) {
+		blk_mq_flush_busy_ctxs(hctx, &re_submit);
+	} else {
+		while ((rq = e->type->ops.dispatch_request(hctx))) {
+			if (rq->mq_hctx != hctx)
+				list_add(&rq->queuelist, &sched);
+			else
+				list_add(&rq->queuelist, &re_submit);
+		}
+	}
+	while (!list_empty(&sched)) {
+		rq = list_first_entry(&sched, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_sched_insert_request(rq, true, true, true);
+	}
+
+	/* requests in dispatch list have to be re-submitted too */
+	spin_lock(&hctx->lock);
+	list_splice_tail_init(&hctx->dispatch, &re_submit);
+	spin_unlock(&hctx->lock);
+
+	/* blk_end_flush_machinery will cover flush request */
+	list_for_each_entry_safe(rq, nxt, &re_submit, queuelist) {
+		if (rq->rq_flags & RQF_FLUSH_SEQ)
+			list_move(&rq->queuelist, &flush_in);
+	}
+	blk_end_flush_machinery(hctx, &flush_in, &flush_out);
+	list_splice_tail(&flush_out, &re_submit);
+
+	while (!list_empty(&re_submit)) {
+		rq = list_first_entry(&re_submit, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_rq(rq);
+	}
+}
+
 static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int cpu)
 {
@@ -2430,17 +2533,20 @@ static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
 }
 
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * @cpu has gone away. If this hctx is inactive, we can't dispatch request
+ * to the hctx any more, so clone and re-submit requests from this hctx
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_dead);
 
-	if (cpumask_test_cpu(cpu, hctx->cpumask))
-		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
+	if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+		if (test_bit(BLK_MQ_S_INACTIVE, &hctx->state))
+			blk_mq_hctx_deactivate(hctx);
+		else
+			blk_mq_hctx_handle_dead_cpu(hctx, cpu);
+	}
 	return 0;
 }
 
-- 
2.25.2

