Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5ECC433ED
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05C1610E5
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDIQDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 12:03:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E6C061760
        for <linux-block@vger.kernel.org>; Fri,  9 Apr 2021 09:03:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 12so3184679wmf.5
        for <linux-block@vger.kernel.org>; Fri, 09 Apr 2021 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpspIAi5dNx+sG9KDMF/ZwAElR3K07r3YF0OoCpocG8=;
        b=S5MZZtP09t2EaJUjzKMcPuAuD6wB6XirICFd5/BS7XLZ+vIcp592G2G0lXyAWvwmub
         xt9IkBo0nh4xhBTalimI+YdH5FMgLi3styqCnPgroDlnK4i1YPJy7LG6W2ncM5/6Gqg8
         HZDoRkdIuWuHRegH4tVxmX+eXP3kRoFY9GOgfhbJXejebXiSOcC/LqmzmeNs59BlMaLI
         UYG/A41CD0Jq2CZ7QSTfq9pbdK2S/I8bb5TeLm2Xbax9tm05f3Jdj7etcf8DKWmifnzG
         fLAl5d8Bdiz4SxRLwnUwrFj1bjXsh6SaQLhZ7+O5S8psOqMBgoELNV3b9JuwZCrrVxj1
         oJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpspIAi5dNx+sG9KDMF/ZwAElR3K07r3YF0OoCpocG8=;
        b=fmpP2eM2eo18RThG4teBsTU51tV2SLRaetQ3Oilr+NzsNxb7D0GVdMtm8K1ALsvGaW
         g5mFuAQqIe1fbcagcRV/904M7A8QO8ZhyIEozgSWnGTEpXEjoQewGc6OyhCevssnW11i
         XXMB2N7yR/Ch5Jdr2XxB8q413aZsaFwfeNzLormxqvkhduaRHImdFiVg9btS7jDj8qmu
         6tt6wFRZXFrDPvCLijc+509DpToQDlcLoYDCyhAk9K03jW5SCDMDfsDCUsyIwfp1dT9u
         f2Dxc8h7d3zVxrAmfXuMLwBgJX+VeuHYXtln6P+WVe0C1LklK6Qh/VGwD2cbm5E6z91o
         vKBg==
X-Gm-Message-State: AOAM532KBXGtyi900d1ewJC6oHmcmlSrqgDaHTCCK0LWQnGXSr6NzRHP
        OAJzm4HGc+0N/KPZFxnhNaQZI/ZekjnNm9JB
X-Google-Smtp-Source: ABdhPJxyfXvn5nPYgQ6EWSAg4fSiOasWBUeo6oXXGmoY9VtJRCwFsoCrO1tOT8RWPeuQdYq3hnnZgA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr14483217wmi.36.1617984200042;
        Fri, 09 Apr 2021 09:03:20 -0700 (PDT)
Received: from nb01533.speedport.ip (p200300f00f04582edcb1e40bc231ceef.dip0.t-ipconnect.de. [2003:f0:f04:582e:dcb1:e40b:c231:ceef])
        by smtp.gmail.com with ESMTPSA id m3sm5322883wme.40.2021.04.09.09.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:03:19 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V6 2/3] block: add a statistic table for io latency
Date:   Fri,  9 Apr 2021 18:03:04 +0200
Message-Id: <20210409160305.711318-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409160305.711318-1-haris.iqbal@ionos.com>
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
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
 Documentation/ABI/testing/sysfs-block |  8 +++++
 block/blk-core.c                      | 24 +++++++++++++++
 block/genhd.c                         | 42 +++++++++++++++++++++++++++
 include/linux/part_stat.h             |  5 ++++
 4 files changed, 79 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 3cf5a2cfaeb9..90970a8dc70f 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -27,6 +27,14 @@ Description:
 
 		For more details refer Documentation/admin-guide/iostats.rst
 
+What:		/sys/block/<disk>/io_latency
+Date:		March 2021
+Contact:	Guoqing Jiang <guoqing.jiang@ionos.com>
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
index 39ca97b0edc6..66c6342968a3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1067,6 +1067,47 @@ static struct device_attribute dev_attr_fail_timeout =
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
 #endif
 
+static ssize_t io_latency_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	size_t count = 0;
+	int i, sgrp;
+
+	for (i = 0; i < ADD_STAT_NUM; i++) {
+		unsigned int from, to;
+
+		if (i == ADD_STAT_NUM - 1) {
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "      >= %5d  ms: ",
+					   (2 << (i - 2)) * HZ_TO_MSEC_NUM);
+		} else {
+			if (i < 2) {
+				from = i;
+				to = i + 1;
+			} else {
+				from = 2 << (i - 2);
+				to = 2 << (i - 1);
+			}
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "[%5d - %-5d) ms: ",
+					   from * HZ_TO_MSEC_NUM,
+					   to * HZ_TO_MSEC_NUM);
+		}
+
+		for (sgrp = 0; sgrp < NR_STAT_GROUPS; sgrp++)
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "%lu ", part_stat_read(bdev,
+					   latency_table[i][sgrp]));
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
@@ -1086,6 +1127,7 @@ static struct attribute *disk_attrs[] = {
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

