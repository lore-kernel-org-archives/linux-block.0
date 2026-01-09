Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65814345CA3
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947519; cv=none; b=dNx2OKWqhIG33W32PMd8GqRs9z3McXvyUFuXNf9lYXc3+Ws6sBPoReBHCHP5U3zYHMq9gXRbOceqoHHNx+ijEOZxicHQO/BLf1SfTSJhp6cNMIVUz0h1vqjv/emxKe2aAzLqfpNGmGG7Ht5Et2/nEjcJlTQ1XGzaY6hHri9G8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947519; c=relaxed/simple;
	bh=QcWShs4mL2Seyc9tgVAvKR9E+NSPmfi9BEUBl0U3ub8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tr+qpkJ7RS+IljNWIQCUEnuP+att7hCIb7wDjbP6JqOsv5WmjgvHTHqIprbszr4ZldJOBMaOSP1I4hN9QY7p0evCfq51kTwru4M7fkwAA4MQD4WC3rSRkR+JrbqKLNXNFVqnf031u2H/n1RpkbTDVc4g3lqk7gq6tWvCb34fmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mptxX65a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mptxX65a"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a110548cdeso30543675ad.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947513; x=1768552313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6eq99+0tMwvpgFKCbT1OzNZeIGKY3KMsocgxOEaHFo=;
        b=mptxX65aFYQfcvVM6U8B+bi1yStxiqj79Z52dXQHixGYvsHzbjH/NZ03ASWVXnn0ID
         vxp87QZ2VwVyjHjAc132fPo5LxuQOEE+YSmR6qvbkY7Wf3+PkgjoBUx+L1jVdjWdRF/w
         Msfw9Y+nOUFkzTrCGI5Vp386qrR8dVkzf/GRc52i0vqxDfW9biK7Ccvt+IFAbiEaC7dk
         dihGjEuym9+8Rp0eLyN3BZeGH8EgEOsTkLkK2/bQx8FVjdOon1X2WHtIlFEDUHNefF9I
         5IIXK5sXkX9XHYkCj7y/1hEkyHFk8sTBp8aGRpul6pmq8hC1vAOQjlfNq7810B46UaYH
         2xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947513; x=1768552313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6eq99+0tMwvpgFKCbT1OzNZeIGKY3KMsocgxOEaHFo=;
        b=iJKlDorb9mhEBr78jOcs/INxfJFVlMqg6ubt/nU7E0ZBkyOAbDZsYffOv8r+1Sz9Pe
         hclECyVG58DYD+aiP9n9i0RMt7w6Z80/YzrPINbfyaWFtqPYk0HHHzLzK6CFN+r8rKS0
         13syoYXSltXaEw3PC70C/Ua8yHBF2iDG9yY3UDh9u2C/RPwtX/5PrVa5F4zOboGtasu2
         0tCD8d1x9wtj3t8aUeEPXsls2FCyj459lKpcexzki6mudQv5GKSduu4GRtZe0J8ui02F
         twabXJpqmL3dyS7kHDrukT5SKQLByYtTfSj06aKxTjEf+kfsClQmf6S3g/aCG3yJb7dR
         Gmvg==
X-Gm-Message-State: AOJu0YyJbz9JFYL6uJIh7UIWMTD9Pd/Ibf/IbZVWfOoVzz4slqn+QdPf
	x8Lc4O3E3FrTVIr9TKmvM27peRjDFyyV2cqeGaNVzPqEGyuWDL0yJ15j
X-Gm-Gg: AY/fxX5lawDuG8rUoE56BmE+PB+qUlt7PGnzIpxiqj073mmLdzg0fUdzn6zX3rsG0Z6
	ccO486en5YYxiOH4IAaf83c8TH4FtB1pfN5P9JNee1W5T4RG+6MJExu2T0RQUk7T7sh5r8n+uIL
	WdFlp3X36rK7OMopDtSihJegaAro9znf67bwof85dEt+9Rm+U6pVoV5THXlXuN6504KzvGtj6t7
	MHhfo4TmFe7zZGnDkrPWQ2o8krSth9raUoDxEyYNWrQ/v1+R8tx/NCTxEYWsxH95EwsT1Jo5sJM
	d0Rg+mERcbuIVyj2G0hdiD6e3CUJ8yZJ+XBDvHDpFPZP6ZpyVmxJ2YqSc/hk2yj2oFHKeNc4/9d
	tqiLuRVuqy8Q2TkcgWp+Q+AmijmxYVairbGVamayd6Ee5yrQleg1aOJ7M0tAhIxxR4rw2B8QlN1
	QGjUbYER7XgJAe9XYb3oZq45xVa3W/+ikBJisoaFYHQm4=
X-Google-Smtp-Source: AGHT+IGpfXTmgOvJ7lrju5/NRykpykvhv9LwCj7H3KkAFw66tefXFSpWJwdw7sqK2zlL4ZNE0PqAzQ==
X-Received: by 2002:a17:902:ea0d:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2a3ee45230fmr93698005ad.17.1767947513040;
        Fri, 09 Jan 2026 00:31:53 -0800 (PST)
Received: from L9HW65VV5R.bytedance.net ([101.126.56.83])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a3e3cc793fsm99474095ad.72.2026.01.09.00.31.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 00:31:52 -0800 (PST)
From: Diangang Li <diangangli@gmail.com>
X-Google-Original-From: Diangang Li <lidiangang@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changfengnan@bytedance.com,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 1/1] block: export windowed IO P99 latency
Date: Fri,  9 Jan 2026 16:31:26 +0800
Message-Id: <20260109083126.15052-2-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260109083126.15052-1-lidiangang@bytedance.com>
References: <20260109083126.15052-1-lidiangang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track per-IO completion latency in a power-of-two histogram
(NR_STAT_BUCKETS buckets, DISK_LAT_BASE_USEC .. DISK_LAT_MAX_USEC).

Maintain a per-cpu sliced ring histogram and compute P99 by aggregating the
recent slices at read time in /proc/diskstats and /sys/block/<dev>/stat.

Report P99 in usecs using the bucket midpoint, clamp overflows to
DISK_LAT_MAX_USEC, and append the P99 for read/write/discard/flush.

Suggested-by: Fengnan Chang <changfengnan@bytedance.com>
Signed-off-by: Diangang Li <lidiangang@bytedance.com>
---
 block/blk-core.c          |  5 ++-
 block/blk-flush.c         |  6 ++-
 block/blk-mq.c            |  5 ++-
 block/genhd.c             | 50 ++++++++++++++++++++++++-
 include/linux/part_stat.h | 79 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8387fe50ea156..832ba4fc1b75a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1062,12 +1062,15 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
 	unsigned long duration = now - start_time;
+	u64 latency_ns = jiffies_to_nsecs(duration);
+	unsigned int bucket = diskstat_latency_bucket(latency_ns);
 
 	part_stat_lock();
 	update_io_ticks(bdev, now, true);
 	part_stat_inc(bdev, ios[sgrp]);
 	part_stat_add(bdev, sectors[sgrp], sectors);
-	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_add(bdev, nsecs[sgrp], latency_ns);
+	part_stat_latency_record(bdev, sgrp, now, bucket);
 	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 }
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 43d6152897a42..b3ff78025968f 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -124,11 +124,13 @@ static void blk_flush_restore_request(struct request *rq)
 static void blk_account_io_flush(struct request *rq)
 {
 	struct block_device *part = rq->q->disk->part0;
+	u64 latency_ns = blk_time_get_ns() - rq->start_time_ns;
+	unsigned int bucket = diskstat_latency_bucket(latency_ns);
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
-	part_stat_add(part, nsecs[STAT_FLUSH],
-		      blk_time_get_ns() - rq->start_time_ns);
+	part_stat_add(part, nsecs[STAT_FLUSH], latency_ns);
+	part_stat_latency_record(part, STAT_FLUSH, jiffies, bucket);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index eff4f72ce83be..6a7fd6681902e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1068,11 +1068,14 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 */
 	if ((req->rq_flags & (RQF_IO_STAT|RQF_FLUSH_SEQ)) == RQF_IO_STAT) {
 		const int sgrp = op_stat_group(req_op(req));
+		u64 latency_ns = now - req->start_time_ns;
+		unsigned int bucket = diskstat_latency_bucket(latency_ns);
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
-		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_add(req->part, nsecs[sgrp], latency_ns);
+		part_stat_latency_record(req->part, sgrp, jiffies, bucket);
 		part_stat_local_dec(req->part,
 				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 69c75117ba2c0..56151c7880651 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -108,23 +108,60 @@ static void part_stat_read_all(struct block_device *part,
 		struct disk_stats *stat)
 {
 	int cpu;
+	u32 now_epoch = (u32)(jiffies / HZ);
 
 	memset(stat, 0, sizeof(struct disk_stats));
 	for_each_possible_cpu(cpu) {
 		struct disk_stats *ptr = per_cpu_ptr(part->bd_stats, cpu);
 		int group;
+		int slice;
+		int bucket;
 
 		for (group = 0; group < NR_STAT_GROUPS; group++) {
 			stat->nsecs[group] += ptr->nsecs[group];
 			stat->sectors[group] += ptr->sectors[group];
 			stat->ios[group] += ptr->ios[group];
 			stat->merges[group] += ptr->merges[group];
+
+			for (slice = 0; slice < NR_STAT_SLICES; slice++) {
+				u32 slice_epoch = READ_ONCE(ptr->latency_epoch[slice]);
+				s32 age = (s32)(now_epoch - slice_epoch);
+
+				if (age < 0 || age >= NR_STAT_SLICES)
+					continue;
+
+				for (bucket = 0; bucket < NR_STAT_BUCKETS; bucket++)
+					stat->latency[group][0][bucket] +=
+						ptr->latency[group][slice][bucket];
+			}
 		}
 
 		stat->io_ticks += ptr->io_ticks;
 	}
 }
 
+static u32 diskstat_p99_us(u32 buckets[NR_STAT_BUCKETS])
+{
+	u32 total = 0;
+	u32 accum = 0;
+	u32 target;
+	int bucket;
+
+	for (bucket = 0; bucket < NR_STAT_BUCKETS; bucket++)
+		total += buckets[bucket];
+	if (!total)
+		return 0;
+
+	target = total - div_u64((u64)total, 100);
+	for (bucket = 0; bucket < NR_STAT_BUCKETS; bucket++) {
+		accum += buckets[bucket];
+		if (accum >= target)
+			return diskstat_latency_bucket_us(bucket);
+	}
+
+	return diskstat_latency_bucket_us(NR_STAT_BUCKETS - 1);
+}
+
 static void bdev_count_inflight_rw(struct block_device *part,
 		unsigned int inflight[2], bool mq_driver)
 {
@@ -1078,7 +1115,8 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u "
 		"%8lu %8lu %8llu %8u "
-		"%8lu %8u"
+		"%8lu %8u "
+		"%8u %8u %8u %8u"
 		"\n",
 		stat.ios[STAT_READ],
 		stat.merges[STAT_READ],
@@ -1100,7 +1138,11 @@ ssize_t part_stat_show(struct device *dev,
 		(unsigned long long)stat.sectors[STAT_DISCARD],
 		(unsigned int)div_u64(stat.nsecs[STAT_DISCARD], NSEC_PER_MSEC),
 		stat.ios[STAT_FLUSH],
-		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC));
+		(unsigned int)div_u64(stat.nsecs[STAT_FLUSH], NSEC_PER_MSEC),
+		diskstat_p99_us(stat.latency[STAT_READ][0]),
+		diskstat_p99_us(stat.latency[STAT_WRITE][0]),
+		diskstat_p99_us(stat.latency[STAT_DISCARD][0]),
+		diskstat_p99_us(stat.latency[STAT_FLUSH][0]));
 }
 
 /*
@@ -1406,6 +1448,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		seq_put_decimal_ull(seqf, " ", stat.ios[STAT_FLUSH]);
 		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
 								     NSEC_PER_MSEC));
+		seq_put_decimal_ull(seqf, " ", diskstat_p99_us(stat.latency[STAT_READ][0]));
+		seq_put_decimal_ull(seqf, " ", diskstat_p99_us(stat.latency[STAT_WRITE][0]));
+		seq_put_decimal_ull(seqf, " ", diskstat_p99_us(stat.latency[STAT_DISCARD][0]));
+		seq_put_decimal_ull(seqf, " ", diskstat_p99_us(stat.latency[STAT_FLUSH][0]));
 		seq_putc(seqf, '\n');
 	}
 	rcu_read_unlock();
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 729415e91215d..cbcb24abac21e 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -5,6 +5,19 @@
 #include <linux/blkdev.h>
 #include <asm/local.h>
 
+/*
+ * Diskstats latency histogram:
+ * - Bucket upper bounds are power-of-two in usecs, starting at DISK_LAT_BASE_USEC.
+ * - The last bucket is a saturation bucket for latencies >= DISK_LAT_MAX_USEC.
+ *
+ * Latency is tracked in NR_STAT_SLICES 1-second slices and
+ * summed to compute a NR_STAT_SLICES-second P99 latency.
+ */
+#define NR_STAT_BUCKETS 21
+#define NR_STAT_SLICES 5
+#define DISK_LAT_BASE_USEC 8U
+#define DISK_LAT_MAX_USEC (DISK_LAT_BASE_USEC << (NR_STAT_BUCKETS - 1))
+
 struct disk_stats {
 	u64 nsecs[NR_STAT_GROUPS];
 	unsigned long sectors[NR_STAT_GROUPS];
@@ -12,6 +25,8 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	local_t in_flight[2];
+	u32 latency_epoch[NR_STAT_SLICES];
+	u32 latency[NR_STAT_GROUPS][NR_STAT_SLICES][NR_STAT_BUCKETS];
 };
 
 /*
@@ -81,4 +96,68 @@ static inline void part_stat_set_all(struct block_device *part, int value)
 
 unsigned int bdev_count_inflight(struct block_device *part);
 
+static inline unsigned int diskstat_latency_bucket(u64 latency_ns)
+{
+	u64 latency_us = latency_ns / 1000;
+	u64 scaled;
+
+	if (latency_us <= DISK_LAT_BASE_USEC)
+		return 0;
+
+	if (latency_us >= DISK_LAT_MAX_USEC)
+		return NR_STAT_BUCKETS - 1;
+
+	scaled = div_u64(latency_us - 1, DISK_LAT_BASE_USEC);
+	return min_t(unsigned int, (unsigned int)fls64(scaled),
+			NR_STAT_BUCKETS - 1);
+}
+
+static inline u32 diskstat_latency_bucket_upper_us(unsigned int bucket)
+{
+	if (bucket >= NR_STAT_BUCKETS - 1)
+		return DISK_LAT_MAX_USEC;
+	return DISK_LAT_BASE_USEC << bucket;
+}
+
+static inline u32 diskstat_latency_bucket_us(unsigned int bucket)
+{
+	u32 high;
+	u32 low;
+
+	if (bucket >= NR_STAT_BUCKETS - 1)
+		return DISK_LAT_MAX_USEC;
+
+	high = diskstat_latency_bucket_upper_us(bucket);
+	low = high >> 1;
+	return low + (low >> 1);
+}
+
+static inline void __part_stat_latency_prepare(struct block_device *part,
+		u32 epoch, unsigned int slice)
+{
+	struct disk_stats *stats = per_cpu_ptr(part->bd_stats, smp_processor_id());
+	int group;
+
+	if (likely(stats->latency_epoch[slice] == epoch))
+		return;
+
+	for (group = 0; group < NR_STAT_GROUPS; group++)
+		memset(stats->latency[group][slice], 0,
+				sizeof(stats->latency[group][slice]));
+	stats->latency_epoch[slice] = epoch;
+}
+
+static inline void part_stat_latency_record(struct block_device *part,
+		int sgrp, unsigned long now, unsigned int bucket)
+{
+	u32 epoch = now / HZ;
+	unsigned int slice = epoch % NR_STAT_SLICES;
+
+	__part_stat_latency_prepare(part, epoch, slice);
+	if (bdev_is_partition(part))
+		__part_stat_latency_prepare(bdev_whole(part), epoch, slice);
+
+	part_stat_inc(part, latency[sgrp][slice][bucket]);
+}
+
 #endif /* _LINUX_PART_STAT_H */
-- 
2.39.5

