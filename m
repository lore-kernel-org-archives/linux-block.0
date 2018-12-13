Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C8C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF52086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACF52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeLMOze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbeLMOze (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED825AD5C;
        Thu, 13 Dec 2018 14:55:32 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 06/12] bcache: cannot set writeback_running via sysfs if no writeback kthread created
Date:   Thu, 13 Dec 2018 22:53:51 +0800
Message-Id: <20181213145357.38528-7-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
References: <20181213145357.38528-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

"echo 1 > writeback_running" marks writeback_running even if no writeback
kthread created as "d_strtoul(writeback_running)" will simply set dc->
writeback_running without checking the existence of dc->writeback_thread.

Add check for setting writeback_running via sysfs: if no writeback kthread
available, reject setting to 1.

v2 -> v3:
  * Make message on wrong assignment more clear.
  * Print name of bcache device instead of name of backing device.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index d2e5c9892d4d..9d5fe12f0c9c 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -384,8 +384,25 @@ STORE(bch_cached_dev)
 	mutex_lock(&bch_register_lock);
 	size = __cached_dev_store(kobj, attr, buf, size);
 
-	if (attr == &sysfs_writeback_running)
-		bch_writeback_queue(dc);
+	if (attr == &sysfs_writeback_running) {
+		/* dc->writeback_running changed in __cached_dev_store() */
+		if (IS_ERR_OR_NULL(dc->writeback_thread)) {
+			/*
+			 * reject setting it to 1 via sysfs if writeback
+			 * kthread is not created yet.
+			 */
+			if (dc->writeback_running) {
+				dc->writeback_running = false;
+				pr_err("%s: failed to run non-existent writeback thread",
+						dc->disk.disk->disk_name);
+			}
+		} else
+			/*
+			 * writeback kthread will check if dc->writeback_running
+			 * is true or false.
+			 */
+			bch_writeback_queue(dc);
+	}
 
 	if (attr == &sysfs_writeback_percent)
 		if (!test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
-- 
2.16.4

