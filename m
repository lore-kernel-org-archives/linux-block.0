Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F57C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C220834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8C220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLDSg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45976 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeLDSgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:23 -0500
Received: by mail-yb1-f193.google.com with SMTP id f6-v6so7269870ybg.12;
        Tue, 04 Dec 2018 10:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lqj6Cml3IT2RuUIZeS3djtKJCP/6zrHnyGdgyu4JqDw=;
        b=kZ1SSRnz2NaungdGjmO8GG7R9KSu7IsiLiPRS75hUvvdtnwsOTXRP5fgW6IA+AO/gg
         33m+KB1wjCxGgbxffCDnoKYJq/YQF24zBScBnp3z1B5JbR7KBH5dVCfOXNGPNtgzL2im
         2lrhCubmzWTxEx/XP3hQUCuyjtz1uE8PU4snh887N24hlJCo8z7Qn1Bi19nrQCADiMbm
         RbVOO+qJdAXg0IIQS8/qCQSSZImuTyNWx3Qs1XYzV+aNlyYTZ9KYGYNkrjiCkzqT95et
         EPZiF3j+d1EAmbJFTkOjtWFGsv+7B6W2N45citcFS/4pyLrUS+sxNichCpKqMw9W2mSL
         fc1g==
X-Gm-Message-State: AA+aEWZIssMDAvqzWLfZuA0PJMJk8Z5RR7QD4lJhnTZAshvK9cLPpq5D
        5hLRWFAY3gNA2R76gAIxUx9iXhZYiqE=
X-Google-Smtp-Source: AFSGD/VwRiTrFdAOB4ws/p97SSomY4DYYPg+bNYQ52JzXu1TzyxcvEBJQnbvIHUl6sxMDTt1J3UHsg==
X-Received: by 2002:a25:a462:: with SMTP id f89-v6mr19907126ybi.490.1543948582333;
        Tue, 04 Dec 2018 10:36:22 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:21 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/14] blkcg: rename blkg_try_get() to blkg_tryget()
Date:   Tue,  4 Dec 2018 13:36:00 -0500
Message-Id: <20181204183600.99746-15-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg reference counting now uses percpu_ref rather than atomic_t. Let's
make this consistent with css_tryget. This renames blkg_try_get to
blkg_tryget and now returns a bool rather than the blkg or %NULL.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                |  2 +-
 block/blk-cgroup.c         |  3 +--
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h | 12 +++++-------
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7ec5316e6ecc..06760543ec81 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1990,7 +1990,7 @@ static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	bio_disassociate_blkg(bio);
 
-	bio->bi_blkg = blkg_try_get_closest(blkg);
+	bio->bi_blkg = blkg_tryget_closest(blkg);
 }
 
 /**
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2ca7611fe274..6bd0619a7d6e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1736,8 +1736,7 @@ void blkcg_maybe_throttle_current(void)
 	blkg = blkg_lookup(blkcg, q);
 	if (!blkg)
 		goto out;
-	blkg = blkg_try_get(blkg);
-	if (!blkg)
+	if (!blkg_tryget(blkg))
 		goto out;
 	rcu_read_unlock();
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 5a79f06a730d..0b14c3d57769 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -698,7 +698,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 		 * We could be exiting, don't access the pd unless we have a
 		 * ref on the blkg.
 		 */
-		if (!blkg_try_get(blkg))
+		if (!blkg_tryget(blkg))
 			continue;
 
 		iolat = blkg_to_lat(blkg);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 05909cf31ed1..64ac89130ae8 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -490,27 +490,25 @@ static inline void blkg_get(struct blkcg_gq *blkg)
 }
 
 /**
- * blkg_try_get - try and get a blkg reference
+ * blkg_tryget - try and get a blkg reference
  * @blkg: blkg to get
  *
  * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
  * of freeing this blkg, so we can only use it if the refcnt is not zero.
  */
-static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
+static inline bool blkg_tryget(struct blkcg_gq *blkg)
 {
-	if (percpu_ref_tryget(&blkg->refcnt))
-		return blkg;
-	return NULL;
+	return percpu_ref_tryget(&blkg->refcnt);
 }
 
 /**
- * blkg_try_get_closest - try and get a blkg ref on the closet blkg
+ * blkg_tryget_closest - try and get a blkg ref on the closet blkg
  * @blkg: blkg to get
  *
  * This walks up the blkg tree to find the closest non-dying blkg and returns
  * the blkg that it did association with as it may not be the passed in blkg.
  */
-static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
+static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 {
 	while (!percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
-- 
2.17.1

