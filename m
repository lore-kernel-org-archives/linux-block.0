Return-Path: <prvs=533ff182d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] pktcdvd: Fix a recently introduced NULL pointer dereference
Date: Tue,  2 Jan 2018 11:39:48 -0800
Message-Id: <20180102193948.22656-3-bart.vanassche@wdc.com>
In-Reply-To: <20180102193948.22656-1-bart.vanassche@wdc.com>
References: <20180102193948.22656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Call bdev_get_queue(bdev) after bdev->bd_disk has been initialized
instead of just before that pointer has been initialized. This patch
avoids that the following command

pktsetup 1 /dev/sr0

triggers the following kernel crash:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000548
IP: pkt_setup_dev+0x2db/0x670 [pktcdvd]
CPU: 2 PID: 724 Comm: pktsetup Not tainted 4.15.0-rc4-dbg+ #1
Call Trace:
 pkt_ctl_ioctl+0xce/0x1c0 [pktcdvd]
 do_vfs_ioctl+0x8e/0x670
 SyS_ioctl+0x3c/0x70
 entry_SYSCALL_64_fastpath+0x23/0x9a

Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: <stable@vger.kernel.org> # v4.13
---
 drivers/block/pktcdvd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2659b2534073..531a0915066b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2579,14 +2579,14 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
+	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
+	if (ret)
+		return ret;
 	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
 		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
-		bdput(bdev);
+		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
-	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
-	if (ret)
-		return ret;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
-- 
2.15.1
