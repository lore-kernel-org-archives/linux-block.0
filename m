Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54AC2D0FD
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2428C205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxZXiFc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEMDtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:49:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgEMDtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rd6+amCIzl+hP4fRgrg9M4OifLZpwuR6RSp6cM8jhEk=;
        b=hxZXiFc8Ba6KIXLw/S0ym0J27nVTaU/vNFRHMSSwdRIBPDb5mvgPsbnl7QSvoG/APHexUP
        mmFJiQKuEVT/ZhPqrhjO26IZ5keqMv6hUE7kBnXifk66+LGK16btWQ/X8DMWnUveZV9qg6
        GDMghAp+C9gGE5Hg8pEO7K59DDlMwgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-q71_r4QCMgm64yCvjmyL5w-1; Tue, 12 May 2020 23:49:13 -0400
X-MC-Unique: q71_r4QCMgm64yCvjmyL5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB8A184040A;
        Wed, 13 May 2020 03:49:11 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 749D26E6E0;
        Wed, 13 May 2020 03:49:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V11 08/12] block: add blk_end_flush_machinery
Date:   Wed, 13 May 2020 11:47:59 +0800
Message-Id: <20200513034803.1844579-9-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flush requests aren't same with normal FS request:

1) one dedicated per-hctx flush rq is pre-allocated for sending flush request

2) flush request si issued to hardware via one machinary so that flush merge
can be applied

We can't simply re-submit flush rqs via blk_steal_bios(), so add
blk_end_flush_machinery to collect flush requests which needs to
be resubmitted:

- if one flush command without DATA is enough, send one flush, complete this
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
@@ -170,10 +170,11 @@ static void blk_flush_complete_seq(struct request *rq,
 	unsigned int cmd_flags;
 
 	BUG_ON(rq->flush.seq & seq);
-	rq->flush.seq |= seq;
+	if (!error)
+		rq->flush.seq |= seq;
 	cmd_flags = rq->cmd_flags;
 
-	if (likely(!error))
+	if (likely(!error && !fq->flush_queue_terminating))
 		seq = blk_flush_cur_seq(rq);
 	else
 		seq = REQ_FSEQ_DONE;
@@ -200,9 +201,15 @@ static void blk_flush_complete_seq(struct request *rq,
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
 
 	default:
@@ -279,7 +286,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	struct request *flush_rq = fq->flush_rq;
 
 	/* C1 described at the top of this file */
-	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
+	if (fq->flush_pending_idx != fq->flush_running_idx ||
+			list_empty(pending) || fq->flush_queue_terminating)
 		return;
 
 	/* C2 and C3
@@ -331,7 +339,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
 
 	if (q->elevator) {
-		WARN_ON(rq->tag < 0);
+		WARN_ON(rq->tag < 0 && !fq->flush_queue_terminating);
 		blk_mq_put_driver_tag(rq);
 	}
 
@@ -503,3 +511,104 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
+
+static void __blk_end_queued_flush(struct blk_flush_queue *fq,
+		unsigned int queue_idx, struct list_head *resubmit_list,
+		struct list_head *flush_list)
+{
+	struct list_head *queue = &fq->flush_queue[queue_idx];
+	struct request *rq, *nxt;
+
+	list_for_each_entry_safe(rq, nxt, queue, flush.list) {
+		unsigned int seq = blk_flush_cur_seq(rq);
+
+		list_del_init(&rq->flush.list);
+		blk_flush_restore_request(rq);
+		if (!blk_rq_sectors(rq) || seq == REQ_FSEQ_POSTFLUSH )
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
+	int error = -ENXIO;
+
+	if (list_empty(flush_list))
+		return;
+
+	rq = list_first_entry(flush_list, struct request, queuelist);
+
+	/* Send flush via one active hctx so we can move on */
+	bdev = bdget_disk(rq->rq_disk, 0);
+	if (bdev) {
+		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
+		bdput(bdev);
+	}
+
+	while (!list_empty(flush_list)) {
+		rq = list_first_entry(flush_list, struct request, queuelist);
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
+	struct blk_flush_queue *fq = hctx->fq;
+	struct request *rq, *nxt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	fq->flush_queue_terminating = 1;
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
+	fq->flush_pending_idx = fq->flush_running_idx = 0;
+	fq->flush_queue_terminating = 0;
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+
+	list_splice_init(&resubmit_list, out);
+}
diff --git a/block/blk.h b/block/blk.h
index 002104739465..79aaf976d15d 100644
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
@@ -453,4 +454,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+void blk_end_flush_machinery(struct blk_mq_hw_ctx *hctx,
+		struct list_head *in, struct list_head *out);
+
 #endif /* BLK_INTERNAL_H */
-- 
2.25.2

