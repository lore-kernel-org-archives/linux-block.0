Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17DAC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644A02075B
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0kIOolM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDJI1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:27:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbfDJI1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:27:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1564331wml.1
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 01:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX9dSz/AtUZ52Tp2kC2tWYDeGDmBEkI/+RsqbAt06sQ=;
        b=G0kIOolMKYhh02MFYzgheBFwKwDXDSs9OqwbN4hvVkZQDMZgzfWji2bCQtJLh/Z/+u
         A5Wk6eJ7Kf7LTeQ36bNYKHtjQN3BAMsGpnFSOYwKmtdPUrxfaa1d9u70tyY750KrLmo0
         JTqa9XcElwSrBQYmLKzTfuvv3XVO+mRvWMU9nUH2tmJ5SiP15b8qUc86kFa73JXoerLF
         2o//ls8QofjNHUDqmtTBjHS4bz46nL2zia2GPw7paMOOzKb32onW5/jEVjQ0zRm4HP5U
         6yyicKdMElz8onp+I1tj4h1PdO6kx/mnq2ZA3g0z9F2TsVu88VZehxYxCA2ARB7AEc8v
         12QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XX9dSz/AtUZ52Tp2kC2tWYDeGDmBEkI/+RsqbAt06sQ=;
        b=mX2rIgLfYkTI0TrqI4Tw+CRw0mXJERHS1/6nxRxS8G0dbrxiDG8CcH/0TZO2qj74VW
         +OzRnzTdVZFgrrqjy1F8pJbJSu36pAOEWpP+pQXLMMN4y78KRr5GmgsOLIN5ewgxM9Ou
         EPt3eggYxLiNmM3c/JXPIxlHEXCVPy6qssiQ02u9S5tT0/okKBLSRskj6XKjcRULowtk
         EBVi8QWty4PlPAj+H1LQdygjQLK+hZkJNhkRJ9tiYg4kWSH+ysnu3S53pZdbnWGdqmDY
         9Q6DQSQnKvbAJsd809AEN7kHnD7GN3cxnGGH/a8Sgh5/rOBuQR974JDBrYC0eZfaypQC
         puHg==
X-Gm-Message-State: APjAAAW9tgISTEmrbCkVdqmQBJypKSAmLH62+iQEadQB/N981KPkzEWl
        7+exKL0xsFeReG2Y3yH/dNWkXA==
X-Google-Smtp-Source: APXvYqwl5phlBjVWWmZZs+rryyYgJ9REQaM7/AuykfJIXLP0N4nKSqMOafroPMqy6/fe0HIyqZZOMA==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr1780519wmc.32.1554884833651;
        Wed, 10 Apr 2019 01:27:13 -0700 (PDT)
Received: from wifi-122_dhcprange-158.wifi.unimo.it ([155.185.122.158])
        by smtp.gmail.com with ESMTPSA id y125sm2293921wmc.39.2019.04.10.01.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:27:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
        Dmitrii Tcvetkov <demfloro@demfloro.ru>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] block, bfq: fix use after free in bfq_bfqq_expire
Date:   Wed, 10 Apr 2019 10:26:46 +0200
Message-Id: <20190410082646.14221-1-paolo.valente@linaro.org>
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

But, since commit 9dee8b3b057e1 ("block, bfq: fix queue removal from
weights tree") this assumption is false. __bfq_bfqq_expire() may also
invoke bfq_weights_tree_remove() and, since commit 9dee8b3b057e1, also
the latter function may invoke bfq_put_queue(). So __bfq_bfqq_expire()
may invoke bfq_put_queue() twice, and this is the actual case where
the in-service queue may happen to be freed.

To address this issue, this commit moves the check on the refcounter
of the queue right around the last bfq_put_queue() that may be invoked
on the queue.

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
index fac188dd78fa..30b88ec7ad26 100644
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
+	 * resets all in-service entites as no more in service. This
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

