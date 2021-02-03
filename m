Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF594C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5304764E4E
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhBCPMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhBCPLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 10:11:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB33C061788
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 07:10:54 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id n201so1229574iod.12
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 07:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JRarvTsQ8A9ZrX9B3OvlkmPSiGLylKTPswcU/6ClOBw=;
        b=bqvp61+ewCAk47R4+9B4LbIpGuubhDyb0kMQVkiHqv6WpvxtbHHwC130PHK5mpwtza
         N2aH2FY3c2tnG5U0yjW2hnbmZq4V+/Mv8SlKlygIc3P8LR0dWNSXuxuEjR80sx4vdDPp
         N6qoXtIbeX5XmGSdZXTNsT7cO/KdqaWBXPs6haKRd8SDLclNMuh+3IrVP1cceS+gMisz
         46gw/2uLh3GDt771N9BRmb1TsDamO0/wj4WnR0tMvKLOdtIYar6x/gCWnUu1vFTK/NIa
         hq8tzGuszswpX2RmHCpaIAlHqnB7Xmsq2PI9eMf2M8ZmtMjJrf5DpNHGtZxCZXGpXGOX
         ID0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JRarvTsQ8A9ZrX9B3OvlkmPSiGLylKTPswcU/6ClOBw=;
        b=mx1gKJ4WolBjJyAo5ouVU+y9D7/F9bO7R0oq2WvtzW/uctVoLYjJajatEOv/qIweSY
         +Nt/GnbejReBmRFVD6ufMkZfLAmObXPC3D4XzhEZs1bQTmHV4g4811UeRQXYTNYAPrqA
         +vYQ9hQGgGLH9F/yk1P3xlqiKGU/GKpArsoBxR1Mf4uprOuXTJ659OfylDMn7hGb0R/G
         7ts0U/HgDlsKZPE/9A83xIauqIIIY1yJdVnM/jj7gf8SV8c/DbMC81eJKFE19DotWfYP
         L0f00C0OJUG2HO5TPT+/Q6O6F6n8R4cqeB4H2Voyxl2wBqCCAe+UyGIHeqA9QlaEki80
         FUUw==
X-Gm-Message-State: AOAM5329mreNTtm4kbnWrXJhOhL3kCGyFr3d5Ekpyrt4ZTutwMr2H7te
        bx8mi3aoYzQNmrW65O6cAF0E5g==
X-Google-Smtp-Source: ABdhPJySSe3jEil3tZjoEUaXN4FPCkaNTRiFjObloc5CHRaFVUOp4odrxBIMtOCZnVKJY93uq78w1w==
X-Received: by 2002:a02:cf24:: with SMTP id s4mr3394979jar.130.1612365052656;
        Wed, 03 Feb 2021 07:10:52 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fd01:c087:775e:21aa])
        by smtp.gmail.com with ESMTPSA id e15sm1201962iog.24.2021.02.03.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:10:51 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V4 2/3] block: add a statistic table for io latency
Date:   Wed,  3 Feb 2021 16:10:18 +0100
Message-Id: <20210203151019.27036-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
References: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Usually, we get the status of block device by cat stat file, but we can
only know the total time with that file. And we would like to know more
accurate statistic, such as each latency range, which helps people to
diagnose if there is issue about the hardware.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  8 ++++++
 block/blk-core.c                      | 24 +++++++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  5 ++++
 4 files changed, 74 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 503314efec13..c4db84c507dd 100644
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
diff --git a/block/blk-core.c b/block/blk-core.c
index 5e752840b41a..1adc9f17e8b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1264,6 +1264,26 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	}
 }
 
+static void blk_additional_latency(struct block_device *part, const int sgrp,
+				   struct request_queue *q,
+				   unsigned long duration)
+{
+	unsigned int idx;
+
+	if (!blk_queue_io_extra_stat(q))
+		return;
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
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1288,6 +1308,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
+		blk_additional_latency(req->part, sgrp, req->q,
+				       now - req->start_time_ns);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1354,6 +1376,8 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, part->bd_disk->queue,
+			       jiffies_to_nsecs(duration));
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 304f8dcc9a9b..09cb177421e0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1146,6 +1146,42 @@ static struct device_attribute dev_attr_fail_timeout =
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
 #endif
 
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
+
 static struct attribute *disk_attrs[] = {
 	&dev_attr_range.attr,
 	&dev_attr_ext_range.attr,
@@ -1165,6 +1201,7 @@ static struct attribute *disk_attrs[] = {
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 	&dev_attr_fail_timeout.attr,
 #endif
+	&dev_attr_io_latency.attr,
 	NULL
 };
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index d2558121d48c..e2bde5160de4 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,6 +9,11 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+	/*
+	 * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+	 */
+#define ADD_STAT_NUM	12
+	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
-- 
2.17.1

