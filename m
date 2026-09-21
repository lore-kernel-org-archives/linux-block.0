Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB545516A
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979896; cv=none; b=oGy5UmD10YPo5IarSwejMJ9rIMitrixTCmK5Hri5klOfmoKhHr/jGupwOu9mVD/lFLojW1yN8kMA9AudYHZxsSWG3VMpbghuFKXVMamz16ae+XVUilRuLclcyD+QiSvGhC6p1neCCDY3m8uv0nFPgMEl/xRfJR1K5vRSmZeRdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979896; c=relaxed/simple;
	bh=suPrxEreYmxdYHqtvnEA6/1wSOD5fNyBvN6FM+CZl9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAtv7xyVRy5GkQ/1KuDy6gVkjqs44g8OsSiydGBmZc7jAX4OwtlpRWvqiGAFzbagqOSPTcCBGPjlz3IoC9xoWVwgtVye31hhrn9PfvUSWPeJ7IMr9t+JgSwuwLlSI7bNAWLQ2y5ceZUsQ/mZS4Ugw8reAz6FgWmcd9/XE/c4FpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r49dz3hU; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r49dz3hU"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=suPrxEreYmxdYHqtvnEA6/1wSOD5fNyBvN6FM+CZl9E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979892; v=1; x=1790584692;
 b=r49dz3hUJOFrbvDfG4O72lr2XigicRnDMXRnwFTubbqA73UeZY8Dxqn+wbZM5CsVyXZQth02
 Ru/vVJnKMabypQq163DaPAq+o44Kl/D/ZuEx/hVKtDb5iczy6iNZypN1lSdC8GRY6YGXdva4JJr
 EunputfAHNfPSqvu2waX9SpQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 96719b6f531fda21;
	Mon, 21 Sep 2026 08:38:12 +0000
X-Mizu-Trace-ID: 96719b6f531fda21
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 1/4] block: support cloning partitions
Date: Mon, 21 Sep 2026 09:37:49 +0100
Message-ID: <20260921083752.1154316-2-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For NVMe multipath support, per-path gendisks have flag GENHD_FL_HIDDEN
set. This means that no partition scan will be run for those disks.
However the head disk will still have its partitions scanned.

Even though for hidden disks there is no partition scan, it can be useful
to have the partition table available. Such is a case for NVMe multipath
when we want to send bios to specific partitions.

Support allowing a disk to clone the partitions from a multipath head disk.

Add struct block_device_operations.disk_changed_notify callback to allow
block drivers be notified of when partition layout may have changed. In
the NVMe multipath case, the head disk would use this callback to re-clone
the partitions onto the per-path disks.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 block/partitions/core.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7c..b03b206bc050 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -703,6 +703,9 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 
+	if (disk->fops->disk_changed_notify)
+		disk->fops->disk_changed_notify(disk);
+
 	return ret;
 }
 /*
@@ -711,6 +714,46 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
+int bdev_clone_partitions(struct gendisk *disk, struct gendisk *mirror)
+{
+	struct block_device *part;
+	unsigned long idx;
+
+	if (disk_has_partscan(mirror))
+		return -EINVAL;
+
+	lockdep_assert_held(&disk->open_mutex);
+	mutex_lock_nested(&mirror->open_mutex, SINGLE_DEPTH_NESTING);
+
+	xa_for_each_start(&mirror->part_tbl, idx, part, 1) {
+		/* Same as bdev_disk_changed() */
+		bdev_unhash(part);
+		WARN_ON_ONCE(atomic_read(&part->bd_openers));
+		invalidate_bdev(part);
+		drop_partition(part);
+	}
+
+	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
+		struct block_device *part_added;
+
+		part_added = add_partition(mirror, idx, part->bd_start_sect,
+					part->bd_nr_sectors, ADDPART_FLAG_NONE,
+					part->bd_meta_info);
+		if (IS_ERR(part_added)) {
+			if (PTR_ERR(part_added) != -ENXIO) {
+				dev_err(disk_to_dev(mirror), "p%ld could not be added: %pe\n",
+				       idx, part_added);
+			}
+			mutex_unlock(&mirror->open_mutex);
+			return PTR_ERR(part_added);
+		}
+	}
+	mutex_unlock(&mirror->open_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_clone_partitions);
+
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
 	struct address_space *mapping = state->disk->part0->bd_mapping;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..249a4250a56d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -978,6 +978,7 @@ static inline unsigned int bdev_nr_zones(struct block_device *bdev)
 }
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
+int bdev_clone_partitions(struct gendisk *disk, struct gendisk *mirror);
 
 void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
@@ -1599,6 +1600,7 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	void (*disk_changed_notify)(struct gendisk *disk);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.43.0

