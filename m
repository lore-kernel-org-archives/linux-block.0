Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34316 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752538AbcJKAc4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2016 20:32:56 -0400
From: Alexey Klimov <klimov.linux@gmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, axboe@fb.com
Cc: jmoyer@redhat.com, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH RESEND] elevator: remove second argument in elevator_init()
Date: Tue, 11 Oct 2016 01:32:49 +0100
Message-Id: <20161011003249.5010-1-klimov.linux@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Last user of elevator_init() with non-NULL name as second argument
that supposed to be s390 dasd driver has gone few releases ago.
Drivers rely on elevator_change(), elevator_switch() and friends
for example. Right now elevator_init() is always called as
elevator_init(q, NULL).

Patch removes passing of second name argument and its usage.

While we're at it fix following if-check after removed lines. We know
that elevator_type e is initialized by NULL and need to check only
chosen_elevator.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
---
 block/blk-core.c         |  2 +-
 block/elevator.c         | 10 ++--------
 include/linux/elevator.h |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 36c7ac3..6e36d0b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -871,7 +871,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
 	mutex_lock(&q->sysfs_lock);
 
 	/* init elevator */
-	if (elevator_init(q, NULL)) {
+	if (elevator_init(q)) {
 		mutex_unlock(&q->sysfs_lock);
 		goto fail;
 	}
diff --git a/block/elevator.c b/block/elevator.c
index f7d973a..e810938 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -177,7 +177,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-int elevator_init(struct request_queue *q, char *name)
+int elevator_init(struct request_queue *q)
 {
 	struct elevator_type *e = NULL;
 	int err;
@@ -196,18 +196,12 @@ int elevator_init(struct request_queue *q, char *name)
 	q->end_sector = 0;
 	q->boundary_rq = NULL;
 
-	if (name) {
-		e = elevator_get(name, true);
-		if (!e)
-			return -EINVAL;
-	}
-
 	/*
 	 * Use the default elevator specified by config boot param or
 	 * config option.  Don't try to load modules as we could be running
 	 * off async and request_module() isn't allowed from async.
 	 */
-	if (!e && *chosen_elevator) {
+	if (*chosen_elevator) {
 		e = elevator_get(chosen_elevator, false);
 		if (!e)
 			printk(KERN_ERR "I/O scheduler %s not found\n",
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index e7f358d..ab6963e 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -159,7 +159,7 @@ extern void elv_unregister(struct elevator_type *);
 extern ssize_t elv_iosched_show(struct request_queue *, char *);
 extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
 
-extern int elevator_init(struct request_queue *, char *);
+extern int elevator_init(struct request_queue *);
 extern void elevator_exit(struct elevator_queue *);
 extern int elevator_change(struct request_queue *, const char *);
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
-- 
2.9.3

