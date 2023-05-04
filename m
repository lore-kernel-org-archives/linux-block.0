Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFFC7EE25
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEDDzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjEDDyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91211FFB;
        Wed,  3 May 2023 20:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055FB6315A;
        Thu,  4 May 2023 03:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46447C4339B;
        Thu,  4 May 2023 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172488;
        bh=B4LI7DiLRdXOYbWcM4+hYj8ZaDh6RsK/MpuMkXKGky4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0q7c+0ZAv2BCm065cTjhI9vCCtjxJcWRO4A93WuGx1obaYfmVAmTleHQFOLof1yI
         RfngTQWYm1FBGyumnJ64C3Glz7jo6s9fLriO2i9UHM4QvrwYHGSoQl0JZg3gx9JN4s
         0vp2+BA3mZ9Jnz8nypl0rCc+0B7lDHzH3pB8DIvYVj/vLBPo8StSoTxCMPX57g5U9l
         Q2s+KuW8czM1iAd/+avLwzu2zUDDCw5zLccmr3c81bFDUfWxlC9wHUMYXNjIYOT9jd
         WnczM/92uvcGPrO91AmNs4s+dE+cqGQKySgPonTOvOGER8Ls5B8QI7mIB2fr8i5RAm
         XY9Eoe+t6rxDg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 3/7] blk-crypto: move internal only declarations to blk-crypto-internal.h
Date:   Wed,  3 May 2023 20:54:13 -0700
Message-Id: <20230504035417.61435-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 3569788c08235c6f3e9e6ca724b2df44787ff487 upstream.

 blk_crypto_get_keyslot, blk_crypto_put_keyslot, __blk_crypto_evict_key
and __blk_crypto_cfg_supported are only used internally by the
blk-crypto code, so move the out of blk-crypto-profile.h, which is
included by drivers that supply blk-crypto functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20221114042944.1009870-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto-internal.h        | 12 ++++++++++++
 include/linux/blk-crypto-profile.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffaddbf8..d31fa80454e49 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -65,6 +65,18 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
+				    const struct blk_crypto_key *key,
+				    struct blk_crypto_keyslot **slot_ptr);
+
+void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot);
+
+int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
+			   const struct blk_crypto_key *key);
+
+bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
+				const struct blk_crypto_config *cfg);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline int blk_crypto_sysfs_register(struct request_queue *q)
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index bbab65bd54288..e6802b69cdd64 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -138,18 +138,6 @@ int devm_blk_crypto_profile_init(struct device *dev,
 
 unsigned int blk_crypto_keyslot_index(struct blk_crypto_keyslot *slot);
 
-blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
-				    const struct blk_crypto_key *key,
-				    struct blk_crypto_keyslot **slot_ptr);
-
-void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot);
-
-bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
-				const struct blk_crypto_config *cfg);
-
-int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
-			   const struct blk_crypto_key *key);
-
 void blk_crypto_reprogram_all_keys(struct blk_crypto_profile *profile);
 
 void blk_crypto_profile_destroy(struct blk_crypto_profile *profile);
-- 
2.40.1

