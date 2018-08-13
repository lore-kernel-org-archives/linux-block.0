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
Subject: [PATCH v3 3/5] xen/blkfront: reorder tests in xlblk_init()
Date: Mon, 13 Aug 2018 16:01:12 +0200
Message-Id: <20180813140114.20126-4-jgross@suse.com>
In-Reply-To: <20180813140114.20126-1-jgross@suse.com>
References: <20180813140114.20126-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

In case we don't want pv block devices we should not test parameters
for sanity and eventually print out error messages. So test precluding
conditions before checking parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkfront.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7c4b1b9d3971..36e4ca41e765 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2713,6 +2713,15 @@ static int __init xlblk_init(void)
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
 
@@ -2728,15 +2737,6 @@ static int __init xlblk_init(void)
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
