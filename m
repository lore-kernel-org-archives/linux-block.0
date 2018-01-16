Return-Path: <prvs=547e67762=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 1/3] block: Unexport elv_register_queue() and elv_unregister_queue()
Date: Tue, 16 Jan 2018 10:17:50 -0800
Message-Id: <20180116181752.25847-2-bart.vanassche@wdc.com>
In-Reply-To: <20180116181752.25847-1-bart.vanassche@wdc.com>
References: <20180116181752.25847-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

These two functions are only called from inside the block layer so
unexport them.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk.h              | 3 +++
 block/elevator.c         | 2 --
 include/linux/elevator.h | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 662005e46560..46db5dc83dcb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -162,6 +162,9 @@ static inline void elv_deactivate_rq(struct request_queue *q, struct request *rq
 		e->type->ops.sq.elevator_deactivate_req_fn(q, rq);
 }
 
+int elv_register_queue(struct request_queue *q);
+void elv_unregister_queue(struct request_queue *q);
+
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 
 #ifdef CONFIG_FAIL_IO_TIMEOUT
diff --git a/block/elevator.c b/block/elevator.c
index 138faeb08a7c..4f00b53cd5fd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -886,7 +886,6 @@ int elv_register_queue(struct request_queue *q)
 	}
 	return error;
 }
-EXPORT_SYMBOL(elv_register_queue);
 
 void elv_unregister_queue(struct request_queue *q)
 {
@@ -900,7 +899,6 @@ void elv_unregister_queue(struct request_queue *q)
 		wbt_enable_default(q);
 	}
 }
-EXPORT_SYMBOL(elv_unregister_queue);
 
 int elv_register(struct elevator_type *e)
 {
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 3d794b3dc532..6d9e230dffd2 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -198,8 +198,6 @@ extern bool elv_attempt_insert_merge(struct request_queue *, struct request *);
 extern void elv_requeue_request(struct request_queue *, struct request *);
 extern struct request *elv_former_request(struct request_queue *, struct request *);
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
-extern int elv_register_queue(struct request_queue *q);
-extern void elv_unregister_queue(struct request_queue *q);
 extern int elv_may_queue(struct request_queue *, unsigned int);
 extern void elv_completed_request(struct request_queue *, struct request *);
 extern int elv_set_request(struct request_queue *q, struct request *rq,
-- 
2.15.1
