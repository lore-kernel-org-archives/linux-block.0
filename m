Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B030C3F2D1
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337AA246C2
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 19:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCAT5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:57:09 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32077 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCAT5A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 14:57:00 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021Ju4XY011201;
        Sun, 1 Mar 2020 20:56:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Ian Molton <spyro@f2s.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 1/6] floppy: remove dead code for drives scanning on ARM
Date:   Sun,  1 Mar 2020 20:55:50 +0100
Message-Id: <20200301195555.11154-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On ARM, function fd_scandrives pre-dates Git era, is #ifed 0 out, not
used, and cannot even compile since it references an fdc variable that's
not declared anywhere (supposed to be the global one that we're turning
to current_fdc apparently).

There was also an ifdefde out include of mach/floppy.h that does not
exist anymore either. Let's get rid of them since they complicate the
fixing of the driver.

Cc: Ian Molton <spyro@f2s.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/include/asm/floppy.h | 51 -------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index f4fe4d0..4655652 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -8,9 +8,6 @@
  */
 #ifndef __ASM_ARM_FLOPPY_H
 #define __ASM_ARM_FLOPPY_H
-#if 0
-#include <mach/floppy.h>
-#endif
 
 #define fd_outb(val,port)			\
 	do {					\
@@ -69,54 +66,6 @@ do {										\
 	outb(new_dor, FD_DOR);							\
 } while (0)
 
-/*
- * Someday, we'll automatically detect which drives are present...
- */
-static inline void fd_scandrives (void)
-{
-#if 0
-	int floppy, drive_count;
-
-	fd_disable_irq();
-	raw_cmd = &default_raw_cmd;
-	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_SEEK;
-	raw_cmd->track = 0;
-	raw_cmd->rate = ?;
-	drive_count = 0;
-	for (floppy = 0; floppy < 4; floppy ++) {
-		current_drive = drive_count;
-		/*
-		 * Turn on floppy motor
-		 */
-		if (start_motor(redo_fd_request))
-			continue;
-		/*
-		 * Set up FDC
-		 */
-		fdc_specify();
-		/*
-		 * Tell FDC to recalibrate
-		 */
-		output_byte(FD_RECALIBRATE);
-		LAST_OUT(UNIT(floppy));
-		/* wait for command to complete */
-		if (!successful) {
-			int i;
-			for (i = drive_count; i < 3; i--)
-				floppy_selects[fdc][i] = floppy_selects[fdc][i + 1];
-			floppy_selects[fdc][3] = 0;
-			floppy -= 1;
-		} else
-			drive_count++;
-	}
-#else
-	floppy_selects[0][0] = 0x10;
-	floppy_selects[0][1] = 0x21;
-	floppy_selects[0][2] = 0x23;
-	floppy_selects[0][3] = 0x33;
-#endif
-}
-
 #define FDC1 (0x3f0)
 
 #define FLOPPY0_TYPE 4
-- 
2.9.0

