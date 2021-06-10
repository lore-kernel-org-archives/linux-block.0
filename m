Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A4C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CB8613BD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJHYh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJHYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:24:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF07C061574;
        Thu, 10 Jun 2021 00:22:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ei4so3107366pjb.3;
        Thu, 10 Jun 2021 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=C5PEpeo0NMyXH9P6gG9NFBgzsAw8v516ubiOgloaYRFhpu4rjOGAfnUZEnOXenI2tV
         LKl4g77lfelBkZsnLU9FSP9mg/+2lv+vxRJoyi61Ig16hI6jZJVLggv+ixXW6pxIegi6
         bJdDZ4mJ2zRuIHyYPsZw35d2ROtqtwOnuEn4jhLb2hbVKb6K9U//q7eGv7Egb6jHK7EK
         z/r0hxBEPxNmvQOKY+cCnkMewZCj8Q/IKf5Uht18R1+TzMwLpFAe4c7/38eBMEVXXJM7
         FAtJ2nCzu2427nCTdjt7HCj8rjmtQ+sQHcP+EcedaNcjgrb5dZzfb+f3x9AWtBzWHUre
         h3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=ZHqIJE2fYdEBDcC2aLO5+p1b0hDewWKrkf7C1mFo6SF0LtwsG4LrFvvBtZDtyIwCqE
         pQS6tBylNXyaJujpzrMHHbUSO+xtmX93iZOB2A2UbI/besgOKe0fXyaQmAS4uwvBL3H9
         BwARrbEPpCTF88PhtZI5srdxoN63k/JeRq5cpBYGYsUlakKgAsaTA+ZuBUbfATYuWHcq
         pOti/ZxVhLtOt8WAuT2IU/vOpMh1cuUf/yP8JiqDIeKF7wHoGsGNznFT3KU37lNjWsEu
         TmUzBVXHiXuGXwOcQ2hWLbKxuTcpnwWwmvMRyneslyVTtTVNnFB7LTCd/hMW8P+yt/ZZ
         W5Gg==
X-Gm-Message-State: AOAM531tIksv1iKX4qbT4kMg3Kx/VJzWFkxChoyciiNTNIcL1iDEtkbq
        Dk0kPQR4Wh7NndzFxJHLelQ=
X-Google-Smtp-Source: ABdhPJwaapexTfjht5umCKz0SBc7uTgitqckUu0R1pWb7EJFAf0aHnk8aMsNgbZC9I0MF/UoqfHa3w==
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr1915783pjn.168.1623309760922;
        Thu, 10 Jun 2021 00:22:40 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:40 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper method
Date:   Thu, 10 Jun 2021 15:22:30 +0800
Message-ID: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072230.TAxxdh-wsL4sihK2TJxF-Gz85ZgsFR7IwOuifnxFi0k@z>

From: Chunguang Xu <brookxu@tencent.com>

Introduce bfq_entity_to_bfqg() to make it easier to obtain the
bfq_group corresponding to the entity.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c  |  6 ++----
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b791e20..a5f544a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 {
 	struct bfq_entity *group_entity = bfqq->entity.parent;
 
-	return group_entity ? container_of(group_entity, struct bfq_group,
-					   entity) :
+	return group_entity ? bfq_entity_to_bfqg(group_entity) :
 			      bfqq->bfqd->root_group;
 }
 
@@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	 */
 	entity = &bfqg->entity;
 	for_each_entity(entity) {
-		struct bfq_group *curr_bfqg = container_of(entity,
-						struct bfq_group, entity);
+		struct bfq_group *curr_bfqg = bfq_entity_to_bfqg(entity);
 		if (curr_bfqg != bfqd->root_group) {
 			parent = bfqg_parent(curr_bfqg);
 			if (!parent)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index b8e793c..a6f98e9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -941,6 +941,7 @@ struct bfq_group {
 #endif
 
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
 
 /* --------------- main algorithm interface ----------------- */
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 070e34a..5ff0028 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 	if (!group_entity)
 		group_entity = &bfqq->bfqd->root_group->entity;
 
-	return container_of(group_entity, struct bfq_group, entity);
+	return bfq_entity_to_bfqg(group_entity);
 }
 
 /*
@@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 	if (bfq_entity_to_bfqq(entity))
 		return true;
 
-	bfqg = container_of(entity, struct bfq_group, entity);
+	bfqg = bfq_entity_to_bfqg(entity);
 
 	/*
 	 * The field active_entities does not always contain the
@@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
 	return bfqq;
 }
 
+struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
+{
+	struct bfq_group *bfqg = NULL;
+
+	if (entity->my_sched_data)
+		bfqg = container_of(entity, struct bfq_group, entity);
+
+	return bfqg;
+}
 
 /**
  * bfq_delta - map service into the virtual time domain.
@@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
+		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
 
 		if (!entity->in_groups_with_pending_reqs) {
-- 
1.8.3.1

