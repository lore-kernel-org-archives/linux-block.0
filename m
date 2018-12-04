Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1074C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7620879
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF7620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeLDSgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44610 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeLDSgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id i22so7076156ywa.11;
        Tue, 04 Dec 2018 10:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxjzjhc/z3i9OP1/0jn9PSMXriok6T069SOawVrVZHE=;
        b=KA3G15Pa0wynr9Q1h4sz1Ay3dkOBiIEEXLB66IClXJdqXYq8bsRXgxHs6AUK9Bj4PX
         XApPtAFqMqE6TwYYkro/Bt+5id1ir8QncJqB+Jq8O/Gr/YHLNkqfJbAp/IHP5QRaFyPb
         cd/FLfqYbwdykRZ4SPna1+yvKFr7jiskUgwOL57szr/LRDBrXjVjo9Yw8vhYDZsxj55X
         CHNfJqudcA4pPIRYx02BJWnMx9KypZq2pjt6zn0SvvfyDhpTSQDBV93HI+0kNPCnbdup
         zZq0HNt9NMnDPsQJqcn1VPOpiYVwDyfMhYEyn1oy/Khg7HUI7AVmPIqenQxVL9M61Ydz
         DNew==
X-Gm-Message-State: AA+aEWbCLVRqRI3N7BbdF5jZ1QIBS6jVBJln03zv1Mv9PymPa5oiJLi1
        6weMDqN95HLAJ3R6GVB3CWc=
X-Google-Smtp-Source: AFSGD/X5iJFiO1VW31J5YEkCb0MI0jtkdz++CD8qkreKrQelfWiCrwKXzhBeAYXDAiZ8/0aIyXyiOA==
X-Received: by 2002:a81:73c4:: with SMTP id o187mr21130809ywc.361.1543948581015;
        Tue, 04 Dec 2018 10:36:21 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:20 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/14] blkcg: change blkg reference counting to use percpu_ref
Date:   Tue,  4 Dec 2018 13:35:59 -0500
Message-Id: <20181204183600.99746-14-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
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
index 120f2e2835fb..2ca7611fe274 100644
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
@@ -367,7 +404,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 }
 
 /**
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 68cae7961060..05909cf31ed1 100644
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

