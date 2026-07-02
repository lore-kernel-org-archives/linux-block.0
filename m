Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4828C84A
	for <linux-block@vger.kernel.org>; Thu,  2 Jul 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998885; cv=none; b=NQCcYwZvfyBw3msbFdvWyaI5NoQp2jPyVoRak+4P2C69/nkYtyNQtRjq51F1Ov/jyKRFCH8ywcHklBlfFUUutDP8zcuA1FleUD2Z6qnWXPGAHORQS+uXuMDTFGUfVF1d1oPLAoeGiT/Fd4zhW6Us0pyDVIepe594NBCqnIW9L1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998885; c=relaxed/simple;
	bh=7E+3M31MLNbz1WbAlI//7XcA3BKC0I8RQ2bzWDAQNWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lyP92+g/OUhJjG4MK4Au4QJcb9Q0wmH4+n3WliP8pjSiVBilRpG0NwiPJfydefNFLxIUB2OoP9vYdR0OfCxvTyKYCcmkGpwp4oFw80ZW6GLhhpoorgNH24z7zWPxIYi/ol1Yz/n4hRUSJS0QnsJ3PhWolc4RA1GyM9sWCYHqPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4vqNSDb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4vqNSDb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c82538b6b0so14233535ad.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782998882; x=1783603682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwEDcvRPkNrlKcAyKiLB0i/cwXYXMyKOhGcuJf5WgiM=;
        b=H4vqNSDbgrz4IIpr7ythfznLZ+36MS+ItzNiNSiZRA3xyLYdEn9TwnxwoFQGKL75py
         Y1or+VgJ5DQxXpBzmSZq9AtzERJRiKyhrCqQgT/MVItabCpHULdIPeiY6IPYUx+YENGt
         juWyB9INJxkw4HET0d2dy2qv+Az/QbUokn4NNXaz52PpXBL0tnX9lfvA7JFGH3w2458t
         DrKssM35wXBeTk1NBucGhobKZnoyFkWpxFj16K7E4sIQiYuWqnKmIMfdu7sab7T08Rii
         BUUTKrZMaEoQznYVn1Kv5WJlJmUJtmSr2n+NQoydfaoe/rlrGz33lNN/R3LjUhNA3C4/
         tb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782998882; x=1783603682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HwEDcvRPkNrlKcAyKiLB0i/cwXYXMyKOhGcuJf5WgiM=;
        b=HljNYNTBLw56mIpRo0ESuciy/Xg4PiuPmI+PvKpb9O4YBF758Scibc9Q21byU2quZe
         kTDJuky55od1jTQRYpucUNrISMW/j2ckbTz1LstZigJQVwM4+m9501Ape31mcib2Bh18
         FfOvTLMOvs8aN+utALFx8ZNwq8E++1hIOPkqZdIZERCDETmNApEdn/QEPwcPV0ieBdb9
         NzBNzYEPzGZWshugWmf+ZMjI1C44zxIDEDhf67FUqO+D4YtOnBEIa3oBJClbH/XWveMC
         N5+mJ57bvQ0DE4YT7sVwd4RiafL15HgRIgbCZuV1It+7/N8tCsOAbCGs8z9ZG3pyQu49
         RQDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjQtu63yj4rR+clXDbu7mlim9DnN674Pwy+YQNFA8cns5+SUBPh9/61KexLiSIpaLNbJI4JVsWMmlfRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAINglb2IWEYMlLnD5upgrof/NfoFR4DwKrkrdJJzNpM6nseg
	hr8j5YVS3BCNbB8IHtU666V9KxrF5OrAbVh0i9xeP3x5VE82SaPngpDthPDGpW3r
X-Gm-Gg: AfdE7cnd3EDOWLs+KduPintQMRKa4YXRIu3dlPkMOD06yd+OOKTkwF9d6PMvU6TOzhn
	V+e/CzstMmmoF/EMJJ2fgUQlk7qoC69wVd1am7j2oW5qP5J7Jr2iNSmy62J9BpwmmfC/s4LzV3j
	fGWrzAMcI1QxtcqJiyUkEY8M6qCg+9W8ifQwMO0X25ORHNUMAavoPtPDXpcmyFt3L5iCrux6cKM
	UbVzzFszpdGzCOSPHfa1XizswFaOp8hBbcPD4GqZ5MaECQR0XWQCwS8S4DNG/THGaHKAAcTUlMF
	RXnfXWpQT2LZbnZhLG4v3dyXWduPbYPscz5UO9Ua81CmUHNFdtV18YQ95x/bJb3kcpSqJNMsuKp
	jIALMPaaAW1Axx964dTlOS/R2Vk0qCFxrCzxTBbIbn3CIHI6wxKyT6jjC/YjLQ4sPkYjOBkXDhf
	M6
X-Received: by 2002:a17:902:d485:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2ca7e52548cmr61331895ad.0.1782998881986;
        Thu, 02 Jul 2026 06:28:01 -0700 (PDT)
Received: from n37-098-250.byted.org ([240e:83:200::330])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae49sm13617755ad.10.2026.07.02.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 06:28:01 -0700 (PDT)
From: Diangang Li <diangangli@gmail.com>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 1/1] block: export I/O latency histograms
Date: Thu,  2 Jul 2026 21:27:12 +0800
Message-Id: <20260702132712.2255703-2-diangangli@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260702132712.2255703-1-diangangli@gmail.com>
References: <20260702132712.2255703-1-diangangli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Diangang Li <lidiangang@bytedance.com>

The existing block I/O statistics expose completed I/O counts and total
elapsed time for each operation group. Userspace can derive average
latency from those counters, but it cannot recover tail latency
information such as P99 from cumulative totals.

Add optional per-block-device latency histogram accounting for read,
write, discard and flush statistics groups. The counters follow the
existing I/O statistics accounting paths and are exported through
/proc/disk_lat_hists.

Add /proc/disk_lat_buckets to expose the bucket upper bounds in
microseconds so userspace can interpret each histogram counter.

Histogram storage is allocated per block_device and treated as optional.
If allocation fails, regular I/O statistics continue to work and the
histogram output skips that device.

Signed-off-by: Diangang Li <lidiangang@bytedance.com>
---
 Documentation/ABI/testing/procfs-diskstats |  25 ++++
 block/Makefile                             |   2 +-
 block/bdev.c                               |   2 +
 block/blk-core.c                           |   4 +-
 block/blk-flush.c                          |   5 +-
 block/blk-mq.c                             |   4 +-
 block/blk.h                                |   7 +
 block/disk-lat-hist.c                      | 158 +++++++++++++++++++++
 block/genhd.c                              |  10 ++
 include/linux/blk_types.h                  |   1 +
 10 files changed, 213 insertions(+), 5 deletions(-)
 create mode 100644 block/disk-lat-hist.c

diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index 6a719cf2075cd..015c33f5c150b 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -41,3 +41,28 @@ Description:
 		==  =====================================
 
 		For more details refer to Documentation/admin-guide/iostats.rst
+
+What:		/proc/disk_lat_buckets
+Date:		July 2026
+Contact:	Linux block layer mailing list <linux-block@vger.kernel.org>
+Description:
+		Contains the latency histogram bucket upper bounds, in
+		microseconds. The 24 bounds define the 25 counters in
+		/proc/disk_lat_hists. The first counter covers latencies up to
+		10 us, and the last counter covers latencies above 8 seconds.
+
+What:		/proc/disk_lat_hists
+Date:		July 2026
+Contact:	Linux block layer mailing list <linux-block@vger.kernel.org>
+Description:
+		Contains cumulative I/O latency histogram counters for block
+		devices and partitions. Each reported device or partition has
+		four consecutive lines, in read, write, discard, flush order.
+		Each line has 28 fields:
+
+		==  ===================================
+		 1  major number
+		 2  minor number
+		 3  device name
+		 4-28 cumulative latency bucket counters
+		==  ===================================
diff --git a/block/Makefile b/block/Makefile
index e7bd320e3d697..a24850cf1d51f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -11,7 +11,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-mq-tag.o blk-mq-dma.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
-			disk-events.o blk-ia-ranges.o early-lookup.o
+			disk-events.o blk-ia-ranges.o early-lookup.o disk-lat-hist.o
 
 obj-$(CONFIG_BLK_ERROR_INJECTION) += error-injection.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
diff --git a/block/bdev.c b/block/bdev.c
index 85ce57bd2ae4f..d389772515e4c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -394,6 +394,7 @@ static void bdev_free_inode(struct inode *inode)
 {
 	struct block_device *bdev = I_BDEV(inode);
 
+	disk_lat_hist_free(bdev);
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 	security_bdev_free(bdev);
@@ -483,6 +484,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		iput(inode);
 		return NULL;
 	}
+	disk_lat_hist_alloc(bdev);
 	bdev->bd_disk = disk;
 	return bdev;
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e8..8d9c4eb850465 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1103,12 +1103,14 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
 	unsigned long duration = now - start_time;
+	u64 duration_ns = jiffies_to_nsecs(duration);
 
 	part_stat_lock();
 	update_io_ticks(bdev, now, true);
 	part_stat_inc(bdev, ios[sgrp]);
 	part_stat_add(bdev, sectors[sgrp], sectors);
-	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_add(bdev, nsecs[sgrp], duration_ns);
+	disk_lat_hist_record_part(bdev, sgrp, duration_ns);
 	bdev_dec_in_flight(bdev, op);
 	part_stat_unlock();
 }
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 403a46c864117..a1fbd749b6607 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -124,11 +124,12 @@ static void blk_flush_restore_request(struct request *rq)
 static void blk_account_io_flush(struct request *rq)
 {
 	struct block_device *part = rq->q->disk->part0;
+	u64 nsecs = blk_time_get_ns() - rq->start_time_ns;
 
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
-	part_stat_add(part, nsecs[STAT_FLUSH],
-		      blk_time_get_ns() - rq->start_time_ns);
+	part_stat_add(part, nsecs[STAT_FLUSH], nsecs);
+	disk_lat_hist_record_part(part, STAT_FLUSH, nsecs);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 88cb5acc4f39e..231bd531803b4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1077,11 +1077,13 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 */
 	if ((req->rq_flags & (RQF_IO_STAT|RQF_FLUSH_SEQ)) == RQF_IO_STAT) {
 		const int sgrp = op_stat_group(req_op(req));
+		u64 nsecs = now - req->start_time_ns;
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
-		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_add(req->part, nsecs[sgrp], nsecs);
+		disk_lat_hist_record_part(req->part, sgrp, nsecs);
 		bdev_dec_in_flight(req->part, req_op(req));
 		part_stat_unlock();
 	}
diff --git a/block/blk.h b/block/blk.h
index 25af8ac5ef0f7..c79222bd13194 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -345,6 +345,13 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
+void disk_lat_hist_alloc(struct block_device *bdev);
+void disk_lat_hist_free(struct block_device *bdev);
+void disk_lat_hist_set_all(struct block_device *bdev, int value);
+void disk_lat_hist_record_part(struct block_device *part, int sgrp, u64 nsec);
+int disk_lat_buckets_show(struct seq_file *seqf, void *v);
+int disk_lat_hists_show(struct seq_file *seqf, void *v);
+
 /*
  * Plug flush limits
  */
diff --git a/block/disk-lat-hist.c b/block/disk-lat-hist.c
new file mode 100644
index 0000000000000..1ef2b33cb68c3
--- /dev/null
+++ b/block/disk-lat-hist.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/blkdev.h>
+#include <linux/part_stat.h>
+#include <linux/percpu.h>
+#include <linux/seq_file.h>
+
+#include "blk.h"
+
+#define DISK_LAT_HIST_BOUNDS	24
+#define DISK_LAT_HIST_BUCKETS	(DISK_LAT_HIST_BOUNDS + 1)
+
+struct disk_lat_hist {
+	u64 buckets[NR_STAT_GROUPS][DISK_LAT_HIST_BUCKETS];
+};
+
+static const u64 disk_lat_hist_bounds_us[DISK_LAT_HIST_BOUNDS] = {
+	10, 20, 40, 80,
+	100, 200, 400, 800,
+	1000, 2000, 4000, 8000,
+	10000, 20000, 40000, 80000,
+	100000, 200000, 400000, 800000,
+	1000000, 2000000, 4000000, 8000000,
+};
+
+static const int disk_lat_hist_order[NR_STAT_GROUPS] = {
+	STAT_READ,
+	STAT_WRITE,
+	STAT_DISCARD,
+	STAT_FLUSH,
+};
+
+void disk_lat_hist_alloc(struct block_device *bdev)
+{
+	/*
+	 * Latency histograms are optional. If allocation fails,
+	 * bd_lat_hist stays NULL; the record path skips histogram
+	 * accounting and regular I/O statistics are unaffected.
+	 */
+	bdev->bd_lat_hist = alloc_percpu(struct disk_lat_hist);
+	if (!bdev->bd_lat_hist)
+		pr_warn_once("block: failed to allocate latency histograms\n");
+}
+
+void disk_lat_hist_free(struct block_device *bdev)
+{
+	if (!bdev->bd_lat_hist)
+		return;
+	free_percpu(bdev->bd_lat_hist);
+	bdev->bd_lat_hist = NULL;
+}
+
+void disk_lat_hist_set_all(struct block_device *bdev, int value)
+{
+	int cpu;
+
+	if (!bdev->bd_lat_hist)
+		return;
+
+	for_each_possible_cpu(cpu)
+		memset(per_cpu_ptr(bdev->bd_lat_hist, cpu), value,
+		       sizeof(struct disk_lat_hist));
+}
+
+static void disk_lat_hist_record(struct block_device *bdev, int sgrp,
+				 int bucket)
+{
+	if (!bdev || !bdev->bd_lat_hist)
+		return;
+	__this_cpu_inc(bdev->bd_lat_hist->buckets[sgrp][bucket]);
+}
+
+static int disk_lat_hist_bucket(u64 nsec)
+{
+	int low = 0, high = DISK_LAT_HIST_BOUNDS;
+
+	while (low < high) {
+		int mid = low + (high - low) / 2;
+
+		if (nsec <= disk_lat_hist_bounds_us[mid] * NSEC_PER_USEC)
+			high = mid;
+		else
+			low = mid + 1;
+	}
+
+	return low;
+}
+
+void disk_lat_hist_record_part(struct block_device *part, int sgrp, u64 nsec)
+{
+	struct block_device *whole;
+	int bucket;
+
+	if (sgrp < 0 || sgrp >= NR_STAT_GROUPS || !part || !part->bd_disk)
+		return;
+
+	bucket = disk_lat_hist_bucket(nsec);
+	disk_lat_hist_record(part, sgrp, bucket);
+
+	whole = bdev_whole(part);
+	if (whole != part)
+		disk_lat_hist_record(whole, sgrp, bucket);
+}
+
+static void disk_lat_hist_seq_show(struct seq_file *seqf,
+				   struct block_device *bdev)
+{
+	u64 buckets[NR_STAT_GROUPS][DISK_LAT_HIST_BUCKETS] = { };
+	int cpu, sgrp, i, bucket;
+
+	if (!bdev->bd_lat_hist)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct disk_lat_hist *hist = per_cpu_ptr(bdev->bd_lat_hist, cpu);
+
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			for (i = 0; i < DISK_LAT_HIST_BUCKETS; i++)
+				buckets[sgrp][i] += hist->buckets[sgrp][i];
+	}
+
+	for (i = 0; i < NR_STAT_GROUPS; i++) {
+		sgrp = disk_lat_hist_order[i];
+		seq_printf(seqf, "%4d %7d %pg",
+			   MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev), bdev);
+		for (bucket = 0; bucket < DISK_LAT_HIST_BUCKETS; bucket++)
+			seq_printf(seqf, " %llu", buckets[sgrp][bucket]);
+		seq_putc(seqf, '\n');
+	}
+}
+
+int disk_lat_buckets_show(struct seq_file *seqf, void *v)
+{
+	int i;
+
+	for (i = 0; i < DISK_LAT_HIST_BOUNDS; i++)
+		seq_printf(seqf, "%s%llu", i ? " " : "",
+			   disk_lat_hist_bounds_us[i]);
+	seq_putc(seqf, '\n');
+
+	return 0;
+}
+
+int disk_lat_hists_show(struct seq_file *seqf, void *v)
+{
+	struct gendisk *disk = v;
+	struct block_device *part;
+	unsigned long idx;
+
+	rcu_read_lock();
+	xa_for_each(&disk->part_tbl, idx, part) {
+		if (bdev_is_partition(part) && !bdev_nr_sectors(part))
+			continue;
+		disk_lat_hist_seq_show(seqf, part);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
diff --git a/block/genhd.c b/block/genhd.c
index f84b6a355b574..b4ee18f5c4ea2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -747,6 +747,7 @@ static void __del_gendisk(struct gendisk *disk)
 	disk->slave_dir = NULL;
 
 	part_stat_set_all(disk->part0, 0);
+	disk_lat_hist_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
 	sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
@@ -1420,9 +1421,18 @@ static const struct seq_operations diskstats_op = {
 	.show	= diskstats_show
 };
 
+static const struct seq_operations disk_lat_hists_op = {
+	.start	= disk_seqf_start,
+	.next	= disk_seqf_next,
+	.stop	= disk_seqf_stop,
+	.show	= disk_lat_hists_show
+};
+
 static int __init proc_genhd_init(void)
 {
 	proc_create_seq("diskstats", 0, NULL, &diskstats_op);
+	proc_create_single("disk_lat_buckets", 0, NULL, disk_lat_buckets_show);
+	proc_create_seq("disk_lat_hists", 0, NULL, &disk_lat_hists_op);
 	proc_create_seq("partitions", 0, NULL, &partitions_op);
 	return 0;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c0..be2d31aea5d44 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -44,6 +44,7 @@ struct block_device {
 	struct gendisk *	bd_disk;
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
+	struct disk_lat_hist __percpu *bd_lat_hist;
 	unsigned long		bd_stamp;
 	atomic_t		__bd_flags;	// partition number + flags
 #define BD_PARTNO		255	// lower 8 bits; assign-once
-- 
2.39.5

