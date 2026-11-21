Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263101;
	b=khzNScwKb8HoevykZtyjtf05bV5xayiRspXh46rQS/JrRnxsxxV0za7sZc6m++MIo+LO
	 7wyEXiXHqZ/am5wGpb0KLkAPeo1a6GwqPFtlq07KwK1yZ+XKmF/RMU/jfW4ar3fDSEKGX
	 Oz5FCrIRQwgTpKgwgNFGiUgAdPz4uqRau3I+nr4Xx+EdE4tB0zORHg7C50F0yHEny6tX0
	 z2ekUuwxpKyuuqFiDRWoDW2eqgNAfNXzcALpJ2dY3DBeHvtwXVVBJdSQarmsUiIZio8nO
	 NvS+C26HTHYx92ijQ6lyvCkmZG6GSPzhUwlSQ/J6EEo3WUftRU0Epe1OwTibzFKDVLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F6qkXouGRbsp6kvGJBQv90f1f75Gxd//qB1z237SRcc=;
	b=vvRj4jq1h8Sm+T4rULZAVeVL5+hKg43F90Kyl2NOwwuggAppC2/OOiC7QWL8bSzYh9Dw
	 11Ta9u99NDVilTx2VYhLhkrkAl21jLIBRIyY4NLCeq0D+yysKetQRg8IqBz7GU1TGc3YA
	 NcYX/j3gNdTcYSnr7GzHCEbVHnDTgjOset6HHKrE0Rvfm6XwMscx4peD/NywxF+/+BP17
	 AZgMY0xh5VfDz3pBqPKz+YL6+oZEDStvIuEGRCfeBaeEv9und7Powr5Y6ymAZL9EwGiOY
	 4ZOwSx5JRkYGj+Jl4dNTCST01AH2h3ti/JCua5ICLBg5AZzSR7Lv1XZU1PbxWESLBlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PYp73yFA;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B02606A32A
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 12:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B02606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PYp73yFA
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1016713a91.0
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 04:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795263100; x=1795867900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6qkXouGRbsp6kvGJBQv90f1f75Gxd//qB1z237SRcc=;
        b=PYp73yFARElm4BYMfpsI0ggKIKFTEAdf15oTKmPto+j3NFOHvykheaHtfH2QZQ+DCY
         XTCWrnXsVG3/W7WH6Zbw5utPd1OYB+EjTqr85JAug5MH16VAZ5WV8ptgMBkMo4G5zus0
         9jEcooViC9ix2Ul5Rb3arN0AnCfQT/hZ6ea1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795263100; x=1795867900;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6qkXouGRbsp6kvGJBQv90f1f75Gxd//qB1z237SRcc=;
        b=SWGloEF7k6ucdbbI+Au2gcDSoyhEaBAZ4BK4AVylQMztSR9kTBt1PBv7IvH1+NRv1u
         JGhgmBiYwkcu9KXQ0szKnMapdmsLRs2zDOwPEABGnqHjN4ow9Ft0onJGdCJbWQjQpJW/
         d4OYIEdKYiaOD7MQF/p+4f15iz4FB4eAqUPLMNmT0EI76dYRqT31QEjkFVUI4JpHEj5L
         bAHPnNLlvRP/Z2KkPRQXekz3nWwWb0ezGec7Y/vpY0pA1u59rjQAWmhak6z9GOlp9HIh
         8TvDYztFEmwaubBs59zBZU+6HlqhiKmQVurLmGz2KpWciKjNZOAwbb0vFbs5c1gl4qmR
         5clg==
X-Forwarded-Encrypted: i=1; AL+hErGGV2SghDku7HbaaAlxhAvfCQ2XH5aleS9s8zyp8FSU/i4AKx52Gpre7A3ehPSrmRVCtrGVMTjCNp/13A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kJgTSs1YRMmPJPf8rnnOx8LVdEuo9tqCqDtDVA+ff2/ta62aD
	B6Cc0YoXAWs/Thq9HI8tSBtdw/t4a40kC8qikP3Upl6ykPty6e0IMLBnEOmuXVMI5w==
X-Gm-Gg: AZFdTZcc4S8vZUUlYj5+0uI7KMUT2FFzO2qZRY97uml/LMvXKlg78NtaXwt6ulacpAl
	MneUQbmiVoc6EmrAMOtkdbftdN7rmmH75y28E72HEV8NEGqVgHIWPTmnePhm72S6fQK82u55Iaw
	JYCgSeTIAl1SxW2RAEHB/qiozCjsmVtCZkpbMSzdJlfcIWBmqzvV2x5k7ZVK70MhhX4/SGmRuFL
	nA+bRD0qlImXAG4Nn+FY8K2yERRvM9YxkgqCASOGgPloIRiTWf4k8WhntFd187a6yObQNeIXcgn
	i6r3dVpQOn71uetggBkuKBOJm/V/cnovMNdkS7vYmfjM/7q1q2uVzaS3fd2Y0bojaAhx12TtXXm
	XV93iPR0ab4/4CBL6lUS3+z+Cn0i+m/LJXJ0s2u5j1seh5sepgsLVNSkrbK2le8l3JEn/bDynFR
	AvYR5gQ8dHoHsOts/0Sx/WYOS8mQIsmJRTNqsPCjPuKterjZ9WOGbGc06rn97N44OSt/iG+wO/E
	6EJUemLezdr4oBQmQeC5+OjwgP3+h8JxIDkjgRPIrNK3Wyo/vS8jtjTbiRpWv5F9yA3hNsTxO35
	fVV63qpiepz80tDaOxZDmxMsrD2xqc5h+BJzm8mH4mhyCpGEtNWpctMJQPkfcgook7e4Z/UpYke
	pdSjoiZwPOYy+vdQ=
X-Received: by 2002:a17:90b:1fcc:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3b41c9481b7mr5245450a91.46.1795263099805;
        Sat, 21 Nov 2026 04:11:39 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:2f43:ed99:516b:8dcd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm2653866a12.23.2026.11.21.04.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:11:38 -0800 (PST)
Date: Sat, 21 Nov 2026 21:11:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hongfeng Chen <hongfengchen@xiaomi.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry@kernel.org>, Wenchao Hao <haowenchao@xiaomi.com>, 
	Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, chenhongfeng0212@gmail.com
Subject: Re: [RFC PATCH v4 2/2] zram: keep the hot statistics per cpu
Message-ID: <awGJ4gPFCiAi4Ia8@google.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <20261017031542.3504947-1-hongfengchen@xiaomi.com>
 <awFXOyeELHgLfy_D@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awFXOyeELHgLfy_D@google.com>

On (26/11/21 17:35), Sergey Senozhatsky wrote:
[..]
> >  	clear_slot_flag(zram, index, ZRAM_IDLE);
> > -	if (test_slot_flag(zram, index, ZRAM_HUGE))
> > -		atomic64_dec(&zram->stats.huge_pages);
> > -	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
> > +	huge = test_slot_flag(zram, index, ZRAM_HUGE) ? -1 : 0;
> > +	size = get_slot_size(zram, index);
> > +	stats = get_cpu_ptr(zram->pcpu_stats);
> > +	u64_stats_update_begin(&stats->syncp);
> > +	WRITE_ONCE(stats->huge_pages, stats->huge_pages + huge);
> > +	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size - size);
> > +	u64_stats_update_end(&stats->syncp);
> > +	put_cpu_ptr(zram->pcpu_stats);
> 
> Thanks for reminding me that I actually looked into per-CPU stats a while
> ago.  And I had much less code, IIRC, let me find and rebase that patch,
> these WRITE_ONCE()-s, etc. are hard to maintain.  Let me find my patch.

So this is what I had, basically replicating zsmalloc stats array.

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

