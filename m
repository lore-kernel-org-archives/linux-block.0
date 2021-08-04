Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E292C4320A
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 02:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57AC60E78
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 02:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhHDCBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:01:38 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13273 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHDCBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 22:01:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GfZbk0H72z82X0;
        Wed,  4 Aug 2021 09:56:34 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 10:01:20 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 4 Aug 2021
 10:01:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patchwork@huawei.com>, <libaokun1@huawei.com>,
        <yukuai3@huawei.com>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next v3] nbd: add the check to prevent overflow in __nbd_ioctl()
Date:   Wed, 4 Aug 2021 10:12:12 +0800
Message-ID: <20210804021212.990223-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If user specify a large enough value of NBD blocks option, it may trigger
signed integer overflow which may lead to nbd->config->bytesize becomes a
large or small value, zero in particular.

UBSAN: Undefined behaviour in drivers/block/nbd.c:325:31
signed integer overflow:
1024 * 4611686155866341414 cannot be represented in type 'long long int'
[...]
Call trace:
[...]
 handle_overflow+0x188/0x1dc lib/ubsan.c:192
 __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
 nbd_size_set drivers/block/nbd.c:325 [inline]
 __nbd_ioctl drivers/block/nbd.c:1342 [inline]
 nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
 __blkdev_driver_ioctl block/ioctl.c:311 [inline]
[...]

Although it is not a big deal, still silence the UBSAN by limit
the input value.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Use check_mul_overflow().
V2->V3:
	The check_mul_overflow function requires the same input parameter type.

 drivers/block/nbd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..5a42b838d26c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1384,6 +1384,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
 {
 	struct nbd_config *config = nbd->config;
+	loff_t bytesize;
 
 	switch (cmd) {
 	case NBD_DISCONNECT:
@@ -1398,8 +1399,11 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SIZE:
 		return nbd_set_size(nbd, arg, config->blksize);
 	case NBD_SET_SIZE_BLOCKS:
-		return nbd_set_size(nbd, arg * config->blksize,
-				    config->blksize);
+		if (unlikely(check_mul_overflow((loff_t)arg,
+						config->blksize,
+						&bytesize)))
+			return -EINVAL;
+		return nbd_set_size(nbd, bytesize, config->blksize);
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
 		return 0;
-- 
2.31.1

