Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2346DC2D0EE
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E2F2073B
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgCaJmv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34170 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgCaJmv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f7BG024529;
        Tue, 31 Mar 2020 11:41:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 21/23] floppy: cleanup: make get_fdc_version() not rely on current_fdc anymore
Date:   Tue, 31 Mar 2020 11:40:52 +0200
Message-Id: <20200331094054.24441-22-w@1wt.eu>
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
 drivers/block/floppy.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f53810ba486d..8850baa3372a 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4297,79 +4297,79 @@ static const struct block_device_operations floppy_fops = {
 
 /* Determine the floppy disk controller type */
 /* This routine was written by David C. Niemi */
-static char __init get_fdc_version(void)
+static char __init get_fdc_version(int fdc)
 {
 	int r;
 
-	output_byte(current_fdc, FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
-	if (fdc_state[current_fdc].reset)
+	output_byte(fdc, FD_DUMPREGS);	/* 82072 and better know DUMPREGS */
+	if (fdc_state[fdc].reset)
 		return FDC_NONE;
-	r = result(current_fdc);
+	r = result(fdc);
 	if (r <= 0x00)
 		return FDC_NONE;	/* No FDC present ??? */
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
-		pr_info("FDC %d is an 8272A\n", current_fdc);
+		pr_info("FDC %d is an 8272A\n", fdc);
 		return FDC_8272A;	/* 8272a/765 don't know DUMPREGS */
 	}
 	if (r != 10) {
 		pr_info("FDC %d init: DUMPREGS: unexpected return of %d bytes.\n",
-			current_fdc, r);
+			fdc, r);
 		return FDC_UNKNOWN;
 	}
 
-	if (!fdc_configure(current_fdc)) {
-		pr_info("FDC %d is an 82072\n", current_fdc);
+	if (!fdc_configure(fdc)) {
+		pr_info("FDC %d is an 82072\n", fdc);
 		return FDC_82072;	/* 82072 doesn't know CONFIGURE */
 	}
 
-	output_byte(current_fdc, FD_PERPENDICULAR);
-	if (need_more_output(current_fdc) == MORE_OUTPUT) {
-		output_byte(current_fdc, 0);
+	output_byte(fdc, FD_PERPENDICULAR);
+	if (need_more_output(fdc) == MORE_OUTPUT) {
+		output_byte(fdc, 0);
 	} else {
-		pr_info("FDC %d is an 82072A\n", current_fdc);
+		pr_info("FDC %d is an 82072A\n", fdc);
 		return FDC_82072A;	/* 82072A as found on Sparcs. */
 	}
 
-	output_byte(current_fdc, FD_UNLOCK);
-	r = result(current_fdc);
+	output_byte(fdc, FD_UNLOCK);
+	r = result(fdc);
 	if ((r == 1) && (reply_buffer[0] == 0x80)) {
-		pr_info("FDC %d is a pre-1991 82077\n", current_fdc);
+		pr_info("FDC %d is a pre-1991 82077\n", fdc);
 		return FDC_82077_ORIG;	/* Pre-1991 82077, doesn't know
 					 * LOCK/UNLOCK */
 	}
 	if ((r != 1) || (reply_buffer[0] != 0x00)) {
 		pr_info("FDC %d init: UNLOCK: unexpected return of %d bytes.\n",
-			current_fdc, r);
+			fdc, r);
 		return FDC_UNKNOWN;
 	}
-	output_byte(current_fdc, FD_PARTID);
-	r = result(current_fdc);
+	output_byte(fdc, FD_PARTID);
+	r = result(fdc);
 	if (r != 1) {
 		pr_info("FDC %d init: PARTID: unexpected return of %d bytes.\n",
-			current_fdc, r);
+			fdc, r);
 		return FDC_UNKNOWN;
 	}
 	if (reply_buffer[0] == 0x80) {
-		pr_info("FDC %d is a post-1991 82077\n", current_fdc);
+		pr_info("FDC %d is a post-1991 82077\n", fdc);
 		return FDC_82077;	/* Revised 82077AA passes all the tests */
 	}
 	switch (reply_buffer[0] >> 5) {
 	case 0x0:
 		/* Either a 82078-1 or a 82078SL running at 5Volt */
-		pr_info("FDC %d is an 82078.\n", current_fdc);
+		pr_info("FDC %d is an 82078.\n", fdc);
 		return FDC_82078;
 	case 0x1:
-		pr_info("FDC %d is a 44pin 82078\n", current_fdc);
+		pr_info("FDC %d is a 44pin 82078\n", fdc);
 		return FDC_82078;
 	case 0x2:
-		pr_info("FDC %d is a S82078B\n", current_fdc);
+		pr_info("FDC %d is a S82078B\n", fdc);
 		return FDC_S82078B;
 	case 0x3:
-		pr_info("FDC %d is a National Semiconductor PC87306\n", current_fdc);
+		pr_info("FDC %d is a National Semiconductor PC87306\n", fdc);
 		return FDC_87306;
 	default:
 		pr_info("FDC %d init: 82078 variant with unknown PARTID=%d.\n",
-			current_fdc, reply_buffer[0] >> 5);
+			fdc, reply_buffer[0] >> 5);
 		return FDC_82078_UNKN;
 	}
 }				/* get_fdc_version */
@@ -4711,7 +4711,7 @@ static int __init do_floppy_init(void)
 			continue;
 		}
 		/* Try to determine the floppy controller type */
-		fdc_state[current_fdc].version = get_fdc_version();
+		fdc_state[current_fdc].version = get_fdc_version(current_fdc);
 		if (fdc_state[current_fdc].version == FDC_NONE) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
 			floppy_release_regions(current_fdc);
-- 
2.20.1

