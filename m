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
Subject: [PATCH 33/55] skd: Remove a redundant init_timer() call
Date: Thu, 17 Aug 2017 13:13:16 -0700
Message-Id: <20170817201338.16537-34-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since setup_timer() invokes init_timer(), invoking init_timer()
just before setup_timer() is redundant. Hence remove the init_timer()
call.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 62e06e35ddf5..71158e8b8a2b 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1057,7 +1057,6 @@ static int skd_start_timer(struct skd_device *skdev)
 {
 	int rc;
 
-	init_timer(&skdev->timer);
 	setup_timer(&skdev->timer, skd_timer_tick, (ulong)skdev);
 
 	rc = mod_timer(&skdev->timer, (jiffies + HZ));
-- 
2.14.0
