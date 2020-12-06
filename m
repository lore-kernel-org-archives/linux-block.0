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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A51C4361B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3382720725
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 05:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLFFSw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 00:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgLFFSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Dec 2020 00:18:51 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69819C0613D0
        for <linux-block@vger.kernel.org>; Sat,  5 Dec 2020 21:18:11 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so6212347pga.7
        for <linux-block@vger.kernel.org>; Sat, 05 Dec 2020 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOnqjjKtgJdSgfyT+lQ6ozq6AyZyvUn8B0LaxhTkabo=;
        b=dYgsy2WwBythWza7qHt2VAbEFvnME+xhiXIYydmH0diTzKlHrMNZR5N+zsigt1SYAt
         zx+gFHiNIiKxtOjbmwqYajUs9taExjH5KP0zx2KyQPklUBm6MhNO0Hcl2WooV2+tkhxD
         kCQEgOyf1dXGHyesNu1tpfnB1wGAqSnHkRsjZbRDRJ64rdJHQzTHvJSWNBmvBJkkDx5H
         EGf4M/fWaLtxis7+/XUv+zmsMFCcBsit+sTUei+e0/yRtuJITSOs6aCIc8ynNUDqk2z5
         UL1qr9d1z6H/+gULCCaGItqlMfJYFxH1K18OdLQFS+Gf1haNCmanvaO3mpba6oIuWCP0
         JekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOnqjjKtgJdSgfyT+lQ6ozq6AyZyvUn8B0LaxhTkabo=;
        b=ZAuPKmiAvMebH/cpg9PrNmd9GgnxY2/RS4kZToEAWRYJ3BT8hVIS/z4Nqdd6Cwrm19
         QwbROE7M5K3g4QanR2FSR0bDZ7ZC2Ivi/zxPCCPQqvkK1d9p8PKM9qpSIlPu0Z37OaFW
         n10NfbDb0szT+g44HOQ09TV6aOgEYD3yjpl9dQtBCZksMyhHCWYZFhwgdHOhlNPz6/Fu
         rhOLHpinQJbd6R5RvF99qn3odwNqW66VtsWNq/5rc9Tcdk+RTN8qtRnxhYDcUPbeaR5H
         qUP0dWZlVkDTQOH2UzhvpFrhrPK7hLJwofJJQSkCOrMhbHBMgv0r2+4Tu7BGyjrHevo6
         rCLg==
X-Gm-Message-State: AOAM531ZdCM4jttanxFjXTKsuMgEXkU3vZKq6VJd17ymt9/meGHp6jMR
        O4ALhyBs7a6jL/kk/SMlOR1K3leFvC8=
X-Google-Smtp-Source: ABdhPJwOHguN6VECD9AJNdIyZQHdU6wUbo21YHkKDWkTKhgnFRFslfI89U9o7Wvj74CCT9xYy9X69A==
X-Received: by 2002:aa7:8045:0:b029:198:3058:b944 with SMTP id y5-20020aa780450000b02901983058b944mr10763030pfm.71.1607231890267;
        Sat, 05 Dec 2020 21:18:10 -0800 (PST)
Received: from archlinux.. ([161.81.68.216])
        by smtp.gmail.com with ESMTPSA id q72sm9969090pfq.62.2020.12.05.21.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 21:18:09 -0800 (PST)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-block@vger.kernel.org, hch@lst.de, ming.l@ssi.samsung.com,
        sagig@grimberg.me, axboe@fb.com
Cc:     tom.leiming@gmail.com, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH] block: fix bio chaining in blk_next_bio()
Date:   Sun,  6 Dec 2020 13:18:02 +0800
Message-Id: <20201206051802.1890-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While it seems to have worked for so long, it doesn't seem right
that we set the new bio as the parent. bio_chain() seems to be used
in the other way everywhere else anyway.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e90614fd8d6a..918deaf5c8a4 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 	struct bio *new = bio_alloc(gfp, nr_pages);
 
 	if (bio) {
-		bio_chain(bio, new);
+		bio_chain(new, bio);
 		submit_bio(bio);
 	}
 
-- 
2.29.2

