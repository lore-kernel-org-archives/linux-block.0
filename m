Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE84C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4C92086A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfU6dTeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4C92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeKSU6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39984 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeKSU6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so22274523wrt.7
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWUit/vYiH26YHlA9buP+oQITDwnzmUPMPxq3d9LPkE=;
        b=YfU6dTeTHM5A73Tg5BMA4Dw8e7o9lmuB/XXB5c23ILL9CwfpTx7baLDS9fcxsc4otQ
         h+tJUzNJjWWpTo+fcsVP95Nv2im3yghKNLInHuZODRvbKsDeb2XPU70gXHTWu30bsKH+
         nOdzVt5hy9oioZwEv6JpXsY9wqtsNzerY764E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWUit/vYiH26YHlA9buP+oQITDwnzmUPMPxq3d9LPkE=;
        b=G39A/XOZapKRKjAkWYq3CfTo8FbrFnZF4JwzPiy433iCb9fp6XKyUz2b+fzqeB+zKL
         Nv5SnwIOzYx3Qazx4HNyrRUSnEZ3JfF3P5bR2B3X/LRMP4nwwWS6pyD2178QWHKRxE1E
         Tp8PHbst5/pU1zXt4QcMbdS2uOrd4IE3RZuNOXmtdfLg88qomvLZwqL7vu1aBEUYFKw/
         IIvXjXuAY3VLLzUECIJezKFezwLwK6AHRVGw68VVn+zsorF4OIwMQhOG4P82b7gQCjSp
         RoqmYdWqr4YZdZLh2bNGDJVpCcZI7QNQgwa3GPh9+Q/y31d0LUH8xcq+5wHLl/Yf0SLC
         F/3g==
X-Gm-Message-State: AGRZ1gLbRNRtUydKiAx9mil4XiJiORND/slJcxDNlyc6BF+ErzPBy/BT
        nwegEgoweF/JsCIV8EjrZOCOEw==
X-Google-Smtp-Source: AJdET5fCheLXk7HslibEJh72wzIBDKuwOox1n0FqTi3WVYdm8eRpBK2TFHFO6xuNfT2KcB6yhBtsJg==
X-Received: by 2002:adf:9387:: with SMTP id 7-v6mr17123195wrp.269.1542623695517;
        Mon, 19 Nov 2018 02:34:55 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:55 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 07/10] block, bfq: use standard file names for the proportional-share policy
Date:   Mon, 19 Nov 2018 11:34:21 +0100
Message-Id: <20181119103424.3853-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of the files exposed in a cgroup by bfq, for the proportional
share policy, have the same meaning as the files owned by cfq (before
legacy blk was removed).

The old implementation of the cgroup interface didn't allow different
entities to create cgroup files with the same name (in the same
subsystem). So, for bfq, we had to add the prefix "bfq" to the names
of its cgroup files.

This commit renames the cgroup files of the bfq scheduler as those
exposed by cfq, and makes bfq willing to share these files with any
other future policy.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 94 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 038e418fa64f..0643147b2cbc 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1055,50 +1055,67 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "weight",
+		.owner_name = "bfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
-		.name = "bfq.io_service_bytes",
+		.name = "io_service_bytes",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
-		.name = "bfq.io_serviced",
+		.name = "io_serviced",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 #ifdef CONFIG_DEBUG_BLK_CGROUP
 	{
-		.name = "bfq.time",
+		.name = "time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.sectors",
+		.name = "sectors",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_stat_sectors,
 	},
 	{
-		.name = "bfq.io_service_time",
+		.name = "io_service_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_wait_time",
+		.name = "io_wait_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_merged",
+		.name = "io_merged",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_queued",
+		.name = "io_queued",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
@@ -1106,66 +1123,92 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* the same statictics which cover the bfqg and its descendants */
 	{
-		.name = "bfq.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "bfq.io_serviced_recursive",
+		.name = "io_serviced_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
 #ifdef CONFIG_DEBUG_BLK_CGROUP
 	{
-		.name = "bfq.time_recursive",
+		.name = "time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show_cft = bfqg_print_stat_recursive,
 	},
 	{
-		.name = "bfq.sectors_recursive",
+		.name = "sectors_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_stat_sectors_recursive,
 	},
 	{
-		.name = "bfq.io_service_time_recursive",
+		.name = "io_service_time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_wait_time_recursive",
+		.name = "io_wait_time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_merged_recursive",
+		.name = "io_merged_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_queued_recursive",
+		.name = "io_queued_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.avg_queue_size",
+		.name = "avg_queue_size",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_avg_queue_size,
 	},
 	{
-		.name = "bfq.group_wait_time",
+		.name = "group_wait_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.group_wait_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.idle_time",
+		.name = "idle_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.idle_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.empty_time",
+		.name = "empty_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.empty_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.dequeue",
+		.name = "dequeue",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.dequeue),
 		.seq_show_cft = bfqg_print_stat,
 	},
@@ -1175,8 +1218,9 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "weight",
+		.owner_name = "bfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
-- 
2.16.1

