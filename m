Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0848C433FE
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 01:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1AE61184
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 01:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhIFBXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239419AbhIFBWl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Sep 2021 21:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04772610FF;
        Mon,  6 Sep 2021 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891275;
        bh=2N0noRVgp/X4pfLYlCFS6gIxkh55PkKkiJe25n3MQaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9+GWw8c2i0M8IfmsIvOZoF3R7o2jt0xK1ga02WLeMGiW31FWzbig/KB5MoV2svvf
         K2njAdDCnDAm+T1PEK/vm0Z7Wt6zH0VK/66TKAmRAe4iKuFouRPV19pPrl02lUiBpD
         sljFMDDlKvGbELRadzrsgrV30s0NtX8Lr6XOcouidHYvDaO6s9Kh6ZHJ/gIIAiEiiI
         kysFoESVHdHL138T80clvQmBU11dIBclDEkjXwGJZbOBTBr/bexq0NT/Di0LKJRBky
         oVsGVh3WFkbR42QDBN/3stwq1MoWBdQ+jTrh5iTAVbRa7DBPe14sCymcPSrLUs54P7
         +rQ+/LUmRRpHg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baokun Li <libaokun1@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.13 18/46] nbd: add the check to prevent overflow in __nbd_ioctl()
Date:   Sun,  5 Sep 2021 21:20:23 -0400
Message-Id: <20210906012052.929174-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012052.929174-1-sashal@kernel.org>
References: <20210906012052.929174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit fad7cd3310db3099f95dd34312c77740fbc455e5 ]

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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20210804021212.990223-1-libaokun1@huawei.com
[axboe: dropped unlikely()]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1061894a55df..7384058c24d0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1369,6 +1369,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		       unsigned int cmd, unsigned long arg)
 {
 	struct nbd_config *config = nbd->config;
+	loff_t bytesize;
 
 	switch (cmd) {
 	case NBD_DISCONNECT:
@@ -1383,8 +1384,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SIZE:
 		return nbd_set_size(nbd, arg, config->blksize);
 	case NBD_SET_SIZE_BLOCKS:
-		return nbd_set_size(nbd, arg * config->blksize,
-				    config->blksize);
+		if (check_mul_overflow((loff_t)arg, config->blksize, &bytesize))
+			return -EINVAL;
+		return nbd_set_size(nbd, bytesize, config->blksize);
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
 		return 0;
-- 
2.30.2

