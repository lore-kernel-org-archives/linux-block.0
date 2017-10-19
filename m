Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nbd: don't start req until after the dead connection logic
Date: Thu, 19 Oct 2017 16:21:59 -0400
Message-Id: <1508444519-8751-2-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1508444519-8751-1-git-send-email-josef@toxicpanda.com>
References: <1508444519-8751-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We can end up sleeping for a while waiting for the dead timeout, which
means we could get the per request timer to fire.  We did handle this
case, but if the dead timeout happened right after we submitted we'd
either tear down the connection or possibly requeue as we're handling an
error and race with the endio which can lead to panics and other
hilarity.

Fixes: 560bc4b39952 ("nbd: handle dead connections")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fd2f724462b6..528e6f6951cc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -289,15 +289,6 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		cmd->status = BLK_STS_TIMEOUT;
 		return BLK_EH_HANDLED;
 	}
-
-	/* If we are waiting on our dead timer then we could get timeout
-	 * callbacks for our request.  For this we just want to reset the timer
-	 * and let the queue side take care of everything.
-	 */
-	if (!completion_done(&cmd->send_complete)) {
-		nbd_config_put(nbd);
-		return BLK_EH_RESET_TIMER;
-	}
 	config = nbd->config;
 
 	if (config->num_connections > 1) {
@@ -732,6 +723,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
+		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	config = nbd->config;
@@ -740,6 +732,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
+		blk_mq_start_request(req);
 		return -EINVAL;
 	}
 	cmd->status = BLK_STS_OK;
@@ -763,6 +756,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
+			blk_mq_start_request(req);
 			return -EIO;
 		}
 		goto again;
@@ -773,6 +767,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	 * here so that it gets put _after_ the request that is already on the
 	 * dispatch list.
 	 */
+	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending != req)) {
 		blk_mq_requeue_request(req, true);
 		ret = 0;
@@ -785,10 +780,10 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	ret = nbd_send_cmd(nbd, cmd, index);
 	if (ret == -EAGAIN) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Request send failed trying another connection\n");
+				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
-		mutex_unlock(&nsock->tx_lock);
-		goto again;
+		blk_mq_requeue_request(req, true);
+		ret = 0;
 	}
 out:
 	mutex_unlock(&nsock->tx_lock);
@@ -812,7 +807,6 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * done sending everything over the wire.
 	 */
 	init_completion(&cmd->send_complete);
-	blk_mq_start_request(bd->rq);
 
 	/* We can be called directly from the user space process, which means we
 	 * could possibly have signals pending so our sendmsg will fail.  In
-- 
2.7.5
