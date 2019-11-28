Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B36C432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 12:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5704B2176D
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 12:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK1MaC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:30:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42533 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 07:30:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iaIvn-0006Kj-A3; Thu, 28 Nov 2019 12:29:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] zram: fix error return codes not being returned in writeback_store
Date:   Thu, 28 Nov 2019 12:29:58 +0000
Message-Id: <20191128122958.178290-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when an error code -EIO or -ENOSPC in the for-loop of
writeback_store the error code is being overwritten by a ret = len
assignment at the end of the function and the error codes are being
lost.  Fix this by assigning ret = len at the start of the function
and remove the assignment from the end, hence allowing ret to be
preserved when error codes are assigned to it.

Addresses-Coverity: ("Unused value")
Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4285e75e52c3..1bf4a908a0bd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -626,7 +626,7 @@ static ssize_t writeback_store(struct device *dev,
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
-	ssize_t ret;
+	ssize_t ret = len;
 	int mode;
 	unsigned long blk_idx = 0;
 
@@ -762,7 +762,6 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	ret = len;
 	__free_page(page);
 release_init_lock:
 	up_read(&zram->init_lock);
-- 
2.24.0

