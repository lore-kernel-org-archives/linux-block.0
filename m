Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE0C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4468B610E5
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDHN7K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHN7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 09:59:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD5C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 06:58:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y124-20020a1c32820000b029010c93864955so2986605wmy.5
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGkKjDaEi/KlYshNQeyrH0VKuXivN67iK6qcTUlbAeE=;
        b=L+LiQImweCmjfT9yazHjBb6m/FjhIML4xUsbIShJPBSWgqB6hvkDxnvJLPZ41lzXTE
         UqSRcPpkZYTn0GaHgdQE2JULUafFWco1o/KfwN83IYKeI+SWHMwgKMHj1MoZGUAr0GT9
         r1aLgIuEKYWIKjx7QThWEexs8m2M7/gu3BCDrjkJe6m42W2pR9wv/XW8EXXMMPzY0fg8
         0syAZitlij8IjXBPjxqM63/VZIjQbX8mgHZF1qNA3ZqJ7+iddH/ECKNMB3wZ1QxCsFoR
         73PGeqUcU6IfjBa0bBEjc1RCJ7L5iyYuRNgyBWBXnjcT1rkPcNM5AJ0/K0vP6tCMgF/E
         luSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGkKjDaEi/KlYshNQeyrH0VKuXivN67iK6qcTUlbAeE=;
        b=GnGTW+wPSV+KLVFYhRpLfk5cEoJW8iTRnsNlbDW97fA2bSovTGw5brOxby/ag4Tfyx
         5Q0HMgkFI/bJaqjrGobn2tcDta45HbhYFWhaLFpkFFcbULNV8Q6Msh2KggpB+vVnn5YK
         jLZFlSvo5rIjbiCgHPdZ2Z5ayzFijogj+aRcb7R7SolTBjmhJwsUACLxFx54EytyKDET
         gsliktHwOSb5wlvbk3IwEhlWIALkZkKOBFfifueDvmSksSNmZbETquEvjO7ONxxNW8qh
         ccG6u4DQgEt9EC5jPJFHVTADZife9lpGc6wJAKkM9OFGbK5x6TTImanNGBdOILXPM1HS
         Ht7w==
X-Gm-Message-State: AOAM533UuqjgwjrdB0tPbBsDLY1699G/ufqN+5LyDFfZstPU9La9a4uH
        Dk8jSVqZa9v0WoYLT+3Y3e9YUg==
X-Google-Smtp-Source: ABdhPJw43U/Viwtqw6YZSs6x5OM5Vvj+LcdyCv5oehnSvid/lJDDmj+WaTClnA3ZzY04Ncskgd269A==
X-Received: by 2002:a7b:c003:: with SMTP id c3mr8576422wmb.59.1617890337976;
        Thu, 08 Apr 2021 06:58:57 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:5dfa:e648:2da1:1094])
        by smtp.gmail.com with ESMTPSA id c6sm45080294wri.32.2021.04.08.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:58:57 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V5 1/3] block: add io_extra_stats node
Date:   Thu,  8 Apr 2021 15:58:38 +0200
Message-Id: <20210408135840.386076-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408135840.386076-1-haris.iqbal@ionos.com>
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@ionos.com>

We will track the size and latency of each io, which could make people
suffer from the additional overhead if they don't need the statistics.
So introduce a specific sysfs node to enable/disable the tracking.

Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Cc: Guoqing Jiang <jgq516@gmail.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.rst   | 5 +++++
 block/blk-sysfs.c                     | 3 +++
 include/linux/blkdev.h                | 2 ++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..aee7464b35da 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -316,3 +316,12 @@ Description:
 		does not complete in this time then the block driver timeout
 		handler is invoked. That timeout handler can decide to retry
 		the request, to fail it or to start a device recovery strategy.
+
+What:		/sys/block/<disk>/queue/io_extra_stats
+Date:		March 2021
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		Indicates if people want to know the extra statistics (I/O
+		size and I/O latency) from /sys/block/<disk>/io_latency
+		and /sys/block/<disk>/io_size. The value is 0 by default,
+		set if the extra statistics are needed.
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 4dc7f0d499a8..5b24c552e3f6 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -99,6 +99,11 @@ iostats (RW)
 This file is used to control (on/off) the iostats accounting of the
 disk.
 
+io_extra_stats (RW)
+-------------------
+This file is used to control (on/off) the additional accounting of the
+io size and io latency of disk.
+
 logical_block_size (RO)
 -----------------------
 This is the logical block size of the device, in bytes.
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e03bedf180ab..848ed6449eca 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -298,6 +298,7 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(io_extra_stats, IO_EXTRA_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
@@ -629,6 +630,7 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 
 QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
+QUEUE_RW_ENTRY(queue_io_extra_stats, "io_extra_stats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
@@ -664,6 +666,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_nomerges_entry.attr,
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
+	&queue_io_extra_stats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 43c4a2d04ea2..b95279494cfa 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_IO_EXTRA_STAT 30	/* extra IO accounting for size and latency */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -641,6 +642,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_stable_writes(q) \
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
+#define blk_queue_io_extra_stat(q) test_bit(QUEUE_FLAG_IO_EXTRA_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
-- 
2.25.1

