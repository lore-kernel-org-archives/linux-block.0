Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96524C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3BC613B2
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhDTLVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhDTLVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72459C06138A;
        Tue, 20 Apr 2021 04:20:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v13so5905949ple.9;
        Tue, 20 Apr 2021 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=D2nrbqQXFOAlluD1rWc2pfvpP1MJP3G6tlvBCQbJhv7F1+eV5k8to7bL1cVMMed2Gv
         stpC6/tKQG1vfxYRV3jwhi534xyJY8vY7wXJmIORtuj0Y18a512UXYeoFz2ljPLVk0Y+
         H6YRwe5GfrkEO/wLu3avPYzuufGPPgSAk8E6CtcNM6yl/4cCDywBceM7Kwtlfaty5vRV
         VFj+vZiTK3aw4Ca7uS6F72ZshzYi7IigBpN7NfwZ2kYcuWMKIEZXxFzgM9TJE3TYLfA5
         7MlgVhSGw5dPGo0IJAjuDBal2uzzfzmSVNfeG/ZCtudiFVaWKXS1XNKHgSQi5yhkPDX8
         tRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k7foMZZRtisGPq+uUebUl4zeTE385Qk+YuiaUy6ZRfU=;
        b=M/uqVCWe0Gg0ZnlEtupM9P6nDgdyiJbMIL7VHJebuVS+BQ2bCxlABiMbwRD9ki9q8X
         EmO3xSxO4S7CKJUOKrwZDEr1lxQrKZ3knVRV4m9p0Dc+l6maobITofp9F200K9ExUhF8
         p3qcGft9kpY1nR8mQbqOADMRx39lxsQH1BJz0INgIqkfSSlz+TQH96zN9/p/FtcL+z4w
         m6FOHDtlgbGFdHfXQjxo4ORABtTgwh29MoV6UU8opE7AiMHvtcpQ1+S+4Bf2bWzvPkVK
         jPxMw9ttkifroC9KEgpR8ISBlB7xwx+J+VC7DEX5YZpKg9QJO3Va0PHbN68lcdaW8jif
         dXPA==
X-Gm-Message-State: AOAM532A0vLFxdyXD1u5rnBKiJQPfMBdZhk4I5Td17zeAH4kdpl+eZRR
        wD2FoNVWPySYG865D9/rnk0=
X-Google-Smtp-Source: ABdhPJxZNhoIPNDlDI7FoU69B1Xr9dXt5bHcXFunC4cDlh+IjfVASzfH1Ewj8o6B9/Yq+KAkEIjuKw==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr4444598pjb.114.1618917629065;
        Tue, 20 Apr 2021 04:20:29 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:28 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper method
Date:   Tue, 20 Apr 2021 19:20:18 +0800
Message-Id: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

