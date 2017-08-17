Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42664 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbdHQUO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2017 16:14:57 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Akhil Bhansali <Akhil.Bhansali@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 10/55] skd: Fix spelling in a source code comment
Date: Thu, 17 Aug 2017 13:12:53 -0700
Message-Id: <20170817201338.16537-11-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Change "ptimal" into "optimal" and remove the misleading reference
to sysfs.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 1d0ad31d2256..6c7cf5327d22 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4273,7 +4273,7 @@ static int skd_cons_disk(struct skd_device *skdev)
 	blk_queue_max_segments(q, skdev->sgs_per_request);
 	blk_queue_max_hw_sectors(q, SKD_N_MAX_SECTORS);
 
-	/* set sysfs ptimal_io_size to 8K */
+	/* set optimal I/O size to 8KB */
 	blk_queue_io_opt(q, 8192);
 
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
-- 
2.14.0
