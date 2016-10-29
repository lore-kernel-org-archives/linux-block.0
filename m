Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34016 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935299AbcJ2IPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:15:45 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 48/60] fs/mpage: convert to bio_for_each_segment_all_rd()
Date: Sat, 29 Oct 2016 16:08:47 +0800
Message-Id: <1477728600-12938-49-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/mpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index d2413af0823a..2c906e82dd49 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -46,9 +46,10 @@
 static void mpage_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
+	struct bvec_iter_all bia;
 	int i;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_rd(bv, bio, i, bia) {
 		struct page *page = bv->bv_page;
 		page_endio(page, op_is_write(bio_op(bio)), bio->bi_error);
 	}
-- 
2.7.4

