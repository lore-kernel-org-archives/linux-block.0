Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E234A21
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910057; cv=none; b=OnYgg1RTQQusYA5ghUT+g903SWL3bvaEso/1myMqwghImfoTVuQfx+I3OPl7tTk+VP52YJu7MCWnno4eeV3tiZOn5TyWNhM/istrnUdFs+VFuy/D+TezNdV8VcMxIIJBZCRX9h/+eGwbjgu+iByljSwcAJrYlEIvHkOXf8p2ynM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910057; c=relaxed/simple;
	bh=pSsimxU8X8wSbeVuvNPeBN1LYivq5lZBE3HbpyaBDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jraylCiWYDOjqfiKzXAsXfD2sM4iQshvVQX9OhDs2eFjW5qKu/6pQBi7Uc+XDBO7+5B2lU34g4m9gTq4mrlaSRiuoiHIWgS9VFNFxGgLOZbVWyNdISxV7+PvDVl4P9Uo4XrQpWr41D6HwuHdGFSVfTMTyLG5r5fromvI6ng2xUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=ooFZ+Q7T; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="ooFZ+Q7T"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770910051; bh=pSsimxU8X8wSbeVuvNPeBN1LYivq5lZBE3HbpyaBDEw=;
	h=From:To:Cc:Subject;
	b=ooFZ+Q7TcN19S/a2zU38I1xrzuZb3RkN99xJIyb2XGBlBiKhifwC87IvwOz/Mh+7C
	 izqj8GBupirSin+NSspiW61gyxa4M53h6J4jVg7cqUyFAE0G/16BjoeCcePnr9vnL8
	 gCuQ8C9ql+9MBxSdHovSN42EimJR5x7KEOmznOYnkwGmBQDR1NkG4JJwiP5u1gkfrF
	 AVsx8i/oP4A+V40TF6Dk4I16tjbYbxSB8aLNdrrLZxswLcRwFNzZtlGdIQCfhIknbX
	 1reXqFCW3nYss/Bxrpld7ngCwOW5zdgOTz53l6wSLj6IRVTZGD7UcK+18xePi6iqbV
	 5yjmLVs712hpQxpacncdcAxnTEY55ylHAFOBQ+JKcQCYO5Ia0oYfWUBeydx2eIPm8N
	 uKHDw429QMTV1XMxG2Vn2WM+O+JG1gVfER+QnQg/vMX6czuacxk2q12f6VQGd1EuvE
	 t/PDFnuVCWCRSLQBQUdKvrgk9dal7kiPYBJee2mEORzOqIYGDaTEsHRD7pKj2186rr
	 msm4BM4Oz/GqQsGUrRPdPJc2VcjXLOu/9Ksz7ZfGgLnbGCEntd6Ywkv9CgvEuARt9o
	 3uo6P4POV/pZDOb17gv7rwmEW1u4inAJ9thlCboARmDTT+mmUYQHjXfU/rhxeWOfy+
	 obL/RFnInD7P9tduBKepdO7o=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH] ublk: cleanup flag handling and fix UBLK_F_NO_AUTO_PART_SCAN
Date: Thu, 12 Feb 2026 15:25:52 +0000
Message-ID: <20260212152553.1737373-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code misuse GD_SUPPRESS_PART_SCAN flag
as it tries to use it as a switch for the auto partition scan.
When UBLK_F_NO_AUTO_PART_SCAN is not passed a proper
auto partition scanning is not done because the first
call to ublk_partition_scan_work will clear the bit
GD_SUPPRESS_PART_SCAN but not actually load the partitions.

How it should work:
Unprivileged daemons - never scan partitions, they have
GD_SUPPRESS_PART_SCAN always set - they are marked as devices
without partitions. While ioctl(BLKRRPART) does require
CAP_SYS_ADMIN, block layer have its own a check in
disk_has_partscan(...) if partitions are supported.

Trusted daemons - auto scan partitions by default
and they do not have the bit set, so they do have partitions.

For trusted daemons auto partitions scan is performed but it can
be skipped if user have set UBLK_F_NO_AUTO_PART_SCAN flag.

Rework the code to work as described above:
- remove checks in ublk_partition_scan_work and rely on
the caller to schedule the work only if it has to be done.
- keep GD_SUPPRESS_PART_SCAN always set on unprivileged
- keep GD_SUPPRESS_PART_SCAN always clear on trusted
- Properly handle user request to skip auto partitioning scanning

Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 drivers/block/ublk_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

Cc: Yoav Cohen <yoav@nvidia.com>

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3c918db4905c..e662c6e8e722 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2361,14 +2361,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
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
 
@@ -4429,12 +4424,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 
 	set_bit(UB_STATE_USED, &ub->state);
 
-	/* Skip partition scan if disabled by user */
-	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
+	if (!ub->unprivileged_daemons) {
+		/* Enable partition scanning for trusted daemons */
 		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-	} else {
-		/* Schedule async partition scan for trusted daemons */
-		if (!ub->unprivileged_daemons)
+		/* Skip auto partition scan if requested by user */
+		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
 			schedule_work(&ub->partition_scan_work);
 	}
 

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.43.0

