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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FFC433E0
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A6622B45
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 11:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAFLWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbhAFLWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 06:22:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F03C061357;
        Wed,  6 Jan 2021 03:21:40 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be12so1399444plb.4;
        Wed, 06 Jan 2021 03:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sBzg1tgz32alZ9aHN5cWbJFQtT8AE3oR3feRMm8uqb4=;
        b=rjUpIwXgwYBgFL6Td5HV5IAazmyCdHJboKVsfEUitilMhFN/NXj7J/s95LuzqsPxzg
         mKUU+dZLeQ20rfLAsjmiykuWQgDLoSAGMF0hegflMVAZb969oU3wGQq4enI58Q/0kHjS
         onJsKaCajoacR2bHituttW/WT1g9UdQtPkTBg5AnwMoOrtFFu8PhZhcXBFogvNH9DFQ1
         km6i2zArd0HdC2fbLZKb66fZwDDVc/7qA24G9JG9yKY7qBuhUyzdz0cVo0yDULb3/hXV
         uzWLNqtOHTUqj2phpaVYzOorPg/t/zjllZlKvyEy25YEROsyB1QI1xVX2TsVmyXSwL4U
         s6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sBzg1tgz32alZ9aHN5cWbJFQtT8AE3oR3feRMm8uqb4=;
        b=jimJYDaqHzrkt+Uqqn13uUSjqMtInl3fNTzEEr1hNHhnQAh9patZg1y+rIslj3RR27
         UBA1h91LVf/eE5hu07Bmo7ko0yg/znrMk2vmwfy49gcztN+2ov97YwoAasfnYXP/DKQf
         Lzdclxdr0VpMLE8aNGH3ZBn3oui3lYQLQnRdmIakDYbZToktxYoFncOJdYfxTD6tTdLw
         95dZVAr5U62R1vZbUy2+ssmb61zeF8lMxA7xqd01T9OkIoQ2KtDXI1K09FtqKf6zXtS7
         whiaghe5ljDGXVDnUpVwmjZ4j20jbbb/XPAicJJUeo+/vPEUAh5koN3IMNagET0KZ9Gu
         y+6Q==
X-Gm-Message-State: AOAM53011H+KKmzUYUucM8jvBHEG1sXe8UJ5buC78peA1esi9vlNMaqw
        FBzcx8RgiT09mtPemmxTSaL9y9I/psk=
X-Google-Smtp-Source: ABdhPJw4ST2D9x6/ZeVz3GrOo9MUhYRwl/+5EAAwFeZdBDP66B9tfiu4w6gyGPcQWDtm7VkldWw7YA==
X-Received: by 2002:a17:902:b588:b029:db:e1d8:1492 with SMTP id a8-20020a170902b588b02900dbe1d81492mr3983485pls.80.1609932099576;
        Wed, 06 Jan 2021 03:21:39 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id p9sm2373767pfq.109.2021.01.06.03.21.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 03:21:39 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: introduce for_each_rq_qos macro
Date:   Wed,  6 Jan 2021 19:20:56 +0800
Message-Id: <1609932056-26990-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Compared to direct pointer traversal, introducing a macro
will make the code more concise. But the introduction of
macros will make rq_qos_xxx() produce a redundant judgment,
usually this may not be a big problem.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-rq-qos.c | 45 ++++++++++++++++++---------------------------
 block/blk-rq-qos.h | 11 +++++++++--
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 6564606..2c21a49 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -31,83 +31,74 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 
 void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->cleanup)
 			rqos->ops->cleanup(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_done(struct rq_qos *rqos, struct request *rq)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->done)
 			rqos->ops->done(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_issue(struct rq_qos *rqos, struct request *rq)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->issue)
 			rqos->ops->issue(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->requeue)
 			rqos->ops->requeue(rqos, rq);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->throttle)
 			rqos->ops->throttle(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->track)
 			rqos->ops->track(rqos, rq, bio);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_merge(struct rq_qos *rqos, struct request *rq, struct bio *bio)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->merge)
 			rqos->ops->merge(rqos, rq, bio);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->done_bio)
 			rqos->ops->done_bio(rqos, bio);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 void __rq_qos_queue_depth_changed(struct rq_qos *rqos)
 {
-	do {
+	for_each_rq_qos(rqos) {
 		if (rqos->ops->queue_depth_changed)
 			rqos->ops->queue_depth_changed(rqos);
-		rqos = rqos->next;
-	} while (rqos);
+	}
 }
 
 /*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2bc43e9..bfa72a5 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -57,11 +57,18 @@ struct rq_depth {
 	unsigned int default_depth;
 };
 
+/*
+ * for_each_rq_qos() allows you to iterate on each rqos
+ */
+#define for_each_rq_qos(rqos) \
+	for (; rqos; rqos = rqos->next)
+
 static inline struct rq_qos *rq_qos_id(struct request_queue *q,
 				       enum rq_qos_id id)
 {
-	struct rq_qos *rqos;
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	struct rq_qos *rqos = q->rq_qos;
+
+	for_each_rq_qos(rqos) {
 		if (rqos->id == id)
 			break;
 	}
-- 
1.8.3.1

