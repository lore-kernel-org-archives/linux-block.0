Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D2C433E9
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80771207B3
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhA0PF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhA0PBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA6C0617AA
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gx5so3068484ejb.7
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+W+fPaccyHn1uXbBCoY+DAN6C3QZSzOPnBrXdEQLXA=;
        b=Gp9IN3z/wBEUsW2g4glH7zxnEY67YpBP5RJ9e70/zy9rOeTlCvGijNFvpnhU27uuDe
         Wi9qNhpY/6I8zEojpsotpXjHLEeLKjxdZAGmatG5hF5kfW+KLPwFVivarhSlx77iOEh6
         IviMR0de5IhH4bhcLx6wD5UT3PEUpbGwGR/4BP7/EXZqIH+o0+ulxnfN2J/WVUzEniDy
         ODeKS36FwHHeANcd1/9UgXFWMEGppMD1CGlgTEdC6lMX549RUaMSYfzaHX/GfHGJxGeP
         KWgGdgg/mZx8ISbeYrFJ1sfwxb/M84B0rGNdBhqj9AT5bxWYMIfbWGm9f/+nJ1G2dd4Z
         IAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+W+fPaccyHn1uXbBCoY+DAN6C3QZSzOPnBrXdEQLXA=;
        b=YYvgI668RpYbonbKltWMRmLsxrrJI3pln1Cw+3dU9Btid3YU9j+cZZPAtiIZXbzs1+
         fGkt/i3qE+mSd23Dk/3jqkNX4M/pldKp4VAqVLQop8PXHOaKfwHQU6U8q5kwEXLvkIDQ
         U0c4ZGEhY88befmZr7mfQoqE6C7wKX7jvqUn5/FTP6Xcuwn3sqXp/FlO4Quh/s98eqNK
         DcKg9+GGANF5UE0cQdyX2To5kb2C+nyvNO2w7OKGQ0E60pp/9SiZJmP68EEfSEiqg1o7
         stVezrvU+HDp5Y3Ofb9cmhj0NeIP699vx0ENYfVsO8C5VDPZt5yKQ3baMA1+JWntKG7t
         l1Pw==
X-Gm-Message-State: AOAM530gNPIh6W4kxfXhFS1qrM+CTkNFI5UenUwyxCr6psRzCflqTcyp
        kAd38V5HbbEFSHZFCBfQ0LFVoQ==
X-Google-Smtp-Source: ABdhPJweruQ4a91+DnWTvScjHLED5X/D8dSzhSRBRuu3IMu3gn232ifJIFFja4xHLJU+WBYoKTys2w==
X-Received: by 2002:a17:906:4c90:: with SMTP id q16mr7440802eju.49.1611759590404;
        Wed, 27 Jan 2021 06:59:50 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:9172:bd00:1e95:fbc9])
        by smtp.gmail.com with ESMTPSA id j4sm1477140edt.18.2021.01.27.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:59:48 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 3/4] block: add io_extra_stats node
Date:   Wed, 27 Jan 2021 15:59:29 +0100
Message-Id: <20210127145930.8826-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even we have introduced a Kconfig option (default N) to control the
accounting of additional data, but the option still could be enabled
occasionally while user doesn't care about the size and latency of io,
and they could suffer from the additional overhead. So introduce a
specific sysfs node to avoid such mistake.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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
index 20f3706b6b2e..6cebc689c36a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_IO_EXTRA_STAT 30	/* extra IO accounting for size and latency */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -658,6 +659,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
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

