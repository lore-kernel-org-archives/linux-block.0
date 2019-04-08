Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F0C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866FD2147A
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGyqJlek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfDHPfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:35:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfDHPfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:35:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so16971957wrn.6;
        Mon, 08 Apr 2019 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IGFlIYLsqW6F74U1ICzyYso+0owEPY2FrYOY2FAK1I0=;
        b=hGyqJlekz8znbVM4b/+W0TsdSzP/WtfkzERuIF/jdBldvqXFcv1j7YJ+OnTex2mqnJ
         o2RUqNAV1i1drDbcdl/1Z5yzo7ITVzAwlma7tCnxHrlmZUGXND/IqyqEVZx6Yxo0MuKO
         MPXNzFL0Q0EBb5oqMzddQV+fTI9Q20NK8BCmBezKitVrGZ7oJg9j8ib1UC2uv6FHhOPK
         RF6iIT2Hp+yQoxwoL4j4r82sCeW4L+j2meozBJI0I8BoeqPUAIkNSS5CHyl5dowjwZlD
         y9z6Xd6gEUZxJvKnHW1rNDcrmGBSYowWc7aSJzK5U2EF1fsIIGNBTqvYG9OQEyafPWdu
         YvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IGFlIYLsqW6F74U1ICzyYso+0owEPY2FrYOY2FAK1I0=;
        b=J89WcKELusuOl5/kRYKCqZor1XVtPJVtg/41pcN7f2cxor26fU1OBkdgEPbIMGyBp+
         xD7TnekiNlyJmrumEHLHojBPdrIyUy+yGaLi0vx8PclG1IapFaDqKwy1bIYxaYzRi6Tz
         CXwB2SMn3pwOcN0aOSTluwrQwxu+yau1wA0WkXOrt6xRfbUube0SWnPnRUxeUTVQWJOD
         cgG60Fl8ah0NtQSpAdd7csmMyu0JtEj+BbIRMUoFKzrpIc3MIsYlv/jVbTrVUxG9jODR
         dOgaEu9NsTKzp89AxF/pmMg3wqhR7vX0XQTDSvI+TDa2a6z5BFu+agBnYusdTgB/zx6H
         jCjg==
X-Gm-Message-State: APjAAAUqdVKhdltDVKSI4Ay0/EXZRzB0AF6rVHWL2GU5oBk3VhCms9OV
        jXwKdt4PmSl8nYs4Pj3WUhWaSXZHwcM=
X-Google-Smtp-Source: APXvYqynQd8XJO57qopMDEFJSrsYr2VEDUp9QNILPwZEeDB/w62WmebzvF/VCHV4ITy0EJWhyjR62A==
X-Received: by 2002:a5d:6b10:: with SMTP id v16mr20401862wrw.294.1554737747863;
        Mon, 08 Apr 2019 08:35:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-117-55.ip49.fastwebnet.it. [93.34.117.55])
        by smtp.gmail.com with ESMTPSA id f15sm36096647wru.21.2019.04.08.08.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:35:47 -0700 (PDT)
From:   Angelo Ruocco <angelo.ruocco.90@gmail.com>
X-Google-Original-From: Angelo Ruocco <angeloruocco90@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] block, bfq: fix some typos in comments
Date:   Mon,  8 Apr 2019 17:35:34 +0200
Message-Id: <20190408153534.6312-1-angeloruocco90@gmail.com>
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
index 2a74a3f2a8f7..793c027ca60e 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1103,7 +1103,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	},
 #endif /* CONFIG_DEBUG_BLK_CGROUP */
 
-	/* the same statictics which cover the bfqg and its descendants */
+	/* the same statistics which cover the bfqg and its descendants */
 	{
 		.name = "bfq.io_service_bytes_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ceb06abd73df..bcaa4bde3961 100644
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
@@ -441,7 +441,7 @@ void bfq_schedule_dispatch(struct bfq_data *bfqd)
 
 /*
  * Lifted from AS - choose which of rq1 and rq2 that is best served now.
- * We choose the request that is closesr to the head right now.  Distance
+ * We choose the request that is closer to the head right now.  Distance
  * behind the head is penalized and only allowed to a certain extent.
  */
 static struct request *bfq_choose_req(struct bfq_data *bfqd,
@@ -989,7 +989,7 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 	 *   of several files
 	 * mplayer took 23 seconds to start, if constantly weight-raised.
 	 *
-	 * As for higher values than that accomodating the above bad
+	 * As for higher values than that accommodating the above bad
 	 * scenario, tests show that higher values would often yield
 	 * the opposite of the desired result, i.e., would worsen
 	 * responsiveness by allowing non-interactive applications to
@@ -2636,8 +2636,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
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
@@ -3089,7 +3089,7 @@ static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	/*
 	 * All in-service entities must have been properly deactivated
 	 * or requeued before executing the next function, which
-	 * resets all in-service entites as no more in service.
+	 * resets all in-service entities as no more in service.
 	 */
 	__bfq_bfqd_reset_in_service(bfqd);
 }
@@ -5632,7 +5632,7 @@ static void bfq_prepare_request(struct request *rq, struct bio *bio)
  * preparation is that, after the prepare_request hook is invoked for
  * rq, rq may still be transformed into a request with no icq, i.e., a
  * request not associated with any queue. No bfq hook is invoked to
- * signal this tranformation. As a consequence, should these
+ * signal this transformation. As a consequence, should these
  * preparation operations be performed when the prepare_request hook
  * is invoked, and should rq be transformed one moment later, bfq
  * would end up in an inconsistent state, because it would have
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 60c148728cc5..e7dc07cf9a57 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -91,7 +91,7 @@ struct bfq_service_tree {
  * expiration. This peculiar definition allows for the following
  * optimization, not yet exploited: while a given entity is still in
  * service, we already know which is the best candidate for next
- * service among the other active entitities in the same parent
+ * service among the other active entities in the same parent
  * entity. We can then quickly compare the timestamps of the
  * in-service entity with those of such best candidate.
  *
@@ -142,7 +142,7 @@ struct bfq_weight_counter {
  *
  * Unless cgroups are used, the weight value is calculated from the
  * ioprio to export the same interface as CFQ.  When dealing with
- * ``well-behaved'' queues (i.e., queues that do not spend too much
+ * "well-behaved" queues (i.e., queues that do not spend too much
  * time to consume their budget and have true sequential behavior, and
  * when there are no external factors breaking anticipation) the
  * relative weights at each level of the cgroups hierarchy should be
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 51ef1f00df80..d2ea98ef26a3 100644
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

