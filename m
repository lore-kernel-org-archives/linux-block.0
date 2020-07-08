Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A9C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA620672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="CCauQiPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGHH7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:32 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620BC08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so49333618eje.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HGL0/NjRqg+TuE5uhO+UupwMyr96BY1LZWkXHNAnP38=;
        b=CCauQiPfdITyCagQ1hYwZjmZaaNACw+SWRTmKfygoY8EFTbq79cXhsFXL9B5rcY94I
         bu7c4XzYRRKsx0w8QapyZHAgk7wF8nuWKlJyC3UzmuJAk1+zWKPNgdUYtqZeLvH62Blz
         TV0Jr9xFW302Kp88TX6ValS4JJsr3bERSK9h+JXWy6K3OjJtaOgkaEWElWzMSuOdhXZM
         3N4grvm7lYiPiaEB2C1wivG9lBumi1dMop3Gkk0Za4cu2iI8uMLupPzQHgPOtN5nh7YT
         fepUlNigr9t5i5EtTkLjeIAGllKTo4DKby30nYe32dVSd/Kj4lq90MifM1Q3GBMFo7MT
         1x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HGL0/NjRqg+TuE5uhO+UupwMyr96BY1LZWkXHNAnP38=;
        b=h8v1Ig1A1xV4zwaULBgp0IfTg1d0TIDS3/UmG8iO1MzCWNb7NX8MDorq9Q/2luERM/
         ytuA8EUx0ZE7FxYK1jBJ1G4teyI5wMsrmZa2fmVr3ca26pi5VP9rJJRi648FPs7/cuvV
         8Pej2XWmPUpFtG1oqUWjTlJXKa8eyEYLUk/ClsEtverTINi3neQ6fu/1S+GDnaumTFIZ
         yp9K3e3i3yc2dWBoPaMPVQ75XodhdAwCu2GYLruslfmIjnXS2pQ7JbWf+dy5Ngw4WfCx
         gwMl2lsXRBizzDBzhyDpcS5ZnQHt2IL/PMWrjGa9RgKsGFd+gWfCCTx+PxS6T9mcW707
         Yx7g==
X-Gm-Message-State: AOAM533ksQ03NK/raql9QYcEkLm5FixvDYLiEGc9W3AbE56UNg5g/uaA
        4zeMVZHVQKo3OatERIxIajrtlQ==
X-Google-Smtp-Source: ABdhPJwI0L3xl+LgGFaxJoeDGCtyVV2OTvtGjQRz/nNeY2dTej8cVOX8I27nxckXm3VRWvhD7DLuYA==
X-Received: by 2002:a17:906:7005:: with SMTP id n5mr32139970ejj.130.1594195170860;
        Wed, 08 Jul 2020 00:59:30 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:30 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: [PATCH RFC 5/5] block: add a statistic table for io sector
Date:   Wed,  8 Jul 2020 09:58:19 +0200
Message-Id: <20200708075819.4531-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the sector table, so we can know the distribution of
different IO size from upper layer, which means we could
have the opportunity to tune the performance based on the
mostly issued IOs.

Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/Kconfig             |  3 ++-
 block/blk-core.c          | 19 +++++++++++++++++++
 block/genhd.c             | 21 +++++++++++++++++++++
 include/linux/part_stat.h |  3 ++-
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index dba71feaa85b..f1c4800969ef 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -179,7 +179,8 @@ config BLK_ADDITIONAL_DISKSTAT
 	bool "Block layer additional diskstat"
 	default n
 	help
-	Enabling this option adds io latency statistics for each block device.
+	Enabling this option adds io latency and io size statistics for each
+	block device.
 
 	If unsure, say N.
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 7a129c8f1b23..d3c9f727926f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1436,12 +1436,29 @@ static void blk_additional_latency(struct hd_struct *part, const int sgrp,
 	part_stat_inc(part, latency_table[idx][sgrp]);
 
 }
+
+static void blk_additional_sector(struct hd_struct *part, const int sgrp,
+				  unsigned int sectors)
+{
+	unsigned int KB, idx;
+
+	KB = sectors / 2;
+	idx = (KB > 0) ? ilog2(KB) : 0;
+
+	idx = (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
+	part_stat_inc(part, size_table[idx][sgrp]);
+}
 #else
 static void blk_additional_latency(struct hd_struct *part, const int sgrp,
 				   struct request *req, unsigned long start_jiffies)
 
 {
 }
+
+static void blk_additional_sector(struct hd_struct *part, const int sgrp,
+				  unsigned int sectors)
+{
+}
 #endif
 
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
@@ -1452,6 +1469,7 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 
 		part_stat_lock();
 		part = req->part;
+		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
 		part_stat_add(part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1506,6 +1524,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index a33937a74fb1..68e4735662f3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1441,6 +1441,26 @@ static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr
 
 static struct device_attribute dev_attr_io_latency =
 	__ATTR(io_latency, 0444, io_latency_show, NULL);
+
+static ssize_t io_size_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	size_t count = 0;
+	int i, sgrp;
+
+	for (i = 0; i < ADD_STAT_NUM; i++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%5d KB: ", 1 << i);
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count += scnprintf(buf + count, PAGE_SIZE - count, "%lu ",
+					   part_stat_read(p, size_table[i][sgrp]));
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
@@ -1464,6 +1484,7 @@ static struct attribute *disk_attrs[] = {
 #endif
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 	&dev_attr_io_latency.attr,
+	&dev_attr_io_size.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index fe3def8c69d7..2b056cd70d1f 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -11,10 +11,11 @@ struct disk_stats {
 	unsigned long merges[NR_STAT_GROUPS];
 #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
 /*
- * We measure latency (ms) for 1, 2, ..., 1024 and >=1024.
+ * We measure latency (ms) and size (sector) for 1, 2, ..., 1024 and >=1024.
  */
 #define ADD_STAT_NUM	12
 	unsigned long latency_table[ADD_STAT_NUM][NR_STAT_GROUPS];
+	unsigned long size_table[ADD_STAT_NUM][NR_STAT_GROUPS];
 #endif
 	unsigned long io_ticks;
 	local_t in_flight[2];
-- 
2.17.1

