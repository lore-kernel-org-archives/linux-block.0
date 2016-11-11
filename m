Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35253 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbcKKMHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2016 07:07:04 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Joern Engel <joern@logfs.org>,
        Prasad Joshi <prasadjoshi.linux@gmail.com>,
        logfs@logfs.org (open list:LogFS)
Subject: [PATCH 09/12] fs: logfs: convert to bio_add_page() in sync_request()
Date: Fri, 11 Nov 2016 20:05:37 +0800
Message-Id: <1478865957-25252-10-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Always bio_add_page() is the standard and preferred way to
do the task.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/logfs/dev_bdev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index dc8cafeee038..e01075790600 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -20,13 +20,9 @@ static int sync_request(struct page *page, struct block_device *bdev, int op)
 	struct bio_vec bio_vec;
 
 	bio_init(&bio, &bio_vec, 1);
-	bio_vec.bv_page = page;
-	bio_vec.bv_len = PAGE_SIZE;
-	bio_vec.bv_offset = 0;
-	bio.bi_vcnt = 1;
 	bio.bi_bdev = bdev;
+	bio_add_page(&bio, page, PAGE_SIZE, 0);
 	bio.bi_iter.bi_sector = page->index * (PAGE_SIZE >> 9);
-	bio.bi_iter.bi_size = PAGE_SIZE;
 	bio_set_op_attrs(&bio, op, 0);
 
 	return submit_bio_wait(&bio);
-- 
2.7.4

