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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76952C43461
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BFE613AF
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 11:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhDTLVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhDTLVG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B088C06174A;
        Tue, 20 Apr 2021 04:20:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so26385731pgh.7;
        Tue, 20 Apr 2021 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=W7KHjr39fzmJQi9Zt2knXhik0hSaJoZniPst+hezF7A=;
        b=pXt/uZII9z+7uXstbIUjfVXNrD30zz4nBJP7rCLOVoMCmcvScgZlqVqQ4Na9p3r5Ko
         TsWRNykOJPMzbD1K9Hs3FhQHhn9u0A3UUADANdTlAPZ+d8xZvM1WgEsfCPcwBXRgXueB
         IaNwbmQrXKNOfIJe+wwNmo3xp3rIl8FirTGMkDneQcunLuHY9s40SJ0F9l9mLblZYTWb
         HbQOxgZay0x0+pOCk/rqA4NqmZi9mcfwSnqsnmYErHHj3PezNt9xUSJNazlSdZxrD48G
         kEfhHY/cTDlyGzgzinodps0MvOZRrZKaHK2GOk1+oJXwQfEa0Lt/uvtG6spGXod9c0Nn
         OOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=W7KHjr39fzmJQi9Zt2knXhik0hSaJoZniPst+hezF7A=;
        b=JGEoaTXXPidUw+QQbdYxiT1x9yiK2OPTjG3TmyzX7+QmRjjElIQ+EZkOwKaPxIeefl
         E9nmE1tyHTmVJGmPr0wjR4/5OASoAyjaAAfvkOGtpeZuAsZpBlDSyvOMEhAhtYzNYhDi
         l8NqrKF2doSBt/JmrWVdEFN4he/SOilu6c29evjFt4SckbpXoyKsz+/su1YDSQtzGEdl
         pIq2+fDxZicLjB+NtLcLGm7OO5QUct5eYptErbZh/ac1aqxqfKVL3ePZGxixgGssobnG
         kn2M2A6l+66a/ZYQ/mkmXIEcQByYVW5qfI/a8f9uXFORSdgI7wouleW+chG7QD6LGH41
         SMbA==
X-Gm-Message-State: AOAM532rOeNQ1lIGVRKR1UEPZDEuPAt1JXxPn885JNN8vgIzAecHK59d
        sH+oxuIB7+MqxMo9iyR/6f4=
X-Google-Smtp-Source: ABdhPJyHa0dUDC5Q8QhNMbkBKKe7e7D36fT9U87newfq0vrTeLzGMi86avVClnVwtrNxJ9iVUMKxDg==
X-Received: by 2002:a63:e13:: with SMTP id d19mr10434472pgl.36.1618917633780;
        Tue, 20 Apr 2021 04:20:33 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:33 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] bfq: keep the minimun bandwidth for CLASS_BE
Date:   Tue, 20 Apr 2021 19:20:21 +0800
Message-Id: <49f0e733ab19bee96fce0bdd205366a5b0d3b51e.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

CLASS_RT will preempt other classes, which may starve. At
present, CLASS_IDLE has alleviated the starvation problem
through the minimum bandwidth mechanism. Similarly, we
should do the same for CLASS_BE.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c |  6 ++++--
 block/bfq-iosched.h | 11 ++++++----
 block/bfq-wf2q.c    | 59 ++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 29940ec..89d4646 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6537,9 +6537,11 @@ static void bfq_init_root_group(struct bfq_group *root_group,
 	root_group->bfqd = bfqd;
 #endif
 	root_group->rq_pos_tree = RB_ROOT;
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
 		root_group->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-	root_group->sched_data.bfq_class_idle_last_service = jiffies;
+		root_group->sched_data.bfq_class_last_service[i] = jiffies;
+	}
+	root_group->sched_data.class_timeout_last_check = jiffies;
 }
 
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 28d8590..da636a8 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -13,7 +13,7 @@
 #include "blk-cgroup-rwstat.h"
 
 #define BFQ_IOPRIO_CLASSES	3
-#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
+#define BFQ_CLASS_TIMEOUT	(HZ/5)
 
 #define BFQ_MIN_WEIGHT			1
 #define BFQ_MAX_WEIGHT			1000
@@ -97,9 +97,12 @@ struct bfq_sched_data {
 	struct bfq_entity *next_in_service;
 	/* array of service trees, one per ioprio_class */
 	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
-	/* last time CLASS_IDLE was served */
-	unsigned long bfq_class_idle_last_service;
-
+	/* last time the class was served */
+	unsigned long bfq_class_last_service[BFQ_IOPRIO_CLASSES];
+	/* last time class timeout was checked */
+	unsigned long class_timeout_last_check;
+	/* next index to check class timeout */
+	unsigned int next_class_index;
 };
 
 /**
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 276f225..619ed21 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1168,6 +1168,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_service_tree *st;
+	int idx = bfq_class_idx(entity);
 	bool is_in_service;
 
 	if (!entity->on_st_or_in_serv) /*
@@ -1207,6 +1208,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
 	else
 		bfq_idle_insert(st, entity);
 
+	sd->bfq_class_last_service[idx] = jiffies;
 	return true;
 }
 
@@ -1435,6 +1437,45 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
 	return entity;
 }
 
+static int bfq_select_next_class(struct bfq_sched_data *sd)
+{
+	struct bfq_service_tree *st = sd->service_tree;
+	unsigned long last_check, last_serve;
+	int i, class_idx, next_class = 0;
+	bool found = false;
+
+	/*
+	 * we needed to guarantee a minimum bandwidth for each class (if
+	 * there is some active entity in this class). This should also
+	 * mitigate priority-inversion problems in case a low priority
+	 * task is holding file system resources.
+	 */
+	last_check = sd->class_timeout_last_check;
+	if (time_is_after_jiffies(last_check + BFQ_CLASS_TIMEOUT))
+		return next_class;
+
+	sd->class_timeout_last_check = jiffies;
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
+		class_idx = (sd->next_class_index + i) % BFQ_IOPRIO_CLASSES;
+		last_serve = sd->bfq_class_last_service[class_idx];
+
+		if (time_is_after_jiffies(last_serve + BFQ_CLASS_TIMEOUT))
+			continue;
+
+		if (!RB_EMPTY_ROOT(&(st + class_idx)->active)) {
+			if (found)
+				continue;
+
+			next_class = class_idx++;
+			class_idx %= BFQ_IOPRIO_CLASSES;
+			sd->next_class_index = class_idx;
+			found = true;
+		}
+		sd->bfq_class_last_service[class_idx] = jiffies;
+	}
+	return next_class;
+}
+
 /**
  * bfq_lookup_next_entity - return the first eligible entity in @sd.
  * @sd: the sched_data.
@@ -1448,24 +1489,8 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 						 bool expiration)
 {
 	struct bfq_service_tree *st = sd->service_tree;
-	struct bfq_service_tree *idle_class_st = st + (BFQ_IOPRIO_CLASSES - 1);
 	struct bfq_entity *entity = NULL;
-	int class_idx = 0;
-
-	/*
-	 * Choose from idle class, if needed to guarantee a minimum
-	 * bandwidth to this class (and if there is some active entity
-	 * in idle class). This should also mitigate
-	 * priority-inversion problems in case a low priority task is
-	 * holding file system resources.
-	 */
-	if (time_is_before_jiffies(sd->bfq_class_idle_last_service +
-				   BFQ_CL_IDLE_TIMEOUT)) {
-		if (!RB_EMPTY_ROOT(&idle_class_st->active))
-			class_idx = BFQ_IOPRIO_CLASSES - 1;
-		/* About to be served if backlogged, or not yet backlogged */
-		sd->bfq_class_idle_last_service = jiffies;
-	}
+	int class_idx = bfq_select_next_class(sd);
 
 	/*
 	 * Find the next entity to serve for the highest-priority
-- 
1.8.3.1

