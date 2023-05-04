Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E6C77B78
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 04:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjEDEDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 00:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDEDj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 00:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B519B7;
        Wed,  3 May 2023 21:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A83106316B;
        Thu,  4 May 2023 04:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57A2C433D2;
        Thu,  4 May 2023 04:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173016;
        bh=Ml+Y04NT3Vn7m5v/vV1NblJ3kOliBeEFp8GFypj1UtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aW4nYJrdfK5qzwg2OdwoOQUAoGsc2cTBO0K5513EyXwp5gE82wNfK3xSbvtLljA5/
         OVWsmnCqAWE8xh/1TGGTBShwG3wWx1DqsevEoVKnXnlzhG+XoHDCF5Vac0j68NfUpk
         k8cWyF3DmKMHFbwr4ehH8KtpRH0guLHTmw5mBC4HqGz218GCyr8XDlkFhBn1RzG21n
         rAd/ECg+3qjZ3nH38G4JwNFPAtPB+E6t/3DVo7xRAM+F4iwWyx5STojC9db37xW+jo
         8kQ5gnMxZqHKu5PDqKvYx/VgRL0rmoRHctDzBBI1LGRP5Re5VYdev7GJ0NupkOZMyf
         /SHH5V110nX3w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 2/3] blk-crypto: make blk_crypto_evict_key() return void
Date:   Wed,  3 May 2023 21:03:28 -0700
Message-Id: <20230504040329.106127-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504040329.106127-1-ebiggers@kernel.org>
References: <20230504040329.106127-1-ebiggers@kernel.org>
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
 block/blk-crypto.c         | 22 ++++++++++------------
 drivers/md/dm-table.c      | 19 +++++--------------
 include/linux/blk-crypto.h |  4 ++--
 3 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 183d7439cf416..686c657f91917 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/keyslot-manager.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -393,20 +394,17 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
  * Upper layers (filesystems) must call this function to ensure that a key is
  * evicted from any hardware that it might have been programmed into.  The key
  * must not be in use by any in-flight IO when this function is called.
- *
- * Return: 0 on success or if key is not present in the q's ksm, -err on error.
  */
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key)
 {
-	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
-		return blk_ksm_evict_key(q->ksm, key);
+	int err;
 
-	/*
-	 * If the request queue's associated inline encryption hardware didn't
-	 * have support for the key, then the key might have been programmed
-	 * into the fallback keyslot manager, so try to evict from there.
-	 */
-	return blk_crypto_fallback_evict_key(key);
+	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		err = blk_ksm_evict_key(q->ksm, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("error %d evicting key\n", err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2111daaacabaf..46ec4590f62f6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1191,21 +1191,12 @@ struct dm_keyslot_manager {
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
 
-	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
-	if (!args->err)
-		args->err = err;
-	/* Always try to evict the key from all devices. */
+	blk_crypto_evict_key(bdev_get_queue(dev->bdev), key);
 	return 0;
 }
 
@@ -1220,7 +1211,6 @@ static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
 						       struct dm_keyslot_manager,
 						       ksm);
 	struct mapped_device *md = dksm->md;
-	struct dm_keyslot_evict_args args = { key };
 	struct dm_table *t;
 	int srcu_idx;
 	int i;
@@ -1233,10 +1223,11 @@ static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
 		ti = dm_table_get_target(t, i);
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
 
 static const struct blk_ksm_ll_ops dm_ksm_ll_ops = {
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf1..5e96bad548047 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -97,8 +97,8 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 			       struct request_queue *q);
 
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported(struct request_queue *q,
 				 const struct blk_crypto_config *cfg);
-- 
2.40.1

