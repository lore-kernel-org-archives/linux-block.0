Return-Path: <SRS0=Wszy=AI=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 1/3] block/loop: don't hijack error number
Date: Wed,  6 Sep 2017 17:13:24 -0700
Message-Id: <61457d9c4399baaf20f151eed4d5971625953504.1504742003.git.shli@fb.com>
In-Reply-To: <cover.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com>
In-Reply-To: <cover.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

If the bio returns -EOPNOTSUPP, we shouldn't hijack it and return -EIO

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 85de673..715b762 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -460,7 +460,7 @@ static void lo_complete_rq(struct request *rq)
 		zero_fill_bio(bio);
 	}
 
-	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
+	blk_mq_end_request(rq, errno_to_blk_status(cmd->ret));
 }
 
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
@@ -476,7 +476,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
-	cmd->ret = ret;
+	cmd->ret = ret > 0 ? 0 : ret;
 	lo_rw_aio_do_completion(cmd);
 }
 
@@ -1706,7 +1706,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		cmd->ret = ret;
 		blk_mq_complete_request(cmd->rq);
 	}
 }
-- 
2.9.5
