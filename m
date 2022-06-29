Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E732C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiF2XdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiF2XdN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:13 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A9659E
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:03 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id 136so11379755pfy.10
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDrUbGX6pJvpKfdPLgsIQ+aIpWdnNjzAWz8vQdxyqAM=;
        b=0iZ7iAxGOf0J8SdqvHsqDjCWKaHDc6ocGL8bhZsIV6e8gku63wa1SpopyQPekMenVh
         jo73RO094pzRorA7zgknxd/LGISV4CRGtkQX185BVOqRWGjQ2mHUeXkXNgbHMnODHxFc
         vJis+/Lyh8ys+xXvqPUp1cVTCFc8y6qawoVtGfy8uwgCCpip1/oOv+nX6KSdaqCNWRP6
         4q4tGrDX4YbGm0Do2RrOyTl9Rhy9O2BsRSesAkrz7EJDH6wFfNxM+V05VNZJI9YiyQQV
         ZKs4dKGD30rJuZTs5S+oAxdCk1I1FST6aA5Jfvkg4LXMwjbmIM/jSB47VrpovNg/8/yF
         qP5w==
X-Gm-Message-State: AJIora+8MF9Aimfv98D9IhruVhxAdR57Vuquy5Z8p8PnGAGUg6y3vOol
        zbOQhHkZJ7uEeNGYTU7B59V7T3DCu6vPPw==
X-Google-Smtp-Source: AGRyM1uNFExjXkzW18yrchiCGdwNZ4F8IwOQ/9VIv3Gq8PHkVf2jLmoQRA1Ks5fJD8h9gueZ24yrkg==
X-Received: by 2002:a63:e64f:0:b0:40d:e79f:8b73 with SMTP id p15-20020a63e64f000000b0040de79f8b73mr4868695pgj.243.1656545582363;
        Wed, 29 Jun 2022 16:33:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 45/63] mm: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:27 -0700
Message-Id: <20220629233145.2779494-46-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for block
layer request flags.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/writeback.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index b8c9610c2313..3f045f6d6c4f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -101,9 +101,9 @@ struct writeback_control {
 #endif
 };
 
-static inline int wbc_to_write_flags(struct writeback_control *wbc)
+static inline blk_opf_t wbc_to_write_flags(struct writeback_control *wbc)
 {
-	int flags = 0;
+	blk_opf_t flags = 0;
 
 	if (wbc->punt_to_cgroup)
 		flags = REQ_CGROUP_PUNT;
