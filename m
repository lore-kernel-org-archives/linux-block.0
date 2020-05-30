Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB39C433E0
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 03:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43016208E4
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 03:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgE3DlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 23:41:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5831 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbgE3DlP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 23:41:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 421E744C4112D24059FF;
        Sat, 30 May 2020 11:41:13 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 30 May 2020
 11:41:03 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>, <jaegeuk@kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] loop: replace kill_bdev with invalidate_bdev
Date:   Sat, 30 May 2020 11:48:09 +0800
Message-ID: <20200530034809.33610-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When a filesystem is mounting on a loop device and on a loop ioctl
LOOP_SET_STATUS64, because of kill_bdev, buffer_head mappings are getting
destroyed.
kill_bdev
  truncate_inode_pages
    truncate_inode_pages_range
      do_invalidatepage
        block_invalidatepage
          discard_buffer  -->clear BH_Mapped flag

sb_bread
  __bread_gfp
  bh = __getblk_gfp
  -->discard_buffer clear BH_Mapped flag
  __bread_slow
    submit_bh
      submit_bh_wbc
        BUG_ON(!buffer_mapped(bh))  --> hit this BUG_ON

Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/block/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..418bb4621255 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1289,7 +1289,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
 	}

 	/* I/O need to be drained during transfer transition */
@@ -1320,7 +1320,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)

 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
+		/* invalidate_bdev should have truncated all the pages */
 		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 			err = -EAGAIN;
 			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
@@ -1565,11 +1565,11 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 		return 0;

 	sync_blockdev(lo->lo_device);
-	kill_bdev(lo->lo_device);
+	invalidate_bdev(lo->lo_device);

 	blk_mq_freeze_queue(lo->lo_queue);

-	/* kill_bdev should have truncated all the pages */
+	/* invalidate_bdev should have truncated all the pages */
 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 		err = -EAGAIN;
 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
--
2.21.3

