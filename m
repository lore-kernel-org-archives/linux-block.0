Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF22C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17F3206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfDXQt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730534AbfDXQt5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F127EAF68;
        Wed, 24 Apr 2019 16:49:55 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 15/18] bcache: improve bcache_reboot()
Date:   Thu, 25 Apr 2019 00:48:40 +0800
Message-Id: <20190424164843.29535-16-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch tries to release mutex bch_register_lock early, to give
chance to stop cache set and bcache device early.

This patch also expends time out of stopping all bcache device from
2 seconds to 10 seconds, because stopping writeback rate update worker
may delay for 5 seconds, 2 seconds is not enough.

After this patch applied, stopping bcache devices during system reboot
or shutdown is very hard to be observed any more.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 drivers/md/bcache/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0363ab534c8e..3f34b96ebbc3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2397,10 +2397,19 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 		list_for_each_entry_safe(dc, tdc, &uncached_devices, list)
 			bcache_device_stop(&dc->disk);
 
+		mutex_unlock(&bch_register_lock);
+
+		/*
+		 * Give an early chance for other kthreads and
+		 * kworkers to stop themselves
+		 */
+		schedule();
+
 		/* What's a condition variable? */
 		while (1) {
-			long timeout = start + 2 * HZ - jiffies;
+			long timeout = start + 10 * HZ - jiffies;
 
+			mutex_lock(&bch_register_lock);
 			stopped = list_empty(&bch_cache_sets) &&
 				list_empty(&uncached_devices);
 
@@ -2412,7 +2421,6 @@ static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 
 			mutex_unlock(&bch_register_lock);
 			schedule_timeout(timeout);
-			mutex_lock(&bch_register_lock);
 		}
 
 		finish_wait(&unregister_wait, &wait);
-- 
2.16.4

