Return-Path: <mpatocka@redhat.com>
Date: Wed, 22 Nov 2017 13:18:05 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kent.overstreet@gmail.com>
cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove useless assignment in bio_split
Message-ID: <alpine.LRH.2.02.1711221312020.21196@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Remove useless assignment to the variable "split" because the variable is
unconditionally assigned later.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/block/bio.c
===================================================================
--- linux-2.6.orig/block/bio.c
+++ linux-2.6/block/bio.c
@@ -1873,7 +1873,7 @@ EXPORT_SYMBOL(bio_endio);
 struct bio *bio_split(struct bio *bio, int sectors,
 		      gfp_t gfp, struct bio_set *bs)
 {
-	struct bio *split = NULL;
+	struct bio *split;
 
 	BUG_ON(sectors <= 0);
 	BUG_ON(sectors >= bio_sectors(bio));
