Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/12] block: floppy: use bio_add_page()
Date: Fri, 11 Nov 2016 20:05:31 +0800
Message-Id: <1478865957-25252-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/floppy.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 6a3ff2b2e3ae..a391a3cfb3fe 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3807,12 +3807,9 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	cbdata.drive = drive;
 
 	bio_init(&bio, &bio_vec, 1);
-	bio_vec.bv_page = page;
-	bio_vec.bv_len = size;
-	bio_vec.bv_offset = 0;
-	bio.bi_vcnt = 1;
-	bio.bi_iter.bi_size = size;
 	bio.bi_bdev = bdev;
+	bio_add_page(&bio, page, size, 0);
+
 	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags |= (1 << BIO_QUIET);
 	bio.bi_private = &cbdata;
-- 
2.7.4

