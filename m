Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 02/55] skd: Avoid that module unloading triggers a use-after-free
Date: Thu, 17 Aug 2017 13:12:45 -0700
Message-Id: <20170817201338.16537-3-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since put_disk() triggers a disk_release() call and since that
last function calls blk_put_queue() if disk->queue != NULL, clear
the disk->queue pointer before calling put_disk(). This avoids
that unloading the skd kernel module triggers the following
use-after-free:

WARNING: CPU: 8 PID: 297 at lib/refcount.c:128 refcount_sub_and_test+0x70/0x80
refcount_t: underflow; use-after-free.
CPU: 8 PID: 297 Comm: kworker/8:1 Not tainted 4.11.10-300.fc26.x86_64 #1
Workqueue: events work_for_cpu_fn
Call Trace:
 dump_stack+0x63/0x84
 __warn+0xcb/0xf0
 warn_slowpath_fmt+0x5a/0x80
 refcount_sub_and_test+0x70/0x80
 refcount_dec_and_test+0x11/0x20
 kobject_put+0x1f/0x50
 blk_put_queue+0x15/0x20
 disk_release+0xae/0xf0
 device_release+0x32/0x90
 kobject_release+0x67/0x170
 kobject_put+0x2b/0x50
 put_disk+0x17/0x20
 skd_destruct+0x5c/0x890 [skd]
 skd_pci_probe+0x124d/0x13a0 [skd]
 local_pci_probe+0x42/0xa0
 work_for_cpu_fn+0x14/0x20
 process_one_work+0x19e/0x470
 worker_thread+0x1dc/0x4a0
 kthread+0x125/0x140
 ret_from_fork+0x25/0x30

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: <stable@vger.kernel.org>
---
 drivers/block/skd_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index d0368682bd43..edab9c04e8ad 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4539,15 +4539,16 @@ static void skd_free_disk(struct skd_device *skdev)
 {
 	struct gendisk *disk = skdev->disk;
 
-	if (disk != NULL) {
-		struct request_queue *q = disk->queue;
-
-		if (disk->flags & GENHD_FL_UP)
-			del_gendisk(disk);
-		if (q)
-			blk_cleanup_queue(q);
-		put_disk(disk);
+	if (disk && (disk->flags & GENHD_FL_UP))
+		del_gendisk(disk);
+
+	if (skdev->queue) {
+		blk_cleanup_queue(skdev->queue);
+		skdev->queue = NULL;
+		disk->queue = NULL;
 	}
+
+	put_disk(disk);
 	skdev->disk = NULL;
 }
 
-- 
2.14.0
