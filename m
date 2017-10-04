Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 2/3] block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
Date: Wed,  4 Oct 2017 07:52:44 -0700
Message-Id: <b2a8123d49958e882ea0fb0be6573adbf40be5f7.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
In-Reply-To: <cover.1507072136.git.shli@fb.com>
References: <cover.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

REQ_OP_WRITE_ZEROES really means zero the data. And in blkdev_fallocate,
FALLOC_FL_ZERO_RANGE will retry but FALLOC_FL_PUNCH_HOLE not, even loop
request doesn't have BLKDEV_ZERO_NOFALLBACK set.

Signed-off-by: Shaohua Li <shli@fb.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6aa739f..7269341 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -426,6 +426,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	int ret;
 
+	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
+		mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+
 	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 
2.9.5
