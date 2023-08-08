Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A2C04A94
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjHHSSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjHHSRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:17:44 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754920269
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:25:54 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 816FF83568;
        Tue,  8 Aug 2023 13:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691515554; bh=Is2HliG2MkqspBW6f5BxRuASCS2e9kkNjtTWGyrNrys=;
        h=From:To:Cc:Subject:Date:From;
        b=vDnZjSX04HJQJMr8fJnGuH7u9PkX8Nvibo360GG8z9XxUAYmbwhVqThVkGTux72L8
         WSvGyXGkGW6BLit4zqII0HqkIVj8qz1fTwT0HjnbMFSmiUeeO+KrowadeDztRpE2Ki
         vWNKCqqhpjbzsT1seHzoaTf3WGbV3hjraDh4xH2KP14RJo4uNHGJEFmh5tS++NpikP
         j7kT/os6aUJXvhjw9y7WKOLNQYF8NZtTiLm1J2OoY1Xp2sm0AkG1LB3ASUlKcfKULb
         guiaE7/djBuoxH9OLHzBTJrgF2hw8E/pIMc/L5qX5936+CCFZkf6noYIsO3NCtwNzw
         l0bK2K12sV4zw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] blk-crypto: dynamically allocate fallback profile
Date:   Tue,  8 Aug 2023 13:25:30 -0400
Message-ID: <20230808172536.211434-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_profile_init() calls lockdep_register_key(), which asserts
that the provided memory is not a static object. Unfortunately,
blk-crypto-fallback currently has a single static blk_crypto_profile,
which means trying to use the fallback with lockdep explodes in
blk_crypto_fallback_init().

Fortunately it is simple enough to use a dynamically allocated profile
for fallback, allowing the use of lockdep.

Fixes: 488f6682c832e ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 block/blk-crypto-fallback.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index ad9844c5b40c..de94e9bffec6 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -78,7 +78,7 @@ static struct blk_crypto_fallback_keyslot {
 	struct crypto_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
 } *blk_crypto_keyslots;
 
-static struct blk_crypto_profile blk_crypto_fallback_profile;
+static struct blk_crypto_profile *blk_crypto_fallback_profile;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
 static struct bio_set crypto_bio_split;
@@ -292,7 +292,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
 	 */
-	blk_st = blk_crypto_get_keyslot(&blk_crypto_fallback_profile,
+	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		src_bio->bi_status = blk_st;
@@ -395,7 +395,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
 	 */
-	blk_st = blk_crypto_get_keyslot(&blk_crypto_fallback_profile,
+	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		bio->bi_status = blk_st;
@@ -499,7 +499,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 		return false;
 	}
 
-	if (!__blk_crypto_cfg_supported(&blk_crypto_fallback_profile,
+	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
 		return false;
@@ -526,7 +526,7 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 {
-	return __blk_crypto_evict_key(&blk_crypto_fallback_profile, key);
+	return __blk_crypto_evict_key(blk_crypto_fallback_profile, key);
 }
 
 static bool blk_crypto_fallback_inited;
@@ -534,29 +534,32 @@ static int blk_crypto_fallback_init(void)
 {
 	int i;
 	int err;
-	struct blk_crypto_profile *profile = &blk_crypto_fallback_profile;
 
 	if (blk_crypto_fallback_inited)
 		return 0;
 
 	get_random_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
 
+	blk_crypto_fallback_profile =
+		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
+
 	err = bioset_init(&crypto_bio_split, 64, 0, 0);
 	if (err)
 		goto out;
 
-	err = blk_crypto_profile_init(profile, blk_crypto_num_keyslots);
+	err = blk_crypto_profile_init(blk_crypto_fallback_profile,
+				      blk_crypto_num_keyslots);
 	if (err)
 		goto fail_free_bioset;
 	err = -ENOMEM;
 
-	profile->ll_ops = blk_crypto_fallback_ll_ops;
-	profile->max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
+	blk_crypto_fallback_profile->ll_ops = blk_crypto_fallback_ll_ops;
+	blk_crypto_fallback_profile->max_dun_bytes_supported = BLK_CRYPTO_MAX_IV_SIZE;
 
 	/* All blk-crypto modes have a crypto API fallback. */
 	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
-		profile->modes_supported[i] = 0xFFFFFFFF;
-	profile->modes_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
+		blk_crypto_fallback_profile->modes_supported[i] = 0xFFFFFFFF;
+	blk_crypto_fallback_profile->modes_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
 
 	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
 					WQ_UNBOUND | WQ_HIGHPRI |
@@ -597,7 +600,7 @@ static int blk_crypto_fallback_init(void)
 fail_free_wq:
 	destroy_workqueue(blk_crypto_wq);
 fail_destroy_profile:
-	blk_crypto_profile_destroy(profile);
+	blk_crypto_profile_destroy(blk_crypto_fallback_profile);
 fail_free_bioset:
 	bioset_exit(&crypto_bio_split);
 out:

base-commit: 54d2161835d828a9663f548f61d1d9c3d3482122
-- 
2.41.0

