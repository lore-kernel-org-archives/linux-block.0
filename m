Return-Path: <vliaskovitis@suse.com>
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	roger.pau@citrix.com,
	konrad.wilk@oracle.com,
	axboe@kernel.dk
Subject: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on device removal
Date: Mon, 15 Oct 2018 15:25:08 +0200
Message-Id: <20181015132508.23293-1-vliaskovitis@suse.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

If a block device is hot-added when we are out of grants,
gnttab_grant_foreign_access fails with -ENOSPC (log message "28
granting access to ring page") in this code path:

  talk_to_blkback ->
	setup_blkring ->
		xenbus_grant_ring ->
			gnttab_grant_foreign_access

and the failing path in talk_to_blkback sets the driver_data to NULL:

 destroy_blkring:
        blkif_free(info, 0);

        mutex_lock(&blkfront_mutex);
        free_info(info);
        mutex_unlock(&blkfront_mutex);

        dev_set_drvdata(&dev->dev, NULL);

This results in a NULL pointer BUG when blkfront_remove and blkif_free
try to access the failing device's NULL struct blkfront_info.

Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 drivers/block/xen-blkfront.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 429d20131c7e..8871bf4c8a2e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2493,6 +2493,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 
 	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
 
+	if (!info)
+		return 0;
+
 	blkif_free(info, 0);
 
 	mutex_lock(&info->mutex);
-- 
2.19.0
