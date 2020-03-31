Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177FEC2D0EE
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEE720B1F
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgCaJml (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:41 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34163 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgCaJml (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:41 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f5np024516;
        Tue, 31 Mar 2020 11:41:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 09/23] floppy: cleanup: make twaddle() not rely on current_{fdc,drive} anymore
Date:   Tue, 31 Mar 2020 11:40:40 +0200
Message-Id: <20200331094054.24441-10-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc and drive are passed in argument so that the function does
not use current_fdc nor current_drive anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 1cda39098b07..b1729daa2e2e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -827,14 +827,14 @@ static int set_dor(int fdc, char mask, char data)
 	return olddor;
 }
 
-static void twaddle(void)
+static void twaddle(int fdc, int drive)
 {
-	if (drive_params[current_drive].select_delay)
+	if (drive_params[drive].select_delay)
 		return;
-	fdc_outb(fdc_state[current_fdc].dor & ~(0x10 << UNIT(current_drive)),
-		 current_fdc, FD_DOR);
-	fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
-	drive_state[current_drive].select_date = jiffies;
+	fdc_outb(fdc_state[fdc].dor & ~(0x10 << UNIT(drive)),
+		 fdc, FD_DOR);
+	fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
+	drive_state[drive].select_date = jiffies;
 }
 
 /*
@@ -1934,7 +1934,7 @@ static void floppy_ready(void)
 		  "calling disk change from floppy_ready\n");
 	if (!(raw_cmd->flags & FD_RAW_NO_MOTOR) &&
 	    disk_change(current_drive) && !drive_params[current_drive].select_delay)
-		twaddle();	/* this clears the dcl on certain
+		twaddle(current_fdc, current_drive);	/* this clears the dcl on certain
 				 * drive/controller combinations */
 
 #ifdef fd_chose_dma_mode
@@ -2904,7 +2904,7 @@ static void redo_fd_request(void)
 	}
 
 	if (test_bit(FD_NEED_TWADDLE_BIT, &drive_state[current_drive].flags))
-		twaddle();
+		twaddle(current_fdc, current_drive);
 	schedule_bh(floppy_start);
 	debugt(__func__, "queue fd request");
 	return;
@@ -3610,7 +3610,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 	case FDTWADDLE:
 		if (lock_fdc(drive))
 			return -EINTR;
-		twaddle();
+		twaddle(current_fdc, current_drive);
 		process_fd_request();
 		return 0;
 	default:
-- 
2.20.1

