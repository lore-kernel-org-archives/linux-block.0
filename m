Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B347C433E1
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77ACB20672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PiJN2FK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGHH7c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH7b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E417C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so40857961edr.2
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+fdVmMPaMuEYUAagJU6UlGTtXsN3VBZ222XdaGlwDBk=;
        b=PiJN2FK6vAbivDgzWfmg0WGjwJBe/IGhPDjYyvAtWXGPHEkJCwep0RgoucpaBPpxox
         WglV0X4aRDkTq2VYuEfalL5cjTTgf+eV3gsKJ0ZN04sPnVxFpdx5w+WvF8n/haJw/QSX
         VumYwW4YSiVB1RYhC7AgtL8/nshuwGLhQo1ZCoI+ysIOhlnD36c2lmeuRL+jUT50/gUP
         pT0z5H7+XXIRE6/u8sacyLn/ZE61kpKP8CxCwpYleyTFrmRSJuVKC4NfaGseDQDbfG0T
         tOe5tqtl5octDmg2jXKXZEzMbRXBfLUYcELFId8NbqW1Uk0fyvuzGysPqKPjIL5/2zSa
         QAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+fdVmMPaMuEYUAagJU6UlGTtXsN3VBZ222XdaGlwDBk=;
        b=NyWZWpMM5L+8a8B0fC2F2HwTP14xir2mYP3GkAQqKx60saYUnozKIOspX53eBclv8X
         oZXSBsJMJ5qiWbKjKPdiHv3GHb2OsjPCz5ZuVzZz+PfpXj0rB9BkLA9KjL3rNAWB+3hf
         hYXH8TNTMQ2FyLgdqNQNDPrbgEg0zl4/gFm37yuZ8KJZmriuN5jkDHjkfq6pMNWHA1RW
         OCsFnHjsC4xAQM+Fjj0c7mVpQcqyvYBjIAxlYttBd7QFCzBwp0H32TlZMcjjNLnPMJSi
         PS1Ej6A5+Tf4e3Q8XQOpuR7haGVpn6kIlbuyrEIw9QMuQ5Pnnc7m01QlcY6X/g8vyMaY
         RJzQ==
X-Gm-Message-State: AOAM531SL9Lt1cj82qOXeOLFs+Dg5mfBKXvpPswxJF2ydT9SsqreA2sy
        5Wp4QpJU1iVq3KMXgZlimRrWUw==
X-Google-Smtp-Source: ABdhPJxs6AqMXeeFUeaFL47L+X2Cjx2PKsI1FavylLR2xNVZeda5MC4mQQUd/PqabTiD999JoUOplA==
X-Received: by 2002:a05:6402:947:: with SMTP id h7mr65667801edz.213.1594195169786;
        Wed, 08 Jul 2020 00:59:29 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:29 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: [PATCH RFC 4/5] block: add a statistic table for io latency
Date:   Wed,  8 Jul 2020 09:58:18 +0200
Message-Id: <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
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
want to know the additional statistics or not, and we also
use the option for io sector in next patch.

Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/Kconfig             |  8 ++++++++
 block/blk-core.c          | 35 +++++++++++++++++++++++++++++++++++
 block/genhd.c             | 26 ++++++++++++++++++++++++++
 include/linux/part_stat.h |  7 +++++++
 4 files changed, 76 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 9357d7302398..dba71feaa85b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -175,6 +175,14 @@ config BLK_DEBUG_FS
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
index 0e806a8c62fb..7a129c8f1b23 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1411,6 +1411,39 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
 	}
 }
 
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+/*
+ * Either account additional stat for request if req is not NULL or account for bio.
+ */
+static void blk_additional_latency(struct hd_struct *part, const int sgrp,
+				   struct request *req, unsigned long start_ns)
+{
+	unsigned int idx;
+	unsigned long duration, now = ktime_get_ns();
+
+	if (req)
+		duration = (now - req->start_time_ns) / NSEC_PER_MSEC;
+	else
+		duration = (now - start_ns) / NSEC_PER_MSEC;
+
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
+#else
+static void blk_additional_latency(struct hd_struct *part, const int sgrp,
+				   struct request *req, unsigned long start_jiffies)
+
+{
+}
+#endif
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
@@ -1440,6 +1473,7 @@ void blk_account_io_done(struct request *req, u64 now)
 		part = req->part;
 
 		update_io_ticks(part, jiffies, true);
+		blk_additional_latency(part, sgrp, req, 0);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1489,6 +1523,7 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], duration);
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 60ae4e1b4d38..a33937a74fb1 100644
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

