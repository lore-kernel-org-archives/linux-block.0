Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F93EC5B57A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426F9208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfF1MBa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:54644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfF1MBa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:01:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F0DFB627;
        Fri, 28 Jun 2019 12:01:29 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, stable@vger.kernel.org
Subject: [PATCH 20/37] bcache: fix mistaken sysfs entry for io_error counter
Date:   Fri, 28 Jun 2019 19:59:43 +0800
Message-Id: <20190628120000.40753-21-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bch_cached_dev_files[] from driver/md/bcache/sysfs.c, sysfs_errors is
incorrectly inserted in. The correct entry should be sysfs_io_errors.

This patch fixes the problem and now I/O errors of cached device can be
read from /sys/block/bcache<N>/bcache/io_errors.

Fixes: c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index eb678e43ac00..dddb8d4048ce 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -176,7 +176,7 @@ SHOW(__bch_cached_dev)
 	var_print(writeback_percent);
 	sysfs_hprint(writeback_rate,
 		     wb ? atomic_long_read(&dc->writeback_rate.rate) << 9 : 0);
-	sysfs_hprint(io_errors,		atomic_read(&dc->io_errors));
+	sysfs_printf(io_errors,		"%i", atomic_read(&dc->io_errors));
 	sysfs_printf(io_error_limit,	"%i", dc->error_limit);
 	sysfs_printf(io_disable,	"%i", dc->io_disable);
 	var_print(writeback_rate_update_seconds);
@@ -463,7 +463,7 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_writeback_rate_p_term_inverse,
 	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
-	&sysfs_errors,
+	&sysfs_io_errors,
 	&sysfs_io_error_limit,
 	&sysfs_io_disable,
 	&sysfs_dirty_data,
-- 
2.16.4

