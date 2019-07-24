Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFDCC76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889F2189F
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563989847;
	bh=CoUiERLHZxnSU81JTfU1X+t9+HsHukjllHZZ384/Ye8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ni3f81i0UNDs0QirVWBow+JHpPPyhuygJqb6Ja5yQpUfV8bQueuG4Mf7m+WexuiL1
	 MfwkaKg9LRVARHBuyjcdSWoMWZ8Man/m0imIMWmzc9Hwa87SHhldzNS9x7kyaNS/lw
	 lN//P06QPH4xVn5viMVDCRwTcwXMOIaX/hEdyvWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGXRh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:37:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfGXRh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 13:37:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so12750591pgu.5;
        Wed, 24 Jul 2019 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHxf1kTdWDT0gUqEm0BhBo9+91LG1FL8yrCj/eDjN5Q=;
        b=ZFjj/SoOb4H/1IrlfjFztvbIO1Bsh8BYcN0SwpbOE0BRo+gHZCy74Y5vkvBaDeJHoi
         UhuC8apPTWl9jCTNHFDLqLY9O5jg925z0nTsXAFcaK4NUHgb54HHKIcT126TPO8kzPWV
         4YxeqDr374ZiyQLQ4TSijs58a7dlf3cMbZYfIRfzOT7uC1mps8qnerrY+JgHaZq5QVAN
         krgdsbOeSTxS0CpNRbR7Cc9Uxew1ohLZY23j4JVimyBi+qee7oQI46TYuoymFlZn9E/b
         sCmix2SVuOSy3t+rUc1T6KdV74Mzxcy5kREmM++gtDZqR38wvgoQe89Q8oCRN6Y30jPN
         TrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHxf1kTdWDT0gUqEm0BhBo9+91LG1FL8yrCj/eDjN5Q=;
        b=FwHoY9vVSSwH7mmmHvmg2aoZsVUq8b8RatAvbYE5g9eTdM7uo+d2XjZvllcYvkgsFM
         A8NBdTwTmpkyTSnfU+oLJGXKDDb4T3y6JilAwPF2FzKpqsHMuJ8Gdz041AGgc3r3SG3y
         Ajd7AAtG0XuTeR1LQnM8W8YrgHDF7jdnlG7jYTSsDK7yLObj5TJ7jm/EL5SmdC02n71i
         WAqgvZXKwdbsyQmbIvFn0VBPjPkNk+6ubaXp0IhU7FY4Jhi/lF+7sZrs+MPGAC6O27SD
         FtR69+6MG++2GWnMx0iJIv4nRkM7pJom8gAQYTfLyhjdXLPHIbYj04oWFgk6lwMUTMfS
         v41Q==
X-Gm-Message-State: APjAAAUWVR0wtzWUHVm/wtMd5Y931FlhVaHhvOkzEXuP2f7QAIGGLb8Q
        /hKk+iXEQnhhpQMHySzLI0Q=
X-Google-Smtp-Source: APXvYqwROvBNdwR2JGWp0IvGhoGV0WlnB62tVM2PJk7IS+1rw1bl5XAJaH9t3EgBH+R+/lh4emQQpw==
X-Received: by 2002:a63:d301:: with SMTP id b1mr74847311pgg.379.1563989844842;
        Wed, 24 Jul 2019 10:37:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c91a])
        by smtp.gmail.com with ESMTPSA id f19sm65642862pfk.180.2019.07.24.10.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:37:24 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:37:22 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RESEND 1/2] blkcg: rename blkcg->cgwb_refcnt to ->online_pin
 and always use it
Message-ID: <20190724173722.GA569612@devbig004.ftw2.facebook.com>
References: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724173517.GA559934@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
(Resending cuz somehow I cleared To: line before sending)

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
