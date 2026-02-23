Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF71DE3DC
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848944; cv=none; b=hdv4J/J6d1Yprkwiox7hIEY4/2wbYul2/SJexQwqYgj9akezDBF146BC/1rHM5ZAXxtGtEdOnpAvgrsQuVGwM5pxPSifjQJN9s+bw3rEJIMKS4AtwT5I0I9QPshWiXSSzGbkvTUNqVVG/zIT/w8cHoJa25TrA6NcXwLLe8JF8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848944; c=relaxed/simple;
	bh=0qggTXxazRQjbqYblxKwRLmVZo+Ctiwcwe7smprYR48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFvOZQXifZNZd572OqwLAAkL6i2W2qCe2r7wOto4nSqffNb/mxUo6giqQ7CyC5HZqUkPO4DHac49WT+eAXbh8ZvTUD6Z/g1hWRy4TmU7JrruaEtRkR02aIHV6Pqa+nq9N4dQdt8efUPy06uj82Gs1jLjSGeUuajPTLtfosxV4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=f4SraJdi; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="f4SraJdi"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771848933; bh=0qggTXxazRQjbqYblxKwRLmVZo+Ctiwcwe7smprYR48=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=f4SraJdisszIxEaag0t8dAY4nxjmOynFnLlumLKPHTQn17/C1jzHFp9vtEtasFXMR
	 P6NGKM0JLncl6IcSU48PZXbBYaeSqUrxpKO/B3E/3zYrwI2RoGJuE+EjSmMUbQHQFb
	 6nifZji33qtEjtMe693Ib+DIaZb9b4UD3QxNIvh8ZB6LuZxjMk5e1yOadep5DTQbfr
	 P7Cq6Im+uZCB6wXHetKKysYT3m4kTte6Alr8uBV7lOcxMTw1DWN7HxuFP1x6ReDt0r
	 KcUjou8ovslVHRQnGXJmuAEz3WzVtHSQ0cAYHehwfUx+Sgn3i8zu4Rc0063UIbgdjo
	 6h2OEJGwzv+hGbPJHvcpqOOh+Lqd/SkiAkT4PfGj8uoIfJ/fArcsPHoAo5VrtBqcb1
	 8GghLj89ANzUdUWkDY6iyyNw2549kMheHBq1Ko8tVkKKDlAsweTPVe0fFUElgZzjbw
	 EjspO9feLiKUXRJ1wg+20qIosMOY3pl7zplCb4GCDspnFqbzlcVv1R88IwlN7QmBiC
	 07iQWOkD5ibuL0QNqFoo45ZBnBB7kzzbMXoOz0Wh2DWLpuok5pTRuM3v4J6ayJGQ9/
	 BJBbD8hUt3pNpwDx7OGN37ARdja9MNEqQvKmOmZIXOKyMB/uERA/Y3zhgWqqjvkOaB
	 SYeGG+7xbvDhykOOFNBxvE1Q=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH 1/4] ublk: cleanup flag handling and fix UBLK_F_NO_AUTO_PART_SCAN
Date: Mon, 23 Feb 2026 12:15:11 +0000
Message-ID: <20260223121515.3296983-2-alex@zazolabs.com>
In-Reply-To: <20260223121515.3296983-1-alex@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
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

Using the new flags rules for partitions become:
 - Unprivileged daemons - never scan partitions, they have
GENHD_FL_NO_PART always set - they are devices without partitions.

 - Trusted daemons - by default have partitions disabled.
Partitions can be enabled via UBLK_F_PARTITIONS flag and
automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag.

Rework the code to work as described above:
- remove checks in ublk_partition_scan_work and rely on
the caller to schedule the work only if it has to be done.
- set GENHD_FL_NO_PART on unprivileged devices
- set GENHD_FL_NO_PART depending on UBLK_F_PARTITIONS on trusted
devices.

Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 drivers/block/ublk_drv.c      | 34 +++++++++++++++++++---------------
 include/uapi/linux/ublk_cmd.h |  7 +++++--
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3c918db4905c..d0c646eb9435 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -81,7 +81,8 @@
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
 		| UBLK_F_SAFE_STOP_DEV \
 		| UBLK_F_BATCH_IO \
-		| UBLK_F_NO_AUTO_PART_SCAN)
+		| UBLK_F_PARTITIONS \
+		| UBLK_F_AUTO_PART_SCAN)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
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
 
@@ -4409,9 +4405,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	 * wait while holding ub->mutex, which can deadlock with other
 	 * operations that need the mutex. Defer partition scan to async
 	 * work.
-	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
-	 * permanently.
+	 * For unprivileged daemons, set GENHD_FL_NO_PART to
+	 * disable partitions.
 	 */
+	if (ub->unprivileged_daemons)
+		disk->flags |= GENHD_FL_NO_PART;
+
+	/* Disable partition scans */
 	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
 	ublk_get_device(ub);
@@ -4429,13 +4429,17 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	set_bit(UB_STATE_USED, &ub->state);
 
-	/* Skip partition scan if disabled by user */
-	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
-		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-	} else {
-		/* Schedule async partition scan for trusted daemons */
-		if (!ub->unprivileged_daemons)
-			schedule_work(&ub->partition_scan_work);
+	if (!ub->unprivileged_daemons) {
+		if (!(ub->dev_info.flags & UBLK_F_PARTITIONS)) {
+			/* disable partitions on trusted device */
+			disk->flags |= GENHD_FL_NO_PART;
+		} else {
+			/* Enable partition scan on device */
+			clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
+			/* Schedule auto partition scan if requested */
+			if (ub->dev_info.flags & UBLK_F_AUTO_PART_SCAN)
+				schedule_work(&ub->partition_scan_work);
+		}
 	}
 
 out_put_cdev:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..467ecaa20ac1 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -367,8 +367,11 @@
  */
 #define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
 
-/* Disable automatic partition scanning when device is started */
-#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
+/* Enable partitions on the device */
+#define UBLK_F_PARTITIONS (1ULL << 18)
+
+/* Perform automatic partition scanning when device is started */
+#define UBLK_F_AUTO_PART_SCAN (1ULL << 19)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
-- 
2.43.0

