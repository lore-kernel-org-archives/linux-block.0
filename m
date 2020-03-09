Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F413C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18C82464B
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM+SbcP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgCIU7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46380 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIU7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id f28so4426260qkk.13
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7VRXswQbZeeDDEY5pYM9kJ2LUfFWyxsVqnKONFcly8=;
        b=HM+SbcP7moXLJoXIKFFT4yzWLdRVLmTEhOtU8Ng1b7lnXzlgGFOOPeVRcrV9vM3+ii
         mLHlvr/k+zyrDrqaI1i6QvYNJxg4XueA+yhGCE8KqIKz/vbMNmUMozSk9uoTz1tm0Z/8
         1gtnIXbMkfoyfSJE5yB6X8uFbCPuxM4bH1wP1CtvhvF0Le8pUlhE/RBniQEv6JrRLLG5
         u0cRBYc2I6ZLWaoH7WhqCwKBylhWh+AdMFTviwavDJx1WG32/S4+tXCa7QAHgLAG3FLV
         nImYB+4Fd0CkVnSCAE7qIPk7eZCFofVhNELooE/6/A7HBHE3lJatjsNHSoDo3o2fRcg1
         gfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7VRXswQbZeeDDEY5pYM9kJ2LUfFWyxsVqnKONFcly8=;
        b=aJW6KCg0JQiftfavlDBV3CGB3xJLAYaXUlttPMMWmcWUa9srYEHdUi72KBFX10XvfK
         jceVmzNUTmVcK6kDQEYSQ7PnxQ3PZrzO+ocr1tYoXC56E3ARcdPjFkTYUdWzqrFgTOZG
         /G1ICW3BE0AEJJddppGJ7GV22cb3gAz0YoYGejnG8ajeiyFKR/xqbrKD9GCJ9aNESZ2O
         2tQl5AGCmV7mVNItLkMdB2rmsV77es0oelyUrt47n8RJd5l/DolgpzviADRKl9nzCLrA
         Zs0T263ff9GdHbDICJaW/2hqfAcZCSJkCoFQFR9eC9pCYfqBAlhRgBY0O+LW2+wgBTED
         LFfA==
X-Gm-Message-State: ANhLgQ2NQAVI2sEcmf2VgdZYbHpEAC4QY5f2L0Py4RV5lIJt3T0HAat/
        sclX3mR9GPqFi3wGC9Cd2fkB/BXswy0=
X-Google-Smtp-Source: ADFU+vsZFs19Qgrp5PY1qgCRxAXWRtt/oJjcotMeZeXgnQoz8f7Hml1ixsetwPJsfGziy9Ylyg6Vbw==
X-Received: by 2002:ae9:e202:: with SMTP id c2mr17368768qkc.224.1583787580866;
        Mon, 09 Mar 2020 13:59:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id 11sm22428945qko.76.2020.03.09.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:40 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 1/7] block: keep track of per-device io sizes in stats
Date:   Mon,  9 Mar 2020 16:59:25 -0400
Message-Id: <20200309205931.24256-2-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

In order to provide blk stat heuristics, we need to track request
sizes per device. This relies on blk_rq_stats_sectors() introduced in
3d24430694077313c75c6b89f618db09943621e4. Add a field to the
blk_rq_stat to hold this information so that consumers of the
blk_rq_stat stuff can use it.

Based on a previous patch by Josef Bacik <josef@toxicpanda.com>

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-iolatency.c     |  2 +-
 block/blk-stat.c          | 14 ++++++++------
 block/blk-stat.h          |  2 +-
 include/linux/blk_types.h |  1 +
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c128d50cb410..ca0eba5fedf7 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -219,7 +219,7 @@ static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 			stat->ps.missed++;
 		stat->ps.total++;
 	} else
-		blk_rq_stat_add(&stat->rqs, req_time);
+		blk_rq_stat_add(&stat->rqs, req_time, 0);
 	put_cpu_ptr(stat);
 }
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7da302ff88d0..dd5c9c8989a5 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -21,7 +21,7 @@ struct blk_queue_stats {
 void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
-	stat->max = stat->nr_samples = stat->mean = 0;
+	stat->max = stat->nr_samples = stat->mean = stat->sectors = 0;
 	stat->batch = 0;
 }
 
@@ -38,13 +38,15 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
+	dst->sectors += src->sectors;
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat *stat, u64 time, u64 sectors)
 {
-	stat->min = min(stat->min, value);
-	stat->max = max(stat->max, value);
-	stat->batch += value;
+	stat->min = min(stat->min, time);
+	stat->max = max(stat->max, time);
+	stat->batch += time;
+	stat->sectors += sectors;
 	stat->nr_samples++;
 }
 
@@ -71,7 +73,7 @@ void blk_stat_add(struct request *rq, u64 now)
 			continue;
 
 		stat = &per_cpu_ptr(cb->cpu_stat, cpu)[bucket];
-		blk_rq_stat_add(stat, value);
+		blk_rq_stat_add(stat, value, blk_rq_stats_sectors(rq));
 	}
 	put_cpu();
 	rcu_read_unlock();
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..ea893c4a9af1 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -164,7 +164,7 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *, u64);
+void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..4db37b220367 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -482,6 +482,7 @@ struct blk_rq_stat {
 	u64 max;
 	u32 nr_samples;
 	u64 batch;
+	u64 sectors;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.17.1

