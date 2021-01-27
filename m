Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29375C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE43D207FC
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhA0PFW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhA0PBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D5C0617A7
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bl23so3078970ejb.5
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ySpizCGBHZcRBItw9WwXPpD1Uaiz2HbJL0Kyu+cvr0=;
        b=VF7L3ao7JgxJicRBkk+vQHnkh5DVfT8K0tAo1XRwAn6Thi7pD1Vhr41jROPqEsmL2M
         3niY2xKMDd4SAUqzA93zJNpjpB5tUwByy1vr2rw9LY2lOM++8WL9yiFjwKkmerF7Fhio
         Rg4lCF2tD6H/iITFNDd/Y4sGE4gMpfj216u4gVuI5cbpE15vA/2jsYRxv5fAY8p7VBv2
         uWNRBO15yk3swsuSkNsVZ8b8NKF0YNoKdxkuk6TJuSrLG9bPGXeJHS453peZvEBtrrFB
         ZC+HkmOz0NsdevNrraMv0C3lHANFh4Rg/KeugPx8P9G8Y56cZoW6QgVn/urDpEsg7y+4
         ixvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ySpizCGBHZcRBItw9WwXPpD1Uaiz2HbJL0Kyu+cvr0=;
        b=R9kOxiudM89b1kLh+CA5LV1CA5u4EdmiIxEbqrX6H9/I9bEIaU8KaDregaVmYjbgkW
         OGFTv/LXawX62+Fj9REY4nwFPAZKsHCvwZoEnzKlsa8HEYSgOS2JLt9as/nX81hLL7SR
         HmMUjTOvcjdbrvslKWcODy6zdBgJzaaFmhonyCgwvDkongMUpujwxEBam8m4NWGX7QLU
         5Pk1+j/qx3db/YJXtYaiHWPCWvtc0EL61VqrCQhy1c3Ecwf7sP9sMbpS8KCSLYhDY2D+
         SoNWT+6bVULfr6szWN+qGF8JYvEot1SQmHr+2Rad+5sSBWc7YdI+V/fa0dn87VOzxE6/
         M5jA==
X-Gm-Message-State: AOAM532/Uhyz50uT5rNM6dl1qJpeHVQhN42jFGz32ReoZVlsSWKTMpcp
        FeTUOtoSI91TfwB0Szz+cIkkGQ==
X-Google-Smtp-Source: ABdhPJx+9mcQtAWge4HsMSsjdGMtGTVFAcVj6aMRLqSBrvsD1c5+9Wz3fFGRP9vGpV47BrzjrUNApA==
X-Received: by 2002:a17:906:ce5b:: with SMTP id se27mr6964228ejb.57.1611759584369;
        Wed, 27 Jan 2021 06:59:44 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:9172:bd00:1e95:fbc9])
        by smtp.gmail.com with ESMTPSA id j4sm1477140edt.18.2021.01.27.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:59:43 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 1/4] block: add a statistic table for io latency
Date:   Wed, 27 Jan 2021 15:59:27 +0100
Message-Id: <20210127145930.8826-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
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

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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
index 5e752840b41a..27cd153e374b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1264,6 +1264,33 @@ static void update_io_ticks(struct block_device *part, unsigned long now,
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
@@ -1288,6 +1315,7 @@ void blk_account_io_done(struct request *req, u64 now)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, true);
+		blk_additional_latency(req->part, sgrp, req, 0);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
 		part_stat_unlock();
@@ -1354,6 +1382,7 @@ static void __part_end_io_acct(struct block_device *part, unsigned int op,
 
 	part_stat_lock();
 	update_io_ticks(part, now, true);
+	blk_additional_latency(part, sgrp, NULL, start_time);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
 	part_stat_local_dec(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
diff --git a/block/genhd.c b/block/genhd.c
index d3ef29fbc536..cdbf56f05060 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1146,6 +1146,44 @@ static struct device_attribute dev_attr_fail_timeout =
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
@@ -1164,6 +1202,9 @@ static struct attribute *disk_attrs[] = {
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

