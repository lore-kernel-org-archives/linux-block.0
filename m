Return-Path: <prvs=0415d39c2a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH 1/3] block/loop: don't hijack error number
Date: Wed, 30 Aug 2017 12:17:16 -0700
Message-ID: <89923d5cd897c8c8f53d0ea4022414b30bd7eeb7.1504120418.git.shli@fb.com>
In-Reply-To: <cover.1504120418.git.shli@fb.com>
References: <cover.1504120418.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If the bio returns -EOPNOTSUPP, we shouldn't hijack it and return -EIO

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef83349..054dccc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -464,7 +464,7 @@ static void lo_complete_rq(struct request *rq)
 		zero_fill_bio(bio);
 	}
 
-	blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
+	blk_mq_end_request(rq, errno_to_blk_status(cmd->ret));
 }
 
 static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
@@ -1725,7 +1725,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
