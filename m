Return-Path: <SRS0=Yov/=X6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1AC4740A
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2672084D
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMQ6xjlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfJETBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:01:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45127 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJETBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Oct 2019 15:01:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so4736491pls.12;
        Sat, 05 Oct 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5oAZiGSPpXNuK1uwtnytopuj3PDV8HZJHuPSIRCGfY=;
        b=SMQ6xjltP8wFyQBHo1N9WhWtUM90tqi1NAC1mTHsQ5WApkLvtUXvR9nI17r23qJ/31
         Gtjck5swaNEY0aIz0uH0tJQngvDL8806g9UXp/gikykefvPZBMrrwNTwHesnVhndtbNB
         uKx4fQy5yGJ9N6dH1anVp8pdl0342GNzIdxeggJXw4disfuNBns8KSOEGadVD1fQnvmC
         3lhvAhmAeTv+ZxVa1natV28wDG70nWk6PeYUiYYlGFE5zoLY5snDNy2K7aK6K8C7UtnN
         idBSgpXP7aTNsjoJB2xU4+Kn6wtPE9x/lRLfyAjTJmX6evSiFj2vBLvlZJVFkTBEsq9V
         lDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w5oAZiGSPpXNuK1uwtnytopuj3PDV8HZJHuPSIRCGfY=;
        b=SMQlOmB8USeNZOUhxBqw9RMr+wPr0fGlBC5dSaVqiGcJl1ZV3midWwDFWov5uA8XVk
         jted13tq/e/KxL35qvpoTA081GjAYsph/Z17YTOUinIQfm1yCNmtY5BiD4m5m1kBesZR
         O4mtVwPor3h5h4bfeqpB9mzbL1Y4tiVyetspJuD/h/LUsgy/GmNplmjfTBMMouoZ+jlR
         NiXQwgM0rjAlzyAf1zS/9uHKPDb5y1ZjpXU+7/sW8yaq1Z2LYTLKQnJU5/TMM/L9IUcG
         9joKQ3Q8rtZEoQjEOGMAsNugsjJxmNIwhxKHqTfMj00aA+57H28wXAdfC/sUEVMD2zlG
         l+cQ==
X-Gm-Message-State: APjAAAXW+iVqirPzEa1hPDyFGkZfPLLwpBigHDRc/Iq6IQa5BRCO1ghY
        1NRSS0XAayecjWkgdB9pU1eMvmJz8gg=
X-Google-Smtp-Source: APXvYqytt2XwZKYsjUEoqIT1JSjH+1dps/xHrJqBU0UlLsZtG8NBhuUg/Pm+hzNcsH5cULf8KNwrqw==
X-Received: by 2002:a17:902:b789:: with SMTP id e9mr14712011pls.7.1570302103828;
        Sat, 05 Oct 2019 12:01:43 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id ep10sm23686288pjb.2.2019.10.05.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 12:01:43 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        vaibhavrustagi@google.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH v2] blk-wbt: fix performance regression in wbt scale_up/scale_down
Date:   Sat,  5 Oct 2019 11:59:27 -0700
Message-Id: <20191005185927.91209-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scale_up wakes up waiters after scaling up. But after scaling max, it
should not wake up more waiters as waiters will not have anything to
do. This patch fixes this by making scale_up (and also scale_down)
return when threshold is reached.

This bug causes increased fdatasync latency when fdatasync and dd
conv=sync are performed in parallel on 4.19 compared to 4.14. This
bug was introduced during refactoring of blk-wbt code.

Changes since V1:
- Replaced incorrect "return 0" with "return true" in
  rq_depth_scale_down()

Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 block/blk-rq-qos.c | 14 +++++++++-----
 block/blk-rq-qos.h |  4 ++--
 block/blk-wbt.c    |  6 ++++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 3954c0dc1443..de04b89e9157 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -142,24 +142,27 @@ bool rq_depth_calc_max_depth(struct rq_depth *rqd)
 	return ret;
 }
 
-void rq_depth_scale_up(struct rq_depth *rqd)
+/* Returns true on success and false if scaling up wasn't possible */
+bool rq_depth_scale_up(struct rq_depth *rqd)
 {
 	/*
 	 * Hit max in previous round, stop here
 	 */
 	if (rqd->scaled_max)
-		return;
+		return false;
 
 	rqd->scale_step--;
 
 	rqd->scaled_max = rq_depth_calc_max_depth(rqd);
+	return true;
 }
 
 /*
  * Scale rwb down. If 'hard_throttle' is set, do it quicker, since we
- * had a latency violation.
+ * had a latency violation. Returns true on success and returns false if
+ * scaling down wasn't possible.
  */
-void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
+bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 {
 	/*
 	 * Stop scaling down when we've hit the limit. This also prevents
@@ -167,7 +170,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 	 * keep up.
 	 */
 	if (rqd->max_depth == 1)
-		return;
+		return false;
 
 	if (rqd->scale_step < 0 && hard_throttle)
 		rqd->scale_step = 0;
@@ -176,6 +179,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 
 	rqd->scaled_max = false;
 	rq_depth_calc_max_depth(rqd);
+	return true;
 }
 
 struct rq_qos_wait_data {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2300e038b9fa..c0f0778d5396 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -125,8 +125,8 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 acquire_inflight_cb_t *acquire_inflight_cb,
 		 cleanup_cb_t *cleanup_cb);
 bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit);
-void rq_depth_scale_up(struct rq_depth *rqd);
-void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
+bool rq_depth_scale_up(struct rq_depth *rqd);
+bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
 void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 313f45a37e9d..5a96881e7a52 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -308,7 +308,8 @@ static void calc_wb_limits(struct rq_wb *rwb)
 
 static void scale_up(struct rq_wb *rwb)
 {
-	rq_depth_scale_up(&rwb->rq_depth);
+	if (!rq_depth_scale_up(&rwb->rq_depth))
+		return;
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
 	rwb_wake_all(rwb);
@@ -317,7 +318,8 @@ static void scale_up(struct rq_wb *rwb)
 
 static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 {
-	rq_depth_scale_down(&rwb->rq_depth, hard_throttle);
+	if (!rq_depth_scale_down(&rwb->rq_depth, hard_throttle))
+		return;
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
 	rwb_trace_step(rwb, "scale down");
-- 
2.23.0.581.g78d2f28ef7-goog

