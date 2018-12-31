Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE8C43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFEE21773
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 05:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeLaFtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 00:49:05 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41912 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLaFtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 00:49:05 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 8B2AE29BD3; Mon, 31 Dec 2018 00:49:02 -0500 (EST)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <980e56c9dd86f2f94ea1f33d8b6cb27fe10ca436.1546235049.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] block/amiflop: Don't log error message on invalid ioctl
Date:   Mon, 31 Dec 2018 16:44:09 +1100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/amiflop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index bf996bd44cfc..0903e0803ec8 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1601,8 +1601,6 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 			return p->type->read_size;
 #endif
 	default:
-		printk(KERN_DEBUG "fd_ioctl: unknown cmd %d for drive %d.",
-		       cmd, drive);
 		return -ENOSYS;
 	}
 	return 0;
-- 
2.19.2

