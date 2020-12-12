Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC263C4361B
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B52A23B31
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 05:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgLLFOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Dec 2020 00:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgLLFNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Dec 2020 00:13:52 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F085C0613CF;
        Fri, 11 Dec 2020 21:13:11 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id b2so7730eje.13;
        Fri, 11 Dec 2020 21:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6YGQCYdK4dZk4LHF+Fjyb1bMQOpJVKHPbyiDsunhQ5k=;
        b=t5Fbb3Em4y/9B778CFhfGEIk73X47XZQ+TWn8gDGL/JKXPqSld8p4sYTd1HfPufa5n
         +8E8N6LwQT5RxWZ6ipgcTmHo1cLVMpyE3fPjj7tPlghhHe5toow4LnQnrVh1LExfNtlS
         h72auKXOPBgkHOzFekchOSZ3FWQH8qyOtIY1kj+d07UdDHPHCHFAJC96wCUNWImAEEId
         uVHBbjZTO0VueC/JWpW7edYRahAU/Gs2cQFULfmcmsVzQIoaBYUxb2AY8/1dfn6RQTj0
         9k3MVAzvyQ2UQNgaGyCVWyJht+mvzD8diRiBlZpg+B/IBF4RvF8FQLU9HfgNmswp7zSC
         dz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6YGQCYdK4dZk4LHF+Fjyb1bMQOpJVKHPbyiDsunhQ5k=;
        b=QszkLN5dXdsbporgYSUXdtYOXhdnv9zU7IfLad7cNVbnFAanc3+wMS8iQDLozifugA
         G1G63E7rrkBq2UBsdWZSJ6uqAJTGV9k7xFkbFoUuLdJY5AGkcfn8wA/TrmNcWMXKYhgc
         hiyzhpzGSTGFaKjWL3WKR5/5zuvLBk6kuCWGq5yzFuYtRJN2jVimi0qsZcNwO858AY3G
         1T6x1iwzLklEz+ONXodtRTECCbitPLYC5cO7mt2bI9Z2XGBonMs4UcvYT1viCFuIP9KU
         /VXvSSC3Oo0iOgJdSXB0zt7sZNhtHEeEnoXIUKlAaQRUvswNpNk/Foy4hocet313FX5x
         jOHw==
X-Gm-Message-State: AOAM533hnmQ3H/2oxtBoYGJqOOI2OU/pkz/JN9c29LNVdtqttIWYlr8y
        TJlwW0ZynrsF8UCL+I+lBvo=
X-Google-Smtp-Source: ABdhPJzaCrRkVrLK1pM/hRSZQ1n4wNhKvzksghXATWAjjooLwPd89ICEc2QFppj2shb/X4DmPsFSAg==
X-Received: by 2002:a17:906:1102:: with SMTP id h2mr13769297eja.296.1607749990171;
        Fri, 11 Dec 2020 21:13:10 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2df4:6c00:bdb5:f209:34cb:5e76])
        by smtp.gmail.com with ESMTPSA id ck27sm9465988edb.13.2020.12.11.21.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 21:13:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3] block: drop dead assignments in loop_init()
Date:   Sat, 12 Dec 2020 06:13:02 +0100
Message-Id: <20201212051302.26008-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
demand") simplified loop_init(); so computing the range of the block region
is not required anymore and can be dropped.

Drop dead assignments in loop_init().

As compilers will detect these unneeded assignments and optimize this,
the resulting object code is identical before and after this change.

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1 -> v2:
  - replaced if block with ternary operator after Julia's style comment

v2 -> v3:
  - use if instead of ternary following Jens' preference

Christoph, please ack.

Jens, please pick this minor non-urgent clean-up patch on your
block -next tree on top of Christoph's commit above.


 drivers/block/loop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d2ce1ddc192d..e5ff328f0917 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
 static int __init loop_init(void)
 {
 	int i, nr;
-	unsigned long range;
 	struct loop_device *lo;
 	int err;
 
@@ -2341,13 +2340,10 @@ static int __init loop_init(void)
 	 * /dev/loop-control interface, or be instantiated by accessing
 	 * a 'dead' device node.
 	 */
-	if (max_loop) {
+	if (max_loop)
 		nr = max_loop;
-		range = max_loop << part_shift;
-	} else {
+	else
 		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-		range = 1UL << MINORBITS;
-	}
 
 	err = misc_register(&loop_misc);
 	if (err < 0)
-- 
2.17.1

