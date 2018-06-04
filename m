Return-Path: <kvigor@gmail.com>
Return-Path: <kvigor@gmail.com>
From: kvigor@gmail.com
To: linux-block@vger.kernel.org
Cc: josef@toxicpanda.com,
	axboe@kernel.dk,
	Kevin Vigor <kvigor@fb.com>
Subject: [PATCH] nbd: Consistently use request pointer in debug messages.
Date: Mon,  4 Jun 2018 10:40:12 -0600
Message-Id: <1528130412-4541-1-git-send-email-kvigor@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Kevin Vigor <kvigor@fb.com>

Existing dev_dbg messages sometimes identify request using request
pointer, sometimes using nbd_cmd pointer. This makes it hard to
follow request flow. Consistently use request pointer instead.
---
 drivers/block/nbd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3ed1ef8..b5afa11 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -275,7 +275,7 @@ static void nbd_complete_rq(struct request *req)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
-	dev_dbg(nbd_to_dev(cmd->nbd), "request %p: %s\n", cmd,
+	dev_dbg(nbd_to_dev(cmd->nbd), "request %p: %s\n", req,
 		cmd->status ? "failed" : "done");
 
 	blk_mq_end_request(req, cmd->status);
@@ -482,7 +482,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	memcpy(request.handle, &tag, sizeof(tag));
 
 	dev_dbg(nbd_to_dev(nbd), "request %p: sending control (%s@%llu,%uB)\n",
-		cmd, nbdcmd_to_ascii(type),
+		req, nbdcmd_to_ascii(type),
 		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
 	result = sock_xmit(nbd, index, 1, &from,
 			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
@@ -518,7 +518,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 			int flags = is_last ? 0 : MSG_MORE;
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
-				cmd, bvec.bv_len);
+				req, bvec.bv_len);
 			iov_iter_bvec(&from, ITER_BVEC | WRITE,
 				      &bvec, 1, bvec.bv_len);
 			if (skip) {
@@ -610,7 +610,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		return cmd;
 	}
 
-	dev_dbg(nbd_to_dev(nbd), "request %p: got reply\n", cmd);
+	dev_dbg(nbd_to_dev(nbd), "request %p: got reply\n", req);
 	if (rq_data_dir(req) != WRITE) {
 		struct req_iterator iter;
 		struct bio_vec bvec;
@@ -637,7 +637,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 				return ERR_PTR(-EIO);
 			}
 			dev_dbg(nbd_to_dev(nbd), "request %p: got %d bytes data\n",
-				cmd, bvec.bv_len);
+				req, bvec.bv_len);
 		}
 	} else {
 		/* See the comment in nbd_queue_rq. */
-- 
2.7.4
