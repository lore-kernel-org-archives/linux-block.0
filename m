Return-Path: <zhangbenlong@didichuxing.com>
Date: Fri, 20 Apr 2018 18:06:01 +0800
From: Benlong Zhang <zhangbenlong@didichuxing.com>
To: <axboe@kernel.dk>
CC: <tj@kernel.org>, <shli@kernel.org>, <david@fromorbit.com>,
	<bfoster@redhat.com>, <linux-block@vger.kernel.org>
Subject: [PATCH] A tentative patch to bypass REQ_META in blk throttle
Message-ID: <20180420100554.GA23471@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangbenlong@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

One problem with cgwb is how fs should treat metadata bios.
For example in xfs, the log might be partially stuck in one
group, leaving threads in other groups waiting for too long.
Please refer to the linux-xfs discussion:
"[PATCH V2] xfs: implement cgroup writeback support"

One approach is to correctly tag bio->bi_css from within the
filesystems (for xfs log should be blkcg_root), and the other
is to skip them, but relies on REQ_META being set.

It works with xfs on a cgwb porting implementation to 3.10.0.
But really not sure about other filesystems...
---
 block/blk-throttle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c5a1316..e2abf6e 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2159,6 +2159,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
 		goto out;
 
+	/* bypass REQ_META for fs global resource */
+	if (bio->bi_opf & REQ_META)
+		goto out;
+
 	spin_lock_irq(q->queue_lock);
 
 	throtl_update_latency_buckets(td);
-- 
1.8.3.1
