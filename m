Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33641 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936582AbdEYRYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 13:24:12 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
Date: Thu, 25 May 2017 17:24:08 +0000
Message-ID: <1495733047.2615.1.camel@sandisk.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
         <1495689892.3045.2.camel@sandisk.com> <20170525090917.GB15737@ming.t460p>
In-Reply-To: <20170525090917.GB15737@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-25 at 17:09 +0800, Ming Lei wrote:
> Another big issue is that 'srcu_struct' is very big, which shouldn't
> be embedded into hctx, since we only have one real user of
> BLK_MQ_F_BLOCKING.
>=20
> So I will fix that too.

Hello Ming,

Is something like the (untested) patch below perhaps what you had in mind?

Subject: [PATCH] blk-mq: Reduce blk_mq_hw_ctx size

Since the srcu structure is rather large (184 bytes on an x86-64
system), only allocate it if needed.

Reported-by: Ming Lei <ming.lei@redhat.com>
---
=A0block/blk-mq.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 13 ++++++++++++-
=A0include/linux/blk-mq.h |=A0=A05 +++--
=A02 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1e330de4e3c5..15b7d4077638 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2233,6 +2233,17 @@ struct request_queue *blk_mq_init_queue(struct blk_m=
q_tag_set *set)
=A0}
=A0EXPORT_SYMBOL(blk_mq_init_queue);
=A0
+static int blk_mq_hw_ctx_size(struct request_queue *q)
+{
+	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, queue_rq_srcu) +
+		sizeof(((struct blk_mq_hw_ctx *)NULL)->queue_rq_srcu), 64) !=3D
+		sizeof(struct blk_mq_hw_ctx));
+
+	return q->tag_set->flags & BLK_MQ_F_BLOCKING ?
+		sizeof(struct blk_mq_hw_ctx) :
+		offsetof(struct blk_mq_hw_ctx, queue_rq_srcu);
+}
+
=A0static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
=A0						struct request_queue *q)
=A0{
@@ -2247,7 +2258,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_=
set *set,
=A0			continue;
=A0
=A0		node =3D blk_mq_hw_queue_to_node(q->mq_map, i);
-		hctxs[i] =3D kzalloc_node(sizeof(struct blk_mq_hw_ctx),
+		hctxs[i] =3D kzalloc_node(blk_mq_hw_ctx_size(q),
=A0					GFP_KERNEL, node);
=A0		if (!hctxs[i])
=A0			break;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c0d59330b5e0..8467e1f83524 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -39,8 +39,6 @@ struct blk_mq_hw_ctx {
=A0	struct blk_mq_tags	*tags;
=A0	struct blk_mq_tags	*sched_tags;
=A0
-	struct srcu_struct	queue_rq_srcu;
-
=A0	unsigned long		queued;
=A0	unsigned long		run;
=A0#define BLK_MQ_MAX_DISPATCH_ORDER	7
@@ -62,6 +60,9 @@ struct blk_mq_hw_ctx {
=A0	struct dentry		*debugfs_dir;
=A0	struct dentry		*sched_debugfs_dir;
=A0#endif
+
+	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
+	struct srcu_struct	queue_rq_srcu;
=A0};
=A0
=A0struct blk_mq_tag_set {
--=A0
2.12.2
