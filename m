Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD44C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLDShS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:37:18 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34547 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLDSgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:10 -0500
Received: by mail-yb1-f193.google.com with SMTP id a67-v6so7300587ybg.1;
        Tue, 04 Dec 2018 10:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhzi5kKdtpnLnQnoN/OzRVY2uwNyEMQKDjxD+gi2Ssw=;
        b=rbxfpQ48fNDN/KoEvyDwLxonogkLyGxH7hrhJDh3P88jOkbar791bRfiXJSHpSVaLC
         jBWzJ6E7FhLBRmpoP5bEINhJF8/tJbT3Y6uddpTciCV8seWk2hLLssNcaudd3GkZuDUT
         xzeZeJialQZdZxCNtetiz0PH71OrCxfPpVlf3At8Pl3l4Udq06ChlutqBddA7efOX0Oa
         Bw19vPYxwShLKNN9LC4m5ifymZNsGRf2z9TTf2ou//p+21tDRBErgHcOFQY66buxAh7W
         BaEhpIQhspASqlRoL/muGyO0QRHOxgwshzx1110Rch6RwC8a/fdkweLKRoxtiouoF6Wb
         roGQ==
X-Gm-Message-State: AA+aEWaL/NKrrzzixiodgWuTcbrc49FnRIMiBzCWIp+hDubaD7Z5gzfj
        OFlI1ALPdoOWEzsmFiu582k=
X-Google-Smtp-Source: AFSGD/Wc+O1ORZ7L/UgZtJ1NadFHhdVXexcSETM0uNIgjN8UtTL7oDvcglyz5rOECHWtiJL25N91Zw==
X-Received: by 2002:a25:4d05:: with SMTP id a5-v6mr19757320ybb.15.1543948569609;
        Tue, 04 Dec 2018 10:36:09 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:08 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/14] blkcg: introduce common blkg association logic
Date:   Tue,  4 Dec 2018 13:35:50 -0500
Message-Id: <20181204183600.99746-5-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are 3 ways blkg association can happen: association with the
current css, with the page css (swap), or from the wbc css (writeback).

This patch handles how association is done for the first case where we
are associating bsaed on the current css. If there is already a blkg
associated, the css will be reused and association will be redone as the
request_queue may have changed.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c           | 62 ++++++++++++++++++++++++++++++++++++-------
 block/blk-iolatency.c | 10 ++-----
 block/blk-throttle.c  |  6 ++---
 include/linux/bio.h   |  5 +++-
 4 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5c9828524adc..452b8e79b998 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2009,7 +2009,21 @@ int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
 /**
- * bio_associate_blkg - associate a bio with the a blkg
+ * bio_disassociate_blkg - puts back the blkg reference if associated
+ * @bio: target bio
+ *
+ * Helper to disassociate the blkg from @bio if a blkg is associated.
+ */
+void bio_disassociate_blkg(struct bio *bio)
+{
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+}
+
+/**
+ * __bio_associate_blkg - associate a bio with the a blkg
  * @bio: target bio
  * @blkg: the blkg to associate
  *
@@ -2022,12 +2036,42 @@ EXPORT_SYMBOL_GPL(bio_associate_blkcg);
  * A reference will be taken on the @blkg and will be released when @bio is
  * freed.
  */
-int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
+static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
-	if (unlikely(bio->bi_blkg))
-		return -EBUSY;
+	bio_disassociate_blkg(bio);
+
 	bio->bi_blkg = blkg_try_get_closest(blkg);
-	return 0;
+}
+
+/**
+ * bio_associate_blkg - associate a bio with a blkg
+ * @bio: target bio
+ *
+ * Associate @bio with the blkg found from the bio's css and request_queue.
+ * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
+ * already associated, the css is reused and association redone as the
+ * request_queue may have changed.
+ */
+void bio_associate_blkg(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	bio_associate_blkcg(bio, NULL);
+	blkcg = bio_blkcg(bio);
+
+	if (!blkcg->css.parent) {
+		__bio_associate_blkg(bio, q->root_blkg);
+	} else {
+		blkg = blkg_lookup_create(blkcg, q);
+
+		__bio_associate_blkg(bio, blkg);
+	}
+
+	rcu_read_unlock();
 }
 
 /**
@@ -2040,10 +2084,7 @@ void bio_disassociate_task(struct bio *bio)
 		css_put(bio->bi_css);
 		bio->bi_css = NULL;
 	}
-	if (bio->bi_blkg) {
-		blkg_put(bio->bi_blkg);
-		bio->bi_blkg = NULL;
-	}
+	bio_disassociate_blkg(bio);
 }
 
 /**
@@ -2055,6 +2096,9 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 {
 	if (src->bi_css)
 		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
+
+	if (src->bi_blkg)
+		__bio_associate_blkg(dst, src->bi_blkg);
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
 #endif /* CONFIG_BLK_CGROUP */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 46e86c34cf79..cdbd10564e66 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -472,21 +472,15 @@ static void check_scale_change(struct iolatency_grp *iolat)
 static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
-	struct request_queue *q = rqos->q;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	rcu_read_lock();
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-	blkg = blkg_lookup_create(blkcg, q);
+	bio_associate_blkg(bio);
+	blkg = bio->bi_blkg;
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-	bio_associate_blkg(bio, blkg);
-	rcu_read_unlock();
 
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d648d6720f46..228c3a007ebc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2115,10 +2115,10 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
+static void blk_throtl_assoc_bio(struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	bio_associate_blkg(bio, tg_to_blkg(tg));
+	bio_associate_blkg(bio);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
@@ -2143,7 +2143,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	throtl_update_latency_buckets(td);
 
-	blk_throtl_assoc_bio(tg, bio);
+	blk_throtl_assoc_bio(bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 056fb627edb3..62715a5a4f32 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -511,12 +511,15 @@ static inline int bio_associate_blkcg_from_page(struct bio *bio,
 
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
-int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
+void bio_disassociate_blkg(struct bio *bio);
+void bio_associate_blkg(struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
+static inline void bio_disassociate_blkg(struct bio *bio) { }
+static inline void bio_associate_blkg(struct bio *bio) { }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkcg_association(struct bio *dst,
 			struct bio *src) { }
-- 
2.17.1

