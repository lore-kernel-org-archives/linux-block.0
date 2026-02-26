Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F31D5ADE
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074517; cv=none; b=UU3JxHEd2F/g4ZO/YXH6h9Mi1M+kDP1pqhElN6w4LvDaV/UW0WWeClJ49PytQIIKP9sikIEIvm35UGT+Umrgbu+0s+WZ1oYNMijZd+tFffErrenugevGwd0E4mlsypmGjkRYVkYl0jz+uITWeldvt9SUbxI5BB93EcV7ND9Hhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074517; c=relaxed/simple;
	bh=VjGKtXITc0pdYwUu6S72CwtewYU/uQ/NuG3HuciaF/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpjEw+Nkmve0j7NvYHeMyCV38N2N4c2iGgUhDEDcyEeqYRbVMnkJ1OvizJ3UXcZLMGICTj7ny6qh7O4M4rqa77dslmAGT9NYhsCvZokixqR0AnmcDtPze4YnYkJIpQdXeysWcUupdzGiwnCFMzl+wEcDMt3hWYzpaNhMpMyH+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UWerd7Ll; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWerd7Ll"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adec255754so1851995ad.3
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 18:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772074515; x=1772679315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EaJpafr6czHHudzxJg6tiucI2ej6OmZ2sEcinKt0YCQ=;
        b=UWerd7LlxTqb8rVEuHG+ldA0+K0UdQykoiejOZ+ZY/tt8phngzx4B6c8aKe1ufZ8i5
         TvWRfltxYOZwHZXqOzXZIdyy10SO8PRuvuK0B5HQfiftaKn6Q/EPY4gjSDBVO81rnOS8
         TdAnScC9qNzZ/pH9Tdq8NNO1J/r3ebd26zz24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772074515; x=1772679315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaJpafr6czHHudzxJg6tiucI2ej6OmZ2sEcinKt0YCQ=;
        b=UWuSNkkRnJuNAW+ZwXkwHPlk0zM3zAOEErZ/J1cYBsAN31bonxArxFZMtYVfmoL2fO
         kwhIc2iS3WhTv7NmGcRpytwLQxv0bPN+sFJklq99ZgRiHo9bwurodnSaT7x2njJ8jx5S
         ESXdP0v7ZsgUPn3bcobqcSNO8cgpljAdI3fwkTpVEQVipANr8K+mfwiZBEz4YCIu5xh7
         phdOY9P5k5o17mAoG5EE5oqCKd3uKblBU2qKhO5HDgKo98TjQ9LX/K4gQA/RJQP31aS4
         J+14Ua+j/U1osfQ4SBAME5l5j56mha+/WBehBp4IP6jPF4Mh4MYvyKkCQzOT0ZVIy2Eb
         sZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmtCkJyRPLLPv3thB7OrOakChnXugRiA5c/atQ9AuSuidfA6DNNpZO5Bcj8kv5RmWGg9cHgDmbdB1P0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85Mg/fcvDLe5w8a68PKng8RMDAGU580UulHc0HaVHGd1Obcxz
	lks4OY5IMAx+O18qoWQIBrYl8HiNhaSXfPjP9turb1qpnYAibGeZua7B9EEQTIHASJh421SMYxE
	HuLg=
X-Gm-Gg: ATEYQzwALVCNea4ASMsxWdU7VSxLYUoKwMdyzkmFFR6knF2KLlAAAm4ZA4SNFS+OOlp
	/sg1uuW2DDPVLYRGOtmcebSO1uKaf6J8wDMUkEc3hZOR/3qTXHHMTdnS9Y+DSPpmWcpHmSu/cCk
	8a7H9wJvXRGqLUmeyou97a+JP7vFEJqZ8WzRzKIFvdmcwVOCGln/E5HCWZ2m4/8wqZvJOzxNXiH
	QlmmjzfPJM73crg3wC4GyWqcQMW0r/d6tQ+dYFQxoh70jJLwgcHIuddNxs5FiROpWiL++wDswbT
	IgH579uilLxFzuHrIHX5yefFnnrR6lREbJS3JUGZCDX0xfovBLiAug9NJGexFH57RDBk4WoJ3v5
	NHRc+SY6aXixXZwpubFZlK10pw1zIbRsvLBvh+xrXhE6lstK9OtbIXEahEUKckvQh9xRXJjs5A5
	Sn9dUMiai20FWomcmJFeHV6QOErlW1FUhXHiii8cqv/5fX9jxl7612Xj2gmcn8BgtdEK1yTq+7q
	clk1TJjejpyvQ==
X-Received: by 2002:a17:903:3b83:b0:2a0:ba6d:d101 with SMTP id d9443c01a7336-2ad74463a70mr174086735ad.21.1772074515021;
        Wed, 25 Feb 2026 18:55:15 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:f7cc:c9c1:b4d7:b50d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f277sm8716145ad.55.2026.02.25.18.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 18:55:14 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] zram: rename writeback_compressed device attr
Date: Thu, 26 Feb 2026 11:54:21 +0900
Message-ID: <20260226025429.1042083-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename writeback_compressed attr to compressed_writeback
to avoid possible confusion and have more natural naming.
writeabck_compressed may look like an alternative version
of writeback while in fact writeback_compressed only sets
a writeback property.  Make this distinction more clear
with a new compressed_writeback name.

Suggested-by: Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Richard Chang <richardycc@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---


Andrew, the code in question is in 7.0-rc1, it has not been
released yet, so we think it's safe to rename the attribute
without breaking userspace.  Can you please pick this patch
for 7.0-rc2?


 Documentation/ABI/testing/sysfs-block-zram  |  4 ++--
 Documentation/admin-guide/blockdev/zram.rst |  6 +++---
 drivers/block/zram/zram_drv.c               | 24 ++++++++++-----------
 drivers/block/zram/zram_drv.h               |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index e538d4850d61..64c03010e951 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -151,11 +151,11 @@ Description:
 		The algorithm_params file is write-only and is used to setup
 		compression algorithm parameters.
 
-What:		/sys/block/zram<id>/writeback_compressed
+What:		/sys/block/zram<id>/compressed_writeback
 Date:		Decemeber 2025
 Contact:	Richard Chang <richardycc@google.com>
 Description:
-		The writeback_compressed device atrribute toggles compressed
+		The compressed_writeback device atrribute toggles compressed
 		writeback feature.
 
 What:		/sys/block/zram<id>/writeback_batch_size
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 005266b0ef15..e83c2860f2f0 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -216,7 +216,7 @@ writeback_limit   	WO	specifies the maximum amount of write IO zram
 writeback_limit_enable  RW	show and set writeback_limit feature
 writeback_batch_size	RW	show and set maximum number of in-flight
 				writeback operations
-writeback_compressed	RW	show and set compressed writeback feature
+compressed_writeback	RW	show and set compressed writeback feature
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
 compact           	WO	trigger memory compaction
@@ -439,11 +439,11 @@ budget in next setting is user's job.
 By default zram stores written back pages in decompressed (raw) form, which
 means that writeback operation involves decompression of the page before
 writing it to the backing device.  This behavior can be changed by enabling
-`writeback_compressed` feature, which causes zram to write compressed pages
+`compressed_writeback` feature, which causes zram to write compressed pages
 to the backing device, thus avoiding decompression overhead.  To enable
 this feature, execute::
 
-	$ echo yes > /sys/block/zramX/writeback_compressed
+	$ echo yes > /sys/block/zramX/compressed_writeback
 
 Note that this feature should be configured before the `zramX` device is
 initialized.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 346a99561a95..6b76dbe7fb80 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -549,7 +549,7 @@ static ssize_t bd_stat_show(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
-static ssize_t writeback_compressed_store(struct device *dev,
+static ssize_t compressed_writeback_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t len)
 {
@@ -564,12 +564,12 @@ static ssize_t writeback_compressed_store(struct device *dev,
 		return -EBUSY;
 	}
 
-	zram->wb_compressed = val;
+	zram->compressed_wb = val;
 
 	return len;
 }
 
-static ssize_t writeback_compressed_show(struct device *dev,
+static ssize_t compressed_writeback_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
@@ -577,7 +577,7 @@ static ssize_t writeback_compressed_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 
 	guard(rwsem_read)(&zram->dev_lock);
-	val = zram->wb_compressed;
+	val = zram->compressed_wb;
 
 	return sysfs_emit(buf, "%d\n", val);
 }
@@ -946,7 +946,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 		goto out;
 	}
 
-	if (zram->wb_compressed) {
+	if (zram->compressed_wb) {
 		/*
 		 * ZRAM_WB slots get freed, we need to preserve data required
 		 * for read decompression.
@@ -960,7 +960,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	set_slot_flag(zram, index, ZRAM_WB);
 	set_slot_handle(zram, index, req->blk_idx);
 
-	if (zram->wb_compressed) {
+	if (zram->compressed_wb) {
 		if (huge)
 			set_slot_flag(zram, index, ZRAM_HUGE);
 		set_slot_size(zram, index, size);
@@ -1100,7 +1100,7 @@ static int zram_writeback_slots(struct zram *zram,
 		 */
 		if (!test_slot_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram->wb_compressed)
+		if (zram->compressed_wb)
 			err = read_from_zspool_raw(zram, req->page, index);
 		else
 			err = read_from_zspool(zram, req->page, index);
@@ -1429,7 +1429,7 @@ static void zram_async_read_endio(struct bio *bio)
 	 *
 	 * Keep the existing behavior for now.
 	 */
-	if (zram->wb_compressed == false) {
+	if (zram->compressed_wb == false) {
 		/* No decompression needed, complete the parent IO */
 		bio_endio(req->parent);
 		bio_put(bio);
@@ -1508,7 +1508,7 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page, u32 index,
 	flush_work(&req.work);
 	destroy_work_on_stack(&req.work);
 
-	if (req.error || zram->wb_compressed == false)
+	if (req.error || zram->compressed_wb == false)
 		return req.error;
 
 	return decompress_bdev_page(zram, page, index);
@@ -2982,7 +2982,7 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(writeback_batch_size);
-static DEVICE_ATTR_RW(writeback_compressed);
+static DEVICE_ATTR_RW(compressed_writeback);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -3006,7 +3006,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
 	&dev_attr_writeback_batch_size.attr,
-	&dev_attr_writeback_compressed.attr,
+	&dev_attr_compressed_writeback.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -3066,7 +3066,7 @@ static int zram_add(void)
 	init_rwsem(&zram->dev_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_batch_size = 32;
-	zram->wb_compressed = false;
+	zram->compressed_wb = false;
 #endif
 
 	/* gendisk structure */
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 453e27ea4525..08d1774c15db 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
 	bool wb_limit_enable;
-	bool wb_compressed;
+	bool compressed_wb;
 	u32 wb_batch_size;
 	u64 bd_wb_limit;
 	struct block_device *bdev;
-- 
2.53.0.473.g4a7958ca14-goog

