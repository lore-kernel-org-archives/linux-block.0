Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbdFZMTo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:19:44 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 39/51] fs/mpage: convert to bio_for_each_segment_all_sp()
Date: Mon, 26 Jun 2017 20:10:22 +0800
Message-Id: <20170626121034.3051-40-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/mpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0da38f401564..bdb4692ae30c 100644
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
 		page_endio(page, op_is_write(bio_op(bio)),
 				blk_status_to_errno(bio->bi_status));
-- 
2.9.4
