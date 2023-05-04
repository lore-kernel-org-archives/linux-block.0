Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB836C7EE2D
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 04:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEDEDn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 00:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEDEDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 00:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3219BA;
        Wed,  3 May 2023 21:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04EC63168;
        Thu,  4 May 2023 04:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35629C4339C;
        Thu,  4 May 2023 04:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173016;
        bh=Rw6OQ3LcxGiiPKVGZx6T1IfqllCpHh818CF0k6s5YlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB7P57IPWB5GbosmOSWRzG/xOhS+9xOzNz7z//FndwY4b69Fn4MsvEfoZJXv22O3W
         RwnOx8tFsqWeQmw9Kk8BrA+Xto0FNWyXMDFzHR0Bw0C9/l6p9VCzIULMKtcEDFT2Xv
         yLG6L9vd20GBzLppRElWVg063msKtLBlH4TEU7pRQBPq4tYm00m2LhUi1M8Iywo2aV
         A3eJuvjg02ge6Ql2co83OVPokMKvoYhzYMtL12XUISRRlr9Kz5QRLfloICXuM6F0a9
         AucrMiUyPg8EKyx9Gh7pYwq+ogqg4K/lcuKuce+s9SAk7PoYZwVBpmVsgpxtItb0KI
         tVlaWj7RgvQdw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 3/3] blk-crypto: make blk_crypto_evict_key() more robust
Date:   Wed,  3 May 2023 21:03:29 -0700
Message-Id: <20230504040329.106127-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504040329.106127-1-ebiggers@kernel.org>
References: <20230504040329.106127-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 5c7cb94452901a93e90c2230632e2c12a681bc92 upstream.

If blk_crypto_evict_key() sees that the key is still in-use (due to a
bug) or that ->keyslot_evict failed, it currently just returns while
leaving the key linked into the keyslot management structures.

However, blk_crypto_evict_key() is only called in contexts such as inode
eviction where failure is not an option.  So actually the caller
proceeds with freeing the blk_crypto_key regardless of the return value
of blk_crypto_evict_key().

These two assumptions don't match, and the result is that there can be a
use-after-free in blk_crypto_reprogram_all_keys() after one of these
errors occurs.  (Note, these errors *shouldn't* happen; we're just
talking about what happens if they do anyway.)

Fix this by making blk_crypto_evict_key() unlink the key from the
keyslot management structures even on failure.

Also improve some comments.

Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-crypto.c      | 29 +++++++++++++++++++--------
 block/keyslot-manager.c | 43 ++++++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 686c657f91917..5029a50807d5d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -385,15 +385,20 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 }
 
 /**
- * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
- *			    it may have been programmed into
- * @q: The request queue who's associated inline encryption hardware this key
- *     might have been programmed into
- * @key: The key to evict
+ * blk_crypto_evict_key() - Evict a blk_crypto_key from a request_queue
+ * @q: a request_queue on which I/O using the key may have been done
+ * @key: the key to evict
  *
- * Upper layers (filesystems) must call this function to ensure that a key is
- * evicted from any hardware that it might have been programmed into.  The key
- * must not be in use by any in-flight IO when this function is called.
+ * For a given request_queue, this function removes the given blk_crypto_key
+ * from the keyslot management structures and evicts it from any underlying
+ * hardware keyslot(s) or blk-crypto-fallback keyslot it may have been
+ * programmed into.
+ *
+ * Upper layers must call this before freeing the blk_crypto_key.  It must be
+ * called for every request_queue the key may have been used on.  The key must
+ * no longer be in use by any I/O when this function is called.
+ *
+ * Context: May sleep.
  */
 void blk_crypto_evict_key(struct request_queue *q,
 			  const struct blk_crypto_key *key)
@@ -404,6 +409,14 @@ void blk_crypto_evict_key(struct request_queue *q,
 		err = blk_ksm_evict_key(q->ksm, key);
 	else
 		err = blk_crypto_fallback_evict_key(key);
+	/*
+	 * An error can only occur here if the key failed to be evicted from a
+	 * keyslot (due to a hardware or driver issue) or is allegedly still in
+	 * use by I/O (due to a kernel bug).  Even in these cases, the key is
+	 * still unlinked from the keyslot management structures, and the caller
+	 * is allowed and expected to free it right away.  There's nothing
+	 * callers can do to handle errors, so just log them and return void.
+	 */
 	if (err)
 		pr_warn_ratelimited("error %d evicting key\n", err);
 }
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca1..2a7a36551cfae 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -343,25 +343,16 @@ bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
 	return true;
 }
 
-/**
- * blk_ksm_evict_key() - Evict a key from the lower layer device.
- * @ksm: The keyslot manager to evict from
- * @key: The key to evict
- *
- * Find the keyslot that the specified key was programmed into, and evict that
- * slot from the lower layer device. The slot must not be in use by any
- * in-flight IO when this function is called.
- *
- * Context: Process context. Takes and releases ksm->lock.
- * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
- *	   if the keyslot is still in use, or another -errno value on other
- *	   error.
+/*
+ * This is an internal function that evicts a key from an inline encryption
+ * device that can be either a real device or the blk-crypto-fallback "device".
+ * It is used only by blk_crypto_evict_key(); see that function for details.
  */
 int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 		      const struct blk_crypto_key *key)
 {
 	struct blk_ksm_keyslot *slot;
-	int err = 0;
+	int err;
 
 	if (blk_ksm_is_passthrough(ksm)) {
 		if (ksm->ksm_ll_ops.keyslot_evict) {
@@ -375,22 +366,30 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
-	if (!slot)
-		goto out_unlock;
+	if (!slot) {
+		/*
+		 * Not an error, since a key not in use by I/O is not guaranteed
+		 * to be in a keyslot.  There can be more keys than keyslots.
+		 */
+		err = 0;
+		goto out;
+	}
 
 	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
+		/* BUG: key is still in use by I/O */
 		err = -EBUSY;
-		goto out_unlock;
+		goto out_remove;
 	}
 	err = ksm->ksm_ll_ops.keyslot_evict(ksm, key,
 					    blk_ksm_get_slot_idx(slot));
-	if (err)
-		goto out_unlock;
-
+out_remove:
+	/*
+	 * Callers free the key even on error, so unlink the key from the hash
+	 * table and clear slot->key even on error.
+	 */
 	hlist_del(&slot->hash_node);
 	slot->key = NULL;
-	err = 0;
-out_unlock:
+out:
 	blk_ksm_hw_exit(ksm);
 	return err;
 }
-- 
2.40.1

