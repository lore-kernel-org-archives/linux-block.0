Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D46EC18DF5
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6C820873
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6C820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeK0IPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:37 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44734 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeK0IPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:35 -0500
Received: by mail-yb1-f196.google.com with SMTP id p144-v6so8120911yba.11;
        Mon, 26 Nov 2018 13:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDWB6v2Sjdd1SXjPBLbMJlV6MI6UKkWJSLdUCbEjuHM=;
        b=a5sxn+OQmV+h/u1U/qUn7QZRVa47uE/Jxc8jiDEfPYmwiJpCM1NylYUOeafF4mPLxe
         0rldvYHed0ZLOrFEWWvaayD/74scUH2oeGUj9vi6ZU1uq4HHCHFrx3TtC47870bUZqEm
         P2E35dNMIELL/yMKhWxq07ayNwPj7gaQfJBlndP2PfMLu0NcOKOCaffOMkseS2thVqJk
         jIq88sNKoDPajf2ilew7nV66yPAnRZ2dgFFScXq5a5tXIMmGxbnCimqfSrNG5nWlXkhr
         /F/VXJc9xrrTjA0qQ6s7bMEyZ4sv2avCxWfg2cd7EmLRZ0rjTKO7A6bHDGwxlIwsDrt3
         jLOw==
X-Gm-Message-State: AA+aEWa6Ct/TWdzwRWD8vKEFdensr8KIQca2AwU0hJVyYJjdxWa79ijT
        lqz6IYf0PB20amy4Hi06x30=
X-Google-Smtp-Source: AFSGD/XQvm2idy21fhB3Brpkb+J7A1uMauFm8eqw07+fpDKKe/b+6IxT17mXtxaOykicqv+cvqePkQ==
X-Received: by 2002:a25:97c4:: with SMTP id j4-v6mr24280278ybo.448.1543267208906;
        Mon, 26 Nov 2018 13:20:08 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:20:08 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 13/13] blkcg: rename blkg_try_get() to blkg_tryget()
Date:   Mon, 26 Nov 2018 16:19:46 -0500
Message-Id: <20181126211946.77067-14-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
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
index 41cc2ead39f5..434a55bc310e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2004,7 +2004,7 @@ static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	if (bio->bi_blkg)
 		bio_disassociate_blkg(bio);
 
-	bio->bi_blkg = blkg_try_get_closest(blkg);
+	bio->bi_blkg = blkg_tryget_closest(blkg);
 }
 
 /**
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 64ce424a78fd..8fc588754861 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1738,8 +1738,7 @@ void blkcg_maybe_throttle_current(void)
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
index fc23bb758566..3741f5b78ffd 100644
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

