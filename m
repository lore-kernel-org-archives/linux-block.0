Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D7C282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA421903
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBIExg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIExg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C33A4AF6F;
        Sat,  9 Feb 2019 04:53:34 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 05/19] bcache: fix indentation issue, remove tabs on a hunk of code
Date:   Sat,  9 Feb 2019 12:52:57 +0800
Message-Id: <20190209045311.15677-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code that is indented one level too deep, fix this
by removing the extra tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4dee119c3664..a697a3a923cd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1615,21 +1615,21 @@ static void conditional_stop_bcache_device(struct cache_set *c,
 		 */
 		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is dirty, stop it to avoid potential data corruption.",
 			d->disk->disk_name);
-			/*
-			 * There might be a small time gap that cache set is
-			 * released but bcache device is not. Inside this time
-			 * gap, regular I/O requests will directly go into
-			 * backing device as no cache set attached to. This
-			 * behavior may also introduce potential inconsistence
-			 * data in writeback mode while cache is dirty.
-			 * Therefore before calling bcache_device_stop() due
-			 * to a broken cache device, dc->io_disable should be
-			 * explicitly set to true.
-			 */
-			dc->io_disable = true;
-			/* make others know io_disable is true earlier */
-			smp_mb();
-			bcache_device_stop(d);
+		/*
+		 * There might be a small time gap that cache set is
+		 * released but bcache device is not. Inside this time
+		 * gap, regular I/O requests will directly go into
+		 * backing device as no cache set attached to. This
+		 * behavior may also introduce potential inconsistence
+		 * data in writeback mode while cache is dirty.
+		 * Therefore before calling bcache_device_stop() due
+		 * to a broken cache device, dc->io_disable should be
+		 * explicitly set to true.
+		 */
+		dc->io_disable = true;
+		/* make others know io_disable is true earlier */
+		smp_mb();
+		bcache_device_stop(d);
 	} else {
 		/*
 		 * dc->stop_when_cache_set_failed == BCH_CACHED_STOP_AUTO
-- 
2.16.4

