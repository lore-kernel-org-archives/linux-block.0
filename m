Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34274 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933122AbcJ2IMu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:12:50 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Joern Engel <joern@logfs.org>,
        Prasad Joshi <prasadjoshi.linux@gmail.com>,
        logfs@logfs.org (open list:LogFS)
Subject: [PATCH 12/60] fs: logfs: use bio_add_page() in do_erase()
Date: Sat, 29 Oct 2016 16:08:11 +0800
Message-Id: <1477728600-12938-13-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Also code gets simplified a bit.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/logfs/dev_bdev.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index 79be4cb0dfd8..ff5e3e31bca3 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -154,49 +154,35 @@ static int do_erase(struct super_block *sb, u64 ofs, pgoff_t index,
 		size_t nr_pages)
 {
 	struct logfs_super *super = logfs_super(sb);
-	struct bio *bio;
+	struct bio *bio = NULL;
 	unsigned int max_pages;
-	int i;
+	int i, ret;
 
 	max_pages = min_t(size_t, nr_pages, BIO_MAX_PAGES);
 
-	bio = bio_alloc(GFP_NOFS, max_pages);
-	BUG_ON(!bio);
-
 	for (i = 0; i < nr_pages; i++) {
-		if (i >= max_pages) {
-			/* Block layer cannot split bios :( */
-			bio->bi_vcnt = i;
-			bio->bi_iter.bi_size = i * PAGE_SIZE;
+		if (!bio) {
+			bio = bio_alloc(GFP_NOFS, max_pages);
+			BUG_ON(!bio);
+
 			bio->bi_bdev = super->s_bdev;
 			bio->bi_iter.bi_sector = ofs >> 9;
 			bio->bi_private = sb;
 			bio->bi_end_io = erase_end_io;
 			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
+		}
+		ret = bio_add_page(bio, super->s_erase_page, PAGE_SIZE, 0);
+		if (!ret) {
+			/* Block layer cannot split bios :( */
+			ofs += bio->bi_iter.bi_size;
 			atomic_inc(&super->s_pending_writes);
 			submit_bio(bio);
-
-			ofs += i * PAGE_SIZE;
-			index += i;
-			nr_pages -= i;
-			i = 0;
-
-			bio = bio_alloc(GFP_NOFS, max_pages);
-			BUG_ON(!bio);
 		}
-		bio->bi_io_vec[i].bv_page = super->s_erase_page;
-		bio->bi_io_vec[i].bv_len = PAGE_SIZE;
-		bio->bi_io_vec[i].bv_offset = 0;
 	}
-	bio->bi_vcnt = nr_pages;
-	bio->bi_iter.bi_size = nr_pages * PAGE_SIZE;
-	bio->bi_bdev = super->s_bdev;
-	bio->bi_iter.bi_sector = ofs >> 9;
-	bio->bi_private = sb;
-	bio->bi_end_io = erase_end_io;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-	atomic_inc(&super->s_pending_writes);
-	submit_bio(bio);
+	if (bio) {
+		atomic_inc(&super->s_pending_writes);
+		submit_bio(bio);
+	}
 	return 0;
 }
 
-- 
2.7.4

