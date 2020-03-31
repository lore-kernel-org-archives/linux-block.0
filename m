Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78372C2D0EF
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD9208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCaJlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:15 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34077 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJlP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:15 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6hP024526;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 19/23] floppy: cleanup: make check_wp() not rely on current_{fdc,drive} anymore
Date:   Tue, 31 Mar 2020 11:40:50 +0200
Message-Id: <20200331094054.24441-20-w@1wt.eu>
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
 drivers/block/floppy.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b929b60afe9b..b9a3a04c2636 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1561,29 +1561,29 @@ static void seek_interrupt(void)
 	floppy_ready();
 }
 
-static void check_wp(void)
+static void check_wp(int fdc, int drive)
 {
-	if (test_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags)) {
+	if (test_bit(FD_VERIFY_BIT, &drive_state[drive].flags)) {
 					/* check write protection */
-		output_byte(current_fdc, FD_GETSTATUS);
-		output_byte(current_fdc, UNIT(current_drive));
-		if (result(current_fdc) != 1) {
-			fdc_state[current_fdc].reset = 1;
+		output_byte(fdc, FD_GETSTATUS);
+		output_byte(fdc, UNIT(drive));
+		if (result(fdc) != 1) {
+			fdc_state[fdc].reset = 1;
 			return;
 		}
-		clear_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags);
+		clear_bit(FD_VERIFY_BIT, &drive_state[drive].flags);
 		clear_bit(FD_NEED_TWADDLE_BIT,
-			  &drive_state[current_drive].flags);
-		debug_dcl(drive_params[current_drive].flags,
+			  &drive_state[drive].flags);
+		debug_dcl(drive_params[drive].flags,
 			  "checking whether disk is write protected\n");
-		debug_dcl(drive_params[current_drive].flags, "wp=%x\n",
+		debug_dcl(drive_params[drive].flags, "wp=%x\n",
 			  reply_buffer[ST3] & 0x40);
 		if (!(reply_buffer[ST3] & 0x40))
 			set_bit(FD_DISK_WRITABLE_BIT,
-				&drive_state[current_drive].flags);
+				&drive_state[drive].flags);
 		else
 			clear_bit(FD_DISK_WRITABLE_BIT,
-				  &drive_state[current_drive].flags);
+				  &drive_state[drive].flags);
 	}
 }
 
@@ -1627,7 +1627,7 @@ static void seek_floppy(void)
 			track = 1;
 		}
 	} else {
-		check_wp();
+		check_wp(current_fdc, current_drive);
 		if (raw_cmd->track != drive_state[current_drive].track &&
 		    (raw_cmd->flags & FD_RAW_NEED_SEEK))
 			track = raw_cmd->track;
-- 
2.20.1

