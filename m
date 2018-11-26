Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A63C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802720873
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeK0IP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:26 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39238 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK0IPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id j6so1933658ywj.6;
        Mon, 26 Nov 2018 13:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MxFDhOHsYdfXQhcVzzfkYemE0CKTyJsvUfaADLg2/fE=;
        b=riwczLGoxAtPloLMTYjf4jQ6a8wWPgpkwIn9TYCtfns4UD1lJbc4ACVD+77bCNgKoo
         vKD8F2bi9+aFfWI+mkxh1PreOGJ7d96q3DCUtkibVeHSL87vd3YficHO+1js1sICRgPE
         fvF9q5VleOEErZ+9TkOKJJtycWJDyZtRq2DYdWEpJbpzNKcPFa35hpuCDUoXYXhLqCGm
         Vg+wXbUd3H3HIa2r3ZEH37YyWCb2G3imDgLm9sL6/kLG3ahg+OzEpsfJYS1nL9Bb3qN+
         p/EtjbnzeIMdCXAaFQxXwYDG6G/FwOtejgkyelqyeLjXHNjCB3RjGTSap+e8OExEG8mo
         G/iA==
X-Gm-Message-State: AA+aEWakBMiXe4qbXFTF9UqKCMucayyQXeC+z5PME6++DVLXnPxwBl8t
        AfbuS6IcMVmLGOhNssOe5Lk=
X-Google-Smtp-Source: AFSGD/XgdYo5g7hq5Z/sKNLfWIDrSpt86azQFy8JmMITOYLMyemxd2QCZVF6XC6x0zCOyYNVV2kBkw==
X-Received: by 2002:a81:63d4:: with SMTP id x203mr7344340ywb.82.1543267199285;
        Mon, 26 Nov 2018 13:19:59 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:19:58 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/13] blkcg: consolidate bio_issue_init() to be a part of core
Date:   Mon, 26 Nov 2018 16:19:39 -0500
Message-Id: <20181126211946.77067-7-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181126211946.77067-1-dennis@kernel.org>
References: <20181126211946.77067-1-dennis@kernel.org>
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
 block/bio.c                | 2 ++
 block/blk-iolatency.c      | 2 --
 block/blk-throttle.c       | 8 --------
 block/bounce.c             | 2 ++
 include/linux/blk-cgroup.h | 9 +++++++++
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 929fd3692e4a..efca5ae607a4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -611,6 +611,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkcg_association(bio, bio_src);
+
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
index 559c55bda040..e77a44a80ac2 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -279,6 +279,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 
 	bio_clone_blkcg_association(bio, bio_src);
 
+	blkcg_bio_issue_init(bio);
+
 	return bio;
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 81b45943ce29..58eb91a9aa8d 100644
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
@@ -826,6 +832,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
+	blkcg_bio_issue_init(bio);
+
 	rcu_read_unlock();
 	return !throtl;
 }
@@ -932,6 +940,7 @@ static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
+static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
 
-- 
2.17.1

