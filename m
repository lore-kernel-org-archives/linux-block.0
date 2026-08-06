Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F91A9FBA
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986210; cv=none; b=oT3bG4VVRDv+KdOZCDILCZKXOomBNotLJA0A5SGVPkm0xK8qmOSbKszNIQwDpZ95Za21ogBNFvHbQymlitLguWeqJ0dBG55zOzrxWV4pmUDgyZvIGs3pbDHMhMWmrY956WD2n/YP7QK8IytDx6xADsrCN/3NqKgQBMxq+dmCtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986210; c=relaxed/simple;
	bh=RF7iVdvejG0KIkTleZoHOTi63b55T799Z7z64kHVEXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+mp1vB2stCUsmRoMicGvWsgrYkcrmh01k+fQUe47vN+7eXA5cAqHR/9BGLMUiUAu8AEWEm4sEtlTQWWBb/iKWxSrwWPDvGLCUKgJTlphtX+GaHbWkzs0quVSX51xjp4jcNLMDLXABh9LnIdv/TSS35HrBHhjnLG74U1b1i36kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TO5MpKGs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO5MpKGs"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487088510aso2282676b3a.0
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785986207; x=1786591007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQKutsuyXmC3mcIgGGyZh8v3K7WcGuLFo1jhwq9sGxU=;
        b=TO5MpKGs187q5TfXt2fBUgtJnO9s6V3oSMqhC+nqFgK6Jbe3PJ44/Tyi+TNMOnQ4DE
         nDtWCIEvyToDbGHRgNVSCzZ1bGafba+HRy1vuhdnzKPfHZac9/K2pL+DfQSPsnwe78dz
         0eO+qUJ/wLel7YIjhyF3/P+Jb/jVNX/bayhDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785986207; x=1786591007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQKutsuyXmC3mcIgGGyZh8v3K7WcGuLFo1jhwq9sGxU=;
        b=Gplj9z3rX43s6ILFG0S7SpJKtAlxWSK7Xzm+ic2TB4Ja4GASnszPL+iN0oGCFSjUUf
         fxcPHdwaRXaOSUBnJY5GGWuyy4vYHHFGxAnYCGXDI+/HPkD4bS/oE0fZVfYHmKZrw7pk
         mTheezSIRwau9v8HhCdAu7ge5eq5JJqYN1bvRMY+1RZZ6HML4r1cHUPhUN3YzJcWptLM
         Dp9wVPBLKcyr6XXPaZZ1F+r8r0RflOrZfd+Tq/XvS3xPBeyYnAAUbWNCDUeqnDJkd+Um
         36K9L/P+3OQPT2Vo5i6l3evL6YUomp/viMDYMsdPGmj5YsNgjHRFPImEmbkEGXi1YEnu
         1MBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIJ7XH9U3rBzrweiuuznUhMDqUlS0m3L1oFcbFeoU7SxopbGcZ2EzdQVTStZ9cVax8ZnMFf25JSE/1zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvs3kR9zcAIahnV1r4IOT0KjNFAiURcPhlgA5npchKXhdqRE9Y
	EGu4PR8hEyK93U/BbWkxti5uSHpKFlaMmVJgCOXpV8cHvJEqKtOnDl738/BPlJpp8R5LfnTgHpu
	EBi8=
X-Gm-Gg: AR+sD13Q6JYY1eqC29Vh2SLEieJ/jbSVWiATBOVXXWXmwpcceJdfWF9mBIGLwxVZT1M
	b27ShxBdSeJTqkH9jcttJbUy4qnhwwaTlATLgfHt6po4tR26BS6ZAh9l5pSTjX3LPoqfnfu37v4
	JPb6Aeg6VyJCkP10RlGw4phOGO3vycZMa17z0Z73CI+mfs0fDTR577X1tMLEk/ijsneuMUXSNyd
	bA3+A+iSVZPnepjyCtjHtokXOXmBBLZbCS31IuCC2xo5FLcQgbd9aSYc7yH1anl3ESvto4PIp+b
	14fqefQZycgwtgK+NQ4Unr1Edi5YsqQTuuT7mVo5p2huPmTkv7UGGXNQJsWbW11IPGiQcnfSHrR
	HEEGqZVeWOhwtkcM+rxRqPNNWHHio9JhdrVlQfS9BWvQ101KT6npVmx4EaH33p0q/5opRtMOAnd
	ZODq9TB82/HXPEyx3hFc490YtfRV/aOU+Ihd+M1ByCczxPVbOUyX3xswK4nsUYd1O1gxOJFanel
	cGNPcAeoA1GjaZtMDnodp/7uP83+YW6Ev9Z/FB1iT9iy/zO4Qrs
X-Received: by 2002:a05:6a00:94e7:b0:848:3f91:da82 with SMTP id d2e1a72fcca58-84f2e12c1fcmr13358442b3a.32.1785986207378;
        Wed, 05 Aug 2026 20:16:47 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9facsm373901b3a.60.2026.08.05.20.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 20:16:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Longlong Xia <xialonglong2025@163.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: switch to unsigned long indexing
Date: Thu,  6 Aug 2026 12:16:32 +0900
Message-ID: <20260806031640.536615-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram has always used "unsigned int" for (page) index calculations,
which unnecessarily limited max zram disksize.

Switch to "unsigned long" and permit much larger zram devices.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Longlong Xia <xialonglong2025@163.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 137 +++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56183c827e1b..6af977dbc6fd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -56,7 +56,7 @@ static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
 
-static void slot_free(struct zram *zram, u32 index);
+static void slot_free(struct zram *zram, unsigned long index);
 
 /*
  * entry locking rules:
@@ -70,7 +70,7 @@ static void slot_free(struct zram *zram, u32 index);
  * 4) Use TRY lock variant when in atomic context
  *    - must check return value and handle locking failers
  */
-static __must_check bool slot_trylock(struct zram *zram, u32 index)
+static __must_check bool slot_trylock(struct zram *zram, unsigned long index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
@@ -83,7 +83,7 @@ static __must_check bool slot_trylock(struct zram *zram, u32 index)
 	return false;
 }
 
-static void slot_lock(struct zram *zram, u32 index)
+static void slot_lock(struct zram *zram, unsigned long index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
@@ -92,7 +92,7 @@ static void slot_lock(struct zram *zram, u32 index)
 	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
 
-static void slot_unlock(struct zram *zram, u32 index)
+static void slot_unlock(struct zram *zram, unsigned long index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
@@ -110,55 +110,56 @@ static inline struct zram *dev_to_zram(struct device *dev)
 	return (struct zram *)dev_to_disk(dev)->private_data;
 }
 
-static unsigned long get_slot_handle(struct zram *zram, u32 index)
+static unsigned long get_slot_handle(struct zram *zram, unsigned long index)
 {
 	return zram->table[index].handle;
 }
 
-static void set_slot_handle(struct zram *zram, u32 index, unsigned long handle)
+static void set_slot_handle(struct zram *zram, unsigned long index,
+			    unsigned long handle)
 {
 	zram->table[index].handle = handle;
 }
 
-static bool test_slot_flag(struct zram *zram, u32 index,
+static bool test_slot_flag(struct zram *zram, unsigned long index,
 			   enum zram_pageflags flag)
 {
 	return zram->table[index].attr.flags & BIT(flag);
 }
 
-static void set_slot_flag(struct zram *zram, u32 index,
+static void set_slot_flag(struct zram *zram, unsigned long index,
 			  enum zram_pageflags flag)
 {
 	zram->table[index].attr.flags |= BIT(flag);
 }
 
-static void clear_slot_flag(struct zram *zram, u32 index,
+static void clear_slot_flag(struct zram *zram, unsigned long index,
 			    enum zram_pageflags flag)
 {
 	zram->table[index].attr.flags &= ~BIT(flag);
 }
 
-static size_t get_slot_size(struct zram *zram, u32 index)
+static size_t get_slot_size(struct zram *zram, unsigned long index)
 {
 	return zram->table[index].attr.flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
 }
 
-static void set_slot_size(struct zram *zram, u32 index, size_t size)
+static void set_slot_size(struct zram *zram, unsigned long index, size_t size)
 {
 	unsigned long flags = zram->table[index].attr.flags >> ZRAM_FLAG_SHIFT;
 
 	zram->table[index].attr.flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
-static inline bool slot_allocated(struct zram *zram, u32 index)
+static inline bool slot_allocated(struct zram *zram, unsigned long index)
 {
 	return get_slot_size(zram, index) ||
 		test_slot_flag(zram, index, ZRAM_SAME) ||
 		test_slot_flag(zram, index, ZRAM_WB);
 }
 
-static inline void set_slot_comp_priority(struct zram *zram, u32 index,
-					  u32 prio)
+static inline void set_slot_comp_priority(struct zram *zram,
+					  unsigned long index, u32 prio)
 {
 	prio &= ZRAM_COMP_PRIORITY_MASK;
 	/*
@@ -170,14 +171,14 @@ static inline void set_slot_comp_priority(struct zram *zram, u32 index,
 	zram->table[index].attr.flags |= (prio << ZRAM_COMP_PRIORITY_BIT1);
 }
 
-static inline u32 get_slot_comp_priority(struct zram *zram, u32 index)
+static inline u32 get_slot_comp_priority(struct zram *zram, unsigned long index)
 {
 	u32 prio = zram->table[index].attr.flags >> ZRAM_COMP_PRIORITY_BIT1;
 
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
-static void mark_slot_accessed(struct zram *zram, u32 index)
+static void mark_slot_accessed(struct zram *zram, unsigned long index)
 {
 	clear_slot_flag(zram, index, ZRAM_IDLE);
 	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
@@ -284,7 +285,7 @@ static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
 }
 
 static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
-			  u32 index)
+			  unsigned long index)
 {
 	struct zram_pp_slot *pps;
 	u32 bid;
@@ -418,7 +419,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 {
 	int is_idle = 1;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	int index;
+	unsigned long index;
 
 	for (index = 0; index < nr_pages; index++) {
 		/*
@@ -485,8 +486,9 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 #define INVALID_BDEV_BLOCK		(~0UL)
 
 static int read_from_zspool_raw(struct zram *zram, struct page *page,
-				u32 index);
-static int read_from_zspool(struct zram *zram, struct page *page, u32 index);
+				unsigned long index);
+static int read_from_zspool(struct zram *zram, struct page *page,
+			    unsigned long index);
 
 struct zram_wb_ctl {
 	/* idle list is accessed only by the writeback task, no concurency */
@@ -522,7 +524,7 @@ struct zram_rb_req {
 		/* error status (sync read) */
 		int error;
 	};
-	u32 index;
+	unsigned long index;
 };
 
 #define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
@@ -910,7 +912,7 @@ static void zram_account_writeback_submit(struct zram *zram)
 
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 {
-	u32 index = req->pps->index;
+	unsigned long index = req->pps->index;
 	int err;
 
 	err = blk_status_to_errno(req->bio.bi_status);
@@ -1032,7 +1034,7 @@ static int zram_writeback_slots(struct zram *zram,
 	struct zram_wb_req *req = NULL;
 	struct zram_pp_slot *pps;
 	int ret = 0, err = 0;
-	u32 index = 0;
+	unsigned long index = 0;
 
 	while ((pps = select_pp_slot(ctl))) {
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
@@ -1198,7 +1200,7 @@ static void scan_slots_for_writeback(struct zram *zram, u32 mode,
 				     unsigned long lo, unsigned long hi,
 				     struct zram_pp_ctl *ctl)
 {
-	u32 index = lo;
+	unsigned long index = lo;
 
 	while (index < hi) {
 		bool ok = true;
@@ -1235,7 +1237,7 @@ static ssize_t writeback_store(struct device *dev,
 			       const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
 	struct zram_pp_ctl *pp_ctl = NULL;
 	struct zram_wb_ctl *wb_ctl = NULL;
@@ -1333,7 +1335,8 @@ static ssize_t writeback_store(struct device *dev,
 	return ret;
 }
 
-static int decompress_bdev_page(struct zram *zram, struct page *page, u32 index)
+static int decompress_bdev_page(struct zram *zram, struct page *page,
+				unsigned long index)
 {
 	struct zcomp_strm *zstrm;
 	unsigned int size;
@@ -1375,7 +1378,7 @@ static void zram_deferred_decompress(struct work_struct *w)
 	struct zram_rb_req *req = container_of(w, struct zram_rb_req, work);
 	struct page *page = bio_first_page_all(req->bio);
 	struct zram *zram = req->zram;
-	u32 index = req->index;
+	unsigned long index = req->index;
 	int ret;
 
 	ret = decompress_bdev_page(zram, page, index);
@@ -1426,7 +1429,7 @@ static void zram_async_read_endio(struct bio *bio)
 }
 
 static int read_from_bdev_async(struct zram *zram, struct page *page,
-				u32 index, unsigned long blk_idx,
+				unsigned long index, unsigned long blk_idx,
 				struct bio *parent)
 {
 	struct zram_rb_req *req;
@@ -1476,8 +1479,8 @@ static void zram_sync_read(struct work_struct *w)
  * chained IO with parent IO in same context, it's a deadlock. To avoid that,
  * use a worker thread context.
  */
-static int read_from_bdev_sync(struct zram *zram, struct page *page, u32 index,
-			       unsigned long blk_idx)
+static int read_from_bdev_sync(struct zram *zram, struct page *page,
+			       unsigned long index, unsigned long blk_idx)
 {
 	struct zram_rb_req req;
 
@@ -1496,8 +1499,9 @@ static int read_from_bdev_sync(struct zram *zram, struct page *page, u32 index,
 	return decompress_bdev_page(zram, page, index);
 }
 
-static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
-			  unsigned long blk_idx, struct bio *parent)
+static int read_from_bdev(struct zram *zram, struct page *page,
+			  unsigned long index, unsigned long blk_idx,
+			  struct bio *parent)
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (!parent) {
@@ -1509,8 +1513,9 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
 }
 #else
 static inline void reset_bdev(struct zram *zram) {};
-static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
-			  unsigned long blk_idx, struct bio *parent)
+static int read_from_bdev(struct zram *zram, struct page *page,
+			  unsigned long index, unsigned long blk_idx,
+			  struct bio *parent)
 {
 	return -EIO;
 }
@@ -1538,7 +1543,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	char *kbuf;
-	ssize_t index, written = 0;
+	unsigned long index;
+	ssize_t written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 
@@ -1560,7 +1566,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 			goto next;
 
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12u.%06d %c%c%c%c%c%c\n",
+			"%12lu %12u.%06d %c%c%c%c%c%c\n",
 			index, zram->table[index].attr.ac_time, 0,
 			test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
@@ -1967,8 +1973,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
-	size_t num_pages = disksize >> PAGE_SHIFT;
-	size_t index;
+	unsigned long num_pages = disksize >> PAGE_SHIFT;
+	unsigned long index;
 
 	if (!zram->table)
 		return;
@@ -1985,7 +1991,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
-	size_t num_pages;
+	unsigned long num_pages;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -2008,7 +2014,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	return true;
 }
 
-static void slot_free(struct zram *zram, u32 index)
+static void slot_free(struct zram *zram, unsigned long index)
 {
 	unsigned long handle;
 
@@ -2062,7 +2068,7 @@ static void slot_free(struct zram *zram, u32 index)
 }
 
 static int read_same_filled_page(struct zram *zram, struct page *page,
-				 u32 index)
+				 unsigned long index)
 {
 	void *mem;
 
@@ -2073,7 +2079,7 @@ static int read_same_filled_page(struct zram *zram, struct page *page,
 }
 
 static int read_incompressible_page(struct zram *zram, struct page *page,
-				    u32 index)
+				    unsigned long index)
 {
 	unsigned long handle;
 	void *src, *dst;
@@ -2088,7 +2094,8 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
-static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
+static int read_compressed_page(struct zram *zram, struct page *page,
+				unsigned long index)
 {
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
@@ -2113,7 +2120,8 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 }
 
 #if defined CONFIG_ZRAM_WRITEBACK
-static int read_from_zspool_raw(struct zram *zram, struct page *page, u32 index)
+static int read_from_zspool_raw(struct zram *zram, struct page *page,
+				unsigned long index)
 {
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
@@ -2145,7 +2153,8 @@ static int read_from_zspool_raw(struct zram *zram, struct page *page, u32 index)
  * Reads (decompresses if needed) a page from zspool (zsmalloc).
  * Corresponding ZRAM slot should be locked.
  */
-static int read_from_zspool(struct zram *zram, struct page *page, u32 index)
+static int read_from_zspool(struct zram *zram, struct page *page,
+			    unsigned long index)
 {
 	if (test_slot_flag(zram, index, ZRAM_SAME) ||
 	    !get_slot_handle(zram, index))
@@ -2157,8 +2166,8 @@ static int read_from_zspool(struct zram *zram, struct page *page, u32 index)
 		return read_incompressible_page(zram, page, index);
 }
 
-static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-			  struct bio *parent)
+static int zram_read_page(struct zram *zram, struct page *page,
+			  unsigned long index, struct bio *parent)
 {
 	int ret;
 
@@ -2180,7 +2189,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (WARN_ON(ret < 0))
-		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
+		pr_err("Decompression failed! err=%d, page=%lu\n", ret, index);
 
 	return ret;
 }
@@ -2190,7 +2199,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
  * always expects a full page for the output.
  */
 static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
-				  u32 index, int offset)
+				  unsigned long index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
@@ -2205,7 +2214,7 @@ static int zram_bvec_read_partial(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-			  u32 index, int offset, struct bio *bio)
+			  unsigned long index, int offset, struct bio *bio)
 {
 	if (is_partial_io(bvec))
 		return zram_bvec_read_partial(zram, bvec, index, offset);
@@ -2213,7 +2222,7 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int write_same_filled_page(struct zram *zram, unsigned long fill,
-				  u32 index)
+				  unsigned long index)
 {
 	slot_lock(zram, index);
 	slot_free(zram, index);
@@ -2228,7 +2237,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 }
 
 static int write_incompressible_page(struct zram *zram, struct page *page,
-				     u32 index)
+				     unsigned long index)
 {
 	unsigned long handle;
 	void *src;
@@ -2268,7 +2277,8 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	return 0;
 }
 
-static int zram_write_page(struct zram *zram, struct page *page, u32 index)
+static int zram_write_page(struct zram *zram, struct page *page,
+			   unsigned long index)
 {
 	int ret = 0;
 	unsigned long handle;
@@ -2335,7 +2345,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
  * This is a partial IO. Read the full page before writing the changes.
  */
 static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
-				   u32 index, int offset)
+				   unsigned long index, int offset)
 {
 	struct page *page = alloc_page(GFP_NOIO);
 	int ret;
@@ -2353,7 +2363,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 }
 
 static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
-			   u32 index, int offset)
+			   unsigned long index, int offset)
 {
 	if (is_partial_io(bvec))
 		return zram_bvec_write_partial(zram, bvec, index, offset);
@@ -2421,8 +2431,9 @@ static void scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
  *
  * Corresponding ZRAM slot should be locked.
  */
-static int recompress_slot(struct zram *zram, u32 index, struct page *page,
-			   u64 *num_recomp_pages, u32 threshold, u32 prio)
+static int recompress_slot(struct zram *zram, unsigned long index,
+			   struct page *page, u64 *num_recomp_pages,
+			   u32 threshold, u32 prio)
 {
 	struct zcomp_strm *zstrm = NULL;
 	unsigned long handle_old;
@@ -2674,7 +2685,7 @@ static ssize_t recompress_store(struct device *dev,
 static void zram_bio_discard(struct zram *zram, struct bio *bio)
 {
 	size_t n = bio->bi_iter.bi_size;
-	u32 index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+	unsigned long index = bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 	u32 offset = (bio->bi_iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 			SECTOR_SHIFT;
 
@@ -2715,7 +2726,7 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 	struct bvec_iter iter = bio->bi_iter;
 
 	do {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+		unsigned long index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
@@ -2746,7 +2757,7 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 	struct bvec_iter iter = bio->bi_iter;
 
 	do {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
+		unsigned long index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
 		struct bio_vec bv = bio_iter_iovec(bio, iter);
@@ -2860,6 +2871,7 @@ static void zram_reset_device(struct zram *zram)
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
+	unsigned long num_pages;
 	u64 disksize;
 	struct zcomp *comp;
 	struct zram *zram = dev_to_zram(dev);
@@ -2877,6 +2889,11 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	disksize = PAGE_ALIGN(disksize);
+	num_pages = disksize >> PAGE_SHIFT;
+	/* Slots are addressed by an unsigned long index */
+	if (!num_pages || ((u64)num_pages << PAGE_SHIFT) != disksize)
+		return -EINVAL;
+
 	if (!zram_meta_alloc(zram, disksize))
 		return -ENOMEM;
 
-- 
2.55.0.629.g250fe7f194-goog

