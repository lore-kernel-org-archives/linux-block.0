Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE732D0EA
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464527; cv=none; b=KN/ImvXTVoPyBK/uQngyeqKRhawcVlYH26VejOFAQ4Wu0iY4cfvNGAAZCQ+RrLl6aYMVBFpXJc8dC++he+z3HlfNakwlxvFSPSQCqpPosLuY3s6QODiAIVAHDpSM+6kkmLGe0LTC0Pzt7sFg5IFROhvQuU3K3aIwDE/7wrfuKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464527; c=relaxed/simple;
	bh=p7eN+bVWWxkL7QedYYdVjpIWfOntnf+VDkriJhWfYZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxLW2QRsHPUnfZZnPmcrRiXctRWcDV8az3E+esOhPWwkw6FCdWiXpyvrW8kA3mGhkIQXPzMTU/9ta+nnGkt3sHky6cU04cX4mWAwhSISbYSWktlLwvq037q0p1NC0LYY6bgKgoZDJKPnjQuDjf9KEHvd6hir6v4VLvLnP+/gYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NoRfQuur; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NoRfQuur"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f3fcdb556so287852b3a.2
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768464525; x=1769069325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtWA5RxXbbzoB3uOwGRmhTGGY6Hy9BUvOwDXsRsPtHE=;
        b=NoRfQuurZO70osBSIV5I+g5rHnhXQhSwXLN6CiFahZ4114DRNjDD8+yJncob2c+JTU
         FCw0yGTB9NrPi4rGUPQs1hs8y2CgJGtvK+kvjrpvk1PUNnCyIrpbM9XdlJp9TGDrPK2H
         UPgOScp2ls5PudGI7gN2064ImAEVAnPytWTQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464525; x=1769069325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtWA5RxXbbzoB3uOwGRmhTGGY6Hy9BUvOwDXsRsPtHE=;
        b=fmKScxHy/Yc+KUGIkhBRNe9iLUcF/LkvKhGrZY3flFdvu+r0vAl70/uegypPnyGikA
         1jXUr3ut7ajBYxShZqYwSgokZoGndzU2MEt6AV8YrwlQpfEDVx3AA3Of3CexaMt9Nwhg
         T0h6oDfGSl/1SH9txBcy497GRBYH87dqX0wZHgyH1Me6j0uPBG5irWcYe4IDM5oA1AAH
         ox0rb+llyhTlypQB5arNOXjd759cLaopIgvNzCVXqwMU/R8S5ie9E+TUW6Yzztihcsxv
         UN4P5spq7+eeBantrCRSjUospfZgZtA4777MWR0hI9FRW1OwnvlsmHAJfl6yKn84Mt5V
         022Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr5WZkpYyWt73qL4H0dRaU6T821++uLZj+Ur6yRwe2iJ68Z1CBiVi8bGQkPuOwqW1bLnmMH/y5ldJX+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0DaTkqIzGxbFfBXH9SCgkAJFV1f4LGAZtuBTDeND3ELUwgX0
	+s6XZt/f2k7vk98KpMQsNFDaezunqosPwKPosRtAhlHW22o02OA/5IuF2w+n1KAeYw==
X-Gm-Gg: AY/fxX4mDuggZE84h8Eqw5z52rZjSsZVjf6NT9KCUMxKu0OIOVs+4RVConhSCuxREPY
	hOA5Rsp4sE8gcHeonObEi76XipnynBU9/Qyy0W/yPM3h6PsWxaGIlmQIMXc97+BmmhSsD6uvgOr
	cGSLHcRF69e4Q78yYVIUlMqHomCYkU3MsEOvR76kzTfXZby3UZ/Tf4CCnnOAs2UezRSXtO2LGOB
	F1s17897k22003U2O6zzy1z0gR4gqPXSDWQ1OZ8J8YtcZtMvj5qqd9rTHoFy6S4hg9Et4QBV0+F
	ugQu0bYyIc9t2j/WG4EzTyeoz6ff4VhTzwwa3TWAXaxLR5CnSVSFqSzV8PeL+wUUVMZaH6MRzgG
	+8D9lMY0VeN+8Hojo3wcQE46x2gW0g3I5vgf0qY9jf8gSSbW6MJKTq2L2n8S0ZlMXVPr0WBPYJD
	rGoYaRxHKbbkRalModoK8ICs0QZvbJDzYbg2K+NIVltjBq79aYHQltlhsMtWjDgLMggn9Jlej8
X-Received: by 2002:a05:6a20:3954:b0:361:4f82:e545 with SMTP id adf61e73a8af0-38bed1ff87emr5376591637.53.1768464524847;
        Thu, 15 Jan 2026 00:08:44 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:5147:712:23d1:5e38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28ebe4sm24449235a12.4.2026.01.15.00.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:08:43 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: rename init_lock to dev_lock
Date: Thu, 15 Jan 2026 17:08:07 +0900
Message-ID: <20260115080807.3957860-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_lock has completely outgrown its initial purpose and is no longer
used only to "prevent concurrent execution of device init" as the stale
comment suggests. The scope of this lock is much bigger now.

These days this lock (rw_semaphore) controls how a task owns the
corresponding zram device: either in shared mode or in exclusive mode.

All zram device attribute writes should own the device in exclusive
mode, which synchronizes these tasks and prevents, for example,
concurrent execution of recompression and writeback.

All zram device attribute reads should own the device in shared mode.

Rename the lock to dev_lock to better reflect its current purpose.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 60 +++++++++++++++++------------------
 drivers/block/zram/zram_drv.h |  4 +--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 912711faa4e4..1908fc66c050 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -365,7 +365,7 @@ static ssize_t initstate_show(struct device *dev, struct device_attribute *attr,
 	u32 val;
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	val = init_done(zram);
 
 	return sysfs_emit(buf, "%u\n", val);
@@ -391,7 +391,7 @@ static ssize_t mem_limit_store(struct device *dev,
 	if (buf == tmp) /* no chars parsed, invalid input */
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	zram->limit_pages = PAGE_ALIGN(limit) >> PAGE_SHIFT;
 
 	return len;
@@ -409,7 +409,7 @@ static ssize_t mem_used_max_store(struct device *dev,
 	if (err || val != 0)
 		return -EINVAL;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	if (init_done(zram)) {
 		atomic_long_set(&zram->stats.max_used_pages,
 				zs_get_total_pages(zram->mem_pool));
@@ -477,7 +477,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 			return -EINVAL;
 	}
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
@@ -539,7 +539,7 @@ static ssize_t bd_stat_show(struct device *dev, struct device_attribute *attr,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	ret = sysfs_emit(buf,
 			 "%8llu %8llu %8llu\n",
 			 FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
@@ -559,7 +559,7 @@ static ssize_t writeback_compressed_store(struct device *dev,
 	if (kstrtobool(buf, &val))
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (init_done(zram)) {
 		return -EBUSY;
 	}
@@ -576,7 +576,7 @@ static ssize_t writeback_compressed_show(struct device *dev,
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	val = zram->wb_compressed;
 
 	return sysfs_emit(buf, "%d\n", val);
@@ -592,7 +592,7 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	zram->wb_limit_enable = val;
 
 	return len;
@@ -605,7 +605,7 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	val = zram->wb_limit_enable;
 
 	return sysfs_emit(buf, "%d\n", val);
@@ -631,7 +631,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 	 */
 	val = rounddown(val, PAGE_SIZE / 4096);
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	zram->bd_wb_limit = val;
 
 	return len;
@@ -643,7 +643,7 @@ static ssize_t writeback_limit_show(struct device *dev,
 	u64 val;
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	val = zram->bd_wb_limit;
 
 	return sysfs_emit(buf, "%llu\n", val);
@@ -662,7 +662,7 @@ static ssize_t writeback_batch_size_store(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	zram->wb_batch_size = val;
 
 	return len;
@@ -675,7 +675,7 @@ static ssize_t writeback_batch_size_show(struct device *dev,
 	u32 val;
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	val = zram->wb_batch_size;
 
 	return sysfs_emit(buf, "%u\n", val);
@@ -703,7 +703,7 @@ static ssize_t backing_dev_show(struct device *dev,
 	char *p;
 	ssize_t ret;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	file = zram->backing_dev;
 	if (!file) {
 		memcpy(buf, "none\n", 5);
@@ -737,7 +737,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	if (!file_name)
 		return -ENOMEM;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (init_done(zram)) {
 		pr_info("Can't setup backing device for initialized device\n");
 		err = -EBUSY;
@@ -901,7 +901,7 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 
 static void zram_account_writeback_rollback(struct zram *zram)
 {
-	lockdep_assert_held_write(&zram->init_lock);
+	lockdep_assert_held_write(&zram->dev_lock);
 
 	if (zram->wb_limit_enable)
 		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
@@ -909,7 +909,7 @@ static void zram_account_writeback_rollback(struct zram *zram)
 
 static void zram_account_writeback_submit(struct zram *zram)
 {
-	lockdep_assert_held_write(&zram->init_lock);
+	lockdep_assert_held_write(&zram->dev_lock);
 
 	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
 		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
@@ -1263,7 +1263,7 @@ static ssize_t writeback_store(struct device *dev,
 	ssize_t ret = len;
 	int err, mode = 0;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
@@ -1566,7 +1566,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	if (!kbuf)
 		return -ENOMEM;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	if (!init_done(zram)) {
 		kvfree(kbuf);
 		return -EINVAL;
@@ -1667,7 +1667,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 		return -EINVAL;
 	}
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (init_done(zram)) {
 		kfree(compressor);
 		pr_info("Can't change algorithm for initialized device\n");
@@ -1795,7 +1795,7 @@ static ssize_t comp_algorithm_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t sz;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_COMP], buf, 0);
 	return sz;
 }
@@ -1821,7 +1821,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	ssize_t sz = 0;
 	u32 prio;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
@@ -1879,7 +1879,7 @@ static ssize_t compact_store(struct device *dev, struct device_attribute *attr,
 {
 	struct zram *zram = dev_to_zram(dev);
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
@@ -1894,7 +1894,7 @@ static ssize_t io_stat_show(struct device *dev, struct device_attribute *attr,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	ret = sysfs_emit(buf,
 			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
@@ -1915,7 +1915,7 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 
 	memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	if (init_done(zram)) {
 		mem_used = zs_get_total_pages(zram->mem_pool);
 		zs_pool_stats(zram->mem_pool, &pool_stats);
@@ -1946,7 +1946,7 @@ static ssize_t debug_stat_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
-	guard(rwsem_read)(&zram->init_lock);
+	guard(rwsem_read)(&zram->dev_lock);
 	ret = sysfs_emit(buf,
 			"version: %d\n0 %8llu\n",
 			version,
@@ -2612,7 +2612,7 @@ static ssize_t recompress_store(struct device *dev,
 	if (threshold >= huge_class_size)
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (!init_done(zram))
 		return -EINVAL;
 
@@ -2864,7 +2864,7 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
 
@@ -2894,7 +2894,7 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 	if (!disksize)
 		return -EINVAL;
 
-	guard(rwsem_write)(&zram->init_lock);
+	guard(rwsem_write)(&zram->dev_lock);
 	if (init_done(zram)) {
 		pr_info("Cannot change disksize for initialized device\n");
 		return -EBUSY;
@@ -3089,7 +3089,7 @@ static int zram_add(void)
 		goto out_free_dev;
 	device_id = ret;
 
-	init_rwsem(&zram->init_lock);
+	init_rwsem(&zram->dev_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_batch_size = 32;
 	zram->wb_compressed = false;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 469a3dab44ad..515a72d9c06f 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -111,8 +111,8 @@ struct zram {
 	struct zcomp *comps[ZRAM_MAX_COMPS];
 	struct zcomp_params params[ZRAM_MAX_COMPS];
 	struct gendisk *disk;
-	/* Prevent concurrent execution of device init */
-	struct rw_semaphore init_lock;
+	/* Locks the device either in exclusive or in shared mode */
+	struct rw_semaphore dev_lock;
 	/*
 	 * the number of pages zram can consume for storing compressed data
 	 */
-- 
2.52.0.457.g6b5491de43-goog

