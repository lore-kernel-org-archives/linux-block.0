Return-Path: <axboe@kernel.dk>
Received: from ?IPv6:2620:10d:c081:1132::1032? ([2620:10d:c090:180::1:981b])
        by smtp.gmail.com with ESMTPSA id d6-v6sm11069129pgc.38.2018.06.22.12.26.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 12:26:12 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-wbt: fix indefinite background writeback sleep
Message-ID: <0fa9cc9f-7d34-2490-cdaf-fe7a761e4790@kernel.dk>
Date: Fri, 22 Jun 2018 13:26:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

blk-wbt adds waiters to the tail of the waitqueue, and factors in the
task placement in its decision making on whether or not the current task
can proceed. This can cause issues for the lowest class of writers,
since they can get woken up, denied access, and then put back to sleep
at the end of the waitqueue.

Fix this so that we only utilize the tail add for the initial sleep, and
we don't factor in the wait queue placement after we've slept (and are
now using the head addition).

Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 4f89b28fa652..7beeabd05f4a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -550,7 +550,7 @@ static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
 	 * If the waitqueue is already active and we are not the next
 	 * in line to be woken up, wait for our turn.
 	 */
-	if (waitqueue_active(&rqw->wait) &&
+	if (wait && waitqueue_active(&rqw->wait) &&
 	    rqw->wait.head.next != &wait->entry)
 		return false;
 
@@ -567,16 +567,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	__acquires(lock)
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
+	struct wait_queue_entry *waitptr = NULL;
 	DEFINE_WAIT(wait);
 
-	if (may_queue(rwb, rqw, &wait, rw))
+	if (may_queue(rwb, rqw, waitptr, rw))
 		return;
 
+	waitptr = &wait;
 	do {
-		prepare_to_wait_exclusive(&rqw->wait, &wait,
+		/*
+		 * Don't add ourselves to the wq tail if we've already
+		 * slept. Otherwise we can penalize background writes
+		 * indefinitely.
+		 */
+		if (waitptr)
+			prepare_to_wait_exclusive(&rqw->wait, &wait,
+							TASK_UNINTERRUPTIBLE);
+		else
+			prepare_to_wait(&rqw->wait, &wait,
 						TASK_UNINTERRUPTIBLE);
 
-		if (may_queue(rwb, rqw, &wait, rw))
+		if (may_queue(rwb, rqw, waitptr, rw))
 			break;
 
 		if (lock) {
@@ -585,6 +596,12 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			spin_lock_irq(lock);
 		} else
 			io_schedule();
+
+		/*
+		 * After we've slept, we don't want to factor in wq head
+		 * placement anymore for may_queue().
+		 */
+		waitptr = NULL;
 	} while (1);
 
 	finish_wait(&rqw->wait, &wait);

-- 
Jens Axboe
