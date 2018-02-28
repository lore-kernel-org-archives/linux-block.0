Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Shaohua Li <shli@kernel.org>
Subject: [PATCH v5 2/6] md: Delete gendisk before cleaning up the request queue
Date: Wed, 28 Feb 2018 10:15:29 -0800
Message-Id: <20180228181533.29402-3-bart.vanassche@wdc.com>
In-Reply-To: <20180228181533.29402-1-bart.vanassche@wdc.com>
References: <20180228181533.29402-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Remove the disk, partition and bdi sysfs attributes before cleaning up
the request queue associated with the disk.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Shaohua Li <shli@kernel.org>
---
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index bc67ab6844f0..eba7fa2f0abb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5203,12 +5203,12 @@ static void md_free(struct kobject *ko)
 	if (mddev->sysfs_state)
 		sysfs_put(mddev->sysfs_state);
 
+	if (mddev->gendisk)
+		del_gendisk(mddev->gendisk);
 	if (mddev->queue)
 		blk_cleanup_queue(mddev->queue);
-	if (mddev->gendisk) {
-		del_gendisk(mddev->gendisk);
+	if (mddev->gendisk)
 		put_disk(mddev->gendisk);
-	}
 	percpu_ref_exit(&mddev->writes_pending);
 
 	kfree(mddev);
-- 
2.16.2
