Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F68C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DB22177E
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBNWYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:24:53 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46786 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440475AbfBNWXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 17:23:00 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 6C29729BE1; Thu, 14 Feb 2019 17:22:55 -0500 (EST)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <34350e8aeb63c19f5b204c3f7b961a99708b50ff.1550182390.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] block/swim: Return -EROFS for FMODE_WRITE
Date:   Fri, 15 Feb 2019 09:13:10 +1100
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Write requests are not supported by the driver and result in IO errors:

print_req_error: I/O error, dev fd0, sector 0
buffer_io_error: 26 callbacks suppressed
Buffer I/O error on dev fd0, logical block 0, lost async page write
Buffer I/O error on dev fd0, logical block 1, lost async page write
Buffer I/O error on dev fd0, logical block 2, lost async page write
Buffer I/O error on dev fd0, logical block 3, lost async page write
Buffer I/O error on dev fd0, logical block 4, lost async page write
Buffer I/O error on dev fd0, logical block 5, lost async page write
Buffer I/O error on dev fd0, logical block 6, lost async page write
Buffer I/O error on dev fd0, logical block 7, lost async page write
Buffer I/O error on dev fd0, logical block 8, lost async page write
Buffer I/O error on dev fd0, logical block 9, lost async page write
print_req_error: I/O error, dev fd0, sector 2688
print_req_error: I/O error, dev fd0, sector 0

Cc: linux-m68k@lists.linux-m68k.org
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3fa6fcc34790..dd19f422fb0d 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -643,7 +643,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
 		check_disk_change(bdev);
-		if ((mode & FMODE_WRITE) && fs->write_protected) {
+		if (mode & FMODE_WRITE) { /* not implemented */
 			err = -EROFS;
 			goto out;
 		}
-- 
2.19.2

