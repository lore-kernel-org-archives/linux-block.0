Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E0C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5320892
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029865;
	bh=0FrrbUlEI8CmS1B1EIIh39d1w2fN9l01bUzg08Wz0Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cWxlreKWCKXph3iiQa/l38CrYjRw51BuRYTGXfeMV2nLhedAjPNoEhZ4qWgKso2zB
	 6aZw3ESbavGzvsFOIMYEwhim0lJDyApG24GeMzkWDikEkfAY4iz1vK1N0vPgWOMjaX
	 8s2St3BTyBh2jdnoMi+Qy0cS9VQbRuOnqgpeFoF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeLERLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:11:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33334 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeLERLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:11:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so23137890qtp.0;
        Wed, 05 Dec 2018 09:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WntvJHPUjYLNcQdbBiZiFTJahfu4d23ydyTd8KYKRZI=;
        b=ufAsyGaEAKP4s6S9O+evuOAhsTgoTjWlYO6oRNw8JWHfE88QW1FivkU7YT95xAJwQJ
         GcpncMbtUYlaEYWdVP4IAjBSL6ic/l8PER8AqhQKWDHl7YKYu50qVFwATNnfSxwy6LGt
         DMwtWCOAEejfJIhW6Ut0Jxz11R1k0/1F/sxd9Tvbdnz+R8LXiLN3mZMtRIlVs6mZ9M0j
         guv67uH2GAUpmiIYUnmJRL8q5pJhnv+LFDuz3yKlEn4gcgeBmIf/kvh3S8YaYRMIglj7
         MLHkaAkxwB3hClh2hRtiNz2OcnKTq2iwX9cR4LFd1GoYNK5Q040oSU1clJq0eeaDJZXo
         4bNw==
X-Gm-Message-State: AA+aEWZuTqX6i3Ikp65QBDFeiRinh0mlxzxFyd0G39+pTBJYPmuAHNjN
        /G7x/NStX33BukLCGGvP2eA=
X-Google-Smtp-Source: AFSGD/XXH7SUHJhOWX6aZ1F8Oe3GhfrhaXoKadOnaz64RORT7PRBfRz/6+Gdx2GmLZRDASFE5pXPkQ==
X-Received: by 2002:a0c:81c4:: with SMTP id 4mr25404109qve.156.1544029861252;
        Wed, 05 Dec 2018 09:11:01 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:11:00 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/14] blkcg: rename blkg_try_get() to blkg_tryget()
Date:   Wed,  5 Dec 2018 12:10:39 -0500
Message-Id: <20181205171039.73066-15-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
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
index d19ef15a673d..752de1becb5c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -491,27 +491,25 @@ static inline void blkg_get(struct blkcg_gq *blkg)
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

