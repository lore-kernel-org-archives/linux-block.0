Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: add 'requeue' fault attribute
Message-ID: <e3116aee-ae06-a415-c56f-30c3780f6a67@kernel.dk>
Date: Tue, 27 Feb 2018 15:34:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Similarly to the support we have for testing/faking timeouts for
null_blk, this adds support for triggering a requeue condition.
Considering the issues around restart we've been seeing, this should be
a useful addition to the testing arsenal to ensure that we are handling
requeue conditions correctly.

This works for queue mode 1 (legacy request_fn based path) and 2 (blk-mq
path), as there's no good way to do requeue with a bio based driver.
This is similar to the timeout path.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

 null_blk.c |   55 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 287a09611c0f..363536572e19 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -29,6 +29,7 @@
 
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 static DECLARE_FAULT_ATTR(null_timeout_attr);
+static DECLARE_FAULT_ATTR(null_requeue_attr);
 #endif
 
 static inline u64 mb_per_tick(int mbps)
@@ -170,6 +171,9 @@ MODULE_PARM_DESC(home_node, "Home node for the device");
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
 static char g_timeout_str[80];
 module_param_string(timeout, g_timeout_str, sizeof(g_timeout_str), S_IRUGO);
+
+static char g_requeue_str[80];
+module_param_string(requeue, g_requeue_str, sizeof(g_requeue_str), S_IRUGO);
 #endif
 
 static int g_queue_mode = NULL_Q_MQ;
@@ -1380,7 +1384,15 @@ static bool should_timeout_request(struct request *rq)
 	if (g_timeout_str[0])
 		return should_fail(&null_timeout_attr, 1);
 #endif
+	return false;
+}
 
+static bool should_requeue_request(struct request *rq)
+{
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+	if (g_requeue_str[0])
+		return should_fail(&null_requeue_attr, 1);
+#endif
 	return false;
 }
 
@@ -1391,11 +1403,17 @@ static void null_request_fn(struct request_queue *q)
 	while ((rq = blk_fetch_request(q)) != NULL) {
 		struct nullb_cmd *cmd = rq->special;
 
-		if (!should_timeout_request(rq)) {
-			spin_unlock_irq(q->queue_lock);
-			null_handle_cmd(cmd);
-			spin_lock_irq(q->queue_lock);
+		/* just ignore the request */
+		if (should_timeout_request(rq))
+			continue;
+		if (should_requeue_request(rq)) {
+			blk_requeue_request(q, rq);
+			continue;
 		}
+
+		spin_unlock_irq(q->queue_lock);
+		null_handle_cmd(cmd);
+		spin_lock_irq(q->queue_lock);
 	}
 }
 
@@ -1422,10 +1440,12 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(bd->rq);
 
-	if (!should_timeout_request(bd->rq))
-		return null_handle_cmd(cmd);
+	if (should_requeue_request(bd->rq))
+		return BLK_STS_RESOURCE;
+	if (should_timeout_request(bd->rq))
+		return BLK_STS_OK;
 
-	return BLK_STS_OK;
+	return null_handle_cmd(cmd);
 }
 
 static const struct blk_mq_ops null_mq_ops = {
@@ -1659,16 +1679,27 @@ static void null_validate_conf(struct nullb_device *dev)
 		dev->mbps = 0;
 }
 
-static bool null_setup_fault(void)
-{
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
-	if (!g_timeout_str[0])
+static bool __null_setup_fault(struct fault_attr *attr, char *str)
+{
+	if (!str[0])
 		return true;
 
-	if (!setup_fault_attr(&null_timeout_attr, g_timeout_str))
+	if (!setup_fault_attr(attr, str))
 		return false;
 
-	null_timeout_attr.verbose = 0;
+	attr->verbose = 0;
+	return true;
+}
+#endif
+
+static bool null_setup_fault(void)
+{
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+	if (!__null_setup_fault(&null_timeout_attr, g_timeout_str))
+		return false;
+	if (!__null_setup_fault(&null_requeue_attr, g_requeue_str))
+		return false;
 #endif
 	return true;
 }

-- 
Jens Axboe
