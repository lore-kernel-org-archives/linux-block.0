Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: colyli@suse.de,
	axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH 8/9] bcache: do not assign in if condition in bcache_device_init()
Date: Thu, 26 Jul 2018 12:17:40 +0800
Message-Id: <20180726041741.1669-9-colyli@suse.de>
In-Reply-To: <20180726041741.1669-1-colyli@suse.de>
References: <20180726041741.1669-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Florian Schmaus <flo@geekplace.eu>

Fixes an error condition reported by checkpatch.pl which is caused by
assigning a variable in an if condition.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a852018964ad..40fe26fef00f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -796,11 +796,12 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 		return idx;
 
 	if (bioset_init(&d->bio_split, 4, offsetof(struct bbio, bio),
-			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER) ||
-	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
-		ida_simple_remove(&bcache_device_idx, idx);
-		return -ENOMEM;
-	}
+			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
+		goto err;
+
+	d->disk = alloc_disk(BCACHE_MINORS);
+	if (!d->disk)
+		goto err;
 
 	set_capacity(d->disk, sectors);
 	snprintf(d->disk->disk_name, DISK_NAME_LEN, "bcache%i", idx);
@@ -834,6 +835,11 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	blk_queue_write_cache(q, true, true);
 
 	return 0;
+
+err:
+	ida_simple_remove(&bcache_device_idx, idx);
+	return -ENOMEM;
+
 }
 
 /* Cached device */
-- 
2.17.1
