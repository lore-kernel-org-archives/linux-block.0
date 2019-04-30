Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F0C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDB5216FD
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhrmaAla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfD3HfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfD3HfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so9912876lfl.12;
        Tue, 30 Apr 2019 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfImJDU825GWzDyzRsKQyMJ5Upvz3fWVsSYZH4ZfskU=;
        b=vhrmaAladSNAGVu0fLthS9JVDA/ImG64hktD6Wq/M8YtE5ZsATapMpiZhgrtWNS7tm
         1QxTfhf9LVTOLj6QNYn16mP1/fQTCUVB33s5U+rDPRdBM8KnDNbapVjWueQYxZ/8GESw
         DGfgbXbUkNEd8dCgN8Eee4fonS95v2kzzSNzlAvqpVjcf36mQjWHVrn+GAnb6Rn79N1j
         6EIE+5VtwubPTc2PwYohBhd4K0jDdWALsU79z9VdKqbt8GLl8YX/RxSGsyNuHoUDKuFr
         fRK9YHCD4Gr5rEgHu85QtHHgJVVz/ATmQmodeO1IwV12TAHt6mbnIbrqDkMFkmq+FWkr
         u7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfImJDU825GWzDyzRsKQyMJ5Upvz3fWVsSYZH4ZfskU=;
        b=hlD9pRmAieYTSQO1J99O7XGCIQW7eeReWxKUqcqLNFNx4IhG47PVAjnkKiC5WFoVCK
         B0WVfXpzFXWgfW95M/j/69MBNku9CkGbrRLp5Vl23FgbaJmXVMC/WHkSWG5rQa3U9Crt
         VYaFwcK6K4BI3l4J/HPEQdg2chndnysVn7Ghsdi3QwXWakRZH8T8IdGmhh491Tbu5O+t
         VeOuSIOJAAYU/klh/ltzPTcvoXFrnCxbp/3pWFJwRdyV17SU/zKOqm286UhYNeF07er3
         Hn62hizZPBJ1G7rVFgRaBIb/3NKeEhXZj/RV6WPw0NwAOa3UVqgG9PIWk6dFlKb1SSTO
         PhCw==
X-Gm-Message-State: APjAAAURLQtxnJK1L5EvQYnrzw/PAU3F671R0/w9qH8yBdmAay28z7qD
        AQtTlnlgBZ2XF0Wc5vqWUQ0cqd+q
X-Google-Smtp-Source: APXvYqzrYQOaoXmefQCI0XvJeMIEHrPowYGFfu32nmBzry/8uqTu8NIgXTtCU4A2VY1v+yC7cQgLYA==
X-Received: by 2002:a19:f703:: with SMTP id z3mr34911683lfe.119.1556609702882;
        Tue, 30 Apr 2019 00:35:02 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:35:02 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 4/7] blk-stats: Add left mean deviation to blk_stats
Date:   Tue, 30 Apr 2019 10:34:16 +0300
Message-Id: <243815abd0a89d660c56739172365556a8f94546.1556609582.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1556609582.git.asml.silence@gmail.com>
References: <cover.1556609582.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

The basic idea is to use the 3-sigma rule to guess adaptive polling
sleep time. Effective standard deviation calculation could easily
overflow u64, thus decided to use mean absolute deviation (MAD) as an
approximation. As only the left bound is needed, to increase accuracy
MAD is replaced by the left mean deviation (LMD).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-debugfs.c    | 10 ++++++----
 block/blk-stat.c          | 21 +++++++++++++++++++--
 block/blk-stat.h          |  6 ++++++
 include/linux/blk_types.h |  3 +++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ec1d18cb643c..b62bd4468db3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -27,12 +27,14 @@
 
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
-	if (stat->nr_samples) {
-		seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
-			   stat->nr_samples, stat->mean, stat->min, stat->max);
-	} else {
+	if (!stat->nr_samples) {
 		seq_puts(m, "samples=0");
+		return;
 	}
+
+	seq_printf(m, "samples=%d, mean=%llu, min=%llu, max=%llu, lmd=%llu",
+		   stat->nr_samples, stat->mean, stat->min, stat->max,
+		   stat->lmd);
 }
 
 static int queue_poll_stat_show(void *data, struct seq_file *m)
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 13f93249fd5f..e1915a4e41b9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -17,14 +17,21 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-void blk_rq_stat_init_staging(struct blk_rq_stat_staging *stat)
+void blk_rq_stat_reset(struct blk_rq_stat_staging *stat)
 {
 	stat->min = -1ULL;
 	stat->max = 0;
 	stat->batch = 0;
+	stat->lmd_batch = 0;
 	stat->nr_samples = 0;
 }
 
+void blk_rq_stat_init_staging(struct blk_rq_stat_staging *stat)
+{
+	blk_rq_stat_reset(stat);
+	stat->mean_last = 0;
+}
+
 void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
@@ -42,8 +49,12 @@ void blk_rq_stat_collect(struct blk_rq_stat *dst,
 
 	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
 				dst->nr_samples + src->nr_samples);
+	dst->lmd = div_u64(src->lmd_batch + dst->lmd * dst->nr_samples,
+				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
+	/* pass mean back for lmd computation */
+	src->mean_last = dst->mean;
 }
 
 void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src)
@@ -57,6 +68,9 @@ void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->mean = div_u64(src->mean * src->nr_samples +
 				dst->mean * dst->nr_samples,
 				dst->nr_samples + src->nr_samples);
+	dst->lmd = div_u64(src->lmd * src->nr_samples +
+				dst->lmd * dst->nr_samples,
+				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
 }
@@ -67,6 +81,9 @@ void blk_rq_stat_add(struct blk_rq_stat_staging *stat, u64 value)
 	stat->max = max(stat->max, value);
 	stat->batch += value;
 	stat->nr_samples++;
+
+	if (value < stat->mean_last)
+		stat->lmd_batch += stat->mean_last - value;
 }
 
 void blk_stat_add(struct request *rq, u64 now)
@@ -113,7 +130,7 @@ static void blk_stat_timer_fn(struct timer_list *t)
 		for (bucket = 0; bucket < cb->buckets; bucket++) {
 			blk_rq_stat_collect(&cb->stat[bucket],
 					    &cpu_stat[bucket]);
-			blk_rq_stat_init_staging(&cpu_stat[bucket]);
+			blk_rq_stat_reset(&cpu_stat[bucket]);
 		}
 	}
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index e5c753fbd6e6..ad81b2ce58bf 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -170,5 +170,11 @@ void blk_rq_stat_collect(struct blk_rq_stat *dst,
 void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src);
 void blk_rq_stat_init(struct blk_rq_stat *);
 void blk_rq_stat_init_staging(struct blk_rq_stat_staging *stat);
+/*
+ * Prepare stat to the next statistics round. Similar to
+ * blk_rq_stat_init_staging, but retains some information
+ * about the previous round (see last_mean).
+ */
+void blk_rq_stat_reset(struct blk_rq_stat_staging *stat);
 
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5718a4e2e731..fe0ad7b2e6ca 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -445,13 +445,16 @@ struct blk_rq_stat {
 	u64 mean;
 	u64 min;
 	u64 max;
+	u64 lmd; /* left mean deviation */
 	u32 nr_samples;
 };
 
 struct blk_rq_stat_staging {
+	u64 mean_last;
 	u64 min;
 	u64 max;
 	u64 batch;
+	u64 lmd_batch;
 	u32 nr_samples;
 };
 
-- 
2.21.0

