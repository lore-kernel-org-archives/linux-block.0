Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F8C7EE30
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjEDDzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEDDyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F81BD3;
        Wed,  3 May 2023 20:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E313D63161;
        Thu,  4 May 2023 03:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326DBC433EF;
        Thu,  4 May 2023 03:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172489;
        bh=Nm/+IIocwUdI6LDY8X3nqwzCVQcr2vl7MvpV8rgclkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD0Se5gaat0NgHYawKHAfwwbk6mnxU4zdLiuDu6ZTh9dAsFSPu4FENJr0I35goDpA
         mztwIsKuU4tyXRAadXXl24ky+QBX/fmJCaVJbEti3WXehQZcZLR19Tfl/k0wBvQDCN
         dN3rJ5I1GDUTOpUqJOIwmD9+DJDF525637cWyahRAh0A+Ly7pBobs+B7vVLCIzKHIM
         9pnjVFL/wZ7QRdKXCYOAThNOlKf4Oxio8/D8IDjU2tDY6QRB0aBePEsfUxtMJCjw+4
         j/ylDr93rJqG4iG7ePNveL+vxgBmU9+Y7oCiKsrcBh3jzWyO/Ep5RhzfpBiFK45rtk
         c1IwXrHpGALiQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 6/7] blk-crypto: make blk_crypto_evict_key() return void
Date:   Wed,  3 May 2023 20:54:16 -0700
Message-Id: <20230504035417.61435-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 70493a63ba04f754f7a7dd53a4fcc82700181490 upstream.

blk_crypto_evict_key() is only called in contexts such as inode eviction
where failure is not an option.  So there is nothing the caller can do
with errors except log them.  (dm-table.c does "use" the error code, but
only to pass on to upper layers, so it doesn't really count.)

Just make blk_crypto_evict_key() return void and log errors itself.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-crypto.c         | 20 +++++++++-----------
 drivers/md/dm-table.c      | 19 +++++--------------
 include/linux/blk-crypto.h |  4 ++--
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 19d81abf94fd8..099381d221542 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-crypto-profile.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -402,21 +403,18 @@ int blk_crypto_start_using_key(struct block_device *bdev,
  * Upper layers (filesystems) must call this function to ensure that a key is
  * evicted from any hardware that it might have been programmed into.  The key
  * must not be in use by any in-flight IO when this function is called.
- *
- * Return: 0 on success or if the key wasn't in any keyslot; -errno on error.
  */
-int blk_crypto_evict_key(struct block_device *bdev,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct block_device *bdev,
+			  const struct blk_crypto_key *key)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
+	int err;
 
 	if (blk_crypto_config_supported_natively(bdev, &key->crypto_cfg))
-		return __blk_crypto_evict_key(q->crypto_profile, key);
-
-	/*
-	 * If the block_device didn't support the key, then blk-crypto-fallback
-	 * may have been used, so try to evict the key from blk-crypto-fallback.
-	 */
-	return blk_crypto_fallback_evict_key(key);
+		err = __blk_crypto_evict_key(q->crypto_profile, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("%pg: error %d evicting key\n", bdev, err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index c571f2385b57f..3acded2f976db 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1203,21 +1203,12 @@ struct dm_crypto_profile {
 	struct mapped_device *md;
 };
 
-struct dm_keyslot_evict_args {
-	const struct blk_crypto_key *key;
-	int err;
-};
-
 static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
-	struct dm_keyslot_evict_args *args = data;
-	int err;
+	const struct blk_crypto_key *key = data;
 
-	err = blk_crypto_evict_key(dev->bdev, args->key);
-	if (!args->err)
-		args->err = err;
-	/* Always try to evict the key from all devices. */
+	blk_crypto_evict_key(dev->bdev, key);
 	return 0;
 }
 
@@ -1230,7 +1221,6 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 {
 	struct mapped_device *md =
 		container_of(profile, struct dm_crypto_profile, profile)->md;
-	struct dm_keyslot_evict_args args = { key };
 	struct dm_table *t;
 	int srcu_idx;
 
@@ -1243,11 +1233,12 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 
 		if (!ti->type->iterate_devices)
 			continue;
-		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback,
+					  (void *)key);
 	}
 
 	dm_put_live_table(md, srcu_idx);
-	return args.err;
+	return 0;
 }
 
 static int
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index a33d32f5c2684..ad17eaa192fbb 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -94,8 +94,8 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
 
-int blk_crypto_evict_key(struct block_device *bdev,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct block_device *bdev,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported_natively(struct block_device *bdev,
 					  const struct blk_crypto_config *cfg);
-- 
2.40.1

