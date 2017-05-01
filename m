Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, "Markus
 Trippelsdorf" <markus@trippelsdorf.de>
Subject: [PATCH] block: Remove elevator_change()
Date: Mon, 1 May 2017 08:58:49 -0700
Message-ID: <20170501155849.5134-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since commit 84253394927c ("remove the mg_disk driver") removed the
only caller of elevator_change(), also remove the elevator_change()
function itself.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>
---
 block/elevator.c         | 13 -------------
 include/linux/elevator.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index c7a4ee682033..ab726a5c0bf6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1085,19 +1085,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	return elevator_switch(q, e);
 }
 
-int elevator_change(struct request_queue *q, const char *name)
-{
-	int ret;
-
-	/* Protect q->elevator from elevator_init() */
-	mutex_lock(&q->sysfs_lock);
-	ret = __elevator_change(q, name);
-	mutex_unlock(&q->sysfs_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(elevator_change);
-
 static inline bool elv_support_iosched(struct request_queue *q)
 {
 	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 3a216318ae73..d44840368ee7 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -214,7 +214,6 @@ extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
 
 extern int elevator_init(struct request_queue *, char *);
 extern void elevator_exit(struct request_queue *, struct elevator_queue *);
-extern int elevator_change(struct request_queue *, const char *);
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
 extern struct elevator_queue *elevator_alloc(struct request_queue *,
 					struct elevator_type *);
-- 
2.12.2
