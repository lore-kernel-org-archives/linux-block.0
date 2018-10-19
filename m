Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
Date: Fri, 19 Oct 2018 17:24:53 +0800
Message-Id: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Discard command supports multiple ranges of blocks, so needn't
checking position contiguity when merging. Let's do the same thing
in attempt_merge as the blk_try_merge.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-merge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..c94749b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -732,9 +732,10 @@ static struct request *attempt_merge(struct request_queue *q,
 		return NULL;
 
 	/*
-	 * not contiguous
+	 * not contiguous, except for DISCARD
 	 */
-	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
+	if ((req_op(req) != REQ_OP_DISCARD) &&
+	    (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)))
 		return NULL;
 
 	if (rq_data_dir(req) != rq_data_dir(next)
-- 
2.7.4
