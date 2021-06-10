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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607DC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C3613BC
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJHYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJHYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:24:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11AC061574;
        Thu, 10 Jun 2021 00:22:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so3263986pjq.3;
        Thu, 10 Jun 2021 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=tlgYbQQGC9aUPmkDkEincUleYTHmaFv4FEB2M1H69EVcPcp+22HMegHmVBf61F1IoI
         Tygp0WHjkhlSJ2BPa16XInKh0MLDWBMuLoSs0h0qrqVlt9rC8nA6SNDUejlhFC1Ws6H8
         7z+htLBSSXTyL4jQRKLErJndhd67wr160lea1VdeAgSaYo5Sc2r5Xuy8ueAecaEnDSzr
         K8L2sohC/8lynyQKZCNZLYIXfxRY6QuXg55qWSceQMVqMQycYox/Lro0XrkIWjNeCDJm
         Reda/oPfVS84mGqLXr3xpTilti2ybr8PY+IbRVQzbwI/mz9xDjkd7F2nJbRPlW/wtsrB
         RFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=bfmipGCbWKbe99rhH5PF3J4HZzicKxFFsyl1X1pxXuvYMa81z2QlpjN0E+36eSwyrl
         YJ8NIx/1uZbimfaQPvgvDr99vuyZjmujfAOy0Qc2puuoTKCWlDztNHNoyybDBvukPs55
         MJ9NcqJu9+tU+BrUKxC6rxLLiIlepciGYEJGR+hfFi8CZqLPnRnLJJsEwVkxRnfpdKJm
         HMeVMnSfY/mjXMuTerzaZCX1m/dF9VG9vcbNthp7hU1Wda5BCioxWDXUFFXfHwCdoKSr
         tmcj53jpCNWfVUewZ9Dr62lOTk339QIryq2drDofT3XA48UtZty2Cw6N1nOIutmyy4D3
         q+fg==
X-Gm-Message-State: AOAM533aQ+wS72N6OK/qZEfnb5cWkDhuzRNcIzrNUAtYf8llyoxxTlm8
        XxLF7lP5mk9SEY1ckkYzRfg=
X-Google-Smtp-Source: ABdhPJz6wTBpgtmYDHHtdCDTXvNmJaY0MnFtBTS800L36oPdwlvcDFirATNe0rquCyI9DeaKEHOdKg==
X-Received: by 2002:a17:90a:4216:: with SMTP id o22mr1940792pjg.3.1623309762347;
        Thu, 10 Jun 2021 00:22:42 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:42 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/8] bfq: convert the type of bfq_group.bfqd to bfq_data*
Date:   Thu, 10 Jun 2021 15:22:31 +0800
Message-ID: <ee08300e3d393b71b67aeaf1609fd6277968f1f1.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072231.ONxBJKx_UUKrQmnpusJ4vSZsu6y2wRd86QiiUE64nS8@z>

From: Chunguang Xu <brookxu@tencent.com>

Setting bfq_group.bfqd to void* type does not seem to make much sense.
This will cause unnecessary type conversion. Perhaps it would be better
to change it to bfq_data* type.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  | 2 +-
 block/bfq-iosched.h | 2 +-
 block/bfq-wf2q.c    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a5f544a..50d06c7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -224,7 +224,7 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
 {
 	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
 	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+	if (!(bfqq == bfqg->bfqd->in_service_queue))
 		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a6f98e9..28d8590 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -914,7 +914,7 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	void *bfqd;
+	struct bfq_data *bfqd;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
 	struct bfq_queue *async_idle_bfqq;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 5ff0028..276f225 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -498,7 +498,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
@@ -597,7 +597,7 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	sd = entity->sched_data;
 	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
+	bfqd = bfqg->bfqd;
 #endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
@@ -743,7 +743,7 @@ struct bfq_service_tree *
 		else {
 			sd = entity->my_sched_data;
 			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
+			bfqd = bfqg->bfqd;
 		}
 #endif
 
-- 
1.8.3.1

