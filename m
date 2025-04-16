Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772CA22D78A
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775715; cv=none; b=dFb9Wdu+anbi2QY3VUPmyCcNM9vXYH8bLDBv5mC4VyWvdNFRoAdbHtEQ5eB1Fy2G0f8CTKnSDt08fc0fhIrJqymX/mkcIuvHJCoL4H/iLvUBiEL13afx8oZQzxZZ9/SBqqPrzO728YDGwaZN1Geb8eMTEM0voK90Yls6Vr/HJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775715; c=relaxed/simple;
	bh=pD3xYVwVoH3g82DJVnywNcsLWFnZV/rOnXwMePzJPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLe0E9d1CLBMY9l8z+a0GeMCkdM0FZwcCc857Prtfo2froxO5iOO03eAMvl7RDHuNjb39xSS2s/n5Uqorf0y/z52pdrCXKlhmFgD2MRCKLGsn2UA8CPTrXplsh6e2wjqner/ZLk1kclQ2LpA5Tq2uCYTBBR+9skA+xMhUgORS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNhHchhD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNhHchhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wAxGnDVnz8sYXIdTjUq3eLMBIJkvxHNdyOLK5pQDOTQ=;
	b=RNhHchhD9Z2KqLhi6dVaD8jH//+l3iP//dug9aYFOF9tGl0ZzwLzoPa18o4cqGbqXAuy/8
	FekeMvakuTuxftSGshRTfCeWC67lKg+P5WuCjFDVKOgzJw4yYFYQgT4mJx4DZBQIAM+Cc4
	ACC9kc+NUOZFUPVvuCp+BRVkJC3sp8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-ADFm8pddMeOr4N_ZrGZAuA-1; Tue,
 15 Apr 2025 23:55:08 -0400
X-MC-Unique: ADFm8pddMeOr4N_ZrGZAuA-1
X-Mimecast-MFC-AGG-ID: ADFm8pddMeOr4N_ZrGZAuA_1744775707
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E415E1956055;
	Wed, 16 Apr 2025 03:55:06 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2BB230001A1;
	Wed, 16 Apr 2025 03:55:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/8] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
Date: Wed, 16 Apr 2025 11:54:37 +0800
Message-ID: <20250416035444.99569-4-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
queue as quiesced. This way is fragile because queue quiesce crosses syscalls
or process contexts.

Switch to rely on ubq->canceling for dealing with
ublk_nosrv_dev_should_queue_io(), because it has been used for this purpose
during io_uring context exiting, and it can be reused before recovering too.
In ublk_queue_rq(), the request will be added to requeue list without
kicking off requeue in case of ubq->canceling, and finally requests added in
requeue list will be dispatched from either ublk_stop_dev() or
ublk_ctrl_end_recovery().

Meantime we have to move reset of ubq->canceling from ublk_ctrl_start_recovery()
to ublk_ctrl_end_recovery(), when IO handling can be recovered completely.

Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
in same context.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e1b4db2f8a56..a479969fd77e 100644
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
@@ -2961,7 +2967,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
 	ubq->timeout = false;
-	ubq->canceling = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -3048,20 +3053,18 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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

