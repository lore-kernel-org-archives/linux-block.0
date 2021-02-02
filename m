Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB75EC433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB27064EAA
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBBDLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBBDLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 22:11:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80AC0613ED
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 19:10:32 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m20so10229053ilj.13
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 19:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fb8F92S38+WcPP1MG8vZXkUKxqhKNM+lh5T4r/uwaS4=;
        b=D5HzbILYIm8QqyHkTqc9ZH/3tVmeYBVkJLBH5RaVXLzmCQFhfoGEDT/3jGBA/HLJsx
         tbRnwKuAZ/mabBhsX9+yeb3GH1C9Fm95Ik1x5HkgSEqAJkNGETVlYZFX95tpJtdtzFqR
         VYOWsTkjq558Qh4YHkbj2h64cDHORI3d1vaFSLxPDBL/tnZJFSyEj3SmHIrv8ptzMlQM
         nAh1Ogr1H1wdN3nFg+zZAmrm//Ic621lmQ8DaFLY9pmqOfc23ubuSHYofJiK5Ju07jf2
         IMEGrq/Fy0R6ZA9SG4XxvQZaI2PypIZ0MrH+c6uk/CN4UagSNHMcnxlGWlOqvQD3qLEd
         5tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fb8F92S38+WcPP1MG8vZXkUKxqhKNM+lh5T4r/uwaS4=;
        b=S5UUhDwCt5iJmBB/NmzZNcElkjW6qjUzaTafUJbvPPOFWc4Bi/7C2/umf0xoTA3tn/
         kwIgkQeXvopdRGULADWljaN1dr6IFeW4O+nZJX9ROalqSshY2Nr3PgEkn/1I0qYXPBrn
         tRvOOyLd7+KGToOi9DYvKe8Pr92/UI2lSVg8B66RVIBNo+yhjvswTHiKGNcMA9aL+mZV
         Kra2xbh9iSdpMO8ECJsE0hgXE81giCTd+0SUPbXPGrvXj8HQJ0L7FgKKNkRI0yLsUJSY
         96THDbM00nyqo+HuHky/QaH6OdKDbU3j53rEvexLgnzeOgETcNAOb915iCYYGpT9IWul
         K8UQ==
X-Gm-Message-State: AOAM530CA4ou7WCLPwJlATS7dpbLLpw6/ZFFcDKKLJ7oJkuNPIxqvFdz
        TqQkupEXuX3oFuhv+nbeGecRTQ==
X-Google-Smtp-Source: ABdhPJz6ZrQzFt2RMat2PUVvurvzQVIHMVG7bZyl6Kc8IbIiyhVNXUo0qsKji4Bup/PFebnFmeFMUA==
X-Received: by 2002:a92:2c08:: with SMTP id t8mr15203446ile.59.1612235431015;
        Mon, 01 Feb 2021 19:10:31 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c05c:3bba:187c:cddb])
        by smtp.gmail.com with ESMTPSA id q5sm9099307ioi.43.2021.02.01.19.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:10:30 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 3/3] block: add a statistic table for io sector
Date:   Tue,  2 Feb 2021 04:10:09 +0100
Message-Id: <20210202031009.11584-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
References: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the sector table, so we can know the distribution of different IO
size from upper layer, which means we could have the opportunity to tune
the performance based on the mostly issued IOs.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@cloud.ionos.com).

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  9 +++++++
 block/blk-core.c                      | 19 ++++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  3 ++-
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index c4db84c507dd..e1611c62a3e1 100644
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
diff --git a/block/blk-core.c b/block/blk-core.c
index 1adc9f17e8b7..a44684033382 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1284,12 +1284,30 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
 	part_stat_inc(part, latency_table[idx][sgrp]);
 }
 
+static void blk_additional_sector(struct block_device *part, const int sgrp,
+				  struct request_queue *q, unsigned int sectors)
+{
+	unsigned int idx;
+
+	if (!blk_queue_io_extra_stat(q))
+		return;
+
+	if (sectors == 1)
+		idx = 0;
+	else
+		idx = ilog2(sectors);
+
+	idx = (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
+	part_stat_inc(part, size_table[idx][sgrp]);
+}
+
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
+		blk_additional_sector(req->part, sgrp, req->q, bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1342,6 +1360,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, part->bd_disk->queue, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index 09cb177421e0..f43574d9dc8c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1182,6 +1182,42 @@ static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr
 static struct device_attribute dev_attr_io_latency =
 	__ATTR(io_latency, 0444, io_latency_show, NULL);
 
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
+
 static struct attribute *disk_attrs[] = {
 	&dev_attr_range.attr,
 	&dev_attr_ext_range.attr,
@@ -1202,6 +1238,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_fail_timeout.attr,
 #endif
 	&dev_attr_io_latency.attr,
+	&dev_attr_io_size.attr,
 	NULL
 };
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index e2bde5160de4..221fb3a884b2 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -10,10 +10,11 @@ struct disk_stats {
 	unsigned long ios[NR_STAT_GROUPS];
 	unsigned long merges[NR_STAT_GROUPS];
 	/*
-	 * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+	 * We measure latency (ms) and size (KB) for 1, 2, ..., 1024 and >=1024.
 	 */
 #define ADD_STAT_NUM	12
 	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+	unsigned long size_table[ADD_STAT_NUM][NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	local_t in_flight[2];
 };
-- 
2.17.1

