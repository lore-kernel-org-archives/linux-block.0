Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B03C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC311208E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgCaJmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:42:18 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34150 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgCaJmR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:42:17 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 02V9f4lt024513;
        Tue, 31 Mar 2020 11:41:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 06/23] floppy: use symbolic register names in the sparc32 port
Date:   Tue, 31 Mar 2020 11:40:37 +0200
Message-Id: <20200331094054.24441-7-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sparc port used to be forced to rely on numeric register indexes
with their equivalent in comments. Now that they don't depend on the
IO port we can use their symbolic names.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/sparc/include/asm/floppy_32.h | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 4d08df4f4deb..946dbcbf3a83 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -114,15 +114,15 @@ static unsigned char sun_read_dir(void)
 static unsigned char sun_82072_fd_inb(int port)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (port) {
 	default:
 		printk("floppy: Asked to read unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
-	case 4: /* FD_STATUS */
+	case FD_STATUS:
 		return sun_fdc->status_82072 & ~STATUS_DMA;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		return sun_fdc->data_82072;
-	case 7: /* FD_DIR */
+	case FD_DIR:
 		return sun_read_dir();
 	}
 	panic("sun_82072_fd_inb: How did I get here?");
@@ -131,20 +131,20 @@ static unsigned char sun_82072_fd_inb(int port)
 static void sun_82072_fd_outb(unsigned char value, int port)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (port) {
 	default:
 		printk("floppy: Asked to write to unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
-	case 2: /* FD_DOR */
+	case FD_DOR:
 		sun_set_dor(value, 0);
 		break;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		sun_fdc->data_82072 = value;
 		break;
-	case 7: /* FD_DCR */
+	case FD_DCR:
 		sun_fdc->dcr_82072 = value;
 		break;
-	case 4: /* FD_STATUS */
+	case FD_DSR:
 		sun_fdc->status_82072 = value;
 		break;
 	}
@@ -154,23 +154,23 @@ static void sun_82072_fd_outb(unsigned char value, int port)
 static unsigned char sun_82077_fd_inb(int port)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (port) {
 	default:
 		printk("floppy: Asked to read unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
-	case 0: /* FD_STATUS_0 */
+	case FD_SRA:
 		return sun_fdc->status1_82077;
-	case 1: /* FD_STATUS_1 */
+	case FD_SRB:
 		return sun_fdc->status2_82077;
-	case 2: /* FD_DOR */
+	case FD_DOR:
 		return sun_fdc->dor_82077;
-	case 3: /* FD_TDR */
+	case FD_TDR:
 		return sun_fdc->tapectl_82077;
-	case 4: /* FD_STATUS */
+	case FD_STATUS:
 		return sun_fdc->status_82077 & ~STATUS_DMA;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		return sun_fdc->data_82077;
-	case 7: /* FD_DIR */
+	case FD_DIR:
 		return sun_read_dir();
 	}
 	panic("sun_82077_fd_inb: How did I get here?");
@@ -179,23 +179,23 @@ static unsigned char sun_82077_fd_inb(int port)
 static void sun_82077_fd_outb(unsigned char value, int port)
 {
 	udelay(5);
-	switch(port & 7) {
+	switch (port) {
 	default:
 		printk("floppy: Asked to write to unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
-	case 2: /* FD_DOR */
+	case FD_DOR:
 		sun_set_dor(value, 1);
 		break;
-	case 5: /* FD_DATA */
+	case FD_DATA:
 		sun_fdc->data_82077 = value;
 		break;
-	case 7: /* FD_DCR */
+	case FD_DCR:
 		sun_fdc->dcr_82077 = value;
 		break;
-	case 4: /* FD_STATUS */
+	case FD_DSR:
 		sun_fdc->status_82077 = value;
 		break;
-	case 3: /* FD_TDR */
+	case FD_TDR:
 		sun_fdc->tapectl_82077 = value;
 		break;
 	}
-- 
2.20.1

