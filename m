Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail2-drop-p3.anu.edu.au ([130.56.64.39]:51038 "EHLO
        mail2-drop-p3.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeGaJEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jul 2018 05:04:50 -0400
From: Li Dongyang <dongyangli@ddn.com>
To: linux-block@vger.kernel.org
Cc: adilger@dilger.ca, lixi@ddn.com, martin.petersen@oracle.com,
        sihara@ddn.com
Subject: [PATCH 2/2] block: pass bio into integrity_processing_fn
Date: Tue, 31 Jul 2018 17:19:38 +1000
Message-Id: <20180731071938.22129-2-dongyangli@ddn.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Having struct bio allows us to do more in the genrate/verify_fn,
like copying a knwon good guard tag already available rather than
calculating it.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 block/bio-integrity.c  |  2 +-
 block/blk-integrity.c  |  3 ++-
 block/t10-pi.c         | 24 ++++++++++++++++--------
 include/linux/blkdev.h |  3 ++-
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b280784671d..79c77984a2ac 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -214,7 +214,7 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 		iter.data_buf = kaddr + bv.bv_offset;
 		iter.data_size = bv.bv_len;
 
-		ret = proc_fn(&iter);
+		ret = proc_fn(bio, &iter);
 		if (ret) {
 			kunmap_atomic(kaddr);
 			return ret;
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 6121611e1316..8207dd7f3fe3 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -384,7 +384,8 @@ static struct kobj_type integrity_ktype = {
 	.sysfs_ops	= &integrity_ops,
 };
 
-static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
+static blk_status_t blk_integrity_nop_fn(struct bio *bio,
+					 struct blk_integrity_iter *iter)
 {
 	return BLK_STS_OK;
 }
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a98db384048f..c409f33a54bc 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -117,42 +117,50 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 	return BLK_STS_OK;
 }
 
-static blk_status_t t10_pi_type1_generate_crc(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type1_generate_crc(struct bio *bio,
+					      struct blk_integrity_iter *iter)
 {
 	return t10_pi_generate(iter, t10_pi_crc_fn, 1);
 }
 
-static blk_status_t t10_pi_type1_generate_ip(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type1_generate_ip(struct bio *bio,
+					     struct blk_integrity_iter *iter)
 {
 	return t10_pi_generate(iter, t10_pi_ip_fn, 1);
 }
 
-static blk_status_t t10_pi_type1_verify_crc(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type1_verify_crc(struct bio *bio,
+					    struct blk_integrity_iter *iter)
 {
 	return t10_pi_verify(iter, t10_pi_crc_fn, 1);
 }
 
-static blk_status_t t10_pi_type1_verify_ip(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type1_verify_ip(struct bio *bio,
+					   struct blk_integrity_iter *iter)
 {
 	return t10_pi_verify(iter, t10_pi_ip_fn, 1);
 }
 
-static blk_status_t t10_pi_type3_generate_crc(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type3_generate_crc(struct bio *bio,
+					      struct blk_integrity_iter *iter)
 {
 	return t10_pi_generate(iter, t10_pi_crc_fn, 3);
 }
 
-static blk_status_t t10_pi_type3_generate_ip(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type3_generate_ip(struct bio *bio,
+					     struct blk_integrity_iter *iter)
 {
 	return t10_pi_generate(iter, t10_pi_ip_fn, 3);
 }
 
-static blk_status_t t10_pi_type3_verify_crc(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type3_verify_crc(struct bio *bio,
+					    struct blk_integrity_iter *iter)
 {
 	return t10_pi_verify(iter, t10_pi_crc_fn, 3);
 }
 
-static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
+static blk_status_t t10_pi_type3_verify_ip(struct bio *bio,
+					   struct blk_integrity_iter *iter)
 {
 	return t10_pi_verify(iter, t10_pi_ip_fn, 3);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..1be4e3a69e81 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1805,7 +1805,8 @@ struct blk_integrity_iter {
 	const char		*disk_name;
 };
 
-typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
+typedef blk_status_t (integrity_processing_fn) (struct bio *,
+						struct blk_integrity_iter *);
 
 struct blk_integrity_profile {
 	integrity_processing_fn		*generate_fn;
-- 
2.18.0
