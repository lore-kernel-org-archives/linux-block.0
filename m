Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33526 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdAWXsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 18:48:38 -0500
Received: by mail-pg0-f45.google.com with SMTP id 204so49039045pge.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 15:48:28 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq-sched: fix possible crash if changing scheduler fails
Date: Mon, 23 Jan 2017 15:47:56 -0800
Message-Id: <b83737e281e311179615f93be9cfbae50addb1a0.1485215087.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In elevator_switch(), we free the old scheduler's tags and then
initialize the new scheduler. If initializing the new scheduler fails,
we fall back to the old scheduler, but our tags have already been freed.
There's no reason to free the sched_tags only to reallocate them, so
let's just reuse them, which makes it possible to safely fall back to
the old scheduler.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Applies to for-4.11/block. Reproduced the issue and verified the fix by
sticking an err = -ENOMEM in the right place. As far as I can tell, it's
safe to reuse the previously allocated sched_tags for the new scheduler.

 block/elevator.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index ef7f59469acc..28283aaab04c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -963,9 +963,6 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	if (old) {
 		old_registered = old->registered;
 
-		if (old->uses_mq)
-			blk_mq_sched_teardown(q);
-
 		if (!q->mq_ops)
 			blk_queue_bypass_start(q);
 
@@ -981,7 +978,14 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	/* allocate, init and register new elevator */
 	if (new_e) {
 		if (new_e->uses_mq) {
-			err = blk_mq_sched_setup(q);
+			/*
+			 * If we were previously using an I/O scheduler, the
+			 * sched_tags are already allocated.
+			 */
+			if (old)
+				err = 0;
+			else
+				err = blk_mq_sched_setup(q);
 			if (!err)
 				err = new_e->ops.mq.init_sched(q, new_e);
 		} else
@@ -997,6 +1001,12 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 	/* done, kill the old one and finish */
 	if (old) {
+		/*
+		 * If we switched to another I/O scheduler, then we shouldn't
+		 * free sched_tags.
+		 */
+		if (old->uses_mq && !new_e)
+			blk_mq_sched_teardown(q);
 		elevator_exit(old);
 		if (!q->mq_ops)
 			blk_queue_bypass_end(q);
@@ -1015,7 +1025,7 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	return 0;
 
 fail_register:
-	if (q->mq_ops)
+	if (q->mq_ops && !old)
 		blk_mq_sched_teardown(q);
 	elevator_exit(q->elevator);
 fail_init:
-- 
2.11.0

