Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64415C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ADD2084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeLPC0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:26:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeLPC0N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 21:26:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 778A93697E;
        Sun, 16 Dec 2018 02:26:13 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3150105705C;
        Sun, 16 Dec 2018 02:26:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] blk-mq-debugfs: export hctx->type
Date:   Sun, 16 Dec 2018 10:25:17 +0800
Message-Id: <20181216022517.26650-5-ming.lei@redhat.com>
In-Reply-To: <20181216022517.26650-1-ming.lei@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 16 Dec 2018 02:26:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we only export hctx->type via sysfs, and there isn't such info
in hctx entry under debugfs. We often use debugfs only to diagnose
queue mapping issue, so add the support in debugfs.

Queue mapping becomes a bit more complicated after multiple queue
mapping is supported, we may write blktest to verify if queue mapping
is valid based on blk-mq-debug.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a32bb79d6c95..219e29d49a49 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -636,6 +636,14 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int hctx_type_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+
+	seq_printf(m, "%u\n", hctx->type);
+	return 0;
+}
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 	__acquires(&ctx->lock)
 {
@@ -798,6 +806,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
+	{"type", 0400, hctx_type_show},
 	{},
 };
 
-- 
2.9.5

