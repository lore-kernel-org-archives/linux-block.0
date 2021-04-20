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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330CEC43460
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6E6613B2
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhDTLVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhDTLVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BDC06174A;
        Tue, 20 Apr 2021 04:20:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s22so5278499pgk.6;
        Tue, 20 Apr 2021 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=GH2ig0nsuG2U8HvPMZwr/S/7fAM3RXR2E8yKMIVYIS6H//pgKckhhyRnJbUZtA7npX
         +4ZYf9kuSOURwDBg8pHfdLAwsYsmYm5Omn8H5QkK1DBC0dMYnkynPRMm2GiP2ElZ4a4T
         bauu/+3iRKL/TUA2YvR0wrAYzKK+PtpCkP12OvgNUdpFeUMk6EEnMyq0lpN2cMgI3dNV
         eV/RUofQUzJWz1dBSyLoREKm7feWgDLcQDuJwDN5cvdA64pWPA0FDVtyMV0rOe7wSb1c
         k9SkLpSzGvhCopB3w/8fkf27Q/aUL2WjsIe22EGczBPVlWazTOSbljtobrN609Xr8d+L
         7oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YXgpUa5T67Dw4AbYp5KoLO/kJdOhq1vLhGhKXZoWFNo=;
        b=VnDQiDkFlJUYhTvXH9IceMaAB5ULgvIOTTJJvJcKQCDDTr77Q0jYZErz+Bro1WnDVR
         TFb0Uxp7roQcR79ao8EvefsbnMcdnM1Re2/gswdOztpGEcZXbQik5ZC41RDuUYqFeued
         Ox22HFmsXwP2fRmyXjEIInQRUt/o9TS/oUaHzjgfH29rlmEzp6va/SL53B7UFrL2oBXJ
         +XQzWhLFLU66fLXqwosoVlkf009r5yGAEE5fHcbTHc/36CDYTfpfSPoM82rWdb+NCBCO
         PuLtiqqkRyWIVyidGHmMQiQSyjcawxuT5DZ55E6FnQ+T8417YgEJUZsR5iOrSYw7vQHn
         D9qg==
X-Gm-Message-State: AOAM5327I+zClUpmLUtUczTEdoxbAWDjGxgdGHwC0QmB996/TmPPB5NA
        HO4HR9xXUOPZMb1Ol7GqFC8=
X-Google-Smtp-Source: ABdhPJwt6Wgtq/z5Y+kkE8MHl4OYvdLw4esQyiSJKo2RUVeQvs6dKU94anOaBlgSRcb/bxks0ZU/5g==
X-Received: by 2002:a63:f40b:: with SMTP id g11mr16922042pgi.133.1618917630632;
        Tue, 20 Apr 2021 04:20:30 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:30 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] bfq: convert the type of bfq_group.bfqd to bfq_data*
Date:   Tue, 20 Apr 2021 19:20:19 +0800
Message-Id: <ee08300e3d393b71b67aeaf1609fd6277968f1f1.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

