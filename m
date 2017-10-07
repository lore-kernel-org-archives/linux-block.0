Return-Path: <SRS0=uvfw=BG=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 2/3] block: set request_list for request
Date: Fri,  6 Oct 2017 17:56:00 -0700
Message-Id: <39caee250aa6d115c0505d629a76281b84369f8e.1507337347.git.shli@fb.com>
In-Reply-To: <cover.1507337347.git.shli@fb.com>
References: <cover.1507337347.git.shli@fb.com>
In-Reply-To: <cover.1507337347.git.shli@fb.com>
References: <cover.1507337347.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Legacy queue sets request's request_list, mq doesn't. This makes mq does
the same thing, so we can find cgroup of a request. Note, we really
only use blkg field of request_list, it's pointless to allocate mempool
for request_list in mq case.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index adb064a..f88afd1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -718,7 +718,7 @@ static void free_request_size(void *element, void *data)
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
 		gfp_t gfp_mask)
 {
-	if (unlikely(rl->rq_pool))
+	if (unlikely(rl->rq_pool) || q->mq_ops)
 		return 0;
 
 	rl->q = q;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7f01d69..c3b5876 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -481,6 +481,9 @@ void blk_mq_free_request(struct request *rq)
 
 	wbt_done(q->rq_wb, &rq->issue_stat);
 
+	if (blk_rq_rl(rq))
+		blk_put_rl(blk_rq_rl(rq));
+
 	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	if (rq->tag != -1)
@@ -1504,6 +1507,8 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 {
 	blk_init_request_from_bio(rq, bio);
 
+	blk_rq_set_rl(rq, blk_get_rl(rq->q, bio));
+
 	blk_account_io_start(rq, true);
 }
 
-- 
2.9.5
