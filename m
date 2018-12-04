Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640BEC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BDF20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BDF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLDShI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:37:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38364 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeLDSgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:14 -0500
Received: by mail-yw1-f65.google.com with SMTP id i20so7397717ywc.5;
        Tue, 04 Dec 2018 10:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53HkgHIonCsBbl+KaKXgiPeGBiiH+FYvGL0HERKygRA=;
        b=sdkgAMww+e+vK1jHGLXGAxsLa0ed28uz9NRJ9gbI32dXMp+8w9Pb1NPPRa2ZBWDW2K
         o20sJheqc36C0bJKAyjImDYDOLcgmqdqbV1Caaczrsl9L+68hJ6ik3lpU2woAjvZe7hj
         RMUKjUrQ6/iwdnLfrmMuScaj9wSaZYmLNTAwS8PX7fM3Zzvb/GuiWu0k1LqtfRat0/Ml
         s2NDSrBYEM1GUH4nTL5viTPE/z4qns6Ye29zpKKtX1vVPP4QhWvxDa24KYpBD8cLAZ4j
         weEYtaWkqCdIgfF1ks7Jg1dWNm/0S5brb4O46i9GgvFDdAFVoZyNaGKILg8oxgPn2v2z
         yybg==
X-Gm-Message-State: AA+aEWZVZOQjtNwAn/YnK8mZ9TPWkkaflghkenR3I+QNYou5ubQ4gc2Z
        tlXBWOdeoP+Vp0xVWX9ZBco=
X-Google-Smtp-Source: AFSGD/VO5RbOhERrZXfMZrK60Bx/OJ9P0zk4GOyk/IiFNO2qE0/w8yJZEGl5jmoQSC2khOsHJONQSg==
X-Received: by 2002:a81:34d3:: with SMTP id b202mr21172248ywa.241.1543948573346;
        Tue, 04 Dec 2018 10:36:13 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:12 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/14] blkcg: consolidate bio_issue_init() to be a part of core
Date:   Tue,  4 Dec 2018 13:35:53 -0500
Message-Id: <20181204183600.99746-8-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_issue_init among other things initializes the timestamp for an IO.
Rather than have this logic handled by policies, this consolidates it to
be on the init paths (normal, clone, bounce clone).

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/bio.c                | 1 +
 block/blk-iolatency.c      | 2 --
 block/blk-throttle.c       | 8 --------
 block/bounce.c             | 1 +
 include/linux/blk-cgroup.h | 9 +++++++++
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1e852ab904aa..90089124b512 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -611,6 +611,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkcg_association(bio, bio_src);
+	blkcg_bio_issue_init(bio);
 }
 EXPORT_SYMBOL(__bio_clone_fast);
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e6b47c255521..5a79f06a730d 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -478,8 +478,6 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1c6529df2002..1b97a73d2fb1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2115,13 +2115,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-static void blk_throtl_assoc_bio(struct bio *bio)
-{
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-#endif
-}
-
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -2142,7 +2135,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	throtl_update_latency_buckets(td);
 
-	blk_throtl_assoc_bio(bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;
diff --git a/block/bounce.c b/block/bounce.c
index 559c55bda040..cfb96d5170d0 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -278,6 +278,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	}
 
 	bio_clone_blkcg_association(bio, bio_src);
+	blkcg_bio_issue_init(bio);
 
 	return bio;
 }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3c87ae71156f..5cca4ffcdae5 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -799,6 +799,12 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 				  struct bio *bio) { return false; }
 #endif
 
+
+static inline void blkcg_bio_issue_init(struct bio *bio)
+{
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+}
+
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
@@ -824,6 +830,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
+	blkcg_bio_issue_init(bio);
+
 	return !throtl;
 }
 
@@ -929,6 +937,7 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
+static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
 
-- 
2.17.1

