Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694FC433E5
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B532077D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MO5/M9Ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgGMVN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMVN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B3C061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so19034500ejb.11
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SM540rLfgV/tYozAN91I2JvPbEReIqvVWiYDvaIIHmw=;
        b=MO5/M9YsMF9s5UbN1r+DMMBRCJmRqda78rR/kqap75ZCO0772TODQcdyy38BSJNt+U
         GTJaTRN1Ffg/f6JCPLz5q3zhJUi+hNbBja67iBz3Nia5VRJBkqEvoVz29nwaeiEdOEnA
         2R0u9Zi4hjzkfwb194dLCNjaEdg+9OaXOKs85utR7J0Y2cM467KK6AnMSHcMoXAboo0b
         wKOtEEU+5SU5usfgLEdk37emU16CBxRk8pWDv8e2+xsLT23bpmXwlFTPMJab19u9mWJz
         CE3F/bGioF6ryodrnrux2e+wUcbfmuGeT4i0FmjeNWpLc0GnF5zaov9VEgbBtftLRtYj
         7S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SM540rLfgV/tYozAN91I2JvPbEReIqvVWiYDvaIIHmw=;
        b=RJDEjz2iQzZK0C00r0+6v7ymd7U4VEUcIVqSY70Ih0x2QOALjUYCJ8N4A7fhCbCeqk
         KZ8eVlwRHz784CN2z0Oh2zS2q/lxjRe3J5Nz+0r3fBTCxdG5ydsEIBo5g8KzxAn1NRbw
         yyGOo12AY+XUJmZgW2sJLJmWp4M7lq/aCguHfzmK3ASvj1TbJs+s3IiOM8PvhwX3VHDy
         eWFm+hhRoB7qlOrf8gzrT4qvmiEIhnCGXdGwMcegAtz5F6eAIVPgQvLjSzXyv22KHRWK
         WrIPvNPqpUatPyBvwHsjE4N11ZimQGSgBaCMQp6e3jyY5lmiQmjWDMssN8MoM6KcDBEV
         0yoA==
X-Gm-Message-State: AOAM532Mnq6/whPPh9h1HyhHrq7yTiBIDZ4a5AH2ECzvqjSTwb6XBfcg
        kgwjMZh0tlzh4E9y6uXTsNj+7Q==
X-Google-Smtp-Source: ABdhPJz2zxaxOeCUof/2E4cEGINfMzYgbWqbzympMWIkmCITcaTzN5s48NaX/cLGZ5KezPwm6mAKog==
X-Received: by 2002:a17:906:e25a:: with SMTP id gq26mr1592704ejb.152.1594674835798;
        Mon, 13 Jul 2020 14:13:55 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ab:24b8:5892:2244])
        by smtp.gmail.com with ESMTPSA id d5sm12715770eds.40.2020.07.13.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:13:55 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V2 3/4] block: add io_extra_stats node
Date:   Mon, 13 Jul 2020 23:13:20 +0200
Message-Id: <20200713211321.21123-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
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
 Documentation/block/queue-sysfs.rst | 6 ++++++
 block/blk-sysfs.c                   | 8 ++++++++
 include/linux/blkdev.h              | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 6a8513af9201..e7b5e0d77385 100644
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
index be67952e7be2..98bd788e32c3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -287,6 +287,7 @@ queue_store_##name(struct request_queue *q, const char *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(io_extra_stats, IO_EXTRA_STAT, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -686,6 +687,12 @@ static struct queue_sysfs_entry queue_iostats_entry = {
 	.store = queue_store_iostats,
 };
 
+static struct queue_sysfs_entry queue_io_extra_stats_entry = {
+	.attr = {.name = "io_extra_stats", .mode = 0644 },
+	.show = queue_show_io_extra_stats,
+	.store = queue_store_io_extra_stats,
+};
+
 static struct queue_sysfs_entry queue_random_entry = {
 	.attr = {.name = "add_random", .mode = 0644 },
 	.show = queue_show_random,
@@ -777,6 +784,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
+	&queue_io_extra_stats_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 69ad13dacd48..640190678bbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -610,6 +610,7 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_IO_EXTRA_STAT 28	/* extra IO accounting for latency and size */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -652,6 +653,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
+#define blk_queue_extra_io_stat(q) test_bit(QUEUE_FLAG_IO_EXTRA_STAT, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.17.1

