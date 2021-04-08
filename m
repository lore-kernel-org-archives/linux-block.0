Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4F5C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FFA610FA
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhDHN7T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHN7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 09:59:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD3C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 06:59:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so2986659wmy.5
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqJ3OgsOwwcseCNm8ByCG5mwhmpA16wMdBXpRAizjEU=;
        b=OD8pStMHlAlNbmzsQgs+UaLl343LNe5Qulp18rFV0UJXKCSwFjzTbpM14Ut/2UafQk
         NPGvGxsPjosL/gCk99rYVgXUqCtu+fxjt/CzkUVSAgODLR8EJDGoIdvIoARSZMnQoDDi
         6LF1G3nddsY0LJOiQJq0kUXG2VHAC+UcJcKD1oA+fU32UPUvT7U65YWiO6HHwXa1OTY3
         eXwcIPzkN9C6vFtAkyuDbgAIoicA+4bQ/WUSc59OtUnGj5+BsB0ZZGwSqdfdJ1EL+zsJ
         j1f2kAQOpkX2fdPa/mpVPJXTlDgTrAfoLT+ef4nkaWS12lriU+o8MkWQDnDtQsdcq+rI
         ufSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqJ3OgsOwwcseCNm8ByCG5mwhmpA16wMdBXpRAizjEU=;
        b=fyr23Ox/0AyK/h8j+s3qZXfX9fwL0n06DZwGhR8Pu7qMoC/6QFnDD9X9WEVsqNlbis
         7QrOt7GQu0YC93dVxLi3FwBGYHwDBtouqJcvM9G7mSr9CJn9Ynll7HJk2l0n9Ro1rpj9
         eY9aStn+DGsV0DKuiI0I+XUtTO8bKJSp6j+oYGUkY7P9Pe9LgiBktpqreanSifvHN6I6
         ZWv9bUu8JyTz8vBsWjqwEAOCB3b+MK9XCtS8QYnERgasovL2BLZpjpOVp7NVc1qZLPSd
         K8fvPiXUducAvJP4nw/1Ws0dOTTJAw/CW1izD9o6fHO9BKmsfZoTwHtF7+ormzU+wNei
         Ublg==
X-Gm-Message-State: AOAM5325JEuHR+VKzLhopOz0ewRCn5RGQS6tiR+HE3V8lzHhf28sZNeK
        aG9bATpIBE+r/YIdKBoZVbAgFA==
X-Google-Smtp-Source: ABdhPJxeJEvo0VF531mJMt26VONV5Cywn1Zzfzf0fLZGPzApyNrNFvrW5vrCqv7d032knlGM7HGbMA==
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr8760791wmr.69.1617890339679;
        Thu, 08 Apr 2021 06:58:59 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:5dfa:e648:2da1:1094])
        by smtp.gmail.com with ESMTPSA id c6sm45080294wri.32.2021.04.08.06.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:58:59 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V5 2/3] block: add a statistic table for io latency
Date:   Thu,  8 Apr 2021 15:58:39 +0200
Message-Id: <20210408135840.386076-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408135840.386076-1-haris.iqbal@ionos.com>
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@ionos.com>

Usually, we get the status of block device by cat stat file, but we can
only know the total time with that file. And we would like to know more
accurate statistic, such as each latency range, which helps people to
diagnose if there is issue about the hardware.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@ionos.com).

Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Cc: Guoqing Jiang <jgq516@gmail.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  8 ++++++
 block/blk-core.c                      | 24 +++++++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  5 ++++
 4 files changed, 74 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index aee7464b35da..a027e5afc35a 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -27,6 +27,14 @@ Description:
 
 		For more details refer Documentation/admin-guide/iostats.rst
 
+What:		/sys/block/<disk>/io_latency
+Date:		March 2021
+Contact:	Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
+Description:
+		The /sys/block/<disk>/io_latency files displays the I/O
+		latency of disk <disk>. With it, it is convenient to know
+		the statistics of I/O latency for each type (read, write,
+		discard and flush) which have happened to the disk.
 
 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
diff --git a/block/blk-core.c b/block/blk-core.c
index 9bcdae93f6d4..0895d5eddc1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1263,6 +1263,26 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
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
@@ -1287,6 +1307,8 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
+		blk_additional_latency(req->part, sgrp, req->q,
+				       now - req->start_time_ns);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1353,6 +1375,8 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, part->bd_disk->queue,
+			       jiffies_to_nsecs(duration));
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index 8c8f543572e6..e054dc5ac9c4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1144,6 +1144,42 @@ static struct device_attribute dev_attr_fail_timeout =
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
@@ -1163,6 +1199,7 @@ static struct attribute *disk_attrs[] = {
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
2.25.1

