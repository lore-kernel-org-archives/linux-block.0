Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A1C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjHJODP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHJODP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:03:15 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A981120;
        Thu, 10 Aug 2023 07:03:14 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C8B6F835BE;
        Thu, 10 Aug 2023 10:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1691676194; bh=FKi9lWX389yWPHAdsOOq80Hxlwk+4mUEYc3mvuzJLzs=;
        h=From:To:Cc:Subject:Date:From;
        b=hzVLh3BHE2zW3OwLiVjC3Byo9LDXt2HCv/EqVLk3MwDIcjoggPkUg3S2it9GO63cO
         DKVY5MIOBmsO3rSsCiuwylA8BKZJs6kd9q8/ng/0q0Zqxt1uvvkFDo4fq2n0C7nXqh
         j7IJpGeTXxtJUBSEm9ZG0FjVb5M4gnL+57cv2m5w3TB3agltkHDlavosrMqJdFeQcb
         h0Nvccr9wJSIKTn4BjuIUxLI90iYtfQHVNwVhTWC1TlJBuOexoERcGo9a1HbeqwPNb
         yHXkpMGaU+3nUZavMGaygC/EHAYnFgaHUTlXGVZ8kDSIP3KzGFYZ4GwTXiLPC/8iXr
         BR3XX4yg63d/A==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        stable@vger.kernel.org
Subject: [PATCH v3] blk-crypto: dynamically allocate fallback profile
Date:   Thu, 10 Aug 2023 09:49:59 -0400
Message-ID: <20230810140307.92790-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_crypto_profile_init() calls lockdep_register_key(), which warns and
does not register if the provided memory is a static object.
blk-crypto-fallback currently has a static blk_crypto_profile and calls
blk_crypto_profile_init() thereupon, resulting in the warning and
failure to register.

Fortunately it is simple enough to use a dynamically allocated profile
and make lockdep function correctly.

Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
Cc: stable@vger.kernel.org
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
v3: added allocation error checking as noted by Eric Biggers.
v2: reworded commit message, fixed Fixes tag, as pointed out by Eric
Biggers.

 block/blk-crypto-fallback.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index ad9844c5b40c..4b0c661df191 100644
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
@@ -526,15 +526,14 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 {
-	return __blk_crypto_evict_key(&blk_crypto_fallback_profile, key);
+	return __blk_crypto_evict_key(blk_crypto_fallback_profile, key);
 }
 
 static bool blk_crypto_fallback_inited;
 static int blk_crypto_fallback_init(void)
 {
 	int i;
-	int err;
-	struct blk_crypto_profile *profile = &blk_crypto_fallback_profile;
+	int err = 0;
 
 	if (blk_crypto_fallback_inited)
 		return 0;
@@ -545,18 +544,25 @@ static int blk_crypto_fallback_init(void)
 	if (err)
 		goto out;
 
-	err = blk_crypto_profile_init(profile, blk_crypto_num_keyslots);
-	if (err)
+	/* Dynamic allocation is needed because of lockdep_register_key(). */
+	blk_crypto_fallback_profile =
+		kzalloc(sizeof(*blk_crypto_fallback_profile), GFP_KERNEL);
+	if (!blk_crypto_fallback_profile)
 		goto fail_free_bioset;
+
+	err = blk_crypto_profile_init(blk_crypto_fallback_profile,
+				      blk_crypto_num_keyslots);
+	if (err)
+		goto fail_free_profile;
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
@@ -597,7 +603,9 @@ static int blk_crypto_fallback_init(void)
 fail_free_wq:
 	destroy_workqueue(blk_crypto_wq);
 fail_destroy_profile:
-	blk_crypto_profile_destroy(profile);
+	blk_crypto_profile_destroy(blk_crypto_fallback_profile);
+fail_free_profile:
+	kfree(blk_crypto_fallback_profile);
 fail_free_bioset:
 	bioset_exit(&crypto_bio_split);
 out:
-- 
2.41.0

