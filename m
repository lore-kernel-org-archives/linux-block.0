Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915BC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949A02133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeLQMJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:09:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQMJK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:09:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF1182D7FF;
        Mon, 17 Dec 2018 12:09:09 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36D36012B;
        Mon, 17 Dec 2018 12:09:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 2/3] blk-mq: export hctx->type in debugfs instead of sysfs
Date:   Mon, 17 Dec 2018 20:08:43 +0800
Message-Id: <20181217120844.8131-3-ming.lei@redhat.com>
In-Reply-To: <20181217120844.8131-1-ming.lei@redhat.com>
References: <20181217120844.8131-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 17 Dec 2018 12:09:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we only export hctx->type via sysfs, and there isn't such info
in hctx entry under debugfs. We often use debugfs only to diagnose
queue mapping issue, so add the support in debugfs.

Queue mapping becomes a bit more complicated after multiple queue
mapping is supported, we may write blktest to verify if queue mapping
is valid based on blk-mq-debugfs.

Given not necessary to export hctx->type twice, so remove the export
from sysfs.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 16 ++++++++++++++++
 block/blk-mq-sysfs.c   | 17 -----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2793e91bc7a4..1e12033be9ea 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -447,6 +447,21 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static const char *const hctx_types[] = {
+	[HCTX_TYPE_DEFAULT]	= "default",
+	[HCTX_TYPE_READ]	= "read",
+	[HCTX_TYPE_POLL]	= "poll",
+};
+
+static int hctx_type_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+
+	BUILD_BUG_ON(ARRAY_SIZE(hctx_types) != HCTX_MAX_TYPES);
+	seq_printf(m, "%s\n", hctx_types[hctx->type]);
+	return 0;
+}
+
 static int hctx_ctx_map_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -799,6 +814,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
+	{"type", 0400, hctx_type_show},
 	{},
 };
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 9c2df137256a..3f9c3f4ac44c 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -173,18 +173,6 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
-static const char *const hctx_types[] = {
-	[HCTX_TYPE_DEFAULT]	= "default",
-	[HCTX_TYPE_READ]	= "read",
-	[HCTX_TYPE_POLL]	= "poll",
-};
-
-static ssize_t blk_mq_hw_sysfs_type_show(struct blk_mq_hw_ctx *hctx, char *page)
-{
-	BUILD_BUG_ON(ARRAY_SIZE(hctx_types) != HCTX_MAX_TYPES);
-	return sprintf(page, "%s\n", hctx_types[hctx->type]);
-}
-
 static struct attribute *default_ctx_attrs[] = {
 	NULL,
 };
@@ -201,16 +189,11 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_type = {
-	.attr = {.name = "type", .mode = 0444 },
-	.show = blk_mq_hw_sysfs_type_show,
-};
 
 static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
-	&blk_mq_hw_sysfs_type.attr,
 	NULL,
 };
 
-- 
2.9.5

