Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C98C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D51F64E9B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBBDLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBBDLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 22:11:12 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771DCC061756
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 19:10:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so17729231ilc.10
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 19:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcLy68pClKT3HUrCFRLHi42wvY72+dIr9Wy+hEhBQr4=;
        b=iiGu5t7gEtp2UHz6+bwWKRLan8rFSd+Jgk25b4q2FY+GEk2WfSBgRkGciokFjLSrd5
         kWsh7G2v43Qzqt1cN1/EuqJkl0prgGoUui8wr4WpygvaSZ6tU+nLJe6IkrtvHiG9Maln
         JVejl+inm3gvcs6o8zW5VK6jKxhakBTnsP4bv0sLuGgQJGs/IOuu2lmEhK6cdxlka1CS
         G3ZU3nXm8aC3qiBnPerQ/IsWgLZ19FxFczbCAEMNefPH9JlIPC9R8EELqL/krCQUpKCA
         Anpmoe48EB6DOXQzSSrhTD3VQIkrmDQwJrKIxOM8FJRg1AjFf/F2oM8cw53B9y5t4tEv
         3kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcLy68pClKT3HUrCFRLHi42wvY72+dIr9Wy+hEhBQr4=;
        b=ohKxAF5+sVVz4XFWY07p2d6HMi0OkDqxzuhUssykSxB6HjgCRXG+R2fFe0mPGIOppW
         pR/KG2fWLcnZ3ItFz/Fx3ewkegtLS677h7nERUAeOnPqAoULwMGdC4ecVCHHuf1+JiNm
         Ic/NlGQJXz3KEUe+poQ7Z4/cSS0LOQaQ8vuU15d+ZoZ1AMIH7T/YPZ7/Ua/tlLYTAAq1
         LuYBsfdJm/VXrD8gKD5vGXO+UV1UczJ3l0ua5exwTk/NV0YMfAybMM5hWKzj5lb8jqcg
         5BfcVTpZFM+bEqtW+HrfOCmgyUswurqcLDzVeucfQXcnYtCgw0PmaK/dFo1vUiWmSRlu
         Bm0A==
X-Gm-Message-State: AOAM531+bOrEQnnv+fGw/GKqqlWYZbrGmKU4UFRhqvj3ynUlaFVAxNvl
        dM/nen0Q/TThpWoAYinTjQTiwg==
X-Google-Smtp-Source: ABdhPJzzByFiP9cMsxlXnrXh51Z9AiGyubKLxPHZ+Jwy0SddFEgbgHKUUk/+tGE5SjUfPibRDo4vEQ==
X-Received: by 2002:a05:6e02:1411:: with SMTP id n17mr14834529ilo.61.1612235425030;
        Mon, 01 Feb 2021 19:10:25 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c05c:3bba:187c:cddb])
        by smtp.gmail.com with ESMTPSA id q5sm9099307ioi.43.2021.02.01.19.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:10:24 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 1/3] block: add io_extra_stats node
Date:   Tue,  2 Feb 2021 04:10:07 +0100
Message-Id: <20210202031009.11584-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
References: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We will track the size and latency of each io, which could make people
suffer from the additional overhead if they don't need the statistics.
So introduce a specific sysfs node to enable/disable the tracking.

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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

