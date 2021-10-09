Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7B9C4321E
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413C5610A4
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 12:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhJIM2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244766AbhJIM2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 08:28:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DCFC061570;
        Sat,  9 Oct 2021 05:26:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v25so38142603wra.2;
        Sat, 09 Oct 2021 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXi3eQ73M3DvHkT3Ar7ro+5G3w3X7uWmCy95vClAZtU=;
        b=Uq8PQQp2XiQsEP9uP52glrC5owaiHl2ABYWB0ACGkuleldivxHIT2Q+ej6Ij/wSnGk
         dydYr2wBCu3JFT8MIHW0SWa1J/QZfUz5JK4MQZQQ1URM3pJ8p0k8qvI6CLWNU66UBkpe
         1T1yMAiUNP+YfZ63iDN4KlYXY8udvFTiI6at3yPlBltd06l/9db0Zltw5hC/vL+mux+2
         rHI9/l6GqURgNkdzfFYPUbiqJtIhKgqex9GfeD2URtQu1eKKJ89jC3YPFs9de/RQytAc
         lJNxHNp+qSM7JGlbGEOw3aFvXHP205el8zaKpLxh3Pk2bpbpcaQMz7dWz4QsfyqTYa3z
         4lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXi3eQ73M3DvHkT3Ar7ro+5G3w3X7uWmCy95vClAZtU=;
        b=Iu2t+w8lm25ijvPt1QS0rvvSuFCPNJC6YqyvpdSDfNobmjFyZjdiYYy22g3/qWeT5X
         z1u4CsFW2iYUcm6jcDnsbEwhn0lxOdIZ2IZL/jNi7iRpXUsWygfW3NjrBT3UmrdLmjd5
         7KkJBlo75PFxkdEzcAWQW7Iy3bhw8v9FyrcX5kcZF7AcS13GlazAN+uOwiz+ZhKOMCJm
         jxPJgWxbr12EgSyVl9DzfNimcRMevpzyjD3sbQ26slsxlo/kgUIP++RxU8OhDWWMI4mY
         3so0M0DpSGC81C2MmVD2K8mp3C8KwD3UFIzFlm3DsK/b4VK9cZaMFF1D8tw0zEs3T22K
         2S4A==
X-Gm-Message-State: AOAM5309GByem/6iBEmlkr+WSQAQU2zeYu1gaezBhn7D0vogFEWbhrnX
        u53Bn+j9Ufze7CaTWkqkIDR8NBjQUk4=
X-Google-Smtp-Source: ABdhPJzPb9VCN0YZ28ZNQDsxHWo5LefRacMk0FbD20qbYUOyAfqF/tAQloqgbgn4KEt1sv7EvADYVA==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr10579496wrc.209.1633782394002;
        Sat, 09 Oct 2021 05:26:34 -0700 (PDT)
Received: from localhost.localdomain ([85.255.236.155])
        by smtp.gmail.com with ESMTPSA id o12sm2157468wrv.78.2021.10.09.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 05:26:33 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com
Subject: [PATCH 5/6] blk-mq: inline hot part of __blk_mq_sched_restart
Date:   Sat,  9 Oct 2021 13:25:42 +0100
Message-Id: <894abaa0998e5999f2fe18f271e5efdfc2c32bd2.1633781740.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633781740.git.asml.silence@gmail.com>
References: <cover.1633781740.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Extract a fast check out of __block_mq_sched_restart() and inline it for
performance reasons.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-sched.c | 4 +---
 block/blk-mq-sched.h | 8 +++++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 27312da7d638..efc1374b8831 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -57,10 +57,8 @@ void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
 
-void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
+void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
-		return;
 	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
 	/*
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index e4d367e0b2a3..c97b816c3800 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -17,7 +17,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 				   struct list_head *free);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
-void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async);
@@ -31,6 +31,12 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_rqs(struct request_queue *q);
 
+static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
+{
+	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+		__blk_mq_sched_restart(hctx);
+}
+
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
-- 
2.33.0

