Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B63C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27322082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029928;
	bh=e2eu5TDr0GAyWXXRAx3DWCaTINwE7/ZPbAhknob+H1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QmEKprYTDpG12ls2TALD6qKL0oeYKyTXm5S+Ea5TiemwMwiR076DA5w+r56qttHx2
	 S6Z/N/Md5cR8fFOQ0DGWJUxL0jfRdvY61nJ061C7zSMCKkKxo7cwd3kYkBI71gev68
	 /Zfg/woBAZuoS+qAGhkCUZo1zeP4kTa6x4G5p+HM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27322082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeLERKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:10:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLERKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so23078246qtj.10;
        Wed, 05 Dec 2018 09:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dIIma/pfNdUO5AJrdqMesuuSId8DEOFyxBmhzG2OYRk=;
        b=TzfXAknHeZrk6e+aTQK6fa0oYA1Z4TqyJyAhOFLcR6o5G7TqyGcfd7gi8RliLT859C
         4Kss94wLFFR2tx90rYRG3WdWuzv/TIGjvMl/+0ECxRBcscdIvwTOm5NHkUqK/ZnkHMgN
         db5V1cUV7cKeii2JC1EWutgEoCuwcnPainzbtslxQF6fJ4yWbqENCbW0c4BkDzHk2WqO
         +EAJfpWd8Bi3VswkwkY94wKOMH+j4f+NjdolcSZvk/jexzAnXMHouiN6roSKHNh/lMMr
         qyoeQXvbjwFufQapJV6rwtywsrz4BxYmD/CACmUgFVwKoXT89b2d62Ry8Q0xWBGB3CW+
         3ssQ==
X-Gm-Message-State: AA+aEWaIxvx6P+6N4fK7aJycpdeBswhwxyDHPYrJ9KT9Qjzjl3XSdmwq
        /xAjjWR4/2sV5nfElyeCejHR9yQu2Wo=
X-Google-Smtp-Source: AFSGD/XhjaLkq2BBiNLvZxbgnUOgA4KP6AhhFZhTDpZB24e2ovQ16SjKHD7WXqUTwHuIlxGwFUtDYA==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr23478743qtg.326.1544029844323;
        Wed, 05 Dec 2018 09:10:44 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:43 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 01/14] blkcg: fix ref count issue with bio_blkcg() using task_css
Date:   Wed,  5 Dec 2018 12:10:26 -0500
Message-Id: <20181205171039.73066-2-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio_blkcg() function turns out to be inconsistent and consequently
dangerous to use. The first part returns a blkcg where a reference is
owned by the bio meaning it does not need to be rcu protected. However,
the third case, the last line, is problematic:

	return css_to_blkcg(task_css(current, io_cgrp_id));

This can race against task migration and the cgroup dying. It is also
semantically different as it must be called rcu protected and is
susceptible to failure when trying to get a reference to it.

This patch adds association ahead of calling bio_blkcg() rather than
after. This makes association a required and explicit step along the
code paths for calling bio_blkcg(). In blk-iolatency, association is
moved above the bio_blkcg() call to ensure it will not return %NULL.

BFQ uses the old bio_blkcg() function, but I do not want to address it
in this series due to the complexity. I have created a private version
documenting the inconsistency and noting not to use it.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bfq-cgroup.c         |  4 +-
 block/bfq-iosched.c        |  2 +-
 block/bio.c                | 10 +++-
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h | 98 ++++++++++++++++++++++++++++++++++----
 5 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a7a1712632b0..c6113af31960 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -642,7 +642,7 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	uint64_t serial_nr;
 
 	rcu_read_lock();
-	serial_nr = bio_blkcg(bio)->css.serial_nr;
+	serial_nr = __bio_blkcg(bio)->css.serial_nr;
 
 	/*
 	 * Check whether blkcg has changed.  The condition may trigger
@@ -651,7 +651,7 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
 		goto out;
 
-	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
+	bfqg = __bfq_bic_change_cgroup(bfqd, bic, __bio_blkcg(bio));
 	/*
 	 * Update blkg_path for bfq_log_* functions. We cache this
 	 * path, and update it here, for the following
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 67b22c924aee..3d1f319fe977 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4384,7 +4384,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	rcu_read_lock();
 
-	bfqg = bfq_find_set_group(bfqd, bio_blkcg(bio));
+	bfqg = bfq_find_set_group(bfqd, __bio_blkcg(bio));
 	if (!bfqg) {
 		bfqq = &bfqd->oom_bfqq;
 		goto out;
diff --git a/block/bio.c b/block/bio.c
index 03895cc0d74a..346a7f5cb2dd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1990,13 +1990,19 @@ int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
  *
  * This function takes an extra reference of @blkcg_css which will be put
  * when @bio is released.  The caller must own @bio and is responsible for
- * synchronizing calls to this function.
+ * synchronizing calls to this function.  If @blkcg_css is %NULL, a call to
+ * blkcg_get_css() finds the current css from the kthread or task.
  */
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 {
 	if (unlikely(bio->bi_css))
 		return -EBUSY;
-	css_get(blkcg_css);
+
+	if (blkcg_css)
+		css_get(blkcg_css);
+	else
+		blkcg_css = blkcg_get_css();
+
 	bio->bi_css = blkcg_css;
 	return 0;
 }
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 5f7f1773be61..fe0c4ca312ff 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -481,8 +481,8 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 		return;
 
 	rcu_read_lock();
+	bio_associate_blkcg(bio, NULL);
 	blkcg = bio_blkcg(bio);
-	bio_associate_blkcg(bio, &blkcg->css);
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(&q->queue_lock);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a9e2e2037129..f619307171a6 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -227,22 +227,103 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
+/**
+ * blkcg_css - find the current css
+ *
+ * Find the css associated with either the kthread or the current task.
+ * This may return a dying css, so it is up to the caller to use tryget logic
+ * to confirm it is alive and well.
+ */
+static inline struct cgroup_subsys_state *blkcg_css(void)
+{
+	struct cgroup_subsys_state *css;
+
+	css = kthread_blkcg();
+	if (css)
+		return css;
+	return task_css(current, io_cgrp_id);
+}
+
+/**
+ * blkcg_get_css - find and get a reference to the css
+ *
+ * Find the css associated with either the kthread or the current task.
+ * This takes a reference on the blkcg which will need to be managed by the
+ * caller.
+ */
+static inline struct cgroup_subsys_state *blkcg_get_css(void)
+{
+	struct cgroup_subsys_state *css;
+
+	rcu_read_lock();
+
+	css = kthread_blkcg();
+	if (css) {
+		css_get(css);
+	} else {
+		/*
+		 * This is a bit complicated.  It is possible task_css() is
+		 * seeing an old css pointer here.  This is caused by the
+		 * current thread migrating away from this cgroup and this
+		 * cgroup dying.  css_tryget() will fail when trying to take a
+		 * ref on a cgroup that's ref count has hit 0.
+		 *
+		 * Therefore, if it does fail, this means current must have
+		 * been swapped away already and this is waiting for it to
+		 * propagate on the polling cpu.  Hence the use of cpu_relax().
+		 */
+		while (true) {
+			css = task_css(current, io_cgrp_id);
+			if (likely(css_tryget(css)))
+				break;
+			cpu_relax();
+		}
+	}
+
+	rcu_read_unlock();
+
+	return css;
+}
 
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct blkcg, css) : NULL;
 }
 
-static inline struct blkcg *bio_blkcg(struct bio *bio)
+/**
+ * __bio_blkcg - internal, inconsistent version to get blkcg
+ *
+ * DO NOT USE.
+ * This function is inconsistent and consequently is dangerous to use.  The
+ * first part of the function returns a blkcg where a reference is owned by the
+ * bio.  This means it does not need to be rcu protected as it cannot go away
+ * with the bio owning a reference to it.  However, the latter potentially gets
+ * it from task_css().  This can race against task migration and the cgroup
+ * dying.  It is also semantically different as it must be called rcu protected
+ * and is susceptible to failure when trying to get a reference to it.
+ * Therefore, it is not ok to assume that *_get() will always succeed on the
+ * blkcg returned here.
+ */
+static inline struct blkcg *__bio_blkcg(struct bio *bio)
 {
-	struct cgroup_subsys_state *css;
+	if (bio && bio->bi_css)
+		return css_to_blkcg(bio->bi_css);
+	return css_to_blkcg(blkcg_css());
+}
 
+/**
+ * bio_blkcg - grab the blkcg associated with a bio
+ * @bio: target bio
+ *
+ * This returns the blkcg associated with a bio, %NULL if not associated.
+ * Callers are expected to either handle %NULL or know association has been
+ * done prior to calling this.
+ */
+static inline struct blkcg *bio_blkcg(struct bio *bio)
+{
 	if (bio && bio->bi_css)
 		return css_to_blkcg(bio->bi_css);
-	css = kthread_blkcg();
-	if (css)
-		return css_to_blkcg(css);
-	return css_to_blkcg(task_css(current, io_cgrp_id));
+	return NULL;
 }
 
 static inline bool blk_cgroup_congested(void)
@@ -710,10 +791,10 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	bool throtl = false;
 
 	rcu_read_lock();
-	blkcg = bio_blkcg(bio);
 
 	/* associate blkcg if bio hasn't attached one */
-	bio_associate_blkcg(bio, &blkcg->css);
+	bio_associate_blkcg(bio, NULL);
+	blkcg = bio_blkcg(bio);
 
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
@@ -835,6 +916,7 @@ static inline int blkcg_activate_policy(struct request_queue *q,
 static inline void blkcg_deactivate_policy(struct request_queue *q,
 					   const struct blkcg_policy *pol) { }
 
+static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
 static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
-- 
2.17.1

