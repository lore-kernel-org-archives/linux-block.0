Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF72DE1F0
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253193; cv=none; b=FYlmWg9cUtDIedExg+ssiZ0hl5nGrCThgIFKZKhltrl5Q6IIXeU5II9uVDPVj+Myg09VeHrSrkdlm0H4996xKWS/eRSaVvq2h3ipp3a6oXSVPeDj0MKQ+mfpJtaWPxH3aprtGnLDiZ6GTFHgwf6s7lR4OTf6E4KCl6+dbNtL/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253193; c=relaxed/simple;
	bh=bYrHSQVYNOUayEsJLSoaaBxt1LOaJZAAWeKboOTC6bo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ikz4dqhV1KgqUkp3sdfzAjOO4BPsJlZhj2Fkt3bxStV431c+O0IkdbO+GfPtX8Syi822xVIgcKdJLVR0EKtrEXOvv5lvzCZjES4eH9QDVq+mJS2z6NoIO6ayfF8hmLvlv7ZqmgylqlDyrb27CHfynXh0Uhjcg9to5sByHZrhA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyZqYVDI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyZqYVDI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so93076025ad.0
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750253191; x=1750857991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7GJ0CAsHPIqX2Owo4ue8T4Rk2EdRyqQpbzciyT4MnQ=;
        b=gyZqYVDI8Me000aaCp+GRlcpS7djYSStNdXAMJx0qC44IyhG1KQPYAWcMRpxVikybg
         Pq5F/vhxpZ+6svN1yLmxx0dchubzwHn0XCzcYA8SimyfEk5HWAFkBlXmeIXzlvUnFE4y
         sHj/NSDw/Q5cT0FTLkGl2183RiHILyNGMiA31vYv8w1MhTzdozYqLqO5gnPjEsjc2tku
         V6bSzupdIMkxXnPwPIImZpOpPDu7VVL09ZYHN0g6uYxYFPmxSbo4MYCNZrxjVSGUiPB4
         DPMRpJvC2gr7Rpi15/wFqw/DBI5Z/UHYCJNqbl0K6NsXDfGH1zWURMOJNrEeubAWHFPu
         K8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253191; x=1750857991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7GJ0CAsHPIqX2Owo4ue8T4Rk2EdRyqQpbzciyT4MnQ=;
        b=vBkVA4A2tbAOIoeNxLpDwbAnmUoIsM821rnT0uQSnT7k3UDhN8kQaCwAlHF9vQekPB
         AO14svc9fktyZK5NR2WBbJisMPq5BOy4wEMjAiXtTFormNJet4vds0Yu/WpO58ACRv+R
         /rk2F6U/hmdo+j7hXg7G1/b6ja6pHQlD35im81GWRuDifha3HCPKmqygSr7mwL/ZNdpW
         HAYrRKmGjC2SvBjUxp3giahYh2oRxoGsa3UM/aKTMshQj0NdoWXYYglJfvVmD5xqrJKA
         6a8upotg6gnUZ7ceTJFKisUvWKfHAL8xWPYc4a9MfdlgW0sfz674Xw4ktcpICnj1TRnb
         MIQw==
X-Forwarded-Encrypted: i=1; AJvYcCUmYumJpVHBL7ld95bIzUUwjRLNRiRyjqbupLctsQNO16y1ag2HqX9hLg/PEj7SPVyk0GZbgpJ+bzWo2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJui+AscHv8HRzmSH+CQhxubKHnk75raClnjFVEQGvxcA4BuqT
	xOTg+9oZ++suz3OJDxTk3VXm6LqsDHZYO4WB2CiXcINj8WDcSeNp2grxV2Aw3RlO65dcTPsnUSZ
	By3mhI5uFlDZb6dDjwkEw
X-Google-Smtp-Source: AGHT+IEMboGn3F8NlMbfTFMekCEuRM6W/hQZqKmJzSmEZMuOhl9cMu8YBKUPk2+WBPekkrBULauJt3S7ZAY9MgVG
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:311:a4ee:7c3d])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:760f:b0:236:6f5f:cac1 with SMTP id d9443c01a7336-2366f5fcea1mr169653105ad.46.1750253190946;
 Wed, 18 Jun 2025 06:26:30 -0700 (PDT)
Date: Wed, 18 Jun 2025 13:26:22 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618132622.3730219-1-richardycc@google.com>
Subject: [PATCH] zram: support asynchronous writeback
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit introduces asynchronous writeback to zram, improving the
idle writeback speed.

Key changes include:

* Replacing `submit_bio_wait()` with `submit_bio()` to enable
  non-blocking writeback operations.
* Utilizing a dedicated kthread for post-writeback tasks, avoiding
  potential lock contention in interrupt context.
* Refactoring writeback-related code into a separate file `zram_wb.c`,
  for better organization and maintainability.

Signed-off-by: Richard Chang <richardycc@google.com>
---
 drivers/block/zram/Makefile   |   1 +
 drivers/block/zram/zram_drv.c | 142 ++++++++--------------
 drivers/block/zram/zram_drv.h |  37 ++++++
 drivers/block/zram/zram_wb.c  | 222 ++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_wb.h  |  41 +++++++
 5 files changed, 353 insertions(+), 90 deletions(-)
 create mode 100644 drivers/block/zram/zram_wb.c
 create mode 100644 drivers/block/zram/zram_wb.h

diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..31ee1ed34e17 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -8,5 +8,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
 zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o
+zram-$(CONFIG_ZRAM_WRITEBACK)		+= zram_wb.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 54c57103715f..1cdebff13049 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -36,6 +36,7 @@
 #include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
+#include "zram_wb.h"
 
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
@@ -56,7 +57,6 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
-static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
@@ -95,7 +95,7 @@ static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
 	return false;
 }
 
-static void zram_slot_lock(struct zram *zram, u32 index)
+void zram_slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].flags;
 
@@ -104,7 +104,7 @@ static void zram_slot_lock(struct zram *zram, u32 index)
 	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
 }
 
-static void zram_slot_unlock(struct zram *zram, u32 index)
+void zram_slot_unlock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].flags;
 
@@ -127,19 +127,17 @@ static unsigned long zram_get_handle(struct zram *zram, u32 index)
 	return zram->table[index].handle;
 }
 
-static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
+void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 {
 	zram->table[index].handle = handle;
 }
 
-static bool zram_test_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags flag)
 {
 	return zram->table[index].flags & BIT(flag);
 }
 
-static void zram_set_flag(struct zram *zram, u32 index,
-			enum zram_pageflags flag)
+void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags flag)
 {
 	zram->table[index].flags |= BIT(flag);
 }
@@ -233,22 +231,6 @@ static void zram_accessed(struct zram *zram, u32 index)
 }
 
 #if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
-struct zram_pp_slot {
-	unsigned long		index;
-	struct list_head	entry;
-};
-
-/*
- * A post-processing bucket is, essentially, a size class, this defines
- * the range (in bytes) of pp-slots sizes in particular bucket.
- */
-#define PP_BUCKET_SIZE_RANGE	64
-#define NUM_PP_BUCKETS		((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
-
-struct zram_pp_ctl {
-	struct list_head	pp_buckets[NUM_PP_BUCKETS];
-};
-
 static struct zram_pp_ctl *init_pp_ctl(void)
 {
 	struct zram_pp_ctl *ctl;
@@ -258,15 +240,20 @@ static struct zram_pp_ctl *init_pp_ctl(void)
 	if (!ctl)
 		return NULL;
 
+	init_completion(&ctl->all_done);
+	atomic_set(&ctl->num_pp_slots, 0);
 	for (idx = 0; idx < NUM_PP_BUCKETS; idx++)
 		INIT_LIST_HEAD(&ctl->pp_buckets[idx]);
 	return ctl;
 }
 
-static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+static void remove_pp_slot_from_ctl(struct zram_pp_slot *pps)
 {
 	list_del_init(&pps->entry);
+}
 
+void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+{
 	zram_slot_lock(zram, pps->index);
 	zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
 	zram_slot_unlock(zram, pps->index);
@@ -274,7 +261,13 @@ static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
 	kfree(pps);
 }
 
-static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
+static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
+{
+	remove_pp_slot_from_ctl(pps);
+	free_pp_slot(zram, pps);
+}
+
+void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
 {
 	u32 idx;
 
@@ -312,6 +305,7 @@ static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
 	list_add(&pps->entry, &ctl->pp_buckets[bid]);
 
 	zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
+	atomic_inc(&ctl->num_pp_slots);
 	return true;
 }
 
@@ -713,7 +707,7 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 	return blk_idx;
 }
 
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
 	int was_set;
 
@@ -737,18 +731,18 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 {
 	unsigned long blk_idx = 0;
-	struct page *page = NULL;
 	struct zram_pp_slot *pps;
-	struct bio_vec bio_vec;
-	struct bio bio;
-	int ret = 0, err;
+	int ret = 0;
 	u32 index;
+	int nr_pps = atomic_read(&ctl->num_pp_slots);
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	if (!nr_pps)
+		return 0;
 
 	while ((pps = select_pp_slot(ctl))) {
+		struct zram_wb_request *req;
+		struct page *page;
+
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
 			spin_unlock(&zram->wb_limit_lock);
@@ -765,6 +759,13 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			}
 		}
 
+		req = alloc_wb_request(zram, pps, ctl, blk_idx);
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			break;
+		}
+		page = bio_first_page_all(req->bio);
+
 		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
@@ -779,63 +780,28 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
-		 */
-		err = submit_bio_wait(&bio);
-		if (err) {
-			release_pp_slot(zram, pps);
-			/*
-			 * BIO errors are not fatal, we continue and simply
-			 * attempt to writeback the remaining objects (pages).
-			 * At the same time we need to signal user-space that
-			 * some writes (at least one, but also could be all of
-			 * them) were not successful and we do so by returning
-			 * the most recent BIO error.
-			 */
-			ret = err;
-			continue;
-		}
-
-		atomic64_inc(&zram->stats.bd_writes);
-		zram_slot_lock(zram, index);
-		/*
-		 * Same as above, we release slot lock during writeback so
-		 * slot can change under us: slot_free() or slot_free() and
-		 * reallocation (zram_write_page()). In both cases slot loses
-		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
-		 * ZRAM_PP_SLOT on such slots until current post-processing
-		 * finishes.
-		 */
-		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
-
-		zram_free_page(zram, index);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_handle(zram, index, blk_idx);
+		nr_pps--;
+		remove_pp_slot_from_ctl(pps);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		submit_bio(req->bio);
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
+		free_wb_request(req);
 
 		cond_resched();
 	}
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+
+	if (nr_pps && atomic_sub_and_test(nr_pps, &ctl->num_pp_slots))
+		complete(&ctl->all_done);
+
+	/* wait until all async bios completed */
+	wait_for_completion(&ctl->all_done);
 
 	return ret;
 }
@@ -1111,8 +1077,6 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 {
 	return -EIO;
 }
-
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
@@ -1620,7 +1584,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void zram_free_page(struct zram *zram, size_t index)
+void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
@@ -2247,12 +2211,6 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
 	ctl = init_pp_ctl();
 	if (!ctl) {
 		ret = -ENOMEM;
@@ -2912,6 +2870,9 @@ static int __init zram_init(void)
 		num_devices--;
 	}
 
+	if (setup_zram_writeback())
+		goto out_error;
+
 	return 0;
 
 out_error:
@@ -2921,6 +2882,7 @@ static int __init zram_init(void)
 
 static void __exit zram_exit(void)
 {
+	destroy_zram_writeback();
 	destroy_devices();
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..7d9081215668 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -139,4 +139,41 @@ struct zram {
 #endif
 	atomic_t pp_in_progress;
 };
+
+void zram_slot_lock(struct zram *zram, u32 index);
+void zram_slot_unlock(struct zram *zram, u32 index);
+void zram_set_handle(struct zram *zram, u32 index, unsigned long handle);
+bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags flag);
+void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags flag);
+void zram_free_page(struct zram *zram, size_t index);
+
+#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
+struct zram_pp_slot {
+	unsigned long		index;
+	struct list_head	entry;
+};
+
+/*
+ * A post-processing bucket is, essentially, a size class, this defines
+ * the range (in bytes) of pp-slots sizes in particular bucket.
+ */
+#define PP_BUCKET_SIZE_RANGE	64
+#define NUM_PP_BUCKETS		((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
+
+struct zram_pp_ctl {
+	struct list_head	pp_buckets[NUM_PP_BUCKETS];
+	struct completion	all_done;
+	atomic_t		num_pp_slots;
+};
+
+void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps);
+void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl);
+#endif
+
+#if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
+void free_block_bdev(struct zram *zram, unsigned long blk_idx);
+#else
+inline void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
+#endif
+
 #endif
diff --git a/drivers/block/zram/zram_wb.c b/drivers/block/zram/zram_wb.c
new file mode 100644
index 000000000000..59f93b22d2bf
--- /dev/null
+++ b/drivers/block/zram/zram_wb.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define KMSG_COMPONENT "zram_wb"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/freezer.h>
+
+#include "zram_wb.h"
+
+static struct task_struct *wb_thread;
+static DECLARE_WAIT_QUEUE_HEAD(wb_wq);
+static struct zram_wb_request_list wb_req_list;
+
+static void complete_wb_request(struct zram_wb_request *req)
+{
+	struct zram *zram = req->zram;
+	struct zram_pp_slot *pps = req->pps;
+	struct zram_pp_ctl *ctl = req->ppctl;
+	unsigned long index = pps->index;
+	unsigned long blk_idx = req->blk_idx;
+	struct bio *bio = req->bio;
+
+	if (bio->bi_status)
+		goto out_err;
+
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+
+	/*
+	 * Same as above, we release slot lock during writeback so
+	 * slot can change under us: slot_free() or slot_free() and
+	 * reallocation (zram_write_page()). In both cases slot loses
+	 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
+	 * ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
+		zram_slot_unlock(zram, index);
+		goto out_err;
+	}
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+	zram_slot_unlock(zram, index);
+	goto end;
+
+out_err:
+	free_block_bdev(zram, blk_idx);
+end:
+	free_pp_slot(zram, pps);
+	free_wb_request(req);
+
+	if (atomic_dec_and_test(&ctl->num_pp_slots))
+		complete(&ctl->all_done);
+}
+
+static void enqueue_wb_request(struct zram_wb_request_list *req_list,
+			       struct zram_wb_request *req)
+{
+	/*
+	 * The enqueue path comes from softirq context:
+	 * blk_done_softirq -> bio_endio -> zram_writeback_end_io
+	 * Use spin_lock_bh for locking.
+	 */
+	spin_lock_bh(&req_list->lock);
+	list_add_tail(&req->node, &req_list->head);
+	req_list->count++;
+	spin_unlock_bh(&req_list->lock);
+}
+
+static struct zram_wb_request *dequeue_wb_request(
+	struct zram_wb_request_list *req_list)
+{
+	struct zram_wb_request *req = NULL;
+
+	spin_lock_bh(&req_list->lock);
+	if (!list_empty(&req_list->head)) {
+		req = list_first_entry(&req_list->head,
+				       struct zram_wb_request,
+				       node);
+		list_del(&req->node);
+		req_list->count--;
+	}
+	spin_unlock_bh(&req_list->lock);
+
+	return req;
+}
+
+static void destroy_wb_request_list(struct zram_wb_request_list *req_list)
+{
+	struct zram_wb_request *req;
+
+	while (!list_empty(&req_list->head)) {
+		req = dequeue_wb_request(req_list);
+		free_block_bdev(req->zram, req->blk_idx);
+		free_wb_request(req);
+	}
+}
+
+static bool wb_ready_to_run(void)
+{
+	int count;
+
+	spin_lock_bh(&wb_req_list.lock);
+	count = wb_req_list.count;
+	spin_unlock_bh(&wb_req_list.lock);
+
+	return count > 0;
+}
+
+static int wb_thread_func(void *data)
+{
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		wait_event_freezable(wb_wq, wb_ready_to_run());
+
+		while (1) {
+			struct zram_wb_request *req;
+
+			req = dequeue_wb_request(&wb_req_list);
+			if (!req)
+				break;
+			complete_wb_request(req);
+		}
+	}
+	return 0;
+}
+
+void zram_writeback_end_io(struct bio *bio)
+{
+	struct zram_wb_request *req =
+		(struct zram_wb_request *)bio->bi_private;
+
+	enqueue_wb_request(&wb_req_list, req);
+	wake_up(&wb_wq);
+}
+
+struct zram_wb_request *alloc_wb_request(struct zram *zram,
+					 struct zram_pp_slot *pps,
+					 struct zram_pp_ctl *ppctl,
+					 unsigned long blk_idx)
+{
+	struct zram_wb_request *req;
+	struct page *page;
+	struct bio *bio;
+	int err = 0;
+
+	page = alloc_page(GFP_NOIO | __GFP_NOWARN);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	bio = bio_alloc(zram->bdev, 1, REQ_OP_WRITE, GFP_NOIO | __GFP_NOWARN);
+	if (!bio) {
+		err = -ENOMEM;
+		goto out_free_page;
+	}
+
+	req = kmalloc(sizeof(struct zram_wb_request), GFP_NOIO | __GFP_NOWARN);
+	if (!req) {
+		err = -ENOMEM;
+		goto out_free_bio;
+	}
+	req->zram = zram;
+	req->pps = pps;
+	req->ppctl = ppctl;
+	req->blk_idx = blk_idx;
+	req->bio = bio;
+
+	bio->bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+	__bio_add_page(bio, page, PAGE_SIZE, 0);
+	bio->bi_private = req;
+	bio->bi_end_io = zram_writeback_end_io;
+	return req;
+
+out_free_bio:
+	bio_put(bio);
+out_free_page:
+	__free_page(page);
+	return ERR_PTR(err);
+}
+
+void free_wb_request(struct zram_wb_request *req)
+{
+	struct bio *bio = req->bio;
+	struct page *page = bio_first_page_all(bio);
+
+	__free_page(page);
+	bio_put(bio);
+	kfree(req);
+}
+
+int setup_zram_writeback(void)
+{
+	spin_lock_init(&wb_req_list.lock);
+	INIT_LIST_HEAD(&wb_req_list.head);
+	wb_req_list.count = 0;
+
+	wb_thread = kthread_run(wb_thread_func, NULL, "zram_wb_thread");
+	if (IS_ERR(wb_thread)) {
+		pr_err("Unable to create zram_wb_thread\n");
+		return -1;
+	}
+	return 0;
+}
+
+void destroy_zram_writeback(void)
+{
+	kthread_stop(wb_thread);
+	destroy_wb_request_list(&wb_req_list);
+}
+
diff --git a/drivers/block/zram/zram_wb.h b/drivers/block/zram/zram_wb.h
new file mode 100644
index 000000000000..e029b4de0de6
--- /dev/null
+++ b/drivers/block/zram/zram_wb.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ZRAM_WRITEBACK_H_
+#define _ZRAM_WRITEBACK_H_
+
+#include <linux/bio.h>
+#include "zram_drv.h"
+
+struct zram_wb_request;
+
+struct zram_wb_request {
+	struct zram *zram;
+	unsigned long blk_idx;
+	struct zram_pp_slot *pps;
+	struct zram_pp_ctl *ppctl;
+	struct bio *bio;
+	struct list_head node;
+};
+
+struct zram_wb_request_list {
+	struct list_head head;
+	int count;
+	spinlock_t lock;
+};
+
+#if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
+void zram_writeback_end_io(struct bio *bio);
+int setup_zram_writeback(void);
+void destroy_zram_writeback(void);
+struct zram_wb_request *alloc_wb_request(struct zram *zram,
+					 struct zram_pp_slot *pps,
+					 struct zram_pp_ctl *ppctl,
+					 unsigned long blk_idx);
+void free_wb_request(struct zram_wb_request *req);
+#else
+inline void zram_writeback_end_io(struct bio *bio) {}
+inline int setup_zram_writeback(void) { return 0; }
+inline void destroy_zram_writeback(void) {}
+#endif
+
+#endif /* _ZRAM_WRITEBACK_H_ */
-- 
2.50.0.rc2.696.g1fc2a0284f-goog

