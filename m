Return-Path: <prvs=0415d39c2a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH 3/3] block/loop: suppress discard IO error message
Date: Wed, 30 Aug 2017 12:17:18 -0700
Message-ID: <1a2fdfc9a698aaee556028b828afef3daa5a51e0.1504120418.git.shli@fb.com>
In-Reply-To: <cover.1504120418.git.shli@fb.com>
References: <cover.1504120418.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We don't know if fallocate really supports FALLOC_FL_PUNCH_HOLE till
fallocate is called. If it doesn't support, loop will return
-EOPNOTSUPP and we seee a lot of error message printed by
blk_update_request. Failure for discard IO isn't a problem, so we just
return 0 in loop which will suppress the IO error message

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a30aa45..15f51e3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -441,6 +441,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		ret = -EIO;
+
+	if (req_op(rq) == REQ_OP_DISCARD && ret == -EOPNOTSUPP)
+		ret = 0;
  out:
 	return ret;
 }
-- 
2.9.5
