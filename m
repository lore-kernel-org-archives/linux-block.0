Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ACC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418A964E27
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhBAB2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBAB21 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 20:28:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BDC061756
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 16so15715734ioz.5
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnmVvJKFQMKkEXF9PIlaj5H0fGnNsnzXgo6GctBUifw=;
        b=gmgD7h9FDJ6oCO+FTYJ3vEr8hosQNKd0zXLxPdsf8RysSJncuUkcC9OgHH4lg8zD1u
         SoSOZ2VsD0uFT/vlB0uTBJRKytozskom5e/4OjG/grxbrbGQfgJhHU682TscOV6NbRXT
         DOeeCsY/tOpb7PjobrcAsTIy6FKWHyOgFmLIJ8hpz3TqOPYNrAy3UsMhqeoES9Sab/ih
         4BBWK+POGibYMWiSogwF+moX/mR8JBwBZD4J+MeWiTdScaWkWGkHe7Dc7IeGisLf8aD4
         98s06/JCCwgnYn2FVcKNtBp7+C/Xlpp6v/Lagfu3TYyMnRz7MKqPcueki1JvNNRzFnCL
         aI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnmVvJKFQMKkEXF9PIlaj5H0fGnNsnzXgo6GctBUifw=;
        b=RYnc4cRnJ5TQX5yG+9Tuj4SO2//MfGq9JZcQLNadLt82Sxjia+Ttp+n2RQ68S1kx4L
         6FW0A7SrdDsC/m6YbQt9q7wAAKBq4Os+unlmQn/QVS1lt20RjMRsvt0fv+bOwVcN6dYw
         qaSTB0eNNpso1D2htW9h3UwdOEhBED2XYQtpwXB4pbZB/vboJWNdfVRUGTFBiyMniz8o
         uiASlb6dOz9yhm5FrlM1v8my06a9GL7/ToYamUvzrXTSwjGmkjD/1SfMosVhiGdxlxxB
         nMOLVIiF4Kcjw6tiJV7Mp8vC07ugp3jdsSpB7dmMmpSdks6CoiIWm6FNodDWIOGqKChU
         sBJw==
X-Gm-Message-State: AOAM530GPvNM9Ovg+ESHcQcznm/G7uNRjVSSUo7ThcOqxnu5sjRXS2yo
        D8mPgYT/A6Efe7zNUza9cZyxYw==
X-Google-Smtp-Source: ABdhPJzBsEM3giZuxHNNalaere7k4ITzurzjahMXl5wClYKIX1DlfNq4yV6IJ0HUyvw7DZMNo7LAEg==
X-Received: by 2002:a02:3541:: with SMTP id y1mr12987501jae.66.1612142865671;
        Sun, 31 Jan 2021 17:27:45 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:994d:fb60:3536:26f])
        by smtp.gmail.com with ESMTPSA id c19sm8539627ile.17.2021.01.31.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 17:27:45 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, hch@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 3/4] block: add io_extra_stats node
Date:   Mon,  1 Feb 2021 02:27:26 +0100
Message-Id: <20210201012727.28305-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
References: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If user doesn't care about the size and latency of io, and they could
suffer from the additional overhead. So introduce a specific sysfs node
to avoid such mistake.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.rst   | 5 +++++
 block/blk-sysfs.c                     | 3 +++
 include/linux/blkdev.h                | 2 ++
 4 files changed, 19 insertions(+)

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
index 2638d3446b79..28ffce653eb1 100644
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
index b513f1683af0..ed31938e89fe 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -287,6 +287,7 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(io_extra_stats, IO_EXTRA_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
@@ -613,6 +614,7 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 
 QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
+QUEUE_RW_ENTRY(queue_io_extra_stats, "io_extra_stats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
@@ -647,6 +649,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_nomerges_entry.attr,
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
+	&queue_io_extra_stats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_random_entry.attr,
 	&queue_poll_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0dea268bd61b..62881db2004f 100644
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
2.17.1

