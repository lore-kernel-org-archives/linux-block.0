Return-Path: <naby88@gmail.com>
Return-Path: <naby88@gmail.com>
From: Khan M Rashedun-Naby <naby88@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khan M Rashedun-Naby <naby88@gmail.com>
Subject: [PATCH] BLOCK: blk-flush: fixed line with more than 80 character
Date: Wed, 20 Dec 2017 23:05:17 +0600
Message-Id: <1513789517-26756-1-git-send-email-naby88@gmail.com>
List-ID: <linux-block@vger.kernel.org>

The line has more than 80 character which is not linux kernel coding
style. Thus it has rewritten into two lines.

Signed-off-by: Khan M Rashedun-Naby <naby88@gmail.com>
---
 block/blk-flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index f171706..7ab46bb 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -299,7 +299,8 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	struct request *flush_rq = fq->flush_rq;
 
 	/* C1 described at the top of this file */
-	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
+	if (fq->flush_pending_idx != fq->flush_running_idx ||
+		list_empty(pending))
 		return false;
 
 	/* C2 and C3
-- 
2.7.4
