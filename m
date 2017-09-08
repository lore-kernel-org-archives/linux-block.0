Return-Path: <lucmiccio@gmail.com>
Return-Path: <lucmiccio@gmail.com>
From: Luca Miccio <lucmiccio@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Miccio <lucmiccio@gmail.com>
Subject: [PATCH] block,bfq: Disable writeback throttling
Date: Fri,  8 Sep 2017 11:50:39 +0200
Message-Id: <1504864239-10288-1-git-send-email-lucmiccio@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Similarly to CFQ, BFQ has its write-throttling heuristics, and it
is better not to combine them with further write-throttling
heuristics of a different nature.
So this commit disables write-back throttling for a device if BFQ
is used as I/O scheduler for that device.

Signed-off-by: Luca Miccio <lucmiccio@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 436b6ca..4feae52 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -108,6 +108,7 @@
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 #include "bfq-iosched.h"
+#include "blk-wbt.h"
 
 #define BFQ_BFQQ_FNS(name)						\
 void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)			\
@@ -4760,7 +4761,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_root_group(bfqd->root_group, bfqd);
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
-
+	wbt_disable_default(q);
 	return 0;
 
 out_free:
-- 
2.7.4
