Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C78C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B6821855
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhXBLMOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfI3I0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:26:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfI3I0D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 04:26:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so10144037wru.7;
        Mon, 30 Sep 2019 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtystXCVgmFe8FVOpvWAM335ehPD2Hq+I2iateHR0RM=;
        b=FhXBLMOs50hPiK/yneThkwx7UCngxYPFMoaGeocIP+ZRh7T00wYCmskK2reoOQezVZ
         GhLG1leUU7ut11lg38RyL10o7+nL4t+bz5VolNwNlql1gKujb3QyiHUiBJ6jk3PILBcE
         wfJxqQG8TBago4PMWTrrb8z0p0AXMuNgvdGuwYP4wl90anCXJI+9cMdlDHwPGBqbOBLy
         YrA+/XP6OKMXmzUf35rHDEeCMiGGx3ia8fZuF/A1XiEkW9uyqviPWBxbK9fuhypnCJc3
         R3guz77M7i/iyd/pfvRb2+fiJ6HnHjf7R6UP7PSku4sLTsek776Wf/njY4+GKJJWR3Jh
         yPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtystXCVgmFe8FVOpvWAM335ehPD2Hq+I2iateHR0RM=;
        b=gt12S9SRgi+Pg+QzOcUmDHcxJPiP+XqNvhXdDW7pCwou+V3dc+5WncvzXkicoPaph6
         kACa+GXKKbhtAJm+1BiVxdFSWEYMq/qTvAY39pBFkFqmIvT3yWzLM/g8GUFy8V+5fqBD
         gCE8a+tKBHXpkrm07KmO9VBAQ9emqeFSUdpVMB/sZOyJx7EAmI2J5ushLx9f9plBo6I+
         wlSwJl58ql9KDqmTK1YEPMS/JyT2FlC2h1b4CGswXd9ULZtQgHDEvTMVTJfZ78hWLL21
         0gq6nXyehzeDEhZym1HkLjbCMSP3QUNwR6c+YeoaHhDc/oFz4wNd9ZBmU+HyuAxOB8Nz
         AE1g==
X-Gm-Message-State: APjAAAXtl/q+MqQzisJOcwPQLoO8Osf499xqWuU+G6nUsQlMXm2wNchP
        q0WqrbtryT2ji7qTKL5hYhk=
X-Google-Smtp-Source: APXvYqzgZrytMLYqA9HA5WbCRzvvrhl4yG6yD8BM5zVIVDfMnBXX0VOqTs5mftPFqD1q3GbnxbIBtQ==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr11705855wrn.251.1569831961032;
        Mon, 30 Sep 2019 01:26:01 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.9])
        by smtp.gmail.com with ESMTPSA id l11sm14211849wmh.34.2019.09.30.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:26:00 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] blk-mq: Inline status checkers
Date:   Mon, 30 Sep 2019 11:25:49 +0300
Message-Id: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

blk_mq_request_completed() and blk_mq_request_started() are
short, inline it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c         | 12 ------------
 block/blk-mq.h         |  9 ---------
 include/linux/blk-mq.h | 20 ++++++++++++++++++--
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 279b138a9e50..d97181d9a3ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -647,18 +647,6 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-int blk_mq_request_started(struct request *rq)
-{
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
-}
-EXPORT_SYMBOL_GPL(blk_mq_request_started);
-
-int blk_mq_request_completed(struct request *rq)
-{
-	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
-}
-EXPORT_SYMBOL_GPL(blk_mq_request_completed);
-
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 32c62c64e6c2..eaaca8fc1c28 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -128,15 +128,6 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
-{
-	return READ_ONCE(rq->state);
-}
-
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
 					   unsigned int cpu)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..090a5601be15 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -301,9 +301,25 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
 }
 
+/**
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
+ * @rq: target request.
+ */
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
+{
+	return READ_ONCE(rq->state);
+}
+
+static inline int blk_mq_request_started(struct request *rq)
+{
+	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
+}
+
+static inline int blk_mq_request_completed(struct request *rq)
+{
+	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+}
 
-int blk_mq_request_started(struct request *rq);
-int blk_mq_request_completed(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.23.0

