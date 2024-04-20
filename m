Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5F14003
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599894; cv=none; b=ucV0Y+EtcgRZRKTKEL1wsxvOp0rQPyANJD7d+Qnv+lwE8ZJRbGW17cjAExfavrDxRv/sS8CYzJQ1Tn9yclLNR1kyT65GdwUO3IHgrPDInVk7EVmopThhKr8Um1BcOyqpDpFMv5Cmt4imXR5tFLaF0n+oDWkXvqyd0InM+K09tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599894; c=relaxed/simple;
	bh=fsrsPeVF6bOK8NzxwtQ1C2hSLYsP4sLBfQ5gj6kgIGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Fg16kNHWXX55Hmqwoe6V1JkH06rIwrEQpUe16Dvq042JtYTf/0XWReXoJYQTI/JcAOdAd2bTaysK+iRQ6Yh0uo3vOsvOne5ZX4k4EPp1rO3dy6FYO8gybj9WCLLPfCyvPyWmNbxrL4fa00RX53z9wehYZ/+aWjT42NgNNzzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKCKvbuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKCKvbuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14318C32781;
	Sat, 20 Apr 2024 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713599894;
	bh=fsrsPeVF6bOK8NzxwtQ1C2hSLYsP4sLBfQ5gj6kgIGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OKCKvbuzY3z5t0Ae43/uEC76G00e2fb36I+WnsaQvuulc7R9hxCTsj0kz9YZcswsP
	 ZKL2+8mGxTpSfCjb1WkTUNqD9QFtiCAzE9yU63saeXG/IxXFqlrmm84IeJ7R6f8z5t
	 HmE4xebEhxyvTsI/tvIgbVeHjgxG0In0ep1Kr4nGmoh8JLdnQtlrhZVLJSJHnvUKOF
	 xukzieFQ5g9DX3tP5983qQeYnUo5u5hKfwZvHxrFLlrOTI2HTpi8QmjDE8PdamHcbP
	 a76y3WiwVzgM4CRoPuDErIP6SWkRSrsMDN2CF0xTxj8HEA6PH4dfwHqjQEbew0DGsP
	 bHkWb4/mhflkA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 2/2] block: use a per disk workqueue for zone write plugging
Date: Sat, 20 Apr 2024 16:58:11 +0900
Message-ID: <20240420075811.1276893-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420075811.1276893-1-dlemoal@kernel.org>
References: <20240420075811.1276893-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A zone write plug BIO work function blk_zone_wplug_bio_work() calls
submit_bio_noacct_nocheck() to execute the next unplugged BIO. This
function may block. So executing zone plugs BIO works using the block
layer global kblockd workqueue can potentially lead to preformance or
latency issues as the number of concurrent work for a workqueue is
limited to WQ_DFL_ACTIVE (256).
1) For a system with a large number of zoned disks, issuing write
   requests to otherwise unused zones may be delayed wiating for a work
   thread to become available.
2) Requeue operations which use kblockd but are independent of zone
   write plugging may alsoi end up being delayed.

To avoid these potential performance issues, create a workqueue per
zoned device to execute zone plugs BIO work. The workqueue max active
parameter is set to the maximum number of zone write plugs allocated
with the zone write plug mempool. This limit is equal to the maximum
number of open zones of the disk and defaults to 128 for disks that do
not have a limit on the number of open zones.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 32 ++++++++++++++++++++++++--------
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 685f0b9159fd..4f5bf1c0a99f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1131,7 +1131,7 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	/* Schedule submission of the next plugged BIO if we have one. */
 	if (!bio_list_empty(&zwplug->bio_list)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
-		kblockd_schedule_work(&zwplug->bio_work);
+		queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
 		return;
 	}
 
@@ -1334,7 +1334,7 @@ static void disk_zone_wplug_handle_error(struct gendisk *disk,
 	/* Restart BIO submission if we still have any BIO left. */
 	if (!bio_list_empty(&zwplug->bio_list)) {
 		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-		kblockd_schedule_work(&zwplug->bio_work);
+		queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
 		goto unlock;
 	}
 
@@ -1411,14 +1411,25 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 
 	disk->zone_wplugs_pool = mempool_create_kmalloc_pool(pool_size,
 						sizeof(struct blk_zone_wplug));
-	if (!disk->zone_wplugs_pool) {
-		kfree(disk->zone_wplugs_hash);
-		disk->zone_wplugs_hash = NULL;
-		disk->zone_wplugs_hash_bits = 0;
-		return -ENOMEM;
-	}
+	if (!disk->zone_wplugs_pool)
+		goto free_hash;
+
+	disk->zone_wplugs_wq =
+		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI,
+				pool_size, disk->disk_name);
+	if (!disk->zone_wplugs_wq)
+		goto destroy_pool;
 
 	return 0;
+
+destroy_pool:
+	mempool_destroy(disk->zone_wplugs_pool);
+	disk->zone_wplugs_pool = NULL;
+free_hash:
+	kfree(disk->zone_wplugs_hash);
+	disk->zone_wplugs_hash = NULL;
+	disk->zone_wplugs_hash_bits = 0;
+	return -ENOMEM;
 }
 
 static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
@@ -1449,6 +1460,11 @@ void disk_free_zone_resources(struct gendisk *disk)
 {
 	cancel_work_sync(&disk->zone_wplugs_work);
 
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
+
 	disk_destroy_zone_wplugs_hash_table(disk);
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c62536c78a46..a2847f8e5f82 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -191,6 +191,7 @@ struct gendisk {
 	struct hlist_head       *zone_wplugs_hash;
 	struct list_head        zone_wplugs_err_list;
 	struct work_struct	zone_wplugs_work;
+	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 #if IS_ENABLED(CONFIG_CDROM)
-- 
2.44.0

