Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFD2C433E6
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EB23B06
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbhAJJqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:46:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E784C0617A2
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so20377855ejf.11
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ynHjJZnXcTj+bY9/RDRCYwdL51Yr1C6TsS7Tr2/rNzo=;
        b=gEWGV1KdKtgbnv3xFFJYzbawrAPzveV89G/ctL1RPtKHY8Ismh8x1u3nZvQVmg05qs
         AoWT8VWXFPLxN09+q8vs89ofYldfjGDA3h+mZqAGprEtUXZDK0cUMzVk8JxMfxRTd6db
         7gl1JJNN8P3o/70L3BUUcpQAto8cBsDXlQ8l/FIqXTfxaPP6lAndjkZ+zBbHXfbKm8VM
         rNdP6VuEphz4eQ3rCorKcRke5XZ4TX2LXVZX68qUBDtf6bbNiIQsehJUKwDJt72tgem8
         rKLnnpkDZ9Sc4KQVRPdFxXKaPZaVCwdAklhd3zRShVyvs5HonOD9wI/Znh/jqTgN9xWy
         L5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ynHjJZnXcTj+bY9/RDRCYwdL51Yr1C6TsS7Tr2/rNzo=;
        b=GVP6y1q+LFc3M0MMgK0X0IYD2nc9qWExhkuFUpbAYD9aqFUA4Vg0H1YpTT4FmXxOvI
         CBD59lL2DyJ5Pl9xkAvMIykgnJyf7HK+SPd8SXJ4LU+WNymYnjvhVTVrqaZV9bQzWpK/
         UqbK0zL067U1JTV8/89UTuiPRfel2ZZSxDmRgeoEnVLZbjUrskFi8gVlYQTabilhrNPo
         SAdIoY89NdVD4MR5DxaCHU0NVthummBcVGRqVExisNa6xqugerjkuoaEqXXHQPJRpcQE
         K5Soy/4Fd+CvsWVsmTCxkQ6I+2lTpkpybUoAtTyO4aPC/kX3h/oXezg7NWRzVuHE+9VB
         bHRw==
X-Gm-Message-State: AOAM531dAMwWtoyifuoE8RTEXOxZSHk7xYCRzlFnqoKeYpx1uYAVtVa+
        LQRBklC6jD9uIWmBJuT8D2Mjng==
X-Google-Smtp-Source: ABdhPJw4AYtLjene+x5O2Q74CmALI1SH8ALR4l+RRX6tVIlS1LQAfWiFSiSyllUqZillAsXryZ5iAQ==
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr7667264ejb.168.1610271919889;
        Sun, 10 Jan 2021 01:45:19 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f4fd:e8ab:2d54:e8c])
        by smtp.gmail.com with ESMTPSA id k15sm5549675ejc.79.2021.01.10.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 01:45:19 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V4 2/4] block: add a statistic table for io sector
Date:   Sun, 10 Jan 2021 10:44:55 +0100
Message-Id: <20210110094457.6624-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
References: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the sector table, so we can know the distribution of different IO
size from upper layer, which means we could have the opportunity to tune
the performance based on the mostly issued IOs.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  9 +++++++
 block/Kconfig                         |  3 ++-
 block/blk-core.c                      | 18 +++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  3 ++-
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 4371a0f2cb5e..0ffb63469772 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -36,6 +36,15 @@ Description:
 		the statistics of I/O latency for each type (read, write,
 		discard and flush) which have happened to the disk.
 
+What:		/sys/block/<disk>/io_size
+Date:		January 2021
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		The /sys/block/<disk>/io_size files displays the I/O
+		size of disk <disk>. With it, it is convenient to know
+		the statistics of I/O size for each type (read, write,
+		discard and flush) which have happened to the disk.
+
 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
diff --git a/block/Kconfig b/block/Kconfig
index ca3854a7e3db..ad04ec253b09 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -178,7 +178,8 @@ config BLK_ADDITIONAL_DISKSTAT
 	bool "Block layer additional diskstat"
 	default n
 	help
-	Enabling this option adds io latency statistics for each block device.
+	Enabling this option adds io latency and io size statistics for each
+	block device.
 
 	If unsure, say N.
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 18cf881d8194..719595578bc8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1304,12 +1304,29 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
 #endif
 }
 
+static void blk_additional_sector(struct block_device *part, const int sgrp,
+				  unsigned int sectors)
+{
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	unsigned int idx;
+
+	if (sectors == 1)
+		idx = 0;
+	else
+		idx = ilog2(sectors);
+
+	idx = (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
+	part_stat_inc(part, size_table[idx][sgrp]);
+#endif
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
+		blk_additional_sector(req->part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1357,6 +1374,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index 643b679883e1..059c82088cc4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1312,6 +1312,42 @@ static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr
 
 static struct device_attribute dev_attr_io_latency =
 	__ATTR(io_latency, 0444, io_latency_show, NULL);
+
+static ssize_t io_size_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	size_t count = 0;
+	int i, sgrp;
+
+	for (i = 0; i < ADD_STAT_NUM; i++) {
+		unsigned int from, to;
+
+		if (i == ADD_STAT_NUM - 1) {
+			from = 2 << (i - 2);
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "      >=%5d   KB: ", from);
+		} else {
+			if (i < 2) {
+				from = i;
+				to = i + 1;
+			} else {
+				from = 2 << (i - 2);
+				to = 2 << (i - 1);
+			}
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "[%5d - %-5d) KB: ", from, to);
+		}
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(bdev, size_table[i][sgrp]));
+		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_io_size =
+	__ATTR(io_size, 0444, io_size_show, NULL);
 #endif
 
 static struct attribute *disk_attrs[] = {
@@ -1335,6 +1371,7 @@ static struct attribute *disk_attrs[] = {
 #endif
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 	&dev_attr_io_latency.attr,
+	&dev_attr_io_size.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 763953238227..8a6440ec9134 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -11,10 +11,11 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 	/*
-	 * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+	 * We measure latency (ms) and size (KB) for 1, 2, ..., 1024 and >=1024.
 	 */
 #define ADD_STAT_NUM	12
 	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+	unsigned long size_table[ADD_STAT_NUM][NR_STAT_GROUPS];
 #endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
-- 
2.17.1

