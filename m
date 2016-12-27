Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH v1 39/54] fs/mpage: convert to bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:48 +0800
Message-Id: <1482854706-14128-8-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/mpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 28af984a3d96..bd94b3dbf27e 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -46,9 +46,10 @@
 static void mpage_end_io(struct bio *bio)
 {
 	struct bio_vec *bv;
+	struct bvec_iter_all bia;
 	int i;
 
-	bio_for_each_segment_all(bv, bio, i) {
+	bio_for_each_segment_all_sp(bv, bio, i, bia) {
 		struct page *page = bv->bv_page;
 		page_endio(page, op_is_write(bio_op(bio)), bio->bi_error);
 	}
-- 
2.7.4

