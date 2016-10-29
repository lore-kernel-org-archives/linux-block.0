Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36153 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966390AbcJ2IQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:16:25 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 59/60] fs/buffer.c: use bvec iterator to truncate the bio
Date: Sat, 29 Oct 2016 16:08:58 +0800
Message-Id: <1477728600-12938-60-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For making multipage bvec working well.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/buffer.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 81c3793948b4..293e081a4b5f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3021,8 +3021,7 @@ void guard_bio_eod(int op, struct bio *bio)
 	unsigned truncated_bytes;
 	/*
 	 * It is safe to truncate the last bvec in the following way
-	 * even though multipage bvec is supported, but we need to
-	 * fix the parameters passed to zero_user().
+	 * even though multipage bvec is supported.
 	 */
 	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
@@ -3045,15 +3044,21 @@ void guard_bio_eod(int op, struct bio *bio)
 	/* Uhhuh. We've got a bio that straddles the device size! */
 	truncated_bytes = bio->bi_iter.bi_size - (maxsector << 9);
 
-	/* Truncate the bio.. */
-	bio->bi_iter.bi_size -= truncated_bytes;
-	bvec->bv_len -= truncated_bytes;
-
 	/* ..and clear the end of the buffer for reads */
 	if (op == REQ_OP_READ) {
-		zero_user(bvec->bv_page, bvec->bv_offset + bvec->bv_len,
-				truncated_bytes);
+		struct bvec_iter start = BVEC_ITER_ALL_INIT;
+		struct bvec_iter iter;
+		struct bio_vec bv;
+
+		start.bi_bvec_done = bvec->bv_len - truncated_bytes;
+
+		__bvec_for_each_sp_bvec(bv, bvec, iter, start)
+			zero_user(bv.bv_page, bv.bv_offset, bv.bv_len);
 	}
+
+	/* Truncate the bio.. */
+	bio->bi_iter.bi_size -= truncated_bytes;
+	bvec->bv_len -= truncated_bytes;
 }
 
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
-- 
2.7.4

