Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B197C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0678620840
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563989723;
	bh=qxfrAz/oCN+LYLiWGVCs207H4awBoTJEDskVIhTJOdw=;
	h=Date:From:Cc:Subject:To:List-ID:From;
	b=yTVrHNsaqnbWsL7Xr+JlL/S/FB0v/6IX8Ak9qCqzigfdOd0ts/SabgvP0uADbrNV1
	 +QBBzxKx5ygWgAnfbt0SnIR1ONyyf+DaOeoVF2ouwJDGx4MXA3MO2AauFQyJuGZFch
	 6025yMdewplq0TXT6qy0yuofAuQjU/rqpkMV0S9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfGXRfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:35:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37205 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGXRfV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 13:35:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so21295889pfa.4;
        Wed, 24 Jul 2019 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8RQRpxikwiuWC4OpfiWsZAC2vrJJElg4wu6sWoYszZI=;
        b=sOJfZ06V7ejN/9i8fpp/cdoSscwWicyjRlh+pMD/TjNdnQ2HDBoCFeUSamK4uoEdC7
         m0lC6463xWV5YcFl7FPoJFwI6gysOkof2xy4mt9ueCdaFm9A98ZTOOPFk+f4UcJFcYXs
         H9ECm1szgWP/LyFYg6KnD2wHRINDmmBtRrTwdzrqtjaLDY53avYI/rVZUuUdRyuzpO3y
         VbxTnsjlRlE1IC/bXPtSI+S2szVuwcx9RzcaR1njXKRwypROI56kpBDNmlEGGlb/tqrz
         SGJGby9iJ0eT4Q8D6m0l3RksHwVqhUtabu28+7DINMeGOSH8sDoH7hGMem7r7d1Q4GrH
         cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=8RQRpxikwiuWC4OpfiWsZAC2vrJJElg4wu6sWoYszZI=;
        b=MAhY6yP5sHmQSmCFiiAtSWZzQuT/v0QqDEAmO88ojfFYUwI8G7GF2B0MTb7/3yaM5l
         Z9fuSnaXMPxfFTYlRvSvGD6Cd2IgVuTy6CCw9wWYuOorxYUq6CwRW/PHdDsJn9DI+rSI
         wWTvgve2sWE1rPvC9Kd42K96zJRJW/wJLIp/fPGcBPMhZvWkFA42TGAFRYne599jEoTM
         LwrUaClBhmPPPHlkLgFzkuD54GkWhd0Y10sQzdrNaIrnt9QeKKKGgaRPepxRDzgUePiE
         Q7mX/TsCxuMOitXjPhCp0dBfzOoV8rc2kmFCyJ3KjAXAvMRttepstZ3cEypNi2VHkx8M
         PkKg==
X-Gm-Message-State: APjAAAV9uNRMjJWva80MleXGmAuTjGeaxBbVRFa4juCmlik4W69JiV/S
        rIAI/dSfEuHaygrZJzEe11STI1JL
X-Google-Smtp-Source: APXvYqy/45xbVWCxW+UkluVuSTVF+aqyq3asyDnKB4CgboplhcFJTPArsIlNrywOkJTzGkKNPyk3Vw==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr90862845pje.71.1563989720109;
        Wed, 24 Jul 2019 10:35:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c91a])
        by smtp.gmail.com with ESMTPSA id l25sm57901670pff.143.2019.07.24.10.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:35:19 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:35:17 -0700
From:   Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] blkcg: rename blkcg->cgwb_refcnt to ->online_pin and
 always use it
Message-ID: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg->cgwb_refcnt is used to delay blkcg offlining so that blkgs
don't get offlined while there are active cgwbs on them.  However, it
ends up making offlining unordered sometimes causing parents to be
offlined before children.

To fix it, we want child blkcgs to pin the parents' online states
turning the refcnt into a more generic online pinning mechanism.

In prepartion,

* blkcg->cgwb_refcnt -> blkcg->online_pin
* blkcg_cgwb_get/put() -> blkcg_pin/unpin_online()
* Take them out of CONFIG_CGROUP_WRITEBACK

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

The asynchronous blkcg offlining can break offline ordering.  This
doesn't affect any of in-kernel users but it broke an assumption that
the pending io.cost controller was making and is generally nasty.
These two patches fix the offlining ordering by making children pin
parents.

Thanks.

 block/blk-cgroup.c         |    6 +++---
 include/linux/blk-cgroup.h |   39 +++++++++++++--------------------------
 mm/backing-dev.c           |    6 +++---
 3 files changed, 19 insertions(+), 32 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1035,8 +1035,8 @@ static void blkcg_css_offline(struct cgr
 	/* this prevents anyone from attaching or migrating to this blkcg */
 	wb_blkcg_offline(blkcg);
 
-	/* put the base cgwb reference allowing step 2 to be triggered */
-	blkcg_cgwb_put(blkcg);
+	/* put the base online pin allowing step 2 to be triggered */
+	blkcg_unpin_online(blkcg);
 }
 
 /**
@@ -1135,11 +1135,11 @@ blkcg_css_alloc(struct cgroup_subsys_sta
 	}
 
 	spin_lock_init(&blkcg->lock);
+	refcount_set(&blkcg->online_pin, 1);
 	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT | __GFP_NOWARN);
 	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
-	refcount_set(&blkcg->cgwb_refcnt, 1);
 #endif
 	list_add_tail(&blkcg->all_blkcgs_node, &all_blkcgs);
 
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -47,6 +47,7 @@ struct blkcg_gq;
 struct blkcg {
 	struct cgroup_subsys_state	css;
 	spinlock_t			lock;
+	refcount_t			online_pin;
 
 	struct radix_tree_root		blkg_tree;
 	struct blkcg_gq	__rcu		*blkg_hint;
@@ -57,7 +58,6 @@ struct blkcg {
 	struct list_head		all_blkcgs_node;
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
-	refcount_t			cgwb_refcnt;
 #endif
 };
 
@@ -431,47 +431,34 @@ static inline struct blkcg *cpd_to_blkcg
 
 extern void blkcg_destroy_blkgs(struct blkcg *blkcg);
 
-#ifdef CONFIG_CGROUP_WRITEBACK
-
 /**
- * blkcg_cgwb_get - get a reference for blkcg->cgwb_list
+ * blkcg_pin_online - pin online state
  * @blkcg: blkcg of interest
  *
- * This is used to track the number of active wb's related to a blkcg.
+ * While pinned, a blkcg is kept online.  This is primarily used to
+ * impedance-match blkg and cgwb lifetimes so that blkg doesn't go offline
+ * while an associated cgwb is still active.
  */
-static inline void blkcg_cgwb_get(struct blkcg *blkcg)
+static inline void blkcg_pin_online(struct blkcg *blkcg)
 {
-	refcount_inc(&blkcg->cgwb_refcnt);
+	refcount_inc(&blkcg->online_pin);
 }
 
 /**
- * blkcg_cgwb_put - put a reference for @blkcg->cgwb_list
+ * blkcg_unpin_online - unpin online state
  * @blkcg: blkcg of interest
  *
- * This is used to track the number of active wb's related to a blkcg.
- * When this count goes to zero, all active wb has finished so the
+ * This is primarily used to impedance-match blkg and cgwb lifetimes so
+ * that blkg doesn't go offline while an associated cgwb is still active.
+ * When this count goes to zero, all active cgwbs have finished so the
  * blkcg can continue destruction by calling blkcg_destroy_blkgs().
- * This work may occur in cgwb_release_workfn() on the cgwb_release
- * workqueue.
  */
-static inline void blkcg_cgwb_put(struct blkcg *blkcg)
+static inline void blkcg_unpin_online(struct blkcg *blkcg)
 {
-	if (refcount_dec_and_test(&blkcg->cgwb_refcnt))
+	if (refcount_dec_and_test(&blkcg->online_pin))
 		blkcg_destroy_blkgs(blkcg);
 }
 
-#else
-
-static inline void blkcg_cgwb_get(struct blkcg *blkcg) { }
-
-static inline void blkcg_cgwb_put(struct blkcg *blkcg)
-{
-	/* wb isn't being accounted, so trigger destruction right away */
-	blkcg_destroy_blkgs(blkcg);
-}
-
-#endif
-
 /**
  * blkg_path - format cgroup path of blkg
  * @blkg: blkg of interest
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -487,8 +487,8 @@ static void cgwb_release_workfn(struct w
 	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
-	/* triggers blkg destruction if cgwb_refcnt becomes zero */
-	blkcg_cgwb_put(blkcg);
+	/* triggers blkg destruction if no online users left */
+	blkcg_unpin_online(blkcg);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
@@ -588,7 +588,7 @@ static int cgwb_create(struct backing_de
 			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
 			list_add(&wb->memcg_node, memcg_cgwb_list);
 			list_add(&wb->blkcg_node, blkcg_cgwb_list);
-			blkcg_cgwb_get(blkcg);
+			blkcg_pin_online(blkcg);
 			css_get(memcg_css);
 			css_get(blkcg_css);
 		}
