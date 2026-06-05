Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90337FF4B
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682519; cv=none; b=t4Mp1DQ1FRTT/HxDp90q2MNAUTOoutBqK+nENOuHpiVPEE9dNp5GahCTpT/WHuHLNK4f3leZ2FG3+twDlKWqwVmLA8QVM+QvnFqMIPUIE9LdHmbt/LXvcHgV/vh4vKZbgvKzkERPcFM+gbmysdbtfDjBl8QuulC6wM0Tu4+C5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682519; c=relaxed/simple;
	bh=URZofMKXZTAKseLHWQPLHEohbpXrnEbybBUjCdUfpLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFbLI+Xp+5oPTBt2/L/9L8/CKq//ZRzFzYklZYPhpt78C+++o4hGwvP/q/vdt1GT3G4fzHRaKymT4lxeYOzqdfILs27LaE8c15i56sOREzeJK9dp38sfV2kM3Yu1NxAp28ZH8v7TLVeb1NZfvthYAT8ksobO2Znk3QUVx6UYsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qYf2pghm; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qYf2pghm"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8QY5qkVz1XM0ny;
	Fri,  5 Jun 2026 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1780682508; x=
	1783274509; bh=0M4d3Vjv0nhXlzOui/ot5K7EkQn0r2P9F7+B0zH2IM0=; b=q
	Yf2pghmRCfmZUgeqjJrpOlI3kiQtOdhnJhEB8oefiDd/h5lY8tFLI6mZXjbndsdx
	c2o05NVThMErVnTbGzEixCLpX7bThAR+A03r1AOMXOEF+DXxst1RCdgSM5JGqNPG
	BirTZVT9X41MMV+6mUojXtnEPSVBPg3rC9aRcHWxAic09WNgoEtqzIPUaGJ8uOAd
	oiX8eRQOI87ZzjMaFsmfK3jRAfYnpnRuVAh8DotaXUjaMo1YCh+JfelX3WEA18Lv
	DT/qvQu+Uo4in+JlGecw6JesOfrxCcorU0nhQCqWkIi7UWJvHk9T+MP67KAfF61M
	N43WW+p8GQQFil/BbbrSA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o1FTNkExu0Il; Fri,  5 Jun 2026 18:01:48 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QK6kl5z1XM0pP;
	Fri,  5 Jun 2026 18:01:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 07/14] block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
Date: Fri,  5 Jun 2026 11:01:00 -0700
Message-ID: <05661d1555decc6dd5389174ba448d803b72ed9a.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The blkg_conf_open_bdev_frozen() calling convention is not compatible
with lock context annotations. Fold both blkg_conf_open_bdev_frozen()
and blkg_conf_close_bdev_frozen() into their only caller. This patch
prepares for enabling lock context analysis.

The type of 'memflags' has been changed from unsigned long into unsigned
int to match the type of current->flags. See also <linux/sched.h>.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 46 ----------------------------------------------
 block/blk-cgroup.h |  4 ----
 block/blk-iocost.c | 25 +++++++++++++++++++------
 3 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 86513c54c217..de0f753b8fe5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -812,39 +812,6 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
=20
-/*
- * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
- * ensures the correct locking order between freeze queue and q->rq_qos_=
mutex.
- *
- * This function returns negative error on failure. On success it return=
s
- * memflags which must be saved and later passed to
- * blkg_conf_close_bdev_frozen() for restoring the memalloc scope.
- */
-unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_c=
tx *ctx)
-{
-	int ret;
-	unsigned long memflags;
-
-	if (ctx->bdev)
-		return -EINVAL;
-
-	ret =3D blkg_conf_open_bdev(ctx);
-	if (ret < 0)
-		return ret;
-	/*
-	 * At this point, we haven=E2=80=99t started protecting anything relate=
d to QoS,
-	 * so we release q->rq_qos_mutex here, which was first acquired in blkg=
_
-	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
-	 * the queue to maintain the correct locking order.
-	 */
-	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	memflags =3D blk_mq_freeze_queue(ctx->bdev->bd_queue);
-	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
-
-	return memflags;
-}
-
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
@@ -991,19 +958,6 @@ void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_close_bdev);
=20
-/*
- * Similar to blkg_close_bdev, but also unfreezes the queue. Should be u=
sed
- * when blkg_conf_open_bdev_frozen is used to open the bdev.
- */
-void blkg_conf_close_bdev_frozen(struct blkg_conf_ctx *ctx,
-				 unsigned long memflags)
-{
-	struct request_queue *q =3D ctx->bdev->bd_queue;
-
-	blkg_conf_close_bdev(ctx);
-	blk_mq_unfreeze_queue(q, memflags);
-}
-
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat =
*src)
 {
 	int i;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index f0a3af520c55..f25fecb87c43 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -220,7 +220,6 @@ struct blkg_conf_ctx {
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	__cond_acquires(0, &ctx->bdev->bd_queue->rq_qos_mutex);
-unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
 	__cond_acquires(0, &ctx->bdev->bd_disk->queue->queue_lock);
@@ -228,9 +227,6 @@ void blkg_conf_unprep(struct blkg_conf_ctx *ctx)
 	__releases(ctx->bdev->bd_disk->queue->queue_lock);
 void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx)
 	__releases(&ctx->bdev->bd_queue->rq_qos_mutex);
-void blkg_conf_close_bdev_frozen(struct blkg_conf_ctx *ctx,
-				 unsigned long memflags)
-	__releases(&ctx->bdev->bd_queue->rq_qos_mutex);
=20
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root b=
lkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 050bfbc6d806..302388e99588 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3233,19 +3233,30 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct blkg_conf_ctx ctx;
+	struct request_queue *q;
 	struct gendisk *disk;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *body, *p;
-	unsigned long memflags;
-	int ret =3D 0;
+	unsigned int memflags;
+	int ret;
=20
 	blkg_conf_init(&ctx, input);
=20
-	memflags =3D blkg_conf_open_bdev_frozen(&ctx);
-	if (IS_ERR_VALUE(memflags))
-		return memflags;
+	ret =3D blkg_conf_open_bdev(&ctx);
+	if (ret)
+		return ret;
+	/*
+	 * At this point, we haven=E2=80=99t started protecting anything relate=
d to QoS,
+	 * so we release q->rq_qos_mutex here, which was first acquired in blkg=
_
+	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
+	 * the queue to maintain the correct locking order.
+	 */
+	mutex_unlock(&ctx.bdev->bd_queue->rq_qos_mutex);
+
+	memflags =3D blk_mq_freeze_queue(ctx.bdev->bd_queue);
+	mutex_lock(&ctx.bdev->bd_queue->rq_qos_mutex);
=20
 	body =3D ctx.body;
 	disk =3D ctx.bdev->bd_disk;
@@ -3363,7 +3374,9 @@ static ssize_t ioc_qos_write(struct kernfs_open_fil=
e *of, char *input,
 	blk_mq_unquiesce_queue(disk->queue);
=20
 close_bdev:
-	blkg_conf_close_bdev_frozen(&ctx, memflags);
+	q =3D ctx.bdev->bd_queue;
+	blkg_conf_close_bdev(&ctx);
+	blk_mq_unfreeze_queue(q, memflags);
 	return ret ?: nbytes;
=20
 einval:
