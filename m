Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26828C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC62820874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLQKno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbeLQKno (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 05:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD130C7C33;
        Mon, 17 Dec 2018 10:43:43 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0AE71883F;
        Mon, 17 Dec 2018 10:43:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 4/4] blk-mq: export hctx->type in debugfs instead of sysfs
Date:   Mon, 17 Dec 2018 18:42:48 +0800
Message-Id: <20181217104248.5828-5-ming.lei@redhat.com>
In-Reply-To: <20181217104248.5828-1-ming.lei@redhat.com>
References: <20181217104248.5828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 10:43:44 +0000 (UTC)
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

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 16 ++++++++++++++++
 block/blk-mq-sysfs.c   | 17 -----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7021d44cef6d..159607be5158 100644
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
@@ -806,6 +821,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
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

