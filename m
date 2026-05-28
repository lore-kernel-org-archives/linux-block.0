Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477A926C3BD
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997586; cv=none; b=SP12AAfOlYElMJXAS8N5f3TzfqyPFYAdvhUnh57kbhQ5EiRdgRqaAQLkPVngQvFfCqlLoq7M9jgZ9KWvK5Bir7ORkvAVATXbFTLhiIwIySUdFbfFf29G1g4M2EgmJmJ2xoSPr6qaL26lI3Jfe6f3zAgHfGRLYmQmPCzuLMtz5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997586; c=relaxed/simple;
	bh=0o1LMMH8YMsy85Ql0dNxopzzmC5h8Gtam/rys9I4VM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZm1uwfYqdtZN7TY9F562Cs801bMprknIcyRNOG9YWF4p61uqK+KCCDq0Tp8qzy5x8syeJkwciKQHhR0HEXgknT61VT9ZfxQQuCfvdsiGcwl40wwnuZ0YcRJQ20HR2erWkoKbl10LwPe+wPANmLpwmlYZwRY3DfSNCelTnYUISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=w4rRhDB7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="w4rRhDB7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6n0QyZz1XM0pZ;
	Thu, 28 May 2026 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997580; x=1782589581; bh=mtT64
	RurcT7xOWF8ZzCwY2gGt1sRp3ckYG01jWWVmBA=; b=w4rRhDB7NT20qNank2ZOR
	W4al/HcqAoz72pVFt/B1ES+p/ykxQQx8l4RziNGEpBpuats4Wq8wEkRudXBGLcQO
	DZx+OKOm+DQEhP0ZgRW1iBxGy1OkPHL7UiskJbMrJseZr+LxzC3JkqnA/A8imZt0
	LBnBaK7IQcGk3xJPH8Z+sfH1U7mTYsPYrbcF38neBgB3q+ld/8RyrA8hGuhvbETH
	paS48gTkWuIobhB9BtZXnPnYFamwcetLLM1V6wC7KaWmtZYpqSG261tLOJ0WSCNV
	fxDNlbcyM00d7lEWEf2T8U5fgMRctIuIIOg+xGYBxyy7vaa+74SspQg+HuEIj3vu
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cozQY3UYtoB4; Thu, 28 May 2026 19:46:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6f4jr5z1XM0pY;
	Thu, 28 May 2026 19:46:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 05/12] block/cgroup: Improve lock context annotations
Date: Thu, 28 May 2026 12:45:42 -0700
Message-ID: <a30486e2e9695614e4407d5ad8c75d637f5b31db.1779997063.git.bvanassche@acm.org>
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
