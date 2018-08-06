Return-Path: <jgross@suse.com>
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Cc: konrad.wilk@oracle.com,
	roger.pau@citrix.com,
	axboe@kernel.dk,
	boris.ostrovsky@oracle.com,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/4] xen/blkfront: reorder tests in xlblk_init()
Date: Mon,  6 Aug 2018 13:34:02 +0200
Message-Id: <20180806113403.24728-5-jgross@suse.com>
In-Reply-To: <20180806113403.24728-1-jgross@suse.com>
References: <20180806113403.24728-1-jgross@suse.com>
List-ID: <linux-block@vger.kernel.org>

In case we don't want pv block devices we should not test parameters
for sanity and eventually print out error messages. So test precluding
conditions before checking parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 19feb8835fc4..f72d96384326 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2718,6 +2718,15 @@ static int __init xlblk_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	if (!xen_has_pv_disk_devices())
+		return -ENODEV;
+
+	if (register_blkdev(XENVBD_MAJOR, DEV_NAME)) {
+		pr_warn("xen_blk: can't get major %d with name %s\n",
+			XENVBD_MAJOR, DEV_NAME);
+		return -ENODEV;
+	}
+
 	if (xen_blkif_max_segments < BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		xen_blkif_max_segments = BLKIF_MAX_SEGMENTS_PER_REQUEST;
 
@@ -2733,15 +2742,6 @@ static int __init xlblk_init(void)
 		xen_blkif_max_queues = nr_cpus;
 	}
 
-	if (!xen_has_pv_disk_devices())
-		return -ENODEV;
-
-	if (register_blkdev(XENVBD_MAJOR, DEV_NAME)) {
-		printk(KERN_WARNING "xen_blk: can't get major %d with name %s\n",
-		       XENVBD_MAJOR, DEV_NAME);
-		return -ENODEV;
-	}
-
 	INIT_DELAYED_WORK(&blkfront_work, blkfront_delay_work);
 
 	ret = xenbus_register_frontend(&blkfront_driver);
-- 
2.13.7
