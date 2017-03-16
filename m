Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36745 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbdCPQOg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2017 12:14:36 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v3 07/14] md: raid1: use bio helper in process_checks()
Date: Fri, 17 Mar 2017 00:12:28 +0800
Message-Id: <20170316161235.27110-8-tom.leiming@gmail.com>
In-Reply-To: <20170316161235.27110-1-tom.leiming@gmail.com>
References: <20170316161235.27110-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid to direct access to bvec table.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/raid1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index b1345aa4efd8..4034a2963da8 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2130,6 +2130,7 @@ static void process_checks(struct r1bio *r1_bio)
 		int j;
 		int size;
 		int error;
+		struct bio_vec *bi;
 		struct bio *b = r1_bio->bios[i];
 		struct resync_pages *rp = get_resync_pages(b);
 		if (b->bi_end_io != end_sync_read)
@@ -2148,9 +2149,7 @@ static void process_checks(struct r1bio *r1_bio)
 		b->bi_private = rp;
 
 		size = b->bi_iter.bi_size;
-		for (j = 0; j < vcnt ; j++) {
-			struct bio_vec *bi;
-			bi = &b->bi_io_vec[j];
+		bio_for_each_segment_all(bi, b, j) {
 			bi->bv_offset = 0;
 			if (size > PAGE_SIZE)
 				bi->bv_len = PAGE_SIZE;
@@ -2174,17 +2173,22 @@ static void process_checks(struct r1bio *r1_bio)
 		int error = sbio->bi_error;
 		struct page **ppages = get_resync_pages(pbio)->pages;
 		struct page **spages = get_resync_pages(sbio)->pages;
+		struct bio_vec *bi;
+		int page_len[RESYNC_PAGES];
 
 		if (sbio->bi_end_io != end_sync_read)
 			continue;
 		/* Now we can 'fixup' the error value */
 		sbio->bi_error = 0;
 
+		bio_for_each_segment_all(bi, sbio, j)
+			page_len[j] = bi->bv_len;
+
 		if (!error) {
 			for (j = vcnt; j-- ; ) {
 				if (memcmp(page_address(ppages[j]),
 					   page_address(spages[j]),
-					   sbio->bi_io_vec[j].bv_len))
+					   page_len[j]))
 					break;
 			}
 		} else
-- 
2.9.3
