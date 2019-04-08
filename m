Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D3C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A846D20857
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIwNxuFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDHOjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:39:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54876 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfDHOjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:39:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so14656334wml.4
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gu8wtsCKXjWJ0bzgQFlSKbghceLWt6dpiC4QGxS8ako=;
        b=NIwNxuFGq/nknNExEL/1gIJN4YJ3X1R1zSbTogJKbEg3wEz2GllIVKqPM10cYmFv6l
         IlPyHtdNPSJXWllpklWHB9iB2sq3PqntuaS/WV6dUdXleRVgXfq6augXSH8CzBoTidhD
         sdvfj/A0sWOdL8IeeAD5WACqL3REe+p1TUxoG6EdK6iYFNH2SvcHy4278IkLzVkwBMud
         P6F6qIIJEiYQKAQLPSN5Jm6o9mprhPqHTwuJxm79qX0ybDvwmqqHvxPRjL2YnI1peEqp
         kJVdi9hzGSH0U7D7VOG08sfcBIyNTMcEpiBxuiEtwbPPefRRpEpj3qbN9QXSUXj7EKCq
         xOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gu8wtsCKXjWJ0bzgQFlSKbghceLWt6dpiC4QGxS8ako=;
        b=B32aoC4mgi5yzcUzT7Fei4WdqArZ+OIXbprvLbToCXa4SlIy13XrE8YnnOWiczZz4h
         jyRDuQ+EHsaB1PhimzQMJ/3GXuZOUzzjPwSbawSWnucAm43DXEXsImykwMI0kiQRgO5h
         hguC0Vkuxz5Ry44uYPXNpGBLJ7czjSj6bL/Ug7X3fChXdbGbTa8bl+607d4o5qNF1+ay
         KJwKwo5ynkVik8iZV1h/CK/o9YsOCRskdDSNkwkViI9GTAAMXCP46h4HM2O1Lvttv+P7
         Y3mA4/WobUzCJyy37qnoxzVAkmloH3xKR0BCpN/0unbefO9+b/G9cfQ/LqHpvAZ0X7oN
         2xfQ==
X-Gm-Message-State: APjAAAWE+Qpd7Mh6qzeNDdEHViU5hP7jF2PcaIRfW4R4O74CXVot9Soq
        dnl/9pydYSPkN+/k9IBRn3DqIA==
X-Google-Smtp-Source: APXvYqytxjkTZQOU06P5mTCnuwi4H+Eu93TjAikXqYAk1qwx2eTE/R3EgcRW34TKG+WVV1zB1e/tvQ==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr18603747wmc.68.1554734392971;
        Mon, 08 Apr 2019 07:39:52 -0700 (PDT)
Received: from localhost.localdomain ([88.147.51.116])
        by smtp.gmail.com with ESMTPSA id r196sm15113852wmf.22.2019.04.08.07.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:39:52 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Angelo Ruocco <angeloruocco90@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
Date:   Mon,  8 Apr 2019 16:39:35 +0200
Message-Id: <20190408143935.9062-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408143935.9062-1-paolo.valente@linaro.org>
References: <20190408143935.9062-1-paolo.valente@linaro.org>
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
index c6113af31960..319c2444dc71 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1053,7 +1053,7 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
@@ -1061,42 +1061,42 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
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
 #ifdef CONFIG_DEBUG_BLK_CGROUP
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
@@ -1104,66 +1104,66 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* the same statictics which cover the bfqg and its descendants */
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
 #ifdef CONFIG_DEBUG_BLK_CGROUP
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
@@ -1173,7 +1173,7 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
+		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
-- 
2.20.1

