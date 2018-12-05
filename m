Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2284C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E2C20892
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029934;
	bh=PV0Ye61K9NoS9k9IIjsbZfy0cYxZkqxIPextWCERfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpNEV+nnepEZMbA49dgWLVRhEcPqQo8iB/KwTREcC+IubmgqxDziZfUhRnv24Zz8F
	 UkKcoUqhHmrhFTCrzLTD074q4WEeLxqXK0wx8TCX5D8jP12Lm4VQEq+1NFbC3o2Jbz
	 CE6ghbrYZJlApur+Xex3dF7Ic6IhMtEf1YTmxMfQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E2C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeLERMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:12:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37034 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLERKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so23112412qtq.4;
        Wed, 05 Dec 2018 09:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vqrnr706mxcuTBSv4fGe89XMxxRx6O2pZFhgxbxRlLY=;
        b=HJ2K4OG/kp6nh2SaNx8R/HNPKcZq8FZ5zTc8WUfLbHQIum2mAaKZJMkGza5D4kHkhw
         R0YbNxnuNRpewUYG+QpVgLXBa6YV+GM7VP+oPObVfN8nC8dJ7DYxhTJEzCisJZ2p0/Ax
         ShBh1nYdhbpmD+M7s1ljX5xrxAkBiuMS82D6iAgukkG05wuBfAnCO48abUYJZjhVYBlR
         qHOUmXsCzJVGsl0z/yF+5UUEuKgEFnoYu5/luDYhxOXvIP8NY8HJcMXA/uFGDo7LpgVL
         tPRtu9Alo843zh4ZQs7uLmi0mAXEaCMSRBmSWKhu/hGgG9KlfJ4P04GdXjtJpK/b471t
         01Mw==
X-Gm-Message-State: AA+aEWZy/C60p0rHDEQ3RnGcT8euMv5Ak4vf5/+9yQJXjy92VbCsH+Nu
        fA6lLLBWpUX1ITSZP7gtGFc=
X-Google-Smtp-Source: AFSGD/WOSiMR10JJCNI2QTdk+x4OzqvdnpvqKVPv63Kof9/sukSLAOXqBa4IB+5YO35skc7xUOtFCw==
X-Received: by 2002:aed:3e49:: with SMTP id m9mr22360105qtf.99.1544029845858;
        Wed, 05 Dec 2018 09:10:45 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:44 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/14] blkcg: update blkg_lookup_create() to do locking
Date:   Wed,  5 Dec 2018 12:10:27 -0500
Message-Id: <20181205171039.73066-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To know when to create a blkg, the general pattern is to do a
blkg_lookup() and if that fails, lock and do the lookup again, and if
that fails finally create. It doesn't make much sense for everyone who
wants to do creation to write this themselves.

This changes blkg_lookup_create() to do locking and implement this
pattern. The old blkg_lookup_create() is renamed to
__blkg_lookup_create().  If a call site wants to do its own error
handling or already owns the queue lock, they can use
__blkg_lookup_create(). This will be used in upcoming patches.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-cgroup.c         | 28 +++++++++++++++++++++++++---
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h |  4 +++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 63d226a084cd..b421a9457e05 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -249,7 +249,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 }
 
 /**
- * blkg_lookup_create - lookup blkg, try to create one if not there
+ * __blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
  *
@@ -262,8 +262,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
  * dead and bypassing, returns ERR_PTR(-EBUSY).
  */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
@@ -293,6 +293,28 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	}
 }
 
+/**
+ * blkg_lookup_create - find or create a blkg
+ * @blkcg: target block cgroup
+ * @q: target request_queue
+ *
+ * This looks up or creates the blkg representing the unique pair
+ * of the blkcg and the request_queue.
+ */
+struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+				    struct request_queue *q)
+{
+	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
+
+	if (unlikely(!blkg)) {
+		spin_lock_irq(&q->queue_lock);
+		blkg = __blkg_lookup_create(blkcg, q);
+		spin_unlock_irq(&q->queue_lock);
+	}
+
+	return blkg;
+}
+
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fe0c4ca312ff..e6f68f15dee9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -486,7 +486,7 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(&q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(&q->queue_lock);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f619307171a6..b3b1a8187d23 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -181,6 +181,8 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q);
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
@@ -799,7 +801,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(&q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(&q->queue_lock);
-- 
2.17.1

