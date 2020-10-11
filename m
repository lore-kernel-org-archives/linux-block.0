Return-Path: <SRS0=aCNT=DS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89653C433E7
	for <linux-block@archiver.kernel.org>; Sun, 11 Oct 2020 13:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431A8207FB
	for <linux-block@archiver.kernel.org>; Sun, 11 Oct 2020 13:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB3m9jou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgJKNFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Oct 2020 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgJKNFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Oct 2020 09:05:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3552C0613CE;
        Sun, 11 Oct 2020 06:05:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so11417255pgk.4;
        Sun, 11 Oct 2020 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWkz3TadtHi8NNTObBGKxwM7sKTo6NT5Vznm23JWx0E=;
        b=RB3m9jouTQT1pND5bLLxoD+bk87PCZqjGlB3cgSeaIqOwri13ZfTAErn+1TqCNAL2X
         xWxruXunQ9708KmvaVSiDbxA72aa6kvPa6V42UgPGbzFI/WVZ8oosaculkf9vjWVffGo
         wyUYkKJowgztEaMDvSMz6i7qZLGyeRRsCKqT4trbYgm1t1O1inm4dy/HZZDqteG4q69L
         AnIuQK/N7yJb38UjwVp2bPKyBuOWXxkblUuqAA4VbM3h8BsHbi8aFTywTcpACEzVzIzV
         VuYFsX3lTOfd1yUJ8qY2CQ9EbpeRmOVuJYdO3YEqs47DLy9MWCkFDzr6EB/E9hNkBgOI
         6yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWkz3TadtHi8NNTObBGKxwM7sKTo6NT5Vznm23JWx0E=;
        b=DznpXtvWzOMlTtwklMcWFAsgp6RSluC47vbyInxLMJB8eKBIrlPrLmGqPiVQViWEIn
         bpUZkpYlnjA+bnDLDLuLwnqEeAcZfc8isL66VBl6bAH51VE3tJ751M2gX1BYowxORAy5
         Gl/u8OTJRMT4pXCh9Ff6/D+Xuoy98jfsK6UVkSBfqzj84AAdijIbK0SzauDucBJowBTh
         8XXDIq3EePGK2AiVxuT1wqxJICqIgTKBJwqNQVjBe2r8ti8dnR2b6i/EZxSkIbOjQ4PK
         nVC6N4SFpywcq7XtLPhR7A6CMupyNio5qgo9Ukv99KPbAVFwdork0D/e3iU9YXxnQ0JA
         u5zA==
X-Gm-Message-State: AOAM53388GYCHQUvgAiWi8wzHKG5jJujK+53cTdofyQZBVxAtSw+kWxa
        Kv30+nm0zxS+ScR8g+bg3Jkl/y/crQCA1r8M
X-Google-Smtp-Source: ABdhPJwA7Mx15oD5cgBupEgOOM7y/7FQs3eXg0tohCLN6MuIwxVrs6Xc80hQSSU0Y5NF/eYICjP0pQ==
X-Received: by 2002:a65:684d:: with SMTP id q13mr8868635pgt.372.1602421512330;
        Sun, 11 Oct 2020 06:05:12 -0700 (PDT)
Received: from localhost.localdomain (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id r8sm18703663pgn.30.2020.10.11.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 06:05:11 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] block: switch to pr_warn() in __device_add_disk()
Date:   Sun, 11 Oct 2020 06:03:47 -0700
Message-Id: <20201011130347.562264-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot triggered a warning while fuzzing with failslab fault injection
enabled
let's convert WARN_ON() to pr_warn()

Reported-and-tested-by: syzbot+f41893bb8c45cd18cf08@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f41893bb8c45cd18cf08
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..be9ce35cf0fe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -822,7 +822,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		/* Register BDI before referencing it from bdev */
 		dev->devt = devt;
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
-		WARN_ON(ret);
+		if (ret)
+			pr_warn("%s: failed to register backing dev info\n", disk->disk_name);
 		bdi_set_owner(bdi, dev);
 		blk_register_region(disk_devt(disk), disk->minors, NULL,
 				    exact_match, exact_lock, disk);
-- 
2.28.0

