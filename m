Return-Path: <SRS0=Wszy=AI=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 3/3] block/loop: suppress discard IO error message
Date: Wed,  6 Sep 2017 17:13:26 -0700
Message-Id: <93626ad390557b27c872bb8325485c9d56cc4e06.1504742003.git.shli@fb.com>
In-Reply-To: <cover.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com>
In-Reply-To: <cover.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

We don't know if fallocate really supports FALLOC_FL_PUNCH_HOLE till
fallocate is called. If it doesn't support, loop will return -EOPNOTSUPP
and we see a lot of error message printed by blk_update_request. Failure
for discard IO isn't a big problem, so we just return 0 in loop which
will suppress the IO error message.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8934e25..9d4545f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -437,6 +437,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
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
