Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau Monn303251 <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 11/12] xen-blkback: Avoid that gcc 7 warns about fall-through when building with W=1
Date: Thu, 17 Aug 2017 16:23:10 -0700
Message-Id: <20170817232311.25948-12-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn303251 <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/block/xen-blkback/blkback.c | 1 +
 drivers/block/xen-blkback/xenbus.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 68157a84bf4d..5f3a813e7ae0 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1251,6 +1251,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		break;
 	case BLKIF_OP_WRITE_BARRIER:
 		drain = true;
+		/* fall through */
 	case BLKIF_OP_FLUSH_DISKCACHE:
 		ring->st_f_req++;
 		operation = REQ_OP_WRITE;
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 792da683e70d..88eaea6475d7 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -810,7 +810,8 @@ static void frontend_changed(struct xenbus_device *dev,
 		xenbus_switch_state(dev, XenbusStateClosed);
 		if (xenbus_dev_is_online(dev))
 			break;
-		/* fall through if not online */
+		/* fall through */
+		/* if not online */
 	case XenbusStateUnknown:
 		/* implies xen_blkif_disconnect() via xen_blkbk_remove() */
 		device_unregister(&dev->dev);
-- 
2.14.0
