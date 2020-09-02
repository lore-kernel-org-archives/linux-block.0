Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0BFC433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 05:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89B92078B
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599023794;
	bh=7NioYolFiINFX16bP6jasJwLznUoujiPqwtNXECfglw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CrVj2NZBD2s3rN9ls4zKOaM7AKUTfTNdegQadNT3f1zvUCXGdUOup98G5zNlGO9on
	 6X5jRecZEjD57IWhRl+qdhfK7GD/Sk6dXnGj63X+uK3/w1Uxtcf9rV+rrrQne/pTPA
	 L1SQVFaeUwZcVGHSwcTvSQEuaYdLrjyGEE5qRTwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBFQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgIBFQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 01:16:31 -0400
Received: from sol.localdomain (ip-99-203-42-15.pools.cgn.spcsdns.net [99.203.42.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2871020758;
        Wed,  2 Sep 2020 05:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599023791;
        bh=7NioYolFiINFX16bP6jasJwLznUoujiPqwtNXECfglw=;
        h=From:To:Cc:Subject:Date:From;
        b=D/gC+Fus0Uz8ar1uLb2McY6fv5637pAjwL8mk3X2MQTM0poesQxR1wscwnuxWt4Sf
         O15rc4jMx/3mSepJTGBZbnpeZkfzSO8sNLZpy4Ysh2s1rjbEfn+2gGcCbFBp15Un9k
         YZw8TI5XNLwhlp0c8WRBSUvTy5wQ1i3OSiqczkdo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH] block: make bio_crypt_clone() return an error code
Date:   Tue,  1 Sep 2020 22:15:11 -0700
Message-Id: <20200902051511.79821-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Callers of bio_clone_fast() may use a gfp_mask that excludes
GFP_DIRECT_RECLAIM.  For example, map_request() uses GFP_ATOMIC.

If this were to happen, the mempool_alloc() in __bio_crypt_clone() can
fail, causing a NULL dereference.

In reality map_request() currently never has to clone an encryption
context, since inline encryption isn't yet supported on device-mapper
devices at all, let alone on request-based ones.

But it is fragile to rely on this.  Just make bio_crypt_clone() able to
fail, similar to bio_integrity_clone().

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/bio.c                | 20 +++++++++-----------
 block/blk-crypto.c         |  5 ++++-
 block/bounce.c             | 19 +++++++++----------
 drivers/md/dm.c            |  7 ++++---
 include/linux/blk-crypto.h |  9 +++++----
 5 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d9332..b42e046b12eb3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -713,20 +713,18 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 
 	__bio_clone_fast(b, bio);
 
-	bio_crypt_clone(b, bio, gfp_mask);
+	if (bio_crypt_clone(b, bio, gfp_mask) < 0)
+		goto err_put;
 
-	if (bio_integrity(bio)) {
-		int ret;
-
-		ret = bio_integrity_clone(b, bio, gfp_mask);
-
-		if (ret < 0) {
-			bio_put(b);
-			return NULL;
-		}
-	}
+	if (bio_integrity(bio) &&
+	    bio_integrity_clone(b, bio, gfp_mask) < 0)
+		goto err_put;
 
 	return b;
+
+err_put:
+	bio_put(b);
+	return NULL;
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 2d5e60023b08b..a3f27a19067c9 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -95,10 +95,13 @@ void __bio_crypt_free_ctx(struct bio *bio)
 	bio->bi_crypt_context = NULL;
 }
 
-void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
+int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
 {
 	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
+	if (!dst->bi_crypt_context)
+		return -ENOMEM;
 	*dst->bi_crypt_context = *src->bi_crypt_context;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__bio_crypt_clone);
 
diff --git a/block/bounce.c b/block/bounce.c
index 431be88a02405..162a6eee89996 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -267,22 +267,21 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		break;
 	}
 
-	bio_crypt_clone(bio, bio_src, gfp_mask);
+	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0)
+		goto err_put;
 
-	if (bio_integrity(bio_src)) {
-		int ret;
-
-		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
-		if (ret < 0) {
-			bio_put(bio);
-			return NULL;
-		}
-	}
+	if (bio_integrity(bio_src) &&
+	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0)
+		goto err_put;
 
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
 
 	return bio;
+
+err_put:
+	bio_put(bio);
+	return NULL;
 }
 
 static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fb0255d25e4b2..e987b417d702f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1326,14 +1326,15 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 		     sector_t sector, unsigned len)
 {
 	struct bio *clone = &tio->clone;
+	int r;
 
 	__bio_clone_fast(clone, bio);
 
-	bio_crypt_clone(clone, bio, GFP_NOIO);
+	r = bio_crypt_clone(clone, bio, GFP_NOIO);
+	if (r < 0)
+		return r;
 
 	if (bio_integrity(bio)) {
-		int r;
-
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
 			     !dm_target_passes_integrity(tio->ti->type))) {
 			DMWARN("%s: the target %s doesn't support integrity data.",
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index e82342907f2b1..d0dba84f6a608 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -112,12 +112,13 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
-void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
-static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
-				   gfp_t gfp_mask)
+int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
+static inline int bio_crypt_clone(struct bio *dst, struct bio *src,
+				  gfp_t gfp_mask)
 {
 	if (bio_has_crypt_ctx(src))
-		__bio_crypt_clone(dst, src, gfp_mask);
+		return __bio_crypt_clone(dst, src, gfp_mask);
+	return 0;
 }
 
 #endif /* __LINUX_BLK_CRYPTO_H */

base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
-- 
2.28.0

