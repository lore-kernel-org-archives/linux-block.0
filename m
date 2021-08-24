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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AFC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 01:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CC36127B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 01:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhHXBKb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhHXBKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 21:10:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6B4C061575;
        Mon, 23 Aug 2021 18:09:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g11so15474502qtk.5;
        Mon, 23 Aug 2021 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0sN6y0IbgY+TOAhIwpepHTBKMbUoRecX1PtvCcLmrc=;
        b=C6JVMXtWOzf6OXCZ+BAsRGqUokcbRsF+JSSQhaBg9coB1PUkA9Iil1Sp8o55ThajT/
         uUMdcdTYyb0unguigxmU2P8f9iPNZ+n0gj8wUaetVlAJ5AU5qNKsLBiAxw3t4wsUXYTQ
         XKS/9FMv7zxxSHQm/OMF4Nqh2SDPv+sfTkrQFmy72WdL3k4Ksj3L19yF/gMDiA4Aco1R
         AHxBku+fq1mDKWEfMeTkat8AB/zxRiDwYHcH51PKkw2HfzvD6rRCayuOjXyVsDqVbuoZ
         0rlk4N15L4L383y47GKPRUtnoEscY3L1FxQGc0qTSOUDFjOgpJKPM0+Ludb5JyhlWDQC
         vI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0sN6y0IbgY+TOAhIwpepHTBKMbUoRecX1PtvCcLmrc=;
        b=GDZyHiym1VUxBwvPwCUd/S33PoGqdh76n61+8YwUYgElvta3+vyXScQRvwSf0IN6KO
         bcCiKXiIQBnVNfsAnOfr0pzYPwEgfcETutge+e/yG52Y1B3sO+J6ukIP17lIMjqQg8p2
         g1OIXkpEFhkfY8X73b651v9WMC1Xt3Mj7sAX6SGv/J2WoTF39vQygDPeomsS4ohdJOy5
         gS6Soc6YLAy8Jnr1w8fPzlY0J9efjgosiWl99Tlyog4Id1HGgAaHnEaCEv+SSAw4c2kZ
         SIIRp3UXa0wUjvWXkqzbfwyRuLTU9Zo5Re7HPrB1N9f+prF+2tYTeMSK8s7tla8UMoGB
         5GxQ==
X-Gm-Message-State: AOAM532dpzFPo8xUYOALE011ZXrCFPnbmIxwVXxj8+ou2/dAHRe4Ymbl
        tl3v0SsRE1MOpCV+nCJwLSExaKkJiuM=
X-Google-Smtp-Source: ABdhPJw99vwHr4Zzk3jRuNK3pFll9zrZlKbU5ThB7gwOyf/NOBmfgh4NplMMi4FXiV5nIrhdlhPvdw==
X-Received: by 2002:a05:622a:207:: with SMTP id b7mr33524146qtx.377.1629767386180;
        Mon, 23 Aug 2021 18:09:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m16sm9482836qka.84.2021.08.23.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 18:09:45 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drivers:ataflop: fix warning comparing pointer to 0
Date:   Mon, 23 Aug 2021 18:09:37 -0700
Message-Id: <20210824010937.56395-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./drivers/block/ataflop.c:1439:20-21:WARNING: comparing pointer to 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 drivers/block/ataflop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644..6cd28df 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1436,7 +1436,7 @@ static int floppy_revalidate(struct gendisk *disk)
 
 	if (test_bit(drive, &changed_floppies) ||
 	    test_bit(drive, &fake_change) ||
-	    p->disktype == 0) {
+	    !p->disktype) {
 		if (UD.flags & FTD_MSG)
 			printk(KERN_ERR "floppy: clear format %p!\n", UDT);
 		BufferDrive = -1;
-- 
1.8.3.1


