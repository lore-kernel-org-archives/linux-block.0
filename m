Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F93381B1D
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475148; cv=none; b=MzH6zAsPf9z3f/mPaxusFD4lpFMDtxZDLxxdS5LMqZgOaCeMjgFXYy2UuFtbx+TRjJ4KOVqy8vdPzAQ6O3IEcA/+6fK17Xs+1a6qlM6qroXuWGuVcUM1bliMX2AGN1/hO/OPN9GFyX2AdYhw/iQKnMroNFZJtpjwKQSGunaA+PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475148; c=relaxed/simple;
	bh=dQ5a0VTo+WmfhfFrhnR6R0WHNRGw5r9UJ5URdoZCBb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcyHhWMC2mExI1uogORg74/slG+8Zsxdhn6sh32Q3d+Lqu/FIMEvkEA41E8XwiSxO57mRYxB8hg3nqjeufKPl2Yqo/QSBKdF0O6tITuWmu52Lt0MS0Cwh4Dbb1f7RbGrUvnL+ooF1yvuPq0jkZuRZ9vH1xiUfpb4+VFX4eBL3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IP6KGxAC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IP6KGxAC"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0p15kpdzlgyGT;
	Wed, 25 Mar 2026 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475141; x=1777067142; bh=lZWj3
	rrMk8w4MDdfwG3sjYe7+6Y+E7sQzMpdCqhBmrY=; b=IP6KGxACPDQSI/OUe3pmd
	rhJ5i4OtGLx9tELwsCk/ZWPY/YhOrowBM9ejrpcli6U2Y17gNeXfVxMm2dN9gMeG
	QupoboX53ClpmgkvNpRR4ehTjObgVsefE1gg1jWIEhqr1pc4RUdKX5SPvTBQ+opW
	ttYDC+kN1rsy0kZxciI1Jfhb3svpLG19kj8rve3nmeBRziHi64fjjyNYNp/tRv+i
	i4naIsWsF8R9TA2qr8y8ct0sCDHvuTWfMsRRxO2w9q1e17ZLBYV12RNE2r75krzA
	QGFUx/C0H06sqywDKFtwG3rP/CcQz6BTreWubYhqvPwS9Jwya7OCZqy58HSsa4Gd
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qo2_k9R624Bb; Wed, 25 Mar 2026 21:45:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0nv2ZcrzlfpMC;
	Wed, 25 Mar 2026 21:45:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 05/26] block/cgroup: Modify the blkg_conf_open_bdev_frozen() calling convention
Date: Wed, 25 Mar 2026 14:44:46 -0700
Message-ID: <20260325214518.2854494-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of returning either a negative error number or a positive memory
flags value, pass a memory flags pointer as an argument and return zero
upon success. This patch prepares for adding thread-safety annotations
by changing the calling convention into something that is supported by
__cond_acquires().

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 12 +++++-------
 block/blk-cgroup.h |  4 +++-
 block/blk-iocost.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8c4052babffb..5b246020aced 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -815,14 +815,12 @@ EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
  * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
  * ensures the correct locking order between freeze queue and q->rq_qos_=
mutex.
  *
- * This function returns negative error on failure. On success it return=
s
- * memflags which must be saved and later passed to
- * blkg_conf_close_bdev_frozen() for restoring the memalloc scope.
+ * Returns: a negative error on failure or zero if successful.
  */
-unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_c=
tx *ctx)
+int blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx,
+			       unsigned long *memflags)
 {
 	int ret;
-	unsigned long memflags;
=20
 	if (ctx->bdev)
 		return -EINVAL;
@@ -838,10 +836,10 @@ unsigned long __must_check blkg_conf_open_bdev_froz=
en(struct blkg_conf_ctx *ctx)
 	 */
 	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
=20
-	memflags =3D blk_mq_freeze_queue(ctx->bdev->bd_queue);
+	*memflags =3D blk_mq_freeze_queue(ctx->bdev->bd_queue);
 	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
=20
-	return memflags;
+	return 0;
 }
=20
 /**
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index f0a3af520c55..f56fab637093 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -220,7 +220,9 @@ struct blkg_conf_ctx {
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	__cond_acquires(0, &ctx->bdev->bd_queue->rq_qos_mutex);
-unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
+int blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx,
+			       unsigned long *memflags)
+	__cond_acquires(0, &ctx->bdev->bd_queue->rq_qos_mutex);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
 	__cond_acquires(0, &ctx->bdev->bd_disk->queue->queue_lock);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index e435ac0c41e5..9f8bdae5a4b3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3232,9 +3232,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_fil=
e *of, char *input,
=20
 	blkg_conf_init(&ctx, input);
=20
-	memflags =3D blkg_conf_open_bdev_frozen(&ctx);
-	if (IS_ERR_VALUE(memflags))
-		return memflags;
+	ret =3D blkg_conf_open_bdev_frozen(&ctx, &memflags);
+	if (ret)
+		return ret;
=20
 	body =3D ctx.body;
 	disk =3D ctx.bdev->bd_disk;
