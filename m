Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33497 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbdAXPyt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 10:54:49 -0500
To: Jens Axboe <axboe@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] queue stall with blk-mq-sched
Message-ID: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
Date: Tue, 24 Jan 2017 16:54:46 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8DD5F5B5E441F8411716ED43"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------8DD5F5B5E441F8411716ED43
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Jens,

I'm trying to debug a queue stall with your blk-mq-sched branch; with my
latest mpt3sas patches fio stops basically directly after starting a
sequential read :-(

I've debugged things and came up with the attached patch; we need to
restart waiters with blk_mq_tag_idle() after completing a tag.
We're already calling blk_mq_tag_busy() when fetching a tag, so I think
calling blk_mq_tag_idle() is required when retiring a tag.

However, even with the attached patch I'm seeing some queue stalls;
looks like they're related to the 'stonewall' statement in fio.

Debugging continues.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)

--------------8DD5F5B5E441F8411716ED43
Content-Type: text/x-patch;
 name="0001-block-mq-fixup-queue-stall.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-block-mq-fixup-queue-stall.patch"

=46rom 82b15ff40d71aed318f9946881825f9f03ef8f48 Mon Sep 17 00:00:00 2001
From: Hannes Reinecke <hare@suse.de>
Date: Tue, 24 Jan 2017 14:43:09 +0100
Subject: [PATCH] block-mq: fixup queue stall

__blk_mq_alloc_request() calls blk_mq_tag_busy(), which might result
in the queue to become blocked. So we need to call blk_mq_tag_idle()
once the tag is finished to wakeup all waiters on the queue.

Patch is relative to the blk-mq-sched branch
=20
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 739a292..d52bcb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -333,10 +333,12 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *=
hctx, struct blk_mq_ctx *ctx,
 {
 	const int sched_tag =3D rq->internal_tag;
 	struct request_queue *q =3D rq->q;
+	bool unbusy =3D false;
=20
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		atomic_dec(&hctx->nr_active);
-
+		unbusy =3D true;
+	}
 	wbt_done(q->rq_wb, &rq->issue_stat);
 	rq->rq_flags =3D 0;
=20
@@ -346,6 +348,9 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hc=
tx, struct blk_mq_ctx *ctx,
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag !=3D -1)
 		blk_mq_sched_completed_request(hctx, rq);
+	if (unbusy)
+		blk_mq_tag_idle(hctx);
+
 	blk_queue_exit(q);
 }
=20
--=20
1.8.5.6


--------------8DD5F5B5E441F8411716ED43--
