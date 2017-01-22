Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH 3/5] blk-throttle: Adjust two function calls together with a
 variable assignment
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <7d68f93d-c14c-60aa-2b02-5005a0a62cad@users.sourceforge.net>
Date: Sun, 22 Jan 2017 09:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 22:15:33 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 block/blk-throttle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b392b48310ba..3cf7472fbba2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -866,10 +866,12 @@ static void tg_update_disptime(struct throtl_grp *tg)
 	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
 	struct bio *bio;
 
-	if ((bio = throtl_peek_queued(&sq->queued[READ])))
+	bio = throtl_peek_queued(&sq->queued[READ]);
+	if (bio)
 		tg_may_dispatch(tg, bio, &read_wait);
 
-	if ((bio = throtl_peek_queued(&sq->queued[WRITE])))
+	bio = throtl_peek_queued(&sq->queued[WRITE]);
+	if (bio)
 		tg_may_dispatch(tg, bio, &write_wait);
 
 	min_wait = min(read_wait, write_wait);
-- 
2.11.0
