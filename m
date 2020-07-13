Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE7C433E0
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5632077D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="TsUXx9Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGMVN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGMVN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33769C061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so19073585eje.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/VznLOsshgoMt5W+c7bCNEFnLgiMUJ304FQKLIA/e4=;
        b=TsUXx9VkJKt1VECQilTb5T661s6RQMsV9Mw9r4xMyxPiKQAqU125t+LjkavZtLKwih
         uNhcx/gK2RTHzIaDOE3VjeLV+9nNIsb3+3vf0bjfy04VfY5UnF5Q3IL6EFqFmDZJ5MZz
         eTmFq5dtHEKies3o2lh1P1counpy5DwGNvtHcMJoPtvujmPsSlYmSCPl5IGJWD0Jb5Xr
         UBn92s891s4Fdg/3YirwvtW3tL9rpThK7PACtkoKLTvcoMHHGqElqG2+t6qt5Cc6J63f
         kFS5WwMv3IYLYknCENG6vYhojkIlXjnQUPcXqiipsHp5bVVgFKBaMo1njhHSawnCROG2
         DUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/VznLOsshgoMt5W+c7bCNEFnLgiMUJ304FQKLIA/e4=;
        b=C2Dx/tkjzIpTZ2caCEqxlz6bR4kiWvAc6upS/QJC67AN9GE50UL89PTqLtqPlTRE+s
         IZumj+dF65uclT0XqaZrnvQ3/GDckneG5iJfA1gu8DpIwvi2dzRPMwvqju2ZmD0FW0qg
         EZ7BOO2kg0IMeulxHfn45uNe8ErhFrP+Mxi1k9iU2k40uDoVVpudczzr1mjrvGIQn3IM
         AmUr9GJrY4c7wPB51IQYLnR8CwVi9E+n4ecWxCl37bENERD/LsqmAAlGBOfZ/m0lUdtu
         qDr9OdMWIe2WBH5TH183IA+AnCoIOgJ7KLPHxnRktFJ0TGjR4icjceYYTlmO0B41PwwE
         tTlQ==
X-Gm-Message-State: AOAM533vzjV0fNNGONMaf1VyrOAy+NUpGKLYcqFKGyJUu6MxtNnlTVIw
        QKMj2zM3aGDpmvrC0gZ19U1llA==
X-Google-Smtp-Source: ABdhPJxkdlyc07zyQ6n4STS3RogHmpzreiV3pvGXqJ4rYEBGyDgOBIXgxOMmBA4PVKSgD4n6UXrrBA==
X-Received: by 2002:a17:907:20ba:: with SMTP id pw26mr1510594ejb.425.1594674834836;
        Mon, 13 Jul 2020 14:13:54 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ab:24b8:5892:2244])
        by smtp.gmail.com with ESMTPSA id d5sm12715770eds.40.2020.07.13.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:13:54 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: [PATCH RFC V2 2/4] block: add a statistic table for io sector
Date:   Mon, 13 Jul 2020 23:13:19 +0200
Message-Id: <20200713211321.21123-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
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
 block/blk-core.c          | 16 ++++++++++++++++
 block/genhd.c             | 21 +++++++++++++++++++++
 include/linux/part_stat.h |  3 ++-
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 360f63111e2d..c9b9f99152d8 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -180,7 +180,8 @@ config BLK_ADDITIONAL_DISKSTAT
 	bool "Block layer additional diskstat"
 	default n
 	help
-	Enabling this option adds io latency statistics for each block device.
+	Enabling this option adds io latency and io size statistics for each
+	block device.
 
 	If unsure, say N.
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 036eb04782de..b67aedfbcefc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1437,6 +1437,16 @@ static void blk_additional_latency(struct hd_struct *part, const int sgrp,
 	part_stat_inc(part, latency_table[idx][sgrp]);
 
 }
+
+static void blk_additional_sector(struct hd_struct *part, const int sgrp,
+				  unsigned int sectors)
+{
+	unsigned int KB = sectors / 2, idx;
+
+	idx = (KB > 0) ? ilog2(KB) : 0;
+	idx = (idx > (ADD_STAT_NUM - 1)) ? (ADD_STAT_NUM - 1) : idx;
+	part_stat_inc(part, size_table[idx][sgrp]);
+}
 #endif
 
 static void blk_account_io_completion(struct request *req, unsigned int bytes)
@@ -1447,6 +1457,9 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
 
 		part_stat_lock();
 		part = req->part;
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+		blk_additional_sector(part, sgrp, bytes >> SECTOR_SHIFT);
+#endif
 		part_stat_add(part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1502,6 +1515,9 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
+	blk_additional_sector(part, sgrp, sectors);
+#endif
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index f5d2f110fb34..cb9394521a8f 100644
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

