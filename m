Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B893BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 01:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKXBlo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhKXBlo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 20:41:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69BA560555
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637717915;
        bh=0loXintXG2WGKke7uLOT/uavnU8gaf/DZhFFOSI6HlU=;
        h=From:To:Subject:Date:From;
        b=Hz2EuyftdRUkU1qnsO6M7AV6IZVUBaZkvR7mJNYTYGvrYRBVQ7hJtKwc2cnZv+tKy
         6AJw0/oPm12seRZiue3H+0rsQ2EYj07FLjCJdCBN0QbQ4UWrKLjOXCQj1z8ZVEQq4v
         oHL8IkxEtBaS679TfyKsEd+5wYxD3vNgfjbGnv3H2DDOQdp2iNi920GaGIy0ljaVIW
         uydOfXQeoL2NdaMMQzK/SMJ0wwavSYP1vowNCoVLRWd8X1PH+hjYVEwpISsZSo10Vh
         o1lYVhDsZrX/0GILxh+jEg6BFpFx2UA6CXcuRXM574IBBV4DjDSv2yXSes3XpUy/HT
         clLereAAEiJGA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Subject: [PATCH] blk-crypto: remove blk_crypto_unregister()
Date:   Tue, 23 Nov 2021 17:37:33 -0800
Message-Id: <20211124013733.347612-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This function is trivial and is only used in one place.  Having this
function is misleading because it implies that blk_crypto_register()
needs to be paired with blk_crypto_unregister(), which is not the case.
Just set disk->queue->crypto_profile to NULL directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto-profile.c | 5 -----
 block/blk-integrity.c      | 2 +-
 include/linux/blkdev.h     | 4 ----
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 605ba0626a5c0..96c511967386d 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -463,11 +463,6 @@ bool blk_crypto_register(struct blk_crypto_profile *profile,
 }
 EXPORT_SYMBOL_GPL(blk_crypto_register);
 
-void blk_crypto_unregister(struct request_queue *q)
-{
-	q->crypto_profile = NULL;
-}
-
 /**
  * blk_crypto_intersect_capabilities() - restrict supported crypto capabilities
  *					 by child device
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d670d54e5f7ac..69eed260a8239 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -411,7 +411,7 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	if (disk->queue->crypto_profile) {
 		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
-		blk_crypto_unregister(disk->queue);
+		disk->queue->crypto_profile = NULL;
 	}
 #endif
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca3..26cad06ed9f8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1171,8 +1171,6 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned lo
 bool blk_crypto_register(struct blk_crypto_profile *profile,
 			 struct request_queue *q);
 
-void blk_crypto_unregister(struct request_queue *q);
-
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool blk_crypto_register(struct blk_crypto_profile *profile,
@@ -1181,8 +1179,6 @@ static inline bool blk_crypto_register(struct blk_crypto_profile *profile,
 	return true;
 }
 
-static inline void blk_crypto_unregister(struct request_queue *q) { }
-
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 enum blk_unique_id {

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
2.34.0

