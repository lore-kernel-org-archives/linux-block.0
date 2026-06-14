Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F33C8733
	for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781451356; cv=none; b=QRzYl3v9GdoZKUpirpylSV+kFKJwvBqjYkgqcy66lMnkwd2rbLgX0FKLHp6wrloZW9SgffuNzU7fUyTzN1n7LVQ46OCeFL2F+698swMzFikc/lGQzuVkszOByhg2uawuaZgEFHRDbOQXFspmY34+XeXTrOt1ukFKkQJBybnxRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781451356; c=relaxed/simple;
	bh=US4ZiUEXSeqi1DqGlIK6guwPu2vW+Htiyg+pB7+1WIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTUlpX/HiuS4vdODTPEanpX1U45NWmT9A9rDbjswbxkLowrnQz3CMs9GqMLQdOXCYXfwt8sdaRNSHGAP3EN/7LSzmXg9lE0U9kSaCV8sn3vTNEMvCfUvMFImt/pYufidOofXpD+5SImfGwxH933S2zY8JgQAdSfjg3lO4a+8TDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqOD3dBN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqOD3dBN"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3075ce9c05aso6206709eec.1
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781451355; x=1782056155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/lxpqFHcXjSmMEFitPcCUnaBZzEe91eCd6YU/69bl8=;
        b=UqOD3dBN9XixHF4w1ox9KMcqTFXeDtAsROqo5CLL6Qq9/vS3IUbgDJfSg5/fa8YMua
         2OwblmwBVGtsNGzwMXzNYe7Qh7Ye6Sx2oSqUjFHV5qWGb2IwD4PFI2VC7OekgqXjUHXa
         JCjXmWFhcY5MUwsyQ8nHHHGTUvBygPwbo2inc1Qfc35hscN5T0wfk2GA75Q1UBJMyKDK
         Eu0TKen+Sh16vQMbJU0LC7zqSOW3iQJkkGXfD1E2bcoMyU1EA0d+zWW7kBeC67H6BeYc
         HzAabiyFbwddc9qHI5gta8ZdT23gpR1h1GKbaTrzHE206JcvfCE4zgSWF6ItGVljJRhy
         uF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781451355; x=1782056155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/lxpqFHcXjSmMEFitPcCUnaBZzEe91eCd6YU/69bl8=;
        b=EWMhjdQb8UZ28up98wDWMFt3pgTz2QUgdQVUHOFQyAEFEGBRKlWaM03rxeqo8ENB+D
         HEB/10FAA7zjfywJU99sfSeZAHgJfFsfkTpr9WpaTIf9v91ZAZVAQREiRG+McTpzwdRb
         iaW86GdtxYMZgfSXppeKVGFDttOJZxX88OF3gzSuCoAeWTtycIZRQCp2W6AbXOUqaKhd
         MXDtoKNdnTZYP2egs0K1A899KNe7oAMY9OYzQmP0v322OL8Qe2Inhr1z0mhAI5bezWK5
         1GfYCr+Mp/Yr4IypyTg5cRilSjUijmdZQkvii0Gc9IPyLo5lKBfvdXj8ybc9AC4W6jhC
         kpcA==
X-Forwarded-Encrypted: i=1; AFNElJ/qt8KhQaEmDYcrosN25Mtg2PTIAOuRHtwBxkRadi2vIV0QRMFl9sD5w6A+eRwrmDEAagsQlKrsZ0KU6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nlCYANH1LNU15fw4RiRFzZnuQlYTNM/jgYJrhNkZP53Bb/W9
	zzeGJRDmpwaaP4qdq38j+TbHxAI+NESDwDbLCy4+cC639U9JFWoQ3ssR
X-Gm-Gg: Acq92OHS+3U8gvJK8TJL2qugp6QHn9TEvfHoKtzqa26Ihq5nyRCtXzteVeD9SgXrQDE
	CyOTt4+rorwwsn30rBdR7dRwTHw7TywvVTdYb3kaiZVRKo6RE4bxl/DpVh0iot7OTauBIyzusbg
	9mDikNJiPNNF3UPOWxQ7vhW9+Xq3q3u33ZDtbkUeZG9Oqidio6AkXjbiLgA8h/3Y3MueAvFT2XU
	orXnLLTIw2LvYXK3UbHlB+otzZ6y5riRwa7Q0XCHKblHLTE0NM6yRW/ReI8lMYUH1SethgQZtQt
	ZhUHMotbFi5M4sfGcUdk9heyVCquWO6irKq7TBPgkgOexmVTek16EHimZ5cK2IjRl7gCLoHlIj0
	txKnIJUrIM2qhVWaPbiwuE7eblHHqDIKb1UgxpXHuhNjE7cAOnAyLfqTK6vihdk3KfM0uTMziNn
	zDvlxzDOjCVhglzFqX5em39VLlVmA8TvORDgW4HYO+OtTQkiZC5FH69FXN7WIRl5LaJ+pHIgPrT
	A==
X-Received: by 2002:a05:693c:42d1:b0:30b:5571:b412 with SMTP id 5a478bee46e88-30b5571ba3emr2033018eec.5.1781451354593;
        Sun, 14 Jun 2026 08:35:54 -0700 (PDT)
Received: from NV-J4GCB44.localdomain ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm12580632eec.7.2026.06.14.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:35:54 -0700 (PDT)
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Sun, 14 Jun 2026 23:35:31 +0800
Subject: [PATCH 3/3] mm/swap: route slot free notifications through
 swap_ops
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-zram-swap-ops-block-register-v1-3-6c1a6639c222@gmail.com>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
In-Reply-To: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jianyue Wu <wujianyue000@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1781451334; l=8570;
 i=wujianyue000@gmail.com; s=id_ed25519; h=from:subject:message-id;
 bh=US4ZiUEXSeqi1DqGlIK6guwPu2vW+Htiyg+pB7+1WIk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgW51Zh3v9nG0Wlld2Ti8ylp1TnO7yB
 H+z9CbXty/WEAQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJxbc8ZmmOMj7C6hmGDwJCnn35hWaMfWfIUsCO6R2sn9DbHTHbqqbvfKYYh9aaFZPf8vr87ppKP
 2ptsA6pliaAw=
X-Developer-Key: i=wujianyue000@gmail.com; a=openssh;
 fpr=SHA256:gVWBPJbHGWlCIw+V8F63Ff0k21S7AB5+rZt8+huemvg

Dispatch slot_free_notify through swap_ops instead of
block_device_operations. Zram keeps slot-free handling alongside its
other swap_ops methods.

Move slot_trylock into the CONFIG_SWAP block. With CONFIG_SWAP=n it
has no callers and the build fails on -Werror=unused-function.

Document the callback locking rules in include/linux/swap.h. Remove
the outdated locking.rst note for swap_slot_free_notify.

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
 Documentation/filesystems/locking.rst |  5 --
 drivers/block/zram/zram_drv.c         | 88 ++++++++++++++++++-----------------
 include/linux/blkdev.h                |  2 -
 include/linux/swap.h                  |  7 +++
 mm/swapfile.c                         | 13 ++----
 rust/kernel/block/mq/gen_disk.rs      |  1 -
 6 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 70481bdc031d..964c841bf917 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -443,7 +443,6 @@ prototypes::
 				unsigned long *);
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*getgeo)(struct gendisk *, struct hd_geometry *);
-	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 
 locking rules:
 
@@ -457,12 +456,8 @@ compat_ioctl:		no
 direct_access:		no
 unlock_native_capacity:	no
 getgeo:			no
-swap_slot_free_notify:	no	(see below)
 ======================= ===================
 
-swap_slot_free_notify is called with swap_lock and sometimes the page lock
-held.
-
 
 file_operations
 ===============
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9b2bd0287402..b78246dc1746 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -72,31 +72,6 @@ static void slot_lock_init(struct zram *zram, u32 index)
 			 &__key, 0);
 }
 
-/*
- * entry locking rules:
- *
- * 1) Lock is exclusive
- *
- * 2) lock() function can sleep waiting for the lock
- *
- * 3) Lock owner can sleep
- *
- * 4) Use TRY lock variant when in atomic context
- *    - must check return value and handle locking failers
- */
-static __must_check bool slot_trylock(struct zram *zram, u32 index)
-{
-	unsigned long *lock = &zram->table[index].__lock;
-
-	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
-		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
-		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
-		return true;
-	}
-
-	return false;
-}
-
 static void slot_lock(struct zram *zram, u32 index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
@@ -2798,23 +2773,6 @@ static void zram_submit_bio(struct bio *bio)
 	}
 }
 
-static void zram_slot_free_notify(struct block_device *bdev,
-				unsigned long index)
-{
-	struct zram *zram;
-
-	zram = bdev->bd_disk->private_data;
-
-	atomic64_inc(&zram->stats.notify_free);
-	if (!slot_trylock(zram, index)) {
-		atomic64_inc(&zram->stats.miss_free);
-		return;
-	}
-
-	slot_free(zram, index);
-	slot_unlock(zram, index);
-}
-
 static void zram_comp_params_reset(struct zram *zram)
 {
 	u32 prio;
@@ -3058,6 +3016,50 @@ static void zram_swap_submit_write(struct swap_io_ctx *ctx)
 	swap_write_end(sio, failed);
 }
 
+/*
+ * entry locking rules:
+ *
+ * 1) Lock is exclusive
+ *
+ * 2) lock() function can sleep waiting for the lock
+ *
+ * 3) Lock owner can sleep
+ *
+ * 4) Use TRY lock variant when in atomic context
+ *    - must check return value and handle locking failers
+ */
+static __must_check bool slot_trylock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].__lock;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
+		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * swap_range_free() holds the swap cluster lock. Use slot_trylock() so
+ * we never block on a slot that is already locked elsewhere.
+ */
+static void zram_swap_slot_free_notify(struct swap_info_struct *sis,
+				       unsigned long index)
+{
+	struct zram *zram = sis->bdev->bd_disk->private_data;
+
+	atomic64_inc(&zram->stats.notify_free);
+	if (!slot_trylock(zram, index)) {
+		atomic64_inc(&zram->stats.miss_free);
+		return;
+	}
+
+	slot_free(zram, index);
+	slot_unlock(zram, index);
+}
+
 /*
  * No ->can_merge: block rules exist to grow bios on contiguous sectors and
  * matching blkcg.  zram already batches through swap_iocb, and
@@ -3068,6 +3070,7 @@ static void zram_swap_submit_write(struct swap_io_ctx *ctx)
 static const struct swap_ops zram_swap_ops = {
 	.submit_read		= zram_swap_submit_read,
 	.submit_write		= zram_swap_submit_write,
+	.slot_free_notify	= zram_swap_slot_free_notify,
 };
 
 #endif /* CONFIG_SWAP */
@@ -3075,7 +3078,6 @@ static const struct swap_ops zram_swap_ops = {
 static const struct block_device_operations zram_devops = {
 	.open = zram_open,
 	.submit_bio = zram_submit_bio,
-	.swap_slot_free_notify = zram_slot_free_notify,
 	.owner = THIS_MODULE
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..f861ceed39eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1669,8 +1669,6 @@ struct block_device_operations {
 	int (*getgeo)(struct gendisk *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
 	void (*free_disk)(struct gendisk *disk);
-	/* this callback is with swap_lock and sometimes page table lock held */
-	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			    unsigned int nr_zones,
 			    struct blk_report_zones_args *args);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 70bf6f3f04dc..09640eb5a45d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -40,6 +40,11 @@ struct swap_io_ctx {
  *             the iocb is full or the plug is flushed.
  * @submit_write: flush the accumulated write ctx to the backend.
  * @submit_read: flush the accumulated read ctx to the backend.
+ * @slot_free_notify: optional callback invoked when a swap slot
+ *                    becomes free. swap_range_free() calls it with the
+ *                    swap cluster lock held. The folio lock may also be
+ *                    held on swap-cache teardown paths. Must not sleep
+ *                    or block.
  */
 struct swap_ops {
 	unsigned int		flags;
@@ -49,6 +54,8 @@ struct swap_ops {
 					     size_t prev_folio_size, int rw);
 	void			(*submit_write)(struct swap_io_ctx *ctx);
 	void			(*submit_read)(struct swap_io_ctx *ctx);
+	void			(*slot_free_notify)(struct swap_info_struct *sis,
+						    unsigned long offset);
 };
 
 int swap_register_block_ops(const struct block_device_operations *fops,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ebdc96092961..79a4166fb9bf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1311,21 +1311,18 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
 	unsigned long end = offset + nr_entries - 1;
-	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+	void (*slot_free_notify)(struct swap_info_struct *sis,
+				 unsigned long offset);
 	unsigned int i;
 
 	for (i = 0; i < nr_entries; i++)
 		zswap_invalidate(swp_entry(si->type, offset + i));
 
-	if (si->flags & SWP_BLKDEV)
-		swap_slot_free_notify =
-			si->bdev->bd_disk->fops->swap_slot_free_notify;
-	else
-		swap_slot_free_notify = NULL;
+	slot_free_notify = si->ops->slot_free_notify;
 	while (offset <= end) {
 		arch_swap_invalidate_page(si->type, offset);
-		if (swap_slot_free_notify)
-			swap_slot_free_notify(si->bdev, offset);
+		if (slot_free_notify)
+			slot_free_notify(si, offset);
 		offset++;
 	}
 
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..25552d69f711 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -135,7 +135,6 @@ pub fn build<T: Operations>(
             unlock_native_capacity: None,
             getgeo: None,
             set_read_only: None,
-            swap_slot_free_notify: None,
             report_zones: None,
             devnode: None,
             alternative_gpt_sector: None,

-- 
2.43.0

