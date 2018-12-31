Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1464DC43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 05:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759720B1F
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 05:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbeLaFtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 00:49:05 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41914 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLaFtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 00:49:05 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9382729BC9; Mon, 31 Dec 2018 00:49:02 -0500 (EST)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <f84a43669647c55b91c2a46e7876d8dd2a713c8a.1546235049.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] block/swim3: Remove dead return statement
Date:   Mon, 31 Dec 2018 16:44:09 +1100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c1c676a33e4a..ba1190f1276b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1151,7 +1151,6 @@ static int swim3_add_device(struct macio_dev *mdev, int index)
 		swim3_err("%s", "Couldn't request interrupt\n");
 		pmac_call_feature(PMAC_FTR_SWIM3_ENABLE, swim, 0, 0);
 		goto out_unmap;
-		return -EBUSY;
 	}
 
 	timer_setup(&fs->timeout, NULL, 0);
-- 
2.19.2

