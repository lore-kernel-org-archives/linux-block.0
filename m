Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F93AF647;
	Sat, 17 Oct 2026 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207018; cv=none; b=Mo5dZocS39ERs0xoZGrCQlnsomJagjyC+lkv2gu9QB3Lo8sQsizQeKwPn8gnZGP/+NaaiDBqN35IGLsOgwigKLRy2S0q4Gi1MR2il4Wu8IyAyDKSXndC1Huu6MgR+5oPb7B05+raS02nGXpmIAeIE8rSWxTjwHCzb9tg1obtoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207018; c=relaxed/simple;
	bh=YFTZDZcr+d1+S6ruRoTARk9e56IUEOiVbU2z5oJGIx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szcS+DhAT6nQQIqMvad+h5c6u0J7EU3Npsz6WpXLcjOCvMUnEjBSV5+Ep5vQGYB15lcj4/GNYwtlG5FVzXdVPsfHAaSuy5qXW1/Pjysx1G72AcErXZnpGgd55uSWApMgkHbjbIBvynfQSv9nAVnFkTwY2ZsJn5/fAsr+F+OY9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SucYKug5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SucYKug5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rY
	eujvCf6NprmQgfrv6xnLcyR5lzfeAJ0jKIJm9Zn+E=; b=SucYKug5Ko8/q75pd+
	T59xqkR123hm/O5nMROdtZwAZjbtcE8QTcQx68lNLOz8vDBu3Uu6IadgHyfe5ECf
	QKGicLv5/NOZD9e2RFNvRuhod064ig5leyUGuWAq7C64kj8yKOoxYXmYZK1q1QAV
	h+6L2A4C/ln1vwdpM31FwhszM=
Received: from hongfeng.mioffice.cn (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3YQl46NJq+Fg1AQ--.37596S2;
	Sat, 17 Oct 2026 11:16:09 +0800 (CST)
From: Hongfeng Chen <hongfengchen@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>,
	Wenchao Hao <haowenchao22@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	chenhongfeng0212@gmail.com
Subject: [RFC PATCH v4 2/2] zram: keep the hot statistics per cpu
Date: Sat, 17 Oct 2026 11:15:42 +0800
Message-ID: <20261017031542.3504947-1-hongfengchen@xiaomi.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3YQl46NJq+Fg1AQ--.37596S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Zr4UWw43KFW5XFWfCr4kWFg_yoW8Wr1UZo
	WxJFsxW3WrG345Gryvk345t3WY93WDWrn3Ar4rWFs8X39xuw1Yq3W3Gr15X3W7JFWYqFWS
	y3savr1Iqrs3tayrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUSs2-DUUUU
Sender: chenhongfeng0212@163.com
X-CM-SenderInfo: hfkh0xxrqjwvtqjqjiqs6rljoofrz/xtbC7RmnwGrS6HkjsgAA3r

From: Hongfeng Chen <hongfengchen@xiaomi.com>

pages_stored, compr_data_size, same_pages, huge_pages and notify_free are
updated on every page that zram stores or releases. When several processes
munmap() swapped out memory at the same time, all cpus update these
counters, and the cacheline that holds them bounces between cpus.

Move the five counters into a per cpu structure and update them through
zram_pcpu_add(), which disables preemption and adds to the value of the
current cpu. All writers run in process context, so disabling preemption is
enough. The store is WRITE_ONCE() and the remote reads are READ_ONCE(),
since a reader on another cpu can see the value at any time. A sysfs read
sums the per cpu values without a snapshot across cpus, so a sum can be
briefly negative and is clamped at zero.

slot_free() and the write, recompression and writeback paths update all of
their counters while preemption is disabled once. Disabling preemption and
finding the per cpu data has a cost, and this way it is paid once per slot
instead of once per counter.

u64_stats_sync keeps 64-bit reads from tearing on 32-bit systems and is
empty on 64-bit systems.

Signed-off-by: Hongfeng Chen <hongfengchen@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 171 ++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h |  16 +++-
 2 files changed, 155 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 024402438bd1..affe758a9543 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -488,6 +488,56 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 	return len;
 }
 
+struct zram_stats_sum {
+	s64 pages_stored;
+	s64 compr_data_size;
+	s64 same_pages;
+	s64 huge_pages;
+	u64 notify_free;
+};
+
+#define zram_pcpu_add(zram_dev, field, val)					\
+do {									\
+	struct zram *__zram = (zram_dev);				\
+	struct zram_pcpu_stats *__stats;				\
+									\
+	__stats = get_cpu_ptr(__zram->pcpu_stats);			\
+	u64_stats_update_begin(&__stats->syncp);			\
+	WRITE_ONCE(__stats->field, __stats->field + (val));		\
+	u64_stats_update_end(&__stats->syncp);			\
+	put_cpu_ptr(__zram->pcpu_stats);				\
+} while (0)
+
+static void zram_pcpu_sum(struct zram *zram, struct zram_stats_sum *sum)
+{
+	int cpu;
+
+	memset(sum, 0, sizeof(*sum));
+
+	for_each_possible_cpu(cpu) {
+		struct zram_pcpu_stats *stats;
+		unsigned int start;
+		s64 pages, bytes, same, huge;
+		u64 notify;
+
+		stats = per_cpu_ptr(zram->pcpu_stats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			pages = READ_ONCE(stats->pages_stored);
+			bytes = READ_ONCE(stats->compr_data_size);
+			same = READ_ONCE(stats->same_pages);
+			huge = READ_ONCE(stats->huge_pages);
+			notify = READ_ONCE(stats->notify_free);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		sum->pages_stored += pages;
+		sum->compr_data_size += bytes;
+		sum->same_pages += same;
+		sum->huge_pages += huge;
+		sum->notify_free += notify;
+	}
+}
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 #define INVALID_BDEV_BLOCK		(~0UL)
 
@@ -919,6 +969,8 @@ static void zram_account_writeback_submit(struct zram *zram)
 static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 {
 	unsigned long index = req->pps->index;
+	struct zram_pcpu_stats *stats;
+	s64 huge, size;
 	int err;
 
 	err = blk_status_to_errno(req->bio.bi_status);
@@ -947,9 +999,14 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	}
 
 	clear_slot_flag(zram, index, ZRAM_IDLE);
-	if (test_slot_flag(zram, index, ZRAM_HUGE))
-		atomic64_dec(&zram->stats.huge_pages);
-	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
+	huge = test_slot_flag(zram, index, ZRAM_HUGE) ? -1 : 0;
+	size = get_slot_size(zram, index);
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->huge_pages, stats->huge_pages + huge);
+	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size - size);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 	zs_free(zram->mem_pool, get_slot_handle(zram, index));
 	set_slot_handle(zram, index, req->blk_idx);
 	set_slot_flag(zram, index, ZRAM_WB);
@@ -1919,14 +1976,16 @@ static ssize_t io_stat_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	struct zram_stats_sum sum;
 	ssize_t ret;
 
 	guard(rwsem_read)(&zram->dev_lock);
+	zram_pcpu_sum(zram, &sum);
 	ret = sysfs_emit(buf,
 			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.notify_free));
+			sum.notify_free);
 
 	return ret;
 }
@@ -1936,6 +1995,7 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 {
 	struct zram *zram = dev_to_zram(dev);
 	struct zs_pool_stats pool_stats;
+	struct zram_stats_sum sum;
 	u64 orig_size, mem_used = 0;
 	long max_used;
 	ssize_t ret;
@@ -1948,19 +2008,20 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 		zs_pool_stats(zram->mem_pool, &pool_stats);
 	}
 
-	orig_size = atomic64_read(&zram->stats.pages_stored);
+	zram_pcpu_sum(zram, &sum);
+	orig_size = max_t(s64, sum.pages_stored, 0);
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = sysfs_emit(buf,
 			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.compr_data_size),
+			(u64)max_t(s64, sum.compr_data_size, 0),
 			mem_used << PAGE_SHIFT,
 			zram->limit_pages << PAGE_SHIFT,
 			max_used << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.same_pages),
+			(u64)max_t(s64, sum.same_pages, 0),
 			atomic_long_read(&pool_stats.pages_compacted),
-			(u64)atomic64_read(&zram->stats.huge_pages),
+			(u64)max_t(s64, sum.huge_pages, 0),
 			(u64)atomic64_read(&zram->stats.huge_pages_since));
 
 	return ret;
@@ -2027,6 +2088,8 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 
 static void slot_free(struct zram *zram, unsigned long index)
 {
+	s64 pages = 0, bytes = 0, same = 0, huge = 0;
+	struct zram_pcpu_stats *stats;
 	unsigned long handle;
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
@@ -2044,7 +2107,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 		 * ZRAM_HUGE flag for deferred decompression path.
 		 */
 		if (!test_slot_flag(zram, index, ZRAM_WB))
-			atomic64_dec(&zram->stats.huge_pages);
+			huge = -1;
 		clear_slot_flag(zram, index, ZRAM_HUGE);
 	}
 
@@ -2060,22 +2123,32 @@ static void slot_free(struct zram *zram, unsigned long index)
 	 */
 	if (test_slot_flag(zram, index, ZRAM_SAME)) {
 		clear_slot_flag(zram, index, ZRAM_SAME);
-		atomic64_dec(&zram->stats.same_pages);
+		same = -1;
 		goto out;
 	}
 
 	handle = get_slot_handle(zram, index);
 	if (!handle)
-		return;
+		goto stats;
 
 	zs_free(zram->mem_pool, handle);
 
-	atomic64_sub(get_slot_size(zram, index),
-		     &zram->stats.compr_data_size);
+	bytes = -(s64)get_slot_size(zram, index);
 out:
-	atomic64_dec(&zram->stats.pages_stored);
+	pages = -1;
 	set_slot_handle(zram, index, 0);
 	set_slot_size(zram, index, 0);
+stats:
+	if (!(pages | bytes | same | huge))
+		return;
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->pages_stored, stats->pages_stored + pages);
+	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size + bytes);
+	WRITE_ONCE(stats->same_pages, stats->same_pages + same);
+	WRITE_ONCE(stats->huge_pages, stats->huge_pages + huge);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 }
 
 static int read_same_filled_page(struct zram *zram, struct page *page,
@@ -2237,14 +2310,20 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 static int write_same_filled_page(struct zram *zram, unsigned long fill,
 				  unsigned long index)
 {
+	struct zram_pcpu_stats *stats;
+
 	slot_lock(zram, index);
 	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_SAME);
 	set_slot_handle(zram, index, fill);
 	slot_unlock(zram, index);
 
-	atomic64_inc(&zram->stats.same_pages);
-	atomic64_inc(&zram->stats.pages_stored);
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->same_pages, stats->same_pages + 1);
+	WRITE_ONCE(stats->pages_stored, stats->pages_stored + 1);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 
 	return 0;
 }
@@ -2252,6 +2331,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 static int write_incompressible_page(struct zram *zram, struct page *page,
 				     unsigned long index)
 {
+	struct zram_pcpu_stats *stats;
 	unsigned long handle;
 	void *src;
 
@@ -2282,10 +2362,14 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	set_slot_size(zram, index, PAGE_SIZE);
 	slot_unlock(zram, index);
 
-	atomic64_add(PAGE_SIZE, &zram->stats.compr_data_size);
-	atomic64_inc(&zram->stats.huge_pages);
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size + PAGE_SIZE);
+	WRITE_ONCE(stats->huge_pages, stats->huge_pages + 1);
+	WRITE_ONCE(stats->pages_stored, stats->pages_stored + 1);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 	atomic64_inc(&zram->stats.huge_pages_since);
-	atomic64_inc(&zram->stats.pages_stored);
 
 	return 0;
 }
@@ -2293,6 +2377,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 static int zram_write_page(struct zram *zram, struct page *page,
 			   unsigned long index)
 {
+	struct zram_pcpu_stats *stats;
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
@@ -2348,8 +2433,12 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	slot_unlock(zram, index);
 
 	/* Update stats */
-	atomic64_inc(&zram->stats.pages_stored);
-	atomic64_add(comp_len, &zram->stats.compr_data_size);
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->pages_stored, stats->pages_stored + 1);
+	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size + comp_len);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 
 	return ret;
 }
@@ -2449,6 +2538,7 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 			   u32 threshold, u32 prio)
 {
 	struct zcomp_strm *zstrm = NULL;
+	struct zram_pcpu_stats *stats;
 	unsigned long handle_old;
 	unsigned long handle_new;
 	unsigned int comp_len_old;
@@ -2545,8 +2635,12 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	set_slot_size(zram, index, comp_len_new);
 	set_slot_comp_priority(zram, index, prio);
 
-	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
-	atomic64_inc(&zram->stats.pages_stored);
+	stats = get_cpu_ptr(zram->pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size + comp_len_new);
+	WRITE_ONCE(stats->pages_stored, stats->pages_stored + 1);
+	u64_stats_update_end(&stats->syncp);
+	put_cpu_ptr(zram->pcpu_stats);
 
 	return 0;
 }
@@ -2724,7 +2818,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 		slot_lock(zram, index);
 		slot_free(zram, index);
 		slot_unlock(zram, index);
-		atomic64_inc(&zram->stats.notify_free);
+		zram_pcpu_add(zram, notify_free, 1);
 		index++;
 		n -= PAGE_SIZE;
 	}
@@ -2825,7 +2919,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 
 	zram = bdev->bd_disk->private_data;
 
-	atomic64_inc(&zram->stats.notify_free);
+	zram_pcpu_add(zram, notify_free, 1);
 	if (!slot_trylock(zram, index)) {
 		atomic64_inc(&zram->stats.miss_free);
 		return;
@@ -2866,6 +2960,8 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
+	int cpu;
+
 	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
@@ -2877,6 +2973,16 @@ static void zram_reset_device(struct zram *zram)
 	zram_meta_free(zram, zram->disksize);
 	zram->disksize = 0;
 	zram_destroy_comps(zram);
+	for_each_possible_cpu(cpu) {
+		struct zram_pcpu_stats *stats;
+
+		stats = per_cpu_ptr(zram->pcpu_stats, cpu);
+		stats->pages_stored = 0;
+		stats->compr_data_size = 0;
+		stats->same_pages = 0;
+		stats->huge_pages = 0;
+		stats->notify_free = 0;
+	}
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
 }
@@ -3083,15 +3189,23 @@ static int zram_add(void)
 						  BLK_FEAT_SYNCHRONOUS,
 	};
 	struct zram *zram;
-	int ret, device_id;
+	int cpu, ret, device_id;
 
 	zram = kzalloc_obj(struct zram);
 	if (!zram)
 		return -ENOMEM;
 
+	zram->pcpu_stats = alloc_percpu(struct zram_pcpu_stats);
+	if (!zram->pcpu_stats) {
+		ret = -ENOMEM;
+		goto out_free_dev;
+	}
+	for_each_possible_cpu(cpu)
+		u64_stats_init(&per_cpu_ptr(zram->pcpu_stats, cpu)->syncp);
+
 	ret = idr_alloc(&zram_index_idr, zram, 0, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto out_free_dev;
+		goto out_free_pcpu;
 	device_id = ret;
 
 	init_rwsem(&zram->dev_lock);
@@ -3133,6 +3247,8 @@ static int zram_add(void)
 	put_disk(zram->disk);
 out_free_idr:
 	idr_remove(&zram_index_idr, device_id);
+out_free_pcpu:
+	free_percpu(zram->pcpu_stats);
 out_free_dev:
 	kfree(zram);
 	return ret;
@@ -3182,6 +3298,7 @@ static int zram_remove(struct zram *zram)
 	zram_reset_device(zram);
 
 	put_disk(zram->disk);
+	free_percpu(zram->pcpu_stats);
 	kfree(zram);
 	return 0;
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 7a55d751417e..482e1c28ca1c 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -17,6 +17,7 @@
 
 #include <asm/byteorder.h>
 #include <linux/rwsem.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/zsmalloc.h>
 
 #include "zcomp.h"
@@ -90,15 +91,19 @@ struct zram_table_entry {
 	};
 };
 
+struct zram_pcpu_stats {
+	struct u64_stats_sync syncp;
+	s64 pages_stored;	/* no. of pages currently stored */
+	s64 compr_data_size;	/* compressed size of pages stored */
+	s64 same_pages;		/* no. of same element filled pages */
+	s64 huge_pages;		/* no. of huge pages */
+	u64 notify_free;	/* no. of swap slot free notifications */
+};
+
 struct zram_stats {
-	atomic64_t compr_data_size;	/* compressed size of pages stored */
 	atomic64_t failed_reads;	/* can happen when memory is too low */
 	atomic64_t failed_writes;	/* can happen when memory is too low */
-	atomic64_t notify_free;	/* no. of swap slot free notifications */
-	atomic64_t same_pages;		/* no. of same element filled pages */
-	atomic64_t huge_pages;		/* no. of huge pages */
 	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
-	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
@@ -134,6 +139,7 @@ struct zram {
 	unsigned long limit_pages;
 
 	struct zram_stats stats;
+	struct zram_pcpu_stats __percpu *pcpu_stats;
 	/*
 	 * This is the limit on amount of *uncompressed* worth of data
 	 * we can store in a disk.
-- 
2.54.0

