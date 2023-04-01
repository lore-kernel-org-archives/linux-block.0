Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA6C76196
	for <linux-block@archiver.kernel.org>; Sat,  1 Apr 2023 09:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDAJrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Apr 2023 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDAJrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2023 05:47:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB01042C
        for <linux-block@vger.kernel.org>; Sat,  1 Apr 2023 02:47:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso26023286pjb.2
        for <linux-block@vger.kernel.org>; Sat, 01 Apr 2023 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680342442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiK4KO4kZbl8xYSoAWQs5Xyf4Snj7jNQFcEtAQejez8=;
        b=V+zhxA472E3zjzApz3J/B0H+TF2UZuO9A3fqlLhaAsX+s8ZPpc6Y5xCXMt+ODvpYia
         prVRA6DUvQ0U8QdnsdMSDgxnevfp/Htz8mOqyOLtb/ctA/aKl7nZX5U1yZOEb8m1jhIS
         h2XiY2mp3+D5wLLfJJ9IWb9ftDxnGzA9PjwjTDB58mMn4WjQlAP9ATXwjr0EZF6KVmMo
         CseN0wvqz9Cb3qySGD9rkACfMDQ7Lmknsc0B9/T5z24lpA8DEXa9OyJu1KaNRtkaErtR
         WU2DKk+Q55OX8+3ozYk2myGGhObt9Vsrf3CqSyvenh4P2tCxjdTR8vfI+su5veg4D4Ys
         1rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiK4KO4kZbl8xYSoAWQs5Xyf4Snj7jNQFcEtAQejez8=;
        b=qH4wwbgP+mABaND+YSOSY/ALDFtz79vw03iam6/DnmrTXKmOJjajQGTA+87grj70YE
         4EqbQMOnafdisDRRj3B7eW90h/19EcyjQ27LwLfouZWsdV7ppldPnxqWTj7VWw2WNQgi
         mjHuem3Kkbx5yAj4I8WQ9UqfALaE8L6atNT7NOzYvIQTy5IalcGAutYEx7vOK4XFHYV9
         76xOmfKI5HDJ5phOe9WcSU5/3Eu7Xq8hAw4x26PyuCaW5uzRmc72lwYVoIuGEIq3RL0X
         4VbQTc4utgFRMEO2a2AlP3KjuDixtbOp0CC0ki7J0rAC+4On1wkaBQ6IJu1ET73lYj0n
         Z6Eg==
X-Gm-Message-State: AAQBX9cpLgI+TqDtnhnCzDq/H4434Z3cpRyxL9J7Onbq3gIwuHFRGKDf
        sW7gSplGo4ZS0b9qxSmJbWpSNw==
X-Google-Smtp-Source: AKy350a5Qyn30MXPsqFDtaona2Q3ahaJBygNo5/JecPGW8Mz2FslX1mFe6llG8NPGyJowvc0Ntl7+A==
X-Received: by 2002:a05:6a20:cd5a:b0:e4:d395:5ce6 with SMTP id hn26-20020a056a20cd5a00b000e4d3955ce6mr3118164pzb.25.1680342442606;
        Sat, 01 Apr 2023 02:47:22 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b0062d90f36d16sm3233919pfn.88.2023.04.01.02.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 02:47:22 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH v2] blk-throttle: Fix io statistics for cgroup v1
Date:   Sat,  1 Apr 2023 17:47:08 +0800
Message-Id: <20230401094708.77631-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
the only stable io stats interface of cgroup v1, and these statistics
are done in the blk-throttle code. But the current code only counts the
bios that are actually throttled. When the user does not add the throttle
limit, the io stats for cgroup v1 has nothing. I fix it according to the
statistical method of v2, and made it count all ios accurately.

Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-cgroup.c   | 6 ++++--
 block/blk-throttle.c | 6 ------
 block/blk-throttle.h | 9 +++++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..33263d0d0e0f 100644
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
@@ -2064,8 +2067,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
+	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
 
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

