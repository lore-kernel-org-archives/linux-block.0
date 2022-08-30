Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF2ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 12:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiH3Mjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH3Mjs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:48 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFB12F571
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 05:39:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661863178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7uM+dEC8iPW0bDtb/BhfLMToCK2jloinourCEMiEeA=;
        b=Vc5dP87wuxPmifjfnQj/BtBG+S5yTo+czq3rS+iMCRRK4jr0trJfgHxRgmghNnFMaRpBWw
        cMr9dq4oZG7WTTwR1YTKsLawvNdV/EzMpWRFpMVzFYSF9GPvEnizEdvHizi23zIU//heud
        miIfydSRbFfMi4VRZPR3/7BNM6PYwN8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] rnbd-srv: remove redundant setting of blk_open_flags
Date:   Tue, 30 Aug 2022 20:39:04 +0800
Message-Id: <20220830123904.26671-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220830123904.26671-1-guoqing.jiang@linux.dev>
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is not necessary since it is set later just before function
return success.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index c63017f6e421..38131fa5718d 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -21,7 +21,6 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev->blk_open_flags = flags;
 	dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
 	ret = PTR_ERR_OR_ZERO(dev->bdev);
 	if (ret)
-- 
2.34.1

