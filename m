Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau Monn303251 <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 12/12] xen-blkfront: Avoid that gcc 7 warns about fall-through when building with W=1
Date: Thu, 17 Aug 2017 16:23:11 -0700
Message-Id: <20170817232311.25948-13-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn303251 <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/block/xen-blkfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 98e34e4c62b8..270019e3e5d8 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2456,7 +2456,7 @@ static void blkback_changed(struct xenbus_device *dev,
 	case XenbusStateClosed:
 		if (dev->state == XenbusStateClosed)
 			break;
-		/* Missed the backend's Closing state -- fallthrough */
+		/* fall through */
 	case XenbusStateClosing:
 		if (info)
 			blkfront_closing(info);
-- 
2.14.0
