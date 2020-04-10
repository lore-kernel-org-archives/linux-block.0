Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A55CC2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274120787
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 09:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJJac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:30:32 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34473 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgDJJac (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 05:30:32 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03A9UQ35014539;
        Fri, 10 Apr 2020 11:30:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 24/23] floppy: cleanup: do not iterate on current_fdc in do_floppy_init()
Date:   Fri, 10 Apr 2020 11:30:23 +0200
Message-Id: <20200410093023.14499-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-23-w@1wt.eu>
References: <20200331094054.24441-23-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's no need to iterate on current_fdc in do_floppy_init() anymore,
in the first case it's only used as an array index to access fdc_state[],
so let's get rid of this confusing assignment. The second case is a bit
trickier because user_reset_fdc() needs to already know current_fdc when
called with drive==-1 due to this call chain:

    user_reset_fdc()
      lock_fdc()
        set_fdc()
           drive<0 ==> new_fdc = current_fdc

Note that current_drive is not used in this code part and may even not
match a unit belonging to current_fdc. Instead of passing -1 we can
simply pass the first drive of the FDC being initialized, which is even
cleaner as it will allow the function chain above to consistently assign
both variables.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 07218f8b17f9..8da7921659f1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4657,16 +4657,15 @@ static int __init do_floppy_init(void)
 	config_types();
 
 	for (i = 0; i < N_FDC; i++) {
-		current_fdc = i;
-		memset(&fdc_state[current_fdc], 0, sizeof(*fdc_state));
-		fdc_state[current_fdc].dtr = -1;
-		fdc_state[current_fdc].dor = 0x4;
+		memset(&fdc_state[i], 0, sizeof(*fdc_state));
+		fdc_state[i].dtr = -1;
+		fdc_state[i].dor = 0x4;
 #if defined(__sparc__) || defined(__mc68000__)
 	/*sparcs/sun3x don't have a DOR reset which we can fall back on to */
 #ifdef __mc68000__
 		if (MACH_IS_SUN3X)
 #endif
-			fdc_state[current_fdc].version = FDC_82072A;
+			fdc_state[i].version = FDC_82072A;
 #endif
 	}
 
@@ -4708,30 +4707,29 @@ static int __init do_floppy_init(void)
 	msleep(10);
 
 	for (i = 0; i < N_FDC; i++) {
-		current_fdc = i;
-		fdc_state[current_fdc].driver_version = FD_DRIVER_VERSION;
+		fdc_state[i].driver_version = FD_DRIVER_VERSION;
 		for (unit = 0; unit < 4; unit++)
-			fdc_state[current_fdc].track[unit] = 0;
-		if (fdc_state[current_fdc].address == -1)
+			fdc_state[i].track[unit] = 0;
+		if (fdc_state[i].address == -1)
 			continue;
-		fdc_state[current_fdc].rawcmd = 2;
-		if (user_reset_fdc(-1, FD_RESET_ALWAYS, false)) {
+		fdc_state[i].rawcmd = 2;
+		if (user_reset_fdc(REVDRIVE(i, 0), FD_RESET_ALWAYS, false)) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
-			floppy_release_regions(current_fdc);
-			fdc_state[current_fdc].address = -1;
-			fdc_state[current_fdc].version = FDC_NONE;
+			floppy_release_regions(i);
+			fdc_state[i].address = -1;
+			fdc_state[i].version = FDC_NONE;
 			continue;
 		}
 		/* Try to determine the floppy controller type */
-		fdc_state[current_fdc].version = get_fdc_version(current_fdc);
-		if (fdc_state[current_fdc].version == FDC_NONE) {
+		fdc_state[i].version = get_fdc_version(i);
+		if (fdc_state[i].version == FDC_NONE) {
 			/* free ioports reserved by floppy_grab_irq_and_dma() */
-			floppy_release_regions(current_fdc);
-			fdc_state[current_fdc].address = -1;
+			floppy_release_regions(i);
+			fdc_state[i].address = -1;
 			continue;
 		}
 		if (can_use_virtual_dma == 2 &&
-		    fdc_state[current_fdc].version < FDC_82072A)
+		    fdc_state[i].version < FDC_82072A)
 			can_use_virtual_dma = 0;
 
 		have_no_fdc = 0;
@@ -4739,7 +4737,7 @@ static int __init do_floppy_init(void)
 		 * properly, so force a reset for the standard FDC clones,
 		 * to avoid interrupt garbage.
 		 */
-		user_reset_fdc(-1, FD_RESET_ALWAYS, false);
+		user_reset_fdc(REVDRIVE(i, 0), FD_RESET_ALWAYS, false);
 	}
 	current_fdc = 0;
 	cancel_delayed_work(&fd_timeout);
-- 
2.20.1

