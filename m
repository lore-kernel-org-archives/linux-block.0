Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 09/55] skd: Avoid that gcc 7 warns about fall-through when building with W=1
Date: Thu, 17 Aug 2017 13:12:52 -0700
Message-Id: <20170817201338.16537-10-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index aa6bfd1391da..1d0ad31d2256 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2340,7 +2340,7 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 			blk_requeue_request(skdev->queue, skreq->req);
 			break;
 		}
-	/* fall through to report error */
+		/* fall through */
 
 	case SKD_CHECK_STATUS_REPORT_ERROR:
 	default:
-- 
2.14.0
