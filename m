Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83009C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F23610D0
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 12:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhJUMUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:20:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29921 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhJUMSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 08:18:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZmYq6ysxzbnKs;
        Thu, 21 Oct 2021 20:11:59 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 20:16:34 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Thu, 21
 Oct 2021 20:16:33 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <paskripkin@gmail.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <luomeng12@huawei.com>
Subject: [PATCH 2/2] nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
Date:   Thu, 21 Oct 2021 20:29:36 +0800
Message-ID: <20211021122936.758221-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021122936.758221-1-yukuai3@huawei.com>
References: <20211021122936.758221-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If 'part_shift' is not zero, then 'index << part_shift' might
overflow to a value that is not greater than '0xfffff', then sysfs
might complains about duplicate creation.

Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f2c17a33c5b..03a10a87500d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1808,11 +1808,11 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->major = NBD_MAJOR;
 
 	/* Too big first_minor can cause duplicate creation of
-	 * sysfs files/links, since MKDEV() expect that the max bits of
-	 * first_minor is 20.
+	 * sysfs files/links, since index << part_shift might overflow, or
+	 * MKDEV() expect that the max bits of first_minor is 20.
 	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor > 0xfffff) {
+	if (disk->first_minor < index || disk->first_minor > 0xfffff) {
 		err = -EINVAL;
 		goto out_free_idr;
 	}
-- 
2.31.1

