Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663FC47254
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0EB24953
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="UIKZzo7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHWAY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 18:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEHWAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 18:00:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6DC061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 15:00:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so3660229wrt.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe6VUiTYsko1zxoPYCZbsMKvQCAiAXB7o0u5C4C7os8=;
        b=UIKZzo7pCejAlakM2hiG4HdCLnh0Hv+FZak8KGCaKM+kGnJAwThVANiEyWdglZLM+S
         5mMMkwn71jUD6RsAml4EzcgJ6KiNqgGjzZHgiQ3yVAUfZmhk8CrdxHId4nqZTZ0AhusB
         StxzkUdXJGP90As1TH59dsDkU+Nrq4j85tT9qfl/s+RXqPSkcO381Gpj4ufneSi7JSsj
         6Hgfboph161R+bTtlnhprm7PnzNrFFpD8mpHtUaJ+sC10PfTO9AtpKULFOz6gU2NsA8S
         wnhytYR/j1dkQ/aZI6QfE3zD9FrytikTvcrT/u7ruPZpXgS3Mhi17hOn0A3i3q+V52Gq
         8cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe6VUiTYsko1zxoPYCZbsMKvQCAiAXB7o0u5C4C7os8=;
        b=JOQen1VXymATL2I6OhWf/NbajNpitRGD0ZxWQHJ3j7u+O4HFn5hJInFfBRcyZX9ysN
         ZVZ7YdqqUr6OZ337ystjx6BnzMrJhBaCI9Z5XL/uJk0vZUni7OmGEPCwF5ai60J0phX6
         V3EFiOro9KAZskvte7/MRrGPgDvQQpA5yY21uUshdZdEjuIzVFJh6MfOpyncgIN6cTpC
         xgBwsMNXtn2ldtXY+bHMF4Psv4jrZhGHycA0x5sbvIPo+4C7zsqSjITgEGVMoRpybYnP
         fJOgw0U3LbPP4rU8gUwrA0FOsd/EdQbqhuZDqvrmMSMeTEPS7ihnDTdaQCBoDvsoHDQy
         saPA==
X-Gm-Message-State: AGi0PuZ5gBYJxf04NHJ6xZHsmelR4tQuKAL59NuhwpN/vdKj8AEulIw2
        RZKnY7yOGQwO0sASt9fcGgU+mw==
X-Google-Smtp-Source: APiQypJmQon21vzDnJA1qjvuqx/qUdbW7qPUG+u5CBe/BtuOAuVSHxiYsvGhy/tK+NKaUFy6zMbGqg==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr4748201wrt.195.1588975221983;
        Fri, 08 May 2020 15:00:21 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/4] blk-throttle: remove tg_drain_bios
Date:   Sat,  9 May 2020 00:00:13 +0200
Message-Id: <20200508220015.11528-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After blk_throtl_drain is removed, there is no caller of tg_drain_bios,
so remove it as well.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-throttle.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0b2ce7fb77a7..209fdd8939fb 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2358,28 +2358,6 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
-/*
- * Dispatch all bios from all children tg's queued on @parent_sq.  On
- * return, @parent_sq is guaranteed to not have any active children tg's
- * and all bios from previously active tg's are on @parent_sq->bio_lists[].
- */
-static void tg_drain_bios(struct throtl_service_queue *parent_sq)
-{
-	struct throtl_grp *tg;
-
-	while ((tg = throtl_rb_first(parent_sq))) {
-		struct throtl_service_queue *sq = &tg->service_queue;
-		struct bio *bio;
-
-		throtl_dequeue_tg(tg);
-
-		while ((bio = throtl_peek_queued(&sq->queued[READ])))
-			tg_dispatch_one_bio(tg, bio_data_dir(bio));
-		while ((bio = throtl_peek_queued(&sq->queued[WRITE])))
-			tg_dispatch_one_bio(tg, bio_data_dir(bio));
-	}
-}
-
 int blk_throtl_init(struct request_queue *q)
 {
 	struct throtl_data *td;
-- 
2.17.1

