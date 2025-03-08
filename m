Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F58433B1
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450526; cv=none; b=g1J3jnszVbwyVzwrchAPOJ7jDC6bKvYZ/GTNbqr8mAl+6tjaBwZF8v7cczM63qt07asP2bw/XxL5RTOU3uxWpjCqsmoKJNmAupr+Mz18XE/Q/vLdINysi7cwgaX9l8I3gfUsmmDgHb7kHFmBU4rCVP5MVNU+Wlzdcz+6ldHbJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450526; c=relaxed/simple;
	bh=e+jORTBzJXYLE5+i5QJbjv/bp42cL7zvDM4Qslq1f0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbZ3LtC94T5WTzrIYnyRU0R3loimowX5nHgriUrHDTgYcyPcDtjQEMUY6z5MzOMRW1IfzT4Q1WXPZICDRpzvo6ReELz5ZjtHZA+qmW8H6jMsVtDEsmFca8iPvVqMS5mwmWe1z7eqWv1fcILMDmh00+mG1ibhytl7n+JE5ziCu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGKMHWcO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGKMHWcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIUjGZlGq7r4VPMZlY5hjKjO/lR8b42Aa+UVkakrz6k=;
	b=gGKMHWcOSfUDDjfbZPj5DVaKVVj/U8+wqHNRL0U4jCkQVf/mkn2kiqVSVhLEzudEV9VonP
	abouQhauZl4apF18ItcW4aC3pcqNQ9DPrlDZqxWTx7+tdLR+lq6ADM8xqzph5/KMDMCS2n
	u2ZySApSYECtblQdusRfQokYNqie0wU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-lv2xumYiOumubfJQyF-cjw-1; Sat,
 08 Mar 2025 11:15:21 -0500
X-MC-Unique: lv2xumYiOumubfJQyF-cjw-1
X-Mimecast-MFC-AGG-ID: lv2xumYiOumubfJQyF-cjw_1741450520
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB44F180035D;
	Sat,  8 Mar 2025 16:15:20 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6915618009BC;
	Sat,  8 Mar 2025 16:15:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: loop: share code of reread partitions
Date: Sun,  9 Mar 2025 00:14:51 +0800
Message-ID: <20250308161504.1639157-2-ming.lei@redhat.com>
In-Reply-To: <20250308161504.1639157-1-ming.lei@redhat.com>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

loop_reread_partitions() has been there for rereading partitions, so
replace the open code in __loop_clr_fd() with loop_reread_partitions()
by passing 'locked' parameter.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a943207705dd..0e08468b9ce0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -650,13 +650,17 @@ static inline void loop_update_dio(struct loop_device *lo)
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
-				   struct block_device *bdev)
+				   struct block_device *bdev, bool locked)
 {
 	int rc;
 
-	mutex_lock(&bdev->bd_mutex);
-	rc = bdev_disk_changed(bdev, false);
-	mutex_unlock(&bdev->bd_mutex);
+	if (locked) {
+		rc = bdev_disk_changed(bdev, false);
+	} else {
+		mutex_lock(&bdev->bd_mutex);
+		rc = bdev_disk_changed(bdev, false);
+		mutex_unlock(&bdev->bd_mutex);
+	}
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -754,7 +758,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 	return 0;
 
 out_err:
@@ -1179,7 +1183,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 	if (claimed_bdev)
 		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 	return 0;
@@ -1270,16 +1274,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!release)
-			mutex_lock(&bdev->bd_mutex);
-		err = bdev_disk_changed(bdev, false);
-		if (!release)
-			mutex_unlock(&bdev->bd_mutex);
-		if (err)
-			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-				__func__, lo_number, err);
-		/* Device is gone, no point in returning error */
-		err = 0;
+		loop_reread_partitions(lo, bdev, release);
 	}
 
 	/*
@@ -1420,7 +1415,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev, false);
 
 	return err;
 }
-- 
2.25.2

