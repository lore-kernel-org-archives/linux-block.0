Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126BC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E48206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmQ0yPRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfDZAVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:31 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44441 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfDZAVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:31 -0400
Received: by mail-yb1-f193.google.com with SMTP id u187so654521ybg.11
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gK5nqmvoIh7e/MtccfmFy5xTemV1dhtFwOFBM32mQJ8=;
        b=NmQ0yPRFEa8XFIAf6cg9dJrjZlwW3LefpNKC9mU208ZUqBV9CyNxuAaDogcuE9tuvU
         4eXf7Mbr988P+Jiyc//MkM0OueESee+XEK1ljsK0V0RJ2k5MCiTG+zwCHQ2kOF6GotaZ
         qASRNsL9KoXn5lghdwsryXWZCYcc8rX4KTgEGMyPSvNPc/CMjh1wtUJnuriDTkOdScls
         3fZi33F0c6CwR8UHchPLWNB4/t7fSS3e8EtSYMpG0hC+gAZk4BrGNc3CKX1L1BZqJpex
         cqEV2JSg/n5tF0eDObZlgD37B80G55hAYN5pXjnPJEM6OjMhfP9UXLjw2M2Bcl8GdtAh
         t/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gK5nqmvoIh7e/MtccfmFy5xTemV1dhtFwOFBM32mQJ8=;
        b=Wn3PoDetGBBoStcsMdEhMg9BFPy/DjSevn4alQCiSboYjKuWUpGZ2JzUFq/yxsOe++
         bc3iXThYc/xsUSQ2gRQe8nSN8CZ+I2Pyj2QnMtu4YluWr7TnyGMUovxy1PZEjm9GXLhz
         zmSPx/ukDAriDBUEbrbzc3mTfnI4bGHlBwzluICy8wHoxIAbKJr76LmWLf9hG0CaAYZk
         AveUqYGpSiFt8gd7IOYOmZqbDhT4k9aYG2bVIZhUdMp70oStRxV5dULXFL2czjfHNL9a
         BZXyP78X7JfvT/dGI8vz1L64+wn/nJunvghvMZ5C3x6KdJR70FLKFqncVm3NT8+Bzjsp
         Lidg==
X-Gm-Message-State: APjAAAXR0p9uaoMa3Yj0gsPeDCyO/me7/8jeI0daZpwY4jfUTEMPFrHa
        CNhVWgas689UNMr/VqpPWhARvCAe
X-Google-Smtp-Source: APXvYqz4Ct+01ZEYVr8uDnnaRJx/OsfGc3NdbkF10o88qSKVfLltTbOd3ja6x2OHrHXRVAgGN8ovdg==
X-Received: by 2002:a25:d289:: with SMTP id j131mr10101538ybg.289.1556238089927;
        Thu, 25 Apr 2019 17:21:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id n63sm813143ywf.61.2019.04.25.17.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:29 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 4/5] Export block dev stats to sysfs
Date:   Thu, 25 Apr 2019 20:20:49 -0400
Message-Id: <20190426002050.15499-5-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
References: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

This exports bytes of read/write/discard per bucket to sysfs

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-sysfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 394760754bfc..f54d91b54b61 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -530,6 +530,23 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_stat_show(struct request_queue *q, char *p)
+{
+	char name[3][8] = {"read", "write", "discard"};
+	int bkt, off, i;
+
+	off = 0;
+	for (i = 0; i < 3; i++) {
+		off += sprintf(p + off, "%s: ", name[i]);
+		for (bkt = 0; bkt < (BLK_DEV_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%llu ",
+				       q->dev_stat[i + 3 * bkt].size);
+		}
+		off += sprintf(p + off, "\n");
+	}
+	return off;
+}
+
 static ssize_t queue_histstat_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_HISTSTATS,
@@ -759,6 +776,11 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
+static struct queue_sysfs_entry queue_stat_entry = {
+	.attr = {.name = "stat", .mode = 0444 },
+	.show = queue_stat_show,
+};
+
 static struct queue_sysfs_entry queue_histstat_entry = {
 	.attr = {.name = "histstat", .mode = 0644 },
 	.show = queue_histstat_show,
@@ -804,6 +826,7 @@ static struct attribute *default_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_stat_entry.attr,
 	&queue_histstat_entry.attr,
 	NULL,
 };
-- 
2.17.1

