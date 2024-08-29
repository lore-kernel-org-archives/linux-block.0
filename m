Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBF1662F1;
	Thu, 29 Aug 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918079; cv=none; b=mNApWU2QqT3XY/dyq9oUGWuamK3WE1ndpFTUuOqZqg5TINqSo3ydrdINdzoizMvLpJP71hfRji27Jzoh0UjefpXzVMHs+VzkA5zTuZmGly/aI+jTjCqTKJQHrnm7mR/GvJx6oB11g6SHvTV2KWJ+3PsXJq4AKVYLW/5xTadW0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918079; c=relaxed/simple;
	bh=b4GgLiPHYsug2IjMM3js6XPqklwZWqBgu+zr67nJAg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4CbXAAXtr1u/iq9LMu5aAbHo+QvG/o31mfHTLTytNz0zV40A9WXPKuvvAHvEEgTR3Ej0PVuUIwQGXrqZXW2+vixzRTRfgUDajBihJidLLs3/zh1qzWETJMSKbpEkuABspjsOKQqp+KYRau1qujXmshDswoSEkCWCGPExM+UXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVyt+7yL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVyt+7yL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724918078; x=1756454078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b4GgLiPHYsug2IjMM3js6XPqklwZWqBgu+zr67nJAg0=;
  b=kVyt+7yLEMzEQh6WYtKmyQIXQuCxVafTUmucV6mWvBaYgrYxzW0sA+AO
   V/Om/fSAWeZPiRtXJ6/5xfojymehjEAEV8P0IvQ2RcqD1+j2xeIu/F9qk
   gw3LfiV7gioi+kivWKH4lW6gPXtBtIqf/J09bPZQ2sNXiTTPu8Cv7gYpx
   o3MJ3Ol7jA9gQKEUEYbM7TGc+TgwBoiwTYdBfGC35tIGvT0y3K3A+HIwn
   PsaIUyTjuyM+MmB95KgMyTihqKJBPnymk0eQ80BgjIRVaqY15iHTzMRXx
   b3GAaMwqTDSDe+iMq5swYunfFEG86ceI/5JZbCjfnmxWNuziw9G6s90i8
   Q==;
X-CSE-ConnectionGUID: DLftODU/RpKSU/a/e72Lwg==
X-CSE-MsgGUID: AnlaIkVTR3CyhbxiLgwGoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="13275403"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="13275403"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:37 -0700
X-CSE-ConnectionGUID: zfU+xscUTeSsn1bDuzcVsw==
X-CSE-MsgGUID: xb5TQ3zyRTaGsUiKmO9McA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68161190"
Received: from carterle-desk.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:54:37 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] bdev: add support for CPU latency PM QoS tuning
Date: Thu, 29 Aug 2024 10:18:19 +0300
Message-ID: <20240829075423.1345042-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
References: <20240829075423.1345042-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for limiting CPU latency while block IO is running. When a
block IO is started, it will add a user configurable CPU latency limit
in place (if any.) The limit is removed with a configurable timeout mechanism.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 block/bdev.c              | 51 +++++++++++++++++++++++++++++++++++++++
 block/bio.c               |  2 ++
 block/blk.h               |  2 ++
 include/linux/blk_types.h | 12 +++++++++
 4 files changed, 67 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 353677ac49b3..8f20681a4ea6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -405,10 +405,18 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = blockdev_mnt->mnt_sb;   /* For writeback */
 }
 
+static void bdev_pm_qos_work(struct work_struct *work)
+{
+	struct bdev_cpu_latency_qos *qos =
+		container_of(work, struct bdev_cpu_latency_qos, work.work);
+	dev_pm_qos_remove_request(&qos->req);
+}
+
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	int cpu;
 
 	inode = new_inode(blockdev_superblock);
 	if (!inode)
@@ -433,6 +441,16 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+	bdev->bd_pm_qos = alloc_percpu(struct bdev_cpu_latency_qos);
+	if (!bdev->bd_pm_qos) {
+		free_percpu(bdev->bd_stats);
+		iput(inode);
+		return NULL;
+	}
+	for_each_possible_cpu(cpu)
+		INIT_DELAYED_WORK(per_cpu_ptr(&bdev->bd_pm_qos->work, cpu),
+				  bdev_pm_qos_work);
+	bdev->cpu_lat_limit = -1;
 	return bdev;
 }
 
@@ -462,6 +480,19 @@ void bdev_unhash(struct block_device *bdev)
 
 void bdev_drop(struct block_device *bdev)
 {
+	int cpu;
+	struct bdev_cpu_latency_qos *qos;
+
+	for_each_possible_cpu(cpu) {
+		qos = per_cpu_ptr(bdev->bd_pm_qos, cpu);
+		if (dev_pm_qos_request_active(&qos->req)) {
+			cancel_delayed_work(&qos->work);
+			dev_pm_qos_remove_request(&qos->req);
+		}
+	}
+
+	free_percpu(bdev->bd_pm_qos);
+
 	iput(BD_INODE(bdev));
 }
 
@@ -1281,6 +1312,26 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 	blkdev_put_no_open(bdev);
 }
 
+void bdev_update_cpu_latency_pm_qos(struct block_device *bdev)
+{
+	int cpu;
+	struct bdev_cpu_latency_qos *qos;
+
+	if (!bdev || bdev->cpu_lat_limit < 0)
+		return;
+
+	cpu = raw_smp_processor_id();
+	qos = per_cpu_ptr(bdev->bd_pm_qos, cpu);
+
+	if (!dev_pm_qos_request_active(&qos->req))
+		dev_pm_qos_add_request(get_cpu_device(cpu), &qos->req,
+				       DEV_PM_QOS_RESUME_LATENCY,
+				       bdev->cpu_lat_limit);
+
+	mod_delayed_work(system_wq, &qos->work,
+			 msecs_to_jiffies(bdev->cpu_lat_timeout));
+}
+
 bool disk_live(struct gendisk *disk)
 {
 	return !inode_unhashed(BD_INODE(disk->part0));
diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..6c46d75345d7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -282,6 +282,8 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_max_vecs = max_vecs;
 	bio->bi_io_vec = table;
 	bio->bi_pool = NULL;
+
+	bdev_update_cpu_latency_pm_qos(bio->bi_bdev);
 }
 EXPORT_SYMBOL(bio_init);
 
diff --git a/block/blk.h b/block/blk.h
index 189bc25beb50..dda2a188984b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -516,6 +516,8 @@ void drop_partition(struct block_device *part);
 
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
 
+void bdev_update_cpu_latency_pm_qos(struct block_device *bdev);
+
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 781c4500491b..0ed29603eaa9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/ktime.h>
 #include <linux/rw_hint.h>
+#include <linux/pm_qos.h>
 
 struct bio_set;
 struct bio;
@@ -38,6 +39,11 @@ struct bio_crypt_ctx;
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 #define SECTOR_MASK		(PAGE_SECTORS - 1)
 
+struct bdev_cpu_latency_qos {
+	struct dev_pm_qos_request	req;
+	struct delayed_work		work;
+};
+
 struct block_device {
 	sector_t		bd_start_sect;
 	sector_t		bd_nr_sectors;
@@ -71,6 +77,12 @@ struct block_device {
 
 	struct partition_meta_info *bd_meta_info;
 	int			bd_writers;
+
+	/* For preventing deep idle during block I/O */
+	struct bdev_cpu_latency_qos __percpu	*bd_pm_qos;
+	int cpu_lat_timeout;
+	int cpu_lat_limit;
+
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
-- 
2.43.1

