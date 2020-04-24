Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C8C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66E920728
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxXw7ihI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgDXKZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:25:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726835AbgDXKZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuFdqHcj1y8PJt18GeQ0wEmZnKutG4HL3CMqMwAN4J8=;
        b=VxXw7ihIDqfzzkOoRM2UyhQo2yo2PtDmVQ680m981VHHSniXVoQ4PTFndaZfBpdnXdC7Kr
        kAF0IwVwLbkgzQ/jo9IFa77QIMWZTY81D1nuzppyY+7yT+4ZDu8YJx859doQBkkF8KU37Q
        XIWFatNfRBB5w557zJWVJIeCeudbUbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-wao87cWzNLuptIlRDhRMoQ-1; Fri, 24 Apr 2020 06:25:08 -0400
X-MC-Unique: wao87cWzNLuptIlRDhRMoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4D6107ACCD;
        Fri, 24 Apr 2020 10:25:07 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38A615D9CC;
        Fri, 24 Apr 2020 10:25:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V8 10/11] blk-mq: re-submit IO in case that hctx is inactive
Date:   Fri, 24 Apr 2020 18:23:50 +0800
Message-Id: <20200424102351.475641-11-ming.lei@redhat.com>
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
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
 block/blk-mq.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0759e0d606b3..a4a26bb23533 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2370,6 +2370,98 @@ static int blk_mq_hctx_notify_online(unsigned int =
cpu, struct hlist_node *node)
 	return 0;
 }
=20
+static void blk_mq_resubmit_end_rq(struct request *rq, blk_status_t erro=
r)
+{
+	struct request *orig_rq =3D rq->end_io_data;
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
+	unsigned int flags =3D 0;
+	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
+	struct blk_mq_tags *tags =3D rq->q->elevator ? hctx->sched_tags :
+		hctx->tags;
+	bool reserved =3D blk_mq_tag_is_reserved(tags, rq->internal_tag);
+
+	if (rq->rq_flags & RQF_PREEMPT)
+		flags |=3D BLK_MQ_REQ_PREEMPT;
+	if (reserved)
+		flags |=3D BLK_MQ_REQ_RESERVED;
+
+	/* avoid allocation failure by clearing NOWAIT */
+	nrq =3D blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
+	if (!nrq)
+		return;
+
+	blk_rq_copy_request(nrq, rq);
+
+	nrq->timeout =3D rq->timeout;
+	nrq->rq_disk =3D rq->rq_disk;
+	nrq->part =3D rq->part;
+
+	memcpy(blk_mq_rq_to_pdu(nrq), blk_mq_rq_to_pdu(rq),
+			rq->q->tag_set->cmd_size);
+
+	nrq->end_io =3D blk_mq_resubmit_end_rq;
+	nrq->end_io_data =3D rq;
+	nrq->bio =3D rq->bio;
+	nrq->biotail =3D rq->biotail;
+
+	if (blk_insert_cloned_request(nrq->q, nrq) !=3D BLK_STS_OK)
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
+	struct elevator_queue *e =3D hctx->queue->elevator;
+
+	if (!e) {
+		blk_mq_flush_busy_ctxs(hctx, &re_submit);
+	} else {
+		while ((rq =3D e->type->ops.dispatch_request(hctx))) {
+			if (rq->mq_hctx !=3D hctx)
+				list_add(&rq->queuelist, &sched);
+			else
+				list_add(&rq->queuelist, &re_submit);
+		}
+	}
+	while (!list_empty(&sched)) {
+		rq =3D list_first_entry(&sched, struct request, queuelist);
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
+		rq =3D list_first_entry(&re_submit, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_resubmit_rq(rq);
+	}
+}
+
 static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
 		unsigned int cpu)
 {
@@ -2398,9 +2490,8 @@ static void blk_mq_hctx_handle_dead_cpu(struct blk_=
mq_hw_ctx *hctx,
 }
=20
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * @cpu has gone away. If this hctx is inactive, we can't dispatch reque=
st
+ * to the hctx any more, so clone and re-submit requests from this hctx
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
@@ -2410,7 +2501,10 @@ static int blk_mq_hctx_notify_dead(unsigned int cp=
u, struct hlist_node *node)
 	if (!cpumask_test_cpu(cpu, hctx->cpumask))
 		return 0;
=20
-	blk_mq_hctx_handle_dead_cpu(hctx, cpu);
+	if (test_bit(BLK_MQ_S_INACTIVE, &hctx->state))
+		blk_mq_hctx_deactivate(hctx);
+	else
+		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
 	return 0;
 }
=20
--=20
2.25.2

