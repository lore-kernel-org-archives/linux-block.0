Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Ming Lei
	<tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH] block: Update comments that refer to __bio_map_user() and bio_map_user()
Date: Wed, 1 Feb 2017 08:20:08 -0800
Message-ID: <20170201162008.4628-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since __bio_map_user() and bio_map_user() have been removed, update
the comments that still refer to these functions.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
References: commit ddad8dd0a162 ("block: use blk_rq_map_user_iov to implement blk_rq_map_user")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>
---
 block/bio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 9a2dd7145e83..4b564d0c3e29 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1394,7 +1394,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 	bio_set_flag(bio, BIO_USER_MAPPED);
 
 	/*
-	 * subtle -- if __bio_map_user() ended up bouncing a bio,
+	 * subtle -- if bio_map_user_iov() ended up bouncing a bio,
 	 * it would normally disappear when its bi_end_io is run.
 	 * however, we need it for the unmap, so grab an extra
 	 * reference to it
@@ -1436,8 +1436,8 @@ static void __bio_unmap_user(struct bio *bio)
  *	bio_unmap_user	-	unmap a bio
  *	@bio:		the bio being unmapped
  *
- *	Unmap a bio previously mapped by bio_map_user(). Must be called with
- *	a process context.
+ *	Unmap a bio previously mapped by bio_map_user_iov(). Must be called from
+ *	process context.
  *
  *	bio_unmap_user() may sleep.
  */
-- 
2.11.0
