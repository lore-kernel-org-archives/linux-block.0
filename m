Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34759C433EA
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1635961A44
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhCYV1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhCYV1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FFC06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m11so4067458qtx.19
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MmWYjpGPDbYB5acELUWsO4encrHeC3JnTDUeENwiFbQ=;
        b=aRFmqGGVBIIha6D3s4IqBdbLQwRZ3iwj2MshJzhp5updTFlT3a7YfSgXP9YhP+KOM9
         9IIb5Qq8xF9Aa1spaprur4lJzLKTifN7BDLkHrjxHbTnHTQjqvUGjE/2HVnQ8H+pAypO
         Mr1yHJr3daM8vJr4sYbI/LTSLNxlW1iMe1xZ8bRDLaLf0suSnCv5etzbLhF6tOoM7qG0
         AyWUOWMJGSiscCOWPkjtJ3RfoWCwMXvzDeoypzQIFT4QI0I6BYU4BtZ84vQot6P51z7e
         PiWQhYOb49pXdgZddaYTGEbH7fOn4vKXPqup23Jhi/Be4/+pB70SQw1DkB7U2RZm9OW2
         JiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MmWYjpGPDbYB5acELUWsO4encrHeC3JnTDUeENwiFbQ=;
        b=snyS5wCaRv+BkaGJDNsoEtOQ2uEyh2FI98/IvPxSbFoyvKPKT9fCYgz+m17kXxNbE3
         YUylP8P7YfRpcrpIGt9SG3jnujnJhJGdWgI1AHL+FPcPcSTei991MFS+X7xP8eePXx+J
         m/WOkfga8qMqGfbBJzL2I96yWRv+nOx/pV7jPhTgTO6RI+wjGs5WUGmpoywTrbMG8hFI
         FYJnNU74Z7uvy0rVNJ9wR00ozORu0oC2mEqvVxM9hpJ3UvaoW4QMZhoSR5QXkLDOzUsU
         hztdpn8bEjcPuGYlA7GF2RVYuRSA+5ErS0K6FDz4/FJU6LNILBLGBKgAxOkBeiPv27Pm
         7SZA==
X-Gm-Message-State: AOAM532n5AJORBC3NM30auOyl0IgvMnPTdTsFlDiKtyMiORe8/UuZOmQ
        P9aG+AA2WaiEohmPpJmm79Mid8N9GhCcz+4yCRXwZyLI0vKceWwc6NtdoQkYIqe6PFI8bjZL3e4
        PHYqTJZjaa3IZhVFFoKipDk18ASj3uU01SxgUWIEu8u80tQtPb0SYE7F76xB611w4NwGB
X-Google-Smtp-Source: ABdhPJzb2JV84UZuCYFVQuOhDyKectwGgdGBzSsFi5sLWkxE7uSRixfPRc9GTz+M38Mip7Yj8KVLFO4Io0U=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:ea83:: with SMTP id d3mr2604367qvp.62.1616707637222;
 Thu, 25 Mar 2021 14:27:17 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:06 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-6-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 5/8] block: respect bio_required_sector_alignment() in blk-crypto-fallback
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make blk_crypto_split_bio_if_needed() respect
bio_required_sector_alignment() when calling bio_split().

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
2.31.0.291.g576ba9dcdaf-goog

