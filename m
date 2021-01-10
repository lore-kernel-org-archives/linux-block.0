Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A92C433E9
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8023976
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbhAJJqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:46:08 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C42C0617A3
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lt17so20522355ejb.3
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3uXkH3R+VG/EIFJCdwP8rkqb3Bg5khoXbVqxj05Xxo=;
        b=Y0iydH3yVwTAnHT3ns1WgPrjtsbc9lxr/ECy0UxaFBMqfViGExb8mcXn1KxeKPV7gV
         qvMF38ZWxzfxARGUM0BQkLIiOidJnohKcDzozHJZ08HL/CcX8pwsww4Hh0Al+BwKiZp6
         mXpFifdTlSOV+tzFkqZKRI9yCTofLuPhwnFmDbvj4iDydIXj+zEoetQbiwCHuTwjyc04
         ss/sKfoV61gGv6iGR41epVtO0MaMlB1MHmUevkvoSo++kv621F1hT5t7sndPT2D/NEZj
         MrwVcvTxrvcwxwFOb2kwbKNs+/jBATmg3b4vFED7snWvSsV+ZDCf5UTN+npS8qdDtMHu
         eA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3uXkH3R+VG/EIFJCdwP8rkqb3Bg5khoXbVqxj05Xxo=;
        b=tXZjR3L21yB7Pz4owTWIcMXtDnkXwLXFGr8Rs3WCpKm4CUN1D9CQv3myP/dytjwV+L
         89Sz8SXdjHYsxWImPsdcEIfJ9QZby2WegR8gRoQ98XvmZRyNjzsC7bElwkyJukbyRftJ
         DNGoC8OHDZydRuMqePqAze7ep6mWqgQtX9AlbOaSu8JeFfor4Y6tmIawQZhvRliLiSbc
         Vk1eohij1//sMhKCPsf/X7YEc4YX95es5TR9s/1SQaS2NOI9XzsP+TCNbOTZg0UG4yFq
         UcXehcWltD9JeEfLgF66BwOeOipOsKEyGHhw9Tp376adw9y6+dZWT9CeAnttHtefcHWi
         L12g==
X-Gm-Message-State: AOAM532folScESyPJpUbTN9mPaMlqOpl8k2hAyTelZD5j/aPSBQtLjwC
        /ELJ9fjydCbP7WCGrRaTeqHFQw==
X-Google-Smtp-Source: ABdhPJwlznfXLHWDC1DHFtEy44NJiy8T+cdiqWm7Rprf07fn/XqAgRAuTwB5ultqMZMlx+/eGizfyw==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr7247347ejb.264.1610271920671;
        Sun, 10 Jan 2021 01:45:20 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f4fd:e8ab:2d54:e8c])
        by smtp.gmail.com with ESMTPSA id k15sm5549675ejc.79.2021.01.10.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 01:45:20 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V4 3/4] block: add io_extra_stats node
Date:   Sun, 10 Jan 2021 10:44:56 +0100
Message-Id: <20210110094457.6624-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
References: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even we have introduced a Kconfig option (default N) to control the
accounting of additional data, but the option still could be enabled
occasionally while user doesn't care about the size and latency of io,
and they could suffer from the additional overhead. So introduce a
specific sysfs node to avoid such mistake.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  9 +++++++++
 Documentation/block/queue-sysfs.rst   |  6 ++++++
 block/blk-sysfs.c                     | 10 ++++++++++
 include/linux/blkdev.h                |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 0ffb63469772..e1611c62a3e1 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -333,3 +333,12 @@ Description:
 		does not complete in this time then the block driver timeout
 		handler is invoked. That timeout handler can decide to retry
 		the request, to fail it or to start a device recovery strategy.
+
+What:		/sys/block/<disk>/queue/io_extra_stats
+Date:		January 2021
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		Indicates if people want to know the extra statistics (I/O
+		size and I/O latency) from /sys/block/<disk>/io_latency
+		and /sys/block/<disk>/io_size. The value is 0 by default,
+		set if the extra statistics are needed.
diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 2638d3446b79..14c4a4c7b9a9 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -99,6 +99,12 @@ iostats (RW)
 This file is used to control (on/off) the iostats accounting of the
 disk.
 
+io_extra_stats (RW)
+-------------------
+This file is used to control (on/off) the additional accounting of the
+io size and io latency of disk, and BLK_ADDITIONAL_DISKSTAT should be
+enabled if you want the additional accounting.
+
 logical_block_size (RO)
 -----------------------
 This is the logical block size of the device, in bytes.
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..87f174f32e9a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -288,6 +288,9 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+QUEUE_SYSFS_BIT_FNS(io_extra_stats, IO_EXTRA_STAT, 0);
+#endif
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -616,6 +619,10 @@ QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+QUEUE_RW_ENTRY(queue_io_extra_stats, "io_extra_stats");
+#endif
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -658,6 +665,9 @@ static struct attribute *queue_attrs[] = {
 	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&blk_throtl_sample_time_entry.attr,
+#endif
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	&queue_io_extra_stats_entry.attr,
 #endif
 	NULL,
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..a86ecd062340 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -625,6 +625,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_IO_EXTRA_STAT 30	/* extra IO accounting for size and latency */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -662,6 +663,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #else
 #define blk_queue_rq_alloc_time(q)	false
 #endif
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+#define blk_queue_io_extra_stat(q) test_bit(QUEUE_FLAG_IO_EXTRA_STAT, &(q)->queue_flags)
+#else
+#define blk_queue_io_extra_stat(q) false
+#endif
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.17.1

