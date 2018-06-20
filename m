Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 20 Jun 2018 13:45:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
Message-ID: <20180620104503.nrwlfak3gyxjg7s2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

If rq_state == ARRAY_SIZE() then we read one element beyond the end of
the blk_mq_rq_state_name_array[] array.

Fixes: ec6dcf63c55c ("blk-mq-debugfs: Show more request state information")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ffa622366922..1c4532e92938 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -356,7 +356,7 @@ static const char *const blk_mq_rq_state_name_array[] = {
 
 static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
 {
-	if (WARN_ON_ONCE((unsigned int)rq_state >
+	if (WARN_ON_ONCE((unsigned int)rq_state >=
 			 ARRAY_SIZE(blk_mq_rq_state_name_array)))
 		return "(?)";
 	return blk_mq_rq_state_name_array[rq_state];
