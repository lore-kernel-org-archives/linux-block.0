Return-Path: <prvs=533ff182d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	"Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pktcdvd: Fix pkt_setup_dev() error path
Date: Tue,  2 Jan 2018 11:39:47 -0800
Message-Id: <20180102193948.22656-2-bart.vanassche@wdc.com>
In-Reply-To: <20180102193948.22656-1-bart.vanassche@wdc.com>
References: <20180102193948.22656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
modified add_disk() and disk_release() but did not update any of the
error paths that trigger a put_disk() call after disk->queue has been
assigned. That introduced the following behavior in the pktcdvd driver
if pkt_new_dev() fails:

Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]

Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
error path.

Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: <stable@vger.kernel.org> # v3.2
---
 drivers/block/pktcdvd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 67974796c350..2659b2534073 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2745,7 +2745,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
@@ -2763,8 +2763,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	mutex_unlock(&ctl_mutex);
 	return 0;
 
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
-- 
2.15.1
