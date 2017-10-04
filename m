Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 3/3] block: don't print message for discard error
Date: Wed,  4 Oct 2017 07:52:45 -0700
Message-Id: <483d098388b5e697dad0b6bde952e8659d8fe545.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

discard error isn't fatal, don't flood discard error messages.

Suggested-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14f7674..adb064a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3090,6 +3090,8 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 
+	if (bio_op(bio) == REQ_OP_DISCARD)
+		rq->rq_flags |= RQF_QUIET;
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
 }
-- 
2.9.5
