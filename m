Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7614D29B
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735124816; cv=none; b=k0XaBvSRhYTaVz8YAluKtf3ZrF215IdyILSM0wp71yYIdMpEG3G/sFIAuEmqeHEqos5aWN5tKQi6j//xKEMoAKuOZagJEu+Y5DBn7ZNjRs8QCmxhQpGiAUnku1slU0O5S2kBOo8nfDIAQUWT2mzNPCuaJI3KdsfWD3C2qlOdfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735124816; c=relaxed/simple;
	bh=zGUEwGJ/wau1bHgvyX1cr0nzZ8TVK/tOklVYjZs9W00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Madn8pKHvOOBI8b1dW0DoCBr2Mcwj9GI7ZFLL/FN2lkeFDIAYax+h9aAmyUtii3WNN7zEI201ZOYLhQMPbyrhB+dowPQK1XfL2/H1xjzdD1j3GYs2ybInRVh8i/r3p7lt79WMOXpvmRhF0dhkpzvpac7+Wf6HVfhl+Esp8XkDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVjS9r8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVjS9r8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735124812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZ2tMRPyaNon0seetKpGnI2A66leOyJHIg/krGqLDvs=;
	b=BVjS9r8Ot6eneW+g9nekWhz+KjqIpFwhpymBYqZE1uYaqq2vXfskAG5ScqyaPeazWGWQrQ
	A06iFsOe8jYbgUNO3rSsNproRSqBYKxWIrY0GB8RK1/pAVpdN2oknOsM+uIbdEqzV/ceRq
	JRYNn6hX5YOkKFyPdSkccn75Ib6wztI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-S6QT33N2M8K0xxe2zm4oYg-1; Wed,
 25 Dec 2024 06:06:51 -0500
X-MC-Unique: S6QT33N2M8K0xxe2zm4oYg-1
X-Mimecast-MFC-AGG-ID: S6QT33N2M8K0xxe2zm4oYg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 567E2195608C;
	Wed, 25 Dec 2024 11:06:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 147081956053;
	Wed, 25 Dec 2024 11:06:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: detach gendisk from ublk device if add_disk() fails
Date: Wed, 25 Dec 2024 19:06:40 +0800
Message-ID: <20241225110640.351531-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Inside ublk_abort_requests(), gendisk is grabbed for aborting all
inflight requests. And ublk_abort_requests() is called when exiting
the uring context or handling timeout.

If add_disk() fails, the gendisk may have been freed when calling
ublk_abort_requests(), so use-after-free can be caused when getting
disk's reference in ublk_abort_requests().

Fixes the bug by detaching gendisk from ublk device if add_disk() fails.

Fixes: bd23f6c2c2d0 ("ublk: quiesce request queue when aborting queue")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d4aed12dd436..934ab9332c80 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1618,6 +1618,21 @@ static void ublk_unquiesce_dev(struct ublk_device *ub)
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
 }
 
+static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	/* Sync with ublk_abort_queue() by holding the lock */
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	ub->dev_info.state = UBLK_S_DEV_DEAD;
+	ub->dev_info.ublksrv_pid = -1;
+	ub->ub_disk = NULL;
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
 static void ublk_stop_dev(struct ublk_device *ub)
 {
 	struct gendisk *disk;
@@ -1631,14 +1646,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 		ublk_unquiesce_dev(ub);
 	}
 	del_gendisk(ub->ub_disk);
-
-	/* Sync with ublk_abort_queue() by holding the lock */
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	ub->dev_info.state = UBLK_S_DEV_DEAD;
-	ub->dev_info.ublksrv_pid = -1;
-	ub->ub_disk = NULL;
-	spin_unlock(&ub->lock);
+	disk = ublk_detach_disk(ub);
 	put_disk(disk);
  unlock:
 	mutex_unlock(&ub->mutex);
@@ -2336,7 +2344,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 
 out_put_cdev:
 	if (ret) {
-		ub->dev_info.state = UBLK_S_DEV_DEAD;
+		ublk_detach_disk(ub);
 		ublk_put_device(ub);
 	}
 	if (ret)
-- 
2.47.1

