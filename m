Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57791C10F14
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35C2133D
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yb84ElHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfDJIip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:38:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37615 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfDJIip (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:38:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so1871216wrm.4
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWd78AzbhQzEPASngzTuqEKi4n3YA2PuHkAQ/kL082I=;
        b=Yb84ElHiAi3ngZek3tuF3xo9EzqvPtaKktmLhWE+2RswltKfl0bJVRpRAjD3SHs8JN
         s/vaYMkFYP8CS7yMcR8TRLOxFRWD80DZbLSYtSPaWrCdkfZTGXWeuXG9I7vXJGxlWo/G
         iqymBJDbHlejFcEDTMOcJpYgh+dodSYGEk/R9iZhpX/P+YshbxcogGiIk/ARodvCPqUc
         zNG8Ser0pYit3dJLYpI/9tm5HYx5LZBDksBE7V5hne3HWRXcin97r1NUsORxYvp7uvL6
         MtDvdEr4fY5yAAmbovi5m9XN8JMMY+beFmkKttBpT0fX8SU5n+mQQwo0d7z/UqJPOJZ/
         Fkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWd78AzbhQzEPASngzTuqEKi4n3YA2PuHkAQ/kL082I=;
        b=MyhuvTxQLfJo7l1F0KgMtK8xLG9hSM3hNnJ+qWAiesEHKUWPXMRFTURyHqg6eRGTh9
         6SF9SZBBb/DLnN4BgTEYUjkt2p4DtJMsbhCQ3P+aipJ4wxe6vruoJbD27/LWMwwWOBuz
         mAS9Z8RFcgkGvXS1KvOz7QyhGwneirUCovylkEqehR4c/u4Sipq53XAG/fjPEqoWu+RB
         0MBtvWM3yOXPurp7QYtZOz63C7rCC7lc2mZ0Wt7QO+SPg283LslgYEOc9TIkbOltrjTK
         rnau5vBhjggnITjVgwQZYJqcX3hV68Xc4TdwOqD+2Wu1240MH5UZ/NrkPTiOnZTHDt3u
         dsLw==
X-Gm-Message-State: APjAAAW4CdPm9sYgFwVPW50nDKILUNmTgedLsUS1FxQyvODaspOH5vUL
        eS2JDuQlLwb67JYBTbrnyLWpaA==
X-Google-Smtp-Source: APXvYqzQWE9XG3hV0/IUzBfYlLZQRDQsJZPCCVb3mRDjYCN1SW0ugVGqSZ26/bOs8Dxy3XIoMO6R4Q==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr27983111wru.36.1554885523267;
        Wed, 10 Apr 2019 01:38:43 -0700 (PDT)
Received: from wifi-122_dhcprange-158.wifi.unimo.it ([155.185.122.158])
        by smtp.gmail.com with ESMTPSA id s10sm1859936wmh.0.2019.04.10.01.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:38:42 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH BUGFIX V2] block, bfq: fix use after free in bfq_bfqq_expire
Date:   Wed, 10 Apr 2019 10:38:33 +0200
Message-Id: <20190410083833.14462-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function bfq_bfqq_expire() invokes the function
__bfq_bfqq_expire(), and the latter may free the in-service bfq-queue.
If this happens, then no other instruction of bfq_bfqq_expire() must
be executed, or a use-after-free will occur.

Basing on the assumption that __bfq_bfqq_expire() invokes
bfq_put_queue() on the in-service bfq-queue exactly once, the queue is
assumed to be freed if its refcounter is equal to one right before
invoking __bfq_bfqq_expire().

But, since commit 9dee8b3b057e ("block, bfq: fix queue removal from
weights tree") this assumption is false. __bfq_bfqq_expire() may also
invoke bfq_weights_tree_remove() and, since commit 9dee8b3b057e
("block, bfq: fix queue removal from weights tree"), also
the latter function may invoke bfq_put_queue(). So __bfq_bfqq_expire()
may invoke bfq_put_queue() twice, and this is the actual case where
the in-service queue may happen to be freed.

To address this issue, this commit moves the check on the refcounter
of the queue right around the last bfq_put_queue() that may be invoked
on the queue.

Fixes: 9dee8b3b057e ("block, bfq: fix queue removal from weights tree")
Reported-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 15 +++++++--------
 block/bfq-iosched.h |  2 +-
 block/bfq-wf2q.c    | 17 +++++++++++++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fac188dd78fa..dfb8cb0af13a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2822,7 +2822,7 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 	bfq_remove_request(q, rq);
 }
 
-static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	/*
 	 * If this bfqq is shared between multiple processes, check
@@ -2855,9 +2855,11 @@ static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	/*
 	 * All in-service entities must have been properly deactivated
 	 * or requeued before executing the next function, which
-	 * resets all in-service entites as no more in service.
+	 * resets all in-service entities as no more in service. This
+	 * may cause bfqq to be freed. If this happens, the next
+	 * function returns true.
 	 */
-	__bfq_bfqd_reset_in_service(bfqd);
+	return __bfq_bfqd_reset_in_service(bfqd);
 }
 
 /**
@@ -3262,7 +3264,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	bool slow;
 	unsigned long delta = 0;
 	struct bfq_entity *entity = &bfqq->entity;
-	int ref;
 
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
@@ -3347,10 +3348,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * reason.
 	 */
 	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
-	ref = bfqq->ref;
-	__bfq_bfqq_expire(bfqd, bfqq);
-
-	if (ref == 1) /* bfqq is gone, no more actions on it */
+	if (__bfq_bfqq_expire(bfqd, bfqq))
+		/* bfqq is gone, no more actions on it */
 		return;
 
 	bfqq->injected_service = 0;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 062e1c4787f4..86394e503ca9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -995,7 +995,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity,
 			     bool ins_into_idle_tree);
 bool next_queue_may_preempt(struct bfq_data *bfqd);
 struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			 bool ins_into_idle_tree, bool expiration);
 void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index a11bef75483d..ae4d000ac0af 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1605,7 +1605,8 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	return bfqq;
 }
 
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+/* returns true if the in-service queue gets freed */
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 {
 	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
 	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
@@ -1629,8 +1630,20 @@ void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * service tree either, then release the service reference to
 	 * the queue it represents (taken with bfq_get_entity).
 	 */
-	if (!in_serv_entity->on_st)
+	if (!in_serv_entity->on_st) {
+		/*
+		 * If no process is referencing in_serv_bfqq any
+		 * longer, then the service reference may be the only
+		 * reference to the queue. If this is the case, then
+		 * bfqq gets freed here.
+		 */
+		int ref = in_serv_bfqq->ref;
 		bfq_put_queue(in_serv_bfqq);
+		if (ref == 1)
+			return true;
+	}
+
+	return false;
 }
 
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-- 
2.20.1

