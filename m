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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49650C4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDABF23125
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 20:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgLKSrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389228AbgLKSqx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 13:46:53 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5EC0613CF;
        Fri, 11 Dec 2020 10:46:13 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cm17so10424444edb.4;
        Fri, 11 Dec 2020 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/vy2vMYsdZgPjSFh+ZUUZIX8+S3sHf8WTmPjKwG5z4w=;
        b=jL8afGSOCnG6zKPRVY1Z/B4pNfhC40FL4x8M+KAi9P/grPebeUmCsu6PZOjDT5de51
         zu4+rwljwUHwUouHkz2idsbUwS/B4VXI+UMejsmxiQIxo04F4R+5589/UVCzetzoPFVb
         1lBGnSuFwjeo6l3KJ25oO65uEbdmzVjrb8Ij1xwasqFy1oVi5CWoAZnW/PRFXKJsozBy
         kvjHgL2XbXAZBTKcSFUOJbvKzlBBohOSr3uBbCM+DSzS2yN9/JoCIO/vDi6SdGhlp9WU
         EzQL3gto4MDYtqMgdYiuk9xdswHuUS265RePsBh/RWU45XLq7619yrt3lXwbxThKRHkS
         iv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/vy2vMYsdZgPjSFh+ZUUZIX8+S3sHf8WTmPjKwG5z4w=;
        b=OxmdTME7AyxkS+JuEONTdCcZt2+17TiJbjLXtqDXbmUnDH1daQ8vFRAFqdF+rchtIS
         Ch9yMZvg7MFXYKOaerKbPcDg4iVydzWfOzZrFdewGpph0BtY5qf56LHU3hBqgbT3wmMC
         zRkJHDwaBn+pUlWssqb6ExlteWVrMgd9Rhs68Kf5+2wt+szyAodc45N2I3WxuLaJhJuK
         zmk3Wn6urirReaE2gSaCWFhQKOT01PRWycAeRBSwmnKulnH10xZwDMm2idnnCyT4vsNt
         JzdPQmkKTaE5kMFmBsmWLoR5I68xAhBmjazzgxFmyGxLWkFG5xwP+jhcf+DEC+Fo4MuN
         xu+Q==
X-Gm-Message-State: AOAM5323ctT/HQFKO35UdJo5OqaBlRZmvFJckNMn+HcRj4h8lgi03m28
        ecIsIoA76hN4ZU9Q3BlNdp8=
X-Google-Smtp-Source: ABdhPJzcwdiQXe4iPx+GDUIVk3Os7vSdHfB0TPq5xa9x+bqLr9hIVDeCZHxAdY5jUl7sJ8+qkGNMxw==
X-Received: by 2002:a50:8e0e:: with SMTP id 14mr12856121edw.171.1607712372086;
        Fri, 11 Dec 2020 10:46:12 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d8e:cf00:1134:a93b:bd3b:5cd6])
        by smtp.gmail.com with ESMTPSA id h12sm7279190eja.113.2020.12.11.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 10:46:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] block: drop dead assignments in loop_init()
Date:   Fri, 11 Dec 2020 19:46:04 +0100
Message-Id: <20201211184604.27646-1-lukas.bulwahn@gmail.com>
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

Christoph, please ack.

Jens, please pick this minor non-urgent clean-up patch on your
block -next tree on top of Christoph's commit above.

 drivers/block/loop.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d2ce1ddc192d..10c7c154c114 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2304,7 +2304,6 @@ MODULE_ALIAS("devname:loop-control");
 static int __init loop_init(void)
 {
 	int i, nr;
-	unsigned long range;
 	struct loop_device *lo;
 	int err;
 
@@ -2341,13 +2340,7 @@ static int __init loop_init(void)
 	 * /dev/loop-control interface, or be instantiated by accessing
 	 * a 'dead' device node.
 	 */
-	if (max_loop) {
-		nr = max_loop;
-		range = max_loop << part_shift;
-	} else {
-		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-		range = 1UL << MINORBITS;
-	}
+	nr = max_loop ? max_loop : CONFIG_BLK_DEV_LOOP_MIN_COUNT;
 
 	err = misc_register(&loop_misc);
 	if (err < 0)
-- 
2.17.1

