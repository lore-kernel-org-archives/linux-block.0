Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE8C7EE24
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 04:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjEDEKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 00:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDEKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 00:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8C2111;
        Wed,  3 May 2023 21:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB7BE63174;
        Thu,  4 May 2023 04:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24625C4339C;
        Thu,  4 May 2023 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173404;
        bh=ONh2darfKTPTYzJEVpGAMWntgyVt0SBzJB7F5Cgn2A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=re9ZTZ6GmzleCceLMG/MS5IW998INfvu5Y4tE79+XwVhmVgWaPsBcsqPjXkvEBVT0
         nBch/u3WYOt9MoDFbV0OwZ7LCcVEcHePQmfgjaVCoQl//H5TBKwfcryp6qwXigTweC
         uAlTOT22u6ADw/w4P72bwjfYLNzTNAtyJG9vs0ttnsGPAcab+yUhE1ln9rmbfcMgPU
         8a+YDZSKxIaJiVxvSURvqw2JRy3XR/2Safg1KELISq0BsrZfgiTFrMUBvg3bdtBU7a
         eOIfxiMaDPlmbNhqUGCWKiL1iBktIhelN9XeKCPsEpWJNctac18yyqDZBy/H/3uMes
         jq2u/QDqRagjA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 2/3] blk-crypto: make blk_crypto_evict_key() return void
Date:   Wed,  3 May 2023 21:09:40 -0700
Message-Id: <20230504040941.152614-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504040941.152614-1-ebiggers@kernel.org>
References: <20230504040941.152614-1-ebiggers@kernel.org>
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
 include/linux/blk-crypto.h |  4 ++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 0506adfd9ca6b..d8c48ee44ba69 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/keyslot-manager.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -393,19 +394,16 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
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

