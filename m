Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiCUHON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344758AbiCUHOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 03:14:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E515468D
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 00:12:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647846765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KA0lCKf4/kgKJuKGBXgpggGS3DdAYFFfpGenm8FOEBw=;
        b=GpK4i9vQejupjAOl1yB60ZbbYkE3hCiYVWkPu8fci4h+zmJ7dkuEYRQOhIxmZXJe1ZCY0f
        SIOo5sQCiO7zRCqYKFOERQgFKdZqGuK0GVo52wVdsPn1ITn371/f4dB4PXcbio9qZxOEuG
        902iqQK7FGhcTCjFrBA2L/R+N4k0IcI=
From:   Jackie Liu <liu.yun@linux.dev>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] n64cart: convert bi_disk to bi_bdev->bd_disk fix build
Date:   Mon, 21 Mar 2022 15:12:16 +0800
Message-Id: <20220321071216.1549596-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

My kernel robot report below:

  drivers/block/n64cart.c: In function ‘n64cart_submit_bio’:
  drivers/block/n64cart.c:91:26: error: ‘struct bio’ has no member named ‘bi_disk’
     91 |  struct device *dev = bio->bi_disk->private_data;
        |                          ^~
    CC      drivers/slimbus/qcom-ctrl.o
    CC      drivers/auxdisplay/hd44780.o
    CC      drivers/watchdog/watchdog_core.o
    CC      drivers/nvme/host/fault_inject.o
    AR      drivers/accessibility/braille/built-in.a
  make[2]: *** [scripts/Makefile.build:288: drivers/block/n64cart.o] Error 1

Fixes: 309dca309fc3 ("block: store a block_device pointer in struct bio");
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/block/n64cart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index 4db9a8c244af..e094d2b8b5a9 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -88,7 +88,7 @@ static void n64cart_submit_bio(struct bio *bio)
 {
 	struct bio_vec bvec;
 	struct bvec_iter iter;
-	struct device *dev = bio->bi_disk->private_data;
+	struct device *dev = bio->bi_bdev->bd_disk->private_data;
 	u32 pos = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 
 	bio_for_each_segment(bvec, bio, iter) {
-- 
2.25.1

