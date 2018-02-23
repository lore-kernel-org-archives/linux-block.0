Return-Path: <prvs=585cc836a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Josef Bacik <jbacik@fb.com>,
	Shaohua Li <shli@fb.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 1/6] block/loop: Delete gendisk before cleaning up the request queue
Date: Thu, 22 Feb 2018 17:08:03 -0800
Message-Id: <20180223010808.25765-2-bart.vanassche@wdc.com>
In-Reply-To: <20180223010808.25765-1-bart.vanassche@wdc.com>
References: <20180223010808.25765-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Remove the disk, partition and bdi sysfs attributes before cleaning up
the request queue associated with the disk.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Shaohua Li <shli@fb.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d5fe720cf149..8b693fdd08dc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1864,8 +1864,8 @@ static int loop_add(struct loop_device **l, int i)
 
 static void loop_remove(struct loop_device *lo)
 {
-	blk_cleanup_queue(lo->lo_queue);
 	del_gendisk(lo->lo_disk);
+	blk_cleanup_queue(lo->lo_queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	put_disk(lo->lo_disk);
 	kfree(lo);
-- 
2.16.2
