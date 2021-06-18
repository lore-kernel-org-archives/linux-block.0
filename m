Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED7FC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 03:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD08613C1
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 03:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFRDTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFRDTf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 23:19:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59359C061574
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 20:17:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q192so40415pfc.7
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LfrcfBW7K9YITWSAX2QC2omGCKcwovHUpaDZ/95iQok=;
        b=tF1inVfg0zkCBqzMiSnS9pGK7ooduFORNOYr1hUM7EusnfEkFZP9XEW6VGXgJ1vDHE
         APMPnHC3TS5IhJ96UNY7wjwRgoYFYqlaaTHV4jsteX7yCRji9kVPBhq8EnIfn9WkVnA8
         t98lYnnXUnnYf/UQuHVk9GHW+dJDT+zvJDzZPb8dDOXMB2eDiSaqpX2M+RaBi9e5tFFA
         BVPszkJBDmXjuDFaP+koUlcUziij7+dTD4Su4V1gn/5A7Y/K2xlKPpmtmdo6uIEMG+tx
         UznkXFEyKCKFstHRgKpkZJDIiyCBrylQauYAXIYIVc1KtqqyC+xGAqx5jMdoWFrqiUp6
         iSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LfrcfBW7K9YITWSAX2QC2omGCKcwovHUpaDZ/95iQok=;
        b=aFIRRpe3EPjRo9NPVsF+W7uhI1KQWu5zU/xmjcSH8ALCIfRRukvQYESsU12mOSZhmY
         sFeUC0u1Oqq06tTQip50IozCyBxHJL8OrThCKNERun90aE8smtV4MIQBc6LIxpWifC1x
         PtoP/UwDEttqB3/3yPlf75i0vZ6hYV+SuuIT5A1D/zs9Qb66Z0QJBB3wWCAqg7SgWCi1
         vjnb/t2BoR/rnsvJLBt5stQN5jjcU+JrNNQZWvlI7soISe/GRO3N15W+WrfxJWN3Bnly
         WTbeAgheN0PzkyDfjtDchmlJ0qFopZol6XrF2jHiue8uXZxDhdY2XfPm0Cq8oaseNOnR
         wljw==
X-Gm-Message-State: AOAM533D63AegBvgiKXUXX2eWmuKNIiwpgfIKqwQeWpcYTnoYIZjbQyC
        G14XAjXDqFRrZ4s3C+534iE=
X-Google-Smtp-Source: ABdhPJwbSLzdwDA8/9IfEbfcfJcao4Q0zAJlRynb7PiPd7O6H5ZsNhHEx15dJHdMxid9q6GtC4GpqA==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr7963555pgh.382.1623986245775;
        Thu, 17 Jun 2021 20:17:25 -0700 (PDT)
Received: from localhost ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id u27sm1013320pfg.60.2021.06.17.20.17.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 20:17:25 -0700 (PDT)
From:   lijiazi <jqqlijiazi@gmail.com>
X-Google-Original-From: lijiazi <lijiazi@xiaomi.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     lijiazi <lijiazi@xiaomi.com>
Subject: [PATCH] block: remove useless comments
Date:   Fri, 18 Jun 2021 11:17:20 +0800
Message-Id: <1623986240-13878-1-git-send-email-lijiazi@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now wbt_wait return void, so remove useless comments.

Signed-off-by: lijiazi <lijiazi@xiaomi.com>
---
 block/blk-wbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 42aed01..b363b05 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -563,7 +563,6 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
 }
 
 /*
- * Returns true if the IO request should be accounted, false if not.
  * May sleep, if we have exceeded the writeback limits. Caller can pass
  * in an irq held spinlock, if it holds one when calling this function.
  * If we do sleep, we'll release and re-grab it.
-- 
2.7.4

