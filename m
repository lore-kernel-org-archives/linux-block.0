Return-Path: <prvs=585cc836a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH v4 3/6] zram: Delete gendisk before cleaning up the request queue
Date: Thu, 22 Feb 2018 17:08:05 -0800
Message-Id: <20180223010808.25765-4-bart.vanassche@wdc.com>
In-Reply-To: <20180223010808.25765-1-bart.vanassche@wdc.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Remove the disk, partition and bdi sysfs attributes before cleaning up
the request queue associated with the disk.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0afa6c8c3857..85110e7931e5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1620,8 +1620,8 @@ static int zram_remove(struct zram *zram)
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
-	blk_cleanup_queue(zram->disk->queue);
 	del_gendisk(zram->disk);
+	blk_cleanup_queue(zram->disk->queue);
 	put_disk(zram->disk);
 	kfree(zram);
 	return 0;
-- 
2.16.2
