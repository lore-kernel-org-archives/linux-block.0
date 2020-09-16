Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD6C43461
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 03:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F69221E3
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 03:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600228463;
	bh=gkyBV96JQe05ZTIpHO/yhCZume0/K4OfWBC+0QarbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJ7jZFU9a7vX/KlBR2DZ7i49IUcVEgPPdmqVOGYfFzoFotdWliwu/WitAPEm0fLWU
	 Qes092azgGE+BMrdM9G969JzP+HoySuzPaympFUTAMJUoWqYaV91lxfFmOcpKH4027
	 kiksivJmIPY1eUwqrgHkcneSIF+cRuJSACyy/pK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIPDyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 23:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIPDyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 23:54:07 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7385A221E3;
        Wed, 16 Sep 2020 03:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600228446;
        bh=gkyBV96JQe05ZTIpHO/yhCZume0/K4OfWBC+0QarbAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGT1plsjhxPd2lZmB1uTSE51w+k1bJWhkoFfS2OleyELN0/9eH71rWlWLsuxKWKRZ
         1akoka6Z/z+KDjhf0Sc0mYu5K37oYvxyHm5bqHwCGSYPp94zNh7r3cx7TloNqhzHO8
         /hdFMp52Wk5a68l6M1xb8qmUOb+tqH5F9Ypcelxo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v2 1/3] block: make bio_crypt_clone() able to fail
Date:   Tue, 15 Sep 2020 20:53:13 -0700
Message-Id: <20200916035315.34046-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916035315.34046-1-ebiggers@kernel.org>
References: <20200916035315.34046-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

bio_crypt_clone() assumes its gfp_mask argument always includes
__GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.

However, bio_crypt_clone() might be called with GFP_ATOMIC via
setup_clone() in drivers/md/dm-rq.c, or with GFP_NOWAIT via
kcryptd_io_read() in drivers/md/dm-crypt.c.

Neither case is currently reachable with a bio that actually has an
encryption context.  However, it's fragile to rely on this.  Just make
bio_crypt_clone() able to fail, analogous to bio_integrity_clone().

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/bio.c                | 20 +++++++++-----------
 block/blk-crypto.c         |  5 ++++-
 block/bounce.c             | 19 +++++++++----------
 drivers/md/dm.c            |  7 ++++---
 include/linux/blk-crypto.h | 20 ++++++++++++++++----
 5 files changed, 42 insertions(+), 29 deletions(-)

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
index 3dedd9cc4fb65..5487c3ff74b51 100644
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
index e82342907f2b1..69b24fe92cbf1 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -112,12 +112,24 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
-void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
-static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
-				   gfp_t gfp_mask)
+int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
+/**
+ * bio_crypt_clone - clone bio encryption context
+ * @dst: destination bio
+ * @src: source bio
+ * @gfp_mask: memory allocation flags
+ *
+ * If @src has an encryption context, clone it to @dst.
+ *
+ * Return: 0 on success, -ENOMEM if out of memory.  -ENOMEM is only possible if
+ *	   @gfp_mask doesn't include %__GFP_DIRECT_RECLAIM.
+ */
+static inline int bio_crypt_clone(struct bio *dst, struct bio *src,
+				  gfp_t gfp_mask)
 {
 	if (bio_has_crypt_ctx(src))
-		__bio_crypt_clone(dst, src, gfp_mask);
+		return __bio_crypt_clone(dst, src, gfp_mask);
+	return 0;
 }
 
 #endif /* __LINUX_BLK_CRYPTO_H */
-- 
2.28.0

