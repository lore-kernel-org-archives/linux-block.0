Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34801C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjDFOwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbjDFOwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:52:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927A170C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:51:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so1809895pjb.5
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvxogFZ7tzo2z7dxF0J9Y3jJgkG796IBeY87z8Qv1kQ=;
        b=PxWqmBRUj4WBnZSfVzpRfLqostqKXR8X10+oF706WENnUQNTAeGyug62X2dsa4tpYN
         TmZJqensASXgsRSvYlajRgHSMIgj2iFr/xVKZh8tJZGDsoodlod6SdH5oK9lq7q+7ePl
         eaWtyww8e1C07Wfpb5nER82j3g66y0RauEyorkQixXonVxmvCfIDmD6SHJ6PzTQihsqe
         I2AQUXe4NtRjpaxWSZwm/sykWFD+1zLra0dC+oUYexpzGyYlq9uYv7vXgtDPypULn3GD
         qClosOFu9bbC+DXhM1sMN06zbLRpwPyZr8aDAP28l2d16iq49K4A3UQfJINl2MstFl0K
         VtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvxogFZ7tzo2z7dxF0J9Y3jJgkG796IBeY87z8Qv1kQ=;
        b=Bsq9ON0oEaGd7Bsk2MqrEERC8LDoyEx49GUf4G4NwsHJVV0PG4qRFbdJmV8IiO70wW
         7herVp2l0E271CTwZhb4Oho95g7uPC4/rO1tIO7JtM2EqMTQv1Wa3KIdHs8tNMm///ai
         99vRFmBvB6/Lt4Dyk0/4ZZOy5icBNa/Hvgf9uHN2OF9gy6np4vy8UmpvwLdqZbg3gAdz
         N7RKtekAAfduLnQyDByJYdJABrueLGASgiZSsmudy5+R/cdOcoiN0tWj7ROuYutKc71W
         8yx9JhVPFe02Mwoyw+A/Vk9aHPavb6jC1wqQZmyzFh5N6aZeQ/4KCeBhWSa+6EOg8Okb
         aX4w==
X-Gm-Message-State: AAQBX9dtJlu4F8Z22LpPrhTYYJ4XWN4TbTry+IugmP/692tI86dVNqAz
        LpIRXz5lyCLAG9/duMCW9hXiKg==
X-Google-Smtp-Source: AKy350YMOAAXOd9Wtpy7569VRlFO8zc9dgQrOSpbdZ975Faxy8Ltu9r0KG6OuX3tcNR0EjtuUJaFTA==
X-Received: by 2002:a17:903:22cd:b0:1a2:8924:224d with SMTP id y13-20020a17090322cd00b001a28924224dmr12472230plg.59.1680792665876;
        Thu, 06 Apr 2023 07:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/3] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
Date:   Thu,  6 Apr 2023 22:50:48 +0800
Message-Id: <20230406145050.49914-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ_WEIGHT_LEGACY_DFL is the same as CGROUP_WEIGHT_DFL, which means
we don't need cpd_bind_fn() callback to update default weight when
attached to a hierarchy.

This patch remove BFQ_WEIGHT_LEGACY_DFL and cpd_bind_fn().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c  | 4 +---
 block/bfq-iosched.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 89ffb3aa992c..a2ab5dd58068 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -504,8 +504,7 @@ static void bfq_cpd_init(struct blkcg_policy_data *cpd)
 {
 	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
 
-	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+	d->weight = CGROUP_WEIGHT_DFL;
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -1302,7 +1301,6 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
 	.cpd_init_fn		= bfq_cpd_init,
-	.cpd_bind_fn	        = bfq_cpd_init,
 	.cpd_free_fn		= bfq_cpd_free,
 
 	.pd_alloc_fn		= bfq_pd_alloc,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 69aaee52285a..467e8cfc41a2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -20,7 +20,6 @@
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_WEIGHT_LEGACY_DFL	100
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-- 
2.39.2

