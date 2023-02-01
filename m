Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD54C05027
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 08:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBAIRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAIRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 03:17:21 -0500
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 00:17:20 PST
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355245D11E
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 00:17:19 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id XCS00108;
        Wed, 01 Feb 2023 16:16:08 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.16; Wed, 1 Feb 2023 16:16:09 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] null_blk: convert sysfs snprintf to sysfs_emit
Date:   Wed, 1 Feb 2023 03:16:04 -0500
Message-ID: <20230201081604.3228-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2023201161608d13dc716d0ef8b4f690272e9cc05d004
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/block/null_blk/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4c601ca9552a..7b79cda53c81 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -255,18 +255,18 @@ static inline struct nullb_device *to_nullb_device(struct config_item *item)
 
 static inline ssize_t nullb_device_uint_attr_show(unsigned int val, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(page, "%u\n", val);
 }
 
 static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
 	char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%lu\n", val);
+	return sysfs_emit(page, "%lu\n", val);
 }
 
 static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(page, "%u\n", val);
 }
 
 static ssize_t nullb_device_uint_attr_store(unsigned int *val,
@@ -627,7 +627,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE,
+	return sysfs_emit(page,
 			"badblocks,blocking,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
-- 
2.27.0

