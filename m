Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E234EC4CECD
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA7E214AF
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIMkC1zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfIQQwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:52:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbfIQQwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:52:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so3920561wrw.8
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+J/rjQ7AlBRxwCs9yj4yDSyroYuGLxSnx2uDbq0Vgs=;
        b=NIMkC1zuAvyYS8NTpNrszHN2uSRAxhYT9fS2+qIBtswRZK4SLEW4XJzAnwCc93arWP
         WHuwOpcUxjh0DCXXmVw4lVRysa9NGezH0rjUO4HXEKeWowzJOLyp3XH2tkz9sxBAQUDu
         HPTLA+os7YozSyrY7uRuF3OSeiwcThAV/8tMLFOSWZGB9zEXD99gcV5Yoz7j5JpzXlFN
         CURxpGmGrU4qcT+HHY9PoBXWK6jlHj7U4PUTyNd8PlUbX1/oveD+vbqXYPnV9cbjGx3O
         laTm6SwnvsIS/67azBwoKE29C+C0RzmPnjqh7jb9yaLzDSZzDGgnfhgLlb0lFHUYTib8
         Jg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+J/rjQ7AlBRxwCs9yj4yDSyroYuGLxSnx2uDbq0Vgs=;
        b=bzBJdBmAEGTFXJNs1im7jCv1Tb3SmxsP1txymc88M0lJQs6jVvweUGfND8h0lLZLkC
         C33O7zlZdy/rw3mG2TGJbK5w3EjvlTqGdbFQZCFIsmBePXu8fdvtYMIDdElWkOvTc9jN
         3qDJkFC5xHUMcqVZbdNOQJQhZZe4DnwJqDP7MvoMOwZt2FpDXtX0l/6AJv3k5YQ6ku4J
         4n7u349z9Rvh8grdTXs1xiITghSVMaoYAik8y+oy857O9IbaRrDl8xL63z+xs4Ud6saS
         PgSjyk/ynmJPLWyGi8kH5emwXOmGrcVKgFafIy+N07kWXgZn05AQpBe/A12quPkNzrLX
         JdsQ==
X-Gm-Message-State: APjAAAUn8/Z+E0lLRWMs9s0jo9IT9vNrTJZULcnNjBGAV3KY9ksUi+pp
        YNRO+Zl1MNn12ui5ir3eK5AlzQ==
X-Google-Smtp-Source: APXvYqx3eTQVrPWePYemSDKcPZijHSXGQeIx3sQtaCgzuovC13Z5bVHiL6fy0+2dK1fnbo2zXOwnVg==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr3677399wrs.106.1568739130945;
        Tue, 17 Sep 2019 09:52:10 -0700 (PDT)
Received: from localhost.localdomain (146-241-53-114.dyn.eolo.it. [146.241.53.114])
        by smtp.gmail.com with ESMTPSA id g73sm4012378wme.10.2019.09.17.09.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:52:10 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
Date:   Tue, 17 Sep 2019 18:51:48 +0200
Message-Id: <20190917165148.19146-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917165148.19146-1-paolo.valente@linaro.org>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

When bfq was merged into mainline, there were two I/O schedulers that
implemented the proportional-share policy: bfq for blk-mq and cfq for
legacy blk. bfq's interface files in the blkio/io controller have the
same names as cfq. But the cgroups interface doesn't allow two
entities to use the same name for their files, so for bfq we had to
prepend the "bfq" prefix to each of its files. However no legacy code
uses these modified file names. This naming also causes confusion, as,
e.g., in [1].

Now cfq has gone with legacy blk, so there is no need any longer for
these prefixes in (the never used) bfq names. In view of this fact, this
commit removes these prefixes, thereby enabling legacy code to truly
use the proportional share policy in blk-mq.

[1] https://github.com/systemd/systemd/issues/7057

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index decda96770f4..7f0160f5155f 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1213,7 +1213,7 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight_legacy,
 		.write_u64 = bfq_io_set_weight_legacy,
@@ -1227,42 +1227,42 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
-		.name = "bfq.io_service_bytes",
+		.name = "io_service_bytes",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_bytes,
 	},
 	{
-		.name = "bfq.io_serviced",
+		.name = "io_serviced",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
-		.name = "bfq.time",
+		.name = "time",
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.sectors",
+		.name = "sectors",
 		.seq_show = bfqg_print_stat_sectors,
 	},
 	{
-		.name = "bfq.io_service_time",
+		.name = "io_service_time",
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_wait_time",
+		.name = "io_wait_time",
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_merged",
+		.name = "io_merged",
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_queued",
+		.name = "io_queued",
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show = bfqg_print_rwstat,
 	},
@@ -1270,66 +1270,66 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* the same statistics which cover the bfqg and its descendants */
 	{
-		.name = "bfq.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "bfq.io_serviced_recursive",
+		.name = "io_serviced_recursive",
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show = blkg_print_stat_ios_recursive,
 	},
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 	{
-		.name = "bfq.time_recursive",
+		.name = "time_recursive",
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show = bfqg_print_stat_recursive,
 	},
 	{
-		.name = "bfq.sectors_recursive",
+		.name = "sectors_recursive",
 		.seq_show = bfqg_print_stat_sectors_recursive,
 	},
 	{
-		.name = "bfq.io_service_time_recursive",
+		.name = "io_service_time_recursive",
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_wait_time_recursive",
+		.name = "io_wait_time_recursive",
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_merged_recursive",
+		.name = "io_merged_recursive",
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_queued_recursive",
+		.name = "io_queued_recursive",
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.avg_queue_size",
+		.name = "avg_queue_size",
 		.seq_show = bfqg_print_avg_queue_size,
 	},
 	{
-		.name = "bfq.group_wait_time",
+		.name = "group_wait_time",
 		.private = offsetof(struct bfq_group, stats.group_wait_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.idle_time",
+		.name = "idle_time",
 		.private = offsetof(struct bfq_group, stats.idle_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.empty_time",
+		.name = "empty_time",
 		.private = offsetof(struct bfq_group, stats.empty_time),
 		.seq_show = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.dequeue",
+		.name = "dequeue",
 		.private = offsetof(struct bfq_group, stats.dequeue),
 		.seq_show = bfqg_print_stat,
 	},
@@ -1339,7 +1339,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
-- 
2.20.1

