Return-Path: <prvs=800592d6e=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix deadline elevator drain for zoned block devices
Date: Wed, 26 Sep 2018 16:23:16 +0900
Message-Id: <20180926072316.24996-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

When the deadline scheduler is used with a zoned block device, writes
to a zone will be dispatched one a a time. This causes the warning
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
---
 block/elevator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 6a06b5d040e5..8cd81fd6339a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -609,7 +609,7 @@ void elv_drain_elevator(struct request_queue *q)
 
 	while (e->type->ops.sq.elevator_dispatch_fn(q, 1))
 		;
-	if (q->nr_sorted && printed++ < 10) {
+	if (q->nr_sorted && printed++ < 10 && !blk_queue_is_zoned(q)) {
 		printk(KERN_ERR "%s: forced dispatching is broken "
 		       "(nr_sorted=%u), please report this\n",
 		       q->elevator->type->elevator_name, q->nr_sorted);
-- 
2.17.1
