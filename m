Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: unsik Kim <donari75@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH] mg_disk: fix error path in mg_probe()
Date: Tue, 28 Jun 2016 15:42:41 +0200
Message-id: <1467121361-21632-1-git-send-email-b.zolnierkie@samsung.com>
List-ID: <linux-block@vger.kernel.org>

MG_DISK_MAJ is defined as 0 so dynamic block major number
allocation is used by the driver and the assigned major
number is stored in host->major.  This patch fixes error
path in mg_probe() to use host->major instead of using
MG_DISK_MAJ.

Cc: unsik Kim <donari75@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/block/mg_disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mg_disk.c b/drivers/block/mg_disk.c
index 1ee3918..e937fcf7 100644
--- a/drivers/block/mg_disk.c
+++ b/drivers/block/mg_disk.c
@@ -1015,7 +1015,7 @@ probe_err_7:
 probe_err_6:
 	blk_cleanup_queue(host->breq);
 probe_err_5:
-	unregister_blkdev(MG_DISK_MAJ, MG_DISK_NAME);
+	unregister_blkdev(host->major, MG_DISK_NAME);
 probe_err_4:
 	if (!prv_data->use_polling)
 		free_irq(host->irq, host);
-- 
1.9.1
