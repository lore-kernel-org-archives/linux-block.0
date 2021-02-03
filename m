Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF5C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9052164E4E
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBCPMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhBCPLa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 10:11:30 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6DC061786
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 07:10:50 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id j5so191223iog.11
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzaJa3Etccl8JcjQv8dbYH5nAqdNSqE8WXoX6JBC4yw=;
        b=TJo1Gl6hS7K5oorQvDzO7xqQCDkxI9l0Q9rundtz6o6TdMGxRscj8FoiRyz+kSRVjB
         HQWq1WZ0Uygl0/ZmX8+v/LXU4IacNvCZQOF1KW9wGR0gRRX8zbTT2/zaMGRYuLOEn9Sb
         i8MbILlSUNHetsbp9HeJoJIuYTHiwfzYCWycpe64UFYBNhC3W95q8zmmoUTaCEUkIPkH
         OMUva76qb7gj7EAQITpT25jL+sTKaq5lE+l1FqEXB+aDoQsV52gPkysDSCppSl7gfdLT
         sGD1XgThwD/SfJceA3RFruQU7oHA8NaaZGp+E4tkHgA8zD+qfqISHza3aLqMkJOjp8AT
         iIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzaJa3Etccl8JcjQv8dbYH5nAqdNSqE8WXoX6JBC4yw=;
        b=JH89gK+zGhGn+g3LOTXnb8JAlIvxH9uBIy9EAPsTnV7BDR4HUmSQg3tsckqHzMoU7Q
         bXDUqWa33zwS69gMb+kH9c41fSOKDgF8/xRuZzXCkNtiNCV/TzlZP/L2rqyZM+/3pCd9
         5DdsUvLepq+gb3Zh0mglSvVsN9+JB4iYIIeWOwRevInqCVcw7rxULIBkJQp8yQxjRfJ1
         J8Hpz4QjYJ3fxTquKAkpRGLgls9F0z15SuUdwM1SAfTvGAFox/vyLltKBhusrIdjd8+w
         8e7R88brS4iRWTeoZv5pPlJ0pvTCKa7ZXYfN5KM5dTDP0s9UzRh8xqZbDTMBlo8y0sTX
         gAaA==
X-Gm-Message-State: AOAM5303y/3j3dkTu+7ZWKSeq5CWSu84gEei3XKbIhrfneUPjtuONgjP
        ZFEXrbBXBC8enLIy4zrFGi/qwg==
X-Google-Smtp-Source: ABdhPJwyQbU6Fs/WT/ms2SaE2i72NAXlJo4jRScdXICFHxbqwvHQzUDxTC083zesYcYZUZzJ+nD0IQ==
X-Received: by 2002:a5d:9c4a:: with SMTP id 10mr2814768iof.145.1612365049320;
        Wed, 03 Feb 2021 07:10:49 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fd01:c087:775e:21aa])
        by smtp.gmail.com with ESMTPSA id e15sm1201962iog.24.2021.02.03.07.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:10:48 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V4 1/3] block: add io_extra_stats node
Date:   Wed,  3 Feb 2021 16:10:17 +0100
Message-Id: <20210203151019.27036-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
References: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We will track the size and latency of each io, which could make people
suffer from the additional overhead if they don't need the statistics.
So introduce a specific sysfs node to enable/disable the tracking.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.rst   | 5 +++++
 block/blk-sysfs.c                     | 3 +++
 include/linux/blkdev.h                | 2 ++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..503314efec13 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -316,3 +316,12 @@ Description:
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

