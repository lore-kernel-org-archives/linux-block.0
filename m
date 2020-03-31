Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2205AC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0113321556
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCaJmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:13 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34142 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbgCaJmK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:10 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f68k024525;
        Tue, 31 Mar 2020 11:41:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 18/23] floppy: cleanup: make fdc_specify() not rely on current_{fdc,drive} anymore
Date:   Tue, 31 Mar 2020 11:40:49 +0200
Message-Id: <20200331094054.24441-19-w@1wt.eu>
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
 drivers/block/floppy.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c1338c4bb941..b929b60afe9b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1273,7 +1273,7 @@ static int fdc_configure(int fdc)
  *
  * These values are rounded up to the next highest available delay time.
  */
-static void fdc_specify(void)
+static void fdc_specify(int fdc, int drive)
 {
 	unsigned char spec1;
 	unsigned char spec2;
@@ -1285,10 +1285,10 @@ static void fdc_specify(void)
 	int hlt_max_code = 0x7f;
 	int hut_max_code = 0xf;
 
-	if (fdc_state[current_fdc].need_configure &&
-	    fdc_state[current_fdc].version >= FDC_82072A) {
-		fdc_configure(current_fdc);
-		fdc_state[current_fdc].need_configure = 0;
+	if (fdc_state[fdc].need_configure &&
+	    fdc_state[fdc].version >= FDC_82072A) {
+		fdc_configure(fdc);
+		fdc_state[fdc].need_configure = 0;
 	}
 
 	switch (raw_cmd->rate & 0x03) {
@@ -1297,13 +1297,13 @@ static void fdc_specify(void)
 		break;
 	case 1:
 		dtr = 300;
-		if (fdc_state[current_fdc].version >= FDC_82078) {
+		if (fdc_state[fdc].version >= FDC_82078) {
 			/* chose the default rate table, not the one
 			 * where 1 = 2 Mbps */
-			output_byte(current_fdc, FD_DRIVESPEC);
-			if (need_more_output(current_fdc) == MORE_OUTPUT) {
-				output_byte(current_fdc, UNIT(current_drive));
-				output_byte(current_fdc, 0xc0);
+			output_byte(fdc, FD_DRIVESPEC);
+			if (need_more_output(fdc) == MORE_OUTPUT) {
+				output_byte(fdc, UNIT(drive));
+				output_byte(fdc, 0xc0);
 			}
 		}
 		break;
@@ -1312,14 +1312,14 @@ static void fdc_specify(void)
 		break;
 	}
 
-	if (fdc_state[current_fdc].version >= FDC_82072) {
+	if (fdc_state[fdc].version >= FDC_82072) {
 		scale_dtr = dtr;
 		hlt_max_code = 0x00;	/* 0==256msec*dtr0/dtr (not linear!) */
 		hut_max_code = 0x0;	/* 0==256msec*dtr0/dtr (not linear!) */
 	}
 
 	/* Convert step rate from microseconds to milliseconds and 4 bits */
-	srt = 16 - DIV_ROUND_UP(drive_params[current_drive].srt * scale_dtr / 1000,
+	srt = 16 - DIV_ROUND_UP(drive_params[drive].srt * scale_dtr / 1000,
 				NOMINAL_DTR);
 	if (slow_floppy)
 		srt = srt / 4;
@@ -1327,14 +1327,14 @@ static void fdc_specify(void)
 	SUPBOUND(srt, 0xf);
 	INFBOUND(srt, 0);
 
-	hlt = DIV_ROUND_UP(drive_params[current_drive].hlt * scale_dtr / 2,
+	hlt = DIV_ROUND_UP(drive_params[drive].hlt * scale_dtr / 2,
 			   NOMINAL_DTR);
 	if (hlt < 0x01)
 		hlt = 0x01;
 	else if (hlt > 0x7f)
 		hlt = hlt_max_code;
 
-	hut = DIV_ROUND_UP(drive_params[current_drive].hut * scale_dtr / 16,
+	hut = DIV_ROUND_UP(drive_params[drive].hut * scale_dtr / 16,
 			   NOMINAL_DTR);
 	if (hut < 0x1)
 		hut = 0x1;
@@ -1345,12 +1345,12 @@ static void fdc_specify(void)
 	spec2 = (hlt << 1) | (use_virtual_dma & 1);
 
 	/* If these parameters did not change, just return with success */
-	if (fdc_state[current_fdc].spec1 != spec1 ||
-	    fdc_state[current_fdc].spec2 != spec2) {
+	if (fdc_state[fdc].spec1 != spec1 ||
+	    fdc_state[fdc].spec2 != spec2) {
 		/* Go ahead and set spec1 and spec2 */
-		output_byte(current_fdc, FD_SPECIFY);
-		output_byte(current_fdc, fdc_state[current_fdc].spec1 = spec1);
-		output_byte(current_fdc, fdc_state[current_fdc].spec2 = spec2);
+		output_byte(fdc, FD_SPECIFY);
+		output_byte(fdc, fdc_state[fdc].spec1 = spec1);
+		output_byte(fdc, fdc_state[fdc].spec2 = spec2);
 	}
 }				/* fdc_specify */
 
@@ -1946,12 +1946,12 @@ static void floppy_ready(void)
 
 	if (raw_cmd->flags & (FD_RAW_NEED_SEEK | FD_RAW_NEED_DISK)) {
 		perpendicular_mode(current_fdc);
-		fdc_specify();	/* must be done here because of hut, hlt ... */
+		fdc_specify(current_fdc, current_drive); /* must be done here because of hut, hlt ... */
 		seek_floppy();
 	} else {
 		if ((raw_cmd->flags & FD_RAW_READ) ||
 		    (raw_cmd->flags & FD_RAW_WRITE))
-			fdc_specify();
+			fdc_specify(current_fdc, current_drive);
 		setup_rw_floppy();
 	}
 }
-- 
2.20.1

