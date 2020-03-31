Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1297C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE8921473
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgCaJlv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34104 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbgCaJlv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f6h4024521;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 14/23] floppy: cleanup: make result() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:45 +0200
Message-Id: <20200331094054.24441-15-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the fdc is passed in argument so that the function does not
use current_fdc anymore.

It's worth noting that there's still a single reply_buffer[] which
will store the result for the current fdc. It may or may not make
sense to implement one buffer per fdc in the future.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 81fd06eaea7d..4aaf84217b53 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1153,13 +1153,13 @@ static int output_byte(int fdc, char byte)
 }
 
 /* gets the response from the fdc */
-static int result(void)
+static int result(int fdc)
 {
 	int i;
 	int status = 0;
 
 	for (i = 0; i < MAX_REPLIES; i++) {
-		status = wait_til_ready(current_fdc);
+		status = wait_til_ready(fdc);
 		if (status < 0)
 			break;
 		status &= STATUS_DIR | STATUS_READY | STATUS_BUSY | STATUS_DMA;
@@ -1169,16 +1169,16 @@ static int result(void)
 			return i;
 		}
 		if (status == (STATUS_DIR | STATUS_READY | STATUS_BUSY))
-			reply_buffer[i] = fdc_inb(current_fdc, FD_DATA);
+			reply_buffer[i] = fdc_inb(fdc, FD_DATA);
 		else
 			break;
 	}
 	if (initialized) {
 		DPRINT("get result error. Fdc=%d Last status=%x Read bytes=%d\n",
-		       current_fdc, status, i);
-		show_floppy(current_fdc);
+		       fdc, status, i);
+		show_floppy(fdc);
 	}
-	fdc_state[current_fdc].reset = 1;
+	fdc_state[fdc].reset = 1;
 	return -1;
 }
 
@@ -1194,7 +1194,7 @@ static int need_more_output(void)
 	if (is_ready_state(status))
 		return MORE_OUTPUT;
 
-	return result();
+	return result(current_fdc);
 }
 
 /* Set perpendicular mode as required, based on data rate, if supported.
@@ -1524,7 +1524,7 @@ static void setup_rw_floppy(void)
 	}
 
 	if (!(flags & FD_RAW_INTR)) {
-		inr = result();
+		inr = result(current_fdc);
 		cont->interrupt();
 	} else if (flags & FD_RAW_NEED_DISK)
 		fd_watchdog();
@@ -1568,7 +1568,7 @@ static void check_wp(void)
 					/* check write protection */
 		output_byte(current_fdc, FD_GETSTATUS);
 		output_byte(current_fdc, UNIT(current_drive));
-		if (result() != 1) {
+		if (result(current_fdc) != 1) {
 			fdc_state[current_fdc].reset = 1;
 			return;
 		}
@@ -1742,14 +1742,14 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 
 	do_print = !handler && print_unex && initialized;
 
-	inr = result();
+	inr = result(current_fdc);
 	if (do_print)
 		print_result("unexpected interrupt", inr);
 	if (inr == 0) {
 		int max_sensei = 4;
 		do {
 			output_byte(current_fdc, FD_SENSEI);
-			inr = result();
+			inr = result(current_fdc);
 			if (do_print)
 				print_result("sensei", inr);
 			max_sensei--;
@@ -1782,7 +1782,7 @@ static void recalibrate_floppy(void)
 static void reset_interrupt(void)
 {
 	debugt(__func__, "");
-	result();		/* get the status ready for set_fdc */
+	result(current_fdc);		/* get the status ready for set_fdc */
 	if (fdc_state[current_fdc].reset) {
 		pr_info("reset set in interrupt, calling %ps\n", cont->error);
 		cont->error();	/* a reset just after a reset. BAD! */
@@ -4305,7 +4305,7 @@ static char __init get_fdc_version(void)
 	output_byte(current_fdc, FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
 	if (fdc_state[current_fdc].reset)
 		return FDC_NONE;
-	r = result();
+	r = result(current_fdc);
 	if (r <= 0x00)
 		return FDC_NONE;	/* No FDC present ??? */
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
@@ -4332,7 +4332,7 @@ static char __init get_fdc_version(void)
 	}
 
 	output_byte(current_fdc, FD_UNLOCK);
-	r = result();
+	r = result(current_fdc);
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
 		pr_info("FDC %d is a pre-1991 82077\n", current_fdc);
 		return FDC_82077_ORIG;	/* Pre-1991 82077, doesn't know
@@ -4344,7 +4344,7 @@ static char __init get_fdc_version(void)
 		return FDC_UNKNOWN;
 	}
 	output_byte(current_fdc, FD_PARTID);
-	r = result();
+	r = result(current_fdc);
 	if (r != 1) {
 		pr_info("FDC %d init: PARTID: unexpected return of %d bytes.\n",
 			current_fdc, r);
-- 
2.20.1

