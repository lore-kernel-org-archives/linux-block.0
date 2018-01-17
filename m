Return-Path: <prvs=5482b108a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 2/3] block: Document scheduler modification locking requirements
Date: Wed, 17 Jan 2018 11:48:09 -0800
Message-Id: <20180117194810.26583-3-bart.vanassche@wdc.com>
In-Reply-To: <20180117194810.26583-1-bart.vanassche@wdc.com>
References: <20180117194810.26583-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/elevator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 4f00b53cd5fd..e87e9b43aba0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -869,6 +869,8 @@ int elv_register_queue(struct request_queue *q)
 	struct elevator_queue *e = q->elevator;
 	int error;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	error = kobject_add(&e->kobj, &q->kobj, "%s", "iosched");
 	if (!error) {
 		struct elv_fs_entry *attr = e->type->elevator_attrs;
@@ -889,6 +891,8 @@ int elv_register_queue(struct request_queue *q)
 
 void elv_unregister_queue(struct request_queue *q)
 {
+	lockdep_assert_held(&q->sysfs_lock);
+
 	if (q) {
 		struct elevator_queue *e = q->elevator;
 
@@ -965,6 +969,8 @@ static int elevator_switch_mq(struct request_queue *q,
 {
 	int ret;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
@@ -1010,6 +1016,8 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	bool old_registered = false;
 	int err;
 
+	lockdep_assert_held(&q->sysfs_lock);
+
 	if (q->mq_ops)
 		return elevator_switch_mq(q, new_e);
 
-- 
2.15.1
