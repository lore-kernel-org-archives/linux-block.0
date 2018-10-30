Return-Path: <evgreen@chromium.org>
Return-Path: <evgreen@chromium.org>
From: Evan Green <evgreen@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Alexis Savery <asavery@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] loop: Report EOPNOTSUPP properly
Date: Tue, 30 Oct 2018 16:06:23 -0700
Message-Id: <20181030230624.61834-2-evgreen@chromium.org>
In-Reply-To: <20181030230624.61834-1-evgreen@chromium.org>
References: <20181030230624.61834-1-evgreen@chromium.org>
List-ID: <linux-block@vger.kernel.org>

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/block/loop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index abad6d15f9563..28990fc94841a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,8 +458,13 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
-			ret = BLK_STS_IOERR;
+		if (cmd->ret < 0) {
+			if (cmd->ret == -EOPNOTSUPP)
+				ret = BLK_STS_NOTSUPP;
+			else
+				ret = BLK_STS_IOERR;
+		}
+
 		goto end_io;
 	}
 
@@ -1788,7 +1793,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.16.4
