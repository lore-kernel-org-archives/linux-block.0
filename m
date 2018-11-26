Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E2C18E01
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6566E208E7
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6566E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeK0IPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:34 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38625 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeK0IPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:34 -0500
Received: by mail-yb1-f193.google.com with SMTP id u103-v6so8142025ybi.5;
        Mon, 26 Nov 2018 13:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e/cKSvoXENIAhoa19TSrbRY4emgj03U4D6lof0BcqW8=;
        b=NtUQfL5uUjgcbUiy761/cdc2GcFGpOCBU0CYG1aj5MAE/VV2j5VmqTuvNhHlnK4uLP
         elL/QjVp2cVU6EFRQwAAJITnQ/QWavOk8qRdV0IzCqibuMyO+qtW9DjxR/dYNAtQArrt
         k4g6EhjGhtmzeuTzWkn7yo2nZNlfeLZLE1m53mybopfkJD4f5mVKMLUjJIp9kROvsIM7
         bwNxvpN3C2yTxKwEj583n3anWOt7gUbRNLkUJ6P+kMAeU3gMWIQMHjdfLs2bWFhZ7ai4
         8pWETC9nnfHiIGaI1tgxA/n5tQ4/ASF+VJ3Tj1CX3a2wFJwflHXJEtF2BQ08WWrsapSa
         VMzQ==
X-Gm-Message-State: AA+aEWah0cafPswoyM/qgVgsdSAE+G55i02Djf2twiFASCJdziiW3ig9
        I6ssJEudm8ZAe3QKGzuVOs0=
X-Google-Smtp-Source: AFSGD/XpLN58mfwn3aimxKld6KTtEa8Q5lTChJGt3a3yEybimb2Wh3ncLZCGlzgWHcOjh1yjzXWpEA==
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr29538300ybd.420.1543267207301;
        Mon, 26 Nov 2018 13:20:07 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:20:06 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/13] blkcg: change blkg reference counting to use percpu_ref
Date:   Mon, 26 Nov 2018 16:19:45 -0500
Message-Id: <20181126211946.77067-13-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every bio is now associated with a blkg putting blkg_get, blkg_try_get,
and blkg_put on the hot path. Switch over the refcnt in blkg to use
percpu_ref.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 41 ++++++++++++++++++++++++++++++++++++--
 include/linux/blk-cgroup.h | 15 +++++---------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dfd984bbed27..64ce424a78fd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -81,6 +81,37 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+static void __blkg_release(struct rcu_head *rcu)
+{
+	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+
+	percpu_ref_exit(&blkg->refcnt);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	if (blkg->parent)
+		blkg_put(blkg->parent);
+
+	wb_congested_put(blkg->wb_congested);
+
+	blkg_free(blkg);
+}
+
+/*
+ * A group is RCU protected, but having an rcu lock does not mean that one
+ * can access all the fields of blkg and assume these are valid.  For
+ * example, don't try to follow throtl_data and request queue links.
+ *
+ * Having a reference to blkg under an rcu allows accesses to only values
+ * local to groups like group stats and group rate limits.
+ */
+static void blkg_release(struct percpu_ref *ref)
+{
+	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+
+	call_rcu(&blkg->rcu_head, __blkg_release);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -107,7 +138,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
-	atomic_set(&blkg->refcnt, 1);
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -207,6 +237,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
+	ret = percpu_ref_init(&blkg->refcnt, blkg_release, 0,
+			      GFP_NOWAIT | __GFP_NOWARN);
+	if (ret)
+		goto err_cancel_ref;
+
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -239,6 +274,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
+err_cancel_ref:
+	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
@@ -369,7 +406,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 }
 
 /**
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6f3bb5e82a57..fc23bb758566 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -123,7 +123,7 @@ struct blkcg_gq {
 	struct blkcg_gq			*parent;
 
 	/* reference count */
-	atomic_t			refcnt;
+	struct percpu_ref		refcnt;
 
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
@@ -486,8 +486,7 @@ static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
  */
 static inline void blkg_get(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	atomic_inc(&blkg->refcnt);
+	percpu_ref_get(&blkg->refcnt);
 }
 
 /**
@@ -499,7 +498,7 @@ static inline void blkg_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 {
-	if (atomic_inc_not_zero(&blkg->refcnt))
+	if (percpu_ref_tryget(&blkg->refcnt))
 		return blkg;
 	return NULL;
 }
@@ -513,23 +512,19 @@ static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
 {
-	while (!atomic_inc_not_zero(&blkg->refcnt))
+	while (!percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
 
 	return blkg;
 }
 
-void __blkg_release_rcu(struct rcu_head *rcu);
-
 /**
  * blkg_put - put a blkg reference
  * @blkg: blkg to put
  */
 static inline void blkg_put(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	if (atomic_dec_and_test(&blkg->refcnt))
-		call_rcu(&blkg->rcu_head, __blkg_release_rcu);
+	percpu_ref_put(&blkg->refcnt);
 }
 
 /**
-- 
2.17.1

