Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21CC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjDFOwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbjDFOwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:52:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8823AD21
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:51:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so43088931pjt.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IukBswUItQA0MwJ6mr8lJHmbvkt98zOHJDlzuZ9xc8=;
        b=iRJlt1CJvMm9eA18RMsi4Pd2vmqTpZST7WKy5PYRQriAE6O/3yD7tZ46f159yNbdWd
         sWkHmJyRT1QPOpKg1FKIakni2SeNhFvE47g04BKr12DCIKMh5ntJ8Bhq++/2LSXORGQk
         81N2B5tvbHSyGgxcdDOX6g+f+n/1cRHK2LWyUferpNf/DBOa02WAou5MUpMmVmafqLT5
         X0hpmy3pNW832fIRF8gT3xx7WlcPuwgoseI7QevKWW1jDeRF0C3XA6YUMBdgE0HE/zEH
         CFK2P57NKeaxPyOJZPLj/9/XBA61NM442z53Dnz6jwJ/G0q1piRk0XHrxw84/n75W0mq
         CEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IukBswUItQA0MwJ6mr8lJHmbvkt98zOHJDlzuZ9xc8=;
        b=ovNueeSfzlGMofRsaRKXtVl3xcsduL4iyQTTSmECrnYde1Ff5mASRS6e/Sv6Bf1U5E
         ihmxgowRSwgM8d4lyh3DTJMMhRChpTXiYs3y5PG83rpHpMf9EdT4AYWmMdT0rh/pcqx1
         jVfJ4e9sVJmZ7HYFfEwK54LDd1wIFfqZqI1QspwDyKDEHvZyfU0aNIUVN4Hu6AiANeF8
         ybHd/R9K9sDdCqawGF31Bz5WGOXDw/251PEj90Kzu2OkV+CKILLSlaWI1hbRt6ab+8O+
         4k2M0ENuRBs1EnwECJXBGsRaHEuNr+2bOVqrqwvXsq/lsvOcrOjRO/9U9/Qo4xMY79FZ
         cHnQ==
X-Gm-Message-State: AAQBX9cqHZwPy9TOIqc4VC4ew6ZGuRn09gaRbephoAcp+s4hV/NR6vwW
        gM1eqrfz2Zz5aeMhwkWzicwnGQ==
X-Google-Smtp-Source: AKy350bKD/N614XCLXav3ebLsFXgDjtshr3+E7sESXsbgXqxHi+VsF3jJtgjKaWQ49jOjPijP3JTtA==
X-Received: by 2002:a17:903:11d1:b0:19f:1c64:c9d8 with SMTP id q17-20020a17090311d100b0019f1c64c9d8mr12440320plh.14.1680792672041;
        Thu, 06 Apr 2023 07:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:11 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 3/3] blk-cgroup: delete cpd_init_fn of blkcg_policy
Date:   Thu,  6 Apr 2023 22:50:50 +0800
Message-Id: <20230406145050.49914-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg_policy cpd_init_fn() is used to just initialize some default
fields of policy data, which is enough to do in cpd_alloc_fn().

This patch delete the only user bfq_cpd_init(), and remove cpd_init_fn
from blkcg_policy.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c | 10 ++--------
 block/blk-cgroup.c |  4 ----
 block/blk-cgroup.h |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a2ab5dd58068..74f7d051665b 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -497,14 +497,9 @@ static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
 	bgd = kzalloc(sizeof(*bgd), gfp);
 	if (!bgd)
 		return NULL;
-	return &bgd->pd;
-}
 
-static void bfq_cpd_init(struct blkcg_policy_data *cpd)
-{
-	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
-
-	d->weight = CGROUP_WEIGHT_DFL;
+	bgd->weight = CGROUP_WEIGHT_DFL;
+	return &bgd->pd;
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -1300,7 +1295,6 @@ struct blkcg_policy blkcg_policy_bfq = {
 	.legacy_cftypes		= bfq_blkcg_legacy_files,
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
-	.cpd_init_fn		= bfq_cpd_init,
 	.cpd_free_fn		= bfq_cpd_free,
 
 	.pd_alloc_fn		= bfq_pd_alloc,
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f663178f3a19..5fa77f32a52b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1289,8 +1289,6 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
-		if (pol->cpd_init_fn)
-			pol->cpd_init_fn(cpd);
 	}
 
 	spin_lock_init(&blkcg->lock);
@@ -1645,8 +1643,6 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			if (pol->cpd_init_fn)
-				pol->cpd_init_fn(cpd);
 		}
 	}
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 073488b9c7a0..6794157ea1eb 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -174,7 +174,6 @@ struct blkcg_policy {
 
 	/* operations */
 	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
-	blkcg_pol_init_cpd_fn		*cpd_init_fn;
 	blkcg_pol_free_cpd_fn		*cpd_free_fn;
 
 	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
-- 
2.39.2

