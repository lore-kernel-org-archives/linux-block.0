Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4770FC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjC1OX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjC1OX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 10:23:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6AB61AB
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k15so7290927pgt.10
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680013403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbUthmvZJbP0uWypvRq6mwPD7H6UG/v/3UyHU90H3o0=;
        b=NTg1JCEYXIL5mZ4LMW8DcsZJvrDf8IwNw9hp30j9TO7GBAGr0SEnuxFWhsFCWyvFD2
         O8bQkmMtjNy8tLclBcd6RNNFBrbtlCs5oxp1OKNk02oxnYYHOFkNH8j/Q/xQ+YVNPwDP
         ln+p36VFbYTbqUl1pKr0haZetqg2MamAFX+iM2arG8XIoKYEXwDDduY8YJCOEaEAzPcF
         tPMHjJPM810hJNCv2O4ZNsByZFmSSIE/8vXL5oFEUfVjB7yXmRhgI+UeQlxMw1P1qnvP
         fQT6rdeMMdTdB5xL5+pgB7wmQEhbrrZml75ao9Yh+IjqjDMfoEAv/5QPwCuNaEjh50+i
         vAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbUthmvZJbP0uWypvRq6mwPD7H6UG/v/3UyHU90H3o0=;
        b=HyR1YUTE/8vdnPoLIbMzsH9Xxmn1OFDdISCX8JHRdfb1Q3v6OJbsdYyhlXXr8tC6h6
         QX5p5jKhZPDJYGqeeHjVPtYC+0UMEMN8OiKHuI9E1GvvNC0VYtqLYz6hiLMw9i6fT5Ev
         kH2okHBLFG/9+uawYWbQh/rtgxV3pq8k6LgzymDtdEylSgf4cuhqyqb6WQfOGwmtW1Co
         DTfjFzlk5Kn2twUizae2VZqOJ7uIbmjG0e97Aiq/d3Rboe8cDm5xVXP6Czb+6wlaq/Y5
         eJ+SFdpaR6Vk1sqDHacyMfOVYc13gKZjkGAD6dJo4Th+pjTpf/rSDDQL/G/fIIr2VTRc
         z+wQ==
X-Gm-Message-State: AO0yUKWmjP86vAg1Ju2Su79Yt1/4JP0554c3sGjnnFHbpsTGyfiwPu10
        b/gFMd0Vl3bXZaPGZH1tKnRswI15ktpXoxdq13U=
X-Google-Smtp-Source: AK7set8BxkafKwct0/+6wDAtkPyJha1sx6HWpCvpzcdjdcFpOATI2Kzlc+6YebBnscJAdFsSJjYqDw==
X-Received: by 2002:a05:6a00:190a:b0:626:f690:e745 with SMTP id y10-20020a056a00190a00b00626f690e745mr26435591pfi.6.1680013403339;
        Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm21156215pfh.193.2023.03.28.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:23:22 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] blk-throttle: Fix io statistics for cgroup v1
Date:   Tue, 28 Mar 2023 22:23:09 +0800
Message-Id: <20230328142309.73413-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

Now the io statistics of cgroup v1 are no longer accurate. Although
in the long run it's best that rstat is a good implementation of
cgroup v1 io statistics. But before that, we'd better fix this issue.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-cgroup.c   | 3 +++
 block/blk-throttle.c | 6 ------
 block/blk-throttle.h | 9 +++++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..677e4473e45e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
+		return;
+
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47e9d8be68f3..2be66e9430f7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2174,12 +2174,6 @@ bool __blk_throtl_bio(struct bio *bio)
 
 	rcu_read_lock();
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-				bio->bi_iter.bi_size);
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
-	}
-
 	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..d1ccbfe9f797 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
+		}
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])
 		return true;
-- 
2.20.1

