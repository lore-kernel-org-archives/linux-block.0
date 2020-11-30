Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E3C64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 02:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511BD20757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 02:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWDxtiEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgK3CVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 21:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgK3CVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 21:21:54 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E113C0613CF;
        Sun, 29 Nov 2020 18:21:08 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so5615709pls.10;
        Sun, 29 Nov 2020 18:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1a1lBoMKaF9SveclJWs+RsYOR0BXSQKnr2c/16CY6gk=;
        b=TWDxtiEMYFHnKpW0h5v5GZwqVM2EwDCvhwThPFmkeYIh79uozU6ye0g+l6UHG5cK6f
         Jc63XciBGmTg9AM1fTPGOeK2disxmOjK4KZtAhKAVBXikrXJFTgWL44kvwSDqJko8Ert
         +8E4sze8vVJjHkJzs5YmUrNmgQ2Snlect71WtQZie7ddgc1tRytA4u/nZZYWDQZEB0yH
         qPAqHx+NZ3ULrWrbgCZ165jsI5hKi9+WEsIK+4CBfsEtzq8nqOJI56BrRa5GvZigtO8R
         LXC1/kAGqZ7x94AQTTrQhzUftFICwoFV2I7eIOBe529awCokqok6CkuPu6hxLsQF+UaZ
         F1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1a1lBoMKaF9SveclJWs+RsYOR0BXSQKnr2c/16CY6gk=;
        b=dDxF7I62iSWPtqFxSIoIALTE6FKj6m0/rMXxS4uF1APWi3Cx8mfPhPQ9E4jt9PUCdO
         PAx8+fmBy0dy2ekAE7gQNzD1ztVevn/SsQLFL7Z/Vtbv8D1eRnr3sh3DBsIOlNjk35U4
         gFq4gqOmVyE0BUO4TaRpsE+ZgCJqBgGXwHSGT2YjZBPK8X1IhNaZEfG3k9hMIikgIfH1
         0D/4nWK/TR0z+UkP5RXIqgi0pAg4yVlG7osjoZmjEdsq3glSJBHJGfEAXE/EwyiGnBZK
         RCbc+w1Id42isE81EyS7qnCuQF2tzG9n6E3Z1lp4j1tj+ArnD0ts9vXGJtuUHIppkZYj
         bm1Q==
X-Gm-Message-State: AOAM530RMAO0yY4rPn+pPYlag3GizzA2tGsojCZIL/CGt6EbIdjxgA2S
        C3KyWL84lSoSI11OzVhs8pU=
X-Google-Smtp-Source: ABdhPJz+MJ5DxZ2afDAeQPJFOqdW7X+TiYNy0hbbeK6GIOZVtX+MdhBXrKjf7VL1EsjPRt03sY4L3A==
X-Received: by 2002:a17:902:8e87:b029:d8:e26a:77ea with SMTP id bg7-20020a1709028e87b02900d8e26a77eamr16315215plb.18.1606702867900;
        Sun, 29 Nov 2020 18:21:07 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id p15sm20447771pjg.21.2020.11.29.18.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 18:21:07 -0800 (PST)
From:   chenlei0x@gmail.com
X-Google-Original-From: lennychen@tencent.com
To:     chenlei0x@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
Subject: [PATCH] block: wbt: Remove unnecessary invoking of wbt_update_limits in wbt_init
Date:   Mon, 30 Nov 2020 10:20:52 +0800
Message-Id: <1606702852-14157-1-git-send-email-lennychen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

It's unnecessary to call wbt_update_limits explicitly within wbt_init,
because it will be called in the following function wbt_queue_depth_changed.

Signed-off-by: Lei Chen <lennychen@tencent.com>
---
 block/blk-wbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index fd41008..0321ca8 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -835,7 +835,6 @@ int wbt_init(struct request_queue *q)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = 1;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
-	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
1.8.3.1

