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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F7C43460
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4CE6139A
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDTLVJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhDTLVI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02832C06138C;
        Tue, 20 Apr 2021 04:20:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so3847937plg.11;
        Tue, 20 Apr 2021 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kfQ3tysIoxsatHCHD/2ZhyT8LCxPccS8PgExkIm8Ohw=;
        b=hXAE7fxzva1kCWVxkakrCakKQrPcHFhibFXiK+vF0uaHxUy5jfzQv6a97DjxPsJUKA
         AGCBJUZM7WuW5ysoVTFV7tz6fEs8fiByWd/TxegyE9xnU3jQcL6VETm1LYJ+ZnmVdmcO
         JPSt0cqR0rg2MGe6QkxWfpwOr20e3rsi1YP7llKF4YKe3k9IHETbxOwPo3vv/8nzzRM0
         I/GcgiBRMbg9yA/roUSivUIlLa4CM0kuYEcT1dilIPmpZ2DbHAJdMTjI8trDWRp4henP
         EEIKj9pHwsdxmse7l+/IvDq8IlGkt48NXZZPCPYJOlbvIJ16xv9CaRsg/MG4jEVdSwx5
         L4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kfQ3tysIoxsatHCHD/2ZhyT8LCxPccS8PgExkIm8Ohw=;
        b=f+MgIji45xQEyQNuCYI9XbPKOGr/RiXCWgF/qM3o/dznOAuK/RKBUhxm0ukDBdMJVJ
         CUG+TNnwRbsiJU2X+70gDvjnWt7c1qQ01AXEN0W3cp96sFO+VLohUDqAQ1UyU6CNxmGF
         emxtI6JmNnlxq9ZBbthMNwB1bzyVZGfT3C52RvJzpNczzrW4VdCmhr3JifDCm2PEn+Yd
         c+57GeCegab1rQcc7Lb3pI8guk8s+AcRi5SvLcOGwCFU+agO40cD10FKD7N6HJqn80PQ
         TNZXMy8IHoJwBDZwACwthZUhX9OZTAEaX1fbgR/QwbXxfMP38g67ZFW94030jP6Eyj/s
         VAWw==
X-Gm-Message-State: AOAM533pjZXmLXDWyjf0B1fEyYIT0HsmOjduwko021KXdY86lFpVTnw7
        A+w5fEOCxBQfcknvduNgrgiKoNkversBGA==
X-Google-Smtp-Source: ABdhPJxxNbkRaBeT5aArcLlXmFXnWv+4UnnloMjashrlLk96pX2aGqacSyOI2C2tt4WLNFS8q9ojBA==
X-Received: by 2002:a17:90b:1118:: with SMTP id gi24mr4344521pjb.30.1618917636634;
        Tue, 20 Apr 2021 04:20:36 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:36 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] bfq: optimize the calculation of bfq_weight_to_ioprio()
Date:   Tue, 20 Apr 2021 19:20:23 +0800
Message-Id: <d824bd955851ea5cb5af54b6b901045f058207b2.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The value range of ioprio is [0, 7], but the result of
bfq_weight_to_ioprio() may exceed this range, so simple
optimization is required.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-wf2q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 619ed21..ea5b90d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -527,8 +527,9 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
  */
 static unsigned short bfq_weight_to_ioprio(int weight)
 {
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+	int ioprio = IOPRIO_BE_NR  - weight / BFQ_WEIGHT_CONVERSION_COEFF;
+
+	return ioprio < 0 ? 0 : min_t(int, ioprio, IOPRIO_BE_NR - 1);
 }
 
 static void bfq_get_entity(struct bfq_entity *entity)
-- 
1.8.3.1

