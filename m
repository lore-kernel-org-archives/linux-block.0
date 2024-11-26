Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F013C3F6
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611237; cv=none; b=WrbcusPgxsePLzi1tLjJCxtXkgBLvSs8sk53JcAv4LZP3GQz7+L7sFj7d+mM7haKvSd+gaPZLLzltNTXk6ucbG7l3rStnuqZoKCQZuunszx1p77lOjaO9d7sUsQnbQmeA9TMyl6dk77nClhSdC0tTL8frWPJFPMAubjlZxdwCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611237; c=relaxed/simple;
	bh=H5hmi/wf1nwowtAee/KUb3arpvhu0f8OYyXdfpU0Z6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gb+EPWDTDTNpQI7vOBRt13EIj/RNxcVU7yH9yScjpI8nbDL0X9wmwWIXzZK4jVFCqkC8iyZuUc14CsCuUZDr4V+jFS1QFTzQ+lYASgt2EFVcUavol119VMDdW4t8leKlN+KtcjrXXWMkNVVNUu4dU0eQJwAawuX7G2sI6dPmzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaUpM9HN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaUpM9HN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C04CC4CECF;
	Tue, 26 Nov 2024 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732611237;
	bh=H5hmi/wf1nwowtAee/KUb3arpvhu0f8OYyXdfpU0Z6I=;
	h=From:To:Cc:Subject:Date:From;
	b=FaUpM9HN/x4rQecKGSpk42Jr/gVy22CcVVKqfq0cmVao+YcjNcbIM7x/GZRPfP/EG
	 7fuZY3wKR8YeS6Y+dns0CLzuvruFcNlecewCTFLdEGIZmEyhrQ+jT5Q1N/T534kYhf
	 eQFVpSYh5dijMLXj58wFZLEbKSudpo3GCO4/Xq6lhhE39WCL5avJevm9paZJzmTY+U
	 taGsjosnSB200Bkdic1GKwENSNJvowqGkZOhu9MlRKqKdC2Yw9s/fwLyUCBMCqOJZE
	 4AkveSgsoUykAfWe55s3UFRTBU3ucgMEEjiVNvkMMFbQBmSAITSnQHK5MyuwhaPqkC
	 bP9UW+DjKpsvw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Prevent potential deadlock in blk_revalidate_disk_zones()
Date: Tue, 26 Nov 2024 17:53:42 +0900
Message-ID: <20241126085342.173158-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function blk_revalidate_disk_zones() calls the function
disk_update_zone_resources() after freezing the device queue. In turn,
disk_update_zone_resources() calls queue_limits_start_update() which
takes a queue limits mutex lock, resulting in the ordering:
q->q_usage_counter check -> q->limits_lock. However, the usual ordering
is to always take a queue limit lock before freezing the queue to commit
the limits updates, e.g., the code pattern:

lim = queue_limits_start_update(q);
...
blk_mq_freeze_queue(q);
ret = queue_limits_commit_update(q, &lim);
blk_mq_unfreeze_queue(q);

Thus, blk_revalidate_disk_zones() introduces a potential circular
locking dependency deadlock that lockdep sometimes catches with the
splat:

[   51.934109] ======================================================
[   51.935916] WARNING: possible circular locking dependency detected
[   51.937561] 6.12.0+ #2107 Not tainted
[   51.938648] ------------------------------------------------------
[   51.940351] kworker/u16:4/157 is trying to acquire lock:
[   51.941805] ffff9fff0aa0bea8 (&q->limits_lock){+.+.}-{4:4}, at: disk_update_zone_resources+0x86/0x170
[   51.944314]
               but task is already holding lock:
[   51.945688] ffff9fff0aa0b890 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: blk_revalidate_disk_zones+0x15f/0x340
[   51.948527]
               which lock already depends on the new lock.

[   51.951296]
               the existing dependency chain (in reverse order) is:
[   51.953708]
               -> #1 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
[   51.956131]        blk_queue_enter+0x1c9/0x1e0
[   51.957290]        blk_mq_alloc_request+0x187/0x2a0
[   51.958365]        scsi_execute_cmd+0x78/0x490 [scsi_mod]
[   51.959514]        read_capacity_16+0x111/0x410 [sd_mod]
[   51.960693]        sd_revalidate_disk.isra.0+0x872/0x3240 [sd_mod]
[   51.962004]        sd_probe+0x2d7/0x520 [sd_mod]
[   51.962993]        really_probe+0xd5/0x330
[   51.963898]        __driver_probe_device+0x78/0x110
[   51.964925]        driver_probe_device+0x1f/0xa0
[   51.965916]        __driver_attach_async_helper+0x60/0xe0
[   51.967017]        async_run_entry_fn+0x2e/0x140
[   51.968004]        process_one_work+0x21f/0x5a0
[   51.968987]        worker_thread+0x1dc/0x3c0
[   51.969868]        kthread+0xe0/0x110
[   51.970377]        ret_from_fork+0x31/0x50
[   51.970983]        ret_from_fork_asm+0x11/0x20
[   51.971587]
               -> #0 (&q->limits_lock){+.+.}-{4:4}:
[   51.972479]        __lock_acquire+0x1337/0x2130
[   51.973133]        lock_acquire+0xc5/0x2d0
[   51.973691]        __mutex_lock+0xda/0xcf0
[   51.974300]        disk_update_zone_resources+0x86/0x170
[   51.975032]        blk_revalidate_disk_zones+0x16c/0x340
[   51.975740]        sd_zbc_revalidate_zones+0x73/0x160 [sd_mod]
[   51.976524]        sd_revalidate_disk.isra.0+0x465/0x3240 [sd_mod]
[   51.977824]        sd_probe+0x2d7/0x520 [sd_mod]
[   51.978917]        really_probe+0xd5/0x330
[   51.979915]        __driver_probe_device+0x78/0x110
[   51.981047]        driver_probe_device+0x1f/0xa0
[   51.982143]        __driver_attach_async_helper+0x60/0xe0
[   51.983282]        async_run_entry_fn+0x2e/0x140
[   51.984319]        process_one_work+0x21f/0x5a0
[   51.985873]        worker_thread+0x1dc/0x3c0
[   51.987289]        kthread+0xe0/0x110
[   51.988546]        ret_from_fork+0x31/0x50
[   51.989926]        ret_from_fork_asm+0x11/0x20
[   51.991376]
               other info that might help us debug this:

[   51.994127]  Possible unsafe locking scenario:

[   51.995651]        CPU0                    CPU1
[   51.996694]        ----                    ----
[   51.997716]   lock(&q->q_usage_counter(queue)#3);
[   51.998817]                                lock(&q->limits_lock);
[   52.000043]                                lock(&q->q_usage_counter(queue)#3);
[   52.001638]   lock(&q->limits_lock);
[   52.002485]
                *** DEADLOCK ***

Prevent this issue by moving the calls to blk_mq_freeze_queue() and
blk_mq_unfreeze_queue() around the call to queue_limits_commit_update()
in disk_update_zone_resources(). disk_free_zone_resources() is also
modified to operate with the queue frozen as before by adding calls to
blk_mq_freeze_queue() and blk_mq_unfreeze_queue().

Fixes: 843283e96e5a ("block: Fake max open zones limit when there is no limit")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 70211751df16..1f961088b813 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1468,9 +1468,13 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
 
 void disk_free_zone_resources(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
+
 	if (!disk->zone_wplugs_pool)
 		return;
 
+	blk_mq_freeze_queue(q);
+
 	cancel_work_sync(&disk->zone_wplugs_work);
 
 	if (disk->zone_wplugs_wq) {
@@ -1493,6 +1497,8 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
 	disk->nr_zones = 0;
+
+	blk_mq_unfreeze_queue(q);
 }
 
 static inline bool disk_need_zone_resources(struct gendisk *disk)
@@ -1551,6 +1557,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	unsigned int nr_seq_zones, nr_conv_zones;
 	unsigned int pool_size;
 	struct queue_limits lim;
+	int ret;
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1601,7 +1608,11 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update(q, &lim);
+	blk_mq_freeze_queue(q);
+	ret = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
@@ -1816,14 +1827,12 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 * Set the new disk zone parameters only once the queue is frozen and
 	 * all I/Os are completed.
 	 */
-	blk_mq_freeze_queue(q);
 	if (ret > 0)
 		ret = disk_update_zone_resources(disk, &args);
 	else
 		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 	if (ret)
 		disk_free_zone_resources(disk);
-	blk_mq_unfreeze_queue(q);
 
 	return ret;
 }
-- 
2.47.0

