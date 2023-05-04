Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6967DC77B7C
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 03:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjEDDy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 23:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEDDyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 23:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E2F1B1;
        Wed,  3 May 2023 20:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 510A763163;
        Thu,  4 May 2023 03:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C589C433D2;
        Thu,  4 May 2023 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172488;
        bh=SpHG+KQvwWX8PVpfHaXOafyDEExTtMry83ljmvnuwHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogvoYeOQmEcI65PoYAe+PHeduNX4YmB5h+SsFQRjzGpPENgrkzGrYhlr57KfpkhFL
         1Z32CnhBkbyruDFU5PvGQM9MKyDq31FjF25WMNlXJja5sn/9OuZyDJ0JBVgnnYBeM5
         JwhbQisRy6Fq7MHoi7FVh0KImVH5EhPRxqQEJmlrwqcY9Xn56rlk8VdUqvc9VlaYUx
         fg0Tp7aBNAHH9KTXGRd1k1YNqdEJRVXQQcPFgXxvE5gbWSOywaBgpsLmAprQu3YO39
         UyrEcpXIvca/cj51E8jaqk2QYTyjKwlwxwAk9NdaDCn5KSnmemh6c6qlhAVgHAAHH8
         R4bjpavKlcQgQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 4/7] blk-crypto: Add a missing include directive
Date:   Wed,  3 May 2023 20:54:14 -0700
Message-Id: <20230504035417.61435-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 85168d416e5d3184b77dbec8fee75c9439894afa upstream.

Allow the compiler to verify consistency of function declarations and
function definitions. This patch fixes the following sparse errors:

block/blk-crypto-profile.c:241:14: error: no previous prototype for ‘blk_crypto_get_keyslot’ [-Werror=missing-prototypes]
  241 | blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
      |              ^~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:318:6: error: no previous prototype for ‘blk_crypto_put_keyslot’ [-Werror=missing-prototypes]
  318 | void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot)
      |      ^~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:344:6: error: no previous prototype for ‘__blk_crypto_cfg_supported’ [-Werror=missing-prototypes]
  344 | bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-crypto-profile.c:373:5: error: no previous prototype for ‘__blk_crypto_evict_key’ [-Werror=missing-prototypes]
  373 | int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
      |     ^~~~~~~~~~~~~~~~~~~~~~

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221123172923.434339-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto-profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 96c511967386d..0307fb0d95d34 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -32,6 +32,7 @@
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
+#include "blk-crypto-internal.h"
 
 struct blk_crypto_keyslot {
 	atomic_t slot_refs;
-- 
2.40.1

