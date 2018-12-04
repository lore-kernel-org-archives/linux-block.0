Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5D7C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21C920850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21C920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeLDSgP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:15 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42003 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeLDSgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:14 -0500
Received: by mail-yb1-f193.google.com with SMTP id s8so5114914ybe.9;
        Tue, 04 Dec 2018 10:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDtyDWFwsy3cTbCsYZQ052J7W94OKIQSuaqoyAgynY4=;
        b=Nz9kDgNWzh8FfTeoYV5SyI6eFZEA81lvdxa+NJQvFnu/3T6qFSsK+n/r8ZEjKSwEn/
         2BKBtPhGVFQYrF2tEUvDWXFyzP7x5L+BIIu7sb3dMzIip1mtaRV2QpZbAW1bXxpCERYS
         najmnPh8DZ8yO3NFZDv8xbDzvvHscLm0x1YxGrF0n4xTlcJpH3pH46vl953UIUHN0jJJ
         HM8/dW5wkO+p1i0yFa6eRGMyirP4u2TMgI2VMcOfZXLA4aMfye1p7bZBNG/Vt9jvWr5e
         Wk9FJj13ENGx/xatE4PakzZuhjvf8s7+SGRFqKf0FJcpzLIXpV+4+VO1Zjgk94ulzBCo
         JQhg==
X-Gm-Message-State: AA+aEWZZpwGBkJvayWhJLTQKCsm2kbikQrgTqn6nEFsaLfx04Tnj0FuZ
        NzDBVp+EQNqAhoZdMKGpzt8=
X-Google-Smtp-Source: AFSGD/WKmiNUKjzz+S7m8mOXWJUpFq1XsVWOiS6qv8bSYeC95hAcFQL+xgW5Mpq/2dD2XMf3Z/Nang==
X-Received: by 2002:a25:5f4c:: with SMTP id h12-v6mr20309268ybm.402.1543948572176;
        Tue, 04 Dec 2018 10:36:12 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:11 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/14] blkcg: associate blkg when associating a device
Date:   Tue,  4 Dec 2018 13:35:52 -0500
Message-Id: <20181204183600.99746-7-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, blkg association was handled by controller specific code in
blk-throttle and blk-iolatency. However, because a blkg represents a
relationship between a blkcg and a request_queue, it makes sense to keep
the blkg->q and bio->bi_disk->queue consistent.

This patch moves association into the bio_set_dev macro(). This should
cover the majority of cases where the device is set/changed keeping the
two pointers consistent. Fallback code is added to
blkcg_bio_issue_check() to catch any missing paths.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/bio.c                |  1 +
 block/blk-iolatency.c      |  4 +---
 block/blk-throttle.c       |  1 -
 include/linux/bio.h        |  2 ++
 include/linux/blk-cgroup.h | 11 +++--------
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 41ebb3f8e2fc..1e852ab904aa 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2074,6 +2074,7 @@ void bio_associate_blkg(struct bio *bio)
 
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(bio_associate_blkg);
 
 /**
  * bio_disassociate_task - undo bio_associate_current()
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index cdbd10564e66..e6b47c255521 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -472,14 +472,12 @@ static void check_scale_change(struct iolatency_grp *iolat)
 static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	bio_associate_blkg(bio);
-	blkg = bio->bi_blkg;
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 
 	while (blkg && blkg->parent) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 228c3a007ebc..1c6529df2002 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2118,7 +2118,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	bio_associate_blkg(bio);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 62715a5a4f32..6ee2ea8b378a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -491,12 +491,14 @@ do {						\
 		bio_clear_flag(bio, BIO_THROTTLED);\
 	(bio)->bi_disk = (bdev)->bd_disk;	\
 	(bio)->bi_partno = (bdev)->bd_partno;	\
+	bio_associate_blkg(bio);		\
 } while (0)
 
 #define bio_copy_dev(dst, src)			\
 do {						\
 	(dst)->bi_disk = (src)->bi_disk;	\
 	(dst)->bi_partno = (src)->bi_partno;	\
+	bio_clone_blkcg_association(dst, src);	\
 } while (0)
 
 #define bio_dev(bio) \
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index c08e96e521ed..3c87ae71156f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -802,21 +802,17 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
-	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
-	rcu_read_lock();
+	if (!bio->bi_blkg)
+		bio_associate_blkg(bio);
 
-	/* associate blkcg if bio hasn't attached one */
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-	blkg = blkg_lookup_create(blkcg, q);
+	blkg = bio->bi_blkg;
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
 	if (!throtl) {
-		blkg = blkg ?: q->root_blkg;
 		/*
 		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
 		 * is a split bio and we would have already accounted for the
@@ -828,7 +824,6 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
-	rcu_read_unlock();
 	return !throtl;
 }
 
-- 
2.17.1

