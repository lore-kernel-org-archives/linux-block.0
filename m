Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33806 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751373AbcLEVUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Dec 2016 16:20:49 -0500
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <mpa@pengutronix.de>, <nbd-general@lists.sourceforge.net>
Subject: [PATCH] nbd: use dev_err_ratelimited in io path
Date: Mon, 5 Dec 2016 16:20:29 -0500
Message-ID: <1480972829-30845-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While doing stress tests we noticed that we'd get a lot of dmesg spam if
we suddenly disconnected teh nbd device out of band.  Rate limite the
messages in the io path in order to deal with this.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index bc78cbb..0e6e52df 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -219,7 +219,7 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send, void *buf,
 	unsigned long pflags = current->flags;
 
 	if (unlikely(!sock)) {
-		dev_err(disk_to_dev(nbd->disk),
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Attempted %s on closed socket in sock_xmit\n",
 			(send ? "send" : "recv"));
 		return -EINVAL;
@@ -302,7 +302,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	result = sock_xmit(nbd, index, 1, &request, sizeof(request),
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0);
 	if (result <= 0) {
-		dev_err(disk_to_dev(nbd->disk),
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
 		return -EIO;
 	}
@@ -501,14 +501,14 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	struct nbd_sock *nsock;
 
 	if (index >= nbd->num_connections) {
-		dev_err(disk_to_dev(nbd->disk),
-			"Attempted send on invalid socket\n");
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on invalid socket\n");
 		goto error_out;
 	}
 
 	if (test_bit(NBD_DISCONNECTED, &nbd->runtime_flags)) {
-		dev_err(disk_to_dev(nbd->disk),
-			"Attempted send on closed socket\n");
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on closed socket\n");
 		goto error_out;
 	}
 
@@ -519,8 +519,8 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (req->cmd_type == REQ_TYPE_FS &&
 	    rq_data_dir(req) == WRITE &&
 	    (nbd->flags & NBD_FLAG_READ_ONLY)) {
-		dev_err(disk_to_dev(nbd->disk),
-			"Write on read-only\n");
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Write on read-only\n");
 		goto error_out;
 	}
 
@@ -530,13 +530,14 @@ static void nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	mutex_lock(&nsock->tx_lock);
 	if (unlikely(!nsock->sock)) {
 		mutex_unlock(&nsock->tx_lock);
-		dev_err(disk_to_dev(nbd->disk),
-			"Attempted send on closed socket\n");
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Attempted send on closed socket\n");
 		goto error_out;
 	}
 
 	if (nbd_send_cmd(nbd, cmd, index) != 0) {
-		dev_err(disk_to_dev(nbd->disk), "Request send failed\n");
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Request send failed\n");
 		req->errors++;
 		nbd_end_request(cmd);
 	}
-- 
2.5.5

