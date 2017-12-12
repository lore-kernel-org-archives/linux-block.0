Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	kernel-team@fb.com,
	osandov@fb.com,
	linux-block@vger.kernel.org,
	hch@lst.de,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] blk-mq: use blk_mq_rq_state() instead of testing REQ_ATOM_COMPLETE
Date: Tue, 12 Dec 2017 11:01:31 -0800
Message-Id: <20171212190134.535941-4-tj@kernel.org>
In-Reply-To: <20171212190134.535941-1-tj@kernel.org>
References: <20171212190134.535941-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

blk_mq_check_inflight() and blk_mq_poll_hybrid_sleep() test
REQ_ATOM_COMPLETE to determine the request state.  Both uses are
speculative and we can test REQ_ATOM_STARTED and blk_mq_rq_state() for
equivalent results.  Replace the tests.  This will allow removing
REQ_ATOM_COMPLETE usages from blk-mq.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b4e733b..3a08d7a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -95,8 +95,7 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (test_bit(REQ_ATOM_STARTED, &rq->atomic_flags) &&
-	    !test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags)) {
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT) {
 		/*
 		 * index[0] counts the specific partition that was asked
 		 * for. index[1] counts the ones that are active on the
@@ -2958,7 +2957,8 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	hrtimer_init_sleeper(&hs, current);
 	do {
-		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
+		if (test_bit(REQ_ATOM_STARTED, &rq->atomic_flags) &&
+		    blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		hrtimer_start_expires(&hs.timer, mode);
-- 
2.9.5
