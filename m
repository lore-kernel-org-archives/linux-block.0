Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0446AEEA
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517102; cv=none; b=MLLcuOd66DC3mOY08eOogWdXbGjb3U4x2La75/reltuIxt+t6QasBDLyksiwtNGZeztllanWBwNCoWMSRbq01LKlosogphLwh4tTOGYzIzIhAdChsiBmWLGHOg/+r8N/idFADlU6BRwqVr1rAJVCCrg6fHYZI5wGa5yCXpvqhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517102; c=relaxed/simple;
	bh=AMp0hETk4GIm2Kv/kvpMRWVSyqH0LPzoPQDhrPgKvCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddMugcOAk/4ZmjYII8XevOjYMOg4MlpeIsbt/WPafJl72EMWkvxv3EePDXXMofAmRw+8qaoHYf8CaIwCTgOfdH/9x5jFdtuRlHYJi9LsE4tInjw8nwEx7tw2cdalITyYEizc7KOuYjWUxotRy/YqtGrJPPe3ElD6bimigoaemk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zSsFX2RL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zSsFX2RL"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbw0Ybczlh2fp;
	Mon, 11 May 2026 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517080; x=1781109081; bh=wYFvH
	3n98GdCMxRme4j5YjyYVgEzBuWYROnC2UuIUhE=; b=zSsFX2RLY/yU61hyeI2HF
	JJ+mLm6jvlETRuR9E/uSY65JYt5ESBFKJRHkDZ/r2khJdyk6/NE+8m+uIn0QGC2G
	oHDRjCADp3m34NAjJgqKkbRo1HoPzMwL/D4wn9iRYn5yk7GNrghIsAq59oMLC6LE
	aEz+mY8j23hASoDNODQR9Exq7BaFZj1jbXTViiO0Z6NDsptbc6orfh+X/9cc3c9x
	fUFWHiFc9y8za5Y5AfhZlPywPfnoAWWzSLDwa0jHlKpVDfuCcqn1YrcxZa5fz5Jk
	pOcF0gdti+1XwZCavTMgVZPu4tHyNZpMflzngvCL/ZGoHHqfcSPW9/nu9YQwoy2S
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EURSlGAhPtEX; Mon, 11 May 2026 16:31:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbV3BMpzlgtd1;
	Mon, 11 May 2026 16:31:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 04/12] block/cgroup: Split blkg_conf_exit()
Date: Mon, 11 May 2026 09:30:46 -0700
Message-ID: <20260511163100.1887263-5-bvanassche@acm.org>
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

Split blkg_conf_exit() into blkg_conf_unprep() and blkg_conf_close_bdev()
because blkg_conf_exit() is not compatible with the Clang thread-safety
annotations. Remove blkg_conf_exit(). Rename blkg_conf_exit_frozen() into
blkg_conf_close_bdev_frozen(). Add thread-safety annotations to the new
functions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c    |  9 ++++--
 block/blk-cgroup.c    | 57 ++++++++++++++++++------------------
 block/blk-cgroup.h    |  6 ++--
 block/blk-iocost.c    | 67 +++++++++++++++++++++----------------------
 block/blk-iolatency.c | 19 ++++++------
 block/blk-throttle.c  | 34 +++++++++++++---------
 6 files changed, 101 insertions(+), 91 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 38396df9dce7..5d40279d6c9d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1053,11 +1053,11 @@ static ssize_t bfq_io_set_device_weight(struct ke=
rnfs_open_file *of,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto out;
+		return ret;
=20
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_bfq, &ctx);
 	if (ret)
-		goto out;
+		goto close_bdev;
=20
 	if (sscanf(ctx.body, "%llu", &v) =3D=3D 1) {
 		/* require "default" on dfl */
@@ -1078,8 +1078,11 @@ static ssize_t bfq_io_set_device_weight(struct ker=
nfs_open_file *of,
 		bfq_group_set_weight(bfqg, bfqg->entity.weight, v);
 		ret =3D 0;
 	}
+
 out:
-	blkg_conf_exit(&ctx);
+	blkg_conf_unprep(&ctx);
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
 	return ret ?: nbytes;
 }
=20
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a8d95d51b866..38d7bcfcbbe8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
  *
  * Initialize @ctx which can be used to parse blkg config input string @=
input.
  * Once initialized, @ctx can be used with blkg_conf_open_bdev() and
- * blkg_conf_prep(), and must be cleaned up with blkg_conf_exit().
+ * blkg_conf_prep().
  */
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input)
 {
@@ -817,8 +817,8 @@ EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
  * ensures the correct locking order between freeze queue and q->rq_qos_=
mutex.
  *
  * This function returns negative error on failure. On success it return=
s
- * memflags which must be saved and later passed to blkg_conf_exit_froze=
n
- * for restoring the memalloc scope.
+ * memflags which must be saved and later passed to
+ * blkg_conf_close_bdev_frozen() for restoring the memalloc scope.
  */
 unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_c=
tx *ctx)
 {
@@ -858,7 +858,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen=
(struct blkg_conf_ctx *ctx)
  *
  * blkg_conf_open_bdev() must be called on @ctx beforehand. On success, =
this
  * function returns with queue lock held and must be followed by
- * blkg_conf_exit().
+ * blkg_conf_close_bdev().
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
@@ -968,42 +968,41 @@ int blkg_conf_prep(struct blkcg *blkcg, const struc=
t blkcg_policy *pol,
 EXPORT_SYMBOL_GPL(blkg_conf_prep);
=20
 /**
- * blkg_conf_exit - clean up per-blkg config update
+ * blkg_conf_unprep - counterpart of blkg_conf_prep()
  * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
- *
- * Clean up after per-blkg config update. This function must be called o=
n all
- * blkg_conf_ctx's initialized with blkg_conf_init().
  */
-void blkg_conf_exit(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->queue_lock)
-	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
+void blkg_conf_unprep(struct blkg_conf_ctx *ctx)
 {
-	if (ctx->blkg) {
-		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
-		ctx->blkg =3D NULL;
-	}
+	WARN_ON_ONCE(!ctx->blkg);
+	spin_unlock_irq(&ctx->bdev->bd_disk->queue->queue_lock);
+	ctx->blkg =3D NULL;
+}
+EXPORT_SYMBOL_GPL(blkg_conf_unprep);
=20
-	if (ctx->bdev) {
-		mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
-		blkdev_put_no_open(ctx->bdev);
-		ctx->body =3D NULL;
-		ctx->bdev =3D NULL;
-	}
+/**
+ * blkg_conf_close_bdev - counterpart of blkg_conf_open_bdev()
+ * @ctx: blkg_conf_ctx initialized with blkg_conf_init()
+ */
+void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx)
+{
+	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
+	blkdev_put_no_open(ctx->bdev);
+	ctx->body =3D NULL;
+	ctx->bdev =3D NULL;
 }
-EXPORT_SYMBOL_GPL(blkg_conf_exit);
+EXPORT_SYMBOL_GPL(blkg_conf_close_bdev);
=20
 /*
- * Similar to blkg_conf_exit, but also unfreezes the queue. Should be us=
ed
+ * Similar to blkg_close_bdev, but also unfreezes the queue. Should be u=
sed
  * when blkg_conf_open_bdev_frozen is used to open the bdev.
  */
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memf=
lags)
+void blkg_conf_close_bdev_frozen(struct blkg_conf_ctx *ctx,
+				 unsigned long memflags)
 {
-	if (ctx->bdev) {
-		struct request_queue *q =3D ctx->bdev->bd_queue;
+	struct request_queue *q =3D ctx->bdev->bd_queue;
=20
-		blkg_conf_exit(ctx);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
+	blkg_conf_close_bdev(ctx);
+	blk_mq_unfreeze_queue(q, memflags);
 }
=20
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat =
*src)
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d..ce90f5b60d52 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -222,8 +222,10 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
 unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
-void blkg_conf_exit(struct blkg_conf_ctx *ctx);
-void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memf=
lags);
+void blkg_conf_unprep(struct blkg_conf_ctx *ctx);
+void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx);
+void blkg_conf_close_bdev_frozen(struct blkg_conf_ctx *ctx,
+				 unsigned long memflags);
=20
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root b=
lkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b34f820dedcc..e611dd63d712 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3142,21 +3142,23 @@ static ssize_t ioc_weight_write(struct kernfs_ope=
n_file *of, char *buf,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto err;
+		return ret;
=20
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
 	if (ret)
-		goto err;
+		goto close_bdev;
=20
 	iocg =3D blkg_to_iocg(ctx.blkg);
=20
+	ret =3D -EINVAL;
+
 	if (!strncmp(ctx.body, "default", 7)) {
 		v =3D 0;
 	} else {
 		if (!sscanf(ctx.body, "%u", &v))
-			goto einval;
+			goto unprep;
 		if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
-			goto einval;
+			goto unprep;
 	}
=20
 	spin_lock(&iocg->ioc->lock);
@@ -3165,14 +3167,15 @@ static ssize_t ioc_weight_write(struct kernfs_ope=
n_file *of, char *buf,
 	weight_updated(iocg, &now);
 	spin_unlock(&iocg->ioc->lock);
=20
-	blkg_conf_exit(&ctx);
-	return nbytes;
+	ret =3D 0;
=20
-einval:
-	ret =3D -EINVAL;
-err:
-	blkg_conf_exit(&ctx);
-	return ret;
+unprep:
+	blkg_conf_unprep(&ctx);
+
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
+
+	return ret ? ret : nbytes;
 }
=20
 static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *=
pd,
@@ -3241,10 +3244,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_fi=
le *of, char *input,
 	blkg_conf_init(&ctx, input);
=20
 	memflags =3D blkg_conf_open_bdev_frozen(&ctx);
-	if (IS_ERR_VALUE(memflags)) {
-		ret =3D memflags;
-		goto err;
-	}
+	if (IS_ERR_VALUE(memflags))
+		return memflags;
=20
 	body =3D ctx.body;
 	disk =3D ctx.bdev->bd_disk;
@@ -3361,14 +3362,14 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
=20
 	blk_mq_unquiesce_queue(disk->queue);
=20
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_close_bdev_frozen(&ctx, memflags);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
 	blk_mq_unquiesce_queue(disk->queue);
 	ret =3D -EINVAL;
 err:
-	blkg_conf_exit_frozen(&ctx, memflags);
+	blkg_conf_close_bdev_frozen(&ctx, memflags);
 	return ret;
 }
=20
@@ -3434,20 +3435,20 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto err;
+		return ret;
=20
 	body =3D ctx.body;
 	q =3D bdev_get_queue(ctx.bdev);
 	if (!queue_is_mq(q)) {
 		ret =3D -EOPNOTSUPP;
-		goto err;
+		goto close_bdev;
 	}
=20
 	ioc =3D q_to_ioc(q);
 	if (!ioc) {
 		ret =3D blk_iocost_init(ctx.bdev->bd_disk);
 		if (ret)
-			goto err;
+			goto close_bdev;
 		ioc =3D q_to_ioc(q);
 	}
=20
@@ -3458,6 +3459,8 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user =3D ioc->user_cost_model;
=20
+	ret =3D -EINVAL;
+
 	while ((p =3D strsep(&body, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
 		char buf[32];
@@ -3475,20 +3478,20 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
 			else if (!strcmp(buf, "user"))
 				user =3D true;
 			else
-				goto einval;
+				goto unlock;
 			continue;
 		case COST_MODEL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
 			if (strcmp(buf, "linear"))
-				goto einval;
+				goto unlock;
 			continue;
 		}
=20
 		tok =3D match_token(p, i_lcoef_tokens, args);
 		if (tok =3D=3D NR_I_LCOEFS)
-			goto einval;
+			goto unlock;
 		if (match_u64(&args[0], &v))
-			goto einval;
+			goto unlock;
 		u[tok] =3D v;
 		user =3D true;
 	}
@@ -3500,24 +3503,18 @@ static ssize_t ioc_cost_model_write(struct kernfs=
_open_file *of, char *input,
 		ioc->user_cost_model =3D false;
 	}
 	ioc_refresh_params(ioc, true);
-	spin_unlock_irq(&ioc->lock);
=20
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
-
-	blkg_conf_exit(&ctx);
-	return nbytes;
+	ret =3D 0;
=20
-einval:
+unlock:
 	spin_unlock_irq(&ioc->lock);
=20
 	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
=20
-	ret =3D -EINVAL;
-err:
-	blkg_conf_exit(&ctx);
-	return ret;
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
+	return ret ? ret : nbytes;
 }
=20
 static struct cftype ioc_files[] =3D {
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 53e8dd2dfa8a..1aaee6fb0f59 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -840,7 +840,7 @@ static ssize_t iolatency_set_limit(struct kernfs_open=
_file *of, char *buf,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto out;
+		return ret;
=20
 	/*
 	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
@@ -850,11 +850,11 @@ static ssize_t iolatency_set_limit(struct kernfs_op=
en_file *of, char *buf,
 	if (!iolat_rq_qos(ctx.bdev->bd_queue))
 		ret =3D blk_iolatency_init(ctx.bdev->bd_disk);
 	if (ret)
-		goto out;
+		goto close_bdev;
=20
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
 	if (ret)
-		goto out;
+		goto close_bdev;
=20
 	iolat =3D blkg_to_lat(ctx.blkg);
 	p =3D ctx.body;
@@ -865,7 +865,7 @@ static ssize_t iolatency_set_limit(struct kernfs_open=
_file *of, char *buf,
 		char val[21];	/* 18446744073709551616 */
=20
 		if (sscanf(tok, "%15[^=3D]=3D%20s", key, val) !=3D 2)
-			goto out;
+			goto unprep;
=20
 		if (!strcmp(key, "target")) {
 			u64 v;
@@ -875,9 +875,9 @@ static ssize_t iolatency_set_limit(struct kernfs_open=
_file *of, char *buf,
 			else if (sscanf(val, "%llu", &v) =3D=3D 1)
 				lat_val =3D v * NSEC_PER_USEC;
 			else
-				goto out;
+				goto unprep;
 		} else {
-			goto out;
+			goto unprep;
 		}
 	}
=20
@@ -889,8 +889,11 @@ static ssize_t iolatency_set_limit(struct kernfs_ope=
n_file *of, char *buf,
 	if (oldval !=3D iolat->min_lat_nsec)
 		iolatency_clear_scaling(blkg);
 	ret =3D 0;
-out:
-	blkg_conf_exit(&ctx);
+
+unprep:
+	blkg_conf_unprep(&ctx);
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
 	return ret ?: nbytes;
 }
=20
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cabf91f0d0dc..8f269310cbf4 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1353,21 +1353,21 @@ static ssize_t tg_set_conf(struct kernfs_open_fil=
e *of,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto out_finish;
+		return ret;
=20
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret =3D blk_throtl_init(ctx.bdev->bd_disk);
 		if (ret)
-			goto out_finish;
+			goto close_bdev;
 	}
=20
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
-		goto out_finish;
+		goto close_bdev;
=20
 	ret =3D -EINVAL;
 	if (sscanf(ctx.body, "%llu", &v) !=3D 1)
-		goto out_finish;
+		goto unprep;
 	if (!v)
 		v =3D U64_MAX;
=20
@@ -1381,8 +1381,12 @@ static ssize_t tg_set_conf(struct kernfs_open_file=
 *of,
=20
 	tg_conf_updated(tg, false);
 	ret =3D 0;
-out_finish:
-	blkg_conf_exit(&ctx);
+
+unprep:
+	blkg_conf_unprep(&ctx);
+
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
 	return ret ?: nbytes;
 }
=20
@@ -1537,17 +1541,17 @@ static ssize_t tg_set_limit(struct kernfs_open_fi=
le *of,
=20
 	ret =3D blkg_conf_open_bdev(&ctx);
 	if (ret)
-		goto out_finish;
+		return ret;
=20
 	if (!blk_throtl_activated(ctx.bdev->bd_queue)) {
 		ret =3D blk_throtl_init(ctx.bdev->bd_disk);
 		if (ret)
-			goto out_finish;
+			goto close_bdev;
 	}
=20
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_throtl, &ctx);
 	if (ret)
-		goto out_finish;
+		goto close_bdev;
=20
 	tg =3D blkg_to_tg(ctx.blkg);
 	tg_update_carryover(tg);
@@ -1573,11 +1577,11 @@ static ssize_t tg_set_limit(struct kernfs_open_fi=
le *of,
 		p =3D tok;
 		strsep(&p, "=3D");
 		if (!p || (sscanf(p, "%llu", &val) !=3D 1 && strcmp(p, "max")))
-			goto out_finish;
+			goto unprep;
=20
 		ret =3D -ERANGE;
 		if (!val)
-			goto out_finish;
+			goto unprep;
=20
 		ret =3D -EINVAL;
 		if (!strcmp(tok, "rbps"))
@@ -1589,7 +1593,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file=
 *of,
 		else if (!strcmp(tok, "wiops"))
 			v[3] =3D min_t(u64, val, UINT_MAX);
 		else
-			goto out_finish;
+			goto unprep;
 	}
=20
 	tg->bps[READ] =3D v[0];
@@ -1599,8 +1603,10 @@ static ssize_t tg_set_limit(struct kernfs_open_fil=
e *of,
=20
 	tg_conf_updated(tg, false);
 	ret =3D 0;
-out_finish:
-	blkg_conf_exit(&ctx);
+unprep:
+	blkg_conf_unprep(&ctx);
+close_bdev:
+	blkg_conf_close_bdev(&ctx);
 	return ret ?: nbytes;
 }
=20
