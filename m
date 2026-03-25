Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0062777EA
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475142; cv=none; b=sR3jZU2NScdenTJ85C6zPZ87YDco1rP9ux6z4GJgBjbijrTHIhU449XCPusseroC2tLjkg92EE7L0G1nnm860FQUpOooSRqmpKDi44Irq0Z/maYM1r7tYbEcGYsSej7axxEUymSsk81Hu8DZYL4nGxVHpDEwrCGprMog41olMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475142; c=relaxed/simple;
	bh=9859yVUBPbHrWH+vXuj5WX+OCvnKCZtwaIjgCvsdcKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpoTBGXHlcP4E21h/xeypLDprFDEmb5Et6hIsyDwhCNKR7Zng0GMJjpp6WuXcyUMt3YR4Mo1pH5UDfvXBfUe4wKRPjkJcCNNXwdQx9cGttwhfyZGEhQCVljlXm8r0FUxlkUjnie0AJ2LL2P2G6bKr7pt54Yv1B0T+6haJ2b5kx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2B5fQkvx; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2B5fQkvx"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0nx11h1zlgyG8;
	Wed, 25 Mar 2026 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475135; x=1777067136; bh=8D9wQ
	C5v1sqM2tbz0NBQDIrHIKFR6Om5fW+o1fke7Nk=; b=2B5fQkvxsGawn9uxGoo2H
	y0Vuqm27kW2VqFco/fhms5CeIw4FPnz7crx9Z89YgRZ62V73Th0ce5xv/SKt0p3m
	ESpt/pPL95Gn7ErXxP9BfNb24v2g1I84L0xBOsdRRGvoyszj/6bl78Fjqej+akGm
	qmnTtjF4JQU8k5PtgFJrtWNvuB84SPcMN1fAwyAIgB0aiNwJDdM0NML1XTRnfpiH
	jrLfqF0ehbqgnGoAnMYwrla3mPf4xv728UcTOBFiqXnhj3cJ0EvA4Y1Pdvkk+L61
	DxE6cCSN0g5e2yiaj0kvqZOokIPa6WjZSPe/gTEe2DZhoIKj6ZoSgWjE3UQRH2mz
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Si0jMLBGFOtm; Wed, 25 Mar 2026 21:45:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0nn2cG2zlgyGQ;
	Wed, 25 Mar 2026 21:45:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 03/26] block/cgroup: Split blkg_conf_prep()
Date: Wed, 25 Mar 2026 14:44:44 -0700
Message-ID: <20260325214518.2854494-4-bvanassche@acm.org>
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

Move the blkg_conf_open_bdev() call out of blkg_conf_prep() to make it
possible to add lock context annotations to blkg_conf_prep(). Change an
if-statement in blkg_conf_open_bdev() into a WARN_ON_ONCE() call. Export
blkg_conf_open_bdev() because it is called by the BFQ I/O scheduler and
the BFQ I/O scheduler may be built as a kernel module.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c |  4 ++++
 block/blk-cgroup.c | 16 ++++++----------
 block/blk-iocost.c |  4 ++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index ac83b0668764..38396df9dce7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1051,6 +1051,10 @@ static ssize_t bfq_io_set_device_weight(struct ker=
nfs_open_file *of,
=20
 	blkg_conf_init(&ctx, buf);
=20
+	ret =3D blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto out;
+
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_bfq, &ctx);
 	if (ret)
 		goto out;
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2d7b18eb7291..8cfdbe9fffdc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -771,10 +771,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_init);
  * @ctx->input and get and store the matching bdev in @ctx->bdev. @ctx->=
body is
  * set to point past the device node prefix.
  *
- * This function may be called multiple times on @ctx and the extra call=
s become
- * NOOPs. blkg_conf_prep() implicitly calls this function. Use this func=
tion
- * explicitly if bdev access is needed without resolving the blkcg / pol=
icy part
- * of @ctx->input. Returns -errno on error.
+ * Returns: -errno on error.
  */
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 {
@@ -783,8 +780,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	struct block_device *bdev;
 	int key_len;
=20
-	if (ctx->bdev)
-		return 0;
+	WARN_ON_ONCE(ctx->bdev);
=20
 	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) !=3D 2)
 		return -EINVAL;
@@ -813,6 +809,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev =3D bdev;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
+
 /*
  * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
  * ensures the correct locking order between freeze queue and q->rq_qos_=
mutex.
@@ -857,7 +855,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen=
(struct blkg_conf_ctx *ctx)
  * following MAJ:MIN, @ctx->bdev points to the target block device and
  * @ctx->blkg to the blkg being configured.
  *
- * blkg_conf_open_bdev() may be called on @ctx beforehand. On success, t=
his
+ * blkg_conf_open_bdev() must be called on @ctx beforehand. On success, =
this
  * function returns with queue lock held and must be followed by
  * blkg_conf_exit().
  */
@@ -870,9 +868,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct =
blkcg_policy *pol,
 	struct blkcg_gq *blkg;
 	int ret;
=20
-	ret =3D blkg_conf_open_bdev(ctx);
-	if (ret)
-		return ret;
+	WARN_ON_ONCE(!ctx->bdev);
=20
 	disk =3D ctx->bdev->bd_disk;
 	q =3D disk->queue;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..7c90241a1dbd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3129,6 +3129,10 @@ static ssize_t ioc_weight_write(struct kernfs_open=
_file *of, char *buf,
=20
 	blkg_conf_init(&ctx, buf);
=20
+	ret =3D blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto err;
+
 	ret =3D blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
 	if (ret)
 		goto err;
