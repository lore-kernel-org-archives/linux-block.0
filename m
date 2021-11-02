Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B8C433FE
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334B1603E8
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhKBBmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:42:33 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26143 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhKBBma (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 21:42:30 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HjswX7274z1DJ5m;
        Tue,  2 Nov 2021 09:37:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 2
 Nov 2021 09:39:51 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH -next v4 1/4] nbd: fix max value for 'first_minor'
Date:   Tue, 2 Nov 2021 09:52:34 +0800
Message-ID: <20211102015237.2309763-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102015237.2309763-1-yebin10@huawei.com>
References: <20211102015237.2309763-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit b1a811633f73 ("block: nbd: add sanity check for first_minor")
checks that 'first_minor' should not be greater than 0xff, which is
wrong. Whitout the commit, the details that when user pass 0x100000,
it ends up create sysfs dir "/sys/block/43:0" are as follows:

nbd_dev_add
 disk->first_minor = index << part_shift
  -> default part_shift is 5, first_minor is 0x2000000
  device_add_disk
   ddev->devt = MKDEV(disk->major, disk->first_minor)
    -> (0x2b << 20) | (0x2000000) = 0x2b00000
   device_add
    device_create_sys_dev_entry
	 format_dev_t
	  sprintf(buffer, "%u:%u", MAJOR(dev), MINOR(dev));
	   -> got 43:0
	  sysfs_create_link -> /sys/block/43:0

By the way, with the wrong fix, when part_shift is the default value,
only 8 ndb devices can be created since 8 << 5 is greater than 0xff.

Since the max bits for 'first_minor' should be the same as what
MKDEV() does, which is 20. Change the upper bound of 'first_minor'
from 0xff to 0xfffff.

Fixes: b1a811633f73 ("block: nbd: add sanity check for first_minor")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b47b2a87ae8f..678ee2688f63 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1803,11 +1803,11 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->major = NBD_MAJOR;
 
 	/* Too big first_minor can cause duplicate creation of
-	 * sysfs files/links, since first_minor will be truncated to
-	 * byte in __device_add_disk().
+	 * sysfs files/links, since MKDEV() expect that the max bits of
+	 * first_minor is 20.
 	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor > 0xff) {
+	if (disk->first_minor > MINORMASK) {
 		err = -EINVAL;
 		goto out_free_idr;
 	}
-- 
2.31.1

