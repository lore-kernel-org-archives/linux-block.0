Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2A202963
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682508; cv=none; b=XtrnFUWsVC4sEPMX8WFRYDAP48igg+YKl599FpBr6J3mpJRsU9nMCO4uWTzZ9msrvogMkeg8yKQxmPOFc9ANgAOU8pWBT6RHzGMxyHoEe5pokslIXGguLlXzuC29yGMr3rZvysoto1A8A+6FYMme/0Rhi/9TfRR8ivNGcG5PEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682508; c=relaxed/simple;
	bh=T8WZ4oywN74S0qZHqtg3MMTv8herE5giR0sIhlWwfbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/IGv1K72janEpKdA4PGv9elLQfgPtLK4TLXMmQFeY9tMq+1/2eXk8IShYPjijahUfSCrB5n8W+PIgAxYVkPZtJISuNqWUioywpyOjL/uN9y5uVL+wO2ienKgBvUnwHnE6+/aqCYxbwWcMNcfctPE6KKVw/+z85QPy/cnjjTjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UKVgv0k1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UKVgv0k1"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8QM33r4z1XM0pS;
	Fri,  5 Jun 2026 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682501; x=1783274502; bh=ZyLqI
	G25rp6VG1Ls2IcvmcMkRCh1Uqagt+X7VHrZ0g8=; b=UKVgv0k1ECWhNeVnx/9NH
	U58dekLuraJJeiJbaFnJU7qAGBCkx0BfiAplNVxd1f4gMR+P5z2NbX9mWcbPegdo
	z8vs7VvPxH2ornHwpxjVfUGxLSo3lm4YJgN534an1bUP+CwE27LVRITIUVXc2vpp
	kol5XWaQKImfEztgC/f1tql4LZIIkH5RXy/IilPy9F6x/G4pF4ZAvhl9xKSmlixV
	Ofr6PV5qZgF+1hx9fLbs25hu1jsaWSU/ZUXdH7txC9aKdkRieleJWPSeNcKTWJ/9
	/Iqb4KjXYPOUvRt2UCbpo4GUwbvA4l6XegSmxLjFt1D9So/Qh+9tUuZtC5EDxBSY
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CdPO-S10hp81; Fri,  5 Jun 2026 18:01:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QC5MHgz1XM0ny;
	Fri,  5 Jun 2026 18:01:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 05/14] block/cgroup: Improve lock context annotations
Date: Fri,  5 Jun 2026 11:00:58 -0700
Message-ID: <58ddd6e2b960bdfa03d0007984386bc0ba351391.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
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

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
