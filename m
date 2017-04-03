Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33019 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdDCHXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 03:23:52 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/7] bio-integrity: save original iterator for verify stage
Date: Mon,  3 Apr 2017 11:23:27 +0400
Message-Id: <1491204212-9952-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In order to perform verification we need to know original data vector
But, after bio traverse io-stack it may be advanced, splited and relocated
many times so it is hard to guess original data vector.

In fact currently ->verify_fn not woks at all because at the moment
it it called bio->bi_iter.bi_size == 0

The simplest way to fix that is to save original data vector and treat is
as immutable.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio-integrity.c | 6 ++++--
 include/linux/bio.h   | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b5009a8..43a4476 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -238,10 +238,10 @@ static int bio_integrity_process(struct bio *bio,
 
 	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	iter.interval = 1 << bi->interval_exp;
-	iter.seed = bip_get_seed(bip);
+	iter.seed = bip->bip_verify_iter.bi_sector;
 	iter.prot_buf = prot_buf;
 
-	bio_for_each_segment(bv, bio, bviter) {
+	__bio_for_each_segment(bv, bio, bviter, bip->bip_verify_iter) {
 		void *kaddr = kmap_atomic(bv.bv_page);
 
 		iter.data_buf = kaddr + bv.bv_offset;
@@ -310,6 +310,7 @@ int bio_integrity_prep(struct bio *bio)
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
 	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	bip->bip_verify_iter = bio->bi_iter;
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
 		bip->bip_flags |= BIP_IP_CHECKSUM;
@@ -476,6 +477,7 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
 
 	bip->bip_vcnt = bip_src->bip_vcnt;
 	bip->bip_iter = bip_src->bip_iter;
+	bip->bip_verify_iter = bip_src->bip_verify_iter;
 
 	return 0;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8e52119..00b086a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -308,6 +308,7 @@ struct bio_integrity_payload {
 	struct bio		*bip_bio;	/* parent bio */
 
 	struct bvec_iter	bip_iter;
+	struct bvec_iter	bip_verify_iter;/* saved orig data iterator */
 
 	bio_end_io_t		*bip_end_io;	/* saved I/O completion fn */
 
-- 
2.9.3
