Return-Path: <tim.dawson@nyriad.com>
Return-Path: <tim.dawson@nyriad.com>
Date: Fri, 21 Oct 2016 20:24:55 +1300
From: Tim Dawson <tim.dawson@nyriad.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] nbd: allow socket reconnect without block IO errors
Message-ID: <20161021072455.GA7101@tim-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

this patch introduces a new ioctl that prevents requests being aborted on a socket error
and instead the request is retried on the next connection
or is cleaned up on timeout, disconnect or clear_sock.

Signed-off-by: Tim Dawson <tim.dawson@nyriad.com>
---
 drivers/block/nbd.c      | 80 +++++++++++++++++++++++++++++++++++++++---------
 include/uapi/linux/nbd.h |  1 +
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ba405b5..727f5b5 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -43,6 +43,7 @@
 
 #define NBD_TIMEDOUT			0
 #define NBD_DISCONNECT_REQUESTED	1
+#define NBD_RESEND_DO_IT			2
 
 struct nbd_device {
 	u32 flags;
@@ -433,8 +434,6 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 		return ret;
 	}
 
-	nbd_size_update(nbd, bdev);
-
 	while (1) {
 		cmd = nbd_read_stat(nbd);
 		if (IS_ERR(cmd)) {
@@ -442,10 +441,19 @@ static int nbd_thread_recv(struct nbd_device *nbd, struct block_device *bdev)
 			break;
 		}
 
+		struct request *req = blk_mq_rq_from_pdu(cmd);
+
+		if (test_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags) && req->errors) {
+			/* reset errors - we will reconnect and fix these */
+			req->errors = 0;
+			ret = -EIO;
+			dev_warn(disk_to_dev(nbd->disk), "Handling failed recv %p\n", req);
+			break;
+		}
+
 		nbd_end_request(cmd);
-	}
 
-	nbd_size_clear(nbd, bdev);
+	}
 
 	device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 	return ret;
@@ -503,7 +511,10 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd)
 		goto error_out;
 	}
 
-	if (nbd_send_cmd(nbd, cmd) != 0) {
+	/* if not NBD_RESEND_DO_IT and there is an error,
+	 * we dont want to nbd_end_request if we can retry later
+	 */
+	if (nbd_send_cmd(nbd, cmd) != 0 && !test_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags)) {
 		dev_err(disk_to_dev(nbd->disk), "Request send failed\n");
 		req->errors++;
 		nbd_end_request(cmd);
@@ -515,8 +526,32 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd)
 	return;
 
 error_out:
-	req->errors++;
-	nbd_end_request(cmd);
+	if (test_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags)) {
+		nbd->task_send = NULL;
+		mutex_unlock(&nbd->tx_lock);
+		return;
+	}
+
+    req->errors++;
+    nbd_end_request(cmd);
+}
+
+
+static void nbd_resend_req(struct request *req, void *data, bool reserved)
+{
+	struct nbd_device *nbd = data;
+	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
+
+	dev_err(nbd_to_dev(nbd), "resend request %p\n", cmd);
+	nbd_handle_cmd(cmd);
+}
+
+static void nbd_resend_pending(struct nbd_device *nbd)
+{
+	BUG_ON(nbd->magic != NBD_MAGIC);
+
+	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_resend_req, nbd);
+	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
 
 static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -661,6 +696,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd->flags = arg;
 		return 0;
 
+	case NBD_SET_RESEND:
+		set_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags);
+		return 0;
+
 	case NBD_DO_IT: {
 		int error;
 
@@ -675,26 +714,37 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 
 		nbd_parse_flags(nbd, bdev);
 
+		/* Resend remaining commands from last connection */
+		if (test_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags))
+			nbd_resend_pending(nbd);
+
+		nbd_size_update(nbd, bdev);
+
 		nbd_dev_dbg_init(nbd);
-		error = nbd_thread_recv(nbd, bdev);
+		error = nbd_thread_recv(nbd, bdev); //blocking
 		nbd_dev_dbg_close(nbd);
 
 		mutex_lock(&nbd->tx_lock);
 		nbd->task_recv = NULL;
 
 		sock_shutdown(nbd);
-		nbd_clear_que(nbd);
-		kill_bdev(bdev);
-		nbd_bdev_reset(bdev);
+		if (!test_bit(NBD_RESEND_DO_IT, &nbd->runtime_flags) ||
+			test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags)) {
 
-		/* user requested, ignore socket errors */
-		if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
+			dev_info(disk_to_dev(nbd->disk), "NBD_DO_IT cleanup\n");
+			nbd_size_clear(nbd, bdev);
+			nbd_clear_que(nbd);
+			kill_bdev(bdev);
+			nbd_bdev_reset(bdev);
+			nbd_reset(nbd);
+
+			/* user requested, ignore socket errors */
 			error = 0;
+		}
+
 		if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
 			error = -ETIMEDOUT;
 
-		nbd_reset(nbd);
-
 		return error;
 	}
 
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index e08e413..9031c87 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -28,6 +28,7 @@
 #define NBD_DISCONNECT  _IO( 0xab, 8 )
 #define NBD_SET_TIMEOUT _IO( 0xab, 9 )
 #define NBD_SET_FLAGS   _IO( 0xab, 10)
+#define NBD_SET_RESEND   _IO( 0xab, 11)
 
 enum {
 	NBD_CMD_READ = 0,
-- 
1.9.1
