Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176AAC77B78
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 04:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEDEKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 00:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEDEKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 00:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFA11FDA;
        Wed,  3 May 2023 21:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92B9B63176;
        Thu,  4 May 2023 04:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAF8C4339B;
        Thu,  4 May 2023 04:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173404;
        bh=ZLj/BUleOh17v3haSnv1Hp/ZzkI9DqH73VidxAbBQ+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI6VYsyx+PFf01GU+nqGKOoMwj/T+6CDtohM+r9ioVv+R0CSW1Nz2nmquPDbkyOm/
         Z5k+Glff4YtCOckUx7+lQ8f8Oib9xeqDjvMRuAZ5PCe9RvjVLI5jxBTYwtJ8Zd1D4i
         tUIxuMJ52GLEUtgeVCLkqEGAz0yTesfJXJDPs6pVjNYPZQpRGs8U8cZ8mXV1elDHiC
         8UCOKxe4IBm9+AfCZ3yEFhoA6iZZQsA/rd+lE/yqDO3E4xi2xxTEYf9c1dpQrjuLiU
         17089d8YHJ6my+Hze4alyQw21Hk4uSwtiF6epp8bv5HeUNxBIqKGCSan02A/xM2KV8
         poaVbqQAS19nw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Nathan Huckleberry <nhuck@google.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 1/3] blk-mq: release crypto keyslot before reporting I/O complete
Date:   Wed,  3 May 2023 21:09:39 -0700
Message-Id: <20230504040941.152614-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504040941.152614-1-ebiggers@kernel.org>
References: <20230504040941.152614-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 9cd1e566676bbcb8a126acd921e4e194e6339603 upstream.

Once all I/O using a blk_crypto_key has completed, filesystems can call
blk_crypto_evict_key().  However, the block layer currently doesn't call
blk_crypto_put_keyslot() until the request is being freed, which happens
after upper layers have been told (via bio_endio()) the I/O has
completed.  This causes a race condition where blk_crypto_evict_key()
can see 'slot_refs != 0' without there being an actual bug.

This makes __blk_crypto_evict_key() hit the
'WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)' and return without
doing anything, eventually causing a use-after-free in
blk_crypto_reprogram_all_keys().  (This is a very rare bug and has only
been seen when per-file keys are being used with fscrypt.)

There are two options to fix this: either release the keyslot before
bio_endio() is called on the request's last bio, or make
__blk_crypto_evict_key() ignore slot_refs.  Let's go with the first
solution, since it preserves the ability to report bugs (via
WARN_ON_ONCE) where a key is evicted while still in-use.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Cc: stable@vger.kernel.org
Reviewed-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c            |  7 +++++++
 block/blk-crypto-internal.h | 25 +++++++++++++++++++++----
 block/blk-crypto.c          | 24 ++++++++++++------------
 block/blk-merge.c           |  2 ++
 block/blk-mq.c              |  2 +-
 5 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9afb79b322fb0..d0d0dd8151f75 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1444,6 +1444,13 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
+	/*
+	 * Upper layers may call blk_crypto_evict_key() anytime after the last
+	 * bio_endio().  Therefore, the keyslot must be released before that.
+	 */
+	if (blk_crypto_rq_has_keyslot(req) && nr_bytes >= blk_rq_bytes(req))
+		__blk_crypto_rq_put_keyslot(req);
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
 		print_req_error(req, error, __func__);
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7b..8e08345576203 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return rq->crypt_keyslot;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +98,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -127,14 +137,21 @@ static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq);
-static inline blk_status_t blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
+static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	if (blk_crypto_rq_is_encrypted(rq))
-		return __blk_crypto_init_request(rq);
+		return __blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
+void __blk_crypto_rq_put_keyslot(struct request *rq);
+static inline void blk_crypto_rq_put_keyslot(struct request *rq)
+{
+	if (blk_crypto_rq_has_keyslot(rq))
+		__blk_crypto_rq_put_keyslot(rq);
+}
+
 void __blk_crypto_free_request(struct request *rq);
 static inline void blk_crypto_free_request(struct request *rq)
 {
@@ -173,7 +190,7 @@ static inline blk_status_t blk_crypto_insert_cloned_request(struct request *rq)
 {
 
 	if (blk_crypto_rq_is_encrypted(rq))
-		return blk_crypto_init_request(rq);
+		return blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5ffa9aab49de0..0506adfd9ca6b 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -216,26 +216,26 @@ static bool bio_crypt_check_alignment(struct bio *bio)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
 					&rq->crypt_keyslot);
 }
 
-/**
- * __blk_crypto_free_request - Uninitialize the crypto fields of a request.
- *
- * @rq: The request whose crypto fields to uninitialize.
- *
- * Completely uninitializes the crypto fields of a request. If a keyslot has
- * been programmed into some inline encryption hardware, that keyslot is
- * released. The rq->crypt_ctx is also freed.
- */
-void __blk_crypto_free_request(struct request *rq)
+void __blk_crypto_rq_put_keyslot(struct request *rq)
 {
 	blk_ksm_put_slot(rq->crypt_keyslot);
+	rq->crypt_keyslot = NULL;
+}
+
+void __blk_crypto_free_request(struct request *rq)
+{
+	/* The keyslot, if one was needed, should have been released earlier. */
+	if (WARN_ON_ONCE(rq->crypt_keyslot))
+		__blk_crypto_rq_put_keyslot(rq);
+
 	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
-	blk_crypto_rq_set_defaults(rq);
+	rq->crypt_ctx = NULL;
 }
 
 /**
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fbba277364f01..f3b016b31af86 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -801,6 +801,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (!blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
+	blk_crypto_rq_put_keyslot(next);
+
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf66de0f00fd3..e153a36c9ba3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2193,7 +2193,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
-	ret = blk_crypto_init_request(rq);
+	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
 		bio->bi_status = ret;
 		bio_endio(bio);
-- 
2.40.1

