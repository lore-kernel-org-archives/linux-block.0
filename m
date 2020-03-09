Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0313C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF08324654
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3wJhj9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCIU7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44712 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIU7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id f198so10684062qke.11
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCgW32uJetkeiw8BZMiemhtOT3vNvyFmXMJQ61UI1gA=;
        b=A3wJhj9lhapfimBP+Ms0YooXl6opDSoddfnXbRxT8wYKnwQeRhLTr36p+7hwzwPUnc
         D8vOzxW6CY11U4PHKqjtV78V2lHNMDQadMo2Bk7qstGaSm8uVACqWN5X5JJIQFMXeFpp
         K30/RZDttG5bkpOXrIRuz0Hr0/ceXiUTbcILEauPYIYcLQIKO1A6W97XPdxfw5NvCsaN
         MkYiXSAIAq4lqVeB2Mt5dxpaYaB3aBuG5I08XZE8S5Ui0L5hUpEP74DGzJbaFLkavKEH
         22DH3YVJyCseOxjoZ19qkYR+gEYeBZc9LYwUE1d3FllI37pOy9tmU0wLR2+xj3K418a8
         uvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCgW32uJetkeiw8BZMiemhtOT3vNvyFmXMJQ61UI1gA=;
        b=ANcik0caEb2jG41Db1fuEL5r4kZQ8xkqu86aEHUI8ZoiwSU0yMJoQgOyYr5PLO3hrP
         kMz6OuUDxWKBbTjBSeQXyLKzqLcyrF5TFMxSkigN7e2VgaWezZj9fctZRH/KksTdyFHu
         mQzK4MexWYGUw6f33khbQpDp9SiVOt8HsOv38SGVr/mye5MMGCcq8IUZoWXmdUTQ2ROI
         h219ji2IVsrZLiTEdQdC8j4sFLt9RQeKTXpc/kYVlprOnn21YeSt9YBiVqN1+1mDuLbo
         gH+tbam/B3uZpEQl7IBOQNt0bmeJp9LDOSOgirHM3dA6DtHm8X1bmzqYBQRnZpvPpZ9H
         nQ1w==
X-Gm-Message-State: ANhLgQ2cglE0GKoxghWszPal+8Nuq00RMr++MIOX2YZKhirVU8mofRKT
        +vehzf/r12Wbtyvgoltdz4m4O3ccW30=
X-Google-Smtp-Source: ADFU+vthXRjwXzL/pB54qof2hs/cXLc3AthLCW/pa99ZsL0gyhNL97zYNz+o4e0fsiylj5qmZg81Mg==
X-Received: by 2002:a37:79c6:: with SMTP id u189mr10388391qkc.96.1583787588283;
        Mon, 09 Mar 2020 13:59:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id w18sm6125583qkw.130.2020.03.09.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:47 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 3/7] Export block request stats to sysfs
Date:   Mon,  9 Mar 2020 16:59:27 -0400
Message-Id: <20200309205931.24256-4-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

This exports bytes read/write/discard per bucket to sysfs

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-sysfs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 8841146cad54..44517799a2e8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -529,6 +529,23 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
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
+		for (bkt = 0; bkt < (BLK_REQ_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%llu ",
+				       q->req_stat[i + 3 * bkt].sectors << 9);
+		}
+		off += sprintf(p + off, "\n");
+	}
+	return off;
+}
+
 static ssize_t queue_reqstat_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_REQSTATS,
@@ -764,6 +781,11 @@ static struct queue_sysfs_entry queue_reqstat_entry = {
 	.store = queue_reqstat_store,
 };
 
+static struct queue_sysfs_entry queue_stat_entry = {
+	.attr = {.name = "stat", .mode = 0444 },
+	.show = queue_stat_show,
+};
+
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -804,6 +826,7 @@ static struct attribute *queue_attrs[] = {
 	&throtl_sample_time_entry.attr,
 #endif
 	&queue_reqstat_entry.attr,
+	&queue_stat_entry.attr,
 	NULL,
 };
 
-- 
2.17.1

