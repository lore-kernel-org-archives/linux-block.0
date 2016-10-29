Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35725 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941455AbcJ2INP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:13:15 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Joe Perches <joe@perches.com>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 18/60] mm: page_io.c: comment on direct access to bvec table
Date: Sat, 29 Oct 2016 16:08:17 +0800
Message-Id: <1477728600-12938-19-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 mm/page_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index a2651f58c86a..b0c0069ec1f4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -43,6 +43,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 void end_swap_bio_write(struct bio *bio)
 {
+	/* single page bio, safe for multipage bvec */
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (bio->bi_error) {
-- 
2.7.4

