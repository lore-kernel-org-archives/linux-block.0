Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E6C2BA19
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E56221F7
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 03:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlcZR9Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDRDKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:10:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgDRDKO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 23:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587179412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDrOfGZhMsylqonXn56cuXumPSnAs37TmhqyYzAC4HI=;
        b=VlcZR9ZyMzm0j3dtGicHZGIa0N9rpC37Sar+4HGQnMQLWgay1VD5nQu/V2e03+/9ReJ7WJ
        MfSg53T8fa0+QJNnkg7mOrtbnrmQwoTd3oJvb+7vdUOt5bwJT5vdK1tM1XPnQpRXRu66cp
        T9Xn7ufbXND1+4dE0y7ZAh81V9A7KNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-OVxNY_WpMVOQUg_YblZFBg-1; Fri, 17 Apr 2020 23:10:08 -0400
X-MC-Unique: OVxNY_WpMVOQUg_YblZFBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A597107ACCD;
        Sat, 18 Apr 2020 03:10:07 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 411BE11A0F9;
        Sat, 18 Apr 2020 03:10:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 7/9] blk-mq: re-submit IO in case that hctx is inactive
Date:   Sat, 18 Apr 2020 11:09:23 +0800
Message-Id: <20200418030925.31996-8-ming.lei@redhat.com>
In-Reply-To: <20200418030925.31996-1-ming.lei@redhat.com>
References: <20200418030925.31996-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in one hctx are offline and this hctx becomes inactive,
we shouldn't run this hw queue for completing request any more.

So steal bios from the request, and resubmit them, and finally free
the request in blk_mq_hctx_notify_dead().

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 130 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b56d7d78269..ae1e57c64ca1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2368,10 +2368,98 @@ static int blk_mq_hctx_notify_online(unsigned int=
 cpu, struct hlist_node *node)
 	return 0;
 }
=20
+static void blk_mq_resubmit_end_io(struct request *rq, blk_status_t erro=
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
+static void blk_mq_resubmit_passthrough_io(struct request *rq)
+{
+	struct request *nrq;
+	unsigned int flags =3D 0, cmd_flags =3D 0;
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
+	/* avoid allocation failure & IO merge */
+	cmd_flags =3D (rq->cmd_flags & ~REQ_NOWAIT) | REQ_NOMERGE;
+
+	nrq =3D blk_get_request(rq->q, cmd_flags, flags);
+	if (!nrq)
+		return;
+
+	nrq->__sector =3D blk_rq_pos(rq);
+	nrq->__data_len =3D blk_rq_bytes(rq);
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		nrq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
+		nrq->special_vec =3D rq->special_vec;
+	}
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	nrq->nr_integrity_segments =3D rq->nr_integrity_segments;
+#endif
+	nrq->nr_phys_segments =3D rq->nr_phys_segments;
+	nrq->ioprio =3D rq->ioprio;
+	nrq->extra_len =3D rq->extra_len;
+	nrq->rq_disk =3D rq->rq_disk;
+	nrq->part =3D rq->part;
+	nrq->write_hint =3D rq->write_hint;
+	nrq->timeout =3D rq->timeout;
+
+	memcpy(blk_mq_rq_to_pdu(nrq), blk_mq_rq_to_pdu(rq),
+			rq->q->tag_set->cmd_size);
+
+	nrq->end_io =3D blk_mq_resubmit_end_io;
+	nrq->end_io_data =3D rq;
+	nrq->bio =3D rq->bio;
+	nrq->biotail =3D rq->biotail;
+
+	blk_account_io_start(nrq, true);
+	blk_mq_sched_insert_request(nrq, true, true, true);
+}
+
+static void blk_mq_resubmit_fs_io(struct request *rq)
+{
+	struct bio_list list;
+	struct bio *bio;
+
+	bio_list_init(&list);
+	blk_steal_bios(&list, rq);
+
+	while (true) {
+		bio =3D bio_list_pop(&list);
+		if (!bio)
+			break;
+
+		generic_make_request(bio);
+	}
+
+	blk_mq_cleanup_rq(rq);
+	blk_mq_end_request(rq, 0);
+}
+
+static void blk_mq_resubmit_io(struct request *rq)
+{
+	if (rq->end_io || blk_rq_is_passthrough(rq))
+		blk_mq_resubmit_passthrough_io(rq);
+	else
+		blk_mq_resubmit_fs_io(rq);
+}
+
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * 'cpu' has gone away. If this hctx is inactive, we can't dispatch requ=
est
+ * to the hctx any more, so steal bios from requests of this hctx, and
+ * re-submit them to the request queue, and free these requests finally.
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
@@ -2394,14 +2482,38 @@ static int blk_mq_hctx_notify_dead(unsigned int c=
pu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
=20
-	if (list_empty(&tmp))
-		return 0;
+	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
+		if (!list_empty(&tmp)) {
+			spin_lock(&hctx->lock);
+			list_splice_tail_init(&tmp, &hctx->dispatch);
+			spin_unlock(&hctx->lock);
+			blk_mq_run_hw_queue(hctx, true);
+		}
+	} else {
+		LIST_HEAD(flush_in);
+		LIST_HEAD(flush_out);
+		struct request *rq, *nxt;
=20
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+		/* requests in dispatch list have to be re-submitted too */
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&hctx->dispatch, &tmp);
+		spin_unlock(&hctx->lock);
+
+		/* blk_end_flush_machinery will cover flush request */
+		list_for_each_entry_safe(rq, nxt, &tmp, queuelist) {
+			if (rq->rq_flags & RQF_FLUSH_SEQ)
+				list_move(&rq->queuelist, &flush_in);
+		}
+		blk_end_flush_machinery(hctx, &flush_in, &flush_out);
+		list_splice_tail(&flush_out, &tmp);
+
+		while (!list_empty(&tmp)) {
+			rq =3D list_first_entry(&tmp, struct request, queuelist);
+			list_del_init(&rq->queuelist);
+			blk_mq_resubmit_io(rq);
+		}
+	}
=20
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
=20
--=20
2.25.2

