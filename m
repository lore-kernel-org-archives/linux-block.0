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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F30C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3561374
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGEMbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhGEMbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 08:31:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D45C061574;
        Mon,  5 Jul 2021 05:29:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y17so18124608pgf.12;
        Mon, 05 Jul 2021 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q1SDvqcxzWdWfG7JTB80kV8rFYgo5yfvNsP0668cMrc=;
        b=uFNTTCBI196HN163SE9PHYyGeyNSxoDT14h5mJjAQgAxor5/LnhCD4zN3xlSIyQzkb
         3VBdJeKZU1Q+rTCaybdubqvByZijGzwNr6fM1q78I/q9Evlsb1I8G4luX7vCAWSNuGcF
         fmiMZJ2T/Gvod6CYw/loAMhJMsLZWpwLhnyfV9OCYLGZmy/w6C7AYB3C6cNN2mGBbud1
         XWh8TIr0MQuSvtQfhAbb9e6sX5jRGR/89rWNgzzi/lcckp/Tkdko5l6Un/z+6UhGH8+K
         Znr/Nl9hIqDFX3FE6Ds/8rv0xN+ibtiKvB17/olwaqWu6UsPWOUcCe4elX4b0uMgDoz9
         5mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q1SDvqcxzWdWfG7JTB80kV8rFYgo5yfvNsP0668cMrc=;
        b=TGidw7Dkn4mg6nEFSkQzBT1r779kjO84ZttJdFvuBfnI9TIXeB9lFfOJw1STb5OVw9
         PZWlyN/GFPQ/MVyxo59z7sH1IUo0j4xx7d9m3gVWW9obZxGfQvecAtAXSZyjb1nF9/95
         VPTrpf4p2SHbFaJPBlXAwP0T2SvekmKY6KAlVBWrUDEoQ/OGUnDWzepBbISm26z5OLPa
         rexDUVFHyI9uJkBMlgs3IsyoOTBRJXKh+/vWwGleOx7Fw8PDR5N8IlO/C/Dp04H7EBj/
         bIWFL+oV2QC1KxqFolLMTsBplLRJHKQI6+2shiMSDX6F+c1pXLtmMHQzno4wB1wABAML
         L67A==
X-Gm-Message-State: AOAM530ftdE365jwqMcDk9bV6rT9x9clX6SOR/by5MDT/zV13W54JDWQ
        +muLc3MgH+ifCb8+rvhQYphzPGYkvfNqe8lO
X-Google-Smtp-Source: ABdhPJyMLV8VBFWU0VCYIqaEuvz+P95s121WeDMMptVTcy0LEWvcj9TvPpNlIpVgIhjKEeaYHNzRSA==
X-Received: by 2002:a65:508a:: with SMTP id r10mr15431217pgp.96.1625488143687;
        Mon, 05 Jul 2021 05:29:03 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id b18sm21395974pjq.2.2021.07.05.05.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 05:29:02 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix the problem of io_ticks becoming smaller
Date:   Mon,  5 Jul 2021 20:29:00 +0800
Message-Id: <1625488140-6943-1-git-send-email-brookxu.cn@gmail.com>
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

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 514838c..a5d1cc2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1243,7 +1243,7 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(stamp != now)) {
+	if (unlikely(time_after(now, stamp)) {
 		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-- 
1.8.3.1

