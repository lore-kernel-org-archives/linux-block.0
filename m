Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35998 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdB1Pmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 10:42:42 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 09/13] md: raid1: use bio_segments_all()
Date: Tue, 28 Feb 2017 23:41:39 +0800
Message-Id: <1488296503-4987-10-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1488296503-4987-1-git-send-email-tom.leiming@gmail.com>
References: <1488296503-4987-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use this helper, instead of direct access to .bi_vcnt.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/raid1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 316bd6dd6cc1..7396c99ff7b1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1091,7 +1091,8 @@ static void alloc_behind_pages(struct bio *bio, struct r1bio *r1_bio)
 {
 	int i;
 	struct bio_vec *bvec;
-	struct bio_vec *bvecs = kzalloc(bio->bi_vcnt * sizeof(struct bio_vec),
+	unsigned vcnt = bio_segments_all(bio);
+	struct bio_vec *bvecs = kzalloc(vcnt * sizeof(struct bio_vec),
 					GFP_NOIO);
 	if (unlikely(!bvecs))
 		return;
@@ -1107,12 +1108,12 @@ static void alloc_behind_pages(struct bio *bio, struct r1bio *r1_bio)
 		kunmap(bvec->bv_page);
 	}
 	r1_bio->behind_bvecs = bvecs;
-	r1_bio->behind_page_count = bio->bi_vcnt;
+	r1_bio->behind_page_count = vcnt;
 	set_bit(R1BIO_BehindIO, &r1_bio->state);
 	return;
 
 do_sync_io:
-	for (i = 0; i < bio->bi_vcnt; i++)
+	for (i = 0; i < vcnt; i++)
 		if (bvecs[i].bv_page)
 			put_page(bvecs[i].bv_page);
 	kfree(bvecs);
-- 
2.7.4
