Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A3DA5B5
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155221; cv=none; b=hZ0ZvbHl0wROvNuxiVPq02/9pOYzimkvsr0ukuHjHLBTyYHA2jrxEkEW8EvrcqjDJcwfMcPjTxgRrnQqWtt2nVlRdX9su2TgyzvXpQZD7RvSbEcesXZG+X6YW/t4zEWL91+xm6ryYETeWdFKEQNrgDIehhAWIced5FVfBubfFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155221; c=relaxed/simple;
	bh=XaJi5LE0jKsvSKyAgJO4oZYzyfUOGlFglcauLZx7Wd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6ZO8dHEQP/uFMLL7RwL4i64aQ6QeYPPTTmjoljE4/BI/08iA5R8gwFc+kcnMUHbM/irXIgxAEskTbRh22VPNj6Mm3z0k+B/9z2WqvKGu0TA0yz9P4lWKnHQ12e2OKJOlXEG0Vc59urgihsxoIb7NW0SRofrFg3aOg+KQPCD2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZEkaLn3r; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZEkaLn3r"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJM2tMGzlh2gC;
	Thu,  2 Apr 2026 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155212; x=1777747213; bh=jvpCo
	j9sifG4EMQk16WARHRYK/ZaSZ0RFY7h39W9bGM=; b=ZEkaLn3rFKjf41aQec1su
	8CMtrdQ7aNCW0X63h0TIma4sIDDIYsi+Oe5IzdKsH5nUnBQ3XVcbAlyE+wKvsvhy
	RyCTIhF9sDA58pqqG9ENHxzFLqQ3Lb3FQMtiZhpfAVpV0qeTEwGzY1nhZxSu5iae
	KkvwS0J51FdJwQYBv60DyWGfKkkzhur6TXHdFZD0cYH9xcas9qDLHFJKgtlmZliT
	8UarpjRmIlG9DoSUNJ0nigCnBFxTdAT37OC6uVoaaN/g6Q4/k88APV8Vxs/qW5vo
	pgi39RL4KAWLvrVsB/Giwl6faGFDJH/BzEP5nL21TDqk2FBRxYZgMa8WDKIZikOA
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IQlCwWjF8Ore; Thu,  2 Apr 2026 18:40:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJ95wbZzlfvqC;
	Thu,  2 Apr 2026 18:40:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fnnas.com>
Subject: [PATCH v3 03/12] block/cgroup: Split blkg_conf_prep()
Date: Thu,  2 Apr 2026 11:39:35 -0700
Message-ID: <20260402183950.3626956-4-bvanassche@acm.org>
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
