Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E0C2BABC
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FC320719
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz+s2zWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgDGJ3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:29:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31462 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgDGJ3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 05:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586251791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AG3vQKcb8cjHMJLULE28lxrI67Hck0Da6of4EFr9N9Y=;
        b=Rz+s2zWW89rNhSCDJGzce5kAA3SzGwdebiC75pKN0xMpwrmnlZsiHm4rRDnP1nq+6D9wQg
        vpRpaR1GwM8OHVJlgOP/EZOaXh2YetEBkLTPanQ1RZ9lAhR8GV7RsiHepsffQxHDGQs9mY
        qWnRlOB+rKp77ksp+DKYiaN7zzMMDWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-ectM9YnkPAy8kTB_iju14A-1; Tue, 07 Apr 2020 05:29:47 -0400
X-MC-Unique: ectM9YnkPAy8kTB_iju14A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB028800D50;
        Tue,  7 Apr 2020 09:29:45 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0F55DA7B;
        Tue,  7 Apr 2020 09:29:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 6/8] blk-mq: re-submit IO in case that hctx is inactive
Date:   Tue,  7 Apr 2020 17:28:59 +0800
Message-Id: <20200407092901.314228-7-ming.lei@redhat.com>
In-Reply-To: <20200407092901.314228-1-ming.lei@redhat.com>
References: <20200407092901.314228-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 block/blk-mq.c | 131 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index aac86cd99f02..6749f39fdd11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2319,10 +2319,98 @@ static int blk_mq_hctx_notify_online(unsigned int=
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
@@ -2342,16 +2430,39 @@ static int blk_mq_hctx_notify_dead(unsigned int c=
pu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
=20
-	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
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
-	if (list_empty(&tmp))
-		return 0;
+		/* requests in dispatch list have to be re-submitted too */
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&hctx->dispatch, &tmp);
+		spin_unlock(&hctx->lock);
=20
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
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
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	}
=20
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
=20
--=20
2.25.2

