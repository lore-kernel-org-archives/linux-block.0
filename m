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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F33C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611D4206F7
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbhAZFdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbhAYMpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 07:45:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B787C061794;
        Mon, 25 Jan 2021 03:27:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so1658872plg.0;
        Mon, 25 Jan 2021 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=USqO0hVIRRmy8RPtiAMvZ6fj22xmDUfHHapspTdrP0M=;
        b=lpKuGhfSYhzqAOztL8yd9fnExl2zUK2nnIOxIkM/H6LQxRthh4Ip03ljGo3nky8DlG
         pKaturulK4+ccQPGZzHSEuS/GcsyO7bw/jfQrjbS18E+V79k0Csox+TmkI6Eqzyzt0mu
         vfkA8uPv19a8X/5Yy676ViYoFxGIAGwpV5iYrIROOMa4ALSKBdvzOSudAeEptjdyky6/
         RzlJRLGUNVAwdcoGiCyR5Z0XGbuOwvmeLqJoQiD68HTRpIQHn7MmUIUdX/lIyyL1UacJ
         N11EbzbhuwAGBI3Jg+IYZhSqfLDS/Eaw/P9FlT25Noj9X001TG/FLWC7Lto9XTtb9iks
         Jqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=USqO0hVIRRmy8RPtiAMvZ6fj22xmDUfHHapspTdrP0M=;
        b=Z0IYrr1oUvwA0j+xw7FLaiviX/C+t1E3/h+brUYLimMHYpRy/KBJCwVhWcK6fmdFUc
         ZfQUwqaV5n3pRUaGAYMTySqjqNsTCpxWtlPEnmUSlTVu9q36TzyiYKw10QITXjjqr28v
         K0iwvTunVjwgczk6qvhYENZXdDqJoO14sCvGVHe9J4r29C37/oljTiLVfSZmd/ZM1Nkn
         Q33mnHUcrhiWF8L75ZR69D6a6evpmuOCd74++lKfKaLK+XFe+J0Pco7LWMu9ySHgZbvE
         gHRz4OZBG/uqTUMILNkSkKnsf3JZ1PoP5WRh2h3Ili/FNvdWZv7gUnpb1Ix+gUkrAUHy
         Y+wA==
X-Gm-Message-State: AOAM530Zge8xcu9ns2tJWIYQ2ORi8FZ9DZxBHiLmONtMTgFrUdV2PhpI
        AtMsNv1T/Y+L2Md1tYLlWMk=
X-Google-Smtp-Source: ABdhPJyyZY6f7l0Qx1et36y54Mvtzr9V7Bf1MFFKLcdOknazL4qHnVEeHpIzmrcOh++5g8h9oE79zw==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr13301205pjw.196.1611574047644;
        Mon, 25 Jan 2021 03:27:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id mj21sm18406747pjb.12.2021.01.25.03.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 03:27:26 -0800 (PST)
From:   chenlei0x@gmail.com
X-Google-Original-From: lennychen@tencent.com
To:     chenlei0x@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
Subject: [PATCH] blk: wbt: remove unused parameter from wbt_should_throttle
Date:   Mon, 25 Jan 2021 19:27:04 +0800
Message-Id: <1611574024-23713-1-git-send-email-lennychen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

The first parameter rwb is not used for this function.
So just remove it.

Signed-off-by: Lei Chen <lennychen@tencent.com>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0321ca8..42aed01 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -518,7 +518,7 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	rq_qos_wait(rqw, &data, wbt_inflight_cb, wbt_cleanup_cb);
 }
 
-static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
+static inline bool wbt_should_throttle(struct bio *bio)
 {
 	switch (bio_op(bio)) {
 	case REQ_OP_WRITE:
@@ -545,7 +545,7 @@ static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		flags = WBT_READ;
-	} else if (wbt_should_throttle(rwb, bio)) {
+	} else if (wbt_should_throttle(bio)) {
 		if (current_is_kswapd())
 			flags |= WBT_KSWAPD;
 		if (bio_op(bio) == REQ_OP_DISCARD)
-- 
1.8.3.1

