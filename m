Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0FCC33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987592166E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1C+QSQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgBCKlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBCKlW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so5097442wrs.10
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYMuqQIhNyGIyUO9+d/0zXKDzQMWFHlzvVLFhG2VePE=;
        b=E1C+QSQPsVg+CtJO9tSTEG9fYUN/zU+R6egxRW0FaC3HLz9p91/p8AAuf21UCXDoia
         Jq4UaZQrd8V/sCaW+ddNEtPSYwrVudIferppaFXDsPXA21Qh+VBnMzJmjmDs/TFUmz+R
         12hkGYeylpGw3TXlDvX19TmM+7wuYERnnLUMpQik/bnma36ebJWgAaRDin7xUwf7rLdu
         CSmIOLjcgPva7uoTzDQQ7BRsUa62WOwxxUydZhr6h8ry1xvGGMT2XIK5v3nBSUqfQNch
         2Eof7TAoe5XQhTolIsPW1+8mf4JxgbZQ3nkG+l5oawRc+tkqzpG0hzlwIkYxFT/yJQ3i
         H4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYMuqQIhNyGIyUO9+d/0zXKDzQMWFHlzvVLFhG2VePE=;
        b=EGcjWbKZUA5AdH50eIsDamhN1WjMqksDHnmvPH7VVnCo6OSp+Ct/ZzMISJaDbxXAdI
         /a9CY5lxl8qRuC2Yb6tu8h7CqMKufF3w5SbtdFJ6KL2jfNaMD6gHsQJezpsmQVmkw7aX
         gHRIiFv5/tMYjXPtxhYCHo66cs348Zo13fMyq37a6UaQaIWxacCNLmxkRhK8dVn/+HLC
         +nhZapV/nNKjPbfYfYDpSlQVd7UKj5j5mT+Z0RP+f0xKHlExRlBxf7eDuwrmYgWFyjh/
         1Wv4PSddCxmBvqEsg6JSyqDuHl2eiiKT4eMWZPKzKEj0OLs5l7T+U3DnrIwGgsrD6pwY
         pWUg==
X-Gm-Message-State: APjAAAXCm6i8z7gMAYfaGjHkNhdefls/3SKKUkEzNYsS3qIMqyZP2jmt
        1OAPuaeEmih2lnop79rrCC9InQ==
X-Google-Smtp-Source: APXvYqwmdAOg8Ixp1iHiociJz/zeNxj1uqmFDGwjueLS0+Hn7nqgMfm+tHV+WbSgGza3ZT2mY5Mipg==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr14425809wrm.349.1580726480009;
        Mon, 03 Feb 2020 02:41:20 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:19 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 4/7] block, bfq: extend incomplete name of field on_st
Date:   Mon,  3 Feb 2020 11:40:57 +0100
Message-Id: <20200203104100.16965-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The flag on_st in the bfq_entity data structure is true if the entity
is on a service tree or is in service. Yet the name of the field,
confusingly, does not mention the second, very important case. Extend
the name to mention the second case too.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c |  2 +-
 block/bfq-iosched.h |  2 +-
 block/bfq-wf2q.c    | 11 +++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 8ab7f18ff8cb..c818c64766e5 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -659,7 +659,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
-	else if (entity->on_st)
+	else if (entity->on_st_or_in_serv)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
 	bfqg_and_blkg_put(bfqq_group(bfqq));
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 15dfb0844644..28770ec7c06f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1059,7 +1059,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st -
+	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st_or_in_serv -
 		(bfqq->weight_counter != NULL);
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 8526f20c53bc..f1cb89def7f8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -150,7 +150,7 @@ struct bfq_entity {
 	 * Flag, true if the entity is on a tree (either the active or
 	 * the idle one of its service_tree) or is in service.
 	 */
-	bool on_st;
+	bool on_st_or_in_serv;
 
 	/* B-WF2Q+ start and finish timestamps [sectors/weight] */
 	u64 start, finish;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index ffe9ce9faa89..26776bdbdf36 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -645,7 +645,7 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
-	entity->on_st = false;
+	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
 	if (bfqq && !is_in_service)
 		bfq_put_queue(bfqq);
@@ -999,7 +999,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		 */
 		bfq_get_entity(entity);
 
-		entity->on_st = true;
+		entity->on_st_or_in_serv = true;
 	}
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
@@ -1165,7 +1165,10 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 	struct bfq_service_tree *st;
 	bool is_in_service;
 
-	if (!entity->on_st) /* entity never activated, or already inactive */
+	if (!entity->on_st_or_in_serv) /*
+					* entity never activated, or
+					* already inactive
+					*/
 		return false;
 
 	/*
@@ -1620,7 +1623,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * service tree either, then release the service reference to
 	 * the queue it represents (taken with bfq_get_entity).
 	 */
-	if (!in_serv_entity->on_st) {
+	if (!in_serv_entity->on_st_or_in_serv) {
 		/*
 		 * If no process is referencing in_serv_bfqq any
 		 * longer, then the service reference may be the only
-- 
2.20.1

