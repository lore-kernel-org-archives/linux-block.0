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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD8C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8CA61414
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFJHZz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:25:55 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:36568 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhFJHZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:51 -0400
Received: by mail-pj1-f51.google.com with SMTP id d5-20020a17090ab305b02901675357c371so3209331pjr.1;
        Thu, 10 Jun 2021 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=W7KHjr39fzmJQi9Zt2knXhik0hSaJoZniPst+hezF7A=;
        b=VzyES56lNrpoggOLLH1ZQO9RRvq51IS6F50ZkFkvj3HAXeTwZfMnxRVYkoISwe75Ox
         h+q5wXFh25j8VB/ELuDiEdue68ONaLuH+q+pgy7FRJwLtEPHNK9zDrETV77TG5AXLauq
         CwGywjHERPPGheLDniBArWV9GbGKNwaXYe7trv/w9/xFVDTyLM9NGqXSn7HA6Sjl45nW
         FZXdnm9v5in0q9c5N6oGFM2gFTZvNat88HGKahZf0OsMArtgRBwyC/s84MGXahILwGax
         oAMwgxC57mBTYtrqwg9vQCChJ8UKHSN2P6TaFpmmJC97AEP15XqCGA5ZGxQPTz8FDu/0
         Z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=W7KHjr39fzmJQi9Zt2knXhik0hSaJoZniPst+hezF7A=;
        b=twq+vfGZlTWX/yh7lKfVjzojQaVCmn6IQDa7tHKulyyFys8Z5xhw1tENEa6j2eK9jn
         UN/flXTyFQd49LQ3ES0O0JpYmnDBfMXI8ttOe2TEWoNHEXV5Ls0tCr6QaUyzG2UwAkn6
         Rql45YQDYolgHg2zd4vuyPns8FqRZEZ5WRPy2+BU82lQnztOzXDCRImuj10iomfDmboD
         s1pwsBSv09Nl5xfLtBP16A2kzJybyEWfw/SmJZLp1fWooChoR1SNO9K9Bat2x5HVnze2
         IVmdf+Wx5EDLiOdDhGL97PAuF0r1l821ivbhs/KYGfRmV8FuCwtGMn9rvzAcPQp1KDgY
         qyhw==
X-Gm-Message-State: AOAM530zBy8zG2C9LjTGKNgIS3f/Aec8NPAQ8SLn3Tuqw1xj0PPiSoDF
        srkIQB74/x3GfdTN2b+tZ0YaWKjNTDpSoP1K
X-Google-Smtp-Source: ABdhPJzVMNrWXZaVSjlIsmw5GGg/jWHkpuo9bt3D2XGPxLUTdFcbckh+1thtLfUuD3cvgtUjzhY4XA==
X-Received: by 2002:a17:90a:16c2:: with SMTP id y2mr1928042pje.236.1623309764881;
        Thu, 10 Jun 2021 00:22:44 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:44 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 4/8] bfq: keep the minimun bandwidth for CLASS_BE
Date:   Thu, 10 Jun 2021 15:22:33 +0800
Message-ID: <49f0e733ab19bee96fce0bdd205366a5b0d3b51e.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072233.PYL1PUn_OqJ7je0WFh3xeaeTUOWNLXb9z9qDCgcu-CU@z>

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

