Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBB3F4DE2
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420128; cv=none; b=jbmB/RZCmhkFrddLIPNOAJ8bgCW4/BNo1AH1oZ17oeY6fQn+Ci8k8NStEUfh85VZHl5YnZNKAHb+HLzIHwa7WFuBbZvhXB0njrvo/yj1q4PpowhKKL45Lv83fFhfmIVzuTicBX+Mvus5wkF23m6bssv54Y6SjV8zNPxCQj3rtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420128; c=relaxed/simple;
	bh=tYdyXcVawMQCg3c6SgPnV5qOmGOFOx+BO/wHdRePpaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKvDzFwNC7VBePMY/VEo91usZglH80iDbLt2MsQt8Wrtjp6XDIAwNRPwoCAslxf/xsR3bVAnco3OxP6Q1FRT/vgHLXDtclSyYChLOxoD6/EmuYhYrIDn1elfp+deQJlR9qVQjt2GlKvFxbGaf+x91rf1AHE2X18Dlr+eT40NOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xFQoKhAW; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xFQoKhAW"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNZ5VnNz1XM0ny;
	Tue,  2 Jun 2026 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420119; x=1783012120; bh=/P5sc
	n+3rVzFz3VqR063xAcnM0s9LiU7sZjXRmwDUsM=; b=xFQoKhAWY9GXBG3uYyciI
	5/cIdpxNIRTbd8gO4hpKX/Ii3KuIOr5guatmydfHkRM2WdlhSEtjGSgK+JrL8NGT
	/UJKZnswVcdTH+uZAtldvQUqObqnmmi1Uk+DP41KH1UpJFpWsU5ZUJMRN7LWHm04
	rfs4UoxI0/1s1QriSL/t615qlqYWrrzwvJlLzFUQvc+EKzUB5xkRWh5UR54a1MoD
	77WuM7ldUx4DtsVN8YXiLwAGpdB1jf49vSZ5RSFHtBiG+cd3YWO1gA0+3+wkLo1r
	7kS6em//qEOzNbVhxBz3Eec8GCkBm33iajnevV7NgvF/SjdsKrG2KlkqBO36DjYD
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id b-S6Qdl7_6SP; Tue,  2 Jun 2026 17:08:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNP3PPrz1XM0p0;
	Tue,  2 Jun 2026 17:08:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v6 11/14] block/blk-mq-debugfs: Improve lock context annotations
Date: Tue,  2 Jun 2026 10:07:40 -0700
Message-ID: <66eff9a5e488fbe0b79db3a54518fe5d181a31ec.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make the existing lock context annotations compatible with Clang. Add
the lock context annotations that are missing.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 24 ++++++++++++++++++------
 block/blk.h            |  4 ++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..6754d8f9449c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -19,8 +19,10 @@ static int queue_poll_stat_show(void *data, struct seq=
_file *m)
 	return 0;
 }
=20
+#define TO_REQUEST_QUEUE(m) ((struct request_queue *)m->private)
+
 static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&q->requeue_lock)
+	__acquires(&TO_REQUEST_QUEUE(m)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
@@ -36,13 +38,15 @@ static void *queue_requeue_list_next(struct seq_file =
*m, void *v, loff_t *pos)
 }
=20
 static void queue_requeue_list_stop(struct seq_file *m, void *v)
-	__releases(&q->requeue_lock)
+	__releases(&TO_REQUEST_QUEUE(m)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
 	spin_unlock_irq(&q->requeue_lock);
 }
=20
+#undef TO_REQUEST_QUEUE
+
 static const struct seq_operations queue_requeue_list_seq_ops =3D {
 	.start	=3D queue_requeue_list_start,
 	.next	=3D queue_requeue_list_next,
@@ -297,8 +301,10 @@ int blk_mq_debugfs_rq_show(struct seq_file *m, void =
*v)
 }
 EXPORT_SYMBOL_GPL(blk_mq_debugfs_rq_show);
=20
+#define TO_HCTX(m) ((struct blk_mq_hw_ctx *)m->private)
+
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&hctx->lock)
+	__acquires(&TO_HCTX(m)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
@@ -314,13 +320,15 @@ static void *hctx_dispatch_next(struct seq_file *m,=
 void *v, loff_t *pos)
 }
=20
 static void hctx_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&hctx->lock)
+	__releases(&TO_HCTX(m)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
 	spin_unlock(&hctx->lock);
 }
=20
+#undef TO_HCTX
+
 static const struct seq_operations hctx_dispatch_seq_ops =3D {
 	.start	=3D hctx_dispatch_start,
 	.next	=3D hctx_dispatch_next,
@@ -484,9 +492,11 @@ static int hctx_dispatch_busy_show(void *data, struc=
t seq_file *m)
 	return 0;
 }
=20
+#define TO_CTX(m) ((struct blk_mq_ctx *)m->private)
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos)=
 \
-	__acquires(&ctx->lock)						\
+	__acquires(&TO_CTX(m)->lock)					\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
@@ -503,7 +513,7 @@ static void *ctx_##name##_rq_list_next(struct seq_fil=
e *m, void *v,	\
 }									\
 									\
 static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
-	__releases(&ctx->lock)						\
+	__releases(&TO_CTX(m)->lock)					\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
@@ -521,6 +531,8 @@ CTX_RQ_SEQ_OPS(default, HCTX_TYPE_DEFAULT);
 CTX_RQ_SEQ_OPS(read, HCTX_TYPE_READ);
 CTX_RQ_SEQ_OPS(poll, HCTX_TYPE_POLL);
=20
+#undef TO_CTX
+
 static int blk_mq_debugfs_show(struct seq_file *m, void *v)
 {
 	const struct blk_mq_debugfs_attr *attr =3D m->private;
diff --git a/block/blk.h b/block/blk.h
index bf1a80493ff1..1a2d9101bba0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -756,16 +756,19 @@ static inline void blk_unfreeze_release_lock(struct=
 request_queue *q)
  * reclaim from triggering block I/O.
  */
 static inline void blk_debugfs_lock_nomemsave(struct request_queue *q)
+	__acquires(&q->debugfs_mutex)
 {
 	mutex_lock(&q->debugfs_mutex);
 }
=20
 static inline void blk_debugfs_unlock_nomemrestore(struct request_queue =
*q)
+	__releases(&q->debugfs_mutex)
 {
 	mutex_unlock(&q->debugfs_mutex);
 }
=20
 static inline unsigned int __must_check blk_debugfs_lock(struct request_=
queue *q)
+	__acquires(&q->debugfs_mutex)
 {
 	unsigned int memflags =3D memalloc_noio_save();
=20
@@ -775,6 +778,7 @@ static inline unsigned int __must_check blk_debugfs_l=
ock(struct request_queue *q
=20
 static inline void blk_debugfs_unlock(struct request_queue *q,
 				      unsigned int memflags)
+	__releases(&q->debugfs_mutex)
 {
 	blk_debugfs_unlock_nomemrestore(q);
 	memalloc_noio_restore(memflags);
