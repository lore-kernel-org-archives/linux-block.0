Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6BC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FFF213F2
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 13:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltxasCY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDHNGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:06:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHNGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 09:06:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so14638371wml.1;
        Mon, 08 Apr 2019 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CMFjVidRxaCqjr2B6wu9J8FIGMu638S6yJ2otQIbk4I=;
        b=ltxasCY9vpH/ilmJ/3rQxhVShEMYB7P/c0tkga0n1sE3FsKq2X3t75dx4wHRNVCVQf
         7jOEZmvXr/5eCYMIUQuna2/xNl/cuTsBJuVw3kwli6VO1r9WHRSgiYnhrKsugXgNiMHs
         2KAPLjtCIC9v5TS/cSLzxHi8W+ZAJ8iD+Gdkbc6ofXQmpikSZ/hQouEogz7MeTVS78pi
         7lAtdew6QUsT2tREnfsnQoBheZLz5xmfzA6HBThM+LqfUnmr1Duk5jua6waaJRJoB0DX
         mjfMFxnJDkMVdElrlmPJ5ENEMSy6JDb98ToflEMdX+uQwzmnO5wp7mQGfMzvWixIvY2F
         G+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CMFjVidRxaCqjr2B6wu9J8FIGMu638S6yJ2otQIbk4I=;
        b=sqtITvtXO/xveJI50QL4nLPFNN56Kj6Eq4UUzdCblpk4IIf5HhV2bmKa2P5LUltywU
         DQ31jQirqzXhhRrm9FZ+AxrkrBrBLLRienFst6LiuAHEiFIoISMROVJdmNVbfO6OCptL
         JMbz1AP6PbRSWCPuGuYapg955VwfYyp6XQi6A4tf30x2A/vBo0LdtPRVG5DMwYOwNHIb
         238EAa8uPtmbewj596sfWVEisRprW/nKtaTChrPsLwW/cAlSYtUDmlGwjrw/13WGN25G
         ftid4rWiUqUpy/CV1abFdfnYhufv/LjiXdQA54rkJSX4TwGIVHWT3qi0sEzxP+dhkC8T
         +sYw==
X-Gm-Message-State: APjAAAWBuyCg5TArr7YRzGtlJaJYRM9iYm4Q0ZjGn2TyPF2BhH+ok0gF
        3AANh6Bcg3fumKp0IhT0gV/ptMAQXeQ=
X-Google-Smtp-Source: APXvYqw3ngorBEV/0v9294ppIO7ZG+Om+j7BlNocqoMfSV74JPmMgRYoX2In30PcQXR1/FnGV3P71Q==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr16635390wmh.81.1554728777168;
        Mon, 08 Apr 2019 06:06:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-117-55.ip49.fastwebnet.it. [93.34.117.55])
        by smtp.gmail.com with ESMTPSA id w14sm25579526wrr.16.2019.04.08.06.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:06:16 -0700 (PDT)
From:   Angelo Ruocco <angelo.ruocco.90@gmail.com>
X-Google-Original-From: Angelo Ruocco <angeloruocco90@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] block, bfq: fix some typos in comments
Date:   Mon,  8 Apr 2019 15:05:45 +0200
Message-Id: <20190408130545.26211-1-angeloruocco90@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of the comments in the bfq files had typos. This patch fixes them.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 16 ++++++++--------
 block/bfq-iosched.h |  4 ++--
 block/bfq-wf2q.c    | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 319c2444dc71..f56046163731 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1102,7 +1102,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	},
 #endif /* CONFIG_DEBUG_BLK_CGROUP */
 
-	/* the same statictics which cover the bfqg and its descendants */
+	/* the same statistics which cover the bfqg and its descendants */
 	{
 		.name = "io_service_bytes_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4c592496a16a..09fd8d92e380 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -189,7 +189,7 @@ static const int bfq_default_max_budget = 16 * 1024;
 /*
  * When a sync request is dispatched, the queue that contains that
  * request, and all the ancestor entities of that queue, are charged
- * with the number of sectors of the request. In constrast, if the
+ * with the number of sectors of the request. In contrast, if the
  * request is async, then the queue and its ancestor entities are
  * charged with the number of sectors of the request, multiplied by
  * the factor below. This throttles the bandwidth for async I/O,
@@ -217,7 +217,7 @@ const int bfq_timeout = HZ / 8;
  * queue merging.
  *
  * As can be deduced from the low time limit below, queue merging, if
- * successful, happens at the very beggining of the I/O of the involved
+ * successful, happens at the very beginning of the I/O of the involved
  * cooperating processes, as a consequence of the arrival of the very
  * first requests from each cooperator.  After that, there is very
  * little chance to find cooperators.
@@ -433,7 +433,7 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 
 /*
  * Lifted from AS - choose which of rq1 and rq2 that is best served now.
- * We choose the request that is closesr to the head right now.  Distance
+ * We choose the request that is closer to the head right now.  Distance
  * behind the head is penalized and only allowed to a certain extent.
  */
 static struct request *bfq_choose_req(struct bfq_data *bfqd,
@@ -955,7 +955,7 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 	 *   of several files
 	 * mplayer took 23 seconds to start, if constantly weight-raised.
 	 *
-	 * As for higher values than that accomodating the above bad
+	 * As for higher values than that accommodating the above bad
 	 * scenario, tests show that higher values would often yield
 	 * the opposite of the desired result, i.e., would worsen
 	 * responsiveness by allowing non-interactive applications to
@@ -2408,8 +2408,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 		/*
 		 * bic still points to bfqq, then it has not yet been
 		 * redirected to some other bfq_queue, and a queue
-		 * merge beween bfqq and new_bfqq can be safely
-		 * fulfillled, i.e., bic can be redirected to new_bfqq
+		 * merge between bfqq and new_bfqq can be safely
+		 * fulfilled, i.e., bic can be redirected to new_bfqq
 		 * and bfqq can be put.
 		 */
 		bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq,
@@ -2855,7 +2855,7 @@ static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	/*
 	 * All in-service entities must have been properly deactivated
 	 * or requeued before executing the next function, which
-	 * resets all in-service entites as no more in service.
+	 * resets all in-service entities as no more in service.
 	 */
 	__bfq_bfqd_reset_in_service(bfqd);
 }
@@ -5157,7 +5157,7 @@ static void bfq_prepare_request(struct request *rq, struct bio *bio)
  * preparation is that, after the prepare_request hook is invoked for
  * rq, rq may still be transformed into a request with no icq, i.e., a
  * request not associated with any queue. No bfq hook is invoked to
- * signal this tranformation. As a consequence, should these
+ * signal this transformation. As a consequence, should these
  * preparation operations be performed when the prepare_request hook
  * is invoked, and should rq be transformed one moment later, bfq
  * would end up in an inconsistent state, because it would have
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 062e1c4787f4..c0121ebb09fb 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -89,7 +89,7 @@ struct bfq_service_tree {
  * expiration. This peculiar definition allows for the following
  * optimization, not yet exploited: while a given entity is still in
  * service, we already know which is the best candidate for next
- * service among the other active entitities in the same parent
+ * service among the other active entities in the same parent
  * entity. We can then quickly compare the timestamps of the
  * in-service entity with those of such best candidate.
  *
@@ -140,7 +140,7 @@ struct bfq_weight_counter {
  *
  * Unless cgroups are used, the weight value is calculated from the
  * ioprio to export the same interface as CFQ.  When dealing with
- * ``well-behaved'' queues (i.e., queues that do not spend too much
+ * "well-behaved" queues (i.e., queues that do not spend too much
  * time to consume their budget and have true sequential behavior, and
  * when there are no external factors breaking anticipation) the
  * relative weights at each level of the cgroups hierarchy should be
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 63311d1ff1ed..d82a9ca82fa2 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -59,7 +59,7 @@ static bool bfq_update_parent_budget(struct bfq_entity *next_in_service);
  * bfq_update_next_in_service - update sd->next_in_service
  * @sd: sched_data for which to perform the update.
  * @new_entity: if not NULL, pointer to the entity whose activation,
- *		requeueing or repositionig triggered the invocation of
+ *		requeueing or repositioning triggered the invocation of
  *		this function.
  * @expiration: id true, this function is being invoked after the
  *             expiration of the in-service entity
@@ -90,7 +90,7 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
 
 	/*
 	 * If this update is triggered by the activation, requeueing
-	 * or repositiong of an entity that does not coincide with
+	 * or repositioning of an entity that does not coincide with
 	 * sd->next_in_service, then a full lookup in the active tree
 	 * can be avoided. In fact, it is enough to check whether the
 	 * just-modified entity has the same priority as
@@ -1396,7 +1396,7 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
  * In this first case, update the virtual time in @st too (see the
  * comments on this update inside the function).
  *
- * In constrast, if there is an in-service entity, then return the
+ * In contrast, if there is an in-service entity, then return the
  * entity that would be set in service if not only the above
  * conditions, but also the next one held true: the currently
  * in-service entity, on expiration,
@@ -1479,12 +1479,12 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 		 * is being invoked as a part of the expiration path
 		 * of the in-service queue. In this case, even if
 		 * sd->in_service_entity is not NULL,
-		 * sd->in_service_entiy at this point is actually not
+		 * sd->in_service_entity at this point is actually not
 		 * in service any more, and, if needed, has already
 		 * been properly queued or requeued into the right
 		 * tree. The reason why sd->in_service_entity is still
 		 * not NULL here, even if expiration is true, is that
-		 * sd->in_service_entiy is reset as a last step in the
+		 * sd->in_service_entity is reset as a last step in the
 		 * expiration path. So, if expiration is true, tell
 		 * __bfq_lookup_next_entity that there is no
 		 * sd->in_service_entity.
-- 
2.17.1

