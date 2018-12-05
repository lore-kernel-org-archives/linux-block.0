Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761E4C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5292082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029903;
	bh=Ez9BV4HnrNr/5O3tQDT6WeXWKJyQfo98hBWf2EM0V+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNQ/fN/JHS80i3YJlG+O0FMUHZWL4oBgCiAELsqWAvipHFzs748sMNZvr1BbK50aV
	 m5X146ImkMsBC/RuI6DyGzWrtYnlnQ0vvdr/GBPwoDEBxrYn+e6OfIN6bZSxCtTDFb
	 jL2Nii89EUfTqFBMl1vdU9m3LMrgx+oer0tHD7G0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5292082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeLERKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:10:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35216 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeLERKx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so12294078qka.2;
        Wed, 05 Dec 2018 09:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kbTt40oSdO9mX4meVZyGYc5JMDxuEWAZsehkr/S4Xp8=;
        b=WNd+nsgyyEcqIajw+LohZIbtfOq6nERG8I4mSXK6tO0jCg8Z9G2xeDkA3p96Uz6H3Q
         RsGtDTfcRJqPI/zB1hRWz/i+9AZVUCqnSMkQIXB33612csmM7s9uvOqaNI3zl84JdxkY
         gWYI/1ELqTnxzjoPMu10frDyeaWecVdgqBaPttAnwjHxrkDJH2V2ynMfNTnDMgpkan/4
         78xMUj3AEvZiHq0FUCYrZbv80NtmJSj83GDEFT7dgztYI/1YYM94daaIazg/BXITHthC
         KfYvWKVvcQIti5jtI5buRR2L/GcpIyzP7i19hdxik1o7zJp2bQvIVpTthv91B54xYkhJ
         uZ/g==
X-Gm-Message-State: AA+aEWaJtwO8lBcVY7IUVED5/4mGmrBRSRO7uLsvPOcxMj2Jks9IjOEJ
        0E76FTT/2XbtkDgS/z1sJ6I=
X-Google-Smtp-Source: AFSGD/U8J5tW+3HT8NBwAcxrpL70aUBhcRdFZASMEP2Sh6/Uap3bEYvCRNpxCpcV98RSPjZ5MuSVew==
X-Received: by 2002:a37:59c4:: with SMTP id n187mr3756214qkb.156.1544029852145;
        Wed, 05 Dec 2018 09:10:52 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:51 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/14] blkcg: consolidate bio_issue_init() to be a part of core
Date:   Wed,  5 Dec 2018 12:10:32 -0500
Message-Id: <20181205171039.73066-8-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
index f09752968c2a..8b069c3775ee 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -800,6 +800,12 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
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
@@ -831,6 +837,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
+	blkcg_bio_issue_init(bio);
+
 	return !throtl;
 }
 
@@ -936,6 +944,7 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
+static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
 
-- 
2.17.1

