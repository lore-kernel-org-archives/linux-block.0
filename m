Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73930C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BCE206A4
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJK//kU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKBdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKBdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 21:33:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34669C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 18:33:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so1681166plo.6
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 18:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ng9vtj0LljhCorqecxJb42lG+BIer9JathPkYl+TuQ=;
        b=lJK//kU7GrYgVtT1mXeNplJkKXoPMZvWBOSBFCypcWSGw3TJzRcRqMyjZpTulscfOm
         G0MIeIbljsppxvVd2tTosE+5FhQlr2T/TxD6IqMtuQA84mChlKv7lBFVbqWRnWWRWzBT
         PoE9HF4XYdRmCs47e5gJQmS3vC2DleWEdT+DwIug6JM1v0gSzh8Gy4eRzYTyb/xOazbV
         Y8/Vt74l1R6rp8jeeAHzwRFqNYXxlb9kQe2MysdlSdMEDpmTdQ4Lw2wpOgy66yweU6Nh
         4n17BNmdzTeCZtxyI7Q/yJvpL555HJC7f+3BvtBgQ7WfGjvWXGPRnsLGpFP4sHUXjzYa
         nKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Ng9vtj0LljhCorqecxJb42lG+BIer9JathPkYl+TuQ=;
        b=hGNqW22hftQNaNHCuvC8km4fX8l1hmMO99CCVl50I0OcQjVlwl2AWl3agwtsDpLVok
         Jvo9SZmdPQjPQ1g+hjFfR5+MlCWi8Xd1wvKrB6obzBmIMeP1r98cC4oWY58HwADxHVn0
         p0W8fmhmOafZXUXdAyd0h5bh7NG7/AjQha6Wau0upMrkmCCquYNwgLm5nkvQnNrvBlLz
         bvKy525/Am5dSwNgzG3hvfPmnz7AMzkObj/02kuNmQPV/upQq4YBK1XPQir1vjy3RGuA
         s3RIFwN0NFCAzg6vARcJgmwWbNyMPTNapCKyrjemPDz/Zff6EfIwb+JNgNeT81ynMzZn
         lb9w==
X-Gm-Message-State: AOAM533QGc+RUpfPResQBQX7bbUwPlUdLusjO3a/AJSD/CmGP/ljY9M3
        rZueAaAVP3r7N+LQ4tQs2J4dYl4U
X-Google-Smtp-Source: ABdhPJw7kqyNATDn0E62x8n1Xq/3v8OpLv3NmMotjCp6QoPVFYGq62mij0vzKyOhUzTreJ00XBxHfQ==
X-Received: by 2002:a17:902:d883:: with SMTP id b3mr5259467plz.133.1591839218264;
        Wed, 10 Jun 2020 18:33:38 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id l2sm931717pga.44.2020.06.10.18.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:33:37 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya.Kulkarni@wdc.com, bvanassche@acm.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Date:   Wed, 10 Jun 2020 18:33:26 -0700
Message-Id: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure that user requested memory via BLKTRACESETUP is within
bounds. This can be easily exploited by setting really large values
for buf_size and buf_nr in BLKTRACESETUP ioctl.

blktrace program has following hardcoded values for bufsize and bufnr:
BUF_SIZE=(512 * 1024)
BUF_NR=(4)

This is very easy to exploit. Setting buf_size / buf_nr in userspace
program to big values make kernel go oom.

This patch adds a new new sysfs tunable called "blktrace_max_alloc"
with the default value as:
blktrace_max_alloc=(1024 * 1024 * 16)

Verified that the fix makes BLKTRACESETUP return -E2BIG if the
buf_size * buf_nr crosses the configured upper bound in the device's
sysfs file. Verified that the bound checking is turned off when we
write 0 to the sysfs file.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-settings.c                |  1 +
 block/blk-sysfs.c                   | 27 +++++++++++++++++++++++++++
 include/linux/blkdev.h              |  5 +++++
 kernel/trace/blktrace.c             |  8 ++++++++
 5 files changed, 49 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 6a8513af9201..ef4eec68cd24 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -251,4 +251,12 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
+blktrace_max_alloc (RW)
+----------
+BLKTRACESETUP ioctl takes the number of buffers and the size of each
+buffer as an argument and uses these values to allocate kernel memory
+for tracing purpose. This is the limit on the maximum kernel memory
+that can be allocated by BLKTRACESETUP ioctl. The default limit is
+16MB. Value of 0 indicates that this bound checking is disabled.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9a2c23cd9700..38535aa146f4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->blktrace_max_alloc = BLKTRACE_MAX_ALLOC;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 02643e149d5e..e849e80930c4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -496,6 +496,26 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 	return count;
 }
 
+static ssize_t queue_blktrace_max_alloc_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.blktrace_max_alloc, page);
+}
+
+static ssize_t queue_blktrace_max_alloc_store(struct request_queue *q,
+					      const char *page,
+					      size_t count)
+{
+	unsigned long blktrace_max_alloc;
+	int ret;
+
+	ret = queue_var_store(&blktrace_max_alloc, page, count);
+	if (ret < 0)
+		return ret;
+
+	q->limits.blktrace_max_alloc = blktrace_max_alloc;
+	return count;
+}
+
 static ssize_t queue_wc_show(struct request_queue *q, char *page)
 {
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
@@ -731,6 +751,12 @@ static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.store = queue_wb_lat_store,
 };
 
+static struct queue_sysfs_entry queue_blktrace_max_alloc_entry = {
+	.attr = {.name = "blktrace_max_alloc", .mode = 0644 },
+	.show = queue_blktrace_max_alloc_show,
+	.store = queue_blktrace_max_alloc_store,
+};
+
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 static struct queue_sysfs_entry throtl_sample_time_entry = {
 	.attr = {.name = "throttle_sample_time", .mode = 0644 },
@@ -779,6 +805,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_blktrace_max_alloc_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..3a72b0fd723e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,10 @@ enum blk_queue_state {
 #define BLK_SCSI_MAX_CMDS	(256)
 #define BLK_SCSI_CMD_PER_LONG	(BLK_SCSI_MAX_CMDS / (sizeof(long) * 8))
 
+#define BLKTRACE_MAX_BUFSIZ	(1024 * 1024)
+#define BLKTRACE_MAX_BUFNR	16
+#define BLKTRACE_MAX_ALLOC	((BLKTRACE_MAX_BUFSIZ) * (BLKTRACE_MAX_BUFNR))
+
 /*
  * Zoned block device models (zoned limit).
  */
@@ -322,6 +326,7 @@ struct queue_limits {
 	unsigned long		bounce_pfn;
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
+	unsigned long		blktrace_max_alloc;
 
 	unsigned int		max_hw_sectors;
 	unsigned int		max_dev_sectors;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f2084087..de028bdbb148 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -477,11 +477,19 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 {
 	struct blk_trace *bt = NULL;
 	struct dentry *dir = NULL;
+	u32 alloc_siz;
 	int ret;
 
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
+	if (check_mul_overflow(buts->buf_size, buts->buf_nr, &alloc_siz))
+		return -E2BIG;
+
+	if (q->limits.blktrace_max_alloc &&
+	    alloc_siz > q->limits.blktrace_max_alloc)
+		return -E2BIG;
+
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
-- 
2.27.0.278.ge193c7cf3a9-goog

