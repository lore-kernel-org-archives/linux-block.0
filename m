Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 2/4] nbd: set rq->errors to actual error code
Date: Fri, 24 Mar 2017 14:08:27 -0400
Message-Id: <1490378909-4056-3-git-send-email-josef@toxicpanda.com>
In-Reply-To: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
References: <1490378909-4056-1-git-send-email-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We've been relying on the block layer to assume rq->errors being set
translates into -EIO.  I noticed in testing that sometimes this isn't
true, and really there's not much of a reason to have a counter instead
of just using -EIO.  So set it properly so we don't leak random numbers
to unsuspecting victims.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3d1fc37a..dbc22f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -192,7 +192,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 
 	dev_err(nbd_to_dev(nbd), "Connection timed out, shutting down connection\n");
 	set_bit(NBD_TIMEDOUT, &nbd->runtime_flags);
-	req->errors++;
+	req->errors = -EIO;
 
 	mutex_lock(&nbd->config_lock);
 	sock_shutdown(nbd);
@@ -432,7 +432,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	if (ntohl(reply.error)) {
 		dev_err(disk_to_dev(nbd->disk), "Other side returned error (%d)\n",
 			ntohl(reply.error));
-		req->errors++;
+		req->errors = -EIO;
 		return cmd;
 	}
 
@@ -448,7 +448,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
-				req->errors++;
+				req->errors = -EIO;
 				return cmd;
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
@@ -518,7 +518,7 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 	if (!blk_mq_request_started(req))
 		return;
 	cmd = blk_mq_rq_to_pdu(req);
-	req->errors++;
+	req->errors = -EIO;
 	nbd_end_request(cmd);
 }
 
-- 
2.7.4
