Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB42E6CB8
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997595; cv=none; b=WqbFm1DVf/xmgCdOg+d7X7ph2NHZ2YlQpjRidB5nljpGVOJdmEPadiy5GRsbGiwaPGKlGXesCJpjgnttgzGmgMp1c38Rb8DYNBtodMyAcTPCcRYq4+cblzv+6kDM0ndqByAqn/98Bjfy7OoCmh86Xa47W30NDYNbNmWyogn5mD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997595; c=relaxed/simple;
	bh=0Q34eKUDCIxIa6ArjrdflXR7OU1WpVEbZndcCQA2EgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHYYTZCziEJSMdqJ1vU+bHDaJB+RyNukNEvsuEleGTVvSP4aZPssig9xKtWAuRfnh+IgGyH937XNLbgR1qp8vwkoW15i+7sbrgDEk7JKztDt8couJIPRe57vvnzZjIce36Azz7I7b4ln/AdOxkc+ztBzIBxYfVqIdUTtPGkI6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XdHUFsrQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XdHUFsrQ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6x5X7Hz1XLyhH;
	Thu, 28 May 2026 19:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997589; x=1782589590; bh=U5bCm
	rj3AZJd2CRPI0jLRWD1MGqGfQiJ64ppoc2ABjQ=; b=XdHUFsrQxetGQWacEDyH3
	lArCylfLE8yGgu+FcDh3B4V5QmBoGGRIy1bzd4NeUzK4TDM64aeuXVXx2akaZVPu
	+3Yi+zhDY5WXlM865G60SB/gE0FED3O1RRCGyvo9NyuQ64y+/f+8rrJbieGLVYk5
	4+I/nJvfHwJCkIQkbuUJft0hZZE+knSLNYB3YKjvCF7WOCUdoHiAfN2jm1owMjyw
	syOtvxViY94SjHXzYLVDLvQPrWMZ5lAi64f1K94HUM0QWXlxuumcwYmB4xnRgnOG
	USRHSvJMewkLG5C/ebq65utwnpuVI1tP6VhGjytcEX/r2+5k+sIXv3Mn45Siv2a+
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NhqiRQojCwqW; Thu, 28 May 2026 19:46:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6q3L6Cz1XM0pY;
	Thu, 28 May 2026 19:46:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5 09/12] block/blk-mq-debugfs: Improve lock context annotations
Date: Thu, 28 May 2026 12:45:46 -0700
Message-ID: <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
 block/blk-mq-debugfs.c | 12 ++++++------
 block/blk.h            |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..5c168e82273e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -20,7 +20,7 @@ static int queue_poll_stat_show(void *data, struct seq_=
file *m)
 }
=20
 static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&q->requeue_lock)
+	__acquires(&((struct request_queue *)m->private)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
@@ -36,7 +36,7 @@ static void *queue_requeue_list_next(struct seq_file *m=
, void *v, loff_t *pos)
 }
=20
 static void queue_requeue_list_stop(struct seq_file *m, void *v)
-	__releases(&q->requeue_lock)
+	__releases(&((struct request_queue *)m->private)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
@@ -298,7 +298,7 @@ int blk_mq_debugfs_rq_show(struct seq_file *m, void *=
v)
 EXPORT_SYMBOL_GPL(blk_mq_debugfs_rq_show);
=20
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&hctx->lock)
+	__acquires(&((struct blk_mq_hw_ctx *)m->private)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
@@ -314,7 +314,7 @@ static void *hctx_dispatch_next(struct seq_file *m, v=
oid *v, loff_t *pos)
 }
=20
 static void hctx_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&hctx->lock)
+	__releases(&((struct blk_mq_hw_ctx *)m->private)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
@@ -486,7 +486,7 @@ static int hctx_dispatch_busy_show(void *data, struct=
 seq_file *m)
=20
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos)=
 \
-	__acquires(&ctx->lock)						\
+	__acquires(&((struct blk_mq_ctx *)m->private)->lock)		\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
@@ -503,7 +503,7 @@ static void *ctx_##name##_rq_list_next(struct seq_fil=
e *m, void *v,	\
 }									\
 									\
 static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
-	__releases(&ctx->lock)						\
+	__releases(&((struct blk_mq_ctx *)m->private)->lock)		\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
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
