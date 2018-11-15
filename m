Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6906CC04EBF
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2566A2146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CIEAgpUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKPGBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32972 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:00:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so10203136pfk.0
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0CsOxzWNiXiFSdVT8Ap2AwFn+e3sW43Qpf/ppSkfHZc=;
        b=CIEAgpUwfncK5yL71e0vdNcIrM3V78MAvcqc5PPBYeEwrA1wNemtYJtn46/sviuHB9
         ji0od33E7vwTJ4s/t8BK+dWWh0pOtMvQ1jJGlMCKuXrFQ8h9PladOZq9cfaU9kS5X4Sg
         XzvncLlMuCDcwpCzE2rDU4Vj2kzZZU2aRWjDhFmv92IpCgSA46RaojFxm9p+lsNK/OZY
         GZiDW0IuLurz/MOuO8AXinFJGa+OU5AnYR0W8pfN/dLyIXZQ1WLwzpNK0ooEIMhD6zwO
         1aQyF1oL1sbRHHUwonUzp37xl+52rO4qY34OWK9SOWZ/dk+C8yRqIpZCQcCH8HSWWIQx
         ND0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0CsOxzWNiXiFSdVT8Ap2AwFn+e3sW43Qpf/ppSkfHZc=;
        b=q/mg8YpLI67f9pRYJkYn1kYudPHpo7szxgJKSvj0J78zJCZg8bJv/CijgTKcq/+rXc
         5NmYnrUvOQ/MMbOq42JM8e0JmRmaVuuvkf1hU2g5FYC6HH3omeT/D0+p0G/VAXbuvrpU
         0+m7Wt/JskEPuVM9VgsVhYj1awfVhbVpjG+jviwugdDF2vuAS1+WWzZuDeNRVjmqbfuY
         C6CahmV368D86/r061hb9WYSqLhkF4L8BcMfyrQXDCAbFnoUT9GzOuzSj9XUHOQ76z4g
         y9Uy4baD18DljaKqjtb0fkj5VNDxx6UN/UHk3oYAWiPa7Qgd5LgxAr77rpMkmLYLceyq
         mZRg==
X-Gm-Message-State: AGRZ1gI+JPF4j/tvexAx/rhptaTmUh0qTtjYXnF58OOt5876arN9veR3
        gMFJTkqUPqW6q/guBzjqLxeLcDbE8S8=
X-Google-Smtp-Source: AJdET5ew1XUfMbFTJpKUgMF13MdNwtlrs+RU3k+uiIDYq2/ETXQVW9SCesGN/4Gl/5oIHvT5uIrsCQ==
X-Received: by 2002:a63:db02:: with SMTP id e2mr7112727pgg.419.1542311506944;
        Thu, 15 Nov 2018 11:51:46 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 03/11] blk-rq-qos: inline check for q->rq_qos functions
Date:   Thu, 15 Nov 2018 12:51:27 -0700
Message-Id: <20181115195135.22812-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Put the short code in the fast path, where we don't have any
functions attached to the queue. This minimizes the impact on
the hot path in the core code.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-rq-qos.c | 63 +++++++++++++++++++++-------------------------
 block/blk-rq-qos.h | 59 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index f8a4d3fbb98c..80f603b76f61 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -27,74 +27,67 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
 
-void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
+void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
 {
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->cleanup)
 			rqos->ops->cleanup(rqos, bio);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_done(struct request_queue *q, struct request *rq)
+void __rq_qos_done(struct rq_qos *rqos, struct request *rq)
 {
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->done)
 			rqos->ops->done(rqos, rq);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_issue(struct request_queue *q, struct request *rq)
+void __rq_qos_issue(struct rq_qos *rqos, struct request *rq)
 {
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->issue)
 			rqos->ops->issue(rqos, rq);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_requeue(struct request_queue *q, struct request *rq)
+void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq)
 {
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->requeue)
 			rqos->ops->requeue(rqos, rq);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_throttle(struct request_queue *q, struct bio *bio)
+void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->throttle)
 			rqos->ops->throttle(rqos, bio);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
+void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
 {
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->track)
 			rqos->ops->track(rqos, rq, bio);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
+void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio)
 {
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+	do {
 		if (rqos->ops->done_bio)
 			rqos->ops->done_bio(rqos, bio);
-	}
+		rqos = rqos->next;
+	} while (rqos);
 }
 
 /*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index b6b11d496007..6e09e98b93ea 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -98,12 +98,57 @@ void rq_depth_scale_up(struct rq_depth *rqd);
 void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
-void rq_qos_cleanup(struct request_queue *, struct bio *);
-void rq_qos_done(struct request_queue *, struct request *);
-void rq_qos_issue(struct request_queue *, struct request *);
-void rq_qos_requeue(struct request_queue *, struct request *);
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
-void rq_qos_throttle(struct request_queue *, struct bio *);
-void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
+void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
+void __rq_qos_done(struct rq_qos *rqos, struct request *rq);
+void __rq_qos_issue(struct rq_qos *rqos, struct request *rq);
+void __rq_qos_requeue(struct rq_qos *rqos, struct request *rq);
+void __rq_qos_throttle(struct rq_qos *rqos, struct bio *bio);
+void __rq_qos_track(struct rq_qos *rqos, struct request *rq, struct bio *bio);
+void __rq_qos_done_bio(struct rq_qos *rqos, struct bio *bio);
+
+static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
+{
+	if (q->rq_qos)
+		__rq_qos_cleanup(q->rq_qos, bio);
+}
+
+static inline void rq_qos_done(struct request_queue *q, struct request *rq)
+{
+	if (q->rq_qos)
+		__rq_qos_done(q->rq_qos, rq);
+}
+
+static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
+{
+	if (q->rq_qos)
+		__rq_qos_issue(q->rq_qos, rq);
+}
+
+static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
+{
+	if (q->rq_qos)
+		__rq_qos_requeue(q->rq_qos, rq);
+}
+
+static inline void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
+{
+	if (q->rq_qos)
+		__rq_qos_done_bio(q->rq_qos, bio);
+}
+
+static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
+{
+	if (q->rq_qos)
+		__rq_qos_throttle(q->rq_qos, bio);
+}
+
+static inline void rq_qos_track(struct request_queue *q, struct request *rq,
+				struct bio *bio)
+{
+	if (q->rq_qos)
+		__rq_qos_track(q->rq_qos, rq, bio);
+}
+
 void rq_qos_exit(struct request_queue *);
+
 #endif
-- 
2.17.1

