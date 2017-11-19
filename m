Return-Path: <marcos.souza.org@gmail.com>
Return-Path: <marcos.souza.org@gmail.com>
From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To: 
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 -next] blktrace.c: Use blk_trace_bio_get_cgid inside blk_add_trace_bio
Date: Sun, 19 Nov 2017 17:59:26 -0200
Message-Id: <20171119195931.27774-1-marcos.souza.org@gmail.com>
In-Reply-To: <20171119184817.15754-1-marcos.souza.org@gmail.com>
References: <20171119184817.15754-1-marcos.souza.org@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Instead of calling blk_trace_bio_get_cgid(q, bio)) seven times, call it directly
inside blk_add_trace_bio.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

Discovered when checking the missing documentation of cgid in blk_add_trace_bio
function when running make pdfdocs.

 kernel/trace/blktrace.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 206e0e2ace53..c5987d4c5f23 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -872,7 +872,7 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *
  **/
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
-			      u32 what, int error, union kernfs_node_id *cgid)
+			      u32 what, int error)
 {
 	struct blk_trace *bt = q->blk_trace;
 
@@ -880,22 +880,21 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 		return;
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, what, error, 0, NULL, cgid);
+			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
+			blk_trace_bio_get_cgid(q, bio));
 }
 
 static void blk_add_trace_bio_bounce(void *ignore,
 				     struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_BOUNCE, 0,
-			  blk_trace_bio_get_cgid(q, bio));
+	blk_add_trace_bio(q, bio, BLK_TA_BOUNCE, 0);
 }
 
 static void blk_add_trace_bio_complete(void *ignore,
 				       struct request_queue *q, struct bio *bio,
 				       int error)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE, error,
-			  blk_trace_bio_get_cgid(q, bio));
+	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE, error);
 }
 
 static void blk_add_trace_bio_backmerge(void *ignore,
@@ -903,8 +902,7 @@ static void blk_add_trace_bio_backmerge(void *ignore,
 					struct request *rq,
 					struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE, 0,
-			 blk_trace_bio_get_cgid(q, bio));
+	blk_add_trace_bio(q, bio, BLK_TA_BACKMERGE, 0);
 }
 
 static void blk_add_trace_bio_frontmerge(void *ignore,
@@ -912,15 +910,13 @@ static void blk_add_trace_bio_frontmerge(void *ignore,
 					 struct request *rq,
 					 struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE, 0,
-			  blk_trace_bio_get_cgid(q, bio));
+	blk_add_trace_bio(q, bio, BLK_TA_FRONTMERGE, 0);
 }
 
 static void blk_add_trace_bio_queue(void *ignore,
 				    struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_QUEUE, 0,
-			  blk_trace_bio_get_cgid(q, bio));
+	blk_add_trace_bio(q, bio, BLK_TA_QUEUE, 0);
 }
 
 static void blk_add_trace_getrq(void *ignore,
@@ -928,8 +924,7 @@ static void blk_add_trace_getrq(void *ignore,
 				struct bio *bio, int rw)
 {
 	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0,
-				  blk_trace_bio_get_cgid(q, bio));
+		blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
 	else {
 		struct blk_trace *bt = q->blk_trace;
 
@@ -945,8 +940,7 @@ static void blk_add_trace_sleeprq(void *ignore,
 				  struct bio *bio, int rw)
 {
 	if (bio)
-		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0,
-				  blk_trace_bio_get_cgid(q, bio));
+		blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
 	else {
 		struct blk_trace *bt = q->blk_trace;
 
-- 
2.13.6
