Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0336C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9563A20892
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029892;
	bh=pKNWf1tb/jcaBL55ul+xqcHiRPOpaS1Jqhs1ndyQde0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XeJ8Gh83dOSAyeHVhvE+fcVbKgr2AUGjwC8p7yd9a8Jun/9wfje1KRjAPzUPdm8lY
	 s84xXG/y0Lnk3ddVnJgzAB6ajwTfd4RXr+KwoZB1r3UL+98PirdnLe6JITymJ5GWI9
	 9OEbFLIz3QXC6cS83U2hobsghjiZUFvERsEXHmQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9563A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeLERK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:10:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39554 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeLERK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id q70so12300261qkh.6;
        Wed, 05 Dec 2018 09:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dG0XaHOWRGL1V9ZiH30NE2Rs6vmnsfww+bOzD6dOcOs=;
        b=Ro2CSCXdcweI98PIUdiI7UDb8so2h3HPi4iWC82i5gYtOYvOK7ZrOmVhFUmNhuCHL4
         glovk7VbNFHLKpgnIFBrQCuiq2Ow+Wt8Y5CUmncba3dfdo8PdtCpRrIKzRoVyT0NUYqD
         8k9pO8lMv1ITihB6Kp3ZnaEr1P+cL/S7kbTf3N64+ewAqY2mXCiN+D01ZgFgepyR/bZ5
         Ke/v4M8YOUZUt0794KLzpiVL3pEJhKr0O7TR9gRhKLNGGvtY8EC+jhCrIi2nqYhr/DvG
         ey5RFptQMMnF3IO8b5Eokgll13T2W1CuSSYKKnbuhxS1CAZZoU+5hMomJQ5pEUlTs7c8
         +2kQ==
X-Gm-Message-State: AA+aEWYi7maun2o2W6HKTMoqjkK4eiPFYo7RFaB7CgmNvyBe+de/kcKz
        a0P5/rEqaWFgATpaYJ0VpfU=
X-Google-Smtp-Source: AFSGD/VmhtryiAMH9C+IspJPyKlHgXz/bUD8qM3bxbJwjSYG/N5bgMYwN3QclUEH/3065zC9suU6SQ==
X-Received: by 2002:a37:2bcf:: with SMTP id r76mr22502134qkr.218.1544029856038;
        Wed, 05 Dec 2018 09:10:56 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:55 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/14] blkcg: remove bio->bi_css and instead use bio->bi_blkg
Date:   Wed,  5 Dec 2018 12:10:35 -0500
Message-Id: <20181205171039.73066-11-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prior patches ensured that any bio that interacts with a request_queue
is properly associated with a blkg. This makes bio->bi_css unnecessary
as blkg maintains a reference to blkcg already.

This removes the bio field bi_css and transfers corresponding uses to
access via bi_blkg.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                | 59 +++++++++-----------------------------
 block/bounce.c             |  2 +-
 drivers/block/loop.c       |  5 ++--
 drivers/md/raid0.c         |  2 +-
 include/linux/bio.h        | 11 +++----
 include/linux/blk-cgroup.h |  8 +++---
 include/linux/blk_types.h  |  7 +++--
 kernel/trace/blktrace.c    |  4 +--
 8 files changed, 32 insertions(+), 66 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b42477b6a225..2b6bc7b805ec 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -610,7 +610,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
 }
 EXPORT_SYMBOL(__bio_clone_fast);
@@ -1957,34 +1957,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-/**
- * bio_associate_blkcg - associate a bio with the specified blkcg
- * @bio: target bio
- * @blkcg_css: css of the blkcg to associate
- *
- * Associate @bio with the blkcg specified by @blkcg_css.  Block layer will
- * treat @bio as if it were issued by a task which belongs to the blkcg.
- *
- * This function takes an extra reference of @blkcg_css which will be put
- * when @bio is released.  The caller must own @bio and is responsible for
- * synchronizing calls to this function.  If @blkcg_css is %NULL, a call to
- * blkcg_get_css() finds the current css from the kthread or task.
- */
-int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
-{
-	if (unlikely(bio->bi_css))
-		return -EBUSY;
-
-	if (blkcg_css)
-		css_get(blkcg_css);
-	else
-		blkcg_css = blkcg_get_css();
-
-	bio->bi_css = blkcg_css;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bio_associate_blkcg);
-
 /**
  * bio_disassociate_blkg - puts back the blkg reference if associated
  * @bio: target bio
@@ -1994,6 +1966,8 @@ EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 void bio_disassociate_blkg(struct bio *bio)
 {
 	if (bio->bi_blkg) {
+		/* a ref is always taken on css */
+		css_put(&bio_blkcg(bio)->css);
 		blkg_put(bio->bi_blkg);
 		bio->bi_blkg = NULL;
 	}
@@ -2047,7 +2021,6 @@ void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css)
 {
 	css_get(css);
-	bio->bi_css = css;
 	__bio_associate_blkg_from_css(bio, css);
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
@@ -2066,13 +2039,10 @@ void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 {
 	struct cgroup_subsys_state *css;
 
-	if (unlikely(bio->bi_css))
-		return;
 	if (!page->mem_cgroup)
 		return;
 
 	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
-	bio->bi_css = css;
 	__bio_associate_blkg_from_css(bio, css);
 }
 #endif /* CONFIG_MEMCG */
@@ -2094,8 +2064,10 @@ void bio_associate_blkg(struct bio *bio)
 
 	rcu_read_lock();
 
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
+	if (bio->bi_blkg)
+		blkcg = bio->bi_blkg->blkcg;
+	else
+		blkcg = css_to_blkcg(blkcg_get_css());
 
 	if (!blkcg->css.parent) {
 		__bio_associate_blkg(bio, q->root_blkg);
@@ -2115,27 +2087,22 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg);
  */
 void bio_disassociate_task(struct bio *bio)
 {
-	if (bio->bi_css) {
-		css_put(bio->bi_css);
-		bio->bi_css = NULL;
-	}
 	bio_disassociate_blkg(bio);
 }
 
 /**
- * bio_clone_blkcg_association - clone blkcg association from src to dst bio
+ * bio_clone_blkg_association - clone blkg association from src to dst bio
  * @dst: destination bio
  * @src: source bio
  */
-void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
+void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 {
-	if (src->bi_css)
-		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
-
-	if (src->bi_blkg)
+	if (src->bi_blkg) {
+		css_get(&bio_blkcg(src)->css);
 		__bio_associate_blkg(dst, src->bi_blkg);
+	}
 }
-EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
+EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 #endif /* CONFIG_BLK_CGROUP */
 
 static void __init biovec_init_slabs(void)
diff --git a/block/bounce.c b/block/bounce.c
index cfb96d5170d0..ffb9e9ecfa7e 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -277,7 +277,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		}
 	}
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
 
 	return bio;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 176ab1f28eca..0770004616de 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/ioprio.h>
+#include <linux/blk-cgroup.h>
 
 #include "loop.h"
 
@@ -1820,8 +1821,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	/* always use the first bio's css */
 #ifdef CONFIG_BLK_CGROUP
-	if (cmd->use_aio && rq->bio && rq->bio->bi_css) {
-		cmd->css = rq->bio->bi_css;
+	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
+		cmd->css = &bio_blkcg(rq->bio)->css;
 		css_get(cmd->css);
 	} else
 #endif
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ac1cffd2a09b..f3fb5bb8c82a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -542,7 +542,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		    !discard_bio)
 			continue;
 		bio_chain(discard_bio, bio);
-		bio_clone_blkcg_association(discard_bio, bio);
+		bio_clone_blkg_association(discard_bio, bio);
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
 				discard_bio, disk_devt(mddev->gendisk),
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f0438061a5a3..84e1c4dc703a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -498,7 +498,7 @@ do {						\
 do {						\
 	(dst)->bi_disk = (src)->bi_disk;	\
 	(dst)->bi_partno = (src)->bi_partno;	\
-	bio_clone_blkcg_association(dst, src);	\
+	bio_clone_blkg_association(dst, src);	\
 } while (0)
 
 #define bio_dev(bio) \
@@ -512,24 +512,21 @@ static inline void bio_associate_blkg_from_page(struct bio *bio,
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 void bio_disassociate_blkg(struct bio *bio);
 void bio_associate_blkg(struct bio *bio);
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css);
 void bio_disassociate_task(struct bio *bio);
-void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
+void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
-static inline int bio_associate_blkcg(struct bio *bio,
-			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline void bio_disassociate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg_from_css(struct bio *bio,
 					       struct cgroup_subsys_state *css)
 { }
 static inline void bio_disassociate_task(struct bio *bio) { }
-static inline void bio_clone_blkcg_association(struct bio *dst,
-			struct bio *src) { }
+static inline void bio_clone_blkg_association(struct bio *dst,
+					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_HIGHMEM
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8b069c3775ee..f11c37f8ce09 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -309,8 +309,8 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
  */
 static inline struct blkcg *__bio_blkcg(struct bio *bio)
 {
-	if (bio && bio->bi_css)
-		return css_to_blkcg(bio->bi_css);
+	if (bio && bio->bi_blkg)
+		return bio->bi_blkg->blkcg;
 	return css_to_blkcg(blkcg_css());
 }
 
@@ -324,8 +324,8 @@ static inline struct blkcg *__bio_blkcg(struct bio *bio)
  */
 static inline struct blkcg *bio_blkcg(struct bio *bio)
 {
-	if (bio && bio->bi_css)
-		return css_to_blkcg(bio->bi_css);
+	if (bio && bio->bi_blkg)
+		return bio->bi_blkg->blkcg;
 	return NULL;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c0ba1a038ff3..46c005d601ac 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -174,10 +174,11 @@ struct bio {
 	void			*bi_private;
 #ifdef CONFIG_BLK_CGROUP
 	/*
-	 * Optional css associated with this bio.  Put on bio
-	 * release.  Read comment on top of bio_associate_current().
+	 * Represents the association of the css and request_queue for the bio.
+	 * If a bio goes direct to device, it will not have a blkg as it will
+	 * not have a request_queue associated with it.  The reference is put
+	 * on release of the bio.
 	 */
-	struct cgroup_subsys_state *bi_css;
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2868d85f1fb1..fac0ddf8a8e2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -764,9 +764,9 @@ blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		return NULL;
 
-	if (!bio->bi_css)
+	if (!bio->bi_blkg)
 		return NULL;
-	return cgroup_get_kernfs_id(bio->bi_css->cgroup);
+	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
 static union kernfs_node_id *
-- 
2.17.1

