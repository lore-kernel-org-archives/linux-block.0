Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3635BC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8AA23ED2
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 19:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393670AbgLKSNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbgLKSNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 13:13:25 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D58C0613D3;
        Fri, 11 Dec 2020 10:12:45 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so13624085ejb.1;
        Fri, 11 Dec 2020 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jXNCL1l6e/6115GRYXv1hRB54orJ1B3shh8vugN/3Pw=;
        b=qhyj3EQJNwQ/3D6OUfCWA4D2e62t7pnzDMZYS3v3pJMMV+ReNqh0iUKz6A6fsA5GT4
         U7dcXm/JNUkQlfLn3CLN62x2t+nNurtUe6+s/lHvddDAuS3+6vKbsxpmqu8cSh3bHAl+
         5Pg6DcPR/8eR1U3R/Q1fyswYLvoU7EiWR5XEAYdEvw5SUP+DJ/yD5Ttr9lajJ3zQt7mK
         VZFwspepb98fxekOgZnPzFzzQ1pl9GGZO1YLqDuxLB7N6PKdCK4jL7RSeDlHBwDR/woS
         ofbLQp/Ox2N2KiSyFR10Mzjmx5yrKH/ll0S0cMeLtrpB3XrNHQk8kQRSEFHd6wlgZZWx
         74Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jXNCL1l6e/6115GRYXv1hRB54orJ1B3shh8vugN/3Pw=;
        b=hVqrZrHOML2ZthgSARlWDIISxSEK1qZxe7rCDNwHM2oWeUI1BHqnGavPQVBVQDm4Vg
         S05OBFiRkhH3kLqqUvZDnM6ea1rfRKWNCmNnJoh3YBSa/JJ/IAcj2UZNLRNXC2Xx/zyy
         XBxk1Ja2niCTDH1ca9tdkFCa0fsc2Ac8VXzJ9BxN/vObhpa4+DS1t0N/NpSihDxs4pSR
         1AgBHsPpRGTdcZN44GtyEp/WZnFUPTk4jWIdSx7o7ncxVXp1kXPqwM/e1YgkQt89DAmQ
         sief7m2Vb3/AF1m7GPzlozpGueb9TF9hsb0Hr6kgwVGyDmIJHzpZhLSmRe7DtKWKkzwS
         uSNA==
X-Gm-Message-State: AOAM530EbdSkx/kT+shu/vp3vv+nAlFdIkM9BI8LkHX8Q8Az4l3CnKRp
        MhnXCK1/H9NWrwEmLRoSbVU=
X-Google-Smtp-Source: ABdhPJyx+onXAuuShWmy6955djm1AEHtWv491E16bAkjwZvMrUAywnC+LKDsAlkf4s11EFqOsjOc2g==
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr12186390ejr.482.1607710363877;
        Fri, 11 Dec 2020 10:12:43 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d8e:cf00:1134:a93b:bd3b:5cd6])
        by smtp.gmail.com with ESMTPSA id ho12sm6914344ejc.45.2020.12.11.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 10:12:42 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] block: drop dead assignments in loop_init()
Date:   Fri, 11 Dec 2020 19:12:36 +0100
Message-Id: <20201211181236.25755-1-lukas.bulwahn@gmail.com>
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
Christoph, please ack.

Jens, please pick this minor non-urgent clean-up patch on your
block -next tree on top of Christoph's commit above.

 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d2ce1ddc192d..eed4bc5ef5c5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
 static int __init loop_init(void)
 {
 	int i, nr;
-	unsigned long range;
 	struct loop_device *lo;
 	int err;
 
@@ -2343,10 +2342,8 @@ static int __init loop_init(void)
 	 */
 	if (max_loop) {
 		nr = max_loop;
-		range = max_loop << part_shift;
 	} else {
 		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-		range = 1UL << MINORBITS;
 	}
 
 	err = misc_register(&loop_misc);
-- 
2.17.1

