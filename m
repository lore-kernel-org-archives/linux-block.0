Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E851C31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168852082C
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405726AbfFLQUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:20:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405068AbfFLQUO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 12:20:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08271AF90;
        Wed, 12 Jun 2019 16:20:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 2/4] bcache: acquire bch_register_lock later in cached_dev_detach_finish()
Date:   Thu, 13 Jun 2019 00:19:56 +0800
Message-Id: <20190612161958.2082-3-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190612161958.2082-1-colyli@suse.de>
References: <20190612161958.2082-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now there is variable bcache_is_reboot to prevent device register or
unregister during reboot, it is unncessary to still hold mutex lock
bch_register_lock before stopping writeback_rate_update kworker and
writeback kthread. And if the stopping kworker or kthread holding
bch_register_lock inside their routine (we used to have such problem
in writeback thread, thanks to Junhui Wang fixed it), it is very easy
to introduce deadlock during reboot/shutdown procedure.

Therefore in this patch, the location to acquire bch_register_lock is
moved to the location before calling calc_cached_dev_sectors(). Which
is later then original location in cached_dev_detach_finish().

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2928adfea743..15916b3ec8bf 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1018,7 +1018,6 @@ static void cached_dev_detach_finish(struct work_struct *w)
 	BUG_ON(!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags));
 	BUG_ON(refcount_read(&dc->count));
 
-	mutex_lock(&bch_register_lock);
 
 	if (test_and_clear_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags))
 		cancel_writeback_rate_update_dwork(dc);
@@ -1034,6 +1033,8 @@ static void cached_dev_detach_finish(struct work_struct *w)
 	bch_write_bdev_super(dc, &cl);
 	closure_sync(&cl);
 
+	mutex_lock(&bch_register_lock);
+
 	calc_cached_dev_sectors(dc->disk.c);
 	bcache_device_detach(&dc->disk);
 	list_move(&dc->list, &uncached_devices);
-- 
2.16.4

