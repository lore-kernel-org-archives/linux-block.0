Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24180C7EE23
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEDDy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEDDyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647E1FDD;
        Wed,  3 May 2023 20:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECE462D2B;
        Thu,  4 May 2023 03:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB60C433EF;
        Thu,  4 May 2023 03:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172487;
        bh=U8FYOFX9ZlP5Pe/TxDzxFhoAKf7bQDW+viC0Wm0A7OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q30DCuIEONnM88yuG9QTPduSpZyW1kOLipzhU2AR1KrDjXnsKWF6E2E24zJtePrch
         ShMsGEpjdcF2wz9uvj2ofLgj0mP0UOyxyzOEMT4VlCMJUmvjVWm34dj+a/EH8gCe0d
         Yq1DFIWEFdFCKxYCnq/RoxfdNwjcvWtlt108YaPlAL9KBAe7cKRJ10LXsujFX5n2fB
         Lba6C51ofAP6TpX6OsQjkXVXxuwPZ3pzrGXk/4MEi9zpjRhITix7qftbz/r7ZFtfdp
         CERcaZ1AhTQqnmdNJp/Oi2/3AYL6uUyfyIGfiHfx7p8OLvJK/3yVPtlrZZeG3j/81o
         bo0C9LZglV++w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 1/7] blk-crypto: don't use struct request_queue for public interfaces
Date:   Wed,  3 May 2023 20:54:11 -0700
Message-Id: <20230504035417.61435-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit fce3caea0f241f5d34855c82c399d5e0e2d91f07 upstream.

Switch all public blk-crypto interfaces to use struct block_device
arguments to specify the device they operate on instead of th
request_queue, which is a block layer implementation detail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20221114042944.1009870-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/block/inline-encryption.rst | 12 ++++++------
 block/blk-crypto.c                        | 24 +++++++++++++----------
 drivers/md/dm-table.c                     |  2 +-
 fs/crypto/inline_crypt.c                  |  8 +++-----
 include/linux/blk-crypto.h                | 11 ++++-------
 5 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 4d151fbe20583..f9bf18ea65093 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -142,7 +142,7 @@ Therefore, we also introduce *blk-crypto-fallback*, which is an implementation
 of inline encryption using the kernel crypto API.  blk-crypto-fallback is built
 into the block layer, so it works on any block device without any special setup.
 Essentially, when a bio with an encryption context is submitted to a
-request_queue that doesn't support that encryption context, the block layer will
+block_device that doesn't support that encryption context, the block layer will
 handle en/decryption of the bio using blk-crypto-fallback.
 
 For encryption, the data cannot be encrypted in-place, as callers usually rely
@@ -187,7 +187,7 @@ API presented to users of the block layer
 
 ``blk_crypto_config_supported()`` allows users to check ahead of time whether
 inline encryption with particular crypto settings will work on a particular
-request_queue -- either via hardware or via blk-crypto-fallback.  This function
+block_device -- either via hardware or via blk-crypto-fallback.  This function
 takes in a ``struct blk_crypto_config`` which is like blk_crypto_key, but omits
 the actual bytes of the key and instead just contains the algorithm, data unit
 size, etc.  This function can be useful if blk-crypto-fallback is disabled.
@@ -195,7 +195,7 @@ size, etc.  This function can be useful if blk-crypto-fallback is disabled.
 ``blk_crypto_init_key()`` allows users to initialize a blk_crypto_key.
 
 Users must call ``blk_crypto_start_using_key()`` before actually starting to use
-a blk_crypto_key on a request_queue (even if ``blk_crypto_config_supported()``
+a blk_crypto_key on a block_device (even if ``blk_crypto_config_supported()``
 was called earlier).  This is needed to initialize blk-crypto-fallback if it
 will be needed.  This must not be called from the data path, as this may have to
 allocate resources, which may deadlock in that case.
@@ -207,7 +207,7 @@ for en/decryption.  Users don't need to worry about freeing the bio_crypt_ctx
 later, as that happens automatically when the bio is freed or reset.
 
 Finally, when done using inline encryption with a blk_crypto_key on a
-request_queue, users must call ``blk_crypto_evict_key()``.  This ensures that
+block_device, users must call ``blk_crypto_evict_key()``.  This ensures that
 the key is evicted from all keyslots it may be programmed into and unlinked from
 any kernel data structures it may be linked into.
 
@@ -221,9 +221,9 @@ as follows:
 5. ``blk_crypto_evict_key()`` (after all I/O has completed)
 6. Zeroize the blk_crypto_key (this has no dedicated function)
 
-If a blk_crypto_key is being used on multiple request_queues, then
+If a blk_crypto_key is being used on multiple block_devices, then
 ``blk_crypto_config_supported()`` (if used), ``blk_crypto_start_using_key()``,
-and ``blk_crypto_evict_key()`` must be called on each request_queue.
+and ``blk_crypto_evict_key()`` must be called on each block_device.
 
 API presented to device drivers
 ===============================
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index a496aaef85ba4..0047436b63371 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -354,20 +354,21 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 
 /*
  * Check if bios with @cfg can be en/decrypted by blk-crypto (i.e. either the
- * request queue it's submitted to supports inline crypto, or the
+ * block_device it's submitted to supports inline crypto, or the
  * blk-crypto-fallback is enabled and supports the cfg).
  */
-bool blk_crypto_config_supported(struct request_queue *q,
+bool blk_crypto_config_supported(struct block_device *bdev,
 				 const struct blk_crypto_config *cfg)
 {
 	return IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) ||
-	       __blk_crypto_cfg_supported(q->crypto_profile, cfg);
+	       __blk_crypto_cfg_supported(bdev_get_queue(bdev)->crypto_profile,
+					  cfg);
 }
 
 /**
  * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
+ * @bdev: block device to operate on
  * @key: A key to use on the device
- * @q: the request queue for the device
  *
  * Upper layers must call this function to ensure that either the hardware
  * supports the key's crypto settings, or the crypto API fallback has transforms
@@ -379,10 +380,11 @@ bool blk_crypto_config_supported(struct request_queue *q,
  *	   blk-crypto-fallback is either disabled or the needed algorithm
  *	   is disabled in the crypto API; or another -errno code.
  */
-int blk_crypto_start_using_key(const struct blk_crypto_key *key,
-			       struct request_queue *q)
+int blk_crypto_start_using_key(struct block_device *bdev,
+			       const struct blk_crypto_key *key)
 {
-	if (__blk_crypto_cfg_supported(q->crypto_profile, &key->crypto_cfg))
+	if (__blk_crypto_cfg_supported(bdev_get_queue(bdev)->crypto_profile,
+			&key->crypto_cfg))
 		return 0;
 	return blk_crypto_fallback_start_using_mode(key->crypto_cfg.crypto_mode);
 }
@@ -390,7 +392,7 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 /**
  * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
  *			    it may have been programmed into
- * @q: The request queue who's associated inline encryption hardware this key
+ * @bdev: The block_device who's associated inline encryption hardware this key
  *     might have been programmed into
  * @key: The key to evict
  *
@@ -400,14 +402,16 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
  *
  * Return: 0 on success or if the key wasn't in any keyslot; -errno on error.
  */
-int blk_crypto_evict_key(struct request_queue *q,
+int blk_crypto_evict_key(struct block_device *bdev,
 			 const struct blk_crypto_key *key)
 {
+	struct request_queue *q = bdev_get_queue(bdev);
+
 	if (__blk_crypto_cfg_supported(q->crypto_profile, &key->crypto_cfg))
 		return __blk_crypto_evict_key(q->crypto_profile, key);
 
 	/*
-	 * If the request_queue didn't support the key, then blk-crypto-fallback
+	 * If the block_device didn't support the key, then blk-crypto-fallback
 	 * may have been used, so try to evict the key from blk-crypto-fallback.
 	 */
 	return blk_crypto_fallback_evict_key(key);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 32b2d3b99d786..c571f2385b57f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1214,7 +1214,7 @@ static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
 	struct dm_keyslot_evict_args *args = data;
 	int err;
 
-	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
+	err = blk_crypto_evict_key(dev->bdev, args->key);
 	if (!args->err)
 		args->err = err;
 	/* Always try to evict the key from all devices. */
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index cea8b14007e6a..55c4d8c23d30d 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -139,8 +139,7 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 		return PTR_ERR(devs);
 
 	for (i = 0; i < num_devs; i++) {
-		if (!blk_crypto_config_supported(bdev_get_queue(devs[i]),
-						 &crypto_cfg))
+		if (!blk_crypto_config_supported(devs[i], &crypto_cfg))
 			goto out_free_devs;
 	}
 
@@ -184,8 +183,7 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 		goto fail;
 	}
 	for (i = 0; i < num_devs; i++) {
-		err = blk_crypto_start_using_key(blk_key,
-						 bdev_get_queue(devs[i]));
+		err = blk_crypto_start_using_key(devs[i], blk_key);
 		if (err)
 			break;
 	}
@@ -224,7 +222,7 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 	devs = fscrypt_get_devices(sb, &num_devs);
 	if (!IS_ERR(devs)) {
 		for (i = 0; i < num_devs; i++)
-			blk_crypto_evict_key(bdev_get_queue(devs[i]), blk_key);
+			blk_crypto_evict_key(devs[i], blk_key);
 		kfree(devs);
 	}
 	kfree_sensitive(blk_key);
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf1..561ca92e204d5 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -71,9 +71,6 @@ struct bio_crypt_ctx {
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 
-struct request;
-struct request_queue;
-
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
 static inline bool bio_has_crypt_ctx(struct bio *bio)
@@ -94,13 +91,13 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			unsigned int dun_bytes,
 			unsigned int data_unit_size);
 
-int blk_crypto_start_using_key(const struct blk_crypto_key *key,
-			       struct request_queue *q);
+int blk_crypto_start_using_key(struct block_device *bdev,
+			       const struct blk_crypto_key *key);
 
-int blk_crypto_evict_key(struct request_queue *q,
+int blk_crypto_evict_key(struct block_device *bdev,
 			 const struct blk_crypto_key *key);
 
-bool blk_crypto_config_supported(struct request_queue *q,
+bool blk_crypto_config_supported(struct block_device *bdev,
 				 const struct blk_crypto_config *cfg);
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
-- 
2.40.1

