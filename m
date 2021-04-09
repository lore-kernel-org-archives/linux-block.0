Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BAC433B4
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D98D610A3
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDIQDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhDIQDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 12:03:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2998C061761
        for <linux-block@vger.kernel.org>; Fri,  9 Apr 2021 09:03:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so5014190wma.3
        for <linux-block@vger.kernel.org>; Fri, 09 Apr 2021 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jLSjPNFxEIEpN2oTjxkYPNUB7wV95qNs1fZYQN8D2U=;
        b=U1YS5JHmwBkJSQbe6JgqjNNkdHu9X2h868YaRJBIUMHPoPh7bPdJmSFnYiIzeik8Rg
         NfCSmPm7knBM/A36tTsX/eDu28KcNB+N/PNGmjD8kgmnt+0vKkW80+wezXVXOalE/n5Z
         kKWsGzW2tQ+CvSyY4VEZ0rHV9Qi5dPfzjBpt7LVd/Yqngj0LOT6WjQKqEJ/Xue1Omo/H
         /dVPAR/28/TumrqfLL5mut4b80O6dIH/I5s9aqSPhy4gJJqmO/qSq/mcUjGamSYUBaM7
         RiNswYn+Lcdl6OEQshrBDIDDWADGrrsqVEXNBIGDfGF2xZo6vaX80/7wO21wFyivt2hk
         CeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jLSjPNFxEIEpN2oTjxkYPNUB7wV95qNs1fZYQN8D2U=;
        b=KUPJ05Cn7jTfWjOVMcSiLo3pKsE5HjTm01E36oBva9wgJal1r+5sdIsU4eEdAjALFU
         kcavE2mG2fI+Q2nDsi5TrEAoEPLux/bmOPGm7kOckDnNUrJXYD1cZVflcrpesMrLAlkx
         R/MgjaixCtYYcRcQzRzLAqANXgHvPItGxznML8Hz2cvtUjAaQfeYlpgXM5qlZi9zh2C5
         1qHrqJWLg6LBFdiv+uPgbwMpbv1lcDcabsQ+Yy2/RwkiZpr9ZWm/9B1LTlt0QeVhZ5yo
         Jpj9k0DbovuTBrIdt7CQ+zPZAnHOckgYM8Wm9J/+5sSFruIPBTd9S5QvFo9W/LqYqjqR
         +MjA==
X-Gm-Message-State: AOAM533tkWTeeBvK9WB8RbkSUkaZoNC7cyM2qvUYW6Iifw1DzhkXE0Q/
        53HmomAd/ZCoKFdopDNJUh45Gw==
X-Google-Smtp-Source: ABdhPJwUenIcEr0HNJx66HKMh1hizVex8v6UerM8R4sDuiKGzZoeexv7gRtBcpqrFXfyyvnFhVI52Q==
X-Received: by 2002:a05:600c:3556:: with SMTP id i22mr14568395wmq.116.1617984201565;
        Fri, 09 Apr 2021 09:03:21 -0700 (PDT)
Received: from nb01533.speedport.ip (p200300f00f04582edcb1e40bc231ceef.dip0.t-ipconnect.de. [2003:f0:f04:582e:dcb1:e40b:c231:ceef])
        by smtp.gmail.com with ESMTPSA id m3sm5322883wme.40.2021.04.09.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:03:21 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V6 3/3] block: add a statistic table for io sector
Date:   Fri,  9 Apr 2021 18:03:05 +0200
Message-Id: <20210409160305.711318-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409160305.711318-1-haris.iqbal@ionos.com>
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
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
 block/blk-core.c                      | 20 ++++++++++++++
 block/genhd.c                         | 39 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  3 ++-
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 90970a8dc70f..a32b2c399e81 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -36,6 +36,15 @@ Description:
 		the statistics of I/O latency for each type (read, write,
 		discard and flush) which have happened to the disk.
 
+What:		/sys/block/<disk>/io_size
+Date:		March 2021
+Contact:	Guoqing Jiang <guoqing.jiang@ionos.com>
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
index 0895d5eddc1f..deaf82f7a478 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1283,12 +1283,31 @@ static void blk_additional_latency(struct block_device *part, const int sgrp,
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
+		blk_additional_sector(req->part, sgrp, req->q,
+				      bytes >> SECTOR_SHIFT);
 		part_stat_add(req->part, sectors[sgrp], bytes >> 9);
 		part_stat_unlock();
 	}
@@ -1341,6 +1360,7 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 	update_io_ticks(part, now, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
+	blk_additional_sector(part, sgrp, part->bd_disk->queue, sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/genhd.c b/block/genhd.c
index 66c6342968a3..cce3c1234282 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1108,6 +1108,44 @@ static ssize_t io_latency_show(struct device *dev,
 static struct device_attribute dev_attr_io_latency =
 	__ATTR(io_latency, 0444, io_latency_show, NULL);
 
+static ssize_t io_size_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
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
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "%lu ", part_stat_read(bdev,
+					   size_table[i][sgrp]));
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
@@ -1128,6 +1166,7 @@ static struct attribute *disk_attrs[] = {
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

