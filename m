Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BCF426EA3
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517089; cv=none; b=g6AvhgFu4tcaGvHxp4f0hvup0tcmRHsxeiQNvvvrGaHfjegj53v/h2nmtCxH7qy9j2CJD0Aabk7FQSu0UGZ3Z3ZbCOHr5Ad59b+rGCh4YsZx1ZKFJclhfYG048723r8/8LHPyLYREv5aATf+DepwCiQ/Di3uB9YruDbVQ5HVeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517089; c=relaxed/simple;
	bh=0o1LMMH8YMsy85Ql0dNxopzzmC5h8Gtam/rys9I4VM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMwr8CbIINNlNTB4duo0xupVBf1zQLD0kyCwblT3t0ckHe9I7weJEBXrpHkPhnKdydsvLHCHDDbcdAbkfQcPPP3zk4H4Em3sTVn1x23dBsZMQ/gCEgzWqIZ6n5lNZLsyPAeepGSZbsnMj++abnh+mNXa24WyPRkhYVPfL3rUEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wWpgHXbs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wWpgHXbs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbg5d64zlfddR;
	Mon, 11 May 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517083; x=1781109084; bh=mtT64
	RurcT7xOWF8ZzCwY2gGt1sRp3ckYG01jWWVmBA=; b=wWpgHXbsCs1s7ROcvYTrg
	iyLjL8hGqwhQ7oY+U4c64I1k/IYJowVz2uTc1xP3rkIBJyaWOXNc5pUQzKKC5RT8
	z6xh57tLFPBOfQzSFSGipA3UF4aBWnQs0NlFeLD/UHJuknfspMY08meUG1fqxxqx
	Okwk3BAkuKul83d7EdHdY5r9+xezg2QTGzeNW9Dxk1UZngRdG4/hvA9rNJnmHScz
	Lw35kliiOUBIiT56Pv/gIS+x15Q+WPmIUhBt4kfQ8BvKvwIDJjAdEGJTu/VLdGNu
	XlEWPMMo7cRFCTIvPELNjIxefmp0vJcFyYMk5IPfIRe616MXyQToUBqSgdUv+pAZ
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UhNkYudphwcX; Mon, 11 May 2026 16:31:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbY1JftzlfgfB;
	Mon, 11 May 2026 16:31:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 05/12] block/cgroup: Improve lock context annotations
Date: Mon, 11 May 2026 09:30:47 -0700
Message-ID: <20260511163100.1887263-6-bvanassche@acm.org>
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

Add lock context annotations where these are missing. Move the
blkg_conf_prep() annotation into block/blk-cgroup.h to make it visible
to all blkg_conf_prep() callers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c |  1 -
 block/blk-cgroup.h | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 38d7bcfcbbe8..86513c54c217 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -862,7 +862,6 @@ unsigned long __must_check blkg_conf_open_bdev_frozen=
(struct blkg_conf_ctx *ctx)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
-	__acquires(&bdev->bd_queue->queue_lock)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index ce90f5b60d52..f0a3af520c55 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -218,14 +218,19 @@ struct blkg_conf_ctx {
 };
=20
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
-int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
+int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
+	__cond_acquires(0, &ctx->bdev->bd_queue->rq_qos_mutex);
 unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
-		   struct blkg_conf_ctx *ctx);
-void blkg_conf_unprep(struct blkg_conf_ctx *ctx);
-void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx);
+		   struct blkg_conf_ctx *ctx)
+	__cond_acquires(0, &ctx->bdev->bd_disk->queue->queue_lock);
+void blkg_conf_unprep(struct blkg_conf_ctx *ctx)
+	__releases(ctx->bdev->bd_disk->queue->queue_lock);
+void blkg_conf_close_bdev(struct blkg_conf_ctx *ctx)
+	__releases(&ctx->bdev->bd_queue->rq_qos_mutex);
 void blkg_conf_close_bdev_frozen(struct blkg_conf_ctx *ctx,
-				 unsigned long memflags);
+				 unsigned long memflags)
+	__releases(&ctx->bdev->bd_queue->rq_qos_mutex);
=20
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root b=
lkg
