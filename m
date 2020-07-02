Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35004C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AF52082F
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 01:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGBBy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:54:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgGBBy7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 21:54:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ACE7739AAA95A4870431;
        Thu,  2 Jul 2020 09:54:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 09:54:56 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <axboe@kernel.dk>
Subject: [PATCH] loop: change to punch hole if zero range is not supported
Date:   Wed, 1 Jul 2020 21:54:01 -0400
Message-ID: <20200702015401.51199-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We found a problem when excuting these operations.

$ cd /tmp
$ qemu-img create -f raw test.img 10G
$ mknod -m 0660 /dev/loop0 b 7 0
$ losetup /dev/loop0 test.img
$ mkfs /dev/loop0

Here is the error message.

[  142.364823] blk_update_request: operation not supported error,
 dev loop0, sector 20971392 op 0x9:(WRITE_ZEROES) flags 0x1000800
 phys_seg 0 prio class 0
[  142.371823] blk_update_request: operation not supported error,
 dev loop0, sector 5144 op 0x9:(WRITE_ZEROES) flags 0x1000800
 phys_seg 0 prio class 0

The problem is that not all filesystem support zero range (eg, tmpfs), if
 filesystem doesn 't support zero range, change to punch hole to fix it.

Fixes: efcfec579f613 ("loop: fix no-unmap write-zeroes request behavior")
Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 drivers/block/loop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c33bbbfd1bd9..504e658adcaf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -450,6 +450,13 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	}
 
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+
+	if ((ret == -EOPNOTSUPP) && (mode & FALLOC_FL_ZERO_RANGE)) {
+		mode &= ~FALLOC_FL_ZERO_RANGE;
+		mode |= FALLOC_FL_PUNCH_HOLE;
+		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+	}
+
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		ret = -EIO;
  out:
-- 
2.19.1

