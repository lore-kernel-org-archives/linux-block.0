Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90004C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 13:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D206613FC
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 13:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGENlk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGENlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 09:41:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A58C061574;
        Mon,  5 Jul 2021 06:39:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so11805017pjo.3;
        Mon, 05 Jul 2021 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V4l2quaAukqPnI1NbkxK0XEdTEIjq8HrgJFI7af8x0Q=;
        b=mjb3CcEm6CGAZOUOGPrmGzNK0oCxmF+rlROuXGTVMQ4xNusGc+LqrNt72hisb73ERc
         GXWhc7PtvGBZ4HL8j7ccOLPjXNS35geSidVfn1GmQQSTQzJHbUarYg99MWxmkdwbfwgK
         LdBu0y5K1Tt4xOpDvH44TuxT/R13fPyK4ybpva4eBQIC8or0EhoF3FpeLk1PpVKmcd37
         qJEOvnfYKb8oV/jfIaL4TaM421p//wsdsNRFBjZCObwmpK4kly369xGyUskVCLEBnK5/
         2kjUCnEaiQUmbRJLIgaFWKlPh38p0jTyH1xCjlrJ0Ay2zh4BoXLCyTwPQJpwksAklPBo
         GJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V4l2quaAukqPnI1NbkxK0XEdTEIjq8HrgJFI7af8x0Q=;
        b=RyBjKyIbaeoqmbe9833WyTMfjkkiQZ1aTE+XjHrhXWgcqJdI28V6EhcHyIoKa0LWdX
         ZsRE2oqgnBV3VuBVlcZVpHT1S8ldZdysCDkstESKdlE8+EqO6KJy8mKP0OaglJsf9mK1
         dXVwFQaFYmDSLbxw05xDp8tDgfexX32MD/ebEw3mIcFo1QanyE1eIxROMkrss+YJ0iaM
         8SzPWvaUlAvO2B/98nBcPkfvxl8or7spM7a3DYji1o21Q46ICWt5lwF4GH4RD2F2LZDE
         DurRC/uvp6S301YNqMmc43n7BTn5LZe+UJN1BOcPHv7ZuSMxEuxAyPE71E36Uos0KTQW
         U5Ww==
X-Gm-Message-State: AOAM5325y8Bf4tJ3Y7FaNwJbKQydSDdK9DTHDzaYa9aPlr5Rv2xV0luI
        NNVR8HZCO6tBQdGpq0zHRQ/JfWpH2C1OmdF7
X-Google-Smtp-Source: ABdhPJx3ObCYiKm30zxcLLrvmLQnJT44+KULQ6oTi+e53H1IDtzcSf5oOMeYBukb4vZ/Mw3QAdbvmA==
X-Received: by 2002:a17:90b:945:: with SMTP id dw5mr14657369pjb.144.1625492342843;
        Mon, 05 Jul 2021 06:39:02 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id y11sm398707pfm.190.2021.07.05.06.39.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 06:39:02 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: fix the problem of io_ticks becoming smaller
Date:   Mon,  5 Jul 2021 21:38:59 +0800
Message-Id: <1625492339-18025-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Before the wraparound occurs, the value of io_ticks should
be monotonically increasing, but we sometimes find that io_ticks
will become smaller, which leads to abnormal values in monitoring
tools. On the IO submission path, blk_account_io_start() may
interrupt the system interruption. When the interruption returns,
the value of part->stamp may have been updated by other cores, so
the time value now collected before the interruption may be less
than part->stamp, and then make the calculated value of io_ticks
become smaller. Therefore, when now is less than part->stamp, we
should do nothing.

v2: sorry, fix compile error due to the missed ')'

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 514838c..bbf56ae 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1243,7 +1243,7 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(stamp != now)) {
+	if (unlikely(time_after(now, stamp))) {
 		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-- 
1.8.3.1

