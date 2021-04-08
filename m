Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3491C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDB0610E5
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhDHN7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHN7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 09:59:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A395C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 06:59:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a6so2258397wrw.8
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeX/zeEODTwsXUjbwigq5L5/TmzwrBx3BRSe6uCkKDs=;
        b=Q4Ixc54Qts/ZWP8TnhI/wsxUnnWrsgrFcbitajvlVjCUmVbpwY8EQBxD3Vc7memn9w
         lYB7Gy4D4rwm4aCgIJSLH9sJgu9c64/HgrpPD7/AkbC9dihV1dnTHlOgEJWH1CHIrP7L
         L5Hkf0Lb/zBK8Vnf6ppEP5Ntm5ljwCaxSmjegZ/eDO83a/XvMgjlaTpTQu7pxTd3g+iZ
         N6d1h22jj1WCAVejqg22gw9vLIF7ibj0nU8RKVmKb1IaO+FBZQCVYysu2oiiB0+Padg1
         3vm1eh3q/DPz5gBcK4UtqkgiDO0TUR6UEyEyBzifn403hlEdFQLs2T0s/KngLqDw4hc+
         XAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeX/zeEODTwsXUjbwigq5L5/TmzwrBx3BRSe6uCkKDs=;
        b=SymdED0jquDQCkhDIV0Pv9RszB3o9cJ16reQBkG8GbVcNjaNKs06k1LL4rKAwZHW4K
         xHZzKgPzqrxopbqWdY0ONMZkIX/TWQuefQ/+c4ISdeEsip2bCTzcsiL+nAVhxv+Fpeda
         cQ6Bfndl5n93UPDL+CQTiNwaIuOUxHM2l69S0Nhn9FoK+NNgTNZVYlUc00VNahWZf4ay
         3KsReRH+cNzkhZgq+8pCvAhxWXs/Nz+3IJPbzF5S8d3+eWmdzgzTkx91VhWs6uH7tFDi
         9VgP1o89Pj6Kx+iPivfFtV4WeOXcvhVJQ7PEgFm8VyF78Jw3jhbJ9fU+HU8DxLt74NUu
         aRcA==
X-Gm-Message-State: AOAM530QCO3cW6ZqBWyJoPNeCMtquh1HYVgXZGbW+m1C8xFS+GJWmivQ
        4TjaAYNhU7XtJuj5oMpH1e97yrmlZN5MNQ==
X-Google-Smtp-Source: ABdhPJyxkBT5fhfJV3UOR1mv3EmU2WHiyNcVi9tRdf97xu8V8VtFXi82tEb7c2LSNQ5RD1CbwoT3Pg==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr11531503wrw.3.1617890351326;
        Thu, 08 Apr 2021 06:59:11 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:5dfa:e648:2da1:1094])
        by smtp.gmail.com with ESMTPSA id c6sm45080294wri.32.2021.04.08.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:59:11 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V5 3/3] block: add a statistic table for io sector
Date:   Thu,  8 Apr 2021 15:58:40 +0200
Message-Id: <20210408135840.386076-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408135840.386076-1-haris.iqbal@ionos.com>
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@ionos.com>

With the sector table, so we can know the distribution of different IO
size from upper layer, which means we could have the opportunity to tune
the performance based on the mostly issued IOs.

This change is based on our internal patch from Florian-Ewald Mueller
(florian-ewald.mueller@ionos.com).

Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Cc: Guoqing Jiang <jgq516@gmail.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 Documentation/ABI/testing/sysfs-block |  9 +++++++
 block/blk-core.c                      | 19 ++++++++++++++
 block/genhd.c                         | 37 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  3 ++-
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index a027e5afc35a..78f84cd44bf0 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -36,6 +36,15 @@ Description:
 		the statistics of I/O latency for each type (read, write,
 		discard and flush) which have happened to the disk.
 
+What:		/sys/block/<disk>/io_size
+Date:		March 2021
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
index 0895d5eddc1f..899b0b08f92d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1283,12 +1283,30 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
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
@@ -1341,6 +1359,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, part->bd_disk->queue, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index e054dc5ac9c4..94a692785fed 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1180,6 +1180,42 @@ static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr
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
@@ -1200,6 +1236,7 @@ static struct attribute *disk_attrs[] = {
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
2.25.1

