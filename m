Return-Path: <prvs=8011d1e1c=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v3] block: fix deadline elevator drain for zoned block devices
Date: Thu, 27 Sep 2018 10:55:13 +0900
Message-Id: <20180927015513.24020-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

When the deadline scheduler is used with a zoned block device, writes
to a zone will be dispatched one at a time. This causes the warning
message:

deadline: forced dispatching is broken (nr_sorted=X), please report this

to be displayed when switching to another elevator with the legacy I/O
path while write requests to a zone are being retained in the scheduler
queue.

Prevent this message from being displayed when executing
elv_drain_elevator() for a zoned block device. __blk_drain_queue() will
loop until all writes are dispatched and completed, resulting in the
desired elevator queue drain without extensive modifications to the
deadline code itself to handle forced-dispatch calls.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Fixes: 8dc8146f9c92 ("deadline-iosched: Introduce zone locking support")
Cc: stable@vger.kernel.org
---

Changes from v2:
* Move zoned block device test before 'printed' increment as suggested by Bart
* Added "Fixes" tag and cc stable

Changes from v1:
* Fixed typo in commit message

 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 6a06b5d040e5..fae58b2f906f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -609,7 +609,7 @@ void elv_drain_elevator(struct request_queue *q)
 
 	while (e->type->ops.sq.elevator_dispatch_fn(q, 1))
 		;
-	if (q->nr_sorted && printed++ < 10) {
+	if (q->nr_sorted && !blk_queue_is_zoned(q) && printed++ < 10 ) {
 		printk(KERN_ERR "%s: forced dispatching is broken "
 		       "(nr_sorted=%u), please report this\n",
 		       q->elevator->type->elevator_name, q->nr_sorted);
-- 
2.17.1
