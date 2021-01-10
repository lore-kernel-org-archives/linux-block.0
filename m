Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09BC433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC622CAF
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAJJqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJqA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:46:00 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4487AC06179F
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b9so20589276ejy.0
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRUpkim9GeyZSrMIp8Mj1SXPSgk6+Y1Eu1l7OFdPFxM=;
        b=YWwPQZ2bzvc1i/jQMu8cUfvnkrGsRiHw5J9apBbRrteiceU1G+IUaqUiZ28fCAWaNI
         qaS0jIlSCN9eUan3JwqsOq1AgNHoaqB7y7GNDbRnHghfS7JgH2dTywCUW7uyRxuHuv0s
         qwalIDmoK0ytSj0DISJ2jv78gdy39Dt1K5+DZpNNo1WsP0le7oUHsj0Jk2nXWh7Qibh5
         nv5FLPgVeY/UyPRIjBR5OnD8sHfh79urUodF5+k7QHF93jkiaeOnZdOVVYWj9LeKwcU7
         YvC7cAfjhN47ycfKbd5FA1NpMSj/Ic7Pv45RexuUkHfxL6x1itfcUa88rxumd0mrxT4c
         U9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRUpkim9GeyZSrMIp8Mj1SXPSgk6+Y1Eu1l7OFdPFxM=;
        b=iU/TJRIWeER2Tm8glhyiYeDJAa6r7AMQRe/41Apiq4emI0KfstaD70zq1koeULUy3q
         BISwP7JqwmXUO1KMXADAD20GplBINVXyXhCVDW4qV3Mpfw9Uh5XF3UxO1mJOViGSdgIP
         L7TIguZPYBE8rGY3gPScucWzArhqjuYwEfGxm5paqYsY5YG+bop8o+v1gV8MSc/ggB2d
         btAEkhnhvpBGETxHwaiR2f6R4Cf9/Lb5/im9h3hXLijTEdzZB9JW3NKHqySM4XTutSls
         rRNZFCQJcqYH9yuyR9lrXN/3vzypsJuK6aPY4OnNUaKawQ1D+gXCtcLqJDVW2S9Axh5O
         cqlQ==
X-Gm-Message-State: AOAM532nrCabVYErXDoaa9PT0kdQIv1e08wD1ckvTZPhFIedh2vN0pyV
        +t5GmPh00u+IMcw7/0X/zycmoP8foO1TjUZE
X-Google-Smtp-Source: ABdhPJwkrZLIWdrO8+rFOHXaBZm9QIKujJJwm27e9nvMEGevvC1A6aERfsE+9XqGExdm1ll+RgSX/w==
X-Received: by 2002:a17:906:98d4:: with SMTP id zd20mr7584814ejb.532.1610271918950;
        Sun, 10 Jan 2021 01:45:18 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f4fd:e8ab:2d54:e8c])
        by smtp.gmail.com with ESMTPSA id k15sm5549675ejc.79.2021.01.10.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 01:45:18 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V4 1/4] block: add a statistic table for io latency
Date:   Sun, 10 Jan 2021 10:44:54 +0100
Message-Id: <20210110094457.6624-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
References: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Usually, we get the status of block device by cat stat file, but we can
only know the total time with that file. And we would like to know more
accurate statistic, such as each latency range, which helps people to
diagnose if there is issue about the hardware.

Also a new config option is introduced to control if people want to know
the additional statistics or not, and we use the option for io sector in
next patch.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  8 ++++++
 block/Kconfig                         |  8 ++++++
 block/blk-core.c                      | 29 +++++++++++++++++++
 block/genhd.c                         | 41 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  7 +++++
 5 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..4371a0f2cb5e 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -27,6 +27,14 @@ Description:
 
 		For more details refer Documentation/admin-guide/iostats.rst
 
+What:		/sys/block/<disk>/io_latency
+Date:		January 2021
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		The /sys/block/<disk>/io_latency files displays the I/O
+		latency of disk <disk>. With it, it is convenient to know
+		the statistics of I/O latency for each type (read, write,
+		discard and flush) which have happened to the disk.
 
 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..ca3854a7e3db 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -174,6 +174,14 @@ config BLK_DEBUG_FS
 	Unless you are building a kernel for a tiny system, you should
 	say Y here.
 
+config BLK_ADDITIONAL_DISKSTAT
+	bool "Block layer additional diskstat"
+	default n
+	help
+	Enabling this option adds io latency statistics for each block device.
+
+	If unsure, say N.
+
 config BLK_DEBUG_FS_ZONED
        bool
        default BLK_DEBUG_FS && BLK_DEV_ZONED
diff --git a/block/blk-core.c b/block/blk-core.c
index 96e5fcd7f071..18cf881d8194 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1277,6 +1277,33 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	}
 }
 
+/*
+ * Either account additional stat for request if req is not NULL or account for bio.
+ */
+static void blk_additional_latency(struct block_device *part, const int sgrp,
+				   struct request *req, unsigned long start_jiffies)
+{
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	unsigned int idx;
+	unsigned long duration, now = READ_ONCE(jiffies);
+
+	if (req)
+		duration = jiffies_to_nsecs(now) - req->start_time_ns;
+	else
+		duration = jiffies_to_nsecs(now - start_jiffies);
+
+	duration /= NSEC_PER_MSEC;
+	duration /= HZ_TO_MSEC_NUM;
+	if (likely(duration > 0)) {
+		idx = ilog2(duration);
+		if (idx > ADD_STAT_NUM - 1)
+			idx = ADD_STAT_NUM - 1;
+	} else
+		idx = 0;
+	part_stat_inc(part, latency_table[idx][sgrp]);
+#endif
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1301,6 +1328,7 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
+		blk_additional_latency(req->part, sgrp, req, 0);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1360,6 +1388,7 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 419548e92d82..643b679883e1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1276,6 +1276,44 @@ static struct device_attribute dev_attr_fail_timeout =
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
 #endif
 
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	size_t count = 0;
+	int i, sgrp;
+
+	for (i = 0; i < ADD_STAT_NUM; i++) {
+		unsigned int from, to;
+
+		if (i == ADD_STAT_NUM - 1) {
+			count += scnprintf(buf + count, PAGE_SIZE - count, "      >= %5d  ms: ",
+					   (2 << (i - 2)) * HZ_TO_MSEC_NUM);
+		} else {
+			if (i < 2) {
+				from = i;
+				to = i + 1;
+			} else {
+				from = 2 << (i - 2);
+				to = 2 << (i - 1);
+			}
+			count += scnprintf(buf + count, PAGE_SIZE - count, "[%5d - %-5d) ms: ",
+					   from * HZ_TO_MSEC_NUM, to * HZ_TO_MSEC_NUM);
+		}
+
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(bdev, latency_table[i][sgrp]));
+		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+	}
+
+	return count;
+}
+
+static struct device_attribute dev_attr_io_latency =
+	__ATTR(io_latency, 0444, io_latency_show, NULL);
+#endif
+
 static struct attribute *disk_attrs[] = {
 	&dev_attr_range.attr,
 	&dev_attr_ext_range.attr,
@@ -1294,6 +1332,9 @@ static struct attribute *disk_attrs[] = {
 #endif
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 	&dev_attr_fail_timeout.attr,
+#endif
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	&dev_attr_io_latency.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index d2558121d48c..763953238227 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,6 +9,13 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	/*
+	 * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+	 */
+#define ADD_STAT_NUM	12
+	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+#endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
-- 
2.17.1

