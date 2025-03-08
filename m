Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13372383A2
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450545; cv=none; b=AXKYRtQ8AhhA2zQHCl4igQ5kU26bO49NcJk42WCtEjA2YqnKApe6MRJYwJ4RGrJYwFblTVw5aLbckdXGuhxOd3G4P0kv/UrWXB96PgVu3K+my0n9wrHQM6qLUX/shKx01Pf1/zgL0Y5Jav1BSgsPw2nP5GQv80rhdBb0cfxpnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450545; c=relaxed/simple;
	bh=yKH8FyqZEFc3vU/byxscD5xl+s8quBpQTtkXjz+7orA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2Ze9SRBEO8bHOJbgW3NpY1AxuLbHdmv9k3cxpDeUvHI3efCpTQLu6aIZubEwrmeZlQr8ojbPO+BKZtTPNE/lacjajCDFY0U2v6MZOaKEdtU4fjgQFG+Jn6h0B27V3VbcgcG6ER3dMvHId9hmIq4g9+32uvPV6U4Pwfco34fdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkHu/eu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkHu/eu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3/5qKEEIHenwqx1XIbYlB5tYhqdYlS0V/aQaqfa+0k=;
	b=BkHu/eu3kMivRBvh6KR/VMQ7T5FjldAQS0+vDbykUTkzQgxhI0iftliEaDl59rM5GNhGXU
	hX2+zabRAEWpoFFl6A3IWwehNvK2qFrZ6xcNISJTGYravnRpIDwk/CAsXKPVdGoahh7lPc
	jUEzR6tTWT+Owwsxp9sm/etdMKPkzTA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Q6s51ThyMqmu9jZ-dHUQxw-1; Sat,
 08 Mar 2025 11:15:39 -0500
X-MC-Unique: Q6s51ThyMqmu9jZ-dHUQxw-1
X-Mimecast-MFC-AGG-ID: Q6s51ThyMqmu9jZ-dHUQxw_1741450539
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76FEA1800257;
	Sat,  8 Mar 2025 16:15:36 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8198B18001E9;
	Sat,  8 Mar 2025 16:15:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: loop: delete partitions after clearing & changing fd
Date: Sun,  9 Mar 2025 00:14:54 +0800
Message-ID: <20250308161504.1639157-5-ming.lei@redhat.com>
In-Reply-To: <20250308161504.1639157-1-ming.lei@redhat.com>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

After clearing fd or changing fd, we have to delete old partitions,
otherwise they may become ghost partitions.

Fix this issue by clearing GENHD_FL_NO_PART_SCAN during calling
bdev_disk_changed() which won't drop old partitions if GENHD_FL_NO_PART_SCAN
isn't set.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0e08468b9ce0..cf71a1bbcd45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -650,17 +650,26 @@ static inline void loop_update_dio(struct loop_device *lo)
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
-				   struct block_device *bdev, bool locked)
+				   struct block_device *bdev, bool locked,
+				   bool force_scan)
 {
 	int rc;
+	bool no_scan;
 
-	if (locked) {
-		rc = bdev_disk_changed(bdev, false);
-	} else {
+	if (!locked)
 		mutex_lock(&bdev->bd_mutex);
-		rc = bdev_disk_changed(bdev, false);
+
+	no_scan = lo->lo_disk->flags & GENHD_FL_NO_PART_SCAN;
+	if (force_scan && no_scan)
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+
+	rc = bdev_disk_changed(bdev, false);
+
+	if (force_scan && no_scan)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+
+	if (!locked)
 		mutex_unlock(&bdev->bd_mutex);
-	}
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -758,7 +767,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, true);
 	return 0;
 
 out_err:
@@ -1183,7 +1192,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, false);
 	if (claimed_bdev)
 		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 	return 0;
@@ -1274,7 +1283,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		loop_reread_partitions(lo, bdev, release);
+		loop_reread_partitions(lo, bdev, release, true);
 	}
 
 	/*
@@ -1415,7 +1424,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, false);
 
 	return err;
 }
-- 
2.25.2

