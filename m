Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C61C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAF220873
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAF220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeK0IPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:22 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38595 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0IPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:21 -0500
Received: by mail-yb1-f195.google.com with SMTP id u103-v6so8141658ybi.5;
        Mon, 26 Nov 2018 13:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZvs5OryDI6sX+Ah4z4QS3SeAhV6AtbGXkw3bMhIx54=;
        b=JNaUGzOsoZ6rO39laoaQ1Di0LIqYc6ErY4Uu8nRLvBeIx0CWmicfhVdKRAsvxXFS43
         D6cfOD+xFVFXqklcFw9wlqtAAzZkIT1NiOAQWVAZk3JcslsfcJXt3pzY0a9M65R3Kg/B
         /6dzhJUrC0pxhpFMhP6pov73qZmmf99WY3V5mFLmQa7kbcyYsG8JklXOtPpcuA2hOWaN
         cWtHhzJZw6THGy4nTkCcpjn3Gm7NVxx1KPFvbEMmHiLzwEJxYLedPVQ4wFLw/uMClf7n
         8ZPYo/op5t8P03JjVaZSsDlWd83OD3U6Hgk32akjVb2J6owgz3lsZnTOjgMjjCg+iXaW
         mBEw==
X-Gm-Message-State: AA+aEWZ/FqQNqElHyI4m4EP2MkdU56UC+T+fMsO9Rkr3N2L6wxVOBDGP
        m7VPDlmWVmNgu/t4rHus1WE=
X-Google-Smtp-Source: AFSGD/WxTuP+n6Gq7pFHcuhjx+Z4VrazRBz6tOgH1yOoSarGeBdgTdeesg2rXiUSQDhTlwtmpDnCWg==
X-Received: by 2002:a5b:1c3:: with SMTP id f3-v6mr25575767ybp.267.1543267194545;
        Mon, 26 Nov 2018 13:19:54 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:19:53 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/13] blkcg: update blkg_lookup_create() to do locking
Date:   Mon, 26 Nov 2018 16:19:35 -0500
Message-Id: <20181126211946.77067-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
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
 block/blk-cgroup.c         | 30 +++++++++++++++++++++++++++---
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h |  4 +++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 63d226a084cd..b1ec98eeeae0 100644
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
 
@@ -293,6 +293,30 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
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
+
+		blkg = __blkg_lookup_create(blkcg, q);
+
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
index db8214047486..49f399cfb0b6 100644
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

