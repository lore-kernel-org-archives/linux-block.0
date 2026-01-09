Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F333B6C6
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960907; cv=none; b=F+5VebT1rxjD4ovRYucduyP8T2U6RiYPiWM5e8ODqv5lUUX6fbhAFdnyZ0ANn4tBPJk1e9qzN9qp0416EfNFshFKG46P50Acv3ZRvKQsD51ktKcga4CGXM58QfziAKxUv8gw2LK4rqmwcjB7KizMq27cIkq/jFuFcpoYt7Kfds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960907; c=relaxed/simple;
	bh=tOc2o7PUk5GR2CNezVaJl4bPt6ezg5feijXSK30D/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNbP4sm6Ag5e9+rAzgGIEH7sjYjksdHtNRRHwSe1nBKZE//CxBAAiJbvxASz93PcoNbUR5F0NzONEbFLT2PtZtLjMnblQwY1ETMQrTWuZWBMQj+inWsz6HEmXD+HbwQom8AgzEOkdXrqRwDMKiXhdgjqikmkcqWYHfnc8GJs/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3AQFLuR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3AQFLuR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767960905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FNcv9OWFq212ck4UihQV9snMzPwMwWBrwOy7VswARx0=;
	b=T3AQFLuR63Eo8Xe2lELgsArWzCR8gq6/qHPscmOlcVDMahx/Ht07VeM2chLebIaeKl2w3q
	LJNIe5Cr0HSB4Fra4T3125yuGftuYocEA6EA+IgbsRM3grOvuIe3lTJB6RY7OGRNRixiHr
	+oK5BabCdg0/xXMNxIfarAYhaA4RmwA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-Wh2C3K-xNQCUWdZ97oZugA-1; Fri,
 09 Jan 2026 07:15:02 -0500
X-MC-Unique: Wh2C3K-xNQCUWdZ97oZugA-1
X-Mimecast-MFC-AGG-ID: Wh2C3K-xNQCUWdZ97oZugA_1767960901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FC551956048;
	Fri,  9 Jan 2026 12:15:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.172])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F269518004D8;
	Fri,  9 Jan 2026 12:14:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Ruikai Peng <ruikai@pwno.io>
Subject: [PATCH] ublk: fix use-after-free in ublk_partition_scan_work
Date: Fri,  9 Jan 2026 20:14:54 +0800
Message-ID: <20260109121454.278336-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A race condition exists between the async partition scan work and device
teardown that can lead to a use-after-free of ub->ub_disk:

1. ublk_ctrl_start_dev() schedules partition_scan_work after add_disk()
2. ublk_stop_dev() calls ublk_stop_dev_unlocked() which does:
   - del_gendisk(ub->ub_disk)
   - ublk_detach_disk() sets ub->ub_disk = NULL
   - put_disk() which may free the disk
3. The worker ublk_partition_scan_work() then dereferences ub->ub_disk
   leading to UAF

Fix this by using ublk_get_disk()/ublk_put_disk() in the worker to hold
a reference to the disk during the partition scan. The spinlock in
ublk_get_disk() synchronizes with ublk_detach_disk() ensuring the worker
either gets a valid reference or sees NULL and exits early.

Also change flush_work() to cancel_work_sync() to avoid running the
partition scan work unnecessarily when the disk is already detached.

Fixes: 7fc4da6a304b ("ublk: scan partition in async way")
Reported-by: Ruikai Peng <ruikai@pwno.io>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 837fedb02e0d..f6e5a0766721 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -255,20 +255,6 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
-static void ublk_partition_scan_work(struct work_struct *work)
-{
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, partition_scan_work);
-
-	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
-					     &ub->ub_disk->state)))
-		return;
-
-	mutex_lock(&ub->ub_disk->open_mutex);
-	bdev_disk_changed(ub->ub_disk, false);
-	mutex_unlock(&ub->ub_disk->open_mutex);
-}
-
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -1597,6 +1583,27 @@ static void ublk_put_disk(struct gendisk *disk)
 		put_device(disk_to_dev(disk));
 }
 
+static void ublk_partition_scan_work(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, partition_scan_work);
+	/* Hold disk reference to prevent UAF during concurrent teardown */
+	struct gendisk *disk = ublk_get_disk(ub);
+
+	if (!disk)
+		return;
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &disk->state)))
+		goto out;
+
+	mutex_lock(&disk->open_mutex);
+	bdev_disk_changed(disk, false);
+	mutex_unlock(&disk->open_mutex);
+out:
+	ublk_put_disk(disk);
+}
+
 /*
  * Use this function to ensure that ->canceling is consistently set for
  * the device and all queues. Do not set these flags directly.
@@ -2041,7 +2048,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
-	flush_work(&ub->partition_scan_work);
+	cancel_work_sync(&ub->partition_scan_work);
 	ublk_cancel_dev(ub);
 }
 
-- 
2.47.1

