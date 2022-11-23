Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F81C3A59F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 17:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiKWRaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiKWR3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 12:29:45 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FEB8EB77
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:29:42 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id 9so1207767pfx.11
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 09:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVXugwYRhcpQLDDhVnsOKEojrymPMU7vDfL6DMPtVD4=;
        b=NJQuvwfNqgGdHnxEnvGURXvWX28qU4QqI2USdexr+L2PZl0f4DwpXSc8DLPH1VBYMS
         gJlV+2/dief3LBOeiCXWp+DiQ2oNreQQAWSsnGa5+5xBw3YC07Nx9vI3q+CC3BLZPreb
         NbWQh8x56e3+mJirRczmmxb4AFZ8cvStYmNK1Il6hCPOJKrMskTEgV4JSfwoafPbJj8C
         QiD4vjDtUmaqnz6LTAcMo7BOa4683LLdXidrClAg5OZIEsc83S8y2VAfOtiLPTPyJIYL
         a240ZflTlhyEtSV6IbW/C8yYHtonUI5oTCxRvI+vL5LfL3IQKVuAMhxdfRooxz83pSzz
         8ddw==
X-Gm-Message-State: ANoB5plSdvZITYowLznPxK0+3QFjsl4QbZiVLauEQwE9zfCk5SRnbbT+
        b6bNZquPBOif6hkei5FTmYo=
X-Google-Smtp-Source: AA0mqf6BfhF0WCAtlNgx45q7LxeOV7YXGDnOpEzLeDPyObTLKoOlQFXMFEKZUmwGtezMW/CkI3w45Q==
X-Received: by 2002:a63:f205:0:b0:477:acd9:896a with SMTP id v5-20020a63f205000000b00477acd9896amr6308923pgh.312.1669224581660;
        Wed, 23 Nov 2022 09:29:41 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0018685aaf41dsm14636762plg.18.2022.11.23.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:29:40 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH] blk-crypto: Add a missing include directive
Date:   Wed, 23 Nov 2022 09:29:23 -0800
Message-Id: <20221123172923.434339-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
---
 block/blk-crypto-profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 96c511967386..0307fb0d95d3 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -32,6 +32,7 @@
 #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
+#include "blk-crypto-internal.h"
 
 struct blk_crypto_keyslot {
 	atomic_t slot_refs;
