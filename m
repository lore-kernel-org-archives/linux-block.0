Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D943382CB
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538845; cv=none; b=AIzml+sWWIBBX4oEJ1xxLA3RqmNHAc4fR6Z8gsy0nhSN7ebd1WwGwsq65KYdbssmUQZPLI8e6NsOWC8flkceOLi3vYFVAyxyoc9eid6XR96weDuCPON9UzN30cg2Be1D8C+zYfHABKQ/PXDB1aQgCfOZWX/myz2h/pe7CueXTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538845; c=relaxed/simple;
	bh=XcvrOBvCezPNbCUvCF/7mnxP4IJ0851/IJN2rQRzWwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdryPJtkqPSzY+w/c6uHbxYatguIz8bZ96nkMPERg2+xVKeUS8a+Uyt7Fc7/hkHMqVVkr138OCGyAcir3CPEl/J62nqnS2itxapqbs3BgNXUqm5jJzr7AFImw+43Gq5ktmm8j6hLZooYhg1En4wCst+Dp5TT0eDVWoGasClHuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=fZSdCnVw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="fZSdCnVw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4833115090dso57583285e9.3
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1772538842; x=1773143642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUWT63/jg9iqgoqLOExCtkSXzsQ+kIFy2uXbPBqqyUY=;
        b=fZSdCnVwB6d6BELWV2m6FCEmF+SkpIHX4XbJ3xiZ2sz7jO8ToAzVLQCrsvexM4W062
         lkwxcJNl1loZ5Ap1S++A1+IFGp//PLleS7YAP4ULr56YUNMVDXb0mMtD/zb1G3D92W+Q
         uHIb/tCX6J5kOqzABp09rhCiJpACMCaseEULYSTsLXq+qyCtQzRu2Q4uul4xRXlrS2Vy
         3bwBWGImmdHzpMMKQAkDV/oOLFpDNwg0W3jg3jzEzLeyPqBT1gVOsq+Pdggta7bwTYuQ
         6tKcQvUqUPX0yJlwWQFtbUT9aK4PQK5Rk0boQus0UKzoUTS54iCP6v0UfQATlvfi6asm
         KAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538842; x=1773143642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUWT63/jg9iqgoqLOExCtkSXzsQ+kIFy2uXbPBqqyUY=;
        b=NlJdI8GIeDD9OmwrvXqZGPAhhcxU2e0nmLLcqzg7aTpjsYaL9/VRbGoKB4n4uyQD8d
         9z5BQ0kE9vW48MBBeHEv/y675gSfBJjUzz5qzXzPn68jupD+tXnjBF+gznrxDXd2tsHd
         /jHi3I6E885tizlSBbvtpZjyb0W8zXrKAMzlpjhPiJtp7u87WIjg+3CrDzn0gbOtvNgx
         EwMyJWIdAvguuq8BWdbxjCNfzPXPCfr/NSd+gdHqj0ihcdDVTxDe/DqXSwYce4Sjk13j
         v3bbb6gEmkJMil0FpuUMl6TOzCwAtbPhkbhHrbtEMo11wv4DplbgXffYivr+tl5qaEXI
         RgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm7GudC/EbO9TWH3yrhaLTfFhq4ZTvZYM52GoBNLF3X+iTf9imAyBa2MngoR7LlPVVE5h50xJSnKo2Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gw2PqPDYbAQ9S/9WQjI7YME81phGWaGOBVqKZKImFkddHrhs
	PQOoqbrkJrPuF1MKr7OMgEJbOfBiS9rhAXlB3b4/To+fp0xIUiKn7UqUzL87eH5qGvI=
X-Gm-Gg: ATEYQzzIZkiBhwI90s3urmWt6ZGKQOkn/EwPvr1fR0FxDVEmAJqFywGQ7C22dk0LreM
	9Di8lgMmCMlkIs9iYdo2fWpl5TDwIv33+BL+qYSeqJ2oTCJ8+YCiRacBMnc0SsdIvheqAsvUB/j
	f7xZ0giAPKgzJs1LM+ftIi8cve2ooJ/7YJvRq80Jtex71H4YRR05gRvcaqrmy9Nr8Wc9Vr3IXur
	dvYvOfKRdY/eKnNFIIxddGnXhXFkau+eRMFAL0gSAjy+sqxjSh7s+itr/1TGEasGDMfwa0sLzwy
	AVihNcw38r3DCHztEdGJ3ltBWCwpY01tcbx39APNLT8ksAxc9zoOuREnyo7USjhO5x+M0VKAjQC
	4nuhw67MjGiatySy7sx0eAnYdmG63diaslGIt16tQGYKbwFrK0YSXDCuKXICi4o15DqN1IxBf9p
	0TwgtsgFXjWP9Z5NrM3ai+b3A=
X-Received: by 2002:a05:600c:45d5:b0:480:6c75:ddce with SMTP id 5b1f17b1804b1-483c9c11ef1mr271279875e9.33.1772538842224;
        Tue, 03 Mar 2026 03:54:02 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::15:430])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm18598717f8f.2.2026.03.03.03.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:54:01 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [RFC PATCH 1/1] mm: Reduce direct reclaim stalls with RAM-backed swap
Date: Tue,  3 Mar 2026 11:53:58 +0000
Message-ID: <20260303115358.1323188-2-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303115358.1323188-1-matt@readmodwrite.com>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

The current should_reclaim_retry() code does not account for the fact
the number of logical swap pages available for RAM-backed swap (zram,
brd) is dependent on having enough free physical pages, and simply
always assumes that enough pages are reclaimable to satisfy the
allocation.

For instance, given a system with a 200GiB zram device (10% used) and
100MB of free physical pages, should_reclaim_retry() incorrectly
concludes that it can swap 180GiB worth of anon pages to swap.

Because it appears to be always possible to write to swap, the OOM
killer is delayed and the system retries in direct reclaim for
prolonged periods (20-30 minutes observed in production).

Fix this by excluding anon pages from the reclaimable estimate when all
active swap devices are RAM-backed. Once file-backed pages are exhausted
the watermark check fails and the kernel falls through to OOM as
expected.

To identify RAM-backed swap devices at swapon time, introduce
BLK_FEAT_RAM_BACKED (set by zram and brd) and SWP_RAM_BACKED
(swapfile.c). A cached bool swap_all_ram_backed is maintained under
swap_lock by swap_update_all_ram_backed() during swapon/swapoff, which
is locklessly accessed in should_reclaim_retry().

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/block/brd.c           |  3 ++-
 drivers/block/zram/zram_drv.c |  3 ++-
 include/linux/blkdev.h        |  8 ++++++
 include/linux/swap.h          |  9 +++++++
 mm/page_alloc.c               | 23 ++++++++++++++++-
 mm/swapfile.c                 | 47 ++++++++++++++++++++++++++++++++++-
 6 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 00cc8122068f..c021dd51ff0a 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -310,7 +310,8 @@ static int brd_alloc(int i)
 		.max_discard_segments	= 1,
 		.discard_granularity	= PAGE_SIZE,
 		.features		= BLK_FEAT_SYNCHRONOUS |
-					  BLK_FEAT_NOWAIT,
+					  BLK_FEAT_NOWAIT |
+					  BLK_FEAT_RAM_BACKED,
 	};
 
 	brd = brd_find_or_alloc_device(i);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bca33403fc8b..8075bab39e62 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -3074,7 +3074,8 @@ static int zram_add(void)
 		.max_write_zeroes_sectors	= UINT_MAX,
 #endif
 		.features			= BLK_FEAT_STABLE_WRITES |
-						  BLK_FEAT_SYNCHRONOUS,
+						  BLK_FEAT_SYNCHRONOUS |
+						  BLK_FEAT_RAM_BACKED,
 	};
 	struct zram *zram;
 	int ret, device_id;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..3666837e8774 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -334,6 +334,9 @@ typedef unsigned int __bitwise blk_features_t;
 /* is a zoned device */
 #define BLK_FEAT_ZONED			((__force blk_features_t)(1u << 10))
 
+/* storage is backed by system RAM (e.g. zram, brd) */
+#define BLK_FEAT_RAM_BACKED		((__force blk_features_t)(1u << 11))
+
 /* supports PCI(e) p2p requests */
 #define BLK_FEAT_PCI_P2PDMA		((__force blk_features_t)(1u << 12))
 
@@ -1477,6 +1480,11 @@ static inline bool bdev_synchronous(struct block_device *bdev)
 	return bdev->bd_disk->queue->limits.features & BLK_FEAT_SYNCHRONOUS;
 }
 
+static inline bool bdev_ram_backed(struct block_device *bdev)
+{
+	return bdev->bd_disk->queue->limits.features & BLK_FEAT_RAM_BACKED;
+}
+
 static inline bool bdev_stable_writes(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b408..844727fe929c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -216,6 +216,7 @@ enum {
 	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
+	SWP_RAM_BACKED	= (1 << 13),	/* swap device uses main memory (e.g. zram) */
 					/* add others here before... */
 };
 
@@ -451,6 +452,11 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
+extern bool swap_all_ram_backed;
+static inline bool swap_is_all_ram_backed(void)
+{
+	return READ_ONCE(swap_all_ram_backed);
+}
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
@@ -508,6 +514,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
 
 #define si_swapinfo(val) \
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
+
+static inline bool swap_is_all_ram_backed(void) { return false; }
+
 #define free_folio_and_swap_cache(folio) \
 	folio_put(folio)
 #define free_pages_and_swap_cache(pages, nr) \
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..c1a8f4620baa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -37,6 +37,7 @@
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
 #include <linux/compaction.h>
+#include <linux/swap.h>
 #include <trace/events/kmem.h>
 #include <trace/events/oom.h>
 #include <linux/prefetch.h>
@@ -4604,6 +4605,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	struct zone *zone;
 	struct zoneref *z;
 	bool ret = false;
+	bool ram_backed_swap = swap_is_all_ram_backed();
 
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
@@ -4637,7 +4639,26 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
 
-		available = reclaimable = zone_reclaimable_pages(zone);
+		if (ram_backed_swap) {
+			/*
+			 * Exclude anon pages when all swap is RAM-backed.
+			 * The reclaimable estimate assumes anon can be
+			 * reclaimed using free swap slots, but those slots
+			 * are only logical accounting for zram: storing the
+			 * swapped data still consumes physical pages. Free
+			 * RAM is the real limit, so counting anon inflates
+			 * 'available', keeps the watermark check passing,
+			 * and delays falling through to OOM.
+			 */
+			reclaimable =
+				zone_page_state_snapshot(zone,
+							 NR_ZONE_INACTIVE_FILE) +
+				zone_page_state_snapshot(zone,
+							 NR_ZONE_ACTIVE_FILE);
+		} else {
+			reclaimable = zone_reclaimable_pages(zone);
+		}
+		available = reclaimable;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 94af29d1de88..18713618f35c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -64,6 +64,7 @@ static bool folio_swapcache_freeable(struct folio *folio);
 static void move_cluster(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci, struct list_head *list,
 			 enum swap_cluster_flags new_flags);
+static void swap_update_all_ram_backed(void);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -74,8 +75,15 @@ atomic_long_t nr_swap_pages;
  * check to see if any swap space is available.
  */
 EXPORT_SYMBOL_GPL(nr_swap_pages);
-/* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
+
+/*
+ * Updates to these globals are serialized by swap_lock.
+ * Read locklessly in vm_swap_full() (total_swap_pages) and
+ * should_reclaim_retry() (swap_all_ram_backed).
+ */
 long total_swap_pages;
+bool swap_all_ram_backed;
+
 #define DEF_SWAP_PRIO  -1
 unsigned long swapfile_maximum_size;
 #ifdef CONFIG_MIGRATION
@@ -2670,6 +2678,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 	plist_add(&si->list, &swap_active_head);
 
+	swap_update_all_ram_backed();
+
 	/* Add back to available list */
 	add_to_avail_list(si, true);
 }
@@ -2813,6 +2823,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	spin_lock(&p->lock);
 	del_from_avail_list(p, true);
 	plist_del(&p->list, &swap_active_head);
+	swap_update_all_ram_backed();
 	atomic_long_sub(p->pages, &nr_swap_pages);
 	total_swap_pages -= p->pages;
 	spin_unlock(&p->lock);
@@ -3460,6 +3471,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (si->bdev && bdev_synchronous(si->bdev))
 		si->flags |= SWP_SYNCHRONOUS_IO;
 
+	if (si->bdev && bdev_ram_backed(si->bdev))
+		si->flags |= SWP_RAM_BACKED;
+
 	if (si->bdev && bdev_nonrot(si->bdev)) {
 		si->flags |= SWP_SOLIDSTATE;
 	} else {
@@ -3587,6 +3601,37 @@ void si_swapinfo(struct sysinfo *val)
 	spin_unlock(&swap_lock);
 }
 
+/*
+ * Recompute swap_all_ram_backed. Must be called with swap_lock held
+ * whenever a swap device is added to or removed from swap_active_head.
+ *
+ * swap_all_ram_backed is true when every active swap device is backed
+ * by main memory (e.g. zram, brd). False if there are no swap devices
+ * configured or at least one of them is backed by disk.
+ *
+ * With RAM-backed swap, swapping out an anonymous page does not yield
+ * net free pages because the driver must allocate physical RAM to
+ * store the compressed data.
+ *
+ * See should_reclaim_retry().
+ */
+static void swap_update_all_ram_backed(void)
+{
+	struct swap_info_struct *si;
+	bool all_ram = !plist_head_empty(&swap_active_head);
+
+	assert_spin_locked(&swap_lock);
+
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if (!(si->flags & SWP_RAM_BACKED)) {
+			all_ram = false;
+			break;
+		}
+	}
+
+	WRITE_ONCE(swap_all_ram_backed, all_ram);
+}
+
 /*
  * Verify that nr swap entries are valid and increment their swap map counts.
  *
-- 
2.43.0

