Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block: make elevator_get robust against cross blk/blk-mq choice
Date: Mon, 13 Feb 2017 22:01:07 +0100
Message-Id: <20170213210107.4848-2-paolo.valente@linaro.org>
In-Reply-To: <20170213210107.4848-1-paolo.valente@linaro.org>
References: <20170213210107.4848-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

If, at boot, a legacy I/O scheduler is chosen for a device using blk-mq,
or, viceversa, a blk-mq scheduler is chosen for a device using blk, then
that scheduler is set and initialized without any check, driving the
system into an inconsistent state. This commit addresses this issue by
letting elevator_get fail for these wrong cross choices.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/elevator.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 27ff1ed..a25bdd9 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -99,7 +99,8 @@ static void elevator_put(struct elevator_type *e)
 	module_put(e->elevator_owner);
 }
 
-static struct elevator_type *elevator_get(const char *name, bool try_loading)
+static struct elevator_type *elevator_get(const char *name, bool try_loading,
+					  bool mq_ops)
 {
 	struct elevator_type *e;
 
@@ -113,6 +114,12 @@ static struct elevator_type *elevator_get(const char *name, bool try_loading)
 		e = elevator_find(name);
 	}
 
+	if (e && (e->uses_mq != mq_ops)) {
+		pr_err("ERROR: attempted to choose %s %s I/O scheduler in blk%s",
+		       name, e->uses_mq ? "blk-mq" : "legacy", mq_ops ? "-mq" : "");
+		e = NULL;
+	}
+
 	if (e && !try_module_get(e->elevator_owner))
 		e = NULL;
 
@@ -201,7 +208,7 @@ int elevator_init(struct request_queue *q, char *name)
 	q->boundary_rq = NULL;
 
 	if (name) {
-		e = elevator_get(name, true);
+		e = elevator_get(name, true, q->mq_ops);
 		if (!e)
 			return -EINVAL;
 	}
@@ -212,7 +219,7 @@ int elevator_init(struct request_queue *q, char *name)
 	 * off async and request_module() isn't allowed from async.
 	 */
 	if (!e && *chosen_elevator) {
-		e = elevator_get(chosen_elevator, false);
+		e = elevator_get(chosen_elevator, false, q->mq_ops);
 		if (!e)
 			printk(KERN_ERR "I/O scheduler %s not found\n",
 							chosen_elevator);
@@ -220,17 +227,20 @@ int elevator_init(struct request_queue *q, char *name)
 
 	if (!e) {
 		if (q->mq_ops && q->nr_hw_queues == 1)
-			e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false);
+			e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false,
+					 q->mq_ops);
 		else if (q->mq_ops)
-			e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
+			e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false,
+					 q->mq_ops);
 		else
-			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false,
+					 q->mq_ops);
 
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
 				"Using noop/none.\n");
-			e = elevator_get("noop", false);
+			e = elevator_get("noop", false, q->mq_ops);
 		}
 	}
 
@@ -1051,7 +1061,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
-	e = elevator_get(strstrip(elevator_name), true);
+	e = elevator_get(strstrip(elevator_name), true, q->mq_ops);
 	if (!e) {
 		printk(KERN_ERR "elevator: type %s not found\n", elevator_name);
 		return -EINVAL;
-- 
2.10.0
