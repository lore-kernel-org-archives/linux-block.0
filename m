Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 1/3] block/loop: don't hijack error number
Date: Wed,  4 Oct 2017 07:52:43 -0700
Message-Id: <d3e3e3bc5992554fe8476eabc9a06b1c9e844e5e.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

If the bio returns -EOPNOTSUPP, we shouldn't hijack it and return -EIO

Signed-off-by: Shaohua Li <shli@fb.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc8e615..6aa739f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -460,7 +460,7 @@ static void lo_complete_rq(struct request *rq)
 		zero_fill_bio(bio);
 	}
 
-	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
+	blk_mq_end_request(rq, errno_to_blk_status(cmd->ret));
 }
 
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
@@ -478,7 +478,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 
 	if (cmd->css)
 		css_put(cmd->css);
-	cmd->ret = ret;
+	cmd->ret = ret > 0 ? 0 : ret;
 	lo_rw_aio_do_completion(cmd);
 }
 
@@ -1719,7 +1719,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
