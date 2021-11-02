Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A942C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 01:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F8761053
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhKBBma (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:42:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26144 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhKBBm3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 21:42:29 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HjswY2tchz1DHwD;
        Tue,  2 Nov 2021 09:37:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 2
 Nov 2021 09:39:51 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH -next v4 2/4] nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
Date:   Tue, 2 Nov 2021 09:52:35 +0800
Message-ID: <20211102015237.2309763-3-yebin10@huawei.com>
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

If 'part_shift' is not zero, then 'index << part_shift' might
overflow to a value that is not greater than '0xfffff', then sysfs
might complains about duplicate creation.

Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 678ee2688f63..cc32b5bc0f49 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1803,11 +1803,11 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->major = NBD_MAJOR;
 
 	/* Too big first_minor can cause duplicate creation of
-	 * sysfs files/links, since MKDEV() expect that the max bits of
-	 * first_minor is 20.
+	 * sysfs files/links, since index << part_shift might overflow, or
+	 * MKDEV() expect that the max bits of first_minor is 20.
 	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor > MINORMASK) {
+	if (disk->first_minor < index || disk->first_minor > MINORMASK) {
 		err = -EINVAL;
 		goto out_free_idr;
 	}
-- 
2.31.1

