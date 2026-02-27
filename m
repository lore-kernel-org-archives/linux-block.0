Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89A42849E
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204295; cv=none; b=QmaUIG7K8Ygp6UUSDIf+3vBuatIx8YI1557Cjz3cJIgdzS1c/HNhswKq8fHDtf3+n13P+i9u6U7IVbETyfk8KM3dYltA43I2C+12mpICeftquMHFNiVKjvFT0R+MD+XS6K5gSG6cv3ea8qW5C9q10taCA4ZkWHeMU1hYroL+nVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204295; c=relaxed/simple;
	bh=ytpotaUKL3MpK1CDvM6xOPUiMeDnIIQfsbzj/TMnvyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owuzb868PY+DPmBxXaS82J8RpQ1BJ8tHaVLqT8HpfJZe2T4sXQhrgK1Nka7nsQTQzNGDla0vM9rltzZiNZPlUwUKdtCj8Y4p7fG6yXclqkVYgO6CW6Qwu5CYIfI9KczYrZUkYNHeN47ddz8lEY3zdy/lq0EZQaAIxNF1zBMUxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=OQW/oZgM; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="OQW/oZgM"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772204284; bh=ytpotaUKL3MpK1CDvM6xOPUiMeDnIIQfsbzj/TMnvyI=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=OQW/oZgMNlcdEFrEeYOLggh2vS92JIUbapUJCkMbSNyBZZQ6GSs1wHk6q5pNZMjCD
	 AiiTFnEO4ZuQU5MTf/ddGiLgU9XQBLoDliKG20Wu95J0VKbORULBoWWPsddkauKCDI
	 ZdrQutMRDvGBCu5XbceTwzuRg3vobF25koCOaJ069iZCZb/B+Hq99rLoFG52dgeNGG
	 L/v7MwI2R0Lr2uGCRfWUFtMKZbh9MELeVxi9d1eeudJX8wIYxcJPX45xGyMxm5pSgK
	 YDIvFCvkb3qfFqm2GoJpkSIYYvua8hQgZHE7+9h+sD8ccAgYO6+l1v+STTJH8aFoT7
	 MzqFW9manjHp9Z095YP33a2G17bVd8+NtwTvD+ENtGLK8ZQdcbRD53HsvlFtrz9gL1
	 YAEKqwMzbTWQism8GwarTYmPwBZtTb5ArNf34RkFi/1N7K3GA2MfY8MIq0KWC+gU1a
	 UO9Eh3V68THe93O5UXIH54Prh9NCasUhpH/Q9zR1ugsiy8zV4m7c/giNW0BBOzNXzP
	 zVjMk3s+k0KhUgYl/WFbSik0j18C7AKK0R7HS5dPOd5r0YLr7HeT4k1home2SmciuQ
	 TuTwXfLiW61hAMSt94GRP0iRyl32VuqD2ZBR3DKNODXom0AqyS/UbHXz7lX2mJCNZm
	 zzAbLm21svuENhZ7Rz2TJGjI=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH v2 1/4] ublk: cleanup partition flags handling and introduce UBLK_F_NO_PARTITONS
Date: Fri, 27 Feb 2026 14:57:53 +0000
Message-ID: <20260227145756.3877069-2-alex@zazolabs.com>
In-Reply-To: <20260227145756.3877069-1-alex@zazolabs.com>
References: <20260227145756.3877069-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code misuse GD_SUPPRESS_PART_SCAN flag
as it tries to use it as a switch for the auto partition scan.
To fully disable creation of partitions GENHD_FL_NO_PART must
be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.

Rules for partitions become:
 - Unprivileged daemons - never scan partitions, they have
GENHD_FL_NO_PART always set - they are devices without partitions.

 - Trusted daemons - by default have partitions enabled,
automatic initial scan can be disabled via UBLK_F_NO_AUTO_PART_SCAN flag.
Partitions can be disabled via UBLK_F_NO_PARTITIONS flag.

Rework the code to work as described above:
- remove checks in ublk_partition_scan_work and rely on
the caller to schedule the work only if it has to be done.
- set GENHD_FL_NO_PART on unprivileged devices
- set GENHD_FL_NO_PART depending on UBLK_F_NO_PARTITIONS on trusted
devices.

Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 drivers/block/ublk_drv.c      | 23 +++++++++--------------
 include/uapi/linux/ublk_cmd.h |  3 +++
 2 files changed, 12 insertions(+), 14 deletions(-)

-v1->v2:
  - remove code duplication and extra flag settings
  - switch from out-in to out-out to preserve backwards compatibility


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3c918db4905c..36da63ba2a57 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -81,6 +81,7 @@
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
 		| UBLK_F_SAFE_STOP_DEV \
 		| UBLK_F_BATCH_IO \
+		| UBLK_F_NO_PARTITIONS \
 		| UBLK_F_NO_AUTO_PART_SCAN)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
@@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
 	if (!disk)
 		return;
 
-	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
-					     &disk->state)))
-		goto out;
-
 	mutex_lock(&disk->open_mutex);
 	bdev_disk_changed(disk, false);
 	mutex_unlock(&disk->open_mutex);
-out:
 	ublk_put_disk(disk);
 }
 
@@ -4409,10 +4405,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	 * wait while holding ub->mutex, which can deadlock with other
 	 * operations that need the mutex. Defer partition scan to async
 	 * work.
-	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
-	 * permanently.
+	 * For unprivileged daemons, set GENHD_FL_NO_PART to
+	 * disable partitions.
 	 */
-	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+	disk->flags |= GENHD_FL_NO_PART;
 
 	ublk_get_device(ub);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
@@ -4429,12 +4425,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	set_bit(UB_STATE_USED, &ub->state);
 
-	/* Skip partition scan if disabled by user */
-	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
-		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-	} else {
-		/* Schedule async partition scan for trusted daemons */
-		if (!ub->unprivileged_daemons)
+	if (!ub->unprivileged_daemons && !(ub->dev_info.flags & UBLK_F_NO_PARTITIONS)) {
+		/* Enable partitions on device */
+		disk->flags &= ~GENHD_FL_NO_PART;
+		/* Disable auto partition scan if requested */
+		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
 			schedule_work(&ub->partition_scan_work);
 	}
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..bfd2adfb3d8d 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -370,6 +370,9 @@
 /* Disable automatic partition scanning when device is started */
 #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
 
+/* Disable partitions on the device */
+#define UBLK_F_NO_PARTITIONS (1ULL << 19)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.43.0

