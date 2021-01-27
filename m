Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76897C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369E3207E2
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhA0PFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhA0PBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232EC0617A9
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rv9so3024693ejb.13
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZXXdM0nwviPv62C0/D2tg3TfLgw8aPPC00NN5WeuA0=;
        b=fm3IXoQ2OYKZ9VhqlCBbd0J83xXVTv7UrzYQkf2tl48qECnUNWJltfehSwIK2gcYun
         83xOcrWp0n+dOSZXHA+u+rBtoyK6bW4NlwMtKyoU0Dv5pWb353EOWFr1tR/WysRD9nBD
         wC1Cbu+FrMxvtAb6lrpgln1CfKKypj/vpP3RK+OPti2yTK7Sntf20ek5zpkC59r7JWCr
         r6mO066+yiDvyMT5uXDgVfrRm9NX2Q9zvOogPBZyrAvMVuAongIWjUVYg4cAFdbQ7BzD
         bLAlKfmR/Fhx/zjatPjzEe4QOCUV8ouLKrcZK3m1YEMJJjoudjLWy3OT8YWXfSlUXZK+
         1RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZXXdM0nwviPv62C0/D2tg3TfLgw8aPPC00NN5WeuA0=;
        b=pqXlnmB90+9rUWRHzCUQfkZbPsZZz4sJEFrDnwFeUnIlh9wSp+cgeCKHf4mIKKgg30
         5v3rKtPvXHOZxEr7HU2xYkHtqK1cKuXJobBK3MZgKauPbTlhBwnVg35IM7O2unfSxzve
         Qcv1MdRD1/NYQY3e6BKW0U1aYeEghS8CDzf8biBJ6mh4b+UY13kcIw44g79ZktRVaIAQ
         W+JoHnj2Fmdv5znBAW2ZMZL427Adwib3PL9qzTcCAEHnA7cxjz2BEVBmHaLtf23RtW1u
         1fBh3cPs+hNtGjOe3gnacA4tglQuUks00s5hWwKqX5moMlIHWDi6U2bB+NeuTishJwLr
         pBjA==
X-Gm-Message-State: AOAM5305nAzUVTNgjtdE/yawvNskgpPSNjK0yykpgVUDondyMyMW/1Bv
        HCcEgn6FzKDYwtadecvJtcfkAmrh3t9V3kx3
X-Google-Smtp-Source: ABdhPJx3SblMKmXno16NMPVtDPyYgNBOHAosuuQy0m5MZry6K65bVQmDJvDxZUmEqYYaBvuSYtJiRg==
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr7085599ejc.519.1611759587289;
        Wed, 27 Jan 2021 06:59:47 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:9172:bd00:1e95:fbc9])
        by smtp.gmail.com with ESMTPSA id j4sm1477140edt.18.2021.01.27.06.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:59:44 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/4] block: add a statistic table for io sector
Date:   Wed, 27 Jan 2021 15:59:28 +0100
Message-Id: <20210127145930.8826-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
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
index 27cd153e374b..4271c5a8e685 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1291,12 +1291,29 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
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
@@ -1348,6 +1365,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index cdbf56f05060..5c12cf7f90a0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1182,6 +1182,42 @@ static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr
 
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
@@ -1205,6 +1241,7 @@ static struct attribute *disk_attrs[] = {
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

