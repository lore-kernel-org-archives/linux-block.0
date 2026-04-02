Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10A3EF653
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155237; cv=none; b=Dqy+gLVTBxti6kT5uChA8bWlMQi1PSvHtzDtUpuRLz08aOJg3Xs1wSCJdugvbe6GgJk5C1IJaQ6c/d5lg9rBEmJp4F8hLlJ5mveEt8MUP9/bUYXBKZfVtJ8tqUQOc1JEVxNHk4f/v14Y2LgorgmL49JFOewkYT1dWk3JHqx1faI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155237; c=relaxed/simple;
	bh=dHObjsFqigg3MqA3xtEWq6yNrbRkoWa6pBI6H2FA2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybwz6XcxS2rFtTer7klm3OeFGDZ9szKPeEpo/Q1o7MZ2sMQXmZ0etdBDSS95soanhjX6dk9eIbk7W9vuognisvZDLIastt28treDakulj3oRkHEAY6aZnEZkifT42KsAiTJCWhmZDg6yLN1REcUpoJH6zhLO74dp9eHCey82/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Oxpg1yzs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Oxpg1yzs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJf4tbkzlfwHM;
	Thu,  2 Apr 2026 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155229; x=1777747230; bh=RZlmT
	9rCmfelVAEMjjiRx+o5faZbQmkLKTTOo/sbXbM=; b=Oxpg1yzs2hIKhHiSwLtQ8
	qA1wtmZ/Jjhrj+qhQOebwH2WSGnO12R5hk6aZpqd/uGz4V1+WfHdTU/FwFbPB7dI
	Y8g89wRF1uMmgtAaHtLIqCxs65aY3pNhoMIXZB/M3KaR2hQe8FILgQdLqOXgA7mD
	aOH9PhbYJFw0IzCjCbGkL6uJdE0gtzbonHJv362eS+BYTWy1enQiCxVYBprmuTzz
	TDMdHZiQxlLR01F0AG0jAqKSvjWYp0j+UXz6v4KivGz+TzkyQq1ilXiuhnmpM0/0
	leP5PAGC3wWKZlvO8Y5a0Zw3fRCZc4cAVHOUFo0VjhPcj28D65pD4nYsY6QaD2/u
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W2NuZ-NTfngs; Thu,  2 Apr 2026 18:40:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJW54QLzlfvqC;
	Thu,  2 Apr 2026 18:40:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 08/12] block/blk-mq-debugfs: Improve lock context annotations
Date: Thu,  2 Apr 2026 11:39:40 -0700
Message-ID: <20260402183950.3626956-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
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
index 103cb1d0b9cb..7082dd5a87f9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -733,16 +733,19 @@ static inline void blk_unfreeze_release_lock(struct=
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
@@ -752,6 +755,7 @@ static inline unsigned int __must_check blk_debugfs_l=
ock(struct request_queue *q
=20
 static inline void blk_debugfs_unlock(struct request_queue *q,
 				      unsigned int memflags)
+	__releases(&q->debugfs_mutex)
 {
 	blk_debugfs_unlock_nomemrestore(q);
 	memalloc_noio_restore(memflags);
