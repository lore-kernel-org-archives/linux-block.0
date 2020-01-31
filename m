Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C316C33CB7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BC21734
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEc5i+wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgAaJZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:25:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52122 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgAaJZC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:25:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so7095515wmi.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYMuqQIhNyGIyUO9+d/0zXKDzQMWFHlzvVLFhG2VePE=;
        b=WEc5i+wMCiAyLuk0tSUYxfVp66mFw8A7FGbPTItb8JCJX8wGBEY81gDxK9JNBsW+Hc
         hhyQtR6a7WYFoSrkKUat+wBmuKUegtsjerK2gqF79tbjgYCJ9rIrHvwUklvZx2U5b6Gs
         tHZRxWq+df3pKHA/3FNK87d0wzzLoChmf5Q51517VgVC2noembzyD1zVCJrshupZRJZQ
         EcNP6zW7NmeT5lGlA9dgFjIqXgeMp38ymYFXv6bk8pCWgyOS9NieRF0Hik3Gr6ivNWrC
         AEcYPvW68s9NDVXoKNqBAA8zunGXTmO7xxb6qreV7M6reHq9uyE05zY2gns/vZ5pVVdX
         F76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYMuqQIhNyGIyUO9+d/0zXKDzQMWFHlzvVLFhG2VePE=;
        b=t99v19VXZL3GGfbeQLMkhAB3MrYekEyqk9dfMa4A3oqnYhAaO6YjhXgV+LQhb/O4HO
         MW5cx429Rnzk6+eH2gnQiKE+fXiigNii+qXssGmLmd4l0jJP5C0BrIzQnYpLd5fgVuZW
         kdO1IuARbOXW8fM59FJxW6GJW24yfI6LQtUlVL1zTmvd5b3kMJfUpJGAy1T43WsKabsk
         vmOMDY4k9WSL0k9ewHXQqMxomv8NUSNDr7kY4SoXm2wFGchdifak6EoNl2s3fiPbT1/m
         8zk+Iep4mKCF3tIWUs90JdAI+OFGu4x2yhlr2H24DsZCXlsTQ59AeoR6LlXgtUE0JqyQ
         IyKg==
X-Gm-Message-State: APjAAAUp7aMyexQ5kJsrxxILHhIQP1WtYbVsidC5Y1Jm+cqxXbWuEGhC
        u/2IK1a+j2KlMV1t0liYls1fug==
X-Google-Smtp-Source: APXvYqwAzr3TIiTKUwDgtKvzj4Ik3+GCPAkjxsrEqUp6NEGoz0CfTNgDeLNnEFSoxKU74ROWUheixw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr11661261wmc.185.1580462700684;
        Fri, 31 Jan 2020 01:25:00 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:59 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 4/6] block, bfq: extend incomplete name of field on_st
Date:   Fri, 31 Jan 2020 10:24:07 +0100
Message-Id: <20200131092409.10867-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
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

