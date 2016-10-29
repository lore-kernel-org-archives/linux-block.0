Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 56/60] fs: crypto: convert to bio_for_each_segment_all_rd()
Date: Sat, 29 Oct 2016 16:08:55 +0800
Message-Id: <1477728600-12938-57-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/crypto/crypto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 98f87fe8f186..ed007ebbd1ab 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -411,8 +411,9 @@ static void completion_pages(struct work_struct *work)
 	struct bio *bio = ctx->r.bio;
 	struct bio_vec *bv;
 	int i;
+	struct bvec_iter_all bia;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_rd(bv, bio, i, bia) {
 		struct page *page = bv->bv_page;
 		int ret = fscrypt_decrypt_page(page);
 
-- 
2.7.4

