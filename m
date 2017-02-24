Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34615 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdBXPnr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 10:43:47 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 10/14] md: raid1: use bio_segments_all()
Date: Fri, 24 Feb 2017 23:42:47 +0800
Message-Id: <1487950971-1131-11-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
References: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use this helper, instead of direct access to .bi_vcnt.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/raid1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7363bf56f3b4..391da975e092 100644
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
