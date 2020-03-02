Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79446C3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566BC2187F
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCBNYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:24:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:34682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCBNYV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 08:24:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92FA2AFAA;
        Mon,  2 Mar 2020 13:24:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Remove used kblockd_schedule_work_on()
Date:   Mon,  2 Mar 2020 14:24:08 +0100
Message-Id: <20200302132408.15954-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit ee63cfa7fc19 ("block: add kblockd_schedule_work_on()")
introduced the helper in 2016. Remove it because since then no caller
was added.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-core.c       | 6 ------
 include/linux/blkdev.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..60dc9552ef8d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1663,12 +1663,6 @@ int kblockd_schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work);
 
-int kblockd_schedule_work_on(int cpu, struct work_struct *work)
-{
-	return queue_work_on(cpu, kblockd_workqueue, work);
-}
-EXPORT_SYMBOL(kblockd_schedule_work_on);
-
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 				unsigned long delay)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 053ea4b51988..1797d1111b44 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1494,7 +1494,6 @@ static inline void put_dev_sector(Sector p)
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-int kblockd_schedule_work_on(int cpu, struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
-- 
2.16.4

