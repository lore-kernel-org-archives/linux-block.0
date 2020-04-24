Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE29C2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A66F20728
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWWnHcWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgDXKZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:25:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbgDXKZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l5Z70E0pqf62ymtt3qvjEYWz0uSZItisdYOEHEZ5Q8=;
        b=WWWnHcWYrg38qZ3y614Jk4DRtvtWcpbvCgSz8f1XnwnAi9EXHdDtwNAIRhcoobuffP/TrF
        q2EwXZrPucQvX6h70w0RI4sKQ7P6S+zPTzsn4TgeBriGerw3/JOyF9sFNbTjxstiieTyEC
        ydPct2ouuWJ/l38fpTjlSwLheGtTios=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-S3nS0K4oOjSX4kbZ7u8O_w-1; Fri, 24 Apr 2020 06:24:58 -0400
X-MC-Unique: S3nS0K4oOjSX4kbZ7u8O_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59BDD1800D6B;
        Fri, 24 Apr 2020 10:24:57 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F62600E8;
        Fri, 24 Apr 2020 10:24:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V8 08/11] block: add blk_end_flush_machinery
Date:   Fri, 24 Apr 2020 18:23:48 +0800
Message-Id: <20200424102351.475641-9-ming.lei@redhat.com>
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flush requests aren't same with normal FS request:

1) one dedicated per-hctx flush rq is pre-allocated for sending flush req=
uest

2) flush request si issued to hardware via one machinary so that flush me=
rge
can be applied

We can't simply re-submit flush rqs via blk_steal_bios(), so add
blk_end_flush_machinery to collect flush requests which needs to
be resubmitted:

- if one flush command without DATA is enough, send one flush, complete t=
his
kind of requests

- otherwise, add the request into a list and let caller re-submit it.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 123 +++++++++++++++++++++++++++++++++++++++++++---
 block/blk.h       |   4 ++
 2 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 977edf95d711..745d878697ed 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -170,10 +170,11 @@ static void blk_flush_complete_seq(struct request *=
rq,
 	unsigned int cmd_flags;
=20
 	BUG_ON(rq->flush.seq & seq);
-	rq->flush.seq |=3D seq;
+	if (!error)
+		rq->flush.seq |=3D seq;
 	cmd_flags =3D rq->cmd_flags;
=20
-	if (likely(!error))
+	if (likely(!error && !fq->flush_queue_terminating))
 		seq =3D blk_flush_cur_seq(rq);
 	else
 		seq =3D REQ_FSEQ_DONE;
@@ -200,9 +201,15 @@ static void blk_flush_complete_seq(struct request *r=
q,
 		 * normal completion and end it.
 		 */
 		BUG_ON(!list_empty(&rq->queuelist));
-		list_del_init(&rq->flush.list);
-		blk_flush_restore_request(rq);
-		blk_mq_end_request(rq, error);
+
+		/* Terminating code will end the request from flush queue */
+		if (likely(!fq->flush_queue_terminating)) {
+			list_del_init(&rq->flush.list);
+			blk_flush_restore_request(rq);
+			blk_mq_end_request(rq, error);
+		} else {
+			list_move_tail(&rq->flush.list, pending);
+		}
 		break;
=20
 	default:
@@ -279,7 +286,8 @@ static void blk_kick_flush(struct request_queue *q, s=
truct blk_flush_queue *fq,
 	struct request *flush_rq =3D fq->flush_rq;
=20
 	/* C1 described at the top of this file */
-	if (fq->flush_pending_idx !=3D fq->flush_running_idx || list_empty(pend=
ing))
+	if (fq->flush_pending_idx !=3D fq->flush_running_idx ||
+			list_empty(pending) || fq->flush_queue_terminating)
 		return;
=20
 	/* C2 and C3
@@ -331,7 +339,7 @@ static void mq_flush_data_end_io(struct request *rq, =
blk_status_t error)
 	struct blk_flush_queue *fq =3D blk_get_flush_queue(q, ctx);
=20
 	if (q->elevator) {
-		WARN_ON(rq->tag < 0);
+		WARN_ON(rq->tag < 0 && !fq->flush_queue_terminating);
 		blk_mq_put_driver_tag(rq);
 	}
=20
@@ -503,3 +511,104 @@ void blk_free_flush_queue(struct blk_flush_queue *f=
q)
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
+
+static void __blk_end_queued_flush(struct blk_flush_queue *fq,
+		unsigned int queue_idx, struct list_head *resubmit_list,
+		struct list_head *flush_list)
+{
+	struct list_head *queue =3D &fq->flush_queue[queue_idx];
+	struct request *rq, *nxt;
+
+	list_for_each_entry_safe(rq, nxt, queue, flush.list) {
+		unsigned int seq =3D blk_flush_cur_seq(rq);
+
+		list_del_init(&rq->flush.list);
+		blk_flush_restore_request(rq);
+		if (!blk_rq_sectors(rq) || seq =3D=3D REQ_FSEQ_POSTFLUSH )
+			list_add_tail(&rq->queuelist, flush_list);
+		else
+			list_add_tail(&rq->queuelist, resubmit_list);
+	}
+}
+
+static void blk_end_queued_flush(struct blk_flush_queue *fq,
+		struct list_head *resubmit_list, struct list_head *flush_list)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	__blk_end_queued_flush(fq, 0, resubmit_list, flush_list);
+	__blk_end_queued_flush(fq, 1, resubmit_list, flush_list);
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+}
+
+/* complete requests which just requires one flush command */
+static void blk_complete_flush_requests(struct blk_flush_queue *fq,
+		struct list_head *flush_list)
+{
+	struct block_device *bdev;
+	struct request *rq;
+	int error =3D -ENXIO;
+
+	if (list_empty(flush_list))
+		return;
+
+	rq =3D list_first_entry(flush_list, struct request, queuelist);
+
+	/* Send flush via one active hctx so we can move on */
+	bdev =3D bdget_disk(rq->rq_disk, 0);
+	if (bdev) {
+		error =3D blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
+		bdput(bdev);
+	}
+
+	while (!list_empty(flush_list)) {
+		rq =3D list_first_entry(flush_list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_end_request(rq, error);
+	}
+}
+
+/*
+ * Called when this hctx is inactive and all CPUs of this hctx is dead,
+ * otherwise don't reuse this function.
+ *
+ * Terminate this hw queue's flush machinery, and try to complete flush
+ * IO requests if possible, such as any flush IO without data, or flush
+ * data IO in POSTFLUSH stage. Otherwise, add the flush IOs into @list
+ * and let caller to re-submit them.
+ */
+void blk_end_flush_machinery(struct blk_mq_hw_ctx *hctx,
+		struct list_head *in, struct list_head *out)
+{
+	LIST_HEAD(resubmit_list);
+	LIST_HEAD(flush_list);
+	struct blk_flush_queue *fq =3D hctx->fq;
+	struct request *rq, *nxt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	fq->flush_queue_terminating =3D 1;
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+
+	/* End inflight flush requests */
+	list_for_each_entry_safe(rq, nxt, in, queuelist) {
+		WARN_ON(!(rq->rq_flags & RQF_FLUSH_SEQ));
+		list_del_init(&rq->queuelist);
+		rq->end_io(rq, BLK_STS_AGAIN);
+	}
+
+	/* End queued requests */
+	blk_end_queued_flush(fq, &resubmit_list, &flush_list);
+
+	/* Send flush and complete requests which just need one flush req */
+	blk_complete_flush_requests(fq, &flush_list);
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	/* reset flush queue so that it is ready to work next time */
+	fq->flush_pending_idx =3D fq->flush_running_idx =3D 0;
+	fq->flush_queue_terminating =3D 0;
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+
+	list_splice_init(&resubmit_list, out);
+}
diff --git a/block/blk.h b/block/blk.h
index 446b2893b478..9f2ed3331fd5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -20,6 +20,7 @@ struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
+	unsigned int		flush_queue_terminating:1;
 	blk_status_t 		rq_status;
 	unsigned long		flush_pending_since;
 	struct list_head	flush_queue[2];
@@ -485,4 +486,7 @@ int __bio_add_pc_page(struct request_queue *q, struct=
 bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		bool *same_page);
=20
+void blk_end_flush_machinery(struct blk_mq_hw_ctx *hctx,
+		struct list_head *in, struct list_head *out);
+
 #endif /* BLK_INTERNAL_H */
--=20
2.25.2

