Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9622A1D1
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775711; cv=none; b=CnsiYeEc9dYEG1yn/ZGl+kmBS6P04yvunbdq7zh1ZqLfdRq8wbkHd6ge5VZRZwqpFbW0Isy+8JvlH/2DzEicmOHGWmSn/5YYb2SUgJZqan9flEQ1fj9AqmvsldQofST+FB/5QUpGthaVs+KEXTZofTe70Y4oFuZH8oN8z0UE1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775711; c=relaxed/simple;
	bh=YLuyRdk7rhqbtEHE52KPr+flsZ1dcKhd/muLsId0+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjTdL+GDYUg9WxzvQQeqGMeVLhrTfFbWerQSlXSMSbAl07vj1xLz7z8p8+PD7o3+dPq/gleX2xffGVyxbS0pIBsK3uOBLDxUkXKwD82UXx4CQdJWGNTww7fuUMpsM4MBfitEZ6VHl8tQoTO0rOMqz5ufM9EnflLjkdMNZ9mslwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJTHkBGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJTHkBGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744775708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB4N4M8BEq2xEDt0HCEXUWyOQOPPqMei8tDZibq9w5Y=;
	b=AJTHkBGEdWaGfXd/l8S0Cyx8Tzgrc2HQ65IVoY9UlpWgaHhYMJ1N8yU2nw0godxiQgOLbw
	qoVROnex4LiHbUlFLOKd03BdgAEKOj1xTdOY+vjU+albnDvkyxS0mDBFXDjQfNVDxJjcML
	bDDn6G5/F8My5m2knq6CHvw/i+X3dqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-HH1kOaTcNW-uLm5ZMs_LGg-1; Tue,
 15 Apr 2025 23:55:04 -0400
X-MC-Unique: HH1kOaTcNW-uLm5ZMs_LGg-1
X-Mimecast-MFC-AGG-ID: HH1kOaTcNW-uLm5ZMs_LGg_1744775703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3D251801A1A;
	Wed, 16 Apr 2025 03:55:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 918881956054;
	Wed, 16 Apr 2025 03:55:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/8] ublk: add ublk_force_abort_dev()
Date: Wed, 16 Apr 2025 11:54:36 +0800
Message-ID: <20250416035444.99569-3-ming.lei@redhat.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add ublk_force_abort_dev() for handling ublk_nosrv_dev_should_queue_io()
in ublk_stop_dev(). Then queue quiesce and unquiesce can be paired in
single function.

Meantime not change device state to QUIESCED any more, since the disk is
going to be removed soon.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bf47f9cb8329..e1b4db2f8a56 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1743,22 +1743,20 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 }
 
-static void ublk_unquiesce_dev(struct ublk_device *ub)
+static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
 
-	pr_devel("%s: unquiesce ub: dev_id %d state %s\n",
+	pr_devel("%s: force abort ub: dev_id %d state %s\n",
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	/* quiesce_work has run. We let requeued rqs be aborted
-	 * before running fallback_wq. "force_abort" must be seen
-	 * after request queue is unqiuesced. Then del_gendisk()
-	 * can move on.
-	 */
+	blk_mq_quiesce_queue(ub->ub_disk->queue);
+	if (ub->dev_info.state == UBLK_S_DEV_LIVE)
+		ublk_wait_tagset_rqs_idle(ub);
+
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->force_abort = true;
-
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	/* We may have requeued some rqs in ublk_quiesce_queue() */
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
@@ -1786,11 +1784,8 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
-			__ublk_quiesce_dev(ub);
-		ublk_unquiesce_dev(ub);
-	}
+	if (ublk_nosrv_dev_should_queue_io(ub))
+		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
-- 
2.47.0

