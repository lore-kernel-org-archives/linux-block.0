Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Add comment to submit_bio_wait()
Date: Wed,  2 Aug 2017 10:25:21 +0200
Message-Id: <20170802082521.3925-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

submit_bio_wait() does not consume bio reference. Add comment about
that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 9a63597aaacc..e241bbc49f14 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -936,6 +936,10 @@ static void submit_bio_wait_endio(struct bio *bio)
  *
  * Simple wrapper around submit_bio(). Returns 0 on success, or the error from
  * bio_endio() on failure.
+ *
+ * WARNING: Unlike to how submit_bio() is usually used, this function does not
+ * result in bio reference to be consumed. The caller must drop the reference
+ * on his own.
  */
 int submit_bio_wait(struct bio *bio)
 {
-- 
2.12.3
