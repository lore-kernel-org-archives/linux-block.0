Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069D1FFC56
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336162; cv=none; b=eiOtMGcb7OPvmItiH/3nok5v2Xo/+dKK15iVup+tpPAm58rjLEmcE9CYq/8oY1VRBeSdYwuPLMV5jKBhmjh974ok5inzN2Kp+DILRnepLuV7ZWzi6szeDYqOWtg1gCiOawZLfp7N4tJofTelyqf+ebweTyM3pWSkOOUUsRNkmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336162; c=relaxed/simple;
	bh=Ns1dvaTpOUy4lMjd72u4kDq+U9HX24L9vEP2LEi5fEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtZDU1w3jk7iaImxM4U0kM46GW/2/bvt1ej13Fs1ZFZ6JKclo7/zkRgN9MELk1TLgbkQAuw/uVvui8WTLFVO1ckQYevrWrtizVf0bLaYD9QXhpkBkuE1EUZ/+HPUh5e/cPetMBhoj3D+dItFXIDJDdR1mmr9qNMM5Lce7OvGmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGmsPtgu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGmsPtgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734336159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntla/0oqB5bIDpBNzrGgEmevgULQgqiy9pQ9dL9GkfU=;
	b=KGmsPtguCkdmLQ3E/CZl7dOcgOLs+YFPNseYEmWyZJ1UZ2jNBv9GOvmhCjyTs+khT+PdOG
	WfA2PtOnKGXbSvcM2GDDKd+EC2wQfcjOowl+h35p1fZQXpGIfowNqPf527dNNRCTc53SrV
	zfltFuslyxeDu9FY0eqO+yA5lu07KBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-VodR2cUqNSu-EhF-Qua2Iw-1; Mon,
 16 Dec 2024 03:02:36 -0500
X-MC-Unique: VodR2cUqNSu-EhF-Qua2Iw-1
X-Mimecast-MFC-AGG-ID: VodR2cUqNSu-EhF-Qua2Iw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1F5E19560BA;
	Mon, 16 Dec 2024 08:02:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.154])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9F2C19560A3;
	Mon, 16 Dec 2024 08:02:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: remove queue_limits_cancel_update()
Date: Mon, 16 Dec 2024 16:02:04 +0800
Message-ID: <20241216080206.2850773-3-ming.lei@redhat.com>
In-Reply-To: <20241216080206.2850773-1-ming.lei@redhat.com>
References: <20241216080206.2850773-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now queue_limits_cancel_update() becomes nop, so remove it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/md.c          |  1 -
 drivers/md/raid0.c       |  4 +---
 drivers/md/raid1.c       |  4 +---
 drivers/md/raid10.c      |  4 +---
 drivers/scsi/scsi_scan.c |  1 -
 include/linux/blkdev.h   | 12 ------------
 6 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index aebe12b0ee27..4a3e109dfa11 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5788,7 +5788,6 @@ int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
 	if (!queue_limits_stack_integrity_bdev(&lim, rdev->bdev)) {
 		pr_err("%s: incompatible integrity profile for %pg\n",
 		       mdname(mddev), rdev->bdev);
-		queue_limits_cancel_update(mddev->gendisk->queue);
 		return -ENXIO;
 	}
 
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 7049ec7fb8eb..e8802309ed60 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -386,10 +386,8 @@ static int raid0_set_limits(struct mddev *mddev)
 	lim.io_opt = lim.io_min * mddev->raid_disks;
 	lim.features |= BLK_FEAT_ATOMIC_WRITES_STACKED;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 519c56f0ee3d..c6e53cc57440 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3241,10 +3241,8 @@ static int raid1_set_limits(struct mddev *mddev)
 	lim.max_write_zeroes_sectors = 0;
 	lim.features |= BLK_FEAT_ATOMIC_WRITES_STACKED;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7d7a8a2524dc..6acc96be77aa 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4042,10 +4042,8 @@ static int raid10_set_queue_limits(struct mddev *mddev)
 	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
 	lim.features |= BLK_FEAT_ATOMIC_WRITES_STACKED;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 042329b74c6e..3e3f64cec9ee 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1079,7 +1079,6 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	else if (hostt->slave_configure)
 		ret = hostt->slave_configure(sdev);
 	if (ret) {
-		queue_limits_cancel_update(sdev->request_queue);
 		/*
 		 * If the LLDD reports device not present, don't clutter the
 		 * console with failure messages.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6cc20ca79adc..b2542d3dcc23 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -957,18 +957,6 @@ int queue_limits_commit_update(struct request_queue *q,
 int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
 int blk_validate_limits(struct queue_limits *lim);
 
-/**
- * queue_limits_cancel_update - cancel an atomic update of queue limits
- * @q:		queue to update
- *
- * This functions cancels an atomic update of the queue limits started by
- * queue_limits_start_update() and should be used when an error occurs after
- * starting update.
- */
-static inline void queue_limits_cancel_update(struct request_queue *q)
-{
-}
-
 /*
  * These helpers are for drivers that have sloppy feature negotiation and might
  * have to disable DISCARD, WRITE_ZEROES or SECURE_DISCARD from the I/O
-- 
2.47.0

