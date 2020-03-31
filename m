Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A3EC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D3207FF
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgCaJli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:41:38 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34093 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgCaJlh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:41:37 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f7c6024531;
        Tue, 31 Mar 2020 11:41:07 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 22/23] floppy: cleanup: do not iterate on current_fdc in DMA grab/release functions
Date:   Tue, 31 Mar 2020 11:40:53 +0200
Message-Id: <20200331094054.24441-23-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both floppy_grab_irq_and_dma() and floppy_release_irq_and_dma() used to
iterate on the global variable while setting up or freeing resources.
Now that they exclusively rely on functions which take the fdc as an
argument, so let's not touch the global one anymore.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8850baa3372a..77bb9a5fcd33 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4854,6 +4854,8 @@ static void floppy_release_regions(int fdc)
 
 static int floppy_grab_irq_and_dma(void)
 {
+	int fdc;
+
 	if (atomic_inc_return(&usage_count) > 1)
 		return 0;
 
@@ -4881,24 +4883,24 @@ static int floppy_grab_irq_and_dma(void)
 		}
 	}
 
-	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
-		if (fdc_state[current_fdc].address != -1) {
-			if (floppy_request_regions(current_fdc))
+	for (fdc = 0; fdc < N_FDC; fdc++) {
+		if (fdc_state[fdc].address != -1) {
+			if (floppy_request_regions(fdc))
 				goto cleanup;
 		}
 	}
-	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++) {
-		if (fdc_state[current_fdc].address != -1) {
-			reset_fdc_info(current_fdc, 1);
-			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
+	for (fdc = 0; fdc < N_FDC; fdc++) {
+		if (fdc_state[fdc].address != -1) {
+			reset_fdc_info(fdc, 1);
+			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 		}
 	}
-	current_fdc = 0;
+
 	set_dor(0, ~0, 8);	/* avoid immediate interrupt */
 
-	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
-		if (fdc_state[current_fdc].address != -1)
-			fdc_outb(fdc_state[current_fdc].dor, current_fdc, FD_DOR);
+	for (fdc = 0; fdc < N_FDC; fdc++)
+		if (fdc_state[fdc].address != -1)
+			fdc_outb(fdc_state[fdc].dor, fdc, FD_DOR);
 	/*
 	 * The driver will try and free resources and relies on us
 	 * to know if they were allocated or not.
@@ -4909,15 +4911,16 @@ static int floppy_grab_irq_and_dma(void)
 cleanup:
 	fd_free_irq();
 	fd_free_dma();
-	while (--current_fdc >= 0)
-		floppy_release_regions(current_fdc);
+	while (--fdc >= 0)
+		floppy_release_regions(fdc);
+	current_fdc = 0;
 	atomic_dec(&usage_count);
 	return -1;
 }
 
 static void floppy_release_irq_and_dma(void)
 {
-	int old_fdc;
+	int fdc;
 #ifndef __sparc__
 	int drive;
 #endif
@@ -4958,11 +4961,9 @@ static void floppy_release_irq_and_dma(void)
 		pr_info("auxiliary floppy timer still active\n");
 	if (work_pending(&floppy_work))
 		pr_info("work still pending\n");
-	old_fdc = current_fdc;
-	for (current_fdc = 0; current_fdc < N_FDC; current_fdc++)
-		if (fdc_state[current_fdc].address != -1)
-			floppy_release_regions(current_fdc);
-	current_fdc = old_fdc;
+	for (fdc = 0; fdc < N_FDC; fdc++)
+		if (fdc_state[fdc].address != -1)
+			floppy_release_regions(fdc);
 }
 
 #ifdef MODULE
-- 
2.20.1

