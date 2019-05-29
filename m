Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D8C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33332425E
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffA+Ht7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE2WIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 18:08:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44051 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:08:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so1207521qtk.11
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6vxTH2RGMqsT6V+sJVcqfeuxGREutVh377pdlEjxZA=;
        b=ffA+Ht7KRhRo/qkpzq8kOrAgeNqLcGlw/hCq3BC9fCWGBZaQjouR2AzBtpBj1UtY0J
         C9R9WNfRO0L8nN+uY0DmBn9uCorDotwKCxkCi1guurAkw1ZJx/b3UmnSGi1ZG2xJ6uxw
         3CO+JMRmWHcJfBrr3VxinI6PXq/5SQrMqn7a4FKKsd3a4yetigTgtGeHzNFzoXakp32o
         sFO4SRau+ZjgxpEvztj3rHtzvloGGNkYFi5QyassQxHS3T3weLwVTG5qblkkEy7+h6FK
         hKGpgQqqP4p3cbYAtuZvN5R1M2o5bB6EALW7ZGgaIdho4PzPSPWbZXSiOLZNxWyrpBHL
         AxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6vxTH2RGMqsT6V+sJVcqfeuxGREutVh377pdlEjxZA=;
        b=khTXV2tt/zHKlxs3RWj2Bft+qcTPnMSv+NkD9iNnzYGasftKG+pGCOb8VSquMbdqhR
         FFLt/BRPtSQs4ZwM1w2zAy16bxES2inEFeHjLGYIUoDv9yyesWzbLNDU0TQ6A7m9ojxH
         64Y9r5tU2gAYhdQi+LQSR+v4NGCJ3/tHUYGicVu/ykrwhd7I1+y1jekclh1hgE88Culz
         pgIxG8fACLGxgpR9mqrKl2tEmQ/zu6rrKesIeYxZ5/cSHuuJOvEq1ySV7zB5C8Sznhaf
         GI+S9pkT/ZaakR+rBIlWlmTn+OJt1VWW8x4zN/iCGZa2xmPvHEFwwa+zev09atH0wVkw
         JQlA==
X-Gm-Message-State: APjAAAUGrQHekE3vhHa908aBU5dQ8RzZ65y4aPjhHxZbA9YPn2Lnbgag
        u0yFNHZWtrgi1MuTB7oZR+vPjgDD
X-Google-Smtp-Source: APXvYqwyvxgNoilb/AF6O2/wd26iMdfbw8m0GzB/s9WvyD7SAaCOA8FMVxM/+dsb4G+5Pz8Ef120lQ==
X-Received: by 2002:ac8:ce:: with SMTP id d14mr325382qtg.149.1559167685831;
        Wed, 29 May 2019 15:08:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id z64sm189036qke.35.2019.05.29.15.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:08:05 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 4/5] Export block dev stats to sysfs
Date:   Wed, 29 May 2019 18:07:29 -0400
Message-Id: <20190529220730.28014-5-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
References: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
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
index 81566432828d..63fdda5e6ccb 100644
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
@@ -804,6 +826,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
+	&queue_stat_entry.attr,
 	&queue_histstat_entry.attr,
 	NULL,
 };
-- 
2.17.1

