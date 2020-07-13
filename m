Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81022C433DF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592762077D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KqHuHUAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGMVNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGMVNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3872CC061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so19019433ejc.8
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nvoC+buu5tasYx6T8UBAK6LFJaCdJgALnFZc/9QT04M=;
        b=KqHuHUAnCR/6DqOS8U6H/f4y0mOneoVWxjNEMglmjVVvv85PlkzQpvQpgroFZXq0fO
         VmcvAZhanPBHQIcMFmxQ2Dhc/ODSYB8f6SPRqwdvCM7uQ2dzsjm+DZZwK+hX7MW+ynKA
         +SR3UBOH9tYA5GYDXl+jTn/oOeTMGa/YjjydtcmT3vmWPWsZ3ipVnnSFnGNBhXHvBGyf
         tR0i7mRp8W+h3t6j8dCmuz0l30ZKldDV11JTB4MBlJ/yIGGO38c+aGfNkZIDmjjigTh0
         cjbQMHHzijLU5jDisAmDVC8sxZB+KcRgFmXnsmCOdhmV08O0H/aQreF1JUFCOWvEvCgH
         ko6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nvoC+buu5tasYx6T8UBAK6LFJaCdJgALnFZc/9QT04M=;
        b=XBCcIUZ/MHr1/9KoULuboH1nnbdR56zOWJWnViDXGdYFaEt0GzrMSGJh/8guH+2aws
         eua/cJnPZ2YmAZISMD3WSspjwakDrvlm2IVHBEkmdPG/0myUT5gf5dsO1rOxPXHn/5Z4
         O0V72OHBHN3y71AM8zuUZ0p0au2ekjrnZZFAzyG4oGd0WOCGIRKDiBfBVzdnG037hQgY
         h0NNQmbRnEJ0aNT3eoZBQGHuHjfaaCot8GHrG+Nm9IiWVSx0elr7JSGQpEatQEIGwT9b
         3LgL5/Vo+yuFEQoRHpIkYQsaS/Gf6jgZj1e+xOx9YjRKcNnbCuhYy/xQbStjtGAUsu/Y
         XzIQ==
X-Gm-Message-State: AOAM533m/yP2pe9o3k7oOLAGZA+OoT/uZiva4tm+e6ZnLwDLRR/sDf/r
        WCBcvAX6Lxyh4GWTkbJpS8APLQ==
X-Google-Smtp-Source: ABdhPJxxM+lXnY1Pv5jC54SILewDa0FsTTF0olUY17HzRDOMvh8J3mDj/T/HYIIXLvmQ1k48kM7r6w==
X-Received: by 2002:a17:906:7c07:: with SMTP id t7mr1626502ejo.487.1594674833855;
        Mon, 13 Jul 2020 14:13:53 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ab:24b8:5892:2244])
        by smtp.gmail.com with ESMTPSA id d5sm12715770eds.40.2020.07.13.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:13:53 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: [PATCH RFC V2 1/4] block: add a statistic table for io latency
Date:   Mon, 13 Jul 2020 23:13:18 +0200
Message-Id: <20200713211321.21123-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Usually, we get the status of block device by cat stat file,
but we can only know the total time with that file. And we
would like to know more accurate statistic, such as each
latency range, which helps people to diagnose if there is
issue about the hardware.

Also a new config option is introduced to control if people
want to know the additional statistics or not, and we use
the option for io sector in next patch.

Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/Kconfig             |  8 ++++++++
 block/blk-core.c          | 34 ++++++++++++++++++++++++++++++++++
 block/genhd.c             | 26 ++++++++++++++++++++++++++
 include/linux/part_stat.h |  7 +++++++
 4 files changed, 75 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index bbad5e8bbffe..360f63111e2d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -176,6 +176,14 @@ config BLK_DEBUG_FS
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
index d9d632639bd1..036eb04782de 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1411,6 +1411,34 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 	}
 }
 
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+/*
+ * Either account additional stat for request if req is not NULL or account for bio.
+ */
+static void blk_additional_latency(struct hd_struct *part, const int sgrp,
+				   struct request *req, unsigned long start_jiffies)
+{
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
+
+}
+#endif
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1440,6 +1468,9 @@ void blk_account_io_done(struct request *req, u64 now)
 		part = req->part;
 
 		update_io_ticks(part, jiffies, true);
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+		blk_additional_latency(part, sgrp, req, 0);
+#endif
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1488,6 +1519,9 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	blk_additional_latency(part, sgrp, NULL, start_time);
+#endif
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index c42a49f2f537..f5d2f110fb34 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1420,6 +1420,29 @@ static struct device_attribute dev_attr_fail_timeout =
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
 #endif
 
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	size_t count = 0;
+	int i, sgrp;
+
+	for (i = 0; i < ADD_STAT_NUM; i++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%5d ms: ",
+				   (1 << i) * HZ_TO_MSEC_NUM);
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(p, latency_table[i][sgrp]));
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
@@ -1438,6 +1461,9 @@ static struct attribute *disk_attrs[] = {
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
index 24125778ef3e..fe3def8c69d7 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -9,6 +9,13 @@ struct disk_stats {
 	unsigned long sectors[NR_STAT_GROUPS];
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+/*
+ * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+ */
+#define ADD_STAT_NUM	12
+	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+#endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
-- 
2.17.1

