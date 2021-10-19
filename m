Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1737C43219
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8C661074
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhJSPf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhJSPfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D3C06174E
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b188so15936308iof.8
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lHckUTBFV/Bx7WP+67LFrlFOrwLKGY+mVy+n4f5qkk=;
        b=xM/EbLZcPRZlwIFGbMdpfWhbsCSdjWNlCmUZrU7BjJXx2LC2ce7JEjor/0QEb2y8uG
         f9SyZH5ATRUpGrgOiTxhsmhf7zpuGizwE7ufafCIjpUfeeOricDfpZdMwRpJaUd+e8pd
         rt5uVHike7bX4mowZTDDGuthqQvtCZWOUjdenXBIxiGbmcNZl9bKbKfGSbOFS3qxP7S2
         uQxQua5CULv+1CGypU/QxyANhsof8jF+pmL0mXUSiBMCT4E4WYAAqPbJaujANnRhV9RJ
         2t2VC/1yNSwf3SggeBiq7YBtaqg91jX82w9LcL5xR1VG7gV4TgVNsxa8MkZpdctjZdJg
         XAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lHckUTBFV/Bx7WP+67LFrlFOrwLKGY+mVy+n4f5qkk=;
        b=dGk0ZmYW6Sg+3bEaY/bpr3wLAV0FTCZ+i9rxM0I/wsDsZnZCqsEzfgYkrjjabJDxPp
         8X5lkXp2c2oPA0qnZyw+f08k/dHfeDSEKObX0aPLoAdKRRNTftlgO3kWagmCGRjn+wyg
         qGPvf0FoT/rjUQ7t2GPSuH6yZcR6+Mzn7goCmvnbkZHUnstxGlHR4pbPCsCRi/Jt/QmO
         azwSnrKcIJASsjRSldGQL3Fo4HTUKSGNFk9nq86DN1KUpeh/Wb+6lFlC/08ZrOY/7HNu
         Cjxn+3AlcrWCgfuuobgrCtFOHDOAV0q3sNSAuW8i0BJjwQO/kFLigsuk7XxPWGjhRFTn
         cl+w==
X-Gm-Message-State: AOAM531AgnXubxidJt8fK1iA5GG0eiWhhZ7VYOW7Lr4Qvu41WIhAHhau
        17Q0VCfYcb5cErHVA7+cBe8baMLqRQK0hg==
X-Google-Smtp-Source: ABdhPJwOXLLr+NoWIHgTgySTE2EST8Xs293r7g5jejyht0ZI7mB7kKaL2DYawIZZZdoUP8lIUPdbUA==
X-Received: by 2002:a5d:8493:: with SMTP id t19mr19183288iom.79.1634657585043;
        Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8409555ilp.43.2021.10.19.08.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:33:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] block: prefetch request to be initialized
Date:   Tue, 19 Oct 2021 09:32:59 -0600
Message-Id: <20211019153300.623322-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019153300.623322-1-axboe@kernel.dk>
References: <20211019153300.623322-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we have the tags available in __blk_mq_alloc_requests_batch(), we
can start fetching the first request cacheline before calling into the
request initialization.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fbaecb6e6dd4..77c2c3220128 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -389,6 +389,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 	for (i = 0; tag_mask; i++) {
 		if (!(tag_mask & (1UL << i)))
 			continue;
+		prefetch(tags->static_rqs[tag]);
 		tag = tag_offset + i;
 		tag_mask &= ~(1UL << i);
 		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
-- 
2.33.1

