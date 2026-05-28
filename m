Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0226C3BD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997583; cv=none; b=nO3ydqR+KpKgKuZgEEfX+ch4Cv+377h0occpWrafgwu878buIxCrTv6TpZcUMERHW1/b1bNqFZ7WnGgkJHRA08vBsCQyQ2YBjXt9Zty+Wpus+QCEeK9JaQhuQfRuO96cCrvBktfiJ5PHqx/fRRpWUUB92TceEHtPCy9ksnezW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997583; c=relaxed/simple;
	bh=XaJi5LE0jKsvSKyAgJO4oZYzyfUOGlFglcauLZx7Wd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXUlnR2+77fZIk9mIx0YGz1iZEsjzeyAx6JRAPqRhwmVuCIs0NcGzn9Y1lrZVy1RSrdUEg68I8kU8HdFnsqmIwDN4Ev9qq1/awfwjqxl8MMkTG0/VVgdofogZzOZE8Rpk3Xkn+0iAfcmIhZEXWBMTggd27phPj3ayR8UFPDPtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lhG2qUFb; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lhG2qUFb"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6j5z0Xz1XM0kC;
	Thu, 28 May 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997575; x=1782589576; bh=jvpCo
	j9sifG4EMQk16WARHRYK/ZaSZ0RFY7h39W9bGM=; b=lhG2qUFb/w/iqYr5N/v7c
	4/eITkiUxt5b3gQBjKmyPtuYSzTm2de58XVvfnx/t9SiZ/2Uq/y/s/X9p4rKNkmz
	X0LaAbpu1dBWm+N63/ml9cf+rtb80GZy3Y6DG/52lsgRWIKo+skaUcGITeu/ZN9d
	AGGQK0z59FD5V5+f84YHOJXICRjT7CUDDT8hNeC8sv30QraHRuVNqhVO4OCI1uDU
	QImb7/oV6VzarRZgwVVV3CYyPUTHGilKpKpqx5fDSwqcC2S1F2xeOfEKKfYzS5c5
	OTLX20uZhg/BdkqU9HB0t5uyy6u0Stf/F/x+mgucCjj1wq5AM46arv6jSHe2/p7T
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ynyb_muzieTV; Thu, 28 May 2026 19:46:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6Y1BrQz1XM0pZ;
	Thu, 28 May 2026 19:46:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fnnas.com>
Subject: [PATCH v5 03/12] block/cgroup: Split blkg_conf_prep()
Date: Thu, 28 May 2026 12:45:40 -0700
Message-ID: <4e4b11711301f1522fec5fb59de12cbd48f5038f.1779997063.git.bvanassche@acm.org>
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

Move the blkg_conf_open_bdev() call out of blkg_conf_prep() to make it
possible to add lock context annotations to blkg_conf_prep(). Change an
if-statement in blkg_conf_open_bdev() into a WARN_ON_ONCE() call. Export
blkg_conf_open_bdev() because it is called by the BFQ I/O scheduler and
the BFQ I/O scheduler may be built as a kernel module.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c |  4 ++++
 block/blk-cgroup.c | 18 ++++++++----------
 block/blk-iocost.c |  4 ++++
 3 files changed, 16 insertions(+), 10 deletions(-)

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
index 554c87bb4a86..a8d95d51b866 100644
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
@@ -783,8 +780,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	struct block_device *bdev;
 	int key_len;
=20
-	if (ctx->bdev)
-		return 0;
+	if (WARN_ON_ONCE(ctx->bdev))
+		return -EINVAL;
=20
 	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) !=3D 2)
 		return -EINVAL;
@@ -813,6 +810,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev =3D bdev;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
+
 /*
  * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
  * ensures the correct locking order between freeze queue and q->rq_qos_=
mutex.
@@ -857,7 +856,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen=
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
@@ -870,9 +869,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct =
blkcg_policy *pol,
 	struct blkcg_gq *blkg;
 	int ret;
=20
-	ret =3D blkg_conf_open_bdev(ctx);
-	if (ret)
-		return ret;
+	if (WARN_ON_ONCE(!ctx->bdev))
+		return -EINVAL;
=20
 	disk =3D ctx->bdev->bd_disk;
 	q =3D disk->queue;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0cca88a366dc..b34f820dedcc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3140,6 +3140,10 @@ static ssize_t ioc_weight_write(struct kernfs_open=
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
