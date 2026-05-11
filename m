Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32B313E24
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517099; cv=none; b=iduRLHOzRVlByk+f3MWSTFKWM9/R+CQ6Ds2BMw/0zFE2aOQ2wU/A4tqGUblPXjEoKwF9GM7JE2kSeOOPBA6uxQNB8zR5w3YBNP8hZ0prKNtUF6AGKPMsptKoj/g8dH75hEzEwXY9/2ay8CQ8I/FVyGNldru9PdTwzzbn5m4+Dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517099; c=relaxed/simple;
	bh=xWPss5GxDknQY7AGRWBqYfcjuC1pCLm4wtb/Oq1imTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJBoFoSuZOfwTaBvHEVb+UMHjN99b98AQGB+35HXs9wYBuVvpJEsjBgV3K3UPMPgJV8H4NvYPh4vaF7QZl9R01eoLAd5iEDY/DwVbqLIvLC4Bk3IGamUp13rnl2pWXbiQnPtQmSfjozgYPnOS4yoIw8iQCbvZZCIczpP1XMJf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0Lep0q6P; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0Lep0q6P"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbs6BTszlfl89;
	Mon, 11 May 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517092; x=1781109093; bh=u5BHi
	entyOGnG1PxnGJR6dv/RAoF2t+lQEdeGYcM2iY=; b=0Lep0q6PS6vLjhwNQ+goo
	69dfytt8Hc2zh8yiI+8rSMSjWYvoYjYJ12g0IvRN0uqkuNrTN00qoiqmjzGLCubT
	R8TKBaFwi/hH5q3T6oG9xU6yXY424/uWecxwkHvDTKZOrrUaCrHF5oEn3iKEakRR
	gFmBozhoCdgxGHac3QDjGyILWueHiuZMjJEFHKd6cZYNuLTEBC0g7owzJK8wQ1ff
	sf1YbPmgYeb3iBZ/8R5munW9hlXEbXdpQlU2qVB/A3eVgPSQ0W0XJkKwrktYfiOB
	D5Qh566o9g/ipGeOZuefExoGTs8aFIdyalf6vCF1vDWjOMY33pdwlQVvav5k4/Go
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UoWWnGA3ljxZ; Mon, 11 May 2026 16:31:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbl06YTzlgyH6;
	Mon, 11 May 2026 16:31:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 09/12] block/blk-mq-debugfs: Improve lock context annotations
Date: Mon, 11 May 2026 09:30:51 -0700
Message-ID: <20260511163100.1887263-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
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
index b998a7761faf..70b794e89a67 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -754,16 +754,19 @@ static inline void blk_unfreeze_release_lock(struct=
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
@@ -773,6 +776,7 @@ static inline unsigned int __must_check blk_debugfs_l=
ock(struct request_queue *q
=20
 static inline void blk_debugfs_unlock(struct request_queue *q,
 				      unsigned int memflags)
+	__releases(&q->debugfs_mutex)
 {
 	blk_debugfs_unlock_nomemrestore(q);
 	memalloc_noio_restore(memflags);
