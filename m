Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0B14A8C
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674997; cv=none; b=Y2jdawC2Nf6xTuKuOoWW0S2h+4f+h88Yvw6D8H6t0yGGmGUmdENFPgMTu3AanQFveH69dW7FfG/zW6sEVLUM1KoR0eR1rjQvvVP6+wwMigguYkwKg2jjPRoBoiVjZpX0dF6S5bZ+K3gvegMzJwmQ9n0L+SODJYtwURz8qJDCcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674997; c=relaxed/simple;
	bh=W4qBi5aKaxwbNsBiYTMPaf0mxPaM4DThRoK8fcCG9sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGS1vlc77ZQCOxVDSgkR5NBPqCARkbbHeglquCnkJVkmLpUc1crWN4SUVQ/04KredrLDPGifPQnjUGncP6sQAHe55Cp5wauZVjv/aMI0Pu+aHYgPLIQhq+8uDDp3mKQschyB1yxsQa5JgBABlI5Zyzs1RYEiTEehLIYayzprs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHTj+GTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHTj+GTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708674994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV0ACDdLD4Y0EyfJX0EvH4hNY/p4WPQ+tPG/NTQCZEQ=;
	b=CHTj+GTkmE6ddr14pQIIlKDT5KGdouIxyAh4ZMqFfZ5Y4muJ7YY/vL7R+I+c+0MEgBorKa
	KXPoVCUEGOQ/XMTjYfU30QuxCrQhvacWuUgjiS9N6VY0uj8zv2W7TuzLEqI2HYtwEwOQee
	RxbfeBkiqX3VV1a6bCxRq72ROofMiaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-NsIXM1WPPZuptbnTkH_vuQ-1; Fri, 23 Feb 2024 02:56:31 -0500
X-MC-Unique: NsIXM1WPPZuptbnTkH_vuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAF35185A781;
	Fri, 23 Feb 2024 07:56:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04E8C1C06710;
	Fri, 23 Feb 2024 07:56:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] ublk: improve getting & putting ublk device
Date: Fri, 23 Feb 2024 15:55:38 +0800
Message-ID: <20240223075539.89945-2-ming.lei@redhat.com>
In-Reply-To: <20240223075539.89945-1-ming.lei@redhat.com>
References: <20240223075539.89945-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Firstly convert get_device() and put_device() into ublk_get_device()
and ublk_put_device().

Secondly annotate ublk_get_device() & ublk_put_device() as noinline
for trace, especially it is often to trigger device deletion hang
when incorrect order is used on ublkc mmap, ublkc close,
io_uring_sqe_unregister_file, ublkb close.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 01afe90a47ac..06d88d2008ba 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -605,14 +605,16 @@ static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
 }
 
-static struct ublk_device *ublk_get_device(struct ublk_device *ub)
+/* Called in slow path only, keep it noinline for trace purpose */
+static noinline struct ublk_device *ublk_get_device(struct ublk_device *ub)
 {
 	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
 		return ub;
 	return NULL;
 }
 
-static void ublk_put_device(struct ublk_device *ub)
+/* Called in slow path only, keep it noinline for trace purpose */
+static noinline void ublk_put_device(struct ublk_device *ub)
 {
 	put_device(&ub->cdev_dev);
 }
@@ -671,7 +673,7 @@ static void ublk_free_disk(struct gendisk *disk)
 	struct ublk_device *ub = disk->private_data;
 
 	clear_bit(UB_STATE_USED, &ub->state);
-	put_device(&ub->cdev_dev);
+	ublk_put_device(ub);
 }
 
 static void ublk_store_owner_uid_gid(unsigned int *owner_uid,
@@ -2142,7 +2144,7 @@ static void ublk_remove(struct ublk_device *ub)
 	cancel_work_sync(&ub->stop_work);
 	cancel_work_sync(&ub->quiesce_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
-	put_device(&ub->cdev_dev);
+	ublk_put_device(ub);
 	ublks_added--;
 }
 
@@ -2235,7 +2237,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
-	get_device(&ub->cdev_dev);
+	ublk_get_device(ub);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 
 	if (ublk_dev_is_zoned(ub)) {
-- 
2.41.0

