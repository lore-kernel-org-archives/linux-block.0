Return-Path: <prvs=0415d39c2a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH] block/loop: fix use after feee
Date: Wed, 30 Aug 2017 14:51:05 -0700
Message-ID: <e1da431a2f961cc0b04241808a31bb58b120fc07.1504129490.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

lo_rw_aio->call_read_iter->
1	aops->direct_IO
2	iov_iter_revert
lo_rw_aio_complete could happen between 1 and 2, the bio and bvec could
be freed before 2, which accesses bvec.

This conflicts with my direcio performance improvement patches, which
I'll resend.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef83349..153ab3c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -490,6 +490,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
 	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
 		      bio_segments(bio), blk_rq_bytes(cmd->rq));
+	bio_inc_remaining(bio);
 	/*
 	 * This bio may be started from the middle of the 'bvec'
 	 * because of bio splitting, so offset from the bvec must
@@ -507,6 +508,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
+	bio_endio(bio);
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
 	return 0;
-- 
2.9.5
