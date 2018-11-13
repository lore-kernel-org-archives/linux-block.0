Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E066C43610
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7CD2086B
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f3tKsM+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7CD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeKNBlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39446 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeKNBlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:25 -0500
Received: by mail-io1-f65.google.com with SMTP id b26-v6so8557486ioc.6
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gngy6ndCqerfPaGct02L9pdutncRCYm4yRPgtxDKoxs=;
        b=f3tKsM+iibflxhK89pVkRzYkxMpSLCGG0qs0mfSa7G9QvohvynNE0gGBTNsNTRbjdw
         qMjrtEZmEjAvNPSigIYio4yUCnYWKwacNulEIHrY9PdZVpbz6NluVrVj7bZIbhciJ3mZ
         8qWucjbUaImCtSGZEOV1ZlFaEe40n+xwMKXdsHrg0QMQtrvkQVQuaKSuT7+tC6eNSwvw
         MxZE79RuSPFiyMyCmepkvvZVFk/ZDI7VWF/69ua7bClqPZhoengt8qnxU7OBP/R/LaMr
         AoVyH3TWzbq509A3DgpmszisRfIk/ztvXM6cuGkYJ1uN01iuCXAiOubzcSwc286gzOoZ
         RyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gngy6ndCqerfPaGct02L9pdutncRCYm4yRPgtxDKoxs=;
        b=spgkUxnx5OK5uBtJt813iUcHqwItDIDjMcA5UTcTD4Tib+RQVKLXnzeYlV2NoJwL7B
         pFLRv3Tjb1yeDc2AvqYmcS5joCpL4HzQ7EMDiV7D6cP7AM+YbxpDCu3zGYz8DZP9ERZL
         r3xAXXVdrxHcCYmsEnN4iZNbJt50P0QopT9xlERH0bpoO6yj0JbRefMsSrPDU29Aqmjr
         Tz/+kOyOChFRDR2gl7bxCqDhOFxO9V5d4Bz1MV3K2JWq4CmJkA4LFPvdbCrydDSxQBIp
         cjdH0XpaKoIUNwk52HsEpCpwONWIpg31Ak3XGfPNkDx/DlnrZUw5VQOF3n2wZ4OSr3pK
         /meg==
X-Gm-Message-State: AGRZ1gIvBO5CAcwD2mkAEPyAnezLNeqjEE8zVhQWVrxAKPewavpHK6/v
        7mIPwBy62YPrC4DngB6LPUqX8BFXUmA=
X-Google-Smtp-Source: AJdET5ejq1/0Io6M3sV/1lum9J0qiUr8SQB2z5gjWxLx15qp7vMEFrlRYBCTvmaRO+FMk7s1SDBYLw==
X-Received: by 2002:a6b:3809:: with SMTP id f9mr4634975ioa.305.1542123765871;
        Tue, 13 Nov 2018 07:42:45 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 04/11] blk-rq-qos: inline check for q->rq_qos functions
Date:   Tue, 13 Nov 2018 08:42:26 -0700
Message-Id: <20181113154233.15256-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Put the short code in the fast path, where we don't have any
functions attached to the queue. This minimizes the impact on
the hot path in the core code.

Cleanup duplicated code by having a macro setup both the inline
check and the actual functions.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-rq-qos.c | 90 +++++++++++++---------------------------------
 block/blk-rq-qos.h | 35 ++++++++++++++----
 2 files changed, 52 insertions(+), 73 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 0005dfd568dd..266c9e111475 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -27,76 +27,34 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
 
-void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->cleanup)
-			rqos->ops->cleanup(rqos, bio);
-	}
-}
-
-void rq_qos_done(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->done)
-			rqos->ops->done(rqos, rq);
-	}
-}
-
-void rq_qos_issue(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->issue)
-			rqos->ops->issue(rqos, rq);
-	}
-}
-
-void rq_qos_requeue(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->requeue)
-			rqos->ops->requeue(rqos, rq);
-	}
+#define __RQ_QOS_FUNC_ONE(__OP, type)					\
+void __rq_qos_##__OP(struct rq_qos *rqos, type arg)			\
+{									\
+	do {								\
+		if ((rqos)->ops->__OP)					\
+			(rqos)->ops->__OP((rqos), arg);			\
+		(rqos) = (rqos)->next;					\
+	} while (rqos);							\
 }
 
-void rq_qos_throttle(struct request_queue *q, struct bio *bio,
-		     spinlock_t *lock)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->throttle)
-			rqos->ops->throttle(rqos, bio, lock);
-	}
+__RQ_QOS_FUNC_ONE(cleanup, struct bio *);
+__RQ_QOS_FUNC_ONE(done, struct request *);
+__RQ_QOS_FUNC_ONE(issue, struct request *);
+__RQ_QOS_FUNC_ONE(requeue, struct request *);
+__RQ_QOS_FUNC_ONE(done_bio, struct bio *);
+
+#define __RQ_QOS_FUNC_TWO(__OP, type1, type2)				\
+void __rq_qos_##__OP(struct rq_qos *rqos, type1 arg1, type2 arg2)	\
+{									\
+	do {								\
+		if ((rqos)->ops->__OP)					\
+			(rqos)->ops->__OP((rqos), arg1, arg2);		\
+		(rqos) = (rqos)->next;					\
+	} while (rqos);							\
 }
 
-void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->track)
-			rqos->ops->track(rqos, rq, bio);
-	}
-}
-
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->done_bio)
-			rqos->ops->done_bio(rqos, bio);
-	}
-}
+__RQ_QOS_FUNC_TWO(throttle, struct bio *, spinlock_t *);
+__RQ_QOS_FUNC_TWO(track, struct request *, struct bio *);
 
 /*
  * Return true, if we can't increase the depth further by scaling
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 32b02efbfa66..50558a6ea248 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -98,12 +98,33 @@ void rq_depth_scale_up(struct rq_depth *rqd);
 void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
-void rq_qos_cleanup(struct request_queue *, struct bio *);
-void rq_qos_done(struct request_queue *, struct request *);
-void rq_qos_issue(struct request_queue *, struct request *);
-void rq_qos_requeue(struct request_queue *, struct request *);
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
-void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
-void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
+#define RQ_QOS_FUNC_ONE(__OP, type)					\
+void __rq_qos_##__OP(struct rq_qos *rqos, type arg);			\
+static inline void rq_qos_##__OP(struct request_queue *q, type arg)	\
+{									\
+	if ((q)->rq_qos)						\
+		__rq_qos_##__OP((q)->rq_qos, arg);			\
+}
+
+#define RQ_QOS_FUNC_TWO(__OP, type1, type2)				\
+void __rq_qos_##__OP(struct rq_qos *rqos, type1 arg1, type2 arg2);	\
+static inline void rq_qos_##__OP(struct request_queue *q, type1 arg1,	\
+				 type2 arg2)				\
+{									\
+	if ((q)->rq_qos)						\
+		__rq_qos_##__OP((q)->rq_qos, arg1, arg2);		\
+}
+
+RQ_QOS_FUNC_ONE(cleanup, struct bio *);
+RQ_QOS_FUNC_ONE(done, struct request *);
+RQ_QOS_FUNC_ONE(issue, struct request *);
+RQ_QOS_FUNC_ONE(requeue, struct request *);
+RQ_QOS_FUNC_ONE(done_bio, struct bio *);
+RQ_QOS_FUNC_TWO(throttle, struct bio *, spinlock_t *);
+RQ_QOS_FUNC_TWO(track, struct request *, struct bio *);
+#undef RQ_QOS_FUNC_ONE
+#undef RQ_QOS_FUNC_TWO
+
 void rq_qos_exit(struct request_queue *);
+
 #endif
-- 
2.17.1

