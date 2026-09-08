Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FF4A92D4
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857898; cv=none; b=ETNZdv7gDRctIL4CLMqMqY/nwvJGRvbPkikSLQ5nTQztLzyrX5zlA6vSPGLCQs6s6GXVR5KvweuQkj9G2xcx+yaiOU4ZyCsDlU9qFMvlgQm2uidd5OHCOcnLadOGhK9BmEqTB8eMT6z4+A/IJeaUijGFzbhsCP5p3rXg2njnZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857898; c=relaxed/simple;
	bh=LlrCEuEx0KjfpqvlolK+54sT1rzW+7euprF5WzlTYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ4qevn3AfghcJQ1yxSDFfZjcvZJbTO28HTnsHK9tgctqA8x5pT0pdKH23/rRZGj0Lz8vb/aXhQpp09TGmhaXsPhmo41lCu7KbT9e6V4UKI8MC+4Ym+AGx7O5bexJIzmSwjZo3jRHa7286LgRREX8yNpNpkMPNwp23tz2GNQIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQPZG088; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQPZG088"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED941F00A3D;
	Tue,  8 Sep 2026 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857883;
	bh=UaQX52qCB9HDwe8VCqKqKi/XKZzxrDnpaKyoyeompw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQPZG088EbvgJz0rwCuajgMHUOUYPbDBwyrdZlXgyCh24bD6A5FmVSgZqdNvPe+r7
	 VPLKatS7Cgz4vr0G4IVxbSHaNzsbu3uBGSkNXTE2vUHL47TIPY8iz1EW14f+TtwaJ4
	 Az55j44mW81r1vRwURZn5hg5mI8PdKs8e4wqVolofd645JYsXnwcahne6QD4EpJlou
	 73q7j2Ab/pPWL8ergeELKsEi8R//wqOQHeJlwAmujIan/IflrF2LNxvyynD1jsJSn6
	 V+Vmyk2kWB7Ju9bnR9+0P0awTTDDI9Hgr6TzSvI27TFmeQRZLuV7qqwepHrJqecC5V
	 xImTBeYOPbIjg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 09/16] block: serialize zone revalidation
Date: Tue,  8 Sep 2026 17:57:38 +0900
Message-ID: <20260908085745.1082697-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zone related fields of struct gendisk can be modified by
blk_revalidate_disk_zones() either on the first scan of the disk, or
during user triggered scans or device revalidation, if some
characteristics of the disk has changed (e.g. the disk capacity). Changes
to these fields are always done with the disk request queue frozen so that
BIO processing does not see any inconsistent state of the zones. This
implies a contract that reading these zone related fields must always be
done while holding a usage count on the request queue of the disk.

However, increasing the usage count of the disk request queue cannot be
done from the context of blk_revalidate_disk_zones() itself, as that would
prevent freezing the disk queue and result in a deadlock. This prevents
blk_revalidate_disk_zones() from consulting the zone related fields of
struct gendisk to detect, for instance, a change in the number of zones of
the disk. For such case, we want to detect the change, take appropriate
measures and revalidate exclusively revalidate the zones to avoid
concurrent revalidation calls to see the same change while corrections are
already on-going.

A simple solution to avoid this issue is to introduce a mutex to serialize
calls to blk_revalidate_disk_zones() and ensure only a single context at a
time can modify the zone related fields of a gendisk. In preparation for
handling disk capacity revalidation in blk_revalidate_disk_zones(), do so
with the mutex zone_revalidate_mutex. This mutex is initialized in
disk_init_zone_resources(), destroyed in disk_release_zone_resources() and
taken and released only in blk_revalidate_disk_zones() to serialize the
execution of this function.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 17 +++++++++++++++--
 include/linux/blkdev.h |  9 ++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 70a687bb371f..676620ed93de 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1963,6 +1963,7 @@ static int disk_zone_wplugs_worker(void *data)
 
 void disk_init_zone_resources(struct gendisk *disk)
 {
+	mutex_init(&disk->zone_revalidate_mutex);
 	atomic_set(&disk->nr_zone_wplugs, 0);
 	spin_lock_init(&disk->zone_wplugs_hash_lock);
 	spin_lock_init(&disk->zone_wplugs_list_lock);
@@ -2120,6 +2121,7 @@ void disk_release_zone_resources(struct gendisk *disk)
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
 	disk->nr_zones = 0;
+	mutex_destroy(&disk->zone_revalidate_mutex);
 }
 
 struct blk_revalidate_zone_args {
@@ -2461,6 +2463,12 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		return -ENODEV;
 	}
 
+	/*
+	 * Serialize calls to this function so that we can safely look at and
+	 * eventually change the disk zone information.
+	 */
+	mutex_lock(&disk->zone_revalidate_mutex);
+
 	/*
 	 * Allocate zone resources if they are needed and we have not done
 	 * so yet, and initialize the revalidation arguments passed to report
@@ -2472,14 +2480,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		ret = disk_alloc_zone_resources(disk, args.capacity);
 		if (ret) {
 			memalloc_noio_restore(noio_flag);
-			return ret;
+			goto unlock;
 		}
 	}
 
 	ret = disk_init_revalidate_args(disk, &args);
 	if (ret) {
 		memalloc_noio_restore(noio_flag);
-		return ret;
+		goto unlock;
 	}
 
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX, &rep_args);
@@ -2496,6 +2504,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (ret)
 		goto free_args;
 
+	mutex_unlock(&disk->zone_revalidate_mutex);
+
 	return 0;
 
 free_args:
@@ -2503,6 +2513,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	kfree(args.zones_state);
 
+unlock:
+	mutex_unlock(&disk->zone_revalidate_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a765146a2d3..8252c896e3ea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -191,10 +191,13 @@ struct gendisk {
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*
 	 * Zoned block device information. Reads of this information must be
-	 * protected with blk_queue_enter() / blk_queue_exit(). Modifying this
-	 * information is only allowed while no requests are being processed.
-	 * See also blk_mq_freeze_queue() and blk_mq_unfreeze_queue().
+	 * protected with blk_queue_enter() / blk_queue_exit() or by holding a
+	 * lock on zone_revalidate_mutex. blk_revalidate_disk_zones() may modify
+	 * this information while no requests are being processed (disk queue
+	 * frozen with blk_mq_freeze_queue()) and while holding a lock on
+	 * zone_revalidate_mutex.
 	 */
+	struct mutex		zone_revalidate_mutex;
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
-- 
2.55.0

