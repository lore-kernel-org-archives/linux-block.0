Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36025 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966359AbcJ2IP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:15:56 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Joern Engel <joern@logfs.org>,
        Prasad Joshi <prasadjoshi.linux@gmail.com>,
        logfs@logfs.org (open list:LogFS)
Subject: [PATCH 52/60] logfs: convert to bio_for_each_segment_all_rd()
Date: Sat, 29 Oct 2016 16:08:51 +0800
Message-Id: <1477728600-12938-53-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/logfs/dev_bdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index f05a02ff43e6..b81bd2154253 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -55,10 +55,11 @@ static void writeseg_end_io(struct bio *bio)
 	int i;
 	struct super_block *sb = bio->bi_private;
 	struct logfs_super *super = logfs_super(sb);
+	struct bvec_iter_all bia;
 
 	BUG_ON(bio->bi_error); /* FIXME: Retry io or write elsewhere */
 
-	bio_for_each_segment_all(bvec, bio, i) {
+	bio_for_each_segment_all_rd(bvec, bio, i, bia) {
 		end_page_writeback(bvec->bv_page);
 		put_page(bvec->bv_page);
 	}
-- 
2.7.4

