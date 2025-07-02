Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375A2DE71B
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488758; cv=none; b=Y6Xj+5ApefLg+VojZCcDfP64XQv6StipyaPanZ5/s4F0fhmXQVi0yiNw9Irp67Pn9HGrcQ/Dd1AxrTU49Dx7AgjOTDhjSAVnsh7WBwZntgE8GNguivZLqYxoD0ZTa6sAB7FUZyNO0tk3WdRZkWeNhgHm2nts5uPnxheKkVCZl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488758; c=relaxed/simple;
	bh=ENocKzrcdxZG+zoe40nhTrEYbFLWrpOqNKivnj34DNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsGubeVYPG7QHTDtJW2Y46oYnXuvu1kkKx7/a5MlIDQtaESHQlYrPFNwg4dKm52zVF1wtOLFbEoKmfmNk/XmHyNaeMP9u3nXXZa/1sNLtvQpiVc6y9Z7+3I3Frr3TmmP7Yln1UzZ1nUuC0YrZq1nksab2/g+cFH0y2/TQocaq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3r5gD3wF; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3r5gD3wF"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWw34CY4zm0dhj;
	Wed,  2 Jul 2025 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488753; x=1754080754; bh=xUueT
	mTRmwC8UQ0T1JXhbaqLQHF35UCZEZy+95I7API=; b=3r5gD3wFgNdtzz9/ndE+i
	j6vBP4pApwkTOrSUY21aqB4nJirHMupmPr1VAL44rxmuhyHC17YMduoP8QWhzYqp
	gZGfBvipcuRKLPnCWSuUvZRIyerIfz6EiYu0hMQRjqyaVJ67fybRR4eNMj1XX++2
	XDqE5kjk/4Kc9MiC2tHCDumnpU0+ugda074w0xA2jB30uQuJfz188XOMKhxJW7XF
	5pCSjNAZvdQGfJcyUb6CbQAKZF3jHd2LHCqTIqcbN4dr0bFyoyoLxfWwmRkFOWKU
	HeevRPHdaDG/NrbmvfIbPUgxwsrBQEMqDIJhOyrG/DxsJnCk9CHubmDbPx9lL6LO
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xSRNJoT7HI_D; Wed,  2 Jul 2025 20:39:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWvx1Ydzzm0Hqj;
	Wed,  2 Jul 2025 20:39:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/8] block: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:38 -0700
Message-ID: <20250702203845.3844510-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen=
,
protecting request queue changes with blk_mq_quiesce_queue() and
blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
Hence this patch that removes quiesce/unquiesce calls on frozen queues.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c   |  8 --------
 block/blk-mq.c       |  4 ----
 block/blk-sysfs.c    | 13 +++++--------
 block/blk-throttle.c |  2 --
 block/elevator.c     |  8 ++------
 5 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..e567d8480569 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3248,8 +3248,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_fil=
e *of, char *input,
 		ioc =3D q_to_ioc(disk->queue);
 	}
=20
-	blk_mq_quiesce_queue(disk->queue);
-
 	spin_lock_irq(&ioc->lock);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable =3D ioc->enabled;
@@ -3346,13 +3344,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
 	else
 		wbt_enable_default(disk);
=20
-	blk_mq_unquiesce_queue(disk->queue);
-
 	blkg_conf_exit_frozen(&ctx, memflags);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
-	blk_mq_unquiesce_queue(disk->queue);
 	ret =3D -EINVAL;
 err:
 	blkg_conf_exit_frozen(&ctx, memflags);
@@ -3439,7 +3434,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
 	}
=20
 	memflags =3D blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
=20
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
@@ -3489,7 +3483,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
=20
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
=20
 	blkg_conf_exit(&ctx);
@@ -3498,7 +3491,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_o=
pen_file *of, char *input,
 einval:
 	spin_unlock_irq(&ioc->lock);
=20
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
=20
 	ret =3D -EINVAL;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 91b9fc1a7ddb..b84ff8e4e17e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4932,8 +4932,6 @@ int blk_mq_update_nr_requests(struct request_queue =
*q, unsigned int nr)
 	if (q->nr_requests =3D=3D nr)
 		return 0;
=20
-	blk_mq_quiesce_queue(q);
-
 	ret =3D 0;
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->tags)
@@ -4964,8 +4962,6 @@ int blk_mq_update_nr_requests(struct request_queue =
*q, unsigned int nr)
 		}
 	}
=20
-	blk_mq_unquiesce_queue(q);
-
 	return ret;
 }
=20
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1f63b184c6e9..dd11d7f1c600 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -593,6 +593,11 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
sk, const char *page,
 	if (val < -1)
 		return -EINVAL;
=20
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
 	memflags =3D blk_mq_freeze_queue(q);
=20
 	rqos =3D wbt_rq_qos(q);
@@ -611,18 +616,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *d=
isk, const char *page,
 	if (wbt_get_min_lat(q) =3D=3D val)
 		goto out;
=20
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
-	blk_mq_quiesce_queue(q);
-
 	mutex_lock(&disk->rqos_state_mutex);
 	wbt_set_min_lat(q, val);
 	mutex_unlock(&disk->rqos_state_mutex);
=20
-	blk_mq_unquiesce_queue(q);
 out:
 	blk_mq_unfreeze_queue(q, memflags);
=20
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 397b6a410f9e..9abcdbfe91e1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1332,7 +1332,6 @@ static int blk_throtl_init(struct gendisk *disk)
 	 * which is protected by 'q_usage_counter'.
 	 */
 	memflags =3D blk_mq_freeze_queue(disk->queue);
-	blk_mq_quiesce_queue(disk->queue);
=20
 	q->td =3D td;
 	td->queue =3D q;
@@ -1354,7 +1353,6 @@ static int blk_throtl_init(struct gendisk *disk)
 		blk_stat_enable_accounting(q);
=20
 out:
-	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue, memflags);
=20
 	return ret;
diff --git a/block/elevator.c b/block/elevator.c
index ab22542e6cf0..574b35f8c01c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -584,8 +584,6 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
 			return -EINVAL;
 	}
=20
-	blk_mq_quiesce_queue(q);
-
 	if (q->elevator) {
 		ctx->old =3D q->elevator;
 		elevator_exit(q);
@@ -594,7 +592,7 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
 	if (new_e) {
 		ret =3D blk_mq_init_sched(q, new_e);
 		if (ret)
-			goto out_unfreeze;
+			goto out;
 		ctx->new =3D q->elevator;
 	} else {
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
@@ -603,9 +601,7 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
 	}
 	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
=20
-out_unfreeze:
-	blk_mq_unquiesce_queue(q);
-
+out:
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
 			new_e->elevator_name);
