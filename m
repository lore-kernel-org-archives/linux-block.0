Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH] block: constify struct blk_integrity_profile
Date: Fri, 24 Mar 2017 18:03:48 -0700
Message-Id: <20170325010348.74421-1-ebiggers3@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

blk_integrity_profile's are never modified, so mark them 'const' so that
they are placed in .rodata and benefit from memory protection.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-integrity.c  |  2 +-
 block/t10-pi.c         |  8 ++++----
 include/linux/genhd.h  | 10 +++++-----
 include/linux/t10-pi.h |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 9f0ff5ba4f84..b3622cb00fc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -389,7 +389,7 @@ static int blk_integrity_nop_fn(struct blk_integrity_iter *iter)
 	return 0;
 }
 
-static struct blk_integrity_profile nop_profile = {
+static const struct blk_integrity_profile nop_profile = {
 	.name = "nop",
 	.generate_fn = blk_integrity_nop_fn,
 	.verify_fn = blk_integrity_nop_fn,
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 2c97912335a9..680c6d636298 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -160,28 +160,28 @@ static int t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 	return t10_pi_verify(iter, t10_pi_ip_fn, 3);
 }
 
-struct blk_integrity_profile t10_pi_type1_crc = {
+const struct blk_integrity_profile t10_pi_type1_crc = {
 	.name			= "T10-DIF-TYPE1-CRC",
 	.generate_fn		= t10_pi_type1_generate_crc,
 	.verify_fn		= t10_pi_type1_verify_crc,
 };
 EXPORT_SYMBOL(t10_pi_type1_crc);
 
-struct blk_integrity_profile t10_pi_type1_ip = {
+const struct blk_integrity_profile t10_pi_type1_ip = {
 	.name			= "T10-DIF-TYPE1-IP",
 	.generate_fn		= t10_pi_type1_generate_ip,
 	.verify_fn		= t10_pi_type1_verify_ip,
 };
 EXPORT_SYMBOL(t10_pi_type1_ip);
 
-struct blk_integrity_profile t10_pi_type3_crc = {
+const struct blk_integrity_profile t10_pi_type3_crc = {
 	.name			= "T10-DIF-TYPE3-CRC",
 	.generate_fn		= t10_pi_type3_generate_crc,
 	.verify_fn		= t10_pi_type3_verify_crc,
 };
 EXPORT_SYMBOL(t10_pi_type3_crc);
 
-struct blk_integrity_profile t10_pi_type3_ip = {
+const struct blk_integrity_profile t10_pi_type3_ip = {
 	.name			= "T10-DIF-TYPE3-IP",
 	.generate_fn		= t10_pi_type3_generate_ip,
 	.verify_fn		= t10_pi_type3_verify_ip,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 76f39754e7b0..9e11082c7f9b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -159,11 +159,11 @@ struct badblocks;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 
 struct blk_integrity {
-	struct blk_integrity_profile	*profile;
-	unsigned char			flags;
-	unsigned char			tuple_size;
-	unsigned char			interval_exp;
-	unsigned char			tag_size;
+	const struct blk_integrity_profile	*profile;
+	unsigned char				flags;
+	unsigned char				tuple_size;
+	unsigned char				interval_exp;
+	unsigned char				tag_size;
 };
 
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 9fba9dd33544..9375d23a24e7 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -34,9 +34,9 @@ struct t10_pi_tuple {
 };
 
 
-extern struct blk_integrity_profile t10_pi_type1_crc;
-extern struct blk_integrity_profile t10_pi_type1_ip;
-extern struct blk_integrity_profile t10_pi_type3_crc;
-extern struct blk_integrity_profile t10_pi_type3_ip;
+extern const struct blk_integrity_profile t10_pi_type1_crc;
+extern const struct blk_integrity_profile t10_pi_type1_ip;
+extern const struct blk_integrity_profile t10_pi_type3_crc;
+extern const struct blk_integrity_profile t10_pi_type3_ip;
 
 #endif
-- 
2.12.1.578.ge9c3154ca4-goog
