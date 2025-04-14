Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E95283697
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629978; cv=none; b=eYY3rLivCwMC9i0adWXcxV+neI0h67Tm0FJdzGZaa11H5NyiTikTeLDbgU9dulx6Io55rKyAIWktG00OF3GLHzfTGVFJpxKYgar93+vVVu+9vmLqKVNqIZEHoyFPAkbc2AvFMIcXa38MmroNmji76s068DFHA165AvIOYDvY3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629978; c=relaxed/simple;
	bh=+W+Vx83XgNrJ9Odmyy9bnqivPvCIf1EtJYcPNBC+8CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh8X4wp3g3je7wUazzeGYu5U9Rqt5ajA5J2KCXewAnjEeBMKC9pty2WONT03dZXbDOrI0vZGhAlsQKnVniesT7dBYzB99ZSaidxVVd2ZD6j2dybP+FmM0Sp9s8HPjz/3tNQ3Vo7wjeqgbugKBMueO3XbeEdyMtReV3Ip3Dy4MZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BC3+38DN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC3+38DN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744629975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0of0BD/RaLgqQvuRqzkH1BYZU5BrXmAwwwZBUGlxJs=;
	b=BC3+38DNjy4Qs2yLlCcNSr9cr/QSsi9LqD7s3wmmodJdbCShQuXWy+qzAQxbMrn92W4x0x
	1Fb6js8yk1Uy45fMykHIzVh7IkQEy2ZuzpiXvUAI14nXgzRO3abuPa+XtTfRfT3nK8k19o
	UwWfWDHRi6cLFz1D8dObtn3dBFDuueY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-rQfdnlqlO4SajN2CDqJN3Q-1; Mon,
 14 Apr 2025 07:26:11 -0400
X-MC-Unique: rQfdnlqlO4SajN2CDqJN3Q-1
X-Mimecast-MFC-AGG-ID: rQfdnlqlO4SajN2CDqJN3Q_1744629970
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 605621800258;
	Mon, 14 Apr 2025 11:26:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57F1C1801A6D;
	Mon, 14 Apr 2025 11:26:08 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/9] ublk: add ublk_force_abort_dev()
Date: Mon, 14 Apr 2025 19:25:44 +0800
Message-ID: <20250414112554.3025113-4-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add ublk_force_abort_dev() for handling ublk_nosrv_dev_should_queue_io()
in ublk_stop_dev(). Then queue quiesce and unquiesce can be paired in
single function.

Meantime not change device state to QUIESCED any more, since the disk is
going to be removed soon.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 79f42ed7339f..7e2c4084c243 100644
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
 	if (!ub->ub_disk)
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

