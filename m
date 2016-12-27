Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32860 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbcL0P7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Christie <mchristi@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH v1 04/54] mm: page_io.c: comment on direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:53 +0800
Message-Id: <1482854250-13481-5-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 mm/page_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index 23f6d0d3470f..368a16aa810c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -43,6 +43,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 
 void end_swap_bio_write(struct bio *bio)
 {
+	/* single page bio, safe for multipage bvec */
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (bio->bi_error) {
@@ -116,6 +117,7 @@ static void swap_slot_free_notify(struct page *page)
 
 static void end_swap_bio_read(struct bio *bio)
 {
+	/* single page bio, safe for multipage bvec */
 	struct page *page = bio->bi_io_vec[0].bv_page;
 
 	if (bio->bi_error) {
-- 
2.7.4

