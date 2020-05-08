Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008DC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2683F24954
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="dUQcdsq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEHWAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgEHWAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 18:00:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FE1C061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 15:00:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so11748598wmb.4
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPhyON5t2lsnMJZ8HYi8BZ7gzQdWEyhKhPMeJVZANdc=;
        b=dUQcdsq4s73ekjBnKr6uL+EYjUYek6QBStLy8HUJV0SiYzsM3N3K7iYsKDel+pfhgP
         WDM2In7qIiPDBRsSfOuvAm8ofB0bJkj1B8lS3ztan7fVynzuYTfKdxqA0bwQwj0xB5uZ
         HkBTqGamIv3aIqL8VqFYRCiuNgwbc1SulcPVeN63xZ30cvLq1F6Ixs4SVkR753AW5jDW
         45jZU3+g7AMe1ltqRboBgcShGyLe6ja1i8QnrPcKgm+XEk5XXgjsKyGpZJGnckaXMw4q
         CcCpUU+W4llxARrHFqg2hd69tozoZtd/jgn3AI7Y6XE9yUY7n6965AJm/ttoiMKdLLtc
         n+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPhyON5t2lsnMJZ8HYi8BZ7gzQdWEyhKhPMeJVZANdc=;
        b=ioOoCB7WR3pmn8b96mhfSDrEk0vXjkHm1fXH84EreyRgQBwr1sWmjJ5AHzC2RHL8wU
         6tcENsMkQtH7/1FbRW9dabLsnnmE8aY6ocqSPDOQz35sGgpSiwXOsJYGlGowIEz5AXRC
         gR5LRHZEqur4BJQXM2BTP0QnhJy66utWdjo5tRDAFHR8GZVWpANWe1tHbmdqi+y9R1xC
         nWoxstW7PZ4GcW80QjZAU8u4byRxy/dcJj2TRuHaKR/vHdVva5Jew4Lj8dMcYrQ3g+Ok
         DFFan0IsyBVXDjr9M/VXHw3MEfYW7PMuiTyI2nthydMrvlbDPON86giortevnC7gqWcM
         Z1nA==
X-Gm-Message-State: AGi0PubkX8xeGtnjCYGtDC397WCZmQhtgjkTUNOCaepzJPFH7gdBX5xo
        fOzLNAssY2hPf+cmQIKjDb3f4A==
X-Google-Smtp-Source: APiQypJmiYVfsjfkrMaY/y70wh5rMb7vQUrnV/1GacNtlxMPipssrqTcDECB6zeqrq3aHVDymDUVCQ==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr17314309wmo.23.1588975223026;
        Fri, 08 May 2020 15:00:23 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:22 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/4] blk-wbt: remove wbt_update_limits
Date:   Sat,  9 May 2020 00:00:14 +0200
Message-Id: <20200508220015.11528-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one call this function after commit 2af2783f2ea4f ("rq-qos: get rid of
redundant wbt_update_limits()"), so remove it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-wbt.c | 8 --------
 block/blk-wbt.h | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9cb082f38b93..78bb624cce53 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -418,14 +418,6 @@ static void __wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
-void wbt_update_limits(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	if (!rqos)
-		return;
-	__wbt_update_limits(RQWB(rqos));
-}
-
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 8e4e37660971..16bdc85b8df9 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -88,7 +88,6 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 #ifdef CONFIG_BLK_WBT
 
 int wbt_init(struct request_queue *);
-void wbt_update_limits(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
 void wbt_enable_default(struct request_queue *);
 
@@ -108,9 +107,6 @@ static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
 }
-static inline void wbt_update_limits(struct request_queue *q)
-{
-}
 static inline void wbt_disable_default(struct request_queue *q)
 {
 }
-- 
2.17.1

