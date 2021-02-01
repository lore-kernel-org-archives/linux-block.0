Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5BAC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D742064E11
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBAB22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBAB2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 20:28:21 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729ADC061574
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:41 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id p8so14118392ilg.3
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gPA07TApmYgMe/+ATzhrdATR+t0VSsYJgvpytsoCLm4=;
        b=UWaeGcFSD6KuiJsogqTTKnzj3Mny08ILREV9xkOYnAu2nU4QP9ycwRKv9rPbxrVrbw
         pddrhBAhIG8QMLqrRCKuFzYHb1ch6i+Sp3QklKwjcONlV9FCsvyt7tUYinonWbSFndto
         pJE550yq+iz3eUxOgkcJtRskEoiZ9y6SvYyc3p2A14DTMvPAvXZP3uwef20varjltFIG
         z8ovYftP38zBnUiqZs+qHjSmkobZmrezCC8EMOXZs6BXYtDsNMO6abBzy3OJ8OchMnjM
         9NZhSkqV2TKyssmA5dfwtwO+Lvxz+kJ3tqnDu3HpM82J+JvMDSXslTNE1q9r8537lQmk
         2oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gPA07TApmYgMe/+ATzhrdATR+t0VSsYJgvpytsoCLm4=;
        b=ZI6PD4BZRLMesGJ/CvZx0Ba/vn+Y4V85jIxSo+ZNoyuK0MFalqplMxYArWyY+MMaxh
         Pd9OvJy/s2Y1/F49hPOM67NKIvF7vj0LY78RmFCwJ9dhEx7uHigfBMnoVMs5g86iNjWq
         RQM3i2wXK2+uT7xvqP9D7d8xTVLN0cbPjR0CDrpbRkxIIrmA0ajqbhvYYimLMB6nWFN+
         V+ZRtfly6iuo/c4aKzz8D49ZjzWt1qSRIvAdTsXxvZrV67o/e+t5odvTMpDtT+PWFslt
         5xOZpgnFpk8ALh4nldAimJELVIsJCir+HRL9WTBjFRhw4Zi0ivBUTtKa+il9YQBVr73s
         +cqA==
X-Gm-Message-State: AOAM5332Q6dV+xcB5OJTBJ/G3z2x/FhLhm4A8QvHtPhrJK5u6bsMTEI3
        +uBSjUU0aksBgefpPznVj7/nvvaewd0grjtK
X-Google-Smtp-Source: ABdhPJy1EqmrlDVQ2rJZUMIezRZsQXXmf6prYcRd6oWf20cXge5yP3QPjUvxb/aShSmCH/AvuxnqzQ==
X-Received: by 2002:a05:6e02:1c05:: with SMTP id l5mr11333526ilh.6.1612142859621;
        Sun, 31 Jan 2021 17:27:39 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:994d:fb60:3536:26f])
        by smtp.gmail.com with ESMTPSA id c19sm8539627ile.17.2021.01.31.17.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 17:27:39 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, hch@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 1/4] block: add a statistic table for io latency
Date:   Mon,  1 Feb 2021 02:27:24 +0100
Message-Id: <20210201012727.28305-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
References: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
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
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  8 ++++++
 block/blk-core.c                      | 19 ++++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  5 ++++
 4 files changed, 69 insertions(+)

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
diff --git a/block/blk-core.c b/block/blk-core.c
index 5e752840b41a..92933d39ded2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1264,6 +1264,22 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
 	}
 }
 
+static void blk_additional_latency(struct block_device *part, const int sgrp,
+				   unsigned long duration)
+{
+	unsigned int idx;
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
@@ -1288,6 +1304,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
+		blk_additional_latency(req->part, sgrp,
+				       now - req->start_time_ns);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1354,6 +1372,7 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, jiffies_to_nsecs(duration));
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

