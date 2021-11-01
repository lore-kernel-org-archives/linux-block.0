Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85222C433FE
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 06:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0D56108D
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 06:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhKAGUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:20:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15323 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhKAGUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 02:20:00 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HjN9M2nQyz90d6;
        Mon,  1 Nov 2021 14:17:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 1
 Nov 2021 14:17:08 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 1/2] nbd: Fix incorrect error handle when first_minor big than '0xff' in nbd_dev_add
Date:   Mon, 1 Nov 2021 14:29:55 +0800
Message-ID: <20211101062956.791573-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101062956.791573-1-yebin10@huawei.com>
References: <20211101062956.791573-1-yebin10@huawei.com>
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

If first_minor big than '0xff' goto out_free_idr label, this will miss
cleanup disk.

Fixes: b1a811633f73 ("block: nbd: add sanity check for first_minor")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b47b2a87ae8f..096883ab9b76 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1809,7 +1809,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->first_minor = index << part_shift;
 	if (disk->first_minor > 0xff) {
 		err = -EINVAL;
-		goto out_free_idr;
+		goto out_err_disk;
 	}
 
 	disk->minors = 1 << part_shift;
-- 
2.31.1

