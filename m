Return-Path: <prvs=403a468a2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/4] skd: Make it easier for static analyzers to analyze skd_free_disk()
Date: Fri, 25 Aug 2017 14:24:13 -0700
Message-Id: <20170825212414.28322-4-bart.vanassche@wdc.com>
In-Reply-To: <20170825212414.28322-1-bart.vanassche@wdc.com>
References: <20170825212414.28322-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Although it is easy to see that skdev->disk != NULL if skdev->queue
!= NULL, add a test for skdev->disk to avoid that smatch reports the
following warning:

drivers/block/skd_main.c:3080 skd_free_disk()
         error: we previously assumed 'disk' could be null (see line 3074)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 8ae0320f02b5..34188a600bfa 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3041,7 +3041,8 @@ static void skd_free_disk(struct skd_device *skdev)
 	if (skdev->queue) {
 		blk_cleanup_queue(skdev->queue);
 		skdev->queue = NULL;
-		disk->queue = NULL;
+		if (disk)
+			disk->queue = NULL;
 	}
 
 	if (skdev->tag_set.tags)
-- 
2.14.1
