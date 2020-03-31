Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCCC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1B2072E
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgCaJn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:43:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34183 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgCaJn3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:43:29 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6pf024520;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 13/23] floppy: cleanup: make output_byte() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:44 +0200
Message-Id: <20200331094054.24441-14-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc is passed in argument so that the function does not
use current_fdc anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 64 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 5dfddd4726fb..81fd06eaea7d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1128,26 +1128,26 @@ static int wait_til_ready(int fdc)
 }
 
 /* sends a command byte to the fdc */
-static int output_byte(char byte)
+static int output_byte(int fdc, char byte)
 {
-	int status = wait_til_ready(current_fdc);
+	int status = wait_til_ready(fdc);
 
 	if (status < 0)
 		return -1;
 
 	if (is_ready_state(status)) {
-		fdc_outb(byte, current_fdc, FD_DATA);
+		fdc_outb(byte, fdc, FD_DATA);
 		output_log[output_log_pos].data = byte;
 		output_log[output_log_pos].status = status;
 		output_log[output_log_pos].jiffies = jiffies;
 		output_log_pos = (output_log_pos + 1) % OLOGSIZE;
 		return 0;
 	}
-	fdc_state[current_fdc].reset = 1;
+	fdc_state[fdc].reset = 1;
 	if (initialized) {
 		DPRINT("Unable to send byte %x to FDC. Fdc=%x Status=%x\n",
-		       byte, current_fdc, status);
-		show_floppy(current_fdc);
+		       byte, fdc, status);
+		show_floppy(fdc);
 	}
 	return -1;
 }
@@ -1229,8 +1229,8 @@ static void perpendicular_mode(void)
 	if (fdc_state[current_fdc].perp_mode == perp_mode)
 		return;
 	if (fdc_state[current_fdc].version >= FDC_82077_ORIG) {
-		output_byte(FD_PERPENDICULAR);
-		output_byte(perp_mode);
+		output_byte(current_fdc, FD_PERPENDICULAR);
+		output_byte(current_fdc, perp_mode);
 		fdc_state[current_fdc].perp_mode = perp_mode;
 	} else if (perp_mode) {
 		DPRINT("perpendicular mode not supported by this FDC.\n");
@@ -1243,12 +1243,12 @@ static int no_fifo;
 static int fdc_configure(void)
 {
 	/* Turn on FIFO */
-	output_byte(FD_CONFIGURE);
+	output_byte(current_fdc, FD_CONFIGURE);
 	if (need_more_output() != MORE_OUTPUT)
 		return 0;
-	output_byte(0);
-	output_byte(0x10 | (no_fifo & 0x20) | (fifo_depth & 0xf));
-	output_byte(0);		/* pre-compensation from track
+	output_byte(current_fdc, 0);
+	output_byte(current_fdc, 0x10 | (no_fifo & 0x20) | (fifo_depth & 0xf));
+	output_byte(current_fdc, 0);		/* pre-compensation from track
 				   0 upwards */
 	return 1;
 }
@@ -1301,10 +1301,10 @@ static void fdc_specify(void)
 		if (fdc_state[current_fdc].version >= FDC_82078) {
 			/* chose the default rate table, not the one
 			 * where 1 = 2 Mbps */
-			output_byte(FD_DRIVESPEC);
+			output_byte(current_fdc, FD_DRIVESPEC);
 			if (need_more_output() == MORE_OUTPUT) {
-				output_byte(UNIT(current_drive));
-				output_byte(0xc0);
+				output_byte(current_fdc, UNIT(current_drive));
+				output_byte(current_fdc, 0xc0);
 			}
 		}
 		break;
@@ -1349,9 +1349,9 @@ static void fdc_specify(void)
 	if (fdc_state[current_fdc].spec1 != spec1 ||
 	    fdc_state[current_fdc].spec2 != spec2) {
 		/* Go ahead and set spec1 and spec2 */
-		output_byte(FD_SPECIFY);
-		output_byte(fdc_state[current_fdc].spec1 = spec1);
-		output_byte(fdc_state[current_fdc].spec2 = spec2);
+		output_byte(current_fdc, FD_SPECIFY);
+		output_byte(current_fdc, fdc_state[current_fdc].spec1 = spec1);
+		output_byte(current_fdc, fdc_state[current_fdc].spec2 = spec2);
 	}
 }				/* fdc_specify */
 
@@ -1513,7 +1513,7 @@ static void setup_rw_floppy(void)
 
 	r = 0;
 	for (i = 0; i < raw_cmd->cmd_count; i++)
-		r |= output_byte(raw_cmd->cmd[i]);
+		r |= output_byte(current_fdc, raw_cmd->cmd[i]);
 
 	debugt(__func__, "rw_command");
 
@@ -1566,8 +1566,8 @@ static void check_wp(void)
 {
 	if (test_bit(FD_VERIFY_BIT, &drive_state[current_drive].flags)) {
 					/* check write protection */
-		output_byte(FD_GETSTATUS);
-		output_byte(UNIT(current_drive));
+		output_byte(current_fdc, FD_GETSTATUS);
+		output_byte(current_fdc, UNIT(current_drive));
 		if (result() != 1) {
 			fdc_state[current_fdc].reset = 1;
 			return;
@@ -1639,9 +1639,9 @@ static void seek_floppy(void)
 	}
 
 	do_floppy = seek_interrupt;
-	output_byte(FD_SEEK);
-	output_byte(UNIT(current_drive));
-	if (output_byte(track) < 0) {
+	output_byte(current_fdc, FD_SEEK);
+	output_byte(current_fdc, UNIT(current_drive));
+	if (output_byte(current_fdc, track) < 0) {
 		reset_fdc();
 		return;
 	}
@@ -1748,7 +1748,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 	if (inr == 0) {
 		int max_sensei = 4;
 		do {
-			output_byte(FD_SENSEI);
+			output_byte(current_fdc, FD_SENSEI);
 			inr = result();
 			if (do_print)
 				print_result("sensei", inr);
@@ -1771,8 +1771,8 @@ static void recalibrate_floppy(void)
 {
 	debugt(__func__, "");
 	do_floppy = recal_interrupt;
-	output_byte(FD_RECALIBRATE);
-	if (output_byte(UNIT(current_drive)) < 0)
+	output_byte(current_fdc, FD_RECALIBRATE);
+	if (output_byte(current_fdc, UNIT(current_drive)) < 0)
 		reset_fdc();
 }
 
@@ -4302,7 +4302,7 @@ static char __init get_fdc_version(void)
 {
 	int r;
 
-	output_byte(FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
+	output_byte(current_fdc, FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
 	if (fdc_state[current_fdc].reset)
 		return FDC_NONE;
 	r = result();
@@ -4323,15 +4323,15 @@ static char __init get_fdc_version(void)
 		return FDC_82072;	/* 82072 doesn't know CONFIGURE */
 	}
 
-	output_byte(FD_PERPENDICULAR);
+	output_byte(current_fdc, FD_PERPENDICULAR);
 	if (need_more_output() == MORE_OUTPUT) {
-		output_byte(0);
+		output_byte(current_fdc, 0);
 	} else {
 		pr_info("FDC %d is an 82072A\n", current_fdc);
 		return FDC_82072A;	/* 82072A as found on Sparcs. */
 	}
 
-	output_byte(FD_UNLOCK);
+	output_byte(current_fdc, FD_UNLOCK);
 	r = result();
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
 		pr_info("FDC %d is a pre-1991 82077\n", current_fdc);
@@ -4343,7 +4343,7 @@ static char __init get_fdc_version(void)
 			current_fdc, r);
 		return FDC_UNKNOWN;
 	}
-	output_byte(FD_PARTID);
+	output_byte(current_fdc, FD_PARTID);
 	r = result();
 	if (r != 1) {
 		pr_info("FDC %d init: PARTID: unexpected return of %d bytes.\n",
-- 
2.20.1

