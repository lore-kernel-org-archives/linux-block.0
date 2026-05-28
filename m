Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23F330D4C
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997592; cv=none; b=lAyUZwD2WPjHRf6e37uBNw1nCE1PWiW57jdH4yAuRy2T1SAGQDDUdsGs6NyCv16w4V5TdAXJ8RpZFzg/Wr1XFOhjdT32x4Xxm48TQcsGpr7axtZXIKDEe2qd67gCinUsAyQDTXA0gN03xY/WVxdAgZ+z9uPO0mYuGV516Wbz1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997592; c=relaxed/simple;
	bh=uAcD9PygWQX2zFnQh9vHRmFr0RD7NRDqWpzfQlebtMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYpFfvPcp1kazCtLRBwMx/ibUzsiXUafH7l2kg91MF00inDA6CTucLerpjXa2A2oNVUhdKe9Bs0t98Chjo+mXEARM8u+QsuNsWSQw28qk6+UMdGp/fwu9AbabwJ5IvZC9JhuMQ8cz4ILjgnoXxZIaGR4ZSiv/HxxIBSQWxFFzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gm1T3eSR; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gm1T3eSR"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6t60pcz1XM0pk;
	Thu, 28 May 2026 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1779997582; x=
	1782589583; bh=VCtnxPL4NnBkk3MYOWookRIKQUo/+NxMJVtdOLzpB+Q=; b=g
	m1T3eSR0n/+J1VlRxUEw4WkxToFmNNL32CK5EqJt9M+07Y+xOCFX6Q0dmVy19Hm+
	4q0SK4hnx3TyMWbWF6plDuEdsYFhFB17OLM77qZiAAMaCBBHM+bU4Xxhikl22YII
	hWY7B7iGyTsbFmWiMV4S8EZu3kD3IpddigP5eJJcq/zcXliiutoEMWbw/UrGWdk2
	PFwIW6cIWp7zaIhmWZ7nqgRL2NIxpGUD9XJIsXuqWkC0v9urYDWoK6iOsQA5512b
	Vx15vHlsFbOrmpclApvtZVdDV/fPwViJN8AFczhZUsV5BUUcCZ8CiWwCb3LpOpaN
	idEvrNeDTR16OAR/1TUkw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LWx-WgoehjBD; Thu, 28 May 2026 19:46:22 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6h6VThz1XM0pp;
	Thu, 28 May 2026 19:46:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 06/12] block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
Date: Thu, 28 May 2026 12:45:43 -0700
Message-ID: <f7be976e5a79afc88970ea16158d0a64bbf8f25e.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The blkg_conf_open_bdev_frozen() calling convention is not compatible
with lock context annotations. Inline both blkg_conf_open_bdev_frozen()
and blkg_conf_close_bdev_frozen() because these functions only have a
single caller. This patch prepares for enabling lock context analysis.

The type of 'memflags' has been changed from unsigned long into unsigned
int to match the type of current->flags. See also <linux/sched.h>.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 46 ----------------------------------------------
 block/blk-cgroup.h |  4 ----
 block/blk-iocost.c | 29 +++++++++++++++++++++++------
 3 files changed, 23 insertions(+), 56 deletions(-)

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
index e611dd63d712..353c165c5cd4 100644
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
+	unsigned int memflags;
 	int ret;
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
@@ -3362,14 +3373,20 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
=20
 	blk_mq_unquiesce_queue(disk->queue);
=20
-	blkg_conf_close_bdev_frozen(&ctx, memflags);
+	q =3D ctx.bdev->bd_queue;
+	blkg_conf_close_bdev(&ctx);
+	blk_mq_unfreeze_queue(q, memflags);
+
 	return nbytes;
+
 einval:
 	spin_unlock_irq(&ioc->lock);
 	blk_mq_unquiesce_queue(disk->queue);
 	ret =3D -EINVAL;
 err:
-	blkg_conf_close_bdev_frozen(&ctx, memflags);
+	q =3D ctx.bdev->bd_queue;
+	blkg_conf_close_bdev(&ctx);
+	blk_mq_unfreeze_queue(q, memflags);
 	return ret;
 }
=20
