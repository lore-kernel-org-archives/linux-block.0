Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdFZMSI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:18:08 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 31/51] fs/buffer.c: use bvec iterator to truncate the bio
Date: Mon, 26 Jun 2017 20:10:14 +0800
Message-Id: <20170626121034.3051-32-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Once multipage bvec is enabled, the last bvec may include
more than one page, this patch use bvec_get_last_page()
to truncate the bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1910f539770b..53b8a29f4525 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3055,8 +3055,7 @@ void guard_bio_eod(int op, struct bio *bio)
 	unsigned truncated_bytes;
 	/*
 	 * It is safe to truncate the last bvec in the following way
-	 * even though multipage bvec is supported, but we need to
-	 * fix the parameters passed to zero_user().
+	 * even though multipage bvec is supported.
 	 */
 	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
@@ -3085,7 +3084,10 @@ void guard_bio_eod(int op, struct bio *bio)
 
 	/* ..and clear the end of the buffer for reads */
 	if (op == REQ_OP_READ) {
-		zero_user(bvec->bv_page, bvec->bv_offset + bvec->bv_len,
+		struct bio_vec bv;
+
+		bvec_get_last_page(bvec, &bv);
+		zero_user(bv.bv_page, bv.bv_offset + bv.bv_len,
 				truncated_bytes);
 	}
 }
-- 
2.9.4
