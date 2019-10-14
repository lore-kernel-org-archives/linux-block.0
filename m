Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F39C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2F020882
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfJNJrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:47:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfJNJrC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 05:47:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4C585C5DEB9B2E3051D;
        Mon, 14 Oct 2019 17:46:59 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 14 Oct 2019 17:46:51 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <sergey.senozhatsky.work@gmail.com>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] zram: fix race between backing_dev_show and backing_dev_store
Date:   Mon, 14 Oct 2019 17:53:59 +0800
Message-ID: <1571046839-16814-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

CPU0:				       CPU1:
backing_dev_show		       backing_dev_store
    ......				   ......
    file = zram->backing_dev;
    down_read(&zram->init_lock);	   down_read(&zram->init_init_lock)
    file_path(file, ...);		   zram->backing_dev = backing_dev;
    up_read(&zram->init_lock);		   up_read(&zram->init_lock);

get the value of zram->backing_dev too early in backing_dev_show,
that will result the value may be NULL at the begining, and not
NULL later.

backtrace:
[<ffffff8570e0f3ec>] d_path+0xcc/0x174
[<ffffff8570decd90>] file_path+0x10/0x18
[<ffffff85712f7630>] backing_dev_show+0x40/0xb4
[<ffffff85712c776c>] dev_attr_show+0x20/0x54
[<ffffff8570e835e4>] sysfs_kf_seq_show+0x9c/0x10c
[<ffffff8570e82b98>] kernfs_seq_show+0x28/0x30
[<ffffff8570e1c580>] seq_read+0x184/0x488
[<ffffff8570e81ec4>] kernfs_fop_read+0x5c/0x1a4
[<ffffff8570dee0fc>] __vfs_read+0x44/0x128
[<ffffff8570dee310>] vfs_read+0xa0/0x138
[<ffffff8570dee860>] SyS_read+0x54/0xb4

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/block/zram/zram_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d58a359..4285e75 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -413,13 +413,14 @@ static void reset_bdev(struct zram *zram)
 static ssize_t backing_dev_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
+	struct file *file;
 	struct zram *zram = dev_to_zram(dev);
-	struct file *file = zram->backing_dev;
 	char *p;
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	if (!zram->backing_dev) {
+	file = zram->backing_dev;
+	if (!file) {
 		memcpy(buf, "none\n", 5);
 		up_read(&zram->init_lock);
 		return 5;
-- 
2.7.4

