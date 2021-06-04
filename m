Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A108C4743D
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE00B61407
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 20:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFDUCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:02:09 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:57064 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhFDUCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 16:02:03 -0400
Received: by mail-yb1-f202.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so13098494ybf.23
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CrvB+067/I+CxLLg5RI6y2+/auWfNk2l0qpau+BMbco=;
        b=K3j5LwA4O8C/vL99eQGQ0tGLMUIZpSoXyyrsmYczwJFjEtEXne1IRUnR1Tmeecqq3f
         CKDu3ca7OKlE4hozFKVOA2tgtpIW9mwzj+Ykf4tS1w6le5spKOHwnUhciOQXa1LQ+fkD
         Fl7oQg1vxQmJSZDSDjR/62PqI5sGiLG/rjBILcpSeCxjzXIWBdgzlaS/9cRsCerSIS7A
         8C46TVhK+bEMbWW2yVrl4z3hZp01Z9+TNVOxUdnL6btYGTwYDGWoAbaeKRgrx2L4bBkw
         KVPRQNmjxiRdE6ewFIPTop8MTUD86m1zZ9Qt+dR+y7gPhcJKP2WesNdZ3vi8SIJqyEIJ
         usVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CrvB+067/I+CxLLg5RI6y2+/auWfNk2l0qpau+BMbco=;
        b=Alkjjr4UVgDlw+eSFW1bvB8yZUIQ8JrwMHH206rkuqip6lROk8VMGjkJLNdjFNprHi
         AgAzIC1yPrPJuRS5K+q3WiOyfQtBlcjyKQ4hTpCDb2wNSHFLXTW2EMlKlFYdUyf+oBP2
         99BCUUr1r3S1sCCqGjKysnWbJYWR1toykjY+9Ic0Pr326Iw8WkvRcrDID/B0ksLlFYB/
         TObkQacZTzCdK31UUZm2dnqhtguIhX64tlXNjJGFnBb9zQ8Enpn/RSL4RmIMzuwIz+Tg
         on8D0aM0EwWBoY8s01lAGkSij99UsSab3Sky2K0prb4ZfUBuaGn6NeN7378zRGhSv2lG
         bI2g==
X-Gm-Message-State: AOAM53029OFVZdmRjUEDOjdQA8vqUNUdl5dz21J49V0DHyiI5fNhTvVJ
        YAGndqmKO8CA2lKEsoNJIdrsdZwAXgiMLnws+VrcGKLXmGfyhebYyUluc0FST2NHSkA+wMCSxbv
        fu9lpBhyBYlXBQxH80ImU5lX+Ix85E6jRLAwDfPqcU4Ne2SVidn2rUKjUTcmiBhLi5onC
X-Google-Smtp-Source: ABdhPJwRpwAf7i+p+qPOvbpLnxp6faKw5GUkn35qPs//LLow4O922a8pO0+n/57Cx+JXfX6OXE4kFyKGRr4=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:824f:: with SMTP id d15mr7687638ybn.273.1622836755998;
 Fri, 04 Jun 2021 12:59:15 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:54 +0000
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Message-Id: <20210604195900.2096121-5-satyat@google.com>
Mime-Version: 1.0
References: <20210604195900.2096121-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 04/10] block: respect bio_required_sector_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
bio_required_sector_alignment() when calling bio_split(). Without this,
blk-crypto-fallback could possibly split a bio in the middle of a data
unit, and the resulting bios can no longer be encrypted (since encryption
can only be done on complete crypto data units).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c322176a1e09..85c813ef670b 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 
+#include "blk.h"
 #include "blk-crypto-internal.h"
 
 static unsigned int num_prealloc_bounce_pg = 32;
@@ -225,6 +226,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 	if (num_sectors < bio_sectors(bio)) {
 		struct bio *split_bio;
 
+		num_sectors = round_down(num_sectors,
+					 bio_required_sector_alignment(bio));
 		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
 				      &crypto_bio_split);
 		if (!split_bio) {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

