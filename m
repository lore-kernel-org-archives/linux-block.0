Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412205;
	b=yYHFU3HUUwx4MoxeCdziCbYzI/Q+ST3I07/459dgUZ6TDff1C2cNgHGUK22GqtxHJ91R
	 fwfQ/ue5B39qesNjQHdpEHBSOCgNU+CTHSLvRt44cOBaqkL/UADmXksfouoDtAWjJpk7d
	 EovVNB6fJMdSxTBzl9zjm2vr3gHl+kKx0JRdo8zgdNV0lBpmrePpKeRrZ0U59G9/e53Qh
	 07ox8tdi5fq1hfvbKBSpxsnOkDPY7MBuqfgrgOWy11V0N4zAerdss+02QvEYMtmP6kcHX
	 Gftx2ZnMCSwZ7H6HQedQRtV3d9xO3BipyE3gDOHc36PE6p9mxpj/oKccGuS6rg/T6mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aM8BVqxwBlUqi8MCzMYu+U803n1WalH75F8EVPXI6z4=;
	b=GIWCWasuYbV4ZrsL/jjjwZLbZJTD1l4LJxSQAe6zWaEAXl0fQDEOfID2Nwlqza4RTB0v
	 b1CHtBe8qChKEUZzlJRRrne40PVgsXY3AriD7Ll9U6rbUJHBjF7BMKSOYob5k1r9d7Q5k
	 lw5qbn8mP5FigvlcSLQZMdGn63e43O4UozvBMHvMss4LLtReKbKJwR2+tXMe3+kAvrXLt
	 o+61sTg7dFHxgJdXPAqMeS89+uER9+i3guFHje2ob/czcRS73WEQBq8tNnHevEQ1xI2vB
	 yWumG+AJXjMUxm2kTpg0MhnHF7iXQeLOmaDHgnMYCoRvJQLj6cWHTj/d1/hEwzq4UPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nisBVTNJ;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49966606A32D
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49966606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nisBVTNJ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cddac941ed1so1102785a12.2
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795412205; x=1796017005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aM8BVqxwBlUqi8MCzMYu+U803n1WalH75F8EVPXI6z4=;
        b=nisBVTNJgRn6aDk5OeONLvjZDpS7wvuWZRYnZr7QMsOXQY1pZKyhdNEZP0Zw7YvSCM
         cQcIUYafi8AuQdr0Sq1LIdOWJR+6tW5YeVOPe8Od72p9HvbKZzyOgPBzXmqOrd0Yw6Mu
         lpK6ok3DaYTFdRAfSroRsWwUWVDrDtFm19uZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412205; x=1796017005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aM8BVqxwBlUqi8MCzMYu+U803n1WalH75F8EVPXI6z4=;
        b=tHjXk4jb0XwzMx2ybBTaIVuvR35bCj/ZRU8Ov7DmTZZp/THlzZzW7WwaEx1u8KrEJ1
         uE7RxQ1+HFl4qVqkRVHelSdqaixciPBZxAAD4lcAn/clqfKcL2aPVjHbLi6nVzOKwIMW
         uAweAZQDaJLR8uUon5k6JPjkoyaf2cnoiX/lz9+bs0M2YMEdBvVB0KFFxtM2bYw18XqN
         9bHuPu3IvUQOuzmdh3hIm9kb4GWgC5MmOjl02wCe0tgoPcDdW8G+f08JrpR1sy9LPKzo
         rRgYEOQekCitoZmvS0XUDbPMuPeqN8A2Jw8FykN4Hf9yqK1A6i8lp7WVt4EnxZLcgdPW
         rF1Q==
X-Forwarded-Encrypted: i=1; AL+hErHJ5MdQbGFmjjl+AfX33Q8s4iz/zWLxGV7KAyiu5ZAMrr8WapwuytybgQOhff0sWd/KbRrRjiOCgo73qQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nNUCG9emPdLjTkZ0FxM50w4kXjfJTURCxqVWtzTCdrSEHqUx6
	ipmbXI1pbvihodd5xFKWuz2/J8ymQ83lYUzj982mrsgSMCMudPW4pPfIDWjxpGdSZg==
X-Gm-Gg: AZFdTZdLKlGyzJtgt1Fk0qdUt3/FWxWpIC89Dd4CXNNfQw+PIn8f5fPGC5CQVnxl1L1
	IW45fILTMMq3Hg5izdDvWa3U3dENICBW3XqnrKPfrK1otAphtNHbkr2gDlixAkpaLbpyRffv+2y
	dBDH4vCdRSIM0EQzx95pJ2Emeo8kf0Xx0/d1HoJ2SPNRGqyuC3UTo3kDWfdwwNZJKa4CjWEKYsI
	9nUnqWTCoQNQ884hGjF0iHMkQmWm437gk0RB9reH59FH89RQgLQsIKavFqirYalj5qJ8PN6MyzZ
	GiFM5Ht+zLZdBLSEu6bYSjFozWa3mlsEh5vywtnOicijk/acPEWdbaph333j0pHSn1EUp3qeNPP
	V6l//DepbjAGk1zzOALbUK979TucEL9gfRELg/ckqcd/cF61t9vy+JaPA5BBC3Q8i+xqbUl3z+s
	wR+R9EyWE4IiGv9DHyAQdRZAKBwbN6paV9vAcTgeJN7RHnYqmLx6/rAznEgf0qXJIYwN4SQBm5r
	LoGNDlldfSXYo8h2BdhJKUB59d22lognvpI+AxdesUSgaS5QjgXCHl63EnrvsooTiQA/YBLdyfk
	zbrkVlZAeQ4dcS31OJHI9JQ6KwH+ZdMN/y5QTxVv7P3ODvRd5cMHsNqsIzur/by5P5Sokc2t0Sf
	nMis91SGGd8qOrikebw==
X-Received: by 2002:a05:6a20:d10f:b0:3eb:9c9f:8b8e with SMTP id adf61e73a8af0-4014e74d04cmr9200842637.92.1795412204728;
        Sun, 22 Nov 2026 21:36:44 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm4636531a12.2.2026.11.22.21.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:36:44 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 2/2] zram: keep the hot statistics per CPU
Date: Mon, 23 Nov 2026 14:36:25 +0900
Message-ID: <cd96ecab2cfbb9a50a0b5141c09f9fda086780a0.1795412161.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
References: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When several processes free swapped out memory at the same time, e.g.
on munmap() or exit, all CPUs update tpages_stored, compr_data_size,
same_pages, huge_pages, huge_pages_since and notify_free stats, so
the cachelines bounce a lot [1].  Keep the six counters per CPU
instead, as local64_t updated with preemption disabled.

munmap() test:
                  before     after
  4 x 256 MiB     18.69 ms   14.12 ms   (-24%)
  8 x 128 MiB     14.82 ms   10.09 ms   (-32%)

[1] https://lore.kernel.org/20261017031542.3504947-1-hongfengchen@xiaomi.com

Suggested-by: Hongfeng Chen <hongfengchen@xiaomi.com>
Co-developed-by: Hongfeng Chen <hongfengchen@xiaomi.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 108 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |  26 ++++++--
 2 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 54eb691f1409..951a38caeb93 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -95,6 +95,47 @@ static void slot_unlock(struct zram *zram, unsigned long index)
 	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK_BIT, lock);
 }
 
+static void zram_stat_add(struct zram *zram, enum zram_pcpu_stat item,
+			  s64 amount)
+{
+	struct zram_pcpu_stats *stats = get_cpu_ptr(zram->pcpu_stats);
+
+	local64_add(amount, &stats->stat[item]);
+	put_cpu_ptr(zram->pcpu_stats);
+}
+
+static void zram_stat_sub(struct zram *zram, enum zram_pcpu_stat item,
+			  s64 amount)
+{
+	struct zram_pcpu_stats *stats = get_cpu_ptr(zram->pcpu_stats);
+
+	local64_sub(amount, &stats->stat[item]);
+	put_cpu_ptr(zram->pcpu_stats);
+}
+
+static u64 zram_stat_read(struct zram *zram, enum zram_pcpu_stat item)
+{
+	struct zram_pcpu_stats *stats;
+	s64 sum;
+	int cpu;
+
+	/*
+	 * Other CPUs keep updating while the values are added up: a page
+	 * stored on a CPU already summed and freed on one not yet summed
+	 * can make the sum negative.  Sum them up again then.
+	 */
+	for (;;) {
+		sum = 0;
+		for_each_possible_cpu(cpu) {
+			stats = per_cpu_ptr(zram->pcpu_stats, cpu);
+			sum += local64_read(&stats->stat[item]);
+		}
+		if (sum >= 0)
+			return sum;
+		cond_resched();
+	}
+}
+
 static inline bool init_done(struct zram *zram)
 {
 	return zram->disksize;
@@ -944,8 +985,9 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 
 	clear_slot_flag(zram, index, ZRAM_IDLE);
 	if (test_slot_flag(zram, index, ZRAM_HUGE))
-		atomic64_dec(&zram->stats.huge_pages);
-	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
+		zram_stat_sub(zram, ZRAM_STAT_HUGE_PAGES, 1);
+	zram_stat_sub(zram, ZRAM_STAT_COMPR_DATA_SIZE,
+		      get_slot_size(zram, index));
 	zs_free(zram->mem_pool, &zram->table[index].handle);
 	zram->table[index].blk_idx = req->blk_idx;
 	set_slot_flag(zram, index, ZRAM_WB);
@@ -1927,7 +1969,7 @@ static ssize_t io_stat_show(struct device *dev, struct device_attribute *attr,
 			"%8llu %8llu 0 %8llu\n",
 			(u64)atomic64_read(&zram->stats.failed_reads),
 			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.notify_free));
+			zram_stat_read(zram, ZRAM_STAT_NOTIFY_FREE));
 
 	return ret;
 }
@@ -1949,20 +1991,20 @@ static ssize_t mm_stat_show(struct device *dev, struct device_attribute *attr,
 		zs_pool_stats(zram->mem_pool, &pool_stats);
 	}
 
-	orig_size = atomic64_read(&zram->stats.pages_stored);
+	orig_size = zram_stat_read(zram, ZRAM_STAT_PAGES_STORED);
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = sysfs_emit(buf,
 			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.compr_data_size),
+			zram_stat_read(zram, ZRAM_STAT_COMPR_DATA_SIZE),
 			mem_used << PAGE_SHIFT,
 			zram->limit_pages << PAGE_SHIFT,
 			max_used << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.same_pages),
+			zram_stat_read(zram, ZRAM_STAT_SAME_PAGES),
 			atomic_long_read(&pool_stats.pages_compacted),
-			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			zram_stat_read(zram, ZRAM_STAT_HUGE_PAGES),
+			zram_stat_read(zram, ZRAM_STAT_HUGE_PAGES_SINCE));
 
 	return ret;
 }
@@ -2045,7 +2087,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 		 * ZRAM_HUGE flag for deferred decompression path.
 		 */
 		if (!test_slot_flag(zram, index, ZRAM_WB))
-			atomic64_dec(&zram->stats.huge_pages);
+			zram_stat_sub(zram, ZRAM_STAT_HUGE_PAGES, 1);
 		clear_slot_flag(zram, index, ZRAM_HUGE);
 	}
 
@@ -2061,7 +2103,7 @@ static void slot_free(struct zram *zram, unsigned long index)
 	 */
 	if (test_slot_flag(zram, index, ZRAM_SAME)) {
 		clear_slot_flag(zram, index, ZRAM_SAME);
-		atomic64_dec(&zram->stats.same_pages);
+		zram_stat_sub(zram, ZRAM_STAT_SAME_PAGES, 1);
 		goto out;
 	}
 
@@ -2071,10 +2113,10 @@ static void slot_free(struct zram *zram, unsigned long index)
 
 	zs_free(zram->mem_pool, handle);
 
-	atomic64_sub(get_slot_size(zram, index),
-		     &zram->stats.compr_data_size);
+	zram_stat_sub(zram, ZRAM_STAT_COMPR_DATA_SIZE,
+		      get_slot_size(zram, index));
 out:
-	atomic64_dec(&zram->stats.pages_stored);
+	zram_stat_sub(zram, ZRAM_STAT_PAGES_STORED, 1);
 	zram->table[index].element = 0;
 	set_slot_size(zram, index, 0);
 }
@@ -2246,8 +2288,8 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
-	atomic64_inc(&zram->stats.same_pages);
-	atomic64_inc(&zram->stats.pages_stored);
+	zram_stat_add(zram, ZRAM_STAT_SAME_PAGES, 1);
+	zram_stat_add(zram, ZRAM_STAT_PAGES_STORED, 1);
 
 	return 0;
 }
@@ -2277,10 +2319,10 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
-	atomic64_add(PAGE_SIZE, &zram->stats.compr_data_size);
-	atomic64_inc(&zram->stats.huge_pages);
-	atomic64_inc(&zram->stats.huge_pages_since);
-	atomic64_inc(&zram->stats.pages_stored);
+	zram_stat_add(zram, ZRAM_STAT_COMPR_DATA_SIZE, PAGE_SIZE);
+	zram_stat_add(zram, ZRAM_STAT_HUGE_PAGES, 1);
+	zram_stat_add(zram, ZRAM_STAT_HUGE_PAGES_SINCE, 1);
+	zram_stat_add(zram, ZRAM_STAT_PAGES_STORED, 1);
 
 	return 0;
 }
@@ -2340,8 +2382,8 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	slot_unlock(zram, index);
 
 	/* Update stats */
-	atomic64_inc(&zram->stats.pages_stored);
-	atomic64_add(comp_len, &zram->stats.compr_data_size);
+	zram_stat_add(zram, ZRAM_STAT_PAGES_STORED, 1);
+	zram_stat_add(zram, ZRAM_STAT_COMPR_DATA_SIZE, comp_len);
 
 	return ret;
 }
@@ -2532,8 +2574,8 @@ static int recompress_slot(struct zram *zram, unsigned long index,
 	set_slot_size(zram, index, comp_len_new);
 	set_slot_comp_priority(zram, index, prio);
 
-	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
-	atomic64_inc(&zram->stats.pages_stored);
+	zram_stat_add(zram, ZRAM_STAT_COMPR_DATA_SIZE, comp_len_new);
+	zram_stat_add(zram, ZRAM_STAT_PAGES_STORED, 1);
 
 	return 0;
 }
@@ -2711,7 +2753,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 		slot_lock(zram, index);
 		slot_free(zram, index);
 		slot_unlock(zram, index);
-		atomic64_inc(&zram->stats.notify_free);
+		zram_stat_add(zram, ZRAM_STAT_NOTIFY_FREE, 1);
 		index++;
 		n -= PAGE_SIZE;
 	}
@@ -2804,7 +2846,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 
 	zram = bdev->bd_disk->private_data;
 
-	atomic64_inc(&zram->stats.notify_free);
+	zram_stat_add(zram, ZRAM_STAT_NOTIFY_FREE, 1);
 	if (!slot_trylock(zram, index)) {
 		atomic64_inc(&zram->stats.miss_free);
 		return;
@@ -2845,6 +2887,8 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
+	int cpu;
+
 	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
@@ -2857,6 +2901,9 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
+	for_each_possible_cpu(cpu)
+		memset(per_cpu_ptr(zram->pcpu_stats, cpu), 0,
+		       sizeof(struct zram_pcpu_stats));
 	reset_bdev(zram);
 #ifdef CONFIG_ZRAM_WRITEBACK
 	zram->wb_limit_enable = false;
@@ -3075,9 +3122,15 @@ static int zram_add(void)
 	if (!zram)
 		return -ENOMEM;
 
+	zram->pcpu_stats = alloc_percpu(struct zram_pcpu_stats);
+	if (!zram->pcpu_stats) {
+		ret = -ENOMEM;
+		goto out_free_dev;
+	}
+
 	ret = idr_alloc(&zram_index_idr, zram, 0, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto out_free_dev;
+		goto out_free_stats;
 	device_id = ret;
 
 	init_rwsem(&zram->dev_lock);
@@ -3119,6 +3172,8 @@ static int zram_add(void)
 	put_disk(zram->disk);
 out_free_idr:
 	idr_remove(&zram_index_idr, device_id);
+out_free_stats:
+	free_percpu(zram->pcpu_stats);
 out_free_dev:
 	kfree(zram);
 	return ret;
@@ -3168,6 +3223,7 @@ static int zram_remove(struct zram *zram)
 	zram_reset_device(zram);
 
 	put_disk(zram->disk);
+	free_percpu(zram->pcpu_stats);
 	kfree(zram);
 	return 0;
 }
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 724f8ce6709b..a3fa6e3d007f 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -10,6 +10,7 @@
 #define _ZRAM_DRV_H_
 
 #include <asm/byteorder.h>
+#include <asm/local64.h>
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
 
@@ -88,15 +89,27 @@ struct zram_table_entry {
 	};
 };
 
+/*
+ * Updated for every page that is stored or freed, so kept per CPU: with
+ * shared counters, concurrent swap frees bounce their cacheline.
+ */
+enum zram_pcpu_stat {
+	ZRAM_STAT_PAGES_STORED,		/* no. of pages currently stored */
+	ZRAM_STAT_COMPR_DATA_SIZE,	/* compressed size of pages stored */
+	ZRAM_STAT_SAME_PAGES,		/* no. of same element filled pages */
+	ZRAM_STAT_HUGE_PAGES,		/* no. of huge pages */
+	ZRAM_STAT_HUGE_PAGES_SINCE,	/* no. of huge pages since set up */
+	ZRAM_STAT_NOTIFY_FREE,		/* no. of slot free notifications */
+	NR_ZRAM_PCPU_STATS,
+};
+
+struct zram_pcpu_stats {
+	local64_t stat[NR_ZRAM_PCPU_STATS];
+};
+
 struct zram_stats {
-	atomic64_t compr_data_size;	/* compressed size of pages stored */
 	atomic64_t failed_reads;	/* can happen when memory is too low */
 	atomic64_t failed_writes;	/* can happen when memory is too low */
-	atomic64_t notify_free;	/* no. of swap slot free notifications */
-	atomic64_t same_pages;		/* no. of same element filled pages */
-	atomic64_t huge_pages;		/* no. of huge pages */
-	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
-	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t miss_free;		/* no. of missed free */
 #ifdef	CONFIG_ZRAM_WRITEBACK
@@ -132,6 +145,7 @@ struct zram {
 	unsigned long limit_pages;
 
 	struct zram_stats stats;
+	struct zram_pcpu_stats __percpu *pcpu_stats;
 	/*
 	 * This is the limit on amount of *uncompressed* worth of data
 	 * we can store in a disk.
-- 
2.56.1.750.gf70dc682cf-goog

