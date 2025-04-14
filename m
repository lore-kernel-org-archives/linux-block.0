Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37127F4D1
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629981; cv=none; b=LJaBixhsEB5jpS34iAPTjbtJr16VH164TvpwfaEx44B9IF0E4EdO7FLlnnK+0q+T6xLpOuV6leDdsFKKSjfHaGL9B56vTORzEl+3romf9uXxndKhpyfCYjrMAt4MEqM27Vi3ERDD+g/xNAUlZjK+yb1Iik5o5eKQxXFaH1i1njQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629981; c=relaxed/simple;
	bh=0UkcEHkWyq057x3civIDljgoc+FUR0lyHjmSXuLNyG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx0XNGU0cwrjz6BGKwt0n+1S1j13wLbGm44vu5pPOKOjsojsrYAxPFmv5/gi3NPbkxekbLBqJS49KsHhLtNUMXPuBGmfGPHOxFOFXBzNP99wZM8zLM8qWqjOqusjPyY9lD2hwOibZueGLZUrqRqWYgk+3yY6A9i2Q/FEzDhNZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTD/Hs61; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTD/Hs61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08bvKO7SB/rwXaGYtE1PS3FgSwM3KovsTU692JqZbIY=;
	b=jTD/Hs61w3Bp4KwW1dW2TB10Ldlpjx9wNyEV/VEtN0ztRQJFLVy/FJWrV33wkZlMFsTB7w
	PRYrtfjqF1ElZA3C7egEW1KN/9F6zh2RBm9Jum/kiems/BmdKihCj2hVB/ClvnLvShSruc
	Jz6cVH+m+DMZHZu923s8tvlortJYeRU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-ttF5k6HXMGa2NH8XUZBnEA-1; Mon,
 14 Apr 2025 07:26:15 -0400
X-MC-Unique: ttF5k6HXMGa2NH8XUZBnEA-1
X-Mimecast-MFC-AGG-ID: ttF5k6HXMGa2NH8XUZBnEA_1744629974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44704195608A;
	Mon, 14 Apr 2025 11:26:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27202180B487;
	Mon, 14 Apr 2025 11:26:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/9] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
Date: Mon, 14 Apr 2025 19:25:45 +0800
Message-ID: <20250414112554.3025113-5-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
queue as quiesced. This way is fragile because queue quiesce crosses syscalls
or process contexts.

Switch to rely on ubq->canceling for dealing with ublk_nosrv_dev_should_queue_io(),
because it has been used for this purpose during io_uring context exiting, and it
can be reused before recovering too.

Meantime we have to move reset of ubq->canceling from ublk_ctrl_end_recovery() to
ublk_ctrl_end_recovery(), when IO handling can be recovered completely.

Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
in same context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7e2c4084c243..e0213222e3cf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1734,13 +1734,19 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 
 static void __ublk_quiesce_dev(struct ublk_device *ub)
 {
+	int i;
+
 	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
 	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	/* mark every queue as canceling */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -2950,7 +2956,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
 	ubq->timeout = false;
-	ubq->canceling = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -3037,20 +3042,18 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
 
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		ub->dev_info.state = UBLK_S_DEV_LIVE;
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-		pr_devel("%s: queue unquiesced, dev id %d.\n",
-				__func__, header->dev_id);
-		blk_mq_kick_requeue_list(ub->ub_disk->queue);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_LIVE;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = false;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = false;
+		ubq->fail_io = false;
 	}
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced, dev id %d.\n",
+			__func__, header->dev_id);
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 
 	ret = 0;
  out_unlock:
-- 
2.47.0

